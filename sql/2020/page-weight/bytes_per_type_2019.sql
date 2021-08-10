#standardSQL
# 18_01b: Distribution of page weight by resource type and client (2019).
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(bytesTotal / 1024, 1000)[OFFSET(percentile * 10)] AS total_kbytes,
  APPROX_QUANTILES(bytesHtml / 1024, 1000)[OFFSET(percentile * 10)] AS html_kbytes,
  APPROX_QUANTILES(bytesJS / 1024, 1000)[OFFSET(percentile * 10)] AS js_kbytes,
  APPROX_QUANTILES(bytesCSS / 1024, 1000)[OFFSET(percentile * 10)] AS css_kbytes,
  APPROX_QUANTILES(bytesImg / 1024, 1000)[OFFSET(percentile * 10)] AS img_kbytes,
  APPROX_QUANTILES(bytesOther / 1024, 1000)[OFFSET(percentile * 10)] AS other_kbytes,
  APPROX_QUANTILES(bytesHtmlDoc / 1024, 1000)[OFFSET(percentile * 10)] AS html_doc_kbytes
FROM
  `httparchive.summary_pages.2019_07_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
