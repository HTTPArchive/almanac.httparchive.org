#standardSQL
# Audio elements attribute usage
CREATE TEMPORARY FUNCTION getUsedAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.audios.attribute_usage_count);
} catch (e) {
  return [];
}
''';
SELECT
  client,
  total_sites,

  total_sites_with_audio,
  pct_sites_with_audio,

  attribute,
  COUNT(0) AS total_sites_using,
  # Of sites with audio tags, how often is this attribute used
  COUNT(0) / total_sites_with_audio AS pct_of_sites_using_audio
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getUsedAttributes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS attribute
LEFT JOIN (
  SELECT
    client,
    COUNT(0) AS total_sites,
    COUNTIF(total_audios > 0) AS total_sites_with_audio,
    COUNTIF(total_audios > 0) / COUNT(0) AS pct_sites_with_audio
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.audios.total') AS INT64) AS total_audios
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
  total_sites_with_audio,
  pct_sites_with_audio
HAVING
  total_sites_using >= 10
ORDER BY
  pct_of_sites_using_audio DESC
