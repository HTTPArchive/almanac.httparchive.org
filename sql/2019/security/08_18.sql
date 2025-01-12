#standardSQL
# 08_18: CSP 'unsafe-eval' usage
SELECT
  client,
  csp_count,
  unsafe_eval_count,
  defaultsrc_unsafe_eval_count,
  scriptsrc_unsafe_eval_count,
  stylesrc_unsafe_eval_count,
  total,
  ROUND(csp_count * 100 / total, 2) AS pct_csp,
  ROUND(unsafe_eval_count * 100 / total, 2) AS pct_unsafe_eval,
  ROUND(defaultsrc_unsafe_eval_count * 100 / total, 2) AS pct_defaultsrc_unsafe_eval,
  ROUND(scriptsrc_unsafe_eval_count * 100 / total, 2) AS pct_scriptsrc_unsafe_eval,
  ROUND(stylesrc_unsafe_eval_count * 100 / total, 2) AS pct_stylesrc_unsafe_eval
FROM (
  SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) AS csp_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'unsafe-eval')) AS unsafe_eval_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?default-src?([^,|;]+)')), 'unsafe-eval')) AS defaultsrc_unsafe_eval_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'unsafe-eval')) AS scriptsrc_unsafe_eval_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?style-src?([^,|;]+)')), 'unsafe-eval')) AS stylesrc_unsafe_eval_count
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    firstHtml
  GROUP BY
    client
)
