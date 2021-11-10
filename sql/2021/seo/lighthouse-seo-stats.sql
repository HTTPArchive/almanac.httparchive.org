#standardSQL
# Lighthouse SEO stats

# live run is about $9

CREATE TEMPORARY FUNCTION isCrawlableDetails(report STRING)
RETURNS STRUCT<
  disallow BOOL,
  noindex BOOL,
  both BOOL,
  neither BOOL
>
DETERMINISTIC
LANGUAGE js
AS '''
var result = {disallow: false, noindex: false};
try {
    var $ = JSON.parse(report);
    var items = $.audits['is-crawlable'].details.items;
    result.noindex = items.filter(item => item.source.type ==='node').length > 0;
    result.disallow = items.filter(item => item.source.type ==='source-location').length > 0;
} catch (e) {
}
return result;
''';

SELECT
  COUNT(0) AS total,

  COUNTIF(is_canonical) AS is_canonical,
  SAFE_DIVIDE(COUNTIF(is_canonical), COUNT(0)) AS pct_is_canonical,

  COUNTIF(has_title) AS has_title,
  SAFE_DIVIDE(COUNTIF(has_title), COUNT(0)) AS pct_has_title,

  COUNTIF(has_meta_description) AS has_meta_description,
  SAFE_DIVIDE(COUNTIF(has_meta_description), COUNT(0)) AS pct_has_meta_description,

  COUNTIF(has_title AND has_meta_description) AS has_title_and_meta_description,
  SAFE_DIVIDE(COUNTIF(has_title AND has_meta_description), COUNT(0)) AS pct_has_title_and_meta_description,

  COUNTIF(img_alt_on_all) AS img_alt_on_all,
  SAFE_DIVIDE(COUNTIF(img_alt_on_all), COUNT(0)) AS pct_img_alt_on_all,

  COUNTIF(link_text_descriptive) AS link_text_descriptive,
  SAFE_DIVIDE(COUNTIF(link_text_descriptive), COUNT(0)) AS pct_link_text_descriptive,

  COUNTIF(legible_font_size) AS legible_font_size,
  SAFE_DIVIDE(COUNTIF(legible_font_size), COUNT(0)) AS pct_legible_font_size,

  COUNTIF(heading_order_valid) AS heading_order_valid,
  SAFE_DIVIDE(COUNTIF(heading_order_valid), COUNT(0)) AS pct_heading_order_valid,

  COUNTIF(robots_txt_valid) AS robots_txt_valid,
  SAFE_DIVIDE(COUNTIF(robots_txt_valid), COUNT(0)) AS pct_robots_txt_valid,

  COUNTIF(is_crawlable) AS is_crawlable,
  SAFE_DIVIDE(COUNTIF(is_crawlable), COUNT(0)) AS pct_is_crawlable,

  COUNTIF(is_crawlable_details.noindex) AS noindex,
  SAFE_DIVIDE(COUNTIF(is_crawlable_details.noindex), COUNT(0)) AS pct_noindex,

  COUNTIF(is_crawlable_details.disallow) AS disallow,
  SAFE_DIVIDE(COUNTIF(is_crawlable_details.disallow), COUNT(0)) AS pct_disallow,

  COUNTIF(is_crawlable_details.disallow AND is_crawlable_details.noindex) AS disallow_noindex,
  SAFE_DIVIDE(COUNTIF(is_crawlable_details.disallow AND is_crawlable_details.noindex), COUNT(0)) AS pct_disallow_noindex,

  COUNTIF(NOT(is_crawlable_details.disallow) AND NOT(is_crawlable_details.noindex)) AS allow_index,
  SAFE_DIVIDE(COUNTIF(NOT(is_crawlable_details.disallow) AND NOT(is_crawlable_details.noindex)), COUNT(0)) AS pct_allow_index,

  COUNTIF(is_crawlable_details.disallow AND NOT(is_crawlable_details.noindex)) AS disallow_index,
  SAFE_DIVIDE(COUNTIF(is_crawlable_details.disallow AND NOT(is_crawlable_details.noindex)), COUNT(0)) AS pct_disallow_index,

  COUNTIF(NOT(is_crawlable_details.disallow) AND is_crawlable_details.noindex) AS allow_noindex,
  SAFE_DIVIDE(COUNTIF(NOT(is_crawlable_details.disallow) AND is_crawlable_details.noindex), COUNT(0)) AS pct_allow_noindex
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') = '1' AS is_crawlable,
    JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') = '1' AS is_canonical,
    JSON_EXTRACT_SCALAR(report, '$.audits.document-title.score') = '1' AS has_title,
    JSON_EXTRACT_SCALAR(report, '$.audits.meta-description.score') = '1' AS has_meta_description,
    JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') = '1' AS img_alt_on_all,
    JSON_EXTRACT_SCALAR(report, '$.audits.robots-txt.score') = '1' AS robots_txt_valid,
    JSON_EXTRACT_SCALAR(report, '$.audits.link-text.score') = '1' AS link_text_descriptive,
    JSON_EXTRACT_SCALAR(report, '$.audits.font-size.score') = '1' AS legible_font_size,
    JSON_EXTRACT_SCALAR(report, '$.audits.heading-order.score') = '1' AS heading_order_valid,
    isCrawlableDetails(report) AS is_crawlable_details
  FROM
    `httparchive.lighthouse.2021_07_01_*`
)
