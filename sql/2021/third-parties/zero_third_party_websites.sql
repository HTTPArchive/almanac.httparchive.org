#standardSQL
# Websites with no third party requests

# Provides incorrect information in some cases, e.g. pageid = 140607555

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    crawlid,
    req_host AS host
  FROM
    `httparchive.summary_requests.2021_07_01_*`
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid,
    crawlid,
    wptid,
    reqTotal,
    url
  FROM
    `httparchive.summary_pages.2021_07_01_*`
),

base AS (
  SELECT
    requests.client,
    LOGICAL_AND(NET.HOST(host) = NET.HOST(url)) AS zero_third_party,
    url,
    requests.crawlid AS requests_crawl,
    pages.crawlid AS pages_crawl,
    wptid,
    reqTotal
  FROM
    requests
  JOIN
    pages
  ON
    requests.page = pages.pageid AND
    requests.client = pages.client
  GROUP BY
    client,
    url,
    requests_crawl,
    pages_crawl,
    wptid,
    reqTotal
  HAVING
    zero_third_party = TRUE

)

SELECT
  client,
  url,
  requests_crawl,
  pages_crawl,
  wptid,
  reqTotal
FROM
  base
ORDER BY
  reqTotal DESC
LIMIT 1000
