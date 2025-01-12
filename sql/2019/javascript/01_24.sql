#standardSQL
# 01_24: % of sites that use dynamic imports.
SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  date = '2019-07-01' AND
  type = 'script' AND
  body LIKE '%import(%' AND
  NET.REG_DOMAIN(page) = NET.REG_DOMAIN(url)
GROUP BY
  client,
  total
