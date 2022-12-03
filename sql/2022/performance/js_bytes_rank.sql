SELECT
  IF(_rank < 10000000, CAST(_rank AS STRING), 'all') AS rank,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(bytesJS, 1001)[OFFSET(501)] / 1024 AS js_kbytes
FROM
  `httparchive.summary_pages.2022_06_01_*`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS _rank
WHERE
  rank <= _rank
GROUP BY
  rank,
  client
ORDER BY
  rank,
  client
