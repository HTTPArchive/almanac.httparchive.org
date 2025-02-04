#standardSQL
# 08_17: CSP 'unsafe-inline' usage
SELECT
  client,
  csp_count,
  unsafe_inline_count,
  defaultsrc_unsafe_inline_count,
  scriptsrc_unsafe_inline_count,
  stylesrc_unsafe_inline_count,
  total,
  ROUND(csp_count * 100 / total, 2) AS pct_csp,
  ROUND(unsafe_inline_count * 100 / total, 2) AS pct_unsafe_inline,
  ROUND(defaultsrc_unsafe_inline_count * 100 / total, 2) AS pct_defaultsrc_unsafe_inline,
  ROUND(scriptsrc_unsafe_inline_count * 100 / total, 2) AS pct_scriptsrc_unsafe_inline,
  ROUND(stylesrc_unsafe_inline_count * 100 / total, 2) AS pct_stylesrc_unsafe_inline
FROM (
  SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) AS csp_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'unsafe-inline')) AS unsafe_inline_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?default-src?([^,|;]+)')), 'unsafe-inline')) AS defaultsrc_unsafe_inline_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'unsafe-inline')) AS scriptsrc_unsafe_inline_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?style-src?([^,|;]+)')), 'unsafe-inline')) AS stylesrc_unsafe_inline_count
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    firstHtml
  GROUP BY
    client
)
