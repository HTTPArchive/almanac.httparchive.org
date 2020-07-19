#standardSQL
# 10_05: structured data by @type
CREATE TEMPORARY FUNCTION getSchemaTypes(payload STRING)
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
  _TABLE_SUFFIX AS client,
  schema_type,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(schema_type) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getSchemaTypes(payload)) AS schema_type
GROUP BY
  client,
  schema_type
ORDER BY
  freq / total DESC