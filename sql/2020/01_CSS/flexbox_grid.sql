#standardSQL
# flexbox and grid adoption
SELECT
  client,
  IF(feature = 'CSSFlexibleBox', 'flexbox', 'grid') AS layout,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.blink_features.features`
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2020_08_01_*` GROUP BY client)
USING
  (client)
WHERE
  yyyymmdd = '20200801' AND
  feature IN ('CSSFlexibleBox', 'CSSGridLayout')
GROUP BY
  client,
  layout,
  total