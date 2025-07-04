SELECT
  IF(_rank < 100000000, CAST(_rank AS STRING), 'all') AS rank,
  client,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary.bytesJS) AS INT64), 1000)[OFFSET(500)] / 1024 AS js_kbytes
FROM
  `httparchive.crawl.pages`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS _rank
WHERE
  date = '2025-06-01' AND
  is_root_page AND
  rank <= _rank
GROUP BY
  rank,
  client
ORDER BY
  rank,
  client
