#standardSQL
# 04_11b: pixel volume
CREATE TEMPORARY FUNCTION getCssPixels(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  let data = JSON.parse(payload);
  return data.reduce((a, c) => a + (c.width||0)*(c.height||0), 0) || 0;
}
catch (e) {}
return null;
''';

CREATE TEMPORARY FUNCTION getNaturalPixels(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  let data = JSON.parse(payload);
  return data.reduce((a, c) => a + (c.naturalWidth||0)*(c.naturalHeight||0), 0) || 0;
}
catch (e) {}
return null;
''';

SELECT
  client,
  count(0) as count,
  any_value(viewportHeight) viewportHeight,
  any_value(viewportWidth) viewportWidth,
  any_value(dpr) dpr,
  any_value(viewportHeight) * any_value(viewportWidth) displaypx,
  APPROX_QUANTILES(cssPixels, 1000)[OFFSET(100)] AS cssPixels_p10,
  APPROX_QUANTILES(cssPixels, 1000)[OFFSET(250)] AS cssPixels_p25,
  APPROX_QUANTILES(cssPixels, 1000)[OFFSET(500)] AS cssPixels_p50,
  APPROX_QUANTILES(cssPixels, 1000)[OFFSET(750)] AS cssPixels_p75,
  APPROX_QUANTILES(cssPixels, 1000)[OFFSET(900)] AS cssPixels_p90,
  APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(100)] AS naturalPixels_p10,
  APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(250)] AS naturalPixels_p25,
  APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(500)] AS naturalPixels_p50,
  APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(750)] AS naturalPixels_p75,
  APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(900)] AS naturalPixels_p90,
  Round(APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(100)] / (any_value(viewportHeight) * any_value(viewportWidth)), 2) AS pct_p10,
  Round(APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(250)] / (any_value(viewportHeight) * any_value(viewportWidth)), 2) AS pct_p25,
  Round(APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(500)] / (any_value(viewportHeight) * any_value(viewportWidth)), 2) AS pct_p50,
  Round(APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(750)] / (any_value(viewportHeight) * any_value(viewportWidth)), 2) AS pct_p75,
  Round(APPROX_QUANTILES(naturalPixels, 1000)[OFFSET(900)] / (any_value(viewportHeight) * any_value(viewportWidth)), 2) AS pct_p90
FROM
(
  SELECT
    _TABLE_SUFFIX AS client,
    url as page,
    getCssPixels(json_extract_scalar(payload, '$._Images')) as cssPixels,
    getNaturalPixels(json_extract_scalar(payload, '$._Images')) as naturalPixels,
    CAST(json_extract_scalar(payload, '$._smallImageCount') AS Int64) as smallImageCount,
    CAST(json_extract_scalar(payload, '$._bigImageCount') AS Int64) as bigImageCount,
    CAST(json_extract_scalar(payload, '$._image_total') AS Int64) as imageBytes,
    CAST(json_extract_scalar(json_extract_scalar(payload, '$._Dpi'), '$.dppx') AS Float64) as dpr,
    CAST(json_extract_scalar(json_extract_scalar(payload, '$._Resolution'), '$.absolute.height') AS Int64) as viewportHeight,
    CAST(json_extract_scalar(json_extract_scalar(payload, '$._Resolution'), '$.absolute.width') AS Int64) as viewportWidth
  FROM
    `httparchive.pages.2019_07_01_*`
--  LIMIT 1000
)
WHERE
  # it appears the _Images array is populated only from <img> tag requests and not CSS or favicon
  # likewise the bigImageCount and smallImageCount only track images > 100,000 and < 10,000 respectively.
  # Meaning images between 10KB and 100KB won't show up in the count
  # https://github.com/WPO-Foundation/webpagetest/blob/master/www/breakdown.inc#L95
  cssPixels > 0 AND naturalPixels > 0
  AND (smallImageCount > 0 OR bigImageCount > 0)
GROUP BY
  client
ORDER BY
  client desc