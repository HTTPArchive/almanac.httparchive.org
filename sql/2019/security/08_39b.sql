#standardSQL
# 08_39b: SRI header
CREATE TEMPORARY FUNCTION extractHeader(payload STRING, name STRING)
RETURNS STRING LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var header = $._headers.response.find(h => h.toLowerCase().startsWith(name.toLowerCase()));
  if (!header) {
    return null;
  }
  return header.substr(header.indexOf(':') + 1).trim();
} catch (e) {
  return null;
}
''';

SELECT
  client,
  COUNTIF(requires_sri) AS pages,
  COUNT(0) AS total,
  ROUND(COUNTIF(requires_sri) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(extractHeader(payload, 'Content-Security-Policy'), '(?i)require-sri-for') AS requires_sri
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
GROUP BY
  client
