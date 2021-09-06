#standardSQL
SELECT
  SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  percentile,
  APPROX_QUANTILES(respHeadersSize, 1000)[OFFSET(percentile * 10)] / 1024 AS respHeadersSizeKiB
FROM
  `httparchive.summary_requests.*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  respHeadersSize IS NOT NULL AND
  _TABLE_SUFFIX LIKE "2021_07_01%"
GROUP BY
  date,
  percentile,
  client
ORDER BY
  client,
  percentile
