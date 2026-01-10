#standardSQL
-- Anchor same site occurrence stats

CREATE TEMPORARY FUNCTION getLinkDesciptions(anchors JSON)
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
  if (Array.isArray(anchors) || typeof anchors !== 'object') return result;

  var r = anchors && anchors.rendered ? anchors.rendered : null;
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
    getLinkDesciptions(custom_metrics.wpt_bodies.anchors) AS anchors_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  anchors_info.links_same_site AS links_same_site,
  is_root_page,
  COUNT(DISTINCT page) AS sites,
  SAFE_DIVIDE(COUNT(0), COUNT(DISTINCT page)) AS pct_links_same_site,
  AVG(anchors_info.links_window_location) AS avg_links_window_location,
  AVG(anchors_info.links_window_open) AS avg_links_window_open,
  AVG(anchors_info.links_href_javascript) AS avg_links_href_javascript,
  AVG(
    anchors_info.links_window_location +
    anchors_info.links_window_open +
    anchors_info.links_href_javascript
  ) AS avg_links_any,
  MAX(
    anchors_info.links_window_location +
    anchors_info.links_window_open +
    anchors_info.links_href_javascript
  ) AS max_links_any,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM
  same_links_info
GROUP BY
  client,
  is_root_page,
  anchors_info.links_same_site
ORDER BY
  links_same_site ASC;
