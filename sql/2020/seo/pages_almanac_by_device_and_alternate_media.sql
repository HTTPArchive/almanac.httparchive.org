#standardSQL
# page almanac favicon image types grouped by device and type M217

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_info(almanac_string STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return ["NO PAYLOAD"];

    if (almanac && almanac["link-nodes"] && almanac["link-nodes"].nodes && almanac["link-nodes"].nodes.filter) {
      result = almanac["link-nodes"].nodes.filter(n => n.rel && n.rel.split(' ').find(r => r.trim().toLowerCase() == 'alternate') && n.media).map(am => am.media.toLowerCase().trim().replace("d(", "d (").replace(": ", ":"));
    }

    if (result.length === 0)
        result.push("NO TAG");

} catch (e) {result.push("ERROR "+e);} // results show some issues with the validity of the payload
return result;
''';

SELECT
  client,
  media,
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
  UNNEST(almanac_info) AS media
GROUP BY total, media, client
ORDER BY count DESC
LIMIT 1000
