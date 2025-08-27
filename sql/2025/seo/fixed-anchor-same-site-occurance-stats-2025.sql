#standardSQL
-- Anchor same site occurrence stats

CREATE TEMPORARY FUNCTION getLinkDesciptionsWptBodies(wpt_bodies_string STRING)
RETURNS STRUCT<
  links_same_site INT64,
  links_window_location INT64,
  links_window_open INT64,
  links_href_javascript INT64
>
LANGUAGE js AS '''
var result = {
  links_same_site: 0,
  links_window_location: 0,
  links_window_open: 0,
  links_href_javascript: 0
};
try {
  var w = JSON.parse(wpt_bodies_string);
  if (Array.isArray(w) || typeof w !== 'object') return result;

  var r = w && w.anchors && w.anchors.rendered ? w.anchors.rendered : null;
  if (!r) return result;

  // Defensive: coerce to numbers or 0
  result.links_same_site       = Number(r.same_site) || 0;
  var spd = (r.same_page && r.same_page.dynamic) ? r.same_page.dynamic : {};
  var oa  = spd.onclick_attributes || {};

  result.links_window_location = Number(oa.window_location) || 0;
  result.links_window_open     = Number(oa.window_open) || 0;
  result.links_href_javascript = Number(spd.href_javascript) || 0;
} catch (e) {}
return result;
''';

WITH same_links_info AS (
  SELECT
    client,
    root_page,
    page,
    CASE WHEN is_root_page THEN 'Homepage' ELSE 'Secondarypage' END AS is_root_page,
    -- CHANGED: read from custom_metrics.wpt_bodies (STRUCT -> JSON -> STRING)
    getLinkDesciptionsWptBodies(
      TO_JSON_STRING(JSON_QUERY(TO_JSON(custom_metrics.wpt_bodies), '$.anchors'))
    ) AS wpt_bodies_info
  FROM `httparchive.crawl.pages` TABLESAMPLE SYSTEM (0.01 PERCENT)
  WHERE date = '2025-07-01'
)

SELECT
  client,
  wpt_bodies_info.links_same_site AS links_same_site,
  is_root_page,
  COUNT(DISTINCT page) AS sites,
  SAFE_DIVIDE(COUNT(0), COUNT(DISTINCT page)) AS pct_links_same_site,
  AVG(wpt_bodies_info.links_window_location) AS avg_links_window_location,
  AVG(wpt_bodies_info.links_window_open)     AS avg_links_window_open,
  AVG(wpt_bodies_info.links_href_javascript) AS avg_links_href_javascript,
  AVG(wpt_bodies_info.links_window_location
    + wpt_bodies_info.links_window_open
    + wpt_bodies_info.links_href_javascript) AS avg_links_any,
  MAX(wpt_bodies_info.links_window_location
    + wpt_bodies_info.links_window_open
    + wpt_bodies_info.links_href_javascript) AS max_links_any,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM same_links_info
GROUP BY client, is_root_page, wpt_bodies_info.links_same_site
ORDER BY links_same_site ASC;
