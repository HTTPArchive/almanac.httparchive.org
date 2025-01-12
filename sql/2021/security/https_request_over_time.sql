#standardSQL
SELECT
  SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  SUM(IF(STARTS_WITH(request, 'https'), 1, 0)) / COUNT(0) AS percent
FROM (SELECT url AS request, page AS url, _TABLE_SUFFIX AS _TABLE_SUFFIX FROM `httparchive.requests.*`)
GROUP BY
  date,
  client
ORDER BY
  date DESC,
  client
