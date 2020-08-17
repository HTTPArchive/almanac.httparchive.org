#standardSQL
# summary_requests data grouped by device and http status
# all firstHtml urls are 200 - so of no use
# if we report on resources we should probably first group by url and report on urls that contain a resource with a broken status code

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  _TABLE_SUFFIX AS client,
  status,
  COUNT(0) AS total,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct
FROM
  `httparchive.sample_data.summary_requests_*` # TEST
WHERE
  firstHtml = false # so only check resources
GROUP BY
  client,
  status
ORDER BY
  client,
  status

