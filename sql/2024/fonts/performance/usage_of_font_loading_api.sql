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
),
scripts AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    type = 'script' AND
    date = '2024-06-01' AND
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
