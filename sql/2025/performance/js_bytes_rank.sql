SELECT
  IF(ranking < 100000000, CAST(ranking AS STRING), 'all') AS ranking,
  client,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary.bytesJS) AS INT64), 1000)[OFFSET(500)] / 1024 AS js_kbytes
FROM
  `httparchive.crawl.pages`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS ranking
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  rank <= ranking
GROUP BY
  ranking,
  client
ORDER BY
  ranking,
  client
