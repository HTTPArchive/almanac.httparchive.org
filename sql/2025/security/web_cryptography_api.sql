#standardSQL
# Section: Attack preventions - Web Cryptography API
# Question: Which Web Cryptography APIs are used the most?
# Note: Possible to port to httparchive.all.pages, however would require to recreate num_urls, total_urls, and pct_urls
SELECT
  client,
  features.feature,
  total_urls,
  COUNT(DISTINCT IF(LOWER(feature) = LOWER(features.feature), page, NULL)) AS urls,
  COUNT(DISTINCT IF(LOWER(feature) = LOWER(features.feature), page, NULL)) / total_urls AS pct_urls
FROM
  `httparchive.crawl.pages`,
  UNNEST(features) AS features,
  (
    SELECT
      COUNT(DISTINCT page) AS total_urls
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-07-01'
  )
WHERE
  (
    features.feature LIKE 'Crypto%' OR
    features.feature LIKE 'Subtle%'
  ) AND
  date = '2025-07-01'
GROUP BY
  client,
  features.feature,
  total_urls
ORDER BY
  pct_urls DESC
