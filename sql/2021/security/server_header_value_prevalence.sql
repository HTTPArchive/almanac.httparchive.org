#standardSQL
# Prevalence of values for Server and X-Powered-By headers; count by number of hosts.

SELECT
  client,
  type,
  resp_value,
  total,
  freq,
  pct
FROM
  (
    SELECT
      client,
      "server" AS type,
      resp_server AS resp_value,
      SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS total,
      COUNT(DISTINCT NET.HOST(page)) AS freq,
      COUNT(DISTINCT NET.HOST(page)) / SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS pct
    FROM
      `httparchive.almanac.requests`
    WHERE
      (date = "2020-08-01" OR date = "2021-07-01") AND
      resp_server IS NOT NULL AND
      resp_server <> ''
    GROUP BY
      client,
      type,
      resp_server
    ORDER BY
      freq DESC
    LIMIT 40
  )
UNION ALL
(
  SELECT
    client,
    "x-powered-by" AS type,
    resp_x_powered_by AS resp_value,
    SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS total,
    COUNT(DISTINCT NET.HOST(page)) AS freq,
    COUNT(DISTINCT NET.HOST(page)) / SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.almanac.requests`
  WHERE
    (date = "2020-08-01" OR date = "2021-07-01") AND
    resp_x_powered_by IS NOT NULL AND
    resp_x_powered_by <> ''
  GROUP BY
    client,
    type,
    resp_x_powered_by
  ORDER BY
    freq DESC
  LIMIT 40
)
ORDER BY
  client,
  type,
  freq DESC
