#standardSQL
# Median resource weights by CMS
SELECT
  client,
  cms,
  COUNT(0) AS pages,
  APPROX_QUANTILES(total_kb, 1000)[OFFSET(500)] AS median_total_kb,
  APPROX_QUANTILES(html_kb, 1000)[OFFSET(500)] AS median_html_kb,
  APPROX_QUANTILES(js_kb, 1000)[OFFSET(500)] AS median_js_kb,
  APPROX_QUANTILES(css_kb, 1000)[OFFSET(500)] AS median_css_kb,
  APPROX_QUANTILES(img_kb, 1000)[OFFSET(500)] AS median_img_kb,
  APPROX_QUANTILES(font_kb, 1000)[OFFSET(500)] AS median_font_kb
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    app AS cms
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'CMS'
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    bytesTotal / 1024 AS total_kb,
    bytesHtml / 1024 AS html_kb,
    bytesJS / 1024 AS js_kb,
    bytesCSS / 1024 AS css_kb,
    bytesImg / 1024 AS img_kb,
    bytesFont / 1024 AS font_kb
  FROM
    `httparchive.summary_pages.2022_06_01_*`
)
USING (client, url)
GROUP BY
  client,
  cms
ORDER BY
  pages DESC
