#standardSQL
# Section: Attack preventions - Preventing attacks using CSP
# Question: Discrepancy between declared and effective CSP, using BlinkFeatures
SELECT
  client,
  featurename,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT IF(LOWER(feature) = LOWER(featurename), page, NULL)) AS count_with_feature,
  COUNT(DISTINCT IF(LOWER(feature) = LOWER(featurename), page, NULL)) / COUNT(DISTINCT page) AS pct_with_feature
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
    'CSPWithUnsafeEval',
    'CSPWithUnsafeDynamic',
    'MainFrameCSPViaHTTP',
    'CSPWithUnsafeHashes',
    'MalformedCSP',
  ]) AS featurename
GROUP BY
  client,
  featurename
ORDER BY
  client,
  featurename
