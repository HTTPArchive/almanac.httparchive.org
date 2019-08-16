#standardSQL
# 07_18: Percentiles of blocking JS requests
#This metric comes from Lighthouse only
CREATE TEMPORARY FUNCTION renderBlockingJS(payload STRING)
RETURNS NUMERIC LANGUAGE js AS '''
  var obj = JSON.parse(payload); 
  if (obj == null)
    return 0;
  else {
    var js = 0;
    var blkelements = JSON.parse(payload);
    for (x of blkelements) {
      if ((x.url).toLowerCase().includes(".js") == true) {
        js = js + 1;
      }
    }
    return js;
  }
''';

SELECT
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(renderBlockingJS, 1000)[OFFSET(900)] AS p90
FROM 
( 
  SELECT
    renderBlockingJS(JSON_EXTRACT(report, '$.audits.render-blocking-resources.details.items')) AS renderBlockingJS
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
