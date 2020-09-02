#standardSQL
#font_formats
SELECT
 client,
 LOWER(IFNULL(REGEXP_EXTRACT(mimeType, '/(?:x-)?(?:font-)?(.*)'), ext)) AS mime_type,
 COUNT(0) AS freq_fmt,
 SUM(COUNT(0)) OVER (PARTITION BY client) AS total_fmt,
 ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_fmt,
FROM
 `httparchive.almanac.requests`
join
 (select origin, fast_fcp, slow_fcp,
from
 `chrome-ux-report.materialized.device_summary` where yyyymm=202007)
ON
 concat(origin, '/')= url
WHERE
 type = 'font' AND mimeType!= ''
GROUP BY
 client,
 mime_type
ORDER BY
 freq_fmt DESC
