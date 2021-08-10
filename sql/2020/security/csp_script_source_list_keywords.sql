#standardSQL
# CSP: usage of default/script-src, and within the directive usage of strict-dynamic, nonce values, unsafe-inline and unsafe-eval
CREATE TEMPORARY FUNCTION getHeader(headers STRING, headername STRING) -- noqa: PRS
-- SQL Linter cannot handle DETERMINISTIC keyword so needs noqa ignore command on previous line
RETURNS STRING
DETERMINISTIC
LANGUAGE js AS '''
  const parsed_headers = JSON.parse(headers);
  const matching_headers = parsed_headers.filter(h => h.name.toLowerCase() == headername.toLowerCase());
  if (matching_headers.length > 0) {
    return matching_headers[0].value;
  }
  return null;
''';
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
  SAFE_DIVIDE(freq_unsafe_eval, freq_default_script_src) AS pct_unsafe_eval_over_csp_with_src
FROM (
  SELECT
    client,
    COUNT(0) AS total_pages,
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
      getHeader(JSON_EXTRACT(payload, '$.response.headers'), 'Content-Security-Policy') AS csp_header
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = "2020-08-01" AND
      firstHtml
  )
  GROUP BY
    client
)
ORDER BY
  client
