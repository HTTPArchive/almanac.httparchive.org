#standardSQL
# pages wpt_bodies metrics grouped by device and robots

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    robots ARRAY<STRING>


> LANGUAGE js AS '''
var result = {};
try {
    var wpt_bodies;

    if (false) { // LIVE = true
        wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE
    }
    else 
    {
      // TEST
      wpt_bodies = {
        "canonicals": {
            "rendered": {
                "html_link_canoncials": [
                    "https://btpi.com/"
                ]
            },
            "raw": {
                "html_link_canoncials": [
                    "https://btpi.com/"
                ]
            },
            "self_canonical": Math.floor(Math.random() * 2) == 0,
            "other_canonical": Math.floor(Math.random() * 10) == 0,
            "canonicals": [
                "https://btpi.com/"
            ],
            "url": "https://btpi.com/",
            "http_header_link_canoncials": [],
            "canonical_missmatch": Math.floor(Math.random() * 20) == 0
        },
        "robots": {
            "has_robots_meta_tag":  Math.floor(Math.random() * 3) == 0,
            "has_x_robots_tag": Math.floor(Math.random() * 20) == 0,
            "rendered": {
                "otherbot": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "googlebot": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "googlebot_news": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "google": {}
            },
            "raw": {
                "otherbot": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "googlebot": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "googlebot_news": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "google": {}
            }
        }
        }; 
    }

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.robots && wpt_bodies.robots.rendered) {

        result.robots = Object.keys(wpt_bodies.robots.rendered);
    }

} catch (e) {}
return result;
''';

SELECT
client,
robots_UA, 
total, 
COUNT(*) AS count,
AS_PERCENT(COUNT(*), total) AS pct

FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        total,
        get_wpt_bodies_info('') AS wpt_bodies_info # TEST
        #get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info, # LIVE       
      FROM
        `httparchive.sample_data.pages_*` # TEST
        #`httparchive.pages.2020_08_01_*` # LIVE
        JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total 
  FROM 
  `httparchive.sample_data.pages_*` # TEST
  #`httparchive.pages.2020_08_01_*` # LIVE
  GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
USING (_TABLE_SUFFIX)
    ), UNNEST(wpt_bodies_info.robots) as robots_UA
    GROUP BY total, robots_UA, client
