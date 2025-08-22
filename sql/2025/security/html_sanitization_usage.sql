#standardSQL
# Section: Attack preventions - HTML Sanitization
# Question: How often is setHTMLUnsafe and parseHTMLUnsafe used?
# Note: Possible to port to httparchive.all.pages, however would require to recreate num_urls, total_urls, and pct_urls
# Note: https://chromestatus.com/feature/6560361081995264
# Note: very rare!
SELECT
  client,
  featurename,
  COUNT(DISTINCT page) AS total_urls,
  COUNT(DISTINCT IF(LOWER(feature) = LOWER(featurename), page, NULL)) AS num_urls,
  COUNT(DISTINCT IF(LOWER(feature) = LOWER(featurename), page, NULL)) / COUNT(DISTINCT page) AS pct_urls
FROM (
  SELECT
    client,
    page,
    features.feature AS feature
  FROM
    `httparchive.crawl.pages`,
    UNNEST(features) AS features
  WHERE
    date = '2025-07-01'
),
  UNNEST([
    'SetHTMLUnsafe', 'ParseHTMLUnsafe'
  ]) AS featurename
GROUP BY
  client,
  featurename
ORDER BY
  client,
  featurename
