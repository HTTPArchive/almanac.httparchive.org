#standardSQL
# Number of third-party requests per page by rank

WITH requests AS (
  SELECT
    client,
    page,
    url
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    is_root_page = true
),

pages AS (
  SELECT
    client,
    page,
    rank
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = true
),

third_party AS (
  SELECT
    tp.client,
    tp.page,
    tp.rank,
    COUNT(DISTINCT r.url) AS distinct_tp_requests,
    COUNT(r.url) AS tp_requests
  FROM
    pages tp
  INNER JOIN
    requests r
  ON NET.HOST(tp.page) = NET.HOST(r.page) AND tp.client = r.client
  GROUP BY
    tp.client,
    tp.page,
    tp.rank
)

SELECT
  client,
  rank_grouping,
  APPROX_QUANTILES(distinct_tp_requests, 1000)[OFFSET(500)] AS p50_distinct_tp_requests_per_page,
  APPROX_QUANTILES(tp_requests, 1000)[OFFSET(500)] AS p50_tp_requests_per_page
FROM
  third_party,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping;
