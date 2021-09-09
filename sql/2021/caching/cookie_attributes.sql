CREATE TEMPORARY FUNCTION getCookieAttributes(headers STRING) RETURNS ARRAY<STRING> DETERMINISTIC LANGUAGE js AS '''
try {
  var $ = JSON.parse(headers);
  return $.filter(header => {
    return header.name.toLowerCase() == 'set-cookie';
  }).flatMap(header => {
    return header.value.split(';').slice(1).map(attr => {
      return attr.trim().split('=')[0].trim();
    });
  });
} catch (e) {
  return [];
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
    APPROX_TOP_COUNT(attr, 100) AS attrs,
    COUNT(0) AS total
  FROM
    `httparchive.almanac.requests`,
    UNNEST(getCookieAttributes(response_headers)) AS attr
  WHERE
    date = '2021-07-01'
  GROUP BY
    client),
  UNNEST(attrs) AS attr
ORDER BY
  pct DESC
