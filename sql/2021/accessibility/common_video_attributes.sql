#standardSQL
# Video elements attribute usage
CREATE TEMPORARY FUNCTION getUsedAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
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
  # Of sites with video tags, how often is this attribute used
  COUNT(0) / total_sites_with_video AS pct_of_sites_using_video
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getUsedAttributes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS attribute
LEFT JOIN (
  SELECT
    client,
    COUNT(0) AS total_sites,
    COUNTIF(total_videos > 0) AS total_sites_with_video,
    COUNTIF(total_videos > 0) / COUNT(0) AS pct_sites_with_video
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.total') AS INT64) AS total_videos
    FROM
      `httparchive.pages.2021_07_01_*`
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
HAVING
  total_sites_using >= 10
ORDER BY
  pct_of_sites_using_video DESC
