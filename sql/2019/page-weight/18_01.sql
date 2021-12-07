#standardSQL
# 18_01: Distribution of page weight by resource type and client.
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(ROUND(bytesTotal / 1024, 2), 1000)[OFFSET(percentile * 10)] AS total_kbytes,
  APPROX_QUANTILES(ROUND(bytesHtml / 1024, 2), 1000)[OFFSET(percentile * 10)] AS html_kbytes,
  APPROX_QUANTILES(ROUND(bytesJS / 1024, 2), 1000)[OFFSET(percentile * 10)] AS js_kbytes,
  APPROX_QUANTILES(ROUND(bytesCSS / 1024, 2), 1000)[OFFSET(percentile * 10)] AS css_kbytes,
  APPROX_QUANTILES(ROUND(bytesImg / 1024, 2), 1000)[OFFSET(percentile * 10)] AS img_kbytes,
  APPROX_QUANTILES(ROUND(bytesOther / 1024, 2), 1000)[OFFSET(percentile * 10)] AS other_kbytes,
  APPROX_QUANTILES(ROUND(bytesHtmlDoc / 1024, 2), 1000)[OFFSET(percentile * 10)] AS html_doc_kbytes
FROM
  `httparchive.summary_pages.2019_07_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
