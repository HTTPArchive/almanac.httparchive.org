# standardSQL
# The number of requests of each unique wasm module, ordered by module popularity.

SELECT
  client,
  CASE
    WHEN REGEXP_CONTAINS(url, r'/(hyphenopoly|patterns).*/[a-z-]{2,5}\.wasm')
      THEN '(hyphenopoly dictionary)'
    WHEN ENDS_WITH(url, '.unityweb')
      THEN '(unityweb app)'
    ELSE
      REGEXP_REPLACE(
        REGEXP_EXTRACT(LOWER(url), r'.*/([^./?]*)'), -- lowercase & extract filename between last `/` and `.` or `?`
        r'-[0-9a-f]{20,32}$', -- trim trailing hashes to transform `name-0abc43234[...]` to `name`
        ''
      )
  END AS name,
  COUNT(0) AS count,
  COUNT(DISTINCT NET.REG_DOMAIN(url)) AS count_serving_hosts
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  (mimeType = 'application/wasm' OR ext = 'wasm')
GROUP BY
  client,
  name
ORDER BY
  count DESC
