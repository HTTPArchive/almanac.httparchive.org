#standardSQL
# Media property usage of link tags with rel=alternate

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getMediaPropertyAlmanacInfo(almanac_string STRING)
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
  SAFE_DIVIDE(COUNT(0), total) AS pct
FROM
  (
    SELECT
      _TABLE_SUFFIX AS client,
      total,
      getMediaPropertyAlmanacInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS media_property_almanac_info
    FROM
      `httparchive.pages.2021_07_01_*`
    JOIN
      (

        SELECT _TABLE_SUFFIX, COUNT(0) AS total
        FROM
          `httparchive.pages.2021_07_01_*`
        GROUP BY _TABLE_SUFFIX
      )
    USING (_TABLE_SUFFIX)
  ),
  UNNEST(media_property_almanac_info) AS media
GROUP BY
  total,
  media,
  client
ORDER BY
  count DESC
LIMIT 1000
