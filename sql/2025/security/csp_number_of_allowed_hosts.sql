#standardSQL
# Section: Attack Preventions - Preventing attacks using CSP
# Question: CSP on home pages: number of unique headers, header length and number of allowed HTTP(S) hosts in all directives
# Note: for CSP we checked whether the header value is NULL (empty?) (99.65% of CSP headers are not NULL on desktop), we did not do this for other headers?
CREATE TEMP FUNCTION getNumUniqueHosts(str STRING) AS (
  (SELECT COUNT(DISTINCT x) FROM UNNEST(REGEXP_EXTRACT_ALL(str, r'(?i)(https*://[^\s;]+)[\s;]')) AS x)
);

SELECT
  client,
  percentile,
  COUNT(0) AS total_csp_headers,
  COUNTIF(csp_header IS NOT NULL) AS total_non_null_csp_headers,
  COUNTIF(csp_header IS NOT NULL) / COUNT(0) AS pct_csp_headers,
  COUNT(DISTINCT csp_header) AS num_unique_csp_headers,
  APPROX_QUANTILES(LENGTH(csp_header), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS csp_header_length,
  APPROX_QUANTILES(getNumUniqueHosts(csp_header), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS unique_allowed_hosts
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
    LOWER(response_headers.name) = 'content-security-policy'
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
