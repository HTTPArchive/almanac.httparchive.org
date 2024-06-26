#standardSQL
# Percent of third party requests cached
# Cache-Control documentation: https://developer.mozilla.org/docs/Web/HTTP/Headers/Cache-Control#Directives

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    resp_cache_control,
    status,
    respOtherHeaders,
    reqOtherHeaders,
    type,
    req_host AS host
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
    type,
    IF((
      status IN (301, 302, 307, 308, 410) AND
      NOT REGEXP_CONTAINS(resp_cache_control, r'(?i)private|no-store') AND
      NOT REGEXP_CONTAINS(reqOtherHeaders, r'Authorization')
    ) OR (
      status IN (301, 302, 307, 308, 410) OR
      REGEXP_CONTAINS(resp_cache_control, r'public|max-age|s-maxage') OR
      REGEXP_CONTAINS(respOtherHeaders, r'Expires')
    ), 1, 0
    ) AS cached
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
  type,
  COUNT(0) AS total_requests,
  SUM(cached) / COUNT(0) AS pct_cached_requests
FROM
  base
GROUP BY
  client,
  type
