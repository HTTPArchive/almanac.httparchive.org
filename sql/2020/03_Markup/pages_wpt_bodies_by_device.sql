#standardSQL
# page wpt_bodies metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
  comment_count INT64,
  conditional_comment_count INT64,
  no_h1 BOOL
> LANGUAGE js AS '''
var result = {};
try {
    //var wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE

    // TEST
    var wpt_bodies = {
      raw_html: {
        comment_count: Math.floor(Math.random() * 100),
        conditional_comment_count: Math.floor(Math.random() * 100)
      },
      "headings": {
        "rendered": {
            "first_non_empty_heading_hidden": false,
            "h1": {
                "total": 1,
                "non_empty_total": 1,
                "characters": 343,
                "words": 20
            }
        }
      }
    }; 

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.raw_html) {
      result.comment_count = wpt_bodies.raw_html.comment_count; // M103
      result.conditional_comment_count = wpt_bodies.raw_html.conditional_comment_count; // M104
    }

    result.no_h1 = !wpt_bodies.headings || !wpt_bodies.headings.rendered || !wpt_bodies.headings.rendered.h1 || !wpt_bodies.headings.rendered.h1.total || wpt_bodies.headings.rendered.h1.total === 0;

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  # % of pages with comments
  COUNTIF(wpt_bodies_info.comment_count > 0) AS freq_contains_comment,
  AS_PERCENT(COUNTIF(wpt_bodies_info.comment_count > 0), COUNT(0)) AS pct_contains_comment_m104,

  # % of pages with conditional comments
  COUNTIF(wpt_bodies_info.conditional_comment_count > 0) AS freq_contains_conditional_comment,
  AS_PERCENT(COUNTIF(wpt_bodies_info.conditional_comment_count > 0), COUNT(0)) AS pct_contains_conditional_comment_m106,

  # pages without an h1
  COUNTIF(wpt_bodies_info.no_h1) AS freq_no_h1,
  AS_PERCENT(COUNTIF(wpt_bodies_info.no_h1), COUNT(0)) AS pct_no_h1_m220,

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