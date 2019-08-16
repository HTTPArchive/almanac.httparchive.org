#standardSQL
# 07_17: Percentiles of blocking CSS requests
#This metric comes from Lighthouse only
CREATE TEMPORARY FUNCTION renderBlockingCSS(payload STRING)
RETURNS NUMERIC LANGUAGE js AS '''
  var obj = JSON.parse(payload); 
  if (obj == null)
    return 0;
  else {
    var css = 0;
    var blkelements = JSON.parse(payload);
    for (x of blkelements) {
      if ((x.url).toLowerCase().includes(".css") == true) {
        css = css + 1;
      }
    }
    return css;
  }
''';

SELECT
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(renderBlockingCSS, 1000)[OFFSET(900)] AS p90
FROM 
( 
  SELECT
    renderBlockingCSS(JSON_EXTRACT(report, '$.audits.render-blocking-resources.details.items')) AS renderBlockingCSS
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`    
)
