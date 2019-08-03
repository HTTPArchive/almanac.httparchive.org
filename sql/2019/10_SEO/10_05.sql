#standardSQL

# ld+json, microformatting, schema.org + what @type
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
    ROUND(COUNT(flattened_105) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.pages.2019_07_01_desktop`
CROSS JOIN
    UNNEST(parseStructuredData(payload)) as flattened_105
GROUP BY flattened_105
ORDER BY occurence DESC
