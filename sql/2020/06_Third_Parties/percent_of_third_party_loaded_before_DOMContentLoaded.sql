#standardSQL
# Percent of third-party requests loaded before DOM Content Loaded event

CREATE TEMP FUNCTION get_load_end_time(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    return $._load_end
  } catch (e) {
    return false;
  }
''';

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    page,
    url,
    get_load_end_time(payload) as load_end
  FROM
    `httparchive.requests.2020_08_01_*`
),
pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    onContentLoaded
  FROM
    `httparchive.summary_pages.2020_08_01_*`
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
base AS (
  SELECT
    requests.client AS client,
    third_party.domain AS request_domain,
    IF(requests.load_end < pages.onContentLoaded, 1, 0) AS early_request,
    third_party.category AS request_category,
  FROM requests
  INNER JOIN third_party
  ON NET.HOST(requests.url) = NET.HOST(third_party.domain)
  LEFT JOIN pages
  ON requests.page = pages.url and requests.client = pages.client
)

SELECT
  client,
  request_category,
  COUNT(0) AS total_requests,
  SUM(early_request) / COUNT(0) AS pct_early_requests
FROM
  base
GROUP BY
  client,
  request_category