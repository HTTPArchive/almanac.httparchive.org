#standardSQL
# 01_24: % of sites that use dynamic imports.
SELECT
  COUNT(DISTINCT page) AS freq,
  ROUND(COUNT(DISTINCT page) * 100 / (SELECT COUNT(DISTINCT page) FROM `httparchive.almanac.summary_response_bodies`), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  type = 'script' AND
  body LIKE '%import(%' AND
  NET.REG_DOMAIN(page) = NET.REG_DOMAIN(url)