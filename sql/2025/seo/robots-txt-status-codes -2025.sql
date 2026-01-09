#standardSQL
# Robots txt status codes

# returns all the data we need from _robots_txt
CREATE TEMPORARY FUNCTION getRobotsStatusInfo(robots_txt JSON)
RETURNS STRUCT<
  status_code STRING
> LANGUAGE js AS '''
var result = {};
try {
    if (Array.isArray(robots_txt) || typeof robots_txt != 'object') return result;

    if (robots_txt.status) {
      result.status_code = ''+robots_txt.status;
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  robots_txt_status_info.status_code AS status_code,
  COUNT(0) AS total,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct

FROM
  (
    SELECT
      client,
      getRobotsStatusInfo(custom_metrics.robots_txt) AS robots_txt_status_info
    FROM
      `httparchive.crawl.pages`
    WHERE
      DATE = '2025-07-01'
  )
GROUP BY
  client,
  status_code
ORDER BY
  total DESC
