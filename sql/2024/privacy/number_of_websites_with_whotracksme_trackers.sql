WITH whotracksme AS (
  SELECT
    domain,
    category,
    tracker
  FROM `max-ostapenko.Public.whotracksme`
  WHERE date = '2024-06-01'
),
pre_aggregated AS (
  SELECT
    client,
    category,
    page,
    COUNT(DISTINCT tracker) AS number_of_trackers,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_websites
  FROM `httparchive.all.requests`
  JOIN whotracksme
  ON NET.REG_DOMAIN(url) = domain
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url) -- third party
  GROUP BY
    client,
    category,
    page
)

SELECT
  client,
  category,
  ANY_VALUE(number_of_trackers) AS number_of_trackers_per_category,
  COUNT(DISTINCT page) / ANY_VALUE(total_websites) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM pre_aggregated
GROUP BY
  client,
  category
ORDER BY
  pct_pages DESC
