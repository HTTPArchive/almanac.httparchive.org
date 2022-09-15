#standardSQL
# 20.10 - Count of sites using HTTP/2 Push

WITH totals AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM
    `httparchive.almanac.requests`
  WHERE
    date IN ('2019-07-01', '2020-08-01', '2021-07-01', '2022-06-01')
  GROUP BY
    date,
    client
)

SELECT
  date,
  client,
  COUNT(DISTINCT page) AS num_pages,
  total_pages,
  COUNT(DISTINCT page) / total_pages AS pct_pages
FROM (
  SELECT
    date,
    client,
    page
  FROM
    `httparchive.almanac.requests`
  WHERE
    date IN ('2019-07-01', '2020-08-01', '2021-07-01', '2022-06-01') AND
    pushed = '1'
)
JOIN
  totals
USING (date, client)
GROUP BY
  date,
  total_pages,
  client
ORDER BY
  date,
  client
