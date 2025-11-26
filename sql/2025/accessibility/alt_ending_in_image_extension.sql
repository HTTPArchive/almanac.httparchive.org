#standardSQL
-- Alt Texts Ending in File Extensions (2025-07-01)
-- Google Sheet: alt_ending_in_image_extension
-- Measures how often <img> alt attributes end in file extensions (e.g., .jpg, .png).
-- Reports both site-level adoption (what % of sites do this) and alt-level frequency
-- (what % of all non-empty alts end with extensions), broken down by client, root status,
-- and specific file extension.
CREATE TEMPORARY FUNCTION getUsedExtensions(a11y JSON)
RETURNS ARRAY<STRUCT<extension STRING, total INT64>> LANGUAGE js AS '''
try {
  return Object.entries(a11y.file_extension_alts.file_extensions).map(([extension, total]) => {
    return {extension, total};
  });
} catch (e) {
  return [];
}
''';
SELECT
  client,
  is_root_page,
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
  `httparchive.crawl.pages`,
  UNNEST(getUsedExtensions(custom_metrics.a11y)) AS extension_stat
LEFT JOIN (
  SELECT
    client,
    is_root_page,
    COUNTIF(total_non_empty_alt > 0) AS sites_with_non_empty_alt,
    COUNTIF(total_with_file_extension > 0) AS sites_with_file_extension_alt,

    SUM(total_non_empty_alt) AS total_non_empty_alts,
    SUM(total_with_file_extension) AS total_alts_with_file_extensions
  FROM (
    SELECT
      client,
      is_root_page,
      CAST(JSON_VALUE(custom_metrics.markup.images.img.alt.present) AS INT64) AS total_non_empty_alt,
      CAST(JSON_VALUE(custom_metrics.a11y.file_extension_alts.total_with_file_extension) AS INT64) AS total_with_file_extension
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-07-01'
  )
  GROUP BY
    client,
    is_root_page
) USING (client, is_root_page)
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  is_root_page,
  sites_with_non_empty_alt,
  sites_with_file_extension_alt,
  total_non_empty_alts,
  total_alts_with_file_extensions,
  extension
ORDER BY
  client,
  is_root_page,
  total_occurances DESC
