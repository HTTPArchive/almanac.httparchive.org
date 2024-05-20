#standardSQL
#web_fonts_usage_by_country
SELECT
  _TABLE_SUFFIX AS client,
  country,
  COUNT(0) AS freq_url,
  APPROX_QUANTILES(bytesFont, 1000)[OFFSET(500)] / 1024 AS median_font_kbytes
FROM (
  SELECT DISTINCT
    origin,
    device,
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202107
)
JOIN
  `httparchive.summary_pages.2021_07_01_*`
ON
  CONCAT(origin, '/') = url AND
  IF(device = 'desktop', 'desktop', 'mobile') = _TABLE_SUFFIX
WHERE
  bytesFont IS NOT NULL
GROUP BY
  client,
  country
ORDER BY
  client,
  country
