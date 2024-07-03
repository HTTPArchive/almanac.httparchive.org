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

WITH
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  client,
  property,
  STRUCT(
    COUNT(DISTINCT page) AS count,
    ANY_VALUE(total) AS total,
    COUNT(DISTINCT page) / ANY_VALUE(total) AS proportion
  ) AS pages,
  STRUCT(
    COUNT(0) AS count,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
  ) AS sheets
FROM
  `httparchive.all.parsed_css`,
  UNNEST(getProperties(css)) AS property
JOIN
  pages USING (client)
WHERE
  date = '2024-06-01'
GROUP BY
  client,
  property
ORDER BY
  client,
  sheets.proportion DESC
