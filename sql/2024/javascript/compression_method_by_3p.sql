#standardSQL
CREATE TEMPORARY FUNCTION getHeader(headers STRING, headername STRING)
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
  host,
  compression,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(0) AS js_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client, host) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, host) AS pct
FROM (
  SELECT
    client,
    page,
    IF(NET.HOST(url) IN (
      SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2024-06-01' AND category != 'hosting'
    ), 'third party', 'first party') AS host,
    getHeader(JSON_EXTRACT(payload, '$.response.headers'), 'Content-Encoding') AS compression
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'script'
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2024_06_01_*`
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  host,
  compression
ORDER BY
  pct DESC
