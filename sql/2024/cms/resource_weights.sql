#standardSQL
# Median resource weights by CMS
#resource_weights.sql

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
    client,
    page as url,
    technologies.technology AS cms
  FROM
    `httparchive.all.pages`,
    UNNEST (technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS'
    AND date ='2024-06-01')
JOIN (
  SELECT
    client,
    page as url,
    cast(json_value(summary, "$.bytesTotal") as int64) / 1024 AS total_kb,
    cast(json_value(summary, "$.bytesHtml") as int64)  / 1024 AS html_kb,
    cast(json_value(summary, "$.bytesJS") as int64) / 1024 AS js_kb,
    cast(json_value(summary, "$.bytesCSS") as int64) / 1024 AS css_kb,
    cast(json_value(summary, "$.bytesImg") as int64) / 1024 AS img_kb,
    cast(json_value(summary, "$.bytesFont") as int64) / 1024 AS font_kb
  FROM
    `httparchive.all.pages`
  WHERE 
    date = '2024-06-01')
USING
  (client, url)
GROUP BY
  client,
  cms
ORDER BY
  pages DESC
