SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(respHeadersSize / 1024, 1000)[OFFSET(percentile * 10)] AS resp_header_kbytes,
  APPROX_QUANTILES(respBodySize / 1024, 1000)[OFFSET(percentile * 10)] AS resp_body_kbytes
FROM
  `httparchive.summary_requests.2021_07_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
