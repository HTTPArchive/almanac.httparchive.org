#standardSQL
# 04_09b: Top Client Hints
CREATE TEMPORARY FUNCTION getClientHintsHeader(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var header = $._headers.response.find(h => h.toLowerCase().startsWith('accept-ch'));
  if (!header) {
    return null;
  }
  var value = header.substr(header.indexOf(':') + 1).trim();
  return value.split(',');
} catch (e) {
  return null;
}
''';

CREATE TEMP FUNCTION getClientHintsMeta(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  var meta = almanac['meta-nodes'].find(meta => meta['http-equiv'].toLowerCase() == 'accept-ch');
  return meta && meta.content && meta.content.split(',');
} catch (e) {
  return null;
}
''';

SELECT
  client,
  LOWER(TRIM(hint)) AS hint,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM (
  SELECT
    client,
    hint
  FROM
    `httparchive.almanac.requests`,
    UNNEST(getClientHintsHeader(payload)) AS hint
  WHERE
    firstHtml
UNION ALL
  SELECT
    _TABLE_SUFFIX AS client,
    hint
  FROM
    `httparchive.pages.2019_07_01_*`,
    UNNEST(getClientHintsMeta(payload)) AS hint)
GROUP BY
  client,
  hint
ORDER BY
  freq / total DESC