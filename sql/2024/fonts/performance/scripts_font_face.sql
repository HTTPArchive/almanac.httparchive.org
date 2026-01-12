-- Section: Performance
-- Question: What is the usage of FontFace in JavaScript?
-- Normalization: Pages

WITH
scripts AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-06-01', '2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
    type = 'script' AND
    is_root_page AND
    REGEXP_CONTAINS(response_body, r'new FontFace\(')
  GROUP BY
    date,
    client
),

pages AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-06-01', '2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
    is_root_page
  GROUP BY
    client,
    date
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
  pages
USING (date, client)
ORDER BY
  date,
  client
