SELECT
  _TABLE_SUFFIX AS client,
  AVG(reqHeadersSize) / 1024 AS request_header_size,
  AVG(respHeadersSize) / 1024 AS response_header_size,
  AVG(respBodySize) / 1024 AS response_body_size
FROM
  `httparchive.summary_requests.2021_07_01_*`
GROUP BY
  client
