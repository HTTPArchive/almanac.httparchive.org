#standardSQL
# 07_18: Percentiles of blocking JS requests
#This metric comes from Lighthouse only
CREATE TEMPORARY FUNCTION renderBlockingJS(report STRING)
RETURNS STRUCT<requests NUMERIC, bytes NUMERIC, wasted_ms NUMERIC> LANGUAGE js AS '''
try {
  var $ = JSON.parse(report);
  return $.audits['render-blocking-resources'].details.items.filter(item => {
    return item.url.toLowerCase().includes('.js');
  }).reduce((summary, item) => {
    summary.requests++;
    summary.bytes += item.totalBytes;
    summary.wasted_ms += item.wastedMs;
    return summary;
  }, {requests: 0, bytes: 0, wasted_ms: 0});;
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  APPROX_QUANTILES(render_blocking_js.requests, 1000)[OFFSET(percentile * 10)] AS requests,
  ROUND(APPROX_QUANTILES(render_blocking_js.bytes, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS kbytes,
  ROUND(APPROX_QUANTILES(render_blocking_js.wasted_ms, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS wasted_sec
FROM (
  SELECT renderBlockingJS(report) AS render_blocking_js
  FROM `httparchive.lighthouse.2019_07_01_mobile`),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
