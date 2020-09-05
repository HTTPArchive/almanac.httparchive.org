#standardSQL
# page almanac metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    has_raw_canonical BOOL,
    has_rendered_canonical BOOL, 
    has_both_canonicals BOOL


> LANGUAGE js AS '''
var result = {};
try {
    //var wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE

    // TEST
    var wpt_bodies = {
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
      },
      "title": {
        "rendered": {
            "primary": {
                "characters": 55,
                "words": Math.floor(Math.random() * 20),
                "text": "Headsets, Wireless Plantronics Headset Distributor, BTP"
            },
            "total": 2
        },
        "raw": {
            "primary": {
                "characters": 55,
                "words": 6,
                "text": "Headsets, Wireless Plantronics Headset Distributor, BTP"
            },
            "total": 2
        },
        "title_changed_on_render": false
      }
    }; 

if (Math.floor(Math.random() * 50) == 0) {
        wpt_bodies.canonicals.canonicals = []; // sometimes no canonicals
    }
    if (Math.floor(Math.random() * 30) == 0) {
        wpt_bodies.canonicals.raw = {}; // sometimes no raw canonicals
    }
    if (Math.floor(Math.random() * 25) == 0) {
        wpt_bodies.canonicals.rendered.html_link_canoncials = ["https://someoneelse.com/"]; // sometimes rendering changes it
    }
    if (Math.floor(Math.random() * 60) == 0) {
        wpt_bodies.canonicals.http_header_link_canoncials = ["https://someoneelse.com/"]; // sometimes header exists
    }



    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.canonicals) {

      if (wpt_bodies.canonicals.rendered.html_link_canoncials.length) {
        result.has_rendered_canonical = true;
      } else {
        result.has_rendered_canonical = false;
      }

      if (wpt_bodies.canonicals.raw.html_link_canoncials.length) {
        result.has_raw_canonical = true;
      } else {
        result.has_raw_canonical = false;
      }

       if (wpt_bodies.canonicals.raw.html_link_canoncials.length && wpt_bodies.canonicals.rendered.html_link_canoncials.length ) {
        result.has_both_canonicals = true;
      } else {
        result.has_both_canonicals = false;
      }
    }

} catch (e) {}
return result;
''';

SELECT
client,
COUNT(*) AS total, 

# RAW Canonical
# COUNTIF(wpt_bodies_info.robots_has_raw_canonical) AS freq_has_raw_canonical,
AS_PERCENT(COUNTIF(wpt_bodies_info.has_raw_canonical), COUNT(0)) AS pct_has_raw_canonical,

# Rendered Canonical
# COUNTIF(wpt_bodies_info.robots_has_rendered_canonical) AS freq_has_rendered_canonical,
AS_PERCENT(COUNTIF(wpt_bodies_info.has_rendered_canonical), COUNT(0)) AS pct_has_rendered_canonical,

# Both Canonicals
# COUNTIF(wpt_bodies_info.robots_has_both_canonicals) AS freq_has_both_canonicals,
AS_PERCENT(COUNTIF(wpt_bodies_info.has_both_canonicals), COUNT(0)) AS pct_has_both_canonicals

FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_wpt_bodies_info('') AS wpt_bodies_info # TEST
        #get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info, # LIVE       
      FROM
        `httparchive.sample_data.pages_*` test # TEST
    )
    GROUP BY client
