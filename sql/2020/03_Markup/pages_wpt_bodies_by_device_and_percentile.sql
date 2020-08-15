#standardSQL
# percientile data from wpt_bodies per device

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
    //var wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE

    // TEST
    var wpt_bodies = {
      raw_html: {
        comment_count: Math.floor(Math.random() * 100),
        conditional_comment_count: Math.floor(Math.random() * 100),
        head_size: Math.floor(Math.random() * 1000),
        body_size: Math.floor(Math.random() * 10000)
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
      },
      "anchors": {
        "rendered": {
          "target_blank": {
                "total": 0,
                "noopener_noreferrer": 0,
                "noopener": 0,
                "noreferrer": 0,
                "neither": 8
          }
        }
      }
    }; 

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
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # Comments per page
  APPROX_QUANTILES(wpt_bodies_info.comment_count, 1000)[OFFSET(percentile * 10)] AS comment_count_m103,
  APPROX_QUANTILES(wpt_bodies_info.conditional_comment_count, 1000)[OFFSET(percentile * 10)] AS conditional_comment_count_m104

  # size of the head section in characters
  APPROX_QUANTILES(wpt_bodies_info.head_size, 1000)[OFFSET(percentile * 10)] AS head_size_m234
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
