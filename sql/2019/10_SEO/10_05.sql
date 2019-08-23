#standardSQL

# structured data by @type

CREATE TEMPORARY FUNCTION parseStructuredData(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return almanac['10.5'].map(element => {
        // strip any @context
        var split = element.split('/');
        return split[split.length - 1];
    });
  } catch (e) {
    return [];
  }
''';

SELECT
    schema_type,
    COUNT(schema_type) AS occurence,
    ROUND(COUNT(schema_type) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.pages.2019_07_01_*`
CROSS JOIN
    UNNEST(parseStructuredData(payload)) AS schema_type
GROUP BY schema_type
ORDER BY occurence DESC
LIMIT 100
