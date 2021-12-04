#standardSQL
SELECT
  LEFT(_TABLE_SUFFIX, 10) AS month,
  IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client,
  COUNTIF(category = 'Cryptominers' OR category = 'Cryptominer') AS freq,
  COUNT(0) AS total,
  COUNTIF(category = 'Cryptominers' OR category = 'Cryptominer') / COUNT(0) AS pct
FROM
  `httparchive.technologies.*`
GROUP BY
  _TABLE_SUFFIX
ORDER BY
  client,
  month,
  pct DESC
