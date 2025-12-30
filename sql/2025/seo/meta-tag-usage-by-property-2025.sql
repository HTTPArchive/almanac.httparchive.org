#standardSQL
# Meta tag usage by property


CREATE TEMPORARY FUNCTION getMetaTagPropertyInfo(meta STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
  var result = [];
  if (!meta) return result;

  try {
    if (!meta || Array.isArray(meta) || typeof meta !== 'object') return result;

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
    getMetaTagPropertyInfo(custom_metrics.other.almanac.`meta-nodes`)
      AS meta_tag_property_almanac_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
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
  p.client,
  meta_tag_property,
  t.total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), t.total) AS pct
FROM
  page_almanac_info p
CROSS JOIN
  UNNEST(p.meta_tag_property_almanac_info) AS meta_tag_property
JOIN
  total_pages t
ON
  p.client = t.client
GROUP BY
  t.total,
  meta_tag_property,
  p.client
ORDER BY
  count DESC,
  client,
  meta_tag_property
LIMIT 1000;
