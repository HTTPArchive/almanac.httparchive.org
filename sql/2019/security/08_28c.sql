#standardSQL
# 08_28c: Groupings of "feature-policy" features
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
  SPLIT(TRIM(directive), ' ')[SAFE_OFFSET(0)] AS feature,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.requests`,
  UNNEST(SPLIT(extractHeader(payload, 'Feature-Policy'), ';')) AS directive
WHERE
    date = '2019-07-01' AND
  firstHtml
GROUP BY
  client,
  feature
ORDER BY
  freq / total DESC
