SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  AVG(reqHeadersSize) / 1024 AS request_header_size,
  AVG(reqBodySize) / 1024 AS request_body_size,
  AVG(respHeadersSize) / 1024 AS response_header_size,
  AVG(respBodySize) / 1024 AS response_body_size,
FROM
  `httparchive.summary_requests.2021_09_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
