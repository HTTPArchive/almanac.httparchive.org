#standardSQL
# Distribution of external stylesheet transfer size (compressed).
WITH summary_pages AS (
  SELECT
    2019 AS year,
    _TABLE_SUFFIX AS client,
    bytesCSS
  FROM
    `httparchive.summary_pages.2019_07_01_*`
  UNION ALL
  SELECT
    2020 AS year,
    _TABLE_SUFFIX AS client,
    bytesCSS
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  UNION ALL
  SELECT
    2021 AS year,
    _TABLE_SUFFIX AS client,
    bytesCSS
  FROM
    `httparchive.summary_pages.2021_07_01_*`
)

SELECT
  year,
  percentile,
  client,
  APPROX_QUANTILES(bytesCSS / 1024, 1000)[OFFSET(percentile * 10)] AS stylesheet_kbytes
FROM
  summary_pages,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  year,
  percentile,
  client
ORDER BY
  year,
  percentile,
  client
