#standardSQL
# Histogram of JS bytes
SELECT
  bin AS kbytes,
  volume,
  ROUND(pdf * 100, 2) AS pdf,
  ROUND(SUM(pdf) OVER (ORDER BY bin) * 100, 2) AS cdf
FROM (
  SELECT
    *,
    volume / SUM(volume) OVER (PARTITION BY 0) AS pdf
  FROM (
    SELECT
      COUNT(0) AS volume,
      CAST(FLOOR(bytesJS / 10240) * 10 AS INT64) AS bin
    FROM
      `httparchive.summary_pages.2020_08_01_*`
    GROUP BY
      bin) )
ORDER BY
  bin
