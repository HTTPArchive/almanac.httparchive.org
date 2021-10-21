#standardSQL
# Percent of third party requests by content type.

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    type AS contentType
  FROM
    `httparchive.summary_requests.2021_07_01_*`
),

third_party AS (
  SELECT
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2021-07-01' AND
    category != 'hosting'
)

SELECT
  client,
  contentType,
  COUNT(0) AS requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_requests,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_requests
FROM
  requests
LEFT JOIN
  third_party
ON
  NET.HOST(requests.url) = NET.HOST(third_party.domain)
WHERE
  domain IS NOT NULL
GROUP BY
  client,
  contentType
ORDER BY
  client,
  contentType
