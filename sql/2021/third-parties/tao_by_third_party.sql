#standardSQL
# Percent of third-party requests with "Timing-Allow-Origin" headers
# Header reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Timing-Allow-Origin

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
    pageid,
    RTRIM(urlShort, '/') AS origin,
    respOtherHeaders
  FROM
    `httparchive.summary_requests.2021_07_01_*`
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid,
    RTRIM(urlShort, '/') AS origin
  FROM
    `httparchive.summary_pages.2021_07_01_*`
),

third_party AS (
  SELECT
    category,
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2021-07-01' AND
    category != 'hosting'
),

headers AS (
  SELECT
    requests.client AS client,
    requests.origin AS req_origin,
    pages.origin AS page_origin,
    get_tao(LOWER(respOtherHeaders)) AS timing_allow_origin,
    third_party.category AS req_category
  FROM requests
  LEFT JOIN pages
  USING (client, pageid)
  INNER JOIN third_party
  ON NET.HOST(requests.origin) = NET.HOST(third_party.domain)
),

base AS (
  SELECT
    client,
    IF(
      page_origin = req_origin OR
      timing_allow_origin = "*, " OR
      STRPOS(timing_allow_origin, CONCAT(page_origin, ", ")) > 0,
      1, 0) AS timing_allowed
  FROM headers
)

SELECT
  client,
  SUM(timing_allowed) AS timing_allowed_requests,
  COUNT(0) AS total_requests,
  SUM(timing_allowed) / COUNT(0) AS pct_timing_allowed_requests
FROM
  base
GROUP BY
  client
