-- Section: Design
-- Question: Which designers are popular?

WITH
designers AS (
  SELECT
    client,
    NULLIF(TRIM(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[9]')), '') AS designer,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'font'
  GROUP BY
    client,
    designer
),
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  client,
  designer,
  count,
  total,
  count / total AS proportion
FROM
  designers
JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
