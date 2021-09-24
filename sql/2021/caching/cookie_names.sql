#standardSQL
# Popularity of top Set-Cookie names
CREATE TEMPORARY FUNCTION getCookies(headers STRING)
RETURNS ARRAY<STRING> DETERMINISTIC LANGUAGE js AS '''
try {
  var $ = JSON.parse(headers);
  return $.filter(header => {
    return header.name.toLowerCase() == 'set-cookie';
  }).map(header => {
    return header.value.split('=')[0].trim();
  });
} catch (e) {
  return [];
}
''';

SELECT
  client,
  cookie.value AS cookie,
  cookie.count AS freq,
  total,
  cookie.count / total AS pct
FROM (
  SELECT
    client,
    APPROX_TOP_COUNT(cookie, 100) AS cookies,
    COUNT(0) AS total
  FROM
    `httparchive.almanac.requests`,
    UNNEST(getCookies(response_headers)) AS cookie
  WHERE
    date = '2021-07-01'
  GROUP BY
    client),
  UNNEST(cookies) AS cookie
ORDER BY
  pct DESC
