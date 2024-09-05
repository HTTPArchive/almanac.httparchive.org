-- Section: Design
-- Question: Which designers are popular?
-- Normalization: Sites

WITH
designers AS (
  SELECT
    client,
    NULLIF(TRIM(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[9]')), '') AS designer,
    COUNT(DISTINCT page) AS count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page AND
    type = 'font'
  GROUP BY
    client,
    designer
  QUALIFY
    rank <= 100
),
sites AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page
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
  sites USING (client)
ORDER BY
  client,
  proportion DESC
