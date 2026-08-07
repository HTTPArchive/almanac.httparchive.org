#standardSQL
# - percentiles of the number of stylesheets per page, per year
# - percentiles of CSS file size, per year
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
),

percentiles AS (
  SELECT
    report_year,
    percentile,
    APPROX_QUANTILES(remote_css + inline_css, 1000)[OFFSET(percentile * 10)] AS num_stylesheets_per_page,
    APPROX_QUANTILES(bytes_css, 1000)[OFFSET(percentile * 10)] AS css_bytes_per_page
  FROM
    basedata
  CROSS JOIN
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  GROUP BY
    report_year, percentile
)

SELECT
  report_year,
  SUM(CASE WHEN percentile = 10 THEN num_stylesheets_per_page ELSE 0 END) AS num_stylesheets_per_page_p10,
  SUM(CASE WHEN percentile = 25 THEN num_stylesheets_per_page ELSE 0 END) AS num_stylesheets_per_page_p25,
  SUM(CASE WHEN percentile = 50 THEN num_stylesheets_per_page ELSE 0 END) AS num_stylesheets_per_page_p50,
  SUM(CASE WHEN percentile = 75 THEN num_stylesheets_per_page ELSE 0 END) AS num_stylesheets_per_page_p75,
  SUM(CASE WHEN percentile = 90 THEN num_stylesheets_per_page ELSE 0 END) AS num_stylesheets_per_page_p90,
  SUM(CASE WHEN percentile = 100 THEN num_stylesheets_per_page ELSE 0 END) AS num_stylesheets_per_page_p100,
  SUM(CASE WHEN percentile = 10 THEN css_bytes_per_page ELSE 0 END) AS css_bytes_per_page_p10,
  SUM(CASE WHEN percentile = 25 THEN css_bytes_per_page ELSE 0 END) AS css_bytes_per_page_p25,
  SUM(CASE WHEN percentile = 50 THEN css_bytes_per_page ELSE 0 END) AS css_bytes_per_page_p50,
  SUM(CASE WHEN percentile = 75 THEN css_bytes_per_page ELSE 0 END) AS css_bytes_per_page_p75,
  SUM(CASE WHEN percentile = 90 THEN css_bytes_per_page ELSE 0 END) AS css_bytes_per_page_p90,
  SUM(CASE WHEN percentile = 100 THEN css_bytes_per_page ELSE 0 END) AS css_bytes_per_page_p100
FROM
  percentiles
GROUP BY
  report_year
ORDER BY
  report_year
