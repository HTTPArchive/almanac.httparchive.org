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
  head_size INT64,
  no_h1 BOOL,
  target_blank_total INT64,
  target_blank_noopener_noreferrer_total INT64
> LANGUAGE js AS '''
var result = {};
try {
    var wpt_bodies = JSON.parse(wpt_bodies_string); 

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.raw_html) {
      result.comment_count = wpt_bodies.raw_html.comment_count; // M103
      result.conditional_comment_count = wpt_bodies.raw_html.conditional_comment_count; // M104
      result.head_size = wpt_bodies.raw_html.head_size; // M234
    }

    result.no_h1 = !wpt_bodies.headings || !wpt_bodies.headings.rendered || !wpt_bodies.headings.rendered.h1 || !wpt_bodies.headings.rendered.h1.total || wpt_bodies.headings.rendered.h1.total === 0;

    if (wpt_bodies.anchors && wpt_bodies.anchors.rendered && wpt_bodies.anchors.rendered.target_blank) {
      result.target_blank_total = wpt_bodies.anchors.rendered.target_blank.total;
      result.target_blank_noopener_noreferrer_total = wpt_bodies.anchors.rendered.target_blank.noopener_noreferrer;
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  # % of pages with comments
  AS_PERCENT(COUNTIF(wpt_bodies_info.comment_count > 0), COUNT(0)) AS pct_contains_comment_m104,

  # % of pages with conditional comments
  AS_PERCENT(COUNTIF(wpt_bodies_info.conditional_comment_count > 0), COUNT(0)) AS pct_contains_conditional_comment_m106,

  # pages without an h1
  AS_PERCENT(COUNTIF(wpt_bodies_info.no_h1), COUNT(0)) AS pct_no_h1_m220,

  # pages with all target _banks including rel="noopener noreferrer" M420
  AS_PERCENT(COUNTIF(wpt_bodies_info.target_blank_total IS NULL OR wpt_bodies_info.target_blank_total = wpt_bodies_info.target_blank_noopener_noreferrer_total), COUNT(0)) AS pct_always_target_blank_noopener_noreferrer_m420,

  # pages with some target _banks not using rel="noopener noreferrer" M421
  AS_PERCENT(COUNTIF(wpt_bodies_info.target_blank_total > wpt_bodies_info.target_blank_noopener_noreferrer_total), COUNT(0)) AS pct_some_target_blank_without_noopener_noreferrer_m421,

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info      
      FROM
       `httparchive.pages.2020_08_01_*`
    )
GROUP BY
  client
  