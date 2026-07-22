WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    client
)

SELECT
  client AS client,
  element_type,
  COUNT(DISTINCT page) AS pages,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.crawl.pages`
JOIN
  totals
USING (client),
  UNNEST(JSON_KEYS(custom_metrics.element_count)) AS element_type
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  total,
  element_type
ORDER BY
  pct DESC,
  client,
  pages DESC
LIMIT 1000
