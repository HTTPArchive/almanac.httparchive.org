#standardSQL

# ld+json, microformatting, schema.org + what @type
# dataset: `httparchive.pages.2019_07_01_desktop`
# sample: `httparchive.almanac.pages_desktop_1k`
# todo: occurence_perc + cleanup array (e.g. remove // ?), or manually group + sum :)
# note: also see 10.01

CREATE TEMPORARY FUNCTION parseStructuredData(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return Array.from(almanac['10.5']);
  } catch (e) {
    return [];
  }
''';

SELECT
    flattened_105,
    COUNT(flattened_105) AS occurence,
    COUNT(flattened_105) / COUNT(url) AS occurence_perc
FROM
    `httparchive.almanac.pages_desktop_1k`
CROSS JOIN
    UNNEST(parseStructuredData(payload)) as flattened_105
GROUP BY flattened_105
ORDER BY occurence DESC
