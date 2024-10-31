#standardSQL
# Median number of third-parties & green third-party requests per websites by rank

WITH requests AS (
  SELECT
    client,
    CAST(JSON_VALUE(summary, '$.pageid') AS INT64) AS page,
    url
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01'
),

green AS (
  SELECT
    NET.HOST(url) AS host,
    TRUE AS is_green
  FROM
    `httparchive.almanac.green_web_foundation`
  WHERE
    date = '2024-09-01'
),

pages AS (
  SELECT
    client,
    CAST(JSON_VALUE(summary, '$.pageid') AS INT64)AS page,
    rank
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
),

third_party AS (
  SELECT
    domain,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2024-06-01' AND
    category NOT IN ('hosting')
  GROUP BY
    domain
  HAVING
    page_usage >= 50
),

green_tp AS (
  SELECT
    domain
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    green g
  ON NET.HOST(g.host) = NET.HOST(tp.domain)
  WHERE
    date = '2024-06-01' AND
    category NOT IN ('hosting')
  GROUP BY
    domain
),

base AS (
  SELECT
    client,
    page,
    rank,
    COUNT(domain) AS third_parties_per_page
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
  INNER JOIN
    pages
  USING
    (client, page)
  GROUP BY
    client,
    page,
    rank
),

base_green AS (
  SELECT
    client,
    page,
    rank,
    COUNT(domain) AS green_third_parties_per_page
  FROM
    requests
  LEFT JOIN
    green_tp
  ON
    NET.HOST(requests.url) = NET.HOST(green_tp.domain)
  INNER JOIN
    pages
  USING
    (client, page)
  GROUP BY
    client,
    page,
    rank
)

SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 0 THEN ''
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  APPROX_QUANTILES(third_parties_per_page, 1000)[OFFSET(500)] AS p50_third_parties_per_page,
  APPROX_QUANTILES(green_third_parties_per_page, 1000)[OFFSET(500)] AS p50_green_third_parties_per_page,
  APPROX_QUANTILES(SAFE_DIVIDE(green_third_parties_per_page, third_parties_per_page), 1000)[OFFSET(500)] AS pct_green
FROM
  base,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
JOIN
  base_green
USING (client, page, rank)
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
