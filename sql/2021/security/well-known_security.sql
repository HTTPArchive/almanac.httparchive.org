#standardSQL
# Prevalence of (signed) /.well-known/security.txt endpoints and prevalence of included attributes (canonical, encryption, expires, policy).
SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNTIF(has_security_txt = "true") AS count_security_txt,
  COUNTIF(has_security_txt = "true") / COUNT(DISTINCT page) AS pct_security_txt,
  COUNTIF(signed = "true") AS count_signed,
  COUNTIF(signed = "true") / COUNTIF(has_security_txt = "true") AS pct_signed,
  COUNTIF(canonical IS NOT NULL) AS canonical,
  COUNTIF(canonical IS NOT NULL) / COUNTIF(has_security_txt = "true") AS pct_canonical,
  COUNTIF(encryption IS NOT NULL) AS encryption,
  COUNTIF(encryption IS NOT NULL) / COUNTIF(has_security_txt = "true") AS pct_encryption,
  COUNTIF(expires IS NOT NULL) AS expires,
  COUNTIF(expires IS NOT NULL) / COUNTIF(has_security_txt = "true") AS pct_expires,
  COUNTIF(policy IS NOT NULL) AS policy,
  COUNTIF(policy IS NOT NULL) / COUNTIF(has_security_txt = "true") AS pct_policy
FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      url AS page,
      JSON_VALUE(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/security.txt".found') AS has_security_txt,
      JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/security.txt".data.signed') AS signed,
      JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/security.txt".data.canonical') AS canonical,
      JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/security.txt".data.encryption') AS encryption,
      JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/security.txt".data.expires') AS expires,
      JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/security.txt".data.policy') AS policy
    FROM
      `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
