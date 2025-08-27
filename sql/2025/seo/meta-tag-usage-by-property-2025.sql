#standardSQL
# Meta tag usage by property

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getMetaTagPropertyAlmanacInfo(almanac_json JSON)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {
    var almanac = almanac_json;

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac && almanac["meta-nodes"] && almanac["meta-nodes"].nodes) {
      result = almanac["meta-nodes"].nodes
        .map(am => am["property"].toLowerCase().trim()) // array of meta tag properties
        .filter((v, i, a) => a.indexOf(v) === i); // remove duplicates
    }

} catch (e) {} // results show some issues with the validity of the payload
return result;
''';

WITH page_almanac_info AS (
  SELECT
    client,
    getMetaTagPropertyAlmanacInfo(TO_JSON(custom_metrics.other.almanac)) AS meta_tag_property_almanac_info
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
  meta_tag_property,
  total_pages.total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), total_pages.total) AS pct
FROM
  page_almanac_info,
  UNNEST(page_almanac_info.meta_tag_property_almanac_info) AS meta_tag_property
JOIN
  total_pages
ON page_almanac_info.client = total_pages.client
GROUP BY
  total_pages.total,
  meta_tag_property,
  page_almanac_info.client
ORDER BY
  count DESC
LIMIT 1000
