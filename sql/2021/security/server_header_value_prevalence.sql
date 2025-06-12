#standardSQL
# Prevalence of values for Server and X-Powered-By headers; count by number of hosts.

WITH requests AS (
  SELECT
    client,
    NET.HOST(page) AS host,
    resp_server,
    resp_x_powered_by
  FROM
    `httparchive.almanac.requests`
  WHERE
    date IN ('2020-08-01', '2021-07-01')
),

server_data AS (
  SELECT
    client,
    'server' AS type,
    resp_server AS resp_value,
    COUNT(DISTINCT host) AS freq,
    SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total,
    COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
  FROM
    requests
  WHERE
    resp_server IS NOT NULL AND
    resp_server != ''
  GROUP BY
    client, resp_server
  ORDER BY
    freq DESC
  LIMIT
    40
),

x_powered_by_data AS (
  SELECT
    client,
    'x-powered-by' AS type,
    resp_x_powered_by AS resp_value,
    COUNT(DISTINCT host) AS freq,
    SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total,
    COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
  FROM
    requests
  WHERE
    resp_x_powered_by IS NOT NULL AND
    resp_x_powered_by != ''
  GROUP BY
    client, resp_x_powered_by
  ORDER BY
    freq DESC
  LIMIT
    40
)

SELECT * FROM server_data
UNION ALL
SELECT * FROM x_powered_by_data
ORDER BY client, type, freq DESC
