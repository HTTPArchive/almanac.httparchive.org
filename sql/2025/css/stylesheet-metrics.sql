#standardSQL
# - percentage of mobile pages, per year
# - average number of stylesheets per page, per year
# - largest amount of stylesheets loaded, per year
# - average CSS size per page, per year
# - largest CSS size per page, per year
WITH
basedata AS (
  SELECT
    EXTRACT(YEAR FROM `date`) AS report_year,
    client,
    LAX_INT64(IFNULL(summary.bytesCss, summary.bytesCSS)) AS bytes_css, -- In 2022 property name was changed by bytesCSS to bytesCss
    LAX_INT64(IFNULL(summary.reqCss, summary.reqCSS)) AS remote_css,
    IFNULL(LAX_INT64(custom_metrics.element_count.style), 0) AS inline_css
  FROM
    `httparchive.crawl.pages` --TABLESAMPLE SYSTEM (0.01 PERCENT)
  WHERE `date` IN ('2025-07-01', '2024-07-01', '2023-07-01', '2022-07-01', '2021-07-01', '2020-07-01', '2019-07-01')
)

SELECT
  report_year,
  COUNTIF(client = 'mobile') / COUNT(0) AS pct_mobile,
  AVG(remote_css + inline_css) AS avg_stylesheets_per_page,
  MAX(remote_css + inline_css) AS max_stylesheets_per_page,
  AVG(bytes_css) AS avg_css_bytes_per_page,
  MAX(bytes_css) AS max_css_bytes_per_page
FROM
  basedata
GROUP BY
  report_year
ORDER BY
  report_year;
