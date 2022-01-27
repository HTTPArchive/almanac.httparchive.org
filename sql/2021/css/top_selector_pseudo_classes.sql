#standardSQL
CREATE TEMPORARY FUNCTION getSelectorParts(css STRING)
RETURNS STRUCT<
  class ARRAY<STRING>,
  id ARRAY<STRING>,
  attribute ARRAY<STRING>,
  pseudo_class ARRAY<STRING>,
  pseudo_element ARRAY<STRING>
>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      class: {},
      id: {},
      attribute: {},
      "pseudo-class": {},
      "pseudo-element": {}
    };

    walkSelectors(ast, selector => {
      let sast = parsel.parse(selector, {list: false});

      parsel.walk(sast, node => {
        if (node.type in ret) {
          incrementByKey(ret[node.type], node.name);
        }
      }, {subtree: true});
    });

    for (let type in ret) {
      ret[type] = sortObject(ret[type]);
    }

    return ret;
  }

  function unzip(obj) {
    return Object.entries(obj).filter(([name, value]) => {
      return !isNaN(value);
    }).map(([name, value]) => name);
  }

  const ast = JSON.parse(css);
  let parts = compute(ast);
  return {
    class: unzip(parts.class),
    id: unzip(parts.id),
    attribute: unzip(parts.attribute),
    pseudo_class: unzip(parts['pseudo-class']),
    pseudo_element: unzip(parts['pseudo-element'])
  }
} catch (e) {
  return null;
}
''';

SELECT
  client,
  pages,
  pseudo_class.value AS pseudo_class,
  pseudo_class.count AS freq,
  pseudo_class.count / pages AS pct
FROM (
  SELECT
    client,
    COUNT(DISTINCT page) AS pages,
    APPROX_TOP_COUNT(pseudo_class, 100) AS pseudo_classes
  FROM (
      SELECT DISTINCT
        client,
        page,
        pseudo_class
      FROM
        `httparchive.almanac.parsed_css`
      LEFT JOIN
        UNNEST(getSelectorParts(css).pseudo_class) AS pseudo_class
      WHERE
        date = '2021-07-01' AND
        # Limit the size of the CSS to avoid OOM crashes.
        LENGTH(css) < 0.1 * 1024 * 1024)
  GROUP BY
    client),
  UNNEST(pseudo_classes) AS pseudo_class
WHERE
  pseudo_class.value IS NOT NULL
ORDER BY
  pct DESC
