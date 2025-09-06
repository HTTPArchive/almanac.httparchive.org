SELECT
  client,
  fuguAPI,
  COUNT(DISTINCT root_page) AS pages,
  total,
  COUNT(DISTINCT root_page) / total AS pct,
  ARRAY_TO_STRING(
    ARRAY_AGG(
      DISTINCT page
      LIMIT
        50
    ), ' '
  ) AS sample_urls
FROM
  `httparchive.crawl.pages`
  JOIN (
    SELECT
      date,
      client,
      COUNT(root_page) AS total
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-07-01'
    GROUP BY
      client,
      date
  ) USING (date, client),
  UNNEST(JSON_KEYS(custom_metrics.other ['fugu-apis'])) AS fuguAPI
WHERE
  TO_JSON_STRING(custom_metrics.other ['fugu-apis']) != '{}'
  AND TO_JSON_STRING(custom_metrics.other ['fugu-apis']) != 'null'
  AND custom_metrics.other ['fugu-apis'] IS NOT NULL
  AND date = '2025-07-01'
GROUP BY
  fuguAPI,
  client,
  total
HAVING
  COUNT(DISTINCT root_page) >= 10
ORDER BY
  pct DESC,
  client;