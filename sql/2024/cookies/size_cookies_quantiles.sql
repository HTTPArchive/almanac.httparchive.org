-- Extract stats around the size of the cookies
-- Before running query: edit date and client

SELECT
  MIN(CAST(size AS INT)) AS min,
  APPROX_QUANTILES(CAST(size AS INT), 100)[OFFSET(25)] AS p25,
  APPROX_QUANTILES(CAST(size AS INT), 100)[OFFSET(50)] AS median,
  APPROX_QUANTILES(CAST(size AS INT), 100)[OFFSET(75)] AS p75,
  APPROX_QUANTILES(CAST(size AS INT), 100)[OFFSET(90)] AS p90,
  APPROX_QUANTILES(CAST(size AS INT), 100)[OFFSET(99)] AS p99,
  MAX(CAST(size AS INT)) AS max
FROM `httparchive.almanac.cookies`
WHERE
  date = '2024-06-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
  firstPartyCookie IS NOT NULL
