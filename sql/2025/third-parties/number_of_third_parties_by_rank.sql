#standardSQL
# Number of third-parties per websites by rank

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
    `httparchive.crawl.pages` AS pg
  WHERE
    pg.date = '2025-07-01' AND
    pg.is_root_page = true
),

third_party AS (
  SELECT
    domain,
    category,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2025-07-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    category
  HAVING
    page_usage >= 50
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
  USING (client, page)
  GROUP BY
    client,
    page,
    rank
)

SELECT
  client,
  rank_grouping,
  APPROX_QUANTILES(third_parties_per_page, 1000)[OFFSET(500)] AS p50_third_parties_per_page
FROM
  base,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
