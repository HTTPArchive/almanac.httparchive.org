#standardSQL
SELECT
  client,
  is_root_page,
  unused_preloads,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, is_root_page) AS pct,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT page LIMIT 5), ' ') AS sample_urls
FROM (
  SELECT
    client,
    is_root_page,
    COALESCE(ARRAY_LENGTH(REGEXP_EXTRACT_ALL(consoleLog, r'was preloaded using link preload but not used within a few seconds')), 0) AS unused_preloads,
    page
  FROM (
    SELECT
      client,
      is_root_page,
      JSON_QUERY(payload, '$._consoleLog') AS consoleLog,
      page
    FROM
      `httparchive.all.pages`
    WHERE
      date = '2024-06-01'
  )
)
GROUP BY
  client,
  is_root_page,
  unused_preloads
ORDER BY
  client,
  is_root_page,
  unused_preloads
