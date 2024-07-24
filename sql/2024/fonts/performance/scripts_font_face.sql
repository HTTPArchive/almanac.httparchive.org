-- Section: Performance
-- Question: What is the usage of FontFace in JavaScript?

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
scripts AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    type = 'script' AND
    date = '2024-07-01' AND
    REGEXP_CONTAINS(response_body, r'new FontFace\(')
  GROUP BY
    client
)

SELECT
  client,
  count,
  total,
  count / total AS proportion
FROM
  scripts
JOIN
  pages USING (client)
ORDER BY
  client
