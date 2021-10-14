#standardSQL
# % of sites with empty alt tags
CREATE TEMPORARY FUNCTION getAltStats(payload STRING)
RETURNS STRUCT<has_alts BOOL, has_alt_of_zero_length BOOL> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  const alt_lengths = almanac.images.alt_lengths;

  return {
    has_alts: alt_lengths.filter(l => l >= 0).length > 0,
    has_alt_of_zero_length: alt_lengths.indexOf(0) >= 0,
  };
} catch (e) {
  return {
    has_alts: false,
    has_alt_of_zero_length: false,
  };
}
''';

SELECT
  client,
  COUNTIF(alt_stats.has_alts) AS total_sites_with_alts,
  COUNTIF(alt_stats.has_alt_of_zero_length) AS total_sites_with_zero_length_alt,

  COUNTIF(alt_stats.has_alt_of_zero_length) / COUNTIF(alt_stats.has_alts) AS perc_sites_with_zero_length_alt
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getAltStats(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS alt_stats
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
