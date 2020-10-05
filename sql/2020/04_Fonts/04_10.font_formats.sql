#standardSQL
#font_formats
SELECT
 client,
 LOWER(IFNULL(REGEXP_EXTRACT(mimeType, '/(?:x-)?(?:font-)?(.*)'), ext)) AS mime_type,
 COUNT(0) AS freq_fmt,
 SUM(COUNT(0)) OVER (PARTITION BY client) AS total_fmt,
 COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_fmt,
FROM
 `httparchive.almanac.requests`
WHERE
 type = 'font' AND mimeType!= '' AND date='2020-08-01'
GROUP BY
 client,
 mime_type
ORDER BY
 freq_fmt DESC
