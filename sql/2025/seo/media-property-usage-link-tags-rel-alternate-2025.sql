#standardSQL
# Media property usage of link tags with rel=alternate

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getMediaInfo(link_nodes JSON)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {
    if (Array.isArray(link_nodes) || typeof link_nodes != 'object') return ["NO PAYLOAD"];

    if (link_nodes && link_nodes.nodes && link_nodes.nodes.filter) {
      result = link_nodes.nodes.filter(n => n.rel && n.rel.split(' ').find(r => r.trim().toLowerCase() == 'alternate') && n.media).map(am => am.media.toLowerCase().trim().replace("d(", "d (").replace(": ", ":"));
    }

    if (result.length === 0)
        result.push("NO TAG");

} catch (e) {result.push("ERROR "+e);} // results show some issues with the validity of the payload
return result;
''';

WITH page_almanac_info AS (
  SELECT
    client,
    getMediaInfo(custom_metrics.other.almanac.`link-nodes`) AS media_property_almanac_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    DATE = '2025-07-01'
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
  total_pages
ON page_almanac_info.client = total_pages.client
GROUP BY
  total_pages.total,
  media,
  page_almanac_info.client
ORDER BY
  count DESC
LIMIT 1000
