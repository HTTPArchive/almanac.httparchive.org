SELECT
  client,
  CASE
    WHEN resp_content_type LIKE '%image%' THEN 'images'
    WHEN resp_content_type LIKE '%font%' THEN 'font'
    WHEN resp_content_type LIKE '%css%' THEN 'css'
    WHEN resp_content_type LIKE '%javascript%' THEN 'javascript'
    WHEN resp_content_type LIKE '%json%' THEN 'json'
    ELSE 'other'
  END AS content_type,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client,
  content_type
ORDER BY
  pct DESC
