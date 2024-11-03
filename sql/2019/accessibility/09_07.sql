#standardSQL
# 09_07: % of pages having a captions track when necessary
# Caveat: This does not necessarily enforce that the track is within the media element.
CREATE TEMPORARY FUNCTION getMediaElements(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return [];
  var mediaElements = new Set(['audio', 'video', 'track']);
  return Object.keys(elements).filter(e => mediaElements.has(e));
} catch (e) {
  return [];
}
''';

SELECT
  client,
  COUNTIF('track' IN UNNEST(media_elements)) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF('track' IN UNNEST(media_elements)) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getMediaElements(payload) AS media_elements
  FROM
    `httparchive.pages.2019_07_01_*`
)
WHERE
  'audio' IN UNNEST(media_elements) OR
  'video' IN UNNEST(media_elements)
GROUP BY
  client
