#standardSQL
# page wpt_bodies metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<

  ##Tony  
  robots_has_robots_meta_tag BOOL,
  robots_has_x_robots_tag BOOL,
  title_words INT64, 

  ##Antoine
  n_titles INT64,
  n_meta_descriptions INT64, 
  n_h1 INT64, 
  n_h2 INT64, 
  n_h3 INT64, 
  n_h4 INT64, 
  n_non_empty_h1 INT64, 
  n_non_empty_h2 INT64, 
  n_non_empty_h3 INT64, 
  n_non_empty_h4 INT64, 
  has_same_h1_title BOOL

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

        //Number of words in the title tag
        result.title_words = wpt_bodies.title.rendered.primary.words;

        //If the webpage has a title
        result.n_titles = wpt_bodies.title.rendered.total

      }
    }


    if (wpt_bodies.meta_description) {
      if (wpt_bodies.meta_descripton.rendered) {


        //If the webpage has a meta description
        result.n_meta_descriptions = wpt_bodies.meta_description.rendered.total;


      }
    }


    if (wpt_bodies.headings) {
      if (wpt_bodies.headings.rendered) {


        //If the webpage has h1
        result.n_h1 = wpt_bodies.headings.rendered.h1.total;


        //If the webpage has h2
        result.n_h2 = wpt_bodies.headings.rendered.h2.total;


        //If the webpage has h3
        result.n_h3 = wpt_bodies.headings.rendered.h3.total;


        //If the webpage has h4
        result.n_h4 = wpt_bodies.headings.rendered.h4.total;
 

        //If the webpage has a non empty h1
        result.n_non_empty_h1 = wpt_bodies.headings.rendered.h1.non_empty_total;
 
        //If the webpage has a non empty h2
        result.n_non_empty_h2 = wpt_bodies.headings.rendered.h2.non_empty_total;

        //If the webpage has a non empty h3
        result.n_non_empty_h3 = wpt_bodies.headings.rendered.h3.non_empty_total;

        //If the webpage has a non empty h4
        result.n_non_empty_h4 = wpt_bodies.headings.rendered.h4.non_empty_total;


        //If h1 and title tag are the same
        result.has_same_h1_title = wpt_bodies.headings.rendered.primary.matches_title;

      }
    }


    }

    // add more code to set result properties here...

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,
  
  ## Tony
  # Meta Robots inclusion
  # COUNTIF(wpt_bodies_info.robots_has_robots_meta_tag) AS freq_has_meta_robots,
  AS_PERCENT(COUNTIF(wpt_bodies_info.robots_has_robots_meta_tag), COUNT(0)) AS pct_has_meta_robots,

  # HTTP Header Robots inclusion
  # COUNTIF(wpt_bodies_info.robots_has_x_robots_tag) AS freq_robots_has_x_robots_tag,
  AS_PERCENT(COUNTIF(wpt_bodies_info.robots_has_x_robots_tag), COUNT(0)) AS pct_robots_has_x_robots_tag,

  # titles with less than 5 words
  # COUNTIF(wpt_bodies_info.title_words < 5) AS freq_robots_has_x_robots_tag,
  AS_PERCENT(COUNTIF(wpt_bodies_info.title_words < 5), COUNT(0)) AS pct_short_title_tag,

  ##Antoine
  # meta title inclusion
  # COUNTIF(wpt_bodies_info.n_titles < 0) AS freq_has_meta_title,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_titles < 0), COUNT(0)) AS pct_has_meta_title,

  # meta description inclusion
  # COUNTIF(wpt_bodies_info.n_meta_descriptions < 0) AS freq_has_meta_description,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_meta_descriptions < 0), COUNT(0)) AS pct_has_meta_description,

  # H1 inclusion
  # COUNTIF(wpt_bodies_info.n_h1 < 0) AS freq_has_h1,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_h1 < 0), COUNT(0)) AS pct_has_h1,

  # H2 inclusion
  # COUNTIF(wpt_bodies_info.n_h2 < 0) AS freq_has_h2,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_h2 < 0), COUNT(0)) AS pct_has_h2,

  # H3 inclusion
  # COUNTIF(wpt_bodies_info.n_h3 < 0) AS freq_has_h3,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_h3 < 0), COUNT(0)) AS pct_has_h3,

  # H4 inclusion
  # COUNTIF(wpt_bodies_info.n_h4 < 0) AS freq_has_h4,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_h4 < 0), COUNT(0)) AS pct_has_h4,

  # Non-empty H1 inclusion
  # COUNTIF(wpt_bodies_info.n_non_empty_h1 < 0) AS freq_has_non_empty_h1,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_non_empty_h1 < 0), COUNT(0)) AS pct_has_non_empty_h1,

  # Non-empty H2 inclusion
  # COUNTIF(wpt_bodies_info.n_non_empty_h2 < 0) AS freq_has_non_empty_h2,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_non_empty_h2 < 0), COUNT(0)) AS pct_has_non_empty_h2,

  # Non-empty H3 inclusion
  # COUNTIF(wpt_bodies_info.n_non_empty_h3 < 0) AS freq_has_non_empty_h3,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_non_empty_h3 < 0), COUNT(0)) AS pct_has_non_empty_h3,

  # Non-empty H4 inclusion
  # COUNTIF(wpt_bodies_info.n_non_empty_h4 < 0) AS freq_has_non_empty_h4,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_non_empty_h4 < 0), COUNT(0)) AS pct_has_non_empty_h4,

  # Same title and H1
  # COUNTIF(wpt_bodies_info.has_same_h1_title ) AS freq_has_same_h1_title,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_same_h1_title ), COUNT(0)) AS pct_has_same_h1_title


  # add more fields here...
  # split the query up into logical groups if it gets too large.

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_wpt_bodies_info('') AS wpt_bodies_info # TEST
        #get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info # LIVE      
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client
