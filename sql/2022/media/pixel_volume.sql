#standardSQL
# pixel areas

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
  percentile,
  client,
  ANY_VALUE(viewport_height) AS viewport_height,
  ANY_VALUE(viewport_width) AS viewport_width,
  ANY_VALUE(dpr) AS dpr,
  ANY_VALUE(viewport_height) * ANY_VALUE(viewport_width) AS display_px,
  APPROX_QUANTILES(css_pixels, 1000)[OFFSET(percentile * 10)] AS css_pixels,
  APPROX_QUANTILES(natural_pixels, 1000)[OFFSET(percentile * 10)] AS natural_pixels,
  APPROX_QUANTILES(natural_pixels, 1000)[OFFSET(percentile * 10)] / (ANY_VALUE(viewport_height) * ANY_VALUE(viewport_width)) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getCssPixels(JSON_EXTRACT_SCALAR(payload, '$._Images')) AS css_pixels,
    getNaturalPixels(JSON_EXTRACT_SCALAR(payload, '$._Images')) AS natural_pixels,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._Dpi'), '$.dppx') AS FLOAT64) AS dpr,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._Resolution'), '$.absolute.height') AS FLOAT64) AS viewport_height,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._Resolution'), '$.absolute.width') AS FLOAT64) AS viewport_width
  FROM
    `httparchive.pages.2022_06_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  # it appears the _Images array is populated only from <img> tag requests and not CSS or favicon
  # likewise the bigImageCount and smallImageCount only track images > 100,000 and < 10,000 respectively.
  # Meaning images between 10KB and 100KB won't show up in the count
  # https://github.com/WPO-Foundation/webpagetest/blob/master/www/breakdown.inc#L95
  css_pixels > 0 AND
  natural_pixels > 0
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
