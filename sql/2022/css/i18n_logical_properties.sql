#standardSQL
CREATE TEMPORARY FUNCTION getLogicalProperties(css STRING)
RETURNS ARRAY<STRUCT<property STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      logical: {},
      physical: {}
    };


    walkDeclarations(ast, ({property, value}) => {
      let isLogical = property.match(/\\b(block|inline|start|end)\\b/);
      let obj = ret[isLogical? "logical" : "physical"];

      let size = property.match(/^(min-|max-)?((block|inline)-size|width|height)$/);

      if (size) {
        incrementByKey(obj, (size[1] || "") + "size");
        return;
      }

      let borderRadius = property.match(/^border-([a-z]-)?radius$/);

      if (borderRadius) {
        incrementByKey(obj, "border-radius");
      }

      let boxModel = property.match(/^(border|margin|padding)(?!-width|-style|-color|$)\\b/);

      if (boxModel) {
        incrementByKey(obj, boxModel[1]);
      }

      if (/^overflow-/.test(property)) {
        incrementByKey(obj, "overflow");
      }

      if (matches(property, [/^inset\\b/, "top", "right", "bottom", "left"])) {
        incrementByKey(ret[property.startsWith("inset")? "logical" : "physical"], "inset");
      }

      if (matches(property, ["clear", "float", "caption-side", "resize", "text-align"])) {
        isLogical = value.match(/\\b(block|inline|start|end)\\b/);
        let obj = ret[isLogical? "logical" : "physical"];
        incrementByKey(obj, property);
      }


    }, {
      properties: [
        "clear", "float", "caption-side", "resize", "text-align",
        /^overflow-/,
        "inset",
        /\\b(block|inline|start|end|top|right|bottom|left|width|height)\\b/,
      ]
    });

    ret.logical.total = sumObject(ret.logical);
    ret.physical.total = sumObject(ret.physical);

    ret.logical = sortObject(ret.logical);
    ret.physical = sortObject(ret.physical);


    return ret;
  }
  var ast = JSON.parse(css);
  var i18n = compute(ast);
  return Object.entries(i18n.logical).filter(([property]) => {
    return property != 'total';
  }).map(([property, freq]) => {
    return {property, freq};
  });
} catch (e) {
  return [];
}
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)

SELECT
  *
FROM (
  SELECT
    client,
    property,
    COUNT(DISTINCT page) AS pages,
    ANY_VALUE(total_pages) AS total_pages,
    COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
    SUM(freq) AS freq,
    SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
    SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
  FROM (
    SELECT
      client,
      page,
      prop.property,
      prop.freq
    FROM
      `httparchive.almanac.parsed_css`,
      UNNEST(getLogicalProperties(css)) AS prop
    WHERE
      date = '2022-07-01' AND -- noqa: CV09
      # Limit the size of the CSS to avoid OOM crashes.
      LENGTH(css) < 0.1 * 1024 * 1024
  )
  JOIN
    totals
  USING (client)
  GROUP BY
    client,
    property
)
WHERE
  pct >= 0.01
ORDER BY
  pct DESC
