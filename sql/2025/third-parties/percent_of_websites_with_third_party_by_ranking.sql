#standardSQL
# Percent of websites with third parties by ranking

WITH requests AS (
  SELECT
    client,
    page,
    url
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01'
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

pages AS (
  SELECT
    client,
    page,
    rank
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  rank_grouping,
  COUNT(DISTINCT IF(domain IS NOT NULL, page, NULL)) AS pages_with_third_party,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT IF(domain IS NOT NULL, page, NULL)) / COUNT(DISTINCT page) AS pct_pages_with_third_party
FROM
  pages
JOIN
  requests
USING (client, page)
LEFT JOIN
  third_party
ON NET.HOST(requests.url) = NET.HOST(third_party.domain),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
