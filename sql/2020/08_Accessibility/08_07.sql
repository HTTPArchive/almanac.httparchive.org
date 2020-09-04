#standardSQL
# 08_07: Alt text ending with an image format
CREATE TEMPORARY FUNCTION getAltImageExtensions(payload STRING)
RETURNS ARRAY<STRUCT<extension STRING, total INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var a11y = JSON.parse($._a11y);
  return Object.keys(a11y.file_extension_alts.file_extensions).map((key) => {
    return {
      extension: key,
      total: a11y.file_extension_alts.file_extensions[key]
    };
  });
} catch (e) {
  return [];
}
''';

SELECT
  a.client AS client,
  total_non_zero_alts,
  extension,
  occurances,
  ROUND((occurances / total_non_zero_alts) * 100, 4) AS pct_occurances
FROM (
  SELECT
    "desktop" AS client,
    file_extensions.extension AS extension,
    SUM(file_extensions.total) AS occurances
  FROM
    `httparchive.almanac.pages_desktop_1k`,
    UNNEST(getAltImageExtensions(payload)) AS file_extensions
  GROUP BY
    client,
    extension
) a
LEFT JOIN (
  SELECT
    "desktop" AS client,
    COUNT(0) AS total_non_zero_alts
  FROM
    `httparchive.almanac.pages_desktop_1k`,
    UNNEST(
      JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$.images.alt_lengths")
    ) AS alt_length_string
  WHERE
    alt_length_string > "0" # This string comparison will still remove all numbers less than 1
  GROUP BY
    client
) b ON a.client = b.client
