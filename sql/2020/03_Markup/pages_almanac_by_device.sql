#standardSQL
# page payload metrics grouped by device

# to speed things up there is only one js function per custom metric property. It returns a STRUCT with all the data needed
# current test gathers 3 bits of incormation from teo custom petric properties
# I tried to do a single js function processing payload but it was very slow (50 sec) because of parsing the full payload in js
# this uses JSON_EXTRACT_SCALAR to first get the custom metrics json string, and only passes those into the js functions
# Estimate about twice the speed of the original code. But should scale up far better as the custom metrics are only parsed once.
# real test ($2.90) 39.1 sec

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
  inline_scripts_total INT64
> LANGUAGE js AS '''
var result = {};
try {
    // var almanac = JSON.parse(almanac_string); // LIVE

    // TEST
    var almanac = {
      "scripts": {
        "total": 4,
        "nodes": [
            {
                "tagName": "script",
                "async": "",
                "src": "//www.google-analytics.com/analytics.js"
            },
            {
                "tagName": "script"
            },
            {
                "tagName": "script",
                "type": "application/ld+json",
                "class": "yoast-schema-graph"
            },
            {
                "tagName": "script",
                "type": "text/javascript",
                "data-cfasync": ""
            }
        ]
      } 
    };

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    if (almanac.scripts) {
      result.scripts_total = almanac.scripts.total;
      if (almanac.scripts.nodes) {
        result.none_jsonld_scripts_total = almanac.scripts.nodes.filter(n => !n.type || n.type.trim().toLowerCase() !== 'application/ld+json').length;
        result.src_scripts_total = almanac.scripts.nodes.filter(n => n.src && n.src.trim().length > 0).length;

        result.inline_scripts_total = result.none_jsonld_scripts_total - result.src_scripts_total;
      }
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  # has scripts excluding jsonld ones
  COUNTIF(almanac_info.none_jsonld_scripts_total > 0) AS freq_contains_none_jsonld_scripts,
  AS_PERCENT(COUNTIF(almanac_info.none_jsonld_scripts_total > 0), COUNT(0)) AS pct_contains_none_jsonld_scripts_m204, 

  # has inline scripts 
  COUNTIF(almanac_info.inline_scripts_total > 0) AS freq_contains_inline_scripts,
  AS_PERCENT(COUNTIF(almanac_info.inline_scripts_total > 0), COUNT(0)) AS pct_contains_inline_scripts_m206,

  # has src scripts 
  COUNTIF(almanac_info.src_scripts_total > 0) AS freq_contains_src_scripts,
  AS_PERCENT(COUNTIF(almanac_info.src_scripts_total > 0), COUNT(0)) AS pct_contains_src_scripts_m208,

  # has no scripts 
  COUNTIF(almanac_info.scripts_total = 0) AS freq_contains_no_scripts,
  AS_PERCENT(COUNTIF(almanac_info.scripts_total = 0), COUNT(0)) AS pct_contains_no_scripts_m210,

  #AVG(almanac_info.scripts_total) AS avg_scripts_total,

  #AVG(almanac_info.none_jsonld_scripts_total) AS avg_none_jsonld_scripts_total

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_almanac_info('') AS almanac_info  # TEST
        #get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info # LIVE
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client