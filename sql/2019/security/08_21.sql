#standardSQL
# 08_21: CSP 'upgrade-insecure-requests' usage
SELECT
  client,
  csp_count,
  csp_upgrade_insecure_requests_count,
  total,
  ROUND(csp_count * 100 / total, 2) AS pct_csp,
  ROUND(csp_upgrade_insecure_requests_count * 100 / total, 2) AS pct_csp_upgrade_insecure_requests
FROM (
  SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(REGEXP_CONTAINS(respOtherHeaders, r'(?i)\Wcontent-security-policy =')) AS csp_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wcontent-security-policy =([^,]+)') ), 'upgrade-insecure-requests')) AS csp_upgrade_insecure_requests_count
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    firstHtml
  GROUP BY
    client)
