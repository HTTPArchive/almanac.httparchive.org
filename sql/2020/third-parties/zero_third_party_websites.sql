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
    `httparchive.summary_requests.2020_08_01_*`
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
    `httparchive.summary_pages.2020_08_01_*`
),

base AS (
  SELECT
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
    requests.page = pages.pageid
  GROUP BY
    url, requests_crawl, pages_crawl, wptid, reqTotal
  HAVING
    zero_third_party = TRUE

)

SELECT
  url, requests_crawl, pages_crawl, wptid, reqTotal
FROM
  base
ORDER BY
  reqTotal DESC
