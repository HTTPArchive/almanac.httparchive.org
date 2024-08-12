#standardSQL
# Section: Well-known URIs - securityt.txt
# Question: What is the prevalence of (signed) /.well-known/security.txt endpoints and prevalence of included attributes (canonical, encryption, expires, policy)?
# Note: Query is huge (60TB)
# Note: Each directive is saved as a list, however, currently we only check whether the directive exist at all or not and do not check the content
# Note: all_required_exist = contact & expires are mandatory; only_one_requirement_broken = expires & preferred_languages are not allowed to occur multiple times; valid = all_required_exist && !only_one_requirement_broken
# Note: We do not use status and content-type directly at the moment; Found is true if the final status code after a potential redirection is 200
SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNTIF(has_security_txt = 'true') AS count_security_txt,
  COUNTIF(has_security_txt = 'true') / COUNT(DISTINCT page) AS pct_security_txt,
  COUNTIF(redirected = 'true') AS count_redirected_all,
  COUNTIF(redirected = 'true') / COUNT(DISTINCT page) AS pct_redirected_all,
  COUNTIF(valid = 'true') AS count_valid,
  COUNTIF(valid = 'true') / COUNTIF(has_security_txt = 'true') AS pct_valid,
  COUNTIF(all_required_exist = 'true') AS count_all_required_exist,
  COUNTIF(all_required_exist = 'true') / COUNTIF(has_security_txt = 'true') AS pct_all_required_exist,
  COUNTIF(only_one_requirement_broken = 'true') AS count_only_one_requirement_broken,
  COUNTIF(only_one_requirement_broken = 'true') / COUNTIF(has_security_txt = 'true') AS pct_only_one_requirement_broken,
  # Individual values
  COUNTIF(signed = 'true') AS count_signed,
  COUNTIF(signed = 'true') / COUNTIF(has_security_txt = 'true') AS pct_signed,
  COUNTIF(contact IS NOT NULL) AS contact,
  COUNTIF(contact IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_contact,  
  COUNTIF(expires IS NOT NULL) AS expires,
  COUNTIF(expires IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_expires, 
  COUNTIF(encryption IS NOT NULL) AS encryption,
  COUNTIF(encryption IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_encryption, 
  COUNTIF(acknowledgements IS NOT NULL) AS acknowlegements,
  COUNTIF(acknowledgements IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_acknowledgements,
  COUNTIF(preferred_languages IS NOT NULL) AS preferred_languages,
  COUNTIF(preferred_languages IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_preferred_languages,
  COUNTIF(canonical IS NOT NULL) AS canonical,
  COUNTIF(canonical IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_canonical,
  COUNTIF(policy IS NOT NULL) AS policy,
  COUNTIF(policy IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_policy,
  COUNTIF(hiring IS NOT NULL) AS hiring,
  COUNTIF(hiring IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_hiring,
  COUNTIF(csaf IS NOT NULL) AS csaf,
  COUNTIF(csaf IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_csaf,
  COUNTIF(other IS NOT NULL) AS other,
  COUNTIF(other IS NOT NULL) / COUNTIF(has_security_txt = 'true') AS pct_other,
  COUNTIF(other IS NOT NULL AND valid = 'true') AS other_valid,
  COUNTIF(other IS NOT NULL AND valid = 'true') / COUNTIF(valid = 'true') AS pct_other_valid
FROM (
    SELECT
      client,
      page,
      JSON_VALUE(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".found') AS has_security_txt,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.redirected') AS redirected,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.status') AS status,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.content_type') AS content_type,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.valid') AS valid,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.all_required_exist') AS all_required_exist,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.only_one_requirement_broken') AS only_one_requirement_broken,
      # Individual values
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.signed') AS signed,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.contact') AS contact,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.expires') AS expires,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.encryption') AS encryption,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.acknowledgements') AS acknowledgements,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.preferred_languages') AS preferred_languages,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.canonical') AS canonical,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.policy') AS policy,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.hiring') AS hiring,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.csaf') AS csaf,
      JSON_QUERY(JSON_VALUE(custom_metrics, '$._well-known'), '$."/.well-known/security.txt".data.other') AS other,

    FROM
      `httparchive.all.pages`
    WHERE
      date = '2024-06-01'
      AND is_root_page
)
GROUP BY
  client
