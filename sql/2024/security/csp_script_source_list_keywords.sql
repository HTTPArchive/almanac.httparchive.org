#standardSQL
# Section: Attack preventions - Preventing attacks using CSP
# Question: usage of default/script-src, and within the directive usage of strict-dynamic, nonce values, unsafe-inline and unsafe-eval
SELECT
  client,
  total_pages_with_csp,
  freq_csp,
  freq_default_script_src,
  SAFE_DIVIDE(freq_default_script_src, freq_csp) AS pct_default_script_src_over_csp,
  freq_strict_dynamic,
  SAFE_DIVIDE(freq_strict_dynamic, freq_csp) AS pct_strict_dynamic_over_csp,
  SAFE_DIVIDE(freq_strict_dynamic, freq_default_script_src) AS pct_strict_dynamic_over_csp_with_src,
  freq_nonce,
  SAFE_DIVIDE(freq_nonce, freq_csp) AS pct_nonce_over_csp,
  SAFE_DIVIDE(freq_nonce, freq_default_script_src) AS pct_nonce_over_csp_with_src,
  freq_unsafe_inline,
  SAFE_DIVIDE(freq_unsafe_inline, freq_csp) AS pct_unsafe_inline_over_csp,
  SAFE_DIVIDE(freq_unsafe_inline, freq_default_script_src) AS pct_unsafe_inline_over_csp_with_src,
  freq_unsafe_eval,
  SAFE_DIVIDE(freq_unsafe_eval, freq_csp) AS pct_unsafe_eval_over_csp,
  SAFE_DIVIDE(freq_unsafe_eval, freq_default_script_src) AS pct_unsafe_eval_over_csp_with_src
FROM (
  SELECT
    client,
    COUNT(0) AS total_pages_with_csp,
    COUNTIF(csp_header IS NOT NULL) AS freq_csp,
    COUNTIF(REGEXP_CONTAINS(csp_header, '(?i)(default|script)-src')) AS freq_default_script_src,
    COUNTIF(REGEXP_CONTAINS(csp_header, '(?i)(default|script)-src[^;]+strict-dynamic')) AS freq_strict_dynamic,
    COUNTIF(REGEXP_CONTAINS(csp_header, '(?i)(default|script)-src[^;]+nonce-')) AS freq_nonce,
    COUNTIF(REGEXP_CONTAINS(csp_header, '(?i)(default|script)-src[^;]+unsafe-inline')) AS freq_script_unsafe_inline,
    COUNTIF(REGEXP_CONTAINS(csp_header, '(?i)(default|script)-src[^;]+unsafe-eval')) AS freq_script_unsafe_eval,
    COUNTIF(REGEXP_CONTAINS(csp_header, '(?i)unsafe-inline')) AS freq_unsafe_inline,
    COUNTIF(REGEXP_CONTAINS(csp_header, '(?i)unsafe-eval')) AS freq_unsafe_eval
  FROM (
    SELECT
      client,
      response_headers.value AS csp_header
    FROM
      `httparchive.all.requests`,
      UNNEST(response_headers) AS response_headers
    WHERE
      date = '2024-06-01' AND
      is_root_page AND
      is_main_document AND
      LOWER(response_headers.name) = 'content-security-policy')
  GROUP BY
    client)
ORDER BY
  client
