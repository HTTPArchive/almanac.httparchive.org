#standardSQL
# 01_01d: Histogram of JS bytes by client
SELECT
  bin AS kbytes,
  client,
  volume,
  ROUND(pdf * 100, 2) AS pdf,
  ROUND(SUM(pdf) OVER (PARTITION BY client ORDER BY bin) * 100, 2) AS cdf
FROM (
  SELECT
    *,
    volume / SUM(volume) OVER (PARTITION BY client) AS pdf
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      COUNT(0) AS volume,
      CAST(FLOOR(bytesJS / 10240) * 10 AS INT64) AS bin
    FROM
      `httparchive.summary_pages.2019_07_01_*`
    GROUP BY
      bin,
      client
  )
)
ORDER BY
  bin,
  client
