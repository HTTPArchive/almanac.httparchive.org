#standardSQL
# Alt text ending in an image extension

# Temporary function to extract file extension statistics from the JSON payload
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

# Main query to analyze alt text usage across sites
SELECT
  client,  # Client domain
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._markup'), '$.images.img.alt.present') AS INT64) > 0) AS sites_with_non_empty_alt,  # Count sites with non-empty alt attributes
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.file_extension_alts.total_with_file_extension') AS INT64) > 0) AS sites_with_file_extension_alt,  # Count sites with alt attributes ending in a file extension
  SUM(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._markup'), '$.images.img.alt.present') AS INT64)) AS total_non_empty_alts,  # Sum of all non-empty alt attributes across sites
  SUM(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.file_extension_alts.total_with_file_extension') AS INT64)) AS total_alts_with_file_extensions,  # Sum of all alt attributes ending in a file extension

  # Percentage of sites with non-empty alt attributes that also have an alt ending in a file extension
  SAFE_DIVIDE(
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.file_extension_alts.total_with_file_extension') AS INT64) > 0),
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._markup'), '$.images.img.alt.present') AS INT64) > 0)
  ) AS pct_sites_with_file_extension_alt,

  # Percentage of all non-empty alt attributes that end in a file extension
  SAFE_DIVIDE(
    SUM(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.file_extension_alts.total_with_file_extension') AS INT64)),
    SUM(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._markup'), '$.images.img.alt.present') AS INT64))
  ) AS pct_alts_with_file_extension,

  extension_stat.extension AS extension,  # File extension used in the alt attribute
  COUNT(DISTINCT client) AS total_sites_using,  # Number of sites using this specific file extension in their alt attributes

  # Percentage of sites with non-empty alt attributes that use this specific file extension
  SAFE_DIVIDE(COUNT(DISTINCT client), COUNTIF(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._markup'), '$.images.img.alt.present') AS INT64) > 0)) AS pct_applicable_sites_using,

  # Total occurrences of this specific file extension across all alt attributes
  SUM(extension_stat.total) AS total_occurances,

  # Percentage of alt attributes ending in any file extension that end in this specific file extension
  SAFE_DIVIDE(SUM(extension_stat.total), SUM(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.file_extension_alts.total_with_file_extension') AS INT64))) AS pct_total_occurances
FROM
  `httparchive.all.pages`,  # Single table containing all the necessary data
  UNNEST(getUsedExtensions(JSON_EXTRACT_SCALAR(payload, '$._a11y'))) AS extension_stat  # Unnest the file extension statistics from the payload JSON
  WHERE
    date = '2024-06-01'
GROUP BY
  client,  # Group by client domain
  extension_stat.extension  # Group by extension to analyze specific file extensions
ORDER BY
  client,  # Order by client domain
  total_occurances DESC;  # Order by the number of occurrences of each file extension in descending order
