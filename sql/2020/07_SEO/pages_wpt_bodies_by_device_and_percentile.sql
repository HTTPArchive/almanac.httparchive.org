#standardSQL
# percientile data from wpt_bodies per device

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
  robots_has_robots_meta_tag BOOL,
  robots_has_x_robots_tag BOOL,
  title_words INT64
# add more properties here...
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
          "self_canonical": true,
          "other_canonical": false,
          "canonicals": [
              "https://btpi.com/"
          ],
          "url": "https://btpi.com/",
          "http_header_link_canoncials": [],
          "canonical_missmatch": false
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

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.robots) {
      result.robots_has_robots_meta_tag = wpt_bodies.robots.has_robots_meta_tag;
      result.robots_has_x_robots_tag = wpt_bodies.robots.has_x_robots_tag;
    }

    if (wpt_bodies.title) {
      if (wpt_bodies.title.rendered) {
        result.title_words = wpt_bodies.title.rendered.primary.words;
      }
    }

    // add more code to set result properties here...

} catch (e) {}
return result;
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # words in a title
  APPROX_QUANTILES(wpt_bodies_info.title_words, 1000)[OFFSET(percentile * 10)] AS title_words

  # add more fields here...
  # split the query up into logical groups if it gets too large.

FROM (
  SELECT 
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    get_wpt_bodies_info('') AS wpt_bodies_info # TEST
    #get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info # LIVE
  FROM
  `httparchive.sample_data.pages_*`, # TEST
  UNNEST([10, 25, 50, 75, 90]) AS percentile
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
