#standardSQL
SELECT
  LEFT(_TABLE_SUFFIX, 10) AS month,
  IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client,
  COUNT(0) AS freq
FROM
  `httparchive.technologies.*`
WHERE
  category = 'Cryptominers'
  OR category = 'Cryptominer'
GROUP BY
  _TABLE_SUFFIX
ORDER BY
  client,
  month,
  freq DESC
