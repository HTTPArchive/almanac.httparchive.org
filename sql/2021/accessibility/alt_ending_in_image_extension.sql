#standardSQL
# Alt text ending in an image extension
CREATE TEMPORARY FUNCTION getUsedExtensions(payload STRING)
RETURNS ARRAY<STRUCT<extension STRING, total INT64>> LANGUAGE js AS '''
try {
  const a11y = JSON.parse(payload);

  return Object.entries(a11y.file_extension_alts.file_extensions).map(([extension, total]) => {
    return {extension, total};
  });
} catch (e) {
  return [];
}
''';
SELECT
  client,
  sites_with_non_empty_alt,
  sites_with_file_extension_alt,
  total_alts_with_file_extensions,

  # Of sites with a non-empty alt, what % have an alt with a file extension
  sites_with_file_extension_alt / sites_with_non_empty_alt AS pct_sites_with_file_extension_alt,
  # Given a random alt, how often will it end in a file extension
  total_alts_with_file_extensions / total_non_empty_alts AS pct_alts_with_file_extension,

  extension_stat.extension AS extension,
  COUNT(0) AS total_sites_using,
  # Of sites with a non-empty alt, what % have an alt with this file extension
  COUNT(0) / sites_with_non_empty_alt AS pct_applicable_sites_using,

  # Of sites with a non-empty alt, what % have an alt with this file extension
  SUM(extension_stat.total) AS total_occurances,
  # Given a random alt ending in a file extension, how often will it end in this file extension
  SUM(extension_stat.total) / total_alts_with_file_extensions AS pct_total_occurances
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getUsedExtensions(JSON_EXTRACT_SCALAR(payload, '$._a11y'))) AS extension_stat
LEFT JOIN (
  SELECT
    client,
    COUNTIF(total_non_empty_alt > 0) AS sites_with_non_empty_alt,
    COUNTIF(total_with_file_extension > 0) AS sites_with_file_extension_alt,

    SUM(total_non_empty_alt) AS total_non_empty_alts,
    SUM(total_with_file_extension) AS total_alts_with_file_extensions
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._markup'), '$.images.img.alt.present') AS INT64) AS total_non_empty_alt,
      CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.file_extension_alts.total_with_file_extension') AS INT64) AS total_with_file_extension
    FROM
      `httparchive.pages.2021_07_01_*`
  )
  GROUP BY
    client
)
ON (_TABLE_SUFFIX = client)
GROUP BY
  client,
  sites_with_non_empty_alt,
  sites_with_file_extension_alt,
  total_non_empty_alts,
  total_alts_with_file_extensions,
  extension
ORDER BY
  client,
  total_occurances DESC
