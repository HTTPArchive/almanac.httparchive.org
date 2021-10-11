#standardSQL
# Image alt stats

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  images_img_total INT64,
  images_with_alt_present INT64,
  images_with_alt_blank INT64,
  images_with_alt_missing INT64
> LANGUAGE js AS '''
var result = {
  images_img_total: 0,
  images_with_alt_present: 0,
  images_with_alt_blank: 0,
  images_with_alt_missing: 0
};
try {
    var markup = JSON.parse(markup_string);

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.images) {
      if (markup.images.img) {
        var img = markup.images.img;
        result.images_img_total = img.total;

        if (img.alt) {
          result.images_with_alt_present = img.alt.present;
          result.images_with_alt_blank = img.alt.blank;
          result.images_with_alt_missing = img.alt.missing;
        }
      }
    }

} catch (e) {}
return result;
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # images per page
  APPROX_QUANTILES(markup_info.images_img_total, 1000)[OFFSET(percentile * 10)] AS img_count,

  # percent of images containg alt text (not blank)
  APPROX_QUANTILES(SAFE_DIVIDE(markup_info.images_with_alt_present, markup_info.images_img_total), 1000)[OFFSET(percentile * 10)] AS images_with_alt_present_percent,

  # percent of images containg a blank alt text
  APPROX_QUANTILES(SAFE_DIVIDE(markup_info.images_with_alt_blank, markup_info.images_img_total), 1000)[OFFSET(percentile * 10)] AS images_with_alt_blank_percent,

  # percent of images without an alt attribute
  APPROX_QUANTILES(SAFE_DIVIDE(markup_info.images_with_alt_missing, markup_info.images_img_total), 1000)[OFFSET(percentile * 10)] AS images_with_alt_missing_percent,

  # number of images containg alt text (not blank)
  APPROX_QUANTILES(markup_info.images_with_alt_present, 1000)[OFFSET(percentile * 10)] AS images_with_alt_present,

  # number of images containg a blank alt text
  APPROX_QUANTILES(markup_info.images_with_alt_blank, 1000)[OFFSET(percentile * 10)] AS images_with_alt_blank,

  # number of images without an alt attribute
  APPROX_QUANTILES(markup_info.images_with_alt_missing, 1000)[OFFSET(percentile * 10)] AS images_with_alt_missing

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST([10, 25, 50, 75, 90]) AS percentile
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
