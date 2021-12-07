#standardSQL
# Share of cryptominers
SELECT
  app,
  _TABLE_SUFFIX AS client,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total_cryptominers,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.technologies.2020_08_01_*`
WHERE
  category = 'Cryptominers' OR
  category = 'Cryptominer'
GROUP BY
  client,
  app
ORDER BY
  client,
  pct DESC
