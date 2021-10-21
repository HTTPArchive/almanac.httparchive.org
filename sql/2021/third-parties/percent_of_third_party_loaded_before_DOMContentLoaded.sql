#standardSQL
# Percent of third-party requests loaded before DOM Content Loaded event

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    page,
    url,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._load_end') AS INT64) AS load_end
  FROM
    `httparchive.requests.2021_07_01_*`
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    onContentLoaded
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

base AS (
  SELECT
    requests.client AS client,
    third_party.domain AS request_domain,
    IF(requests.load_end < pages.onContentLoaded, 1, 0) AS early_request,
    third_party.category AS request_category
  FROM requests
  INNER JOIN third_party
  ON NET.HOST(requests.url) = NET.HOST(third_party.domain)
  LEFT JOIN pages
  ON requests.page = pages.url AND requests.client = pages.client
)

SELECT
  client,
  request_category,
  SUM(early_request) AS early_requests,
  COUNT(0) AS total_requests,
  SUM(early_request) / COUNT(0) AS pct_early_requests
FROM
  base
GROUP BY
  client,
  request_category
