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

WITH page_almanac_info AS (
  SELECT
    client,
    getMediaPropertyAlmanacInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS media_property_almanac_info
  FROM
    `httparchive.all.pages`
  WHERE
    DATE = '2024-06-01'
),
total_pages AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    page_almanac_info
  GROUP BY
    client
)

SELECT
  page_almanac_info.client,
  media,
  total_pages.total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), total_pages.total) AS pct
FROM
  page_almanac_info,
  UNNEST(page_almanac_info.media_property_almanac_info) AS media
JOIN
  total_pages ON page_almanac_info.client = total_pages.client
GROUP BY
  total_pages.total,
  media,
  page_almanac_info.client
ORDER BY
  count DESC
LIMIT 1000
