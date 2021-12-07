#standardSQL
# 18_02: Distribution of requests by resource type and client
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(reqTotal, 1000)[OFFSET(percentile * 10)] AS total_req,
  APPROX_QUANTILES(reqHtml, 1000)[OFFSET(percentile * 10)] AS html_req,
  APPROX_QUANTILES(reqJS, 1000)[OFFSET(percentile * 10)] AS js_req,
  APPROX_QUANTILES(reqCSS, 1000)[OFFSET(percentile * 10)] AS css_req,
  APPROX_QUANTILES(reqImg, 1000)[OFFSET(percentile * 10)] AS img_req,
  APPROX_QUANTILES(reqJson, 1000)[OFFSET(percentile * 10)] AS json_req,
  APPROX_QUANTILES(reqOther, 1000)[OFFSET(percentile * 10)] AS other_req
FROM
  `httparchive.summary_pages.2020_08_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
