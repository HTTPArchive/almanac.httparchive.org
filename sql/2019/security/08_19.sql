#standardSQL
# 08_19: CSP 'strict-dynamic' usage
SELECT
  client,
  csp_count,
  strict_dynamic_count,
  scriptsrc_strict_dynamic_count,
  defaultsrc_strict_dynamic_count,
  total,
  ROUND(csp_count * 100 / total, 2) AS pct_csp,
  ROUND(strict_dynamic_count * 100 / total, 2) AS pct_strict_dynamic,
  ROUND(scriptsrc_strict_dynamic_count * 100 / total, 2) AS pct_scriptsrc_strict_dynamic,
  ROUND(defaultsrc_strict_dynamic_count * 100 / total, 2) AS pct_defaultsrc_strict_dynamic
FROM (
  SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) AS csp_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(respOtherHeaders), 'strict-dynamic')) AS strict_dynamic_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'strict-dynamic')) AS scriptsrc_strict_dynamic_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?default-src?([^,|;]+)')), 'strict-dynamic')) AS defaultsrc_strict_dynamic_count
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    firstHtml
  GROUP BY
    client)
