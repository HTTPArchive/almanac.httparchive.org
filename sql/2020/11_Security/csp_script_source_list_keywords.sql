#standardSQL
# CSP: usage of default/script-src, and within the directive usage of strict-dynamic, nonce values, unsafe-inline and unsafe-eval
SELECT
  client,
  total_pages,
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
  SAFE_DIVIDE(freq_unsafe_eval, freq_default_script_src) AS pct_unsafe_eval_over_csp_with_src,
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages,
    COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy ')) AS freq_csp,
    COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy .+(default|script)-src')) AS freq_default_script_src,
    COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy .+strict-dynamic')) AS freq_strict_dynamic,
    COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy .+nonce-')) AS freq_nonce,
    COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy .+unsafe-inline')) AS freq_unsafe_inline,
    COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy .+unsafe-eval')) AS freq_unsafe_eval
  FROM
    `httparchive.summary_requests.2020_08_01_*` AS r
  WHERE
    firstHtml
  GROUP BY
    client
)
ORDER BY
  client