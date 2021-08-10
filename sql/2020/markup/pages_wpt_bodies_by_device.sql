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
  target_blank_noopener_noreferrer_total INT64,
  target_blank_noopener_total INT64,
  target_blank_noreferrer_total INT64,
  target_blank_neither_total INT64,

  n_h1 INT64,
  n_h2 INT64,
  n_h3 INT64,
  n_h4 INT64,
  n_h5 INT64,
  n_h6 INT64,
  n_h7 INT64,
  n_h8 INT64,
  n_non_empty_h1 INT64,
  n_non_empty_h2 INT64,
  n_non_empty_h3 INT64,
  n_non_empty_h4 INT64,
  n_non_empty_h5 INT64,
  n_non_empty_h6 INT64,
  n_non_empty_h7 INT64,
  n_non_empty_h8 INT64
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
      result.target_blank_noopener_total = wpt_bodies.anchors.rendered.target_blank.noopener;
      result.target_blank_noreferrer_total = wpt_bodies.anchors.rendered.target_blank.noreferrer;
      result.target_blank_neither_total = wpt_bodies.anchors.rendered.target_blank.neither;
    }

    var headings = wpt_bodies.headings;
    if (headings) {
      var headings_rendered = headings.rendered;
      if (headings_rendered) {

        //If the webpage has h1
        result.n_h1 = headings_rendered.h1.total;

        //If the webpage has h2
        result.n_h2 = headings_rendered.h2.total;

        //If the webpage has h3
        result.n_h3 = headings_rendered.h3.total;

        //If the webpage has h4
        result.n_h4 = headings_rendered.h4.total;

        //If the webpage has h5
        result.n_h5 = headings_rendered.h5.total;

        //If the webpage has h6
        result.n_h6 = headings_rendered.h6.total;

        //If the webpage has h7
        result.n_h7 = headings_rendered.h7.total;

        //If the webpage has h8
        result.n_h8 = headings_rendered.h8.total;

        //If the webpage has a non empty h1
        result.n_non_empty_h1 = headings_rendered.h1.non_empty_total;

        //If the webpage has a non empty h2
        result.n_non_empty_h2 = headings_rendered.h2.non_empty_total;

        //If the webpage has a non empty h3
        result.n_non_empty_h3 = headings_rendered.h3.non_empty_total;

        //If the webpage has a non empty h4
        result.n_non_empty_h4 = headings_rendered.h4.non_empty_total;

        //If the webpage has a non empty h5
        result.n_non_empty_h5 = headings_rendered.h5.non_empty_total;

        //If the webpage has a non empty h6
        result.n_non_empty_h6 = headings_rendered.h6.non_empty_total;

        //If the webpage has a non empty h7
        result.n_non_empty_h7 = headings_rendered.h7.non_empty_total;

        //If the webpage has a non empty h8
        result.n_non_empty_h8 = headings_rendered.h8.non_empty_total;

      }
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

  AS_PERCENT(COUNTIF(wpt_bodies_info.target_blank_total > 0), COUNT(0)) AS pct_has_target_blank,
  AS_PERCENT(COUNTIF(wpt_bodies_info.target_blank_noopener_noreferrer_total > 0), COUNT(0)) AS pct_has_target_blank_noopener_noreferrer,
  AS_PERCENT(COUNTIF(wpt_bodies_info.target_blank_noopener_total > 0), COUNT(0)) AS pct_has_target_blank_noopener,
  AS_PERCENT(COUNTIF(wpt_bodies_info.target_blank_noreferrer_total > 0), COUNT(0)) AS pct_has_target_blank_noreferrer,
  AS_PERCENT(COUNTIF(wpt_bodies_info.target_blank_neither_total > 0), COUNT(0)) AS pct_has_target_blank_neither,

  ROUND(AVG(wpt_bodies_info.n_h1), 2) AS avg_h1,
  ROUND(AVG(wpt_bodies_info.n_h2), 2) AS avg_h2,
  ROUND(AVG(wpt_bodies_info.n_h3), 2) AS avg_h3,
  ROUND(AVG(wpt_bodies_info.n_h4), 2) AS avg_h4,
  ROUND(AVG(wpt_bodies_info.n_h5), 2) AS avg_h5,
  ROUND(AVG(wpt_bodies_info.n_h6), 2) AS avg_h6,
  ROUND(AVG(wpt_bodies_info.n_h7), 2) AS avg_h7,
  ROUND(AVG(wpt_bodies_info.n_h8), 2) AS avg_h8,

  SUM(wpt_bodies_info.n_h1) AS freq_h1,
  SUM(wpt_bodies_info.n_h2) AS freq_h2,
  SUM(wpt_bodies_info.n_h3) AS freq_h3,
  SUM(wpt_bodies_info.n_h4) AS freq_h4,
  SUM(wpt_bodies_info.n_h5) AS freq_h5,
  SUM(wpt_bodies_info.n_h6) AS freq_h6,
  SUM(wpt_bodies_info.n_h7) AS freq_h7,
  SUM(wpt_bodies_info.n_h8) AS freq_h8

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
