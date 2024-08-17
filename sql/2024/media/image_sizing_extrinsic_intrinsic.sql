#standardSQL
# Are <img>s sized extrinsically or intrinsically (both height and width)?
# image_sizing_extrinsic_intrinsic.sql

CREATE TEMPORARY FUNCTION getImageSizing(payload STRING)
RETURNS ARRAY<STRUCT<property STRING, value STRING>>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.flatMap(({intrinsicOrExtrinsicSizing}) => ([
    {property: 'width', value: intrinsicOrExtrinsicSizing.width},
    {property: 'height', value: intrinsicOrExtrinsicSizing.height}
  ]));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  image.property,
  image.value,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, image.property) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, image.property) AS pct
FROM
  `httparchive.pages.2024_06_01_*`,
  UNNEST(getImageSizing(payload)) AS image
GROUP BY
  client,
  property,
  value
ORDER BY
  pct DESC
