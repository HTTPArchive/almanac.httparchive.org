#standardSQL
# page markup metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<

  ##Tony
  images_img_total INT64, 
  images_alt_missing_total INT64,
  images_alt_blank_total INT64,
  images_alt_present_total INT64,

  ##Antoine
  has_html_amp_attribute BOOL, 
  has_rel_amphtml_tag BOOL,
  has_html_amp_emoji_attribute BOOL
> LANGUAGE js AS '''
var result = {};
try {
    //var markup = JSON.parse(markup_string); // LIVE

    // TEST
    var markup = {
      "images": {
          "img": {
              "total": Math.floor(Math.random() * 100)
          },
          "alt": {
              "missing": Math.floor(Math.random() * 50),
              "blank": Math.floor(Math.random() * 10),
              "present": Math.floor(Math.random() * 50)
          }
      },
      "amp": {
        "html_amp_attribute_present": Math.floor(Math.random() * 3) == 0,
        "html_amp_emoji_attribute_present": Math.floor(Math.random() * 20) == 0,
        "amp_page": Math.floor(Math.random() * 3) == 0,
        "rel_amphtml": null
      }
    }; 
    if (Math.floor(Math.random() * 5) == 0) {
      markup.amp.rel_amphtml = "http://example.com/";
    }

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.images) {
      if (markup.images.img) {
        result.images_img_total = markup.images.img.total;

      }
      if (markup.images.alt) {
          result.images_alt_missing_total = markup.images.alt.missing;
          result.images_alt_blank_total = markup.images.alt.blank;
          result.images_alt_present_total = markup.images.alt.present; // present does not include blank
      }
    }

    if (markup.amp) {
      result.has_html_amp_attribute = markup.amp.html_amp_attribute_present;
      result.has_html_amp_emoji_attribute = markup.amp.html_amp_emoji_attribute_present;
      result.has_rel_amphtml_tag = markup.amp.rel_amphtml;
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  ##Tony
  # Pages with img
  #COUNTIF(markup_info.images_img_total > 0) as has_img,
  AS_PERCENT(COUNTIF(markup_info.images_img_total > 0), COUNT(0)) AS pct_has_img,

  #  percent pages with an img alt
  SUM(markup_info.images_img_total) as total_img,
  SUM(markup_info.images_alt_present_total) as total_img_alt_present,
  SUM(markup_info.images_alt_blank_total) as total_img_alt_blank,
  SUM(markup_info.images_alt_missing_total) as total_img_alt_missing,
  AS_PERCENT(SUM(markup_info.images_alt_missing_total), SUM(markup_info.images_img_total)) AS pct_images_with_img_alt_missing,
  AS_PERCENT(SUM(markup_info.images_alt_present_total), SUM(markup_info.images_img_total)) AS pct_images_with_img_alt_present, # present does not include blank
  AS_PERCENT(SUM(markup_info.images_alt_blank_total), SUM(markup_info.images_img_total)) AS pct_images_with_img_alt_blank,
  AS_PERCENT(SUM(markup_info.images_alt_blank_total)+SUM(markup_info.images_alt_present_total), SUM(markup_info.images_img_total)) AS pct_images_with_img_alt_blank_or_present,

  ##Antoine

  # Pages with <html amp> tag
  COUNTIF(markup_info.has_html_amp_attribute) as has_html_amp_attribute,
  COUNTIF(markup_info.has_html_amp_emoji_attribute) as has_html_amp_emoji_attribute,
  AS_PERCENT(COUNTIF(markup_info.has_html_amp_attribute), COUNT(0)) AS pct_has_html_amp_attribute,
  AS_PERCENT(COUNTIF(markup_info.has_html_amp_emoji_attribute), COUNT(0)) AS pct_has_html_amp_emoji_attribute,
  AS_PERCENT(COUNTIF(markup_info.has_html_amp_emoji_attribute OR markup_info.has_html_amp_attribute), COUNT(0)) AS pct_has_html_amp_or_emoji_attribute,

  # Pages with rel=amphtml
  #COUNTIF(markup_info.has_rel_amphtml_tag) as has_rel_amphtml_tag,
  AS_PERCENT(COUNTIF(markup_info.has_rel_amphtml_tag), COUNT(0)) AS pct_has_rel_amphtml_tag


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