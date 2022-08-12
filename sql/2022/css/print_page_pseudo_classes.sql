#standardSQL
CREATE TEMPORARY FUNCTION getSelectorParts(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      "pseudo-class": {}
    };

    walkRules(ast, rule => {
      walkSelectors(rule, selector => {
        let sast = parsel.parse(selector, {list: false});

        parsel.walk(sast, node => {
          if (node.type in ret) {
            incrementByKey(ret[node.type], node.name);
          }
        }, {subtree: true});
      });
    }, {type: 'page'});

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
  return unzip(parts['pseudo-class']);
} catch (e) {
  return null;
}
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*`
  GROUP BY
    client
)

SELECT
  client,
  pages,
  total_pages,
  pct_pages,
  pseudo_class.value AS pseudo_class,
  pseudo_class.count AS freq,
  pseudo_class.count / pages AS pct
FROM (
  SELECT
    client,
    COUNT(DISTINCT page) AS pages,
    ANY_VALUE(total_pages) AS total_pages,
    COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
    APPROX_TOP_COUNT(pseudo_class, 100) AS pseudo_classes
  FROM (
      SELECT DISTINCT
        client,
        page,
        pseudo_class
      FROM
        `httparchive.almanac.parsed_css`
      LEFT JOIN
        UNNEST(getSelectorParts(css)) AS pseudo_class
      WHERE
        date = '2022-07-01')
  JOIN
    totals
  USING
    (client)
  GROUP BY
    client),
  UNNEST(pseudo_classes) AS pseudo_class
WHERE
  pseudo_class.value IS NOT NULL
ORDER BY
  pct DESC
