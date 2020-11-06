#standardSQL
# Websites with no third party requests

# Provides incorrect information in some cases, e.g. pageid = 140607555 

WITH requests AS (
  SELECT
    pageid AS page,
    req_host AS host
  FROM
    `httparchive.summary_requests.2020_08_01_mobile`
),
pages AS (
  SELECT
    pageid,
    url
  FROM
    `httparchive.summary_pages.2020_08_01_mobile`
),
base AS (
  SELECT
    LOGICAL_AND(IF(NET.HOST(host) = NET.HOST(url), TRUE, FALSE)) zero_third_party,
    url
  FROM
    requests
  INNER JOIN
    pages
  ON
    requests.page = pages.pageid
  GROUP BY
    url
)

SELECT
  url
FROM
  base
WHERE
  zero_third_party = TRUE
  AND REGEXP_CONTAINS(url, r"^https:\/\/www\.[a-z]+\.com\/$")
ORDER BY
  url