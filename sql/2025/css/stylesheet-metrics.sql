#standardSQL
# - percentage of mobile pages, per year
# - average number of inline stylesheets per page, per year
# - average number of remote stylesheets per page, per year
# - average number of total of stylesheets per page, per year
# - largest amount of inline stylesheets loaded, per year
# - largest amount of remote stylesheets loaded, per year
# - largest amount of total of stylesheets loaded, per year
# - average CSS size per page, per year
# - largest CSS size per page, per year
CREATE TEMPORARY FUNCTION getStylesheets(otherMetrics JSON, elementCounts JSON)
RETURNS STRUCT<remote INT64, inline INT64> LANGUAGE js AS '''
try {
  if (otherMetrics && otherMetrics.sass && otherMetrics.sass.stylesheets) {
    // data from 2022 onwards
    return otherMetrics.sass.stylesheets;
  } else {
    // data from before 2022
    return {
      remote: (otherMetrics && otherMetrics.almanac && ('link-nodes' in otherMetrics.almanac)) ? otherMetrics.almanac['link-nodes'].reduce(function(a, e) { return (e.rel.toLowerCase() === 'stylesheet') ? a + 1 : a; }, 0) : null,
      inline: (elementCounts && elementCounts.style) ? elementCounts.style : null
    }
  }
} catch (e) {
  return null;
}
''';

WITH
basedata AS (
  SELECT
    EXTRACT(YEAR FROM `date`) AS report_year,
    client,
    LAX_INT64(IFNULL(summary.bytesCss, summary.bytesCSS)) AS bytes_css, -- In 2022 property name was changed by bytesCSS to bytesCss
    getStylesheets(custom_metrics.other, custom_metrics.element_count) AS stylesheets
  FROM
    `httparchive.crawl.pages` --TABLESAMPLE SYSTEM (0.01 PERCENT)
  WHERE `date` IN ('2025-07-01', '2024-07-01', '2023-07-01', '2022-07-01', '2021-07-01', '2020-07-01', '2019-07-01')
)

SELECT
  report_year,
  COUNTIF(client = 'mobile') / COUNT(0) AS pct_mobile,
  AVG(stylesheets.inline) AS avg_inline_stylesheets_per_page,
  AVG(stylesheets.remote) AS avg_remote_stylesheets_per_page,
  AVG(stylesheets.inline + stylesheets.remote) AS avg_stylesheets_per_page,
  MAX(stylesheets.inline) AS max_inline_stylesheets_per_page,
  MAX(stylesheets.remote) AS max_remote_stylesheets_per_page,
  MAX(stylesheets.inline + stylesheets.remote) AS max_stylesheets_per_page,
  AVG(bytes_css) AS avg_css_bytes_per_page,
  MAX(bytes_css) AS max_css_bytes_per_page
FROM
  basedata
GROUP BY
  report_year
ORDER BY
  report_year;
