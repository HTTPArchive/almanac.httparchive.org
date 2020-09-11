#standardSQL
# pages wpt_bodies metrics grouped by device and links

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    number_links INT64
> LANGUAGE js AS '''
var result = {};
try {
    var wpt_bodies = JSON.parse(wpt_bodies_string); 

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.anchors && wpt_bodies.anchors.rendered) {
      var anchors_rendered = wpt_bodies.anchors.rendered;
      result.number_links = 0;
      if (anchors_rendered.other_property) result.number_links += anchors_rendered.other_property;
      if (anchors_rendered.same_site) result.number_links += anchors_rendered.same_site;
      if (anchors_rendered.same_property) result.number_links += anchors_rendered.same_property;
    }

} catch (e) {}
return result;
''';

SELECT
client,
COUNT(0) AS total, 
wpt_bodies_info.number_links as links

FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info       
      FROM
        `httparchive.pages.2020_08_01_*`
    )
GROUP BY client, links
