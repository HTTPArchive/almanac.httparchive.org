#standardSQL
# Percent of pages using Performance observer
  
SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(performance_pages > 0) AS performance_pages,
  COUNTIF(performance_pages > 0) / COUNT(0) AS pct_performance_pages,
FROM (
  SELECT
    client,
    COUNTIF(body LIKE '%new PerformanceObserver%') AS performance_pages,
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = "2019-08-01"
    AND type = "script"
  GROUP BY
    client,
    page)
GROUP BY
  client