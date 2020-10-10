#standardSQL
# Percent of third party requests cacheable
# Cache-Control documentation: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control#Directives

WITH requests AS (
  SELECT
    'desktop' AS client,
    resp_cache_control,
    status,
    respOtherHeaders,
    reqOtherHeaders,
    req_host AS host
  FROM
    `httparchive.summary_requests.2020_08_01_desktop`
  UNION ALL (
    SELECT
      'mobile' AS client,
      resp_cache_control,
      status,
      respOtherHeaders,
      reqOtherHeaders,
      req_host AS host
    FROM
      `httparchive.summary_requests.2020_08_01_mobile`
  )
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
    IF(
    (
      status IN (301, 302, 307, 308, 410)
      AND NOT REGEXP_CONTAINS(resp_cache_control, r'private|no-store')
      AND NOT REGEXP_CONTAINS(reqOtherHeaders, r'Authorization')
    )
    OR (
      status IN (301, 302, 307, 308, 410)
      OR REGEXP_CONTAINS(resp_cache_control, r'public|max-age|s-maxage')
      OR REGEXP_CONTAINS(respOtherHeaders, r'Expires')
    ), 1, 0) AS cacheable
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
  sum(cacheable) / COUNT(0) AS pct_cacheable
FROM
  base
GROUP BY
  client