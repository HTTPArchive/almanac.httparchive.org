#standardSQL
SELECT
  client,
  fuguAPI,
  COUNT(DISTINCT root_page) AS sites,
  total,
  COUNT(DISTINCT root_page) / total AS pct,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT page LIMIT 50), ' ') AS sample_urls
FROM
  `httparchive.crawl.pages`
JOIN
  (
    SELECT
      client,
      COUNT(root_page) AS total
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-07-01'
    GROUP BY
      client
  ) USING (client),
  UNNEST(JSON_KEYS(custom_metrics.other.`fugu-apis`)) AS fuguAPI
WHERE
  date = '2025-07-01' AND
  custom_metrics.other.`fugu-apis` IS NOT NULL
GROUP BY
  fuguAPI,
  client,
  total
HAVING
  COUNT(DISTINCT root_page) >= 10
ORDER BY
  pct DESC,
  client;
