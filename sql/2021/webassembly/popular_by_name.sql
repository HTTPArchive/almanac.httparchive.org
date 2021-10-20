SELECT
  client,
  CASE
    WHEN REGEXP_CONTAINS(url, r'/(hyphenopoly|patterns).*/[a-z-]{2,5}\.wasm') THEN '(hyphenopoly dictionary)'
    WHEN ENDS_WITH(url, '.unityweb') THEN '(unityweb app)'
    ELSE
      REGEXP_REPLACE(REGEXP_EXTRACT(LOWER(url), r'.*/([^./?]*)'), r'-\b[0-9a-f]{20,32}\b\.', '.')
  END
  AS name,
  COUNT(0) AS count,
  COUNT(DISTINCT filename) AS count_versions,
  COUNT(DISTINCT NET.REG_DOMAIN(url)) AS count_serving_hosts,
  MIN(url) AS url
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client,
  name
ORDER BY
  count DESC
