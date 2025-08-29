#standardSQL
# Meta tag usage by property


CREATE TEMPORARY FUNCTION getMetaTagPropertyAlmanacInfo(almanac_json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
  var result = [];
  if (!almanac_json) return result;

  try {
    var almanac = JSON.parse(almanac_json);
    if (!almanac || Array.isArray(almanac) || typeof almanac !== 'object') return result;

    var meta = almanac["meta-nodes"];
    if (meta && meta.nodes && Array.isArray(meta.nodes)) {
      // collect, normalize, and de-duplicate per page
      var seen = new Set();
      for (var i=0; i<meta.nodes.length; i++) {
        var am = meta.nodes[i] || {};
        var prop = (am["property"] || "").toString().toLowerCase().trim();
        if (prop) seen.add(prop);
      }
      result = Array.from(seen);
    }
  } catch (e) {
    // swallow and return []
  }
  return result;
''';

WITH page_almanac_info AS (
  SELECT
    client,
    -- ✅ 2) Pass STRING into the UDF
    getMetaTagPropertyAlmanacInfo(TO_JSON_STRING(custom_metrics.other.almanac))
      AS meta_tag_property_almanac_info
  FROM `httparchive.crawl.pages` 
  WHERE date = '2025-07-01'
),

total_pages AS (
  SELECT
    client,
    COUNT(*) AS total
  FROM page_almanac_info
  GROUP BY client
)

SELECT
  p.client,
  meta_tag_property,
  t.total,
  COUNT(*) AS count,
  SAFE_DIVIDE(COUNT(*), t.total) AS pct
FROM page_almanac_info p
CROSS JOIN UNNEST(p.meta_tag_property_almanac_info) AS meta_tag_property
JOIN total_pages t
  ON p.client = t.client
GROUP BY
  t.total, meta_tag_property, p.client
ORDER BY count DESC
LIMIT 1000;
