CREATE TEMPORARY FUNCTION getProperties(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {};
    walkDeclarations(ast, ({property, value}) => {
      const propName = property.toLowerCase();

      if (propName === 'font-variant') {
        incrementByKey(ret, 'font-variant: ' + value)
      } else if (propName.startsWith('font-variant-')) {
        incrementByKey(ret, propName + ': ' + value);
      }
    });
    return sortObject(ret);
  }
  let ast = JSON.parse(css);
  let props = compute(ast);
  return Object.entries(props).flatMap(([prop, freq]) => {
    return Array(freq).fill(prop);
  });
}
catch (e) {
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
  client,
  prop,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getProperties(css)) AS prop
JOIN
  totals
USING (client)
WHERE
  date = '2022-07-01' -- noqa: CV09
GROUP BY
  client,
  prop
ORDER BY
  pct DESC
