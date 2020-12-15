#standardSQL
# images with covid in path - average size
SELECT
  client,
  LOWER(ext) AS ext,
  COUNT(0) AS ext_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(url), r'[^/]*?[:]//[^/]*?/.*?covid')) as ext_count_covid,
  SAFE_DIVIDE(sum(respSize), COUNT(0)) as avg_size,
  SAFE_DIVIDE(sum(if(REGEXP_CONTAINS(LOWER(url), r'[^/]*?[:]//[^/]*?/.*?covid'), respSize, 0)), COUNTIF(REGEXP_CONTAINS(LOWER(url), r'[^/]*?[:]//[^/]*?/.*?covid'))) AS avg_size_covid
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01' and
  type = 'image'
GROUP BY
  client,
  ext
HAVING
  ext_count_covid > 100
ORDER BY
  client,
  ext_count_covid DESC;

