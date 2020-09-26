#standardSQL
#color_fonts(??NoResult)
SELECT
 client,
 format,
 COUNT(DISTINCT page) AS pages_color,
 total_page,
 COUNT(DISTINCT page) * 100 / total_page AS pct_color
FROM
 `httparchive.almanac.requests`
JOIN
 (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total_page FROM `httparchive.summary_pages.2020_08_01_*` GROUP BY _TABLE_SUFFIX)
USING
 (client),
# Color fonts have any of sbix, cbdt, svg or colr tables.
 UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)(sbix|CBDT|SVG|COLR)')) AS format
WHERE
 type = 'font' AND date='2020-08-01'
GROUP BY
 client,
 total_page,
 format
ORDER BY
 pages_color DESC
