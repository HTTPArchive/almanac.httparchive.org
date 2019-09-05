#standardSQL
# 01_25: % of sites that ship sourcemaps.
SELECT
  COUNT(DISTINCT page) AS freq,
  ROUND(COUNT(DISTINCT page) * 100 /
    (SELECT COUNT(DISTINCT page) FROM `httparchive.almanac.summary_response_bodies`), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  type = 'script' AND
  body LIKE '%sourceMappingURL%' AND
  NET.REG_DOMAIN(page) = NET.REG_DOMAIN(url)