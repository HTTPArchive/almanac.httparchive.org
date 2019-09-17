#standardSQL
# 08_38: Cookie prefixes
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
  prefix,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.requests`,
  UNNEST(SPLIT(extractHeader(payload, 'Set-Cookie'), ';')) AS directive,
  UNNEST(REGEXP_EXTRACT_ALL(directive, '(__Host-|__Secure-)')) AS prefix
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  firstHtml AND
  prefix IS NOT NULL
GROUP BY
  client,
  total,
  prefix
ORDER BY
  pages / total DESC