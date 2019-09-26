#standardSQL
# 04_06: Pages with source[sizes]
SELECT
  client,
  COUNTIF(has_source_sizes) AS has_source_sizes,
  COUNT(0) AS total,
  ROUND(COUNTIF(has_source_sizes) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, r'(?i)<source[^>]*sizes=[\'"]?([^\'"]*)') AS has_source_sizes
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    firstHtml)
GROUP BY
  client