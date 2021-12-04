#standardSQL
# flexbox and grid adoption
SELECT
  SUBSTR(yyyymmdd, 0, 4) AS year,
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
  yyyymmdd IN ('20200801', '20190701') AND
  feature IN ('CSSFlexibleBox', 'CSSGridLayout')
GROUP BY
  year,
  client,
  layout,
  total
