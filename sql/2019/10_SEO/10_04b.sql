#standardSQL

# hreflang implementation values

SELECT
  hreflang,
  COUNT(hreflang) AS occurence,
  ROUND(COUNT(hreflang) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
  `httparchive.almanac.summary_response_bodies`
CROSS JOIN
  UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<link[^>]*hreflang=[\'"]?([^(\'|"|\\s)]+)')) as hreflang
GROUP BY hreflang
ORDER BY occurence DESC
