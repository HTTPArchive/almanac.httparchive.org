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
    page AS url,
    technologies.technology AS cms
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2025-06-01' AND
    is_root_page
)
JOIN (
  SELECT
    client,
    page AS url,
    CAST(INT64(summary.bytesTotal) AS INT64) / 1024 AS total_kb,
    CAST(INT64(summary.bytesHtml) AS INT64) / 1024 AS html_kb,
    CAST(INT64(summary.bytesJS) AS INT64) / 1024 AS js_kb,
    CAST(INT64(summary.bytesCss) AS INT64) / 1024 AS css_kb,
    CAST(INT64(summary.bytesImg) AS INT64) / 1024 AS img_kb,
    CAST(INT64(summary.bytesFont) AS INT64) / 1024 AS font_kb
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01' AND
    is_root_page
)
USING (client, url)
GROUP BY
  client,
  cms
ORDER BY
  pages DESC
