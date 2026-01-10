#standardSQL
# Percent of third-party requests with "Timing-Allow-Origin" headers
# Header reference: https://developer.mozilla.org/docs/Web/HTTP/Headers/Timing-Allow-Origin

CREATE TEMP FUNCTION get_tao(headers STRING)
RETURNS STRING LANGUAGE js AS '''
  try {
    const regex = /timing-allow-origin = (\\*|(http.*?,? )+)/gm;
    output = regex.exec(headers)[1]+", ";
    output = output.replace(/, , $/, ", ");
    return output;
  } catch (e) {
    return false;
  }
''';

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    RTRIM(urlShort, '/') AS origin,
    respOtherHeaders
  FROM
    `httparchive.summary_requests.2025_06_01_*`
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    pageid AS page,
    RTRIM(urlShort, '/') AS origin
  FROM
    `httparchive.summary_pages.2025_06_01_*`
),

third_party AS (
  SELECT
    domain,
    category,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2025-07-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    category
  HAVING
    page_usage >= 50
),

headers AS (
  SELECT
    requests.client AS client,
    requests.origin AS req_origin,
    pages.origin AS page_origin,
    get_tao(LOWER(respOtherHeaders)) AS timing_allow_origin,
    respOtherHeaders,
    third_party.category AS req_category
  FROM requests
  LEFT JOIN pages
  USING (client, page)
  INNER JOIN third_party
  ON NET.HOST(requests.origin) = NET.HOST(third_party.domain)
),

base AS (
  SELECT
    client,
    IF(respOtherHeaders LIKE '%timing-allow-origin = %', 1, 0) AS tao_header_present,
    IF(
      page_origin = req_origin OR
      timing_allow_origin = '*' OR
      timing_allow_origin LIKE '*,%' OR
      timing_allow_origin LIKE '%,*' OR
      timing_allow_origin LIKE '%,*,%' OR
      timing_allow_origin LIKE '%, *,%' OR
      timing_allow_origin = page_origin OR
      timing_allow_origin LIKE page_origin || ',' OR
      timing_allow_origin LIKE '%,' || page_origin OR
      timing_allow_origin LIKE '%, ' || page_origin OR
      timing_allow_origin LIKE '%,' || page_origin || ',%' OR
      timing_allow_origin LIKE '%, ' || page_origin || ',%',
      1, 0
    ) AS timing_allowed
  FROM headers
)

SELECT
  client,
  SUM(tao_header_present) AS tao_requests,
  SUM(timing_allowed) AS timing_allowed_requests,
  COUNT(0) AS total_requests,
  SUM(tao_header_present) / COUNT(0) AS pct_tao_requests,
  SUM(timing_allowed) / COUNT(0) AS pct_timing_allowed_requests
FROM
  base
GROUP BY
  client
