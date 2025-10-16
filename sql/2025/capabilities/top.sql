#standardSQL
SELECT
  client,
  page,
  COUNT(DISTINCT fuguAPI) AS fuguAPIs
FROM
  `httparchive.crawl.pages`,
  UNNEST(JSON_KEYS(custom_metrics.other.`fugu-apis`)) AS fuguAPI
WHERE
  date = '2025-07-01' AND
  custom_metrics.other.`fugu-apis` IS NOT NULL
GROUP BY
  client,
  page
HAVING
  COUNT(DISTINCT fuguAPI) >= 1
ORDER BY
  fuguAPIs DESC,
  page,
  client
LIMIT 100;
