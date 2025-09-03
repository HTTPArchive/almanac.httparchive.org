#standardSQL
# Meta tag usage by property

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getMetaTagAlmanacInfo(almanac_string STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {
    var almanac = JSON.parse(almanac_string);
    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac && almanac["meta-nodes"] && almanac["meta-nodes"].nodes && almanac["meta-nodes"].nodes.filter) {
      result = almanac["meta-nodes"].nodes
        .filter(n => n["property"]) // just with a property attribute
        .map(am => am["property"].toLowerCase().trim()) // array of the property values
        .filter((v, i, a) => a.indexOf(v) === i); // remove duplicates
    }

} catch (e) {} // results show some issues with the validity of the payload
return result;
''';

WITH page_almanac_info AS (
  SELECT
    client,
    getMetaTagAlmanacInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS meta_tag_almanac_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    DATE = '2025-06-01'
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
  UNNEST(page_almanac_info.meta_tag_almanac_info) AS meta_tag_property,
  total_pages
WHERE
  page_almanac_info.client = total_pages.client
GROUP BY
  total_pages.total,
  meta_tag_property,
  page_almanac_info.client
ORDER BY
  count DESC
LIMIT 1000
