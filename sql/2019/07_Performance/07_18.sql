#standardSQL
# 07_18: Percentiles of blocking JS requests
#This metric comes from Lighthouse only
CREATE TEMPORARY FUNCTION renderBlockingJS(report STRING)
RETURNS NUMERIC LANGUAGE js AS '''
try {
  var $ = JSON.parse(report);
  return $.audits['render-blocking-resources'].details.items.filter(item => {
    return item.url.toLowerCase().includes('.js');
  }).length;
} catch (e) {
  return null;
}
''';

SELECT
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT renderBlockingJS(report) AS renderBlockingJS
  FROM `httparchive.lighthouse.2019_07_01_mobile`
)
