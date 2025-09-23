#standardSQL
# - percentiles of the number of inline stylesheets per page, per year
# - percentiles of the number of remote stylesheets per page, per year
# - percentiles of the total number of stylesheets per page, per year
# - percentiles of CSS file size, per year
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
  percentile,
  APPROX_QUANTILES(stylesheets.inline, 1000)[OFFSET(percentile * 10)] AS num_inline_stylesheets_per_page,
  APPROX_QUANTILES(stylesheets.remote, 1000)[OFFSET(percentile * 10)] AS num_remote_stylesheets_per_page,
  APPROX_QUANTILES(stylesheets.inline + stylesheets.remote, 1000)[OFFSET(percentile * 10)] AS num_stylesheets_per_page,
  APPROX_QUANTILES(bytes_css, 1000)[OFFSET(percentile * 10)] AS css_bytes_per_page
FROM
  basedata
CROSS JOIN
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  report_year, percentile
ORDER BY
  report_year, percentile;
