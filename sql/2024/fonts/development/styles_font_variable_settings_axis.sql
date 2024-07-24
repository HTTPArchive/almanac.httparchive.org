-- Section: Development
-- Question: Which axes are used in CSS?

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }
    return values.concat(
      rule.declarations
        .filter(d => d.property.toLowerCase() == 'font-variation-settings')
        .map(d => d.value)
    );
  };
  var $ = JSON.parse(json);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

WITH
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01'
  GROUP BY
    client
),
properties AS (
  SELECT
    client,
    REGEXP_EXTRACT(chunk, r'''['"]([\w]{4})['"]''') AS axis,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property,
    UNNEST(SPLIT(property, ',')) AS chunk
  WHERE
    date = '2024-07-01'
  GROUP BY
    client,
    axis
  HAVING
    axis IS NOT NULL
)

SELECT
  client,
  axis,
  count,
  total,
  count / total AS proportion
FROM
  properties
JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
