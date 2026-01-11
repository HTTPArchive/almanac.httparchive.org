# Query for wasm requests' count with distinct wasm origin name

WITH wasmRequests AS (
  SELECT
    client,
    page,
    CASE
      WHEN REGEXP_CONTAINS(url, r'/(hyphenopoly|patterns).*/[a-z-]{2,5}\.wasm')
        THEN '(hyphenopoly dictionary)'
      WHEN ENDS_WITH(url, '.unityweb')
        THEN '(unityweb app)'
      ELSE
        REGEXP_REPLACE(
          REGEXP_EXTRACT(LOWER(url), r'./([^./?])'), -- lowercase & extract filename between last `/` and `.` or `?`
          r'-[0-9a-f]{20,32}$', -- trim trailing hashes to transform `name-0abc43234[...]` to `name`
          ''
        )
    END AS name
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    type = 'wasm'
)

SELECT
  client,
  COUNT(0) AS total_wasm,
  COUNT(DISTINCT NET.REG_DOMAIN(page)) AS distinct_origin
FROM
  wasmRequests
GROUP BY
  client
ORDER BY
  client
