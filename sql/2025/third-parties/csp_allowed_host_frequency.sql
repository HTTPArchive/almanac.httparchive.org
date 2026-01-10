#standardSQL
# CSP on home pages: most prevalent allowed hosts

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

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2025-07-01' AND
    is_main_document
  GROUP BY
    client
),

csp_data AS (
  SELECT
    client,
    page,
    getHeader(TO_JSON_STRING(response_headers), 'Content-Security-Policy') AS csp_header
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2025-07-01' AND
    is_main_document AND
    response_headers IS NOT NULL
),

csp_expanded AS (
  SELECT
    client,
    page,
    csp_allowed_host
  FROM
    csp_data,
    UNNEST(REGEXP_EXTRACT_ALL(csp_header, r'(?i)(https*://[^\s;]+)[\s;]')) AS csp_allowed_host
  WHERE
    csp_header IS NOT NULL
),

ranked_csp AS (
  SELECT
    client,
    csp_allowed_host,
    COUNT(DISTINCT page) AS freq,
    total AS total_pages,
    COUNT(DISTINCT page) / total AS pct,
    RANK() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS csp_allowed_host_rank
  FROM
    csp_expanded
  JOIN
    totals
  USING (client)
  GROUP BY
    client,
    total,
    csp_allowed_host
)

SELECT
  client,
  csp_allowed_host,
  freq,
  total_pages,
  pct
FROM
  ranked_csp
WHERE
  csp_allowed_host_rank <= 100
ORDER BY
  client,
  pct DESC;
