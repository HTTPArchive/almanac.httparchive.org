#standardSQL
# Anchor same site occurrence stats
# This query aims to highlight sites with few same-site links, like SPAs.

CREATE TEMPORARY FUNCTION getLinkDesciptionsWptBodies(anchors JSON)
RETURNS STRUCT<
  links_same_site INT64,
  links_window_location INT64,
  links_window_open INT64,
  links_href_javascript INT64
> LANGUAGE js AS '''
var result = {
  links_same_site: 0,
  links_window_location: 0,
  links_window_open: 0,
  links_href_javascript: 0
};
try {
  if (Array.isArray(anchors) || typeof anchors != 'object') return result;

  if (anchors && anchors.rendered) {
      var anchors_rendered = anchors.rendered;

      result.links_same_site = anchors_rendered.same_site || 0;
      result.links_window_location = anchors_rendered.same_page.dynamic.onclick_attributes.window_location || 0;
      result.links_window_open = anchors_rendered.same_page.dynamic.onclick_attributes.window_open || 0;
      result.links_href_javascript = anchors_rendered.same_page.dynamic.href_javascript || 0;
  }

} catch (e) {}
return result;
''';

WITH same_links_info AS (
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
    getLinkDesciptionsWptBodies(custom_metrics.wpt_bodies.anchors) AS anchors_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  anchors_info.links_same_site AS links_same_site,
  is_root_page,
  COUNT(DISTINCT page) AS sites, -- Counting all occurrences of links_same_site
  SAFE_DIVIDE(COUNT(0), COUNT(DISTINCT page)) AS pct_links_same_site,  -- Percentage of same-site links
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
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct -- Secondary page percentage within group
FROM
  same_links_info
GROUP BY
  client,
  is_root_page,
  anchors_info.links_same_site
ORDER BY
  links_same_site ASC;
