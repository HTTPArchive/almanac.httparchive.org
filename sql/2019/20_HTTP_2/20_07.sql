#standardSQL
# 20.07 - % of sites affected by CDN prioritization issues (H2 and served by CDN)
SELECT 
  client,
  IF(pages.cdn = "", "Not using CDN", pages.cdn) AS CDN,
  IF(prioritization_status IS NOT null, prioritization_status, "Unknown") prioritizes_correctly,
  COUNT(*) AS num_pages,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM 
  (
    SELECT 
      _TABLE_SUFFIX AS client,
      url,
      JSON_EXTRACT_SCALAR(payload, "$._cdn_provider") as cdn
    FROM 
      `httparchive.requests.2019_07_01_*` 
    WHERE 
      JSON_EXTRACT_SCALAR(payload, "$._protocol") ="HTTP/2"
      AND JSON_EXTRACT_SCALAR(payload, "$._is_base_page") = "true"
  ) AS pages
LEFT JOIN 
  `httparchive.almanac.h2_prioritization_cdns_201909` AS h2_pri
ON pages.cdn = h2_pri.cdn
GROUP BY
  client,
  CDN,
  prioritizes_correctly
ORDER BY num_pages DESC
