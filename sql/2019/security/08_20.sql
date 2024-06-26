#standardSQL
# 08_20: CSP 'trusted-types' usage
SELECT
  client,
  csp_report_only_count,
  csp_trusted_type_count,
  csp_report_only_trusted_type_count,
  total,
  ROUND(csp_report_only_count * 100 / total, 2) AS pct_csp_report_only,
  ROUND(csp_trusted_type_count * 100 / total, 2) AS pct_csp_trusted_type,
  ROUND(csp_trusted_type_count * 100 / total, 2) AS pct_csp_report_only_trusted_type
FROM (
  SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(REGEXP_CONTAINS(respOtherHeaders, r'(?i)\Wcontent-security-policy-report-only =')) AS csp_report_only_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wcontent-security-policy =([^,]+)')), 'trusted-types')) AS csp_trusted_type_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wcontent-security-policy-report-only =([^,]+)')), 'trusted-types')) AS csp_report_only_trusted_type_count
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    firstHtml
  GROUP BY
    client
)
