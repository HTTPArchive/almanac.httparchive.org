#standardSQL
# 07_17: Percentiles of blocking CSS requests
#This metric comes from Lighthouse only
CREATE TEMPORARY FUNCTION renderBlockingCSS(report STRING)
RETURNS NUMERIC LANGUAGE js AS '''
try {
  var $ = JSON.parse(report);
  return $.audits['render-blocking-resources'].details.items.filter(item => {
    return item.url.toLowerCase().includes('.css');
  }).length;
} catch (e) {
  return null;
}
''';

SELECT
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT renderBlockingCSS(report) AS renderBlockingCSS
  FROM `httparchive.lighthouse.2019_07_01_mobile`
)
