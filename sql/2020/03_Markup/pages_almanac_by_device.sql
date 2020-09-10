#standardSQL
# pages almanac metrics grouped by device

# real run estimated at $4.08 and took 48 seconds

# to speed things up there is only one js function per custom metric property. It returns a STRUCT with all the data needed
# current test gathers 3 bits of incormation from the custom petric properties
# I tried to do a single js function processing the whole payload but it was very slow (50 sec) because of parsing the full payload in js
# this uses JSON_EXTRACT_SCALAR to first get the custom metrics json string, and only passes those into the js functions
# Estimate about twice the speed of the original code. But should scale up far better as the custom metrics are only parsed once.

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_info(almanac_string STRING)
RETURNS STRUCT<
  scripts_total INT64,
  none_jsonld_scripts_total INT64,
  src_scripts_total INT64,
  inline_scripts_total INT64,
  good_heading_sequence BOOL,
  contains_videos_with_autoplay BOOL,
  contains_videos_without_autoplay BOOL,
  html_node_lang STRING
> LANGUAGE js AS '''
var result = {};
try {
    var almanac;
    if (true) { // LIVE = true
      almanac = JSON.parse(almanac_string); // LIVE
    }
    else {
      // TEST
      almanac = {
        "scripts": {
          "total": Math.floor(Math.random() * 4),
          "nodes": []
        },
        "headings_order": [
          1,
          2,
          2,
          3,
          2
        ],
        "videos": {
          "total": 2,
          "nodes": [],
          "attribute_usage_count": {},
          "tracks": {
              "total": 0,
              "nodes": [],
              "attribute_usage_count": {}
          }
        },
        "html_node": {
            "tagName": "html",
            "xmlns": "http://www.w3.org/1999/xhtml",
            "xml:lang": "en-US",
            "prefix": "og: https://ogp.me/ns#"
        } 
      };
      if(Math.floor(Math.random() * 10)) {
        almanac.scripts.nodes.push({
            "tagName": "script",
            "async": "",
            "src": "//www.google-analytics.com/analytics.js"
        });
      }
      if(Math.floor(Math.random() * 10)) {
        almanac.scripts.nodes.push({
            "tagName": "script"
        });
      }
      if(Math.floor(Math.random() * 10)) {
        almanac.scripts.nodes.push({
            "tagName": "script",
            "type": "application/ld+json",
            "class": "yoast-schema-graph"
        });
      }
      if(Math.floor(Math.random() * 10)) {
        almanac.scripts.nodes.push({
            "tagName": "script",
            "type": "text/javascript",
            "data-cfasync": ""
        });
      }
      if(Math.floor(Math.random() * 3)) {
        almanac.headings_order = [1,4,2,3,8];
      }
      if(Math.floor(Math.random() * 10)) {
        almanac.videos.nodes.push({
              "tagName": "video",
              "autoplay": ""
          });
      }
      if(Math.floor(Math.random() * 10)) {
        almanac.videos.nodes.push({
              "tagName": "video",
              "autoplay": "false"
          });
      }
      if(Math.floor(Math.random() * 3)) {
        almanac.html_node.lang = "en-US";
      }
      if(Math.floor(Math.random() * 5)) {
        almanac.html_node.lang = "en-UK";
      }
    }

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    if (almanac.scripts) {
      result.scripts_total = almanac.scripts.total;
      if (almanac.scripts.nodes) {
        result.none_jsonld_scripts_total = almanac.scripts.nodes.filter(n => !n.type || n.type.trim().toLowerCase() !== 'application/ld+json').length;
        result.src_scripts_total = almanac.scripts.nodes.filter(n => n.src && n.src.trim().length > 0).length;

        result.inline_scripts_total = result.none_jsonld_scripts_total - result.src_scripts_total;
      }
    }

    if (almanac.headings_order) {
      var good = true;
      var previousLevel = 0;
      almanac.headings_order.forEach(level =>  {
          if (previousLevel + 1 < level) { // jumped a level
            good = false;
          }
          previousLevel = level;
      }); 
      result.good_heading_sequence = good;
    }

    if (almanac.videos) {
      var autoplay_count = almanac.videos.nodes.filter(n => n.autoplay == "" || n.autoplay).length; // valid values are blank or autoplay. Im just checking it exists...
      //var autoplay_count = almanac.videos.nodes.filter(n => n.autoplay == "" || n.autoplay == "autoplay").length; 

      result.contains_videos_with_autoplay = autoplay_count > 0;
      result.contains_videos_without_autoplay = almanac.videos.total > autoplay_count;
    }

    if (almanac.html_node) {
      result.html_node_lang = almanac.html_node.lang;
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  # has scripts excluding jsonld ones
  # COUNTIF(almanac_info.none_jsonld_scripts_total > 0) AS freq_contains_none_jsonld_scripts,
  AS_PERCENT(COUNTIF(almanac_info.none_jsonld_scripts_total > 0), COUNT(0)) AS pct_contains_none_jsonld_scripts_m204, 

  # has inline scripts 
  # COUNTIF(almanac_info.inline_scripts_total > 0) AS freq_contains_inline_scripts,
  AS_PERCENT(COUNTIF(almanac_info.inline_scripts_total > 0), COUNT(0)) AS pct_contains_inline_scripts_m206,

  # has src scripts 
  # COUNTIF(almanac_info.src_scripts_total > 0) AS freq_contains_src_scripts,
  AS_PERCENT(COUNTIF(almanac_info.src_scripts_total > 0), COUNT(0)) AS pct_contains_src_scripts_m208,

  # has no scripts 
  # COUNTIF(almanac_info.scripts_total = 0) AS freq_contains_no_scripts,
  AS_PERCENT(COUNTIF(almanac_info.scripts_total = 0), COUNT(0)) AS pct_contains_no_scripts_m210,

  # Does the heading logical sequence make any sense
  # COUNTIF(almanac_info.good_heading_sequence) AS freq_good_heading_sequence,
  AS_PERCENT(COUNTIF(almanac_info.good_heading_sequence), COUNT(0)) AS pct_good_heading_sequence_m222,

  # pages with autoplaying video elements M310
  # COUNTIF(almanac_info.contains_videos_with_autoplay) AS freq_contains_videos_with_autoplay,
  AS_PERCENT(COUNTIF(almanac_info.contains_videos_with_autoplay), COUNT(0)) AS pct_contains_videos_with_autoplay_m310,

  # pages without autoplaying video elements M311
  # COUNTIF(almanac_info.contains_videos_without_autoplay) AS freq_contains_videos_without_autoplay,
  AS_PERCENT(COUNTIF(almanac_info.contains_videos_without_autoplay), COUNT(0)) AS pct_contains_videos_without_autoplay_m311,

  # pages with no html lang attribute M404
  # COUNTIF(almanac_info.html_node_lang IS NULL OR LENGTH(almanac_info.html_node_lang) = 0) AS freq_no_html_lang,
  AS_PERCENT(COUNTIF(almanac_info.html_node_lang IS NULL OR LENGTH(almanac_info.html_node_lang) = 0), COUNT(0)) AS pct_no_html_lang_m404,

FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        #get_almanac_info('') AS almanac_info  # TEST
        get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info # LIVE
      FROM
        #`httparchive.sample_data.pages_*` # TEST
        `httparchive.pages.2020_08_01_*` # LIVE
    )
GROUP BY
  client
  