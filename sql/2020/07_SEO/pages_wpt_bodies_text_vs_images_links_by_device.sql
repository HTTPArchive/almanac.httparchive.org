#standardSQL
# page almanac metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    image_links INT64, 
    text_links INT64 
> LANGUAGE js AS '''
var result = {};
try {
    var wpt_bodies;

    if (true) { // LIVE = true
        wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE
    }
    else 
    {
      // TEST
      wpt_bodies = {
          "anchors": {
              "rendered": {            
                  "image_links": Math.floor(Math.random() * 5),
                  "text_links": Math.floor(Math.random() * 50)
              }
          }
      }; 
    }

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.anchors && wpt_bodies.anchors.rendered) {

      result.image_links = wpt_bodies.anchors.rendered.image_links;
      result.text_links = wpt_bodies.anchors.rendered.text_links;
    }

} catch (e) {}
return result;
''';

SELECT
client,
COUNT(*) AS total, 
ROUND(AVG(wpt_bodies_info.image_links)) as image_links_avg,
ROUND(AVG(wpt_bodies_info.text_links)) as text_links_avg,

FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        #get_wpt_bodies_info('') AS wpt_bodies_info # TEST
        get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info, # LIVE       
      FROM
        #`httparchive.sample_data.pages_*` # TEST
        `httparchive.pages.2020_08_01_*` # LIVE
    )
    GROUP BY client
