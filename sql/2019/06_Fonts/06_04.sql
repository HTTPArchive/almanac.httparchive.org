#standardSQL

-- counts font-display value usage

SELECT
  ROUND(SUM(IF(JSON_EXTRACT(report, '$.audits.font-display.score') IN ('true', '1'), 1, 0)) * 100 / COUNT(0), 2) AS percent
FROM
  `httparchive.lighthouse.2019_07_01_*`
WHERE
  report IS NOT NULL AND
  JSON_EXTRACT(report, '$.audits.font-display.score') IS NOT NULL

-- WITH
--   response_bodies AS (
--     SELECT * FROM `httparchive.response_bodies.2019_07_01_desktop`
--     UNION ALL
--     SELECT * FROM `httparchive.response_bodies.2019_07_01_mobile`
--   ),
--   temp AS (
--     SELECT REGEXP_EXTRACT_ALL(body, r"font-display\:\s*\w+") AS font_display_arr, url
--     FROM response_bodies WHERE STRPOS(body, "font-display") > 0
--   ),
--   processedTable AS (
--     SELECT TRIM(SPLIT(font_display, ":")[OFFSET(1)]) AS font_display, url
--     FROM temp,
--     UNNEST(font_display_arr) AS font_display
--   )
-- SELECT
--   DISTINCT(font_display),
--   COUNT(font_display) AS count
-- FROM processedTable
-- GROUP BY font_display
-- ORDER BY count DESC
