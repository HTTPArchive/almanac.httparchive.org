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
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)

SELECT
  client,
  pseudo_class,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_freq
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
    date = '2022-07-01' AND -- noqa: CV09
    pseudo_class IS NOT NULL
)
JOIN
  totals
USING (client)
GROUP BY
  client,
  pseudo_class
ORDER BY
  pct_pages DESC
