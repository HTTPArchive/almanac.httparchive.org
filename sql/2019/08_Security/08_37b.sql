#standardSQL
# 08_37b: SameSite cookie values
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
  NORMALIZE_AND_CASEFOLD(TRIM(SPLIT(directive, '=')[SAFE_OFFSET(1)])) AS value,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.requests`,
  UNNEST(SPLIT(extractHeader(payload, 'Set-Cookie'), ';')) AS directive
WHERE
  firstHtml AND
  STARTS_WITH(TRIM(directive), 'SameSite')
GROUP BY
  client,
  value
ORDER BY
  freq / total DESC