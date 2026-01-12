#standardSQL
# Distribution of unminified JS request bytes per page

SELECT
  client,
  percentile,
  APPROX_QUANTILES(
    CAST(
      JSON_VALUE(
        lighthouse,
        '$.audits.unminified-javascript.details.overallSavingsBytes'
      ) AS INT64
    ) / 1024,
    1000
  )[OFFSET(percentile * 10)] AS js_kilobytes
FROM
  `httparchive.crawl.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
