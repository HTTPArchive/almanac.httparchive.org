#standardSQL
# Section: Attack preventions - Preventing attacks using CSP
# Question: Which are the most common CSP directives on home pages?
SELECT
  client,
  directive,
  COUNT(0) AS total_csp_headers,
  COUNTIF(REGEXP_CONTAINS(CONCAT(' ', csp_header, ' '), CONCAT(r'(?i)\W', directive, r'\W'))) AS num_with_directive,
  COUNTIF(REGEXP_CONTAINS(CONCAT(' ', csp_header, ' '), CONCAT(r'(?i)\W', directive, r'\W'))) / COUNT(0) AS pct_with_directive
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
    LOWER(response_headers.name) = 'content-security-policy'),
  UNNEST(['child-src', 'connect-src', 'default-src', 'font-src', 'frame-src', 'img-src', 'manifest-src', 'media-src', 'object-src', 'prefetch-src', 'script-src', 'script-src-elem', 'script-src-attr', 'style-src', 'style-src-elem', 'style-src-attr', 'worker-src', 'base-uri', 'plugin-types', 'sandbox', 'form-action', 'frame-ancestors', 'navigate-to', 'report-uri', 'report-to', 'block-all-mixed-content', 'referrer', 'require-sri-for', 'require-trusted-types-for', 'trusted-types', 'upgrade-insecure-requests', 'input-protection']) AS directive
WHERE
  csp_header IS NOT NULL
GROUP BY
  client,
  directive
ORDER BY
  client,
  pct_with_directive DESC
