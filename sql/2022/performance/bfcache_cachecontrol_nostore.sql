CREATE TEMP FUNCTION HAS_NO_STORE_DIRECTIVE(cache_control STRING) RETURNS BOOL AS (
  REGEXP_CONTAINS(cache_control, r'(?i)\bno-store\b')
);

WITH requests AS (
  SELECT
    client,
    rank,
    LOGICAL_OR(HAS_NO_STORE_DIRECTIVE(JSON_VALUE(payload, '$._cacheControl'))) AS includes_ccns
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2022-06-01' AND
    firstHtml
  GROUP BY
    client,
    rank,
    page
)

SELECT
  client,
  _rank AS rank,
  COUNTIF(includes_ccns) AS pages,
  COUNT(0) AS total,
  COUNTIF(includes_ccns) / COUNT(0) AS pct
FROM
  requests,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS _rank
WHERE
  rank <= _rank
GROUP BY
  client,
  rank
ORDER BY
  rank,
  client
