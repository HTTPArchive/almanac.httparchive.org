#standardSQL
# percientile data from wpt_bodies per device

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  favicon BOOL,
  noscripts_count INT64,
  noscripts_iframe_googletagmanager_count INT64,
  svg_element_total INT64,
  svg_img_total INT64,
  svg_object_total INT64,
  svg_embed_total INT64,
  svg_iframe_total INT64,
  svg_total INT64,
  buttons_total INT64
> LANGUAGE js AS '''
var result = {};
try {
    //var markup = JSON.parse(markup_string); // LIVE

    // TEST
    var markup = {
      "favicon": Math.random() > 0.25,
      "noscripts": {
          "iframe_googletagmanager_count": Math.floor(Math.random()*10),
          "total": Math.floor(Math.random()*10)
      },
      "svgs": {
        "svg_element_total": Math.floor(Math.random()*10),
        "svg_img_total": Math.floor(Math.random()*10),
        "svg_object_total": Math.floor(Math.random()*10),
        "svg_embed_total": Math.floor(Math.random()*10),
        "svg_iframe_total": Math.floor(Math.random()*10),
        "svg_total": Math.floor(Math.random()*60)
      },
      "buttons": {
        "types": {
            "button": 1
        },
        "total": 1
      }
    }; 

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    result.favicon = !!markup.favicon;

    if (markup.noscripts) {
      result.noscripts_count = markup.noscripts.total;
      result.noscripts_iframe_googletagmanager_count = markup.noscripts.iframe_googletagmanager_count;
    }

    if (markup.svgs) {
      result.svg_element_total = markup.svgs.svg_element_total;
      result.svg_img_total = markup.svgs.svg_img_total;
      result.svg_object_total = markup.svgs.svg_object_total;
      result.svg_embed_total = markup.svgs.svg_embed_total;
      result.svg_iframe_total = markup.svgs.svg_iframe_total;
      result.svg_total = markup.svgs.svg_total;
    }

    if (markup.buttons) {
      result.buttons_total = markup.buttons.total;
    }

} catch (e) {}
return result;
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # Comments per page
  APPROX_QUANTILES(markup_info.noscripts_count, 1000)[OFFSET(percentile * 10)] AS noscripts_count_m212,
  APPROX_QUANTILES(markup_info.noscripts_iframe_googletagmanager_count, 1000)[OFFSET(percentile * 10)] AS noscripts_iframe_googletagmanager_count,

  # svg
  APPROX_QUANTILES(markup_info.svg_element_total, 1000)[OFFSET(percentile * 10)] AS svg_element_count_m224,
  APPROX_QUANTILES(markup_info.svg_img_total, 1000)[OFFSET(percentile * 10)] AS svg_img_count_m226,
  APPROX_QUANTILES(markup_info.svg_object_total, 1000)[OFFSET(percentile * 10)] AS svg_object_count_m228,
  APPROX_QUANTILES(markup_info.svg_embed_total, 1000)[OFFSET(percentile * 10)] AS svg_embed_count_m230,
  APPROX_QUANTILES(markup_info.svg_iframe_total, 1000)[OFFSET(percentile * 10)] AS svg_iframe_count_m232,
  APPROX_QUANTILES(markup_info.svg_total, 1000)[OFFSET(percentile * 10)] AS svg_count,

  # how many button elements on a page
  APPROX_QUANTILES(markup_info.buttons_total, 1000)[OFFSET(percentile * 10)] AS buttons_count_m301,

FROM (
  SELECT 
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    get_markup_info('') AS markup_info # TEST
    #get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info # LIVE
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
