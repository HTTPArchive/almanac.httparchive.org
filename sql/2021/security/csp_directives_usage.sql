#standardSQL
# CSP on home pages: popularity of different directives
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

SELECT
  client,
  directive,
  COUNT(0) AS total_csp_headers,
  COUNTIF(REGEXP_CONTAINS(CONCAT(' ', csp_header, ' '), CONCAT(r'(?i)\W', directive, r'\W'))) AS num_with_directive,
  COUNTIF(REGEXP_CONTAINS(CONCAT(' ', csp_header, ' '), CONCAT(r'(?i)\W', directive, r'\W'))) / COUNT(0) AS pct_with_directive
FROM (
  SELECT
    client,
    getHeader(response_headers, 'Content-Security-Policy') AS csp_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml
),
  UNNEST(['child-src', 'connect-src', 'default-src', 'font-src', 'frame-src', 'img-src', 'manifest-src', 'media-src', 'object-src', 'prefetch-src', 'script-src', 'script-src-elem', 'script-src-attr', 'style-src', 'style-src-elem', 'style-src-attr', 'worker-src', 'base-uri', 'plugin-types', 'sandbox', 'form-action', 'frame-ancestors', 'navigate-to', 'report-uri', 'report-to', 'block-all-mixed-content', 'referrer', 'require-sri-for', 'require-trusted-types-for', 'trusted-types', 'upgrade-insecure-requests']) AS directive
WHERE
  csp_header IS NOT NULL
GROUP BY
  client,
  directive
ORDER BY
  client,
  pct_with_directive DESC
