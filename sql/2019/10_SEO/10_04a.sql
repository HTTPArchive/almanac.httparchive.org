#standardSQL

# has hreflang

SELECT
  has_hreflang,
  has_hreflang / total AS pct
FROM (
  SELECT
    COUNTIF(REGEXP_CONTAINS(body, '(?i)<link[^>]*hreflang')) AS has_hreflang,
    COUNT(0) AS total
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    firstHtml
)
