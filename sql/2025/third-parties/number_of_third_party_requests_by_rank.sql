#standardSQL
# Number of third-party requests by rank

WITH requests AS (
  SELECT
    client,
    page,
    url
  FROM
    `httparchive.all.requests` AS req
  WHERE
    req.date = '2025-07-01' AND
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
    pg.date = '2025-07-01' AND
    pg.is_root_page = true
),

third_party AS (
  SELECT
    tp.client,
    tp.rank,
    COUNT(DISTINCT r.url) AS distinct_tp_requests,
    COUNT(r.url) AS tp_requests,
    rank_grouping
  FROM
    pages tp
  INNER JOIN
    requests r
  ON NET.HOST(tp.page) = NET.HOST(r.page) AND tp.client = r.client
  CROSS JOIN UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    tp.rank <= rank_grouping
  GROUP BY
    tp.client,
    tp.rank,
    rank_grouping
)

SELECT
  client,
  rank_grouping,
  APPROX_QUANTILES(distinct_tp_requests, 1000)[OFFSET(500)] AS median_distinct_tp_requests,
  APPROX_QUANTILES(tp_requests, 1000)[OFFSET(500)] AS median_tp_requests
FROM
  third_party
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping;
