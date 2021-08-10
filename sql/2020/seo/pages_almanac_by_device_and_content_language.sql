#standardSQL
# page almanac favicon image types grouped by device and type M217

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_info(almanac_string STRING)
RETURNS
 ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return ["NO PAYLOAD"];

    if (almanac && almanac["meta-nodes"] && almanac["meta-nodes"].nodes && almanac["meta-nodes"].nodes.filter) {
      result = almanac["meta-nodes"].nodes.filter(n => n["http-equiv"] && n["http-equiv"].toLowerCase().trim() == 'content-language' && n.content).map(am => am.content.toLowerCase().trim());
    }

    if (result.length === 0)
        result.push("NO TAG");

} catch (e) {result.push("ERROR "+e);} // results show some issues with the validity of the payload
return result;
''';

SELECT
  client,
  content_language,
  total,
  COUNT(0) AS count,
  AS_PERCENT(COUNT(0), total) AS pct
FROM
(
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info
  FROM
    `httparchive.pages.2020_08_01_*`
  JOIN
  (
    # to get an accurate total of pages per device. also seems fast
    SELECT _TABLE_SUFFIX, COUNT(0) AS total
    FROM
    `httparchive.pages.2020_08_01_*`

    GROUP BY _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
),
UNNEST(almanac_info) AS content_language
GROUP BY total, content_language, client
ORDER BY count DESC
LIMIT 1000
