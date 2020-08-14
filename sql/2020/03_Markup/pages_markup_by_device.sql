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
  svg_total INT64,
  buttons_total INT64,
  buttons_with_type INT64,
  contains_audios_with_autoplay BOOL,
  contains_audios_without_autoplay BOOL,
  app_id_present BOOL
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
            "button": 1,
            "fish": 1
        },
        "total": Math.floor(Math.random()*2)+2
      },
      "audios": {
        "autoplay": {true: 3, false: 6, "": 6},
        "total": 9
      },
      "app": {
        "app_id_present": false,
        "meta_theme_color": null
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

      result.buttons_with_type = Object.values(markup.buttons.types).reduce((total, freq) => total + freq, 0);
    }

    if (markup.audios) {

      var autoplay_count = Object.entries(markup.audios.autoplay)
        .filter(([key, value]) => key == "" || key.toLowerCase() == "true")
        .reduce((total, [key, value]) => total + value, 0);

      result.contains_audios_with_autoplay = autoplay_count > 0;
      result.contains_audios_without_autoplay = markup.audios.total > autoplay_count;
    }

    if (markup.app) {
      result.app_id_present = !!markup.app.app_id_present;
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
  COUNTIF(markup_info.svg_element_total > 0) AS freq_svg_element,
  AS_PERCENT(COUNTIF(markup_info.svg_element_total > 0), COUNT(0)) AS pct_svg_element_m223,

  # pages with an svg img
  COUNTIF(markup_info.svg_img_total > 0) AS freq_svg_img,
  AS_PERCENT(COUNTIF(markup_info.svg_img_total > 0), COUNT(0)) AS pct_svg_svg_img_m225,

  # pages with an svg object
  COUNTIF(markup_info.svg_object_total > 0) AS freq_svg_object,
  AS_PERCENT(COUNTIF(markup_info.svg_object_total > 0), COUNT(0)) AS pct_svg_object_m227,

  # pages with an svg embed
  COUNTIF(markup_info.svg_embed_total > 0) AS freq_svg_embed,
  AS_PERCENT(COUNTIF(markup_info.svg_embed_total > 0), COUNT(0)) AS pct_svg_embed_m229,

  # pages with an svg iframe
  COUNTIF(markup_info.svg_iframe_total > 0) AS freq_svg_iframe,
  AS_PERCENT(COUNTIF(markup_info.svg_iframe_total > 0), COUNT(0)) AS pct_svg_iframe_m231,

  # pages with an svg 
  COUNTIF(markup_info.svg_total > 0) AS freq_svg,
  AS_PERCENT(COUNTIF(markup_info.svg_total > 0), COUNT(0)) AS pct_svg__m233,

  # pages with a button 
  COUNTIF(markup_info.buttons_total > 0) AS freq_buttons,
  AS_PERCENT(COUNTIF(markup_info.buttons_total > 0), COUNT(0)) AS pct_buttons_m302,

  # pages with a button without a type 
  COUNTIF(markup_info.buttons_total > markup_info.buttons_with_type) AS freq_buttons_without_type,
  AS_PERCENT(COUNTIF(markup_info.buttons_total > markup_info.buttons_with_type), COUNT(0)) AS pct_buttons_without_type_m303,

  # pages with autoplaying audio elements M312
  COUNTIF(markup_info.contains_audios_with_autoplay) AS freq_contains_audios_with_autoplay,
  AS_PERCENT(COUNTIF(markup_info.contains_audios_with_autoplay), COUNT(0)) AS pct_contains_audios_with_autoplay_m312,

  # pages with non autoplaying audio elements M313
  COUNTIF(markup_info.contains_audios_without_autoplay) AS freq_contains_audios_without_autoplay,
  AS_PERCENT(COUNTIF(markup_info.contains_audios_without_autoplay), COUNT(0)) AS pct_contains_audios_without_autoplay_m313,

  # pages identified as an app M403
  COUNTIF(markup_info.app_id_present) AS freq_app_id_present,
  AS_PERCENT(COUNTIF(markup_info.app_id_present), COUNT(0)) AS pct_app_id_present_m403,

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