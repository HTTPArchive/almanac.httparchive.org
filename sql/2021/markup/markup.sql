#standardSQL
# pages markup metrics grouped by device

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  favicon BOOL,
  app_id_present BOOL,
  amp_rel_amphtml_present BOOL,
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
  inputs_types_image_total INT64,
  inputs_types_button_total INT64,
  inputs_types_submit_total INT64,
  dirs_html_dir STRING,
  dirs_body_nodes_dir_total INT64
> LANGUAGE js AS '''
var result = {};
try {
    var markup = JSON.parse(markup_string);

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    result.favicon = !!markup.favicon;

    if (markup.app) {
      result.app_id_present = !!markup.app.app_id_present;
    }

    if (markup.amp) {
      result.amp_rel_amphtml_present = !!markup.amp.rel_amphtml;
    }

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
        // .filter(([key, value]) => key == "" || key == "autoplay") // should check, but lets just include all values
        .reduce((total, [key, value]) => total + value, 0);

      result.contains_audios_with_autoplay = autoplay_count > 0;
      result.contains_audios_without_autoplay = markup.audios.total > autoplay_count;
    }

    if (markup.inputs) {
      result.inputs_types_image_total = Object.entries(markup.inputs.types)
        .filter(([key, value]) => key.trim().toLowerCase() == "image")
        .reduce((total, [key, value]) => total + value, 0);

      result.inputs_types_button_total = Object.entries(markup.inputs.types)
        .filter(([key, value]) => key.trim().toLowerCase() == "button")
        .reduce((total, [key, value]) => total + value, 0);

      result.inputs_types_submit_total = Object.entries(markup.inputs.types)
        .filter(([key, value]) => key.trim().toLowerCase() == "submit")
        .reduce((total, [key, value]) => total + value, 0);
    }

    if (markup.dirs) {
      if (markup.dirs.html_dir) {
        result.dirs_html_dir = markup.dirs.html_dir.trim().toLowerCase();
      }

      if (markup.dirs.body_nodes_dir) {
        result.dirs_body_nodes_dir_total = markup.dirs.body_nodes_dir.total;
      }
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  # pages with a favicon
  SAFE_DIVIDE(COUNTIF(markup_info.favicon), COUNT(0)) AS pct_favicon,

  # pages identified as an app
  SAFE_DIVIDE(COUNTIF(markup_info.app_id_present), COUNT(0)) AS pct_app_id_present,

  # pages with a link rel="amphtml"
  SAFE_DIVIDE(COUNTIF(markup_info.amp_rel_amphtml_present), COUNT(0)) AS pct_amp_rel_amphtml_present,

  # pages with a noscript tag
  SAFE_DIVIDE(COUNTIF(markup_info.noscripts_count > 0), COUNT(0)) AS pct_noscripts,

  # pages with a noscript gtm tag
  SAFE_DIVIDE(COUNTIF(markup_info.noscripts_iframe_googletagmanager_count > 0), COUNT(0)) AS pct_noscripts_gtm_tag,

  # pages with an svg element
  SAFE_DIVIDE(COUNTIF(markup_info.svg_element_total > 0), COUNT(0)) AS pct_svg_element,

  # pages with an svg img
  SAFE_DIVIDE(COUNTIF(markup_info.svg_img_total > 0), COUNT(0)) AS pct_svg_svg_img,

  # pages with an svg object
  SAFE_DIVIDE(COUNTIF(markup_info.svg_object_total > 0), COUNT(0)) AS pct_svg_object,

  # pages with an svg embed
  SAFE_DIVIDE(COUNTIF(markup_info.svg_embed_total > 0), COUNT(0)) AS pct_svg_embed,

  # pages with an svg iframe
  SAFE_DIVIDE(COUNTIF(markup_info.svg_iframe_total > 0), COUNT(0)) AS pct_svg_iframe,

  # pages with an svg
  SAFE_DIVIDE(COUNTIF(markup_info.svg_total > 0), COUNT(0)) AS pct_svg_,

  # pages with a button
  SAFE_DIVIDE(COUNTIF(markup_info.buttons_total > 0), COUNT(0)) AS pct_buttons,

  # pages with a button without a type
  SAFE_DIVIDE(COUNTIF(markup_info.buttons_total > markup_info.buttons_with_type), COUNT(0)) AS pct_buttons_without_type,

  # pages with autoplaying audio elements
  SAFE_DIVIDE(COUNTIF(markup_info.contains_audios_with_autoplay), COUNT(0)) AS pct_contains_audios_with_autoplay,

  # pages with non autoplaying audio elements
  SAFE_DIVIDE(COUNTIF(markup_info.contains_audios_without_autoplay), COUNT(0)) AS pct_contains_audios_without_autoplay,

  # pages with html dir set
  SAFE_DIVIDE(COUNTIF(LENGTH(markup_info.dirs_html_dir) > 0), COUNT(0)) AS pct_html_dir_set,

  # pages with html dir set to ltr
  SAFE_DIVIDE(COUNTIF(markup_info.dirs_html_dir = 'ltr'), COUNT(0)) AS pct_html_dir_ltr,

  # pages with html dir set to rtl
  SAFE_DIVIDE(COUNTIF(markup_info.dirs_html_dir = 'rtl'), COUNT(0)) AS pct_html_dir_rtl,

  # pages with html dir set to auto
  SAFE_DIVIDE(COUNTIF(markup_info.dirs_html_dir = 'auto'), COUNT(0)) AS pct_html_dir_auto,

  # pages with dir on other elements
  SAFE_DIVIDE(COUNTIF(markup_info.dirs_body_nodes_dir_total > 0), COUNT(0)) AS pct_body_nodes_dir_set

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
