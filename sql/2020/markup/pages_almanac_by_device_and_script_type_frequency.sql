#standardSQL
# pages almanac metrics grouped by device and element attribute use (frequency)

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION get_almanac_attribute_info(almanac_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac.scripts && almanac.scripts.nodes && almanac.scripts.nodes.map) {
      return almanac.scripts.nodes.map(n => {if (n.type) return n.type.toLowerCase().trim(); else return "NOT_SET"; });
    }

} catch (e) {

}
return [];
''';

SELECT
  _TABLE_SUFFIX AS client,
  type_name,
  COUNT(0) AS freq,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(get_almanac_attribute_info(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS type_name
GROUP BY
  client,
  type_name
HAVING
  freq > 1000
ORDER BY
  freq DESC,
  client
