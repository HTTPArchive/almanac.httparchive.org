#standardSQL
# page markup metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

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
  svg_total INT64
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

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  # pages with a noscript tag
  COUNTIF(markup_info.noscripts_count > 0) AS freq_noscripts,
  AS_PERCENT(COUNTIF(markup_info.noscripts_count > 0), COUNT(0)) AS pct_noscripts_m211,

  # pages with a noscript gtm tag
  COUNTIF(markup_info.noscripts_iframe_googletagmanager_count > 0) AS freq_noscripts_gtm_tag,
  AS_PERCENT(COUNTIF(markup_info.noscripts_iframe_googletagmanager_count > 0), COUNT(0)) AS pct_noscripts_gtm_tag_m213,

  # pages with a favicon
  COUNTIF(markup_info.favicon) AS freq_favicon,
  AS_PERCENT(COUNTIF(markup_info.favicon), COUNT(0)) AS pct_favicon_m218,

  # pages with an svg element
  COUNTIF(markup_info.svg_element_total > 0) AS freq_svg_element_total,
  AS_PERCENT(COUNTIF(markup_info.svg_element_total > 0), COUNT(0)) AS pct_svg_element_total_m223,

  # pages with an svg img
  COUNTIF(markup_info.svg_img_total > 0) AS freq_svg_img_total,
  AS_PERCENT(COUNTIF(markup_info.svg_img_total > 0), COUNT(0)) AS pct_svg_svg_img_total_m225,

  # pages with an svg object
  COUNTIF(markup_info.svg_object_total > 0) AS freq_svg_object_total,
  AS_PERCENT(COUNTIF(markup_info.svg_object_total > 0), COUNT(0)) AS pct_svg_object_total_m227,

  # pages with an svg embed
  COUNTIF(markup_info.svg_embed_total > 0) AS freq_svg_embed_total,
  AS_PERCENT(COUNTIF(markup_info.svg_embed_total > 0), COUNT(0)) AS pct_svg_embed_total_m229,

  # pages with an svg iframe
  COUNTIF(markup_info.svg_iframe_total > 0) AS freq_svg_iframe_total,
  AS_PERCENT(COUNTIF(markup_info.svg_iframe_total > 0), COUNT(0)) AS pct_svg_iframe_total_m231,

  # pages with an svg 
  COUNTIF(markup_info.svg_total > 0) AS freq_svg_total,
  AS_PERCENT(COUNTIF(markup_info.svg_total > 0), COUNT(0)) AS pct_svg_total_m233,

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_markup_info('') AS markup_info # TEST
        #get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info # LIVE      
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client