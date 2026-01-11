WITH whotracksme AS (
  SELECT
    domain,
    category,
    tracker
  FROM `httparchive.almanac.whotracksme`
  WHERE date = '2025-07-01'
),

pre_aggregated AS (
  SELECT
    client,
    category,
    page,
    tracker,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages
  FROM `httparchive.crawl.requests`
  JOIN whotracksme
  ON NET.REG_DOMAIN(url) = domain
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE AND
    NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url) -- third party
  GROUP BY
    client,
    category,
    tracker,
    page
)

SELECT
  client,
  category,
  tracker,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM pre_aggregated
GROUP BY
  client,
  category,
  tracker
ORDER BY
  pct_pages DESC
