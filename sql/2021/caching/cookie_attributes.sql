#standardSQL
# Popularity of top Set-Cookie attributes/directives
CREATE TEMPORARY FUNCTION getCookieAttributes(headers STRING)
RETURNS ARRAY<STRING> DETERMINISTIC LANGUAGE js AS '''
try {
  var $ = JSON.parse(headers);
  return $.filter(header => {
    return header.name.toLowerCase() == 'set-cookie';
  }).flatMap(header => {
    return Array.from(new Set(header.value.split(';').slice(1).map(attr => {
      return attr.trim().split('=')[0].trim();
    })));
  });
} catch (e) {
  return [];
}
''';

CREATE TEMPORARY FUNCTION countCookies(headers STRING)
RETURNS INT64 DETERMINISTIC LANGUAGE js AS '''
try {
  var $ = JSON.parse(headers);
  return $.filter(header => {
    return header.name.toLowerCase() == 'set-cookie';
  }).length;
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  attr.value AS attr,
  attr.count AS freq,
  total,
  attr.count / total AS pct
FROM (
  SELECT
    client,
    APPROX_TOP_COUNT(attr, 100) AS attrs
  FROM
    `httparchive.almanac.requests`,
    UNNEST(getCookieAttributes(response_headers)) AS attr
  WHERE
    date = '2021-07-01'
  GROUP BY
    client
)
JOIN (
  SELECT
    client,
    SUM(countCookies(response_headers)) AS total
  FROM
    `httparchive.almanac.requests`
  GROUP BY
    client
)
USING (client),
  UNNEST(attrs) AS attr
ORDER BY
  pct DESC
