#standardSQL
# Meta tag usage by name

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getMetaTagAlmanacInfo(meta_nodes JSON)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {
    if (Array.isArray(meta_nodes) || typeof meta_nodes != 'object') return [];

    if (meta_nodes && meta_nodes.nodes) {
      result = meta_nodes.nodes
        .map(am => am["name"].toLowerCase().trim()) // array of meta tag names
        .filter((v, i, a) => a.indexOf(v) === i); // remove duplicates
    }

} catch (e) {} // results show some issues with the validity of the payload
return result;
''';

WITH page_almanac_info AS (
  SELECT
    client,
    getMetaTagAlmanacInfo(custom_metrics.other.almanac.`meta-nodes`) AS meta_tag_almanac_info
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
  meta_tag_name,
  total_pages.total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), total_pages.total) AS pct
FROM
  page_almanac_info,
  UNNEST(page_almanac_info.meta_tag_almanac_info) AS meta_tag_name
JOIN
  total_pages
ON page_almanac_info.client = total_pages.client
GROUP BY
  total_pages.total,
  meta_tag_name,
  page_almanac_info.client
ORDER BY
  count DESC
LIMIT 1000
