#standardSQL
# 04_03: SVG usage
SELECT
  client,
  percentile,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  ROUND(APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS kbytes
FROM (
  SELECT _TABLE_SUFFIX AS client, COUNT(0) AS requests, SUM(respSize) AS bytes
  FROM `httparchive.summary_requests.2019_07_01_*`
  WHERE format = 'svg'
  GROUP BY client, pageid),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile