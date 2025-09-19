#standardSQL
# Section: Well-known URIs - securityt.txt
# Question: What is the prevalence of (signed) /.well-known/security.txt endpoints and prevalence of included attributes (canonical, encryption, expires, policy)?
# Note: Query is huge (60TB) and computationally expensive (slow)
# Note: We require that the final status code for /.well-known/security.txt is 200 (found) and that the content-type starts with text/plain. This can lead to a very small number of false negatives but is much better than false positives using other approaches
# Note: all_required_exist = contact & expires are mandatory; only_one_requirement_broken = expires & preferred_languages are not allowed to occur multiple times; valid = all_required_exist && !only_one_requirement_broken
# Note: The custom metric only has an entry for a directive if it is not empty, thus we can assume that a non-null value cannot be an empty list
# Note: Each directive (except signed) is saved as a list, however currently we do not really check the content
WITH
security_txt_data AS (
  SELECT
    client,
    page,
    # Bools
    LAX_BOOL(TO_JSON(JSON_VALUE(sec_txt, '$.found'))) AS found,
    LAX_BOOL(TO_JSON(JSON_VALUE(sec_txt, '$.data.redirected'))) AS redirected,
    LAX_BOOL(TO_JSON(JSON_VALUE(sec_txt, '$.data.valid'))) AS valid,
    LAX_BOOL(TO_JSON(JSON_VALUE(sec_txt, '$.data.all_required_exist'))) AS all_required_exist,
    LAX_BOOL(TO_JSON(JSON_VALUE(sec_txt, '$.data.only_one_requirement_broken'))) AS only_one_requirement_broken,
    # Meta Info
    JSON_VALUE(sec_txt, '$.data.status') AS status,
    JSON_VALUE(sec_txt, '$.data.content_type') AS content_type,
    # Directives
    LAX_BOOL(TO_JSON(JSON_VALUE(sec_txt, '$.data.signed'))) AS signed,
    JSON_VALUE_ARRAY(sec_txt, '$.data.contact') AS contact,
    JSON_VALUE_ARRAY(sec_txt, '$.data.expires') AS expires,
    JSON_VALUE_ARRAY(sec_txt, '$.data.encryption') AS encryption,
    JSON_VALUE_ARRAY(sec_txt, '$.data.acknowledgments') AS acknowledgments,
    JSON_VALUE_ARRAY(sec_txt, '$.data.preferred_languages') AS preferred_languages,
    JSON_VALUE_ARRAY(sec_txt, '$.data.canonical') AS canonical,
    JSON_VALUE_ARRAY(sec_txt, '$.data.policy') AS POLICY,
    JSON_VALUE_ARRAY(sec_txt, '$.data.hiring') AS hiring,
    JSON_VALUE_ARRAY(sec_txt, '$.data.csaf') AS csaf,
    # Other has a structure of [("key": value)] and thus needs QUERY_ARRAY
    JSON_QUERY_ARRAY(sec_txt, '$.data.other') AS other
  FROM (
    SELECT
      client,
      page,
      JSON_QUERY(custom_metrics.well_known, '$."/.well-known/security.txt"') AS sec_txt
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-07-01' AND
      is_root_page
  # AND rank <= 1000
  )
),

totals AS (
  SELECT
    client,
    # High Level stats
    COUNT(DISTINCT page) AS total_pages,
    # Request to .well-known/security.txt failed or did not even start
    COUNTIF(found IS NULL) AS count_failed,
    # Found == final status code is 200
    COUNTIF(found) AS count_found,
    COUNTIF(found) / COUNT(DISTINCT page) AS pct_found,
    # Redirected == response redirected at least once
    COUNTIF(redirected) AS count_redirected_all,
    COUNTIF(redirected) / COUNT(DISTINCT page) AS pct_redirected_all,
    # Redirected found == response redirected and final status code is 200 (some redirect and then answer with 500 or 426; Note that some also use a redirect status code such as 307 but as there is no location header, do not actually redirect)
    COUNTIF(redirected AND found) AS count_redirected_found
  FROM
    security_txt_data
  GROUP BY
    client
)

SELECT
  client,
  # High Level stats for all pages
  total_pages,
  count_failed,
  count_found,
  pct_found,
  count_redirected_all,
  pct_redirected_all,
  count_redirected_found,

  # High level stats on real security.txt files (i.e., found + content-type startswith text/plain)
  # Real security.txt files
  COUNT(0) AS has_security_txt,
  COUNT(0) / total_pages AS pct_security_txt,
  # Redirected and real security.txt file
  COUNTIF(redirected) AS count_redirected_security_txt,
  # Redirected valid == response redirected, final status code is 200 and file is a "valid" security.txt file
  COUNTIF(redirected AND valid) AS count_redirected_valid,
  # Valid == all_required_exist && !only_one_requirement_broken
  COUNTIF(valid) AS count_valid,
  COUNTIF(valid) / COUNT(0) AS pct_valid,
  # All required exist == expires && contact
  COUNTIF(all_required_exist) AS count_all_required_exist,
  COUNTIF(all_required_exist) / COUNT(0) AS pct_all_required_exist,
  # Only one requriement broken == expires & preferred_languages are not allowed to occur multiple times
  COUNTIF(only_one_requirement_broken) AS count_only_one_requirement_broken,
  COUNTIF(only_one_requirement_broken) / COUNT(0) AS pct_only_one_requirement_broken,

  # Individual values
  COUNTIF(signed) AS count_signed,
  COUNTIF(signed) / COUNT(0) AS pct_signed,
  COUNTIF(contact IS NOT NULL) AS contact,
  COUNTIF(contact IS NOT NULL) / COUNT(0) AS pct_contact,
  COUNTIF(expires IS NOT NULL) AS expires,
  COUNTIF(expires IS NOT NULL) / COUNT(0) AS pct_expires,
  COUNTIF(encryption IS NOT NULL) AS encryption,
  COUNTIF(encryption IS NOT NULL) / COUNT(0) AS pct_encryption,
  COUNTIF(acknowledgments IS NOT NULL) AS acknowlegments,
  COUNTIF(acknowledgments IS NOT NULL) / COUNT(0) AS pct_acknowledgments,
  COUNTIF(preferred_languages IS NOT NULL) AS preferred_languages,
  COUNTIF(preferred_languages IS NOT NULL) / COUNT(0) AS pct_preferred_languages,
  COUNTIF(canonical IS NOT NULL) AS canonical,
  COUNTIF(canonical IS NOT NULL) / COUNT(0) AS pct_canonical,
  COUNTIF(POLICY IS NOT NULL) AS POLICY,
  COUNTIF(POLICY IS NOT NULL) / COUNT(0) AS pct_policy,
  COUNTIF(hiring IS NOT NULL) AS hiring,
  COUNTIF(hiring IS NOT NULL) / COUNT(0) AS pct_hiring,
  COUNTIF(csaf IS NOT NULL) AS csaf,
  COUNTIF(csaf IS NOT NULL) / COUNT(0) AS pct_csaf,
  COUNTIF(other IS NOT NULL) AS other,
  COUNTIF(other IS NOT NULL) / COUNT(0) AS pct_other,

  # Other values relative to only valid files (as other can be garbage if the file is not actually a security.txt file)
  COUNTIF(
    other IS NOT NULL AND
    valid
  ) AS other_valid,
  COUNTIF(
    other IS NOT NULL AND
    valid
  ) / COUNTIF(valid
  ) AS pct_other_valid,

  # Average counts of directives (only non-null values are counted; i.e., min is 1, might be better to count the average of all "found" files, i.e., including 0) (COALASCE 0)
  AVG(ARRAY_LENGTH(contact)) AS avg_contact_count,
  AVG(ARRAY_LENGTH(expires)) AS avg_expires_count,
  AVG(ARRAY_LENGTH(encryption)) AS avg_encryption_count,
  AVG(ARRAY_LENGTH(acknowledgments)) AS avg_acknowledgments_count,
  AVG(ARRAY_LENGTH(preferred_languages)) AS avg_preferred_language_count,
  AVG(ARRAY_LENGTH(canonical)) AS avg_canonical_count,
  AVG(ARRAY_LENGTH(policy)) AS avg_policy_count,
  AVG(ARRAY_LENGTH(hiring)) AS avg_hiring_count,
  AVG(ARRAY_LENGTH(csaf)) AS avg_csaf_count,
  AVG(ARRAY_LENGTH(other)) AS avg_other_count
FROM
  security_txt_data
JOIN totals USING (client)
WHERE
  found AND
  STARTS_WITH(content_type, 'text/plain')
GROUP BY
  client,
  total_pages,
  count_failed,
  count_found,
  pct_found,
  count_redirected_all,
  pct_redirected_all,
  count_redirected_found

