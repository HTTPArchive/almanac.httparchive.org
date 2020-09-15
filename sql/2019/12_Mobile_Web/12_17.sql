#standardSQL
# 12_17: Histogram of mobile JS bytes (10kb buckets)
SELECT
  bin,
  volume,
  pdf,
  SUM(pdf) OVER (ORDER BY bin) AS cdf
FROM (
  SELECT
    *,
    volume / SUM(volume) OVER () AS pdf
  FROM (
    SELECT
      COUNT(0) AS volume,
      CAST(FLOOR(bytesJS / 10240) * 10 AS INT64) AS bin
    FROM
      `httparchive.summary_pages.2019_07_01_mobile`
    GROUP BY
      bin ) )
ORDER BY
  bin
