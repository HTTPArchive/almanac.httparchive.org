#standardSQL
# Image alt stats

# Returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup JSON)
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

WITH processed_data AS (
  SELECT
    client,
    root_page,
    page,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    get_markup_info(custom_metrics.markup) AS markup_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  percentile,
  client,
  is_root_page,
  # Images per page
  APPROX_QUANTILES(markup_info.images_img_total, 1000)[OFFSET(percentile * 10)] AS img_count,

  # Percent of images containing alt text (not blank)
  APPROX_QUANTILES(SAFE_DIVIDE(markup_info.images_with_alt_present, markup_info.images_img_total), 1000)[OFFSET(percentile * 10)] AS images_with_alt_present_percent,

  # Percent of images containing a blank alt text
  APPROX_QUANTILES(SAFE_DIVIDE(markup_info.images_with_alt_blank, markup_info.images_img_total), 1000)[OFFSET(percentile * 10)] AS images_with_alt_blank_percent,

  # Percent of images without an alt attribute
  APPROX_QUANTILES(SAFE_DIVIDE(markup_info.images_with_alt_missing, markup_info.images_img_total), 1000)[OFFSET(percentile * 10)] AS images_with_alt_missing_percent,

  # Number of images containing alt text (not blank)
  APPROX_QUANTILES(markup_info.images_with_alt_present, 1000)[OFFSET(percentile * 10)] AS images_with_alt_present,

  # Number of images containing a blank alt text
  APPROX_QUANTILES(markup_info.images_with_alt_blank, 1000)[OFFSET(percentile * 10)] AS images_with_alt_blank,

  # Number of images without an alt attribute
  APPROX_QUANTILES(markup_info.images_with_alt_missing, 1000)[OFFSET(percentile * 10)] AS images_with_alt_missing,
  COUNT(DISTINCT page) AS sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM
  processed_data,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  is_root_page,
  client
ORDER BY
  percentile,
  client;
