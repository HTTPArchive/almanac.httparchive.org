#standardSQL

# <meta description> length

CREATE TEMP FUNCTION getMetaDescriptionLength(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  var description = almanac['meta-nodes'].find(meta => meta.name.toLowerCase() == 'description');
  return description && description.content.length;
} catch (e) {
  return null;
}
''';


SELECT
    APPROX_QUANTILES(getMetaDescriptionLength(payload), 1000)[OFFSET(250)] AS p25_meta_length,
    APPROX_QUANTILES(getMetaDescriptionLength(payload), 1000)[OFFSET(500)] AS median_meta_length,
    APPROX_QUANTILES(getMetaDescriptionLength(payload), 1000)[OFFSET(750)] AS p75_meta_length,
    AVG(getMetaDescriptionLength(payload)) AS avg_meta_length
FROM
    `httparchive.pages.2019_07_01_*`
