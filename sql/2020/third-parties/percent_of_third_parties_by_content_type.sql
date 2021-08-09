#standardSQL
# Percent of third party requests by content type.

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    req_host AS host,
    type AS contentType
  FROM
    `httparchive.summary_requests.2020_08_01_*`
),

third_party AS (
  SELECT
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
),

base AS (
  SELECT
    client,
    contentType,
    COUNT(0) OVER (PARTITION BY client) AS total_requests
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
  WHERE
    domain IS NOT NULL
)

SELECT
  client,
  contentType,
  total_requests,
  COUNT(0) AS requests,
  COUNT(0) / total_requests AS pct_requests
FROM
  base
GROUP BY
  client,
  contentType,
  total_requests
ORDER BY
  client,
  contentType
