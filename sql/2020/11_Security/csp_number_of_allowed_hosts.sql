#standardSQL
# CSP on home pages: number of unique headers, header length and number of allowed hosts in all directives
CREATE TEMPORARY FUNCTION getHeader(headers STRING, headername STRING)
  RETURNS STRING DETERMINISTIC
  LANGUAGE js AS '''
  const parsed_headers = JSON.parse(headers);
  const matching_headers = parsed_headers.filter(h => h.name.toLowerCase() == headername.toLowerCase());
  if (matching_headers.length > 0) {
    return matching_headers[0].value;
  }
  return null;
''';
CREATE TEMP FUNCTION array_unique(arr ANY TYPE) AS (
  (SELECT ARRAY_AGG(DISTINCT x) FROM UNNEST(arr) as x)
);

SELECT
  client,
  percentile,
  COUNT(0) AS total,
  COUNTIF(csp_header IS NOT NULL) AS num_csp_headers,
  COUNTIF(csp_header IS NOT NULL) / COUNT(0) AS pct_csp_headers,
  COUNT(DISTINCT csp_header) AS num_unique_csp_headers,
  APPROX_QUANTILES(LENGTH(csp_header), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS csp_header_length,
  APPROX_QUANTILES(ARRAY_LENGTH(array_unique(REGEXP_EXTRACT_ALL(csp_header, r'(?i)\W(https*://[^\s;]+)[\s;]'))), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS unique_allowed_hosts,
FROM (
  SELECT
    client,
    getHeader(JSON_EXTRACT(payload, '$.response.headers'), 'Content-Security-Policy') AS csp_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = "2020-08-01" AND firstHtml
   ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
