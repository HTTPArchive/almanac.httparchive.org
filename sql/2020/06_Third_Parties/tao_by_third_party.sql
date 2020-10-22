#standardSQL
# Percent of third-party requests with "Timing-Allow-Origin" headers
# Header reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Timing-Allow-Origin 

WITH requests AS (
  SELECT
    pageid,
    RTRIM(urlShort, '/') AS origin,
    respOtherHeaders
  FROM
    `httparchive.summary_requests.2020_08_01_mobile`
),
pages AS (
  SELECT
    pageid,
    RTRIM(urlShort, '/') AS origin
  FROM
    `httparchive.summary_pages.2020_08_01_mobile`
),
third_party AS (
  SELECT
    category,
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
),
headers AS (
  SELECT
    requests.origin AS req_origin,
    pages.origin AS page_origin,
    REGEXP_EXTRACT(LOWER(requests.respOtherHeaders), r'timing-allow-origin = (.*?), ') AS timing_allow_origin,
    IFNULL(third_party.category, 'first-party') AS req_category, 
  FROM requests
  LEFT JOIN pages
  USING (pageid)
  INNER JOIN third_party
  ON NET.HOST(requests.origin) = NET.HOST(third_party.domain)
),
base AS (
    SELECT
    req_origin,
    page_origin,
    timing_allow_origin,
    req_category,
    IF(
        page_origin = req_origin
        OR timing_allow_origin = "*"
        OR page_origin = timing_allow_origin,
    1, 0) AS timing_allowed
    FROM headers
)

SELECT
    COUNT(0) total_requests,
    SUM(timing_allowed) / COUNT(0) AS pct_timing_allowed_requests
FROM
    base