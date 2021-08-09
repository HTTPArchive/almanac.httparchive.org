#standardSQL
# page robots_txt metrics grouped by device and status code

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _robots_txt
CREATE TEMPORARY FUNCTION get_robots_txt_info(robots_txt_string STRING)
RETURNS STRUCT<
  status_code STRING
> LANGUAGE js AS '''
var result = {};
try {
    var robots_txt = JSON.parse(robots_txt_string);

    if (Array.isArray(robots_txt) || typeof robots_txt != 'object') return result;

    if (robots_txt.status) {
       result.status_code = ''+robots_txt.status;
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  robots_txt_info.status_code AS status_code,

  COUNT(0) AS total,

  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct

  FROM
    (
      SELECT
        _TABLE_SUFFIX AS client,
        get_robots_txt_info(JSON_EXTRACT_SCALAR(payload, '$._robots_txt')) AS robots_txt_info
      FROM
        `httparchive.pages.2020_08_01_*`
    )
GROUP BY
  client,
  status_code
ORDER BY total DESC

