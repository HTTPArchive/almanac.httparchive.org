#standardSQL
# Anchor same site occurrence stats
# This query aims to highlight sites with few same-site links, like SPAs.

CREATE TEMPORARY FUNCTION getLinkDesciptionsWptBodies(wpt_bodies_string STRING)
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
  var wpt_bodies = JSON.parse(wpt_bodies_string);

  if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

  if (wpt_bodies.anchors && wpt_bodies.anchors.rendered) {
      var anchors_rendered = wpt_bodies.anchors.rendered;

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
    getLinkDesciptionsWptBodies(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)

SELECT
  client,
  wpt_bodies_info.links_same_site AS links_same_site,
  is_root_page,
  COUNT(DISTINCT page) AS sites, -- Counting all occurrences of links_same_site
  SAFE_DIVIDE(COUNT(0), COUNT(DISTINCT page)) AS pct_links_same_site,  -- Percentage of same-site links
  AVG(wpt_bodies_info.links_window_location) AS avg_links_window_location,
  AVG(wpt_bodies_info.links_window_open) AS avg_links_window_open,
  AVG(wpt_bodies_info.links_href_javascript) AS avg_links_href_javascript,
  AVG(wpt_bodies_info.links_window_location + wpt_bodies_info.links_window_open + wpt_bodies_info.links_href_javascript) AS avg_links_any,
  MAX(wpt_bodies_info.links_window_location + wpt_bodies_info.links_window_open + wpt_bodies_info.links_href_javascript) AS max_links_any,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct -- Secondary page percentage within group
FROM
  same_links_info
GROUP BY
  client,
  is_root_page,
  wpt_bodies_info.links_same_site
ORDER BY
  links_same_site ASC;
