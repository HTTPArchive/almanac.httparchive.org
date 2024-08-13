-- Section: Performance
-- Question: What is the usage of FontFace in JavaScript?

WITH
pages AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01')
  GROUP BY
    client,
    date
),
scripts AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    type = 'script' AND
    REGEXP_CONTAINS(response_body, r'new FontFace\(')
  GROUP BY
    date,
    client
)

SELECT
  date,
  client,
  count,
  total,
  count / total AS proportion
FROM
  scripts
JOIN
  pages USING (date, client)
ORDER BY
  date,
  client
