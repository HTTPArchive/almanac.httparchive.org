#standardSQL
# pages markup metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  images_img_total INT64,
  images_alt_missing_total INT64,
  images_alt_blank_total INT64,
  images_alt_present_total INT64,

  has_html_amp_attribute BOOL,
  has_rel_amphtml_tag BOOL,
  has_html_amp_emoji_attribute BOOL
> LANGUAGE js AS '''
var result = {
  images_img_total: 0,
  images_alt_missing_total: 0,
  images_alt_blank_total: 0,
  images_alt_present_total: 0,
  has_html_amp_attribute: false,
  has_rel_amphtml_tag: false,
  has_html_amp_emoji_attribute: false
};
try {
    var markup = JSON.parse(markup_string);

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.images) {
      if (markup.images.img) {
        var img = markup.images.img;
        result.images_img_total = img.total;

        if (img.alt) {
          var alt = img.alt;
            result.images_alt_missing_total = alt.missing;
            result.images_alt_blank_total = alt.blank;
            result.images_alt_present_total = alt.present; // present does not include blank
        }
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

  # Pages with img
  AS_PERCENT(COUNTIF(markup_info.images_img_total > 0), COUNT(0)) AS pct_has_img,

  #  percent pages with an img alt
  SUM(markup_info.images_img_total) AS total_img,
  SUM(markup_info.images_alt_present_total) AS total_img_alt_present,
  SUM(markup_info.images_alt_blank_total) AS total_img_alt_blank,
  SUM(markup_info.images_alt_missing_total) AS total_img_alt_missing,
  AS_PERCENT(SUM(markup_info.images_alt_missing_total), SUM(markup_info.images_img_total)) AS pct_images_with_img_alt_missing,
  AS_PERCENT(SUM(markup_info.images_alt_present_total), SUM(markup_info.images_img_total)) AS pct_images_with_img_alt_present, # present does not include blank
  AS_PERCENT(SUM(markup_info.images_alt_blank_total), SUM(markup_info.images_img_total)) AS pct_images_with_img_alt_blank,
  AS_PERCENT(SUM(markup_info.images_alt_blank_total) + SUM(markup_info.images_alt_present_total), SUM(markup_info.images_img_total)) AS pct_images_with_img_alt_blank_or_present,

  # Pages with <html amp> tag
  COUNTIF(markup_info.has_html_amp_attribute) AS has_html_amp_attribute,
  COUNTIF(markup_info.has_html_amp_emoji_attribute) AS has_html_amp_emoji_attribute,
  AS_PERCENT(COUNTIF(markup_info.has_html_amp_attribute), COUNT(0)) AS pct_has_html_amp_attribute,
  AS_PERCENT(COUNTIF(markup_info.has_html_amp_emoji_attribute), COUNT(0)) AS pct_has_html_amp_emoji_attribute,
  AS_PERCENT(COUNTIF(markup_info.has_html_amp_emoji_attribute OR markup_info.has_html_amp_attribute), COUNT(0)) AS pct_has_html_amp_or_emoji_attribute,

  # Pages with rel=amphtml
  AS_PERCENT(COUNTIF(markup_info.has_rel_amphtml_tag), COUNT(0)) AS pct_has_rel_amphtml_tag

FROM
  (
    SELECT
      _TABLE_SUFFIX AS client,
      get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info
    FROM
      `httparchive.pages.2020_08_01_*`
  )
GROUP BY
  client
