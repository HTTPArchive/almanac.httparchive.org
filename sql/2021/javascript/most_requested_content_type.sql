SELECT
  resp_content_type,
  COUNT(1)
FROM
  `httparchive.sample_data.summary_requests_*`
GROUP BY
  1
ORDER BY
  2 DESC
