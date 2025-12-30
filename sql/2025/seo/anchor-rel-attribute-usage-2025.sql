#standardSQL
# Anchor rel attribute usage
# This query reports if a rel attribute value was ever used on a page, and calculates various statistics.

CREATE TEMPORARY FUNCTION getRelStatsWptBodies(wpt_bodies JSON)
RETURNS STRUCT<
  rel ARRAY<STRING>
> LANGUAGE js AS '''
var result = {rel: []};
// Function to retrieve only keys if value is >0
function getKey(dict){
  const arr = [],
        obj = Object.keys(dict);
  for (var x in obj){
    if(dict[obj[x]] > 0){
      arr.push(obj[x]);
    }
  }
  return arr;
}
try {
    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;
    if (wpt_bodies.anchors && wpt_bodies.anchors.rendered && wpt_bodies.anchors.rendered.rel_attributes) {
      result.rel = getKey(wpt_bodies.anchors.rendered.rel_attributes);
    }
} catch (e) {}
return result;
''';

WITH rel_stats_table AS (
  SELECT
    client,
    root_page,
    page,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END
      AS is_root_page,
    getRelStatsWptBodies(custom_metrics.wpt_bodies) AS wpt_bodies_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  rel,
  COUNT(DISTINCT page) AS sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM
  rel_stats_table,
  UNNEST(wpt_bodies_info.rel) AS rel
GROUP BY
  client,
  is_root_page,
  rel
ORDER BY
  sites DESC,
  rel,
  client DESC;
