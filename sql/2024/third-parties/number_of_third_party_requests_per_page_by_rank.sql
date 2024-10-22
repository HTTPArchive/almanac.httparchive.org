#standardSQL
# Number of third-party requests per page by rank
WITH requests AS (
  SELECT
    client,
    page,
    url
  FROM
    `httparchive.all.requests` AS req
  WHERE
    req.date = '2024-06-01' AND
    req.is_root_page = true
),
pages AS (
  SELECT
    client,
    page,
    rank
  FROM
    `httparchive.all.pages` AS pg
  WHERE
    pg.date = '2024-06-01' AND
    pg.is_root_page = true
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
  ON NET.HOST(r.page) = NET.HOST(tp.page) AND r.client = tp.client
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
