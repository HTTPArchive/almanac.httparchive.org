# standardSQL
# Sites with more than 1000 non-2xx status codes, or more than 500KiB

SELECT
  client,
  status,
  page,
  COUNT(0) AS number,
  SUM(respHeadersSize) / 1024 AS sizeKiB
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01' AND
  (status < 200 OR status > 299)
GROUP BY
  client,
  status,
  page
HAVING
  number > 1000 OR
  sizeKiB > 500
ORDER BY
  number,
  sizeKiB
