#standardSQL
# The distribution of page weight by resource type and client.

# Declare variables to calculate the carbon emissions of one byte
# Source: https://sustainablewebdesign.org/calculating-digital-emissions/
# The implementation below does not make the assumptions about returning visitors or caching that are present in the Sustainable Web Design model.

DECLARE kw_per_GB NUMERIC DEFAULT 0.81;
DECLARE global_grid_intensity NUMERIC DEFAULT 442;


SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(bytesTotal / 1024, 1000)[OFFSET(percentile * 10)] AS total_kbytes,
  APPROX_QUANTILES((bytesTotal / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity, 1000)[OFFSET(percentile * 10)] AS total_emissions,
  APPROX_QUANTILES(bytesHtml / 1024, 1000)[OFFSET(percentile * 10)] AS html_kbytes,
  APPROX_QUANTILES((bytesHtml / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity, 1000)[OFFSET(percentile * 10)] AS html_emissions,
  APPROX_QUANTILES(bytesJS / 1024, 1000)[OFFSET(percentile * 10)] AS js_kbytes,
  APPROX_QUANTILES((bytesJS / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity, 1000)[OFFSET(percentile * 10)] AS js_emissions,
  APPROX_QUANTILES(bytesCSS / 1024, 1000)[OFFSET(percentile * 10)] AS css_kbytes,
  APPROX_QUANTILES((bytesCSS / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity, 1000)[OFFSET(percentile * 10)] AS css_emissions,
  APPROX_QUANTILES(bytesImg / 1024, 1000)[OFFSET(percentile * 10)] AS img_kbytes,
  APPROX_QUANTILES((bytesImg / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity, 1000)[OFFSET(percentile * 10)] AS img_emissions,
  APPROX_QUANTILES(bytesOther / 1024, 1000)[OFFSET(percentile * 10)] AS other_kbytes,
  APPROX_QUANTILES((bytesOther / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity, 1000)[OFFSET(percentile * 10)] AS other_emissions,
  APPROX_QUANTILES(bytesHtmlDoc / 1024, 1000)[OFFSET(percentile * 10)] AS html_doc_kbytes,
  APPROX_QUANTILES((bytesHtmlDoc / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity, 1000)[OFFSET(percentile * 10)] AS html_doc_emissions,
  APPROX_QUANTILES(bytesFont / 1024, 1000)[OFFSET(percentile * 10)] AS font_kbytes,
  APPROX_QUANTILES((bytesFont / 1024 / 1024 / 1024) * kw_per_GB * global_grid_intensity, 1000)[OFFSET(percentile * 10)] AS font_emissions
FROM
  `httparchive.summary_pages.2022_06_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
