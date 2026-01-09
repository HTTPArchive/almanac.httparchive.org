#standardSQL
CREATE TEMPORARY FUNCTION getDirValues(css STRING)
RETURNS ARRAY<STRUCT<element STRING, value STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      html: {},
      body: {},
      other: {}
    };

    walkDeclarations(ast, ({value}, rule) => {
      if (rule.selectors) {
        for (let selector of rule.selectors) {
          let sast = parsel.parse(selector, {list: false});

          let node = sast.type === "complex"? sast.right : sast;
          let list = node.type === "compound"? node.list : [node];
          if (list.find(n => n.content === "html" || n.content === ":root")) {
            incrementByKey(ret.html, value);
          }
          else if (list.find(n => n.content === "body")) {
            incrementByKey(ret.body, value);
          }
          else {
            incrementByKey(ret.other, value);
          }
        }
      }
    }, {properties: "direction"});

    for (let type in ret) {
      ret[type].total = sumObject(ret[type]);
    }

    return ret;
  }
  var ast = JSON.parse(css);
  var dirs = compute(ast);
  return Object.entries(dirs).flatMap(([element, values]) => {
    return Object.entries(values).filter(([value]) => {
      return value != 'total';
    }).map(([value, freq]) => {
      return {element, value, freq};
    });
  });
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    client,
    element,
    value,
    SUM(freq) AS freq,
    SUM(SUM(freq)) OVER (PARTITION BY client, element) AS total,
    SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client, element) AS pct
  FROM (
    SELECT
      client,
      dir.element,
      dir.value,
      dir.freq
    FROM
      `httparchive.almanac.parsed_css`,
      UNNEST(getDirValues(css)) AS dir
    WHERE
      date = '2022-07-01' AND -- noqa: CV09
      # Limit the size of the CSS to avoid OOM crashes.
      LENGTH(css) < 0.1 * 1024 * 1024
  )
  GROUP BY
    client,
    element,
    value
)
WHERE
  pct >= 0.01
ORDER BY
  client,
  element,
  pct DESC
