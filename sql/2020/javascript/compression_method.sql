#standardSQL
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
  compression,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(0) AS js_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_js_requests,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_js_requests
FROM (
  SELECT
    client,
    page,
    getHeader(JSON_EXTRACT(payload, '$.response.headers'), 'Content-Encoding') AS compression
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    type = 'script')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  compression
ORDER BY
  pct_js_requests DESC
