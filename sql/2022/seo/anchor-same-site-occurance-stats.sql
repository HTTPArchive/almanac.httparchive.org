#standardSQL
# Anchor same site occurance stats
# this query aims to highlight sites with few same site links, like SPAs

# TODO: this query may tell a better story if we use quantiles for links_same_site as that would allow us to truly compare low-a-linking sites verse high-a-linking sites.

CREATE TEMPORARY FUNCTION getLinkDesciptionsWptBodies(wpt_bodies_string STRING)
RETURNS STRUCT<
  links_same_site INT64,
  links_window_location INT64,
  links_window_open INT64,
  links_href_javascript INT64

> LANGUAGE js AS '''
var result = {};
try {
  var wpt_bodies = JSON.parse(wpt_bodies_string);

  if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

  if (wpt_bodies.anchors && wpt_bodies.anchors.rendered) {
      var anchors_rendered = wpt_bodies.anchors.rendered;

      result.links_same_site = anchors_rendered.same_site;
      result.links_window_location = anchors_rendered.same_page.dynamic.onclick_attributes.window_location;
      result.links_window_open = anchors_rendered.same_page.dynamic.onclick_attributes.window_open;
      result.links_href_javascript = anchors_rendered.same_page.dynamic.href_javascript;

    }

} catch (e) {}
return result;
''';

SELECT
  client,

  wpt_bodies_info.links_same_site AS links_same_site,

  COUNT(0) AS pages,

  SAFE_DIVIDE(COUNT(0), total) AS pct_links_same_site,

  AVG(wpt_bodies_info.links_window_location) AS avg_links_window_location,
  AVG(wpt_bodies_info.links_window_open) AS avg_links_window_open,
  AVG(wpt_bodies_info.links_href_javascript) AS avg_links_href_javascript,
  AVG(wpt_bodies_info.links_window_location + wpt_bodies_info.links_window_open + wpt_bodies_info.links_href_javascript) AS avg_links_any,
  MAX(wpt_bodies_info.links_window_location + wpt_bodies_info.links_window_open + wpt_bodies_info.links_href_javascript) AS max_links_any
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    getLinkDesciptionsWptBodies(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
  JOIN (

    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2022_07_01_*` -- noqa: CV09
    GROUP BY
      _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
)
GROUP BY
  client,
  links_same_site,
  total
ORDER BY
  links_same_site ASC
LIMIT 100
