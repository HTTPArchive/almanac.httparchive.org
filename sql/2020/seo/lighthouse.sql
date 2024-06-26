#standardSQL
# Gather SEO data from lighthouse

# live run is about $9

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT(freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

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
  AS_PERCENT(COUNTIF(is_canonical), COUNT(0)) AS pct_is_canonical,

  COUNTIF(has_title) AS has_title,
  AS_PERCENT(COUNTIF(has_title), COUNT(0)) AS pct_has_title,

  COUNTIF(has_meta_description) AS has_meta_description,
  AS_PERCENT(COUNTIF(has_meta_description), COUNT(0)) AS pct_has_meta_description,

  COUNTIF(has_title AND has_meta_description) AS has_title_and_meta_description,
  AS_PERCENT(COUNTIF(has_title AND has_meta_description), COUNT(0)) AS pct_has_title_and_meta_description,

  COUNTIF(img_alt_on_all) AS img_alt_on_all,
  AS_PERCENT(COUNTIF(img_alt_on_all), COUNT(0)) AS pct_img_alt_on_all,

  COUNTIF(link_text_descriptive) AS link_text_descriptive,
  AS_PERCENT(COUNTIF(link_text_descriptive), COUNT(0)) AS pct_link_text_descriptive,

  COUNTIF(robots_txt_valid) AS robots_txt_valid,
  AS_PERCENT(COUNTIF(robots_txt_valid), COUNT(0)) AS pct_robots_txt_valid,

  COUNTIF(is_crawlable) AS is_crawlable,
  AS_PERCENT(COUNTIF(is_crawlable), COUNT(0)) AS pct_is_crawlable,

  COUNTIF(is_crawlable_details.noindex) AS noindex,
  AS_PERCENT(COUNTIF(is_crawlable_details.noindex), COUNT(0)) AS pct_noindex,

  COUNTIF(is_crawlable_details.disallow) AS disallow,
  AS_PERCENT(COUNTIF(is_crawlable_details.disallow), COUNT(0)) AS pct_disallow,

  COUNTIF(is_crawlable_details.disallow AND is_crawlable_details.noindex) AS disallow_noindex,
  AS_PERCENT(COUNTIF(is_crawlable_details.disallow AND is_crawlable_details.noindex), COUNT(0)) AS pct_disallow_noindex,

  COUNTIF(NOT (is_crawlable_details.disallow) AND NOT (is_crawlable_details.noindex)) AS allow_index,
  AS_PERCENT(COUNTIF(NOT (is_crawlable_details.disallow) AND NOT (is_crawlable_details.noindex)), COUNT(0)) AS pct_allow_index,

  COUNTIF(is_crawlable_details.disallow AND NOT (is_crawlable_details.noindex)) AS disallow_index,
  AS_PERCENT(COUNTIF(is_crawlable_details.disallow AND NOT (is_crawlable_details.noindex)), COUNT(0)) AS pct_disallow_index,

  COUNTIF(NOT (is_crawlable_details.disallow) AND is_crawlable_details.noindex) AS allow_noindex,
  AS_PERCENT(COUNTIF(NOT (is_crawlable_details.disallow) AND is_crawlable_details.noindex), COUNT(0)) AS pct_allow_noindex
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') = '1' AS is_crawlable,
    JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') = '1' AS is_canonical,
    JSON_EXTRACT_SCALAR(report, '$.audits.document-title.score') = '1' AS has_title,
    JSON_EXTRACT_SCALAR(report, '$.audits.meta-description.score') = '1' AS has_meta_description,
    JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') = '1' AS img_alt_on_all,
    JSON_EXTRACT_SCALAR(report, '$.audits.robots-txt.score') = '1' AS robots_txt_valid,
    JSON_EXTRACT_SCALAR(report, '$.audits.link-text.score') = '1' AS link_text_descriptive,
    isCrawlableDetails(report) AS is_crawlable_details
  FROM
    `httparchive.lighthouse.2020_08_01_*`
)
