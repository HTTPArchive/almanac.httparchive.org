#standardSQL
#variable_font_with_fcp(??NoResult)
SELECT
  client,
  name,
  COUNT(DISTINCT page) AS freq_vf,
  total_page,
  COUNT(DISTINCT page) * 100 / total_page AS pct_vf,
  COUNTIF(fast_fcp >= 0.75) * 100 / COUNT(0) AS pct_good_fcp_vf,
  COUNTIF(NOT(slow_fcp >= 0.25)
      AND NOT(fast_fcp >= 0.75)) * 100 / COUNT(0) AS pct_ni_fcp_vf,
  COUNTIF(slow_fcp >= 0.25) * 100 / COUNT(0) AS pct_poor_fcp_vf,
FROM (
  SELECT
    *
  FROM
    `httparchive.almanac.requests`
    LEFT JOIN UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload,
        '$._font_details.name'), '(?i)(name)')) AS name
    LEFT JOIN UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload,
        '$._font_details.table_sizes'), '(?i)(gvar)')) AS axisValue
  WHERE
    date='2020-08-01')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX) 
USING
  (client)
JOIN (
  SELECT DISTINCT
    origin, device,
    fast_fcp,
    slow_fcp,
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date='2020-08-01')
ON
  CONCAT(origin, '/')= url AND
  IF(device='desktop','desktop','mobile')=client
WHERE
  type = 'font' AND 
  axisValue IS NOT NULL
GROUP BY
  client,
  name,
  total_page
Order BY
  freq_vf DESC