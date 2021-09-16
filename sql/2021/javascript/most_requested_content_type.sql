SELECT
  resp_content_type,
  COUNT(0) AS count
FROM
  `httparchive.sample_data.summary_requests_*`
GROUP BY
  1
ORDER BY
  2 DESC
