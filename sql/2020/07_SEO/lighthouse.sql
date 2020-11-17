#standardSQL
# Gather SEO data from lighthouse

# live run is about $9

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION isCrawlable(report STRING) 
RETURNS STRUCT<
disallow BOOL, 
noindex BOOL,
both BOOL,
neither BOOL
> DETERMINISTIC LANGUAGE js AS '''
var result = {disallow:false, noindex:false};
try {
    var $ = JSON.parse(report);
    var items = $.audits['is-crawlable'].details.items;
    result.noindex = items.filter(item => item.source.type ==='node').length > 0;
    result.disallow = items.filter(item => item.source.type ==='source-location').length > 0;
    result.both = result.noindex && result.disallow;
    result.neither = !result.noindex && !result.disallow;
} catch (e) {
}
return result;
''';


SELECT
    COUNT(0) AS total,

    COUNTIF(is_crawlable) AS crawlable,
    COUNTIF(is_canonical) AS canonical,

    AS_PERCENT(COUNTIF(is_crawlable), COUNT(0)) AS pct_crawlable,
    AS_PERCENT(COUNTIF(is_canonical), COUNT(0)) AS pct_canonical,

    COUNTIF(has_title) AS title,
    COUNTIF(has_meta_description) AS meta_description,
    COUNTIF(has_title AND has_meta_description) AS title_and_meta_description,

    AS_PERCENT(COUNTIF(has_title), COUNT(0)) AS pct_title,
    AS_PERCENT(COUNTIF(has_meta_description), COUNT(0)) AS pct_meta_description,
    AS_PERCENT(COUNTIF(has_title AND has_meta_description), COUNT(0)) AS pct_title_and_meta_description,

    COUNTIF(img_alt_on_all) AS img_alt_on_all,
    AS_PERCENT(COUNTIF(img_alt_on_all), COUNT(0)) AS pct_img_alt_on_all,

    COUNTIF(robots_txt_valid) AS robots_txt_valid,
    AS_PERCENT(COUNTIF(robots_txt_valid), COUNT(0)) AS pct_robots_txt_valid,

    COUNTIF(link_text_descriptive) AS link_text_descriptive,
    AS_PERCENT(COUNTIF(link_text_descriptive), COUNT(0)) AS pct_link_text_descriptive,

    COUNTIF(isCrawlable.noindex) AS noindex,
    AS_PERCENT(COUNTIF(isCrawlable.noindex), COUNT(0)) AS pct_noindex,  

    COUNTIF(isCrawlable.disallow) AS disallow,
    AS_PERCENT(COUNTIF(isCrawlable.disallow), COUNT(0)) AS pct_disallow,  

    COUNTIF(isCrawlable.both) AS both,
    AS_PERCENT(COUNTIF(isCrawlable.both), COUNT(0)) AS pct_both,  

    COUNTIF(isCrawlable.neither) AS neither,
    AS_PERCENT(COUNTIF(isCrawlable.neither), COUNT(0)) AS pct_neither,  
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') = '1' AS is_crawlable,
    JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') = '1' AS is_canonical,
    JSON_EXTRACT_SCALAR(report, '$.audits.document-title.score') = '1' AS has_title,
    JSON_EXTRACT_SCALAR(report, '$.audits.meta-description.score') = '1' AS has_meta_description,
    JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') = '1' AS img_alt_on_all,
    JSON_EXTRACT_SCALAR(report, '$.audits.robots-txt.score') = '1' AS robots_txt_valid,
    JSON_EXTRACT_SCALAR(report, '$.audits.link-text.score') = '1' AS link_text_descriptive,
    isCrawlable(report) AS isCrawlable
  FROM
    #`httparchive.lighthouse.2020_08_01_*`
    `httparchive.sample_data.lighthouse_mobile_10k`
    )
    
