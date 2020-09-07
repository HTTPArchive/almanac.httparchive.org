#standardSQL
# 08_25: How often video elements use a given attribute
CREATE TEMPORARY FUNCTION getUsedAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return Object.keys(almanac.videos.attribute_usage_count);
} catch (e) {
  return [];
}
''';
SELECT
  client,
  total_sites,

  total_sites_with_video,
  pct_sites_with_video,

  attribute,
  COUNT(0) AS total_sites_using,
  ROUND(COUNT(0) * 100 / total_sites_with_video, 2) AS pct_of_sites_using_video
FROM
  `httparchive.almanac.pages_desktop_*`,
  UNNEST(getUsedAttributes(payload)) AS attribute
LEFT JOIN (
  SELECT
    client,
    COUNT(0) AS total_sites,
    COUNTIF(total_videos > 0) AS total_sites_with_video,
    ROUND(COUNTIF(total_videos > 0) * 100 / COUNT(0), 2) AS pct_sites_with_video
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._almanac"), "$.videos.total") AS INT64) AS total_videos
    FROM
      `httparchive.almanac.pages_desktop_*`
  )
  GROUP BY
    client
)
ON (_TABLE_SUFFIX = client)
GROUP BY
  client,
  attribute,
  total_sites,
  total_sites_with_video,
  pct_sites_with_video
ORDER BY
  pct_of_sites_using_video DESC
