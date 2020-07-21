#standardSQL
# Gather SEO data from lighthouse
SELECT
    COUNT(0) AS total,

    COUNTIF(is_crawlable) AS crawlable,
    COUNTIF(is_canonical) AS canonical,

    ROUND(COUNTIF(is_crawlable) * 100 / COUNT(0), 2) AS pct_crawlable,
    ROUND(COUNTIF(is_canonical) * 100 / COUNT(0), 2) AS pct_canonical,

    COUNTIF(has_title) AS title,
    COUNTIF(has_meta_description) AS meta_description,
    COUNTIF(has_title AND has_meta_description) AS title_and_meta_description,

    ROUND(COUNTIF(has_title) * 100 / COUNT(0), 2) AS pct_title,
    ROUND(COUNTIF(has_meta_description) * 100 / COUNT(0), 2) AS pct_meta_description,
    ROUND(COUNTIF(has_title AND has_meta_description) * 100 / COUNT(0), 2) AS pct_title_and_meta_description,

    COUNTIF(img_alt_on_all) AS img_alt_on_all,
    ROUND(COUNTIF(img_alt_on_all) * 100 / COUNT(0), 2) AS pct_img_alt_on_all,

    COUNTIF(robots_txt_valid) AS robots_txt_valid,
    ROUND(COUNTIF(robots_txt_valid) * 100 / COUNT(0), 2) AS pct_robots_txt_valid,

    COUNTIF(link_text_descriptive) AS link_text_descriptive,
    ROUND(COUNTIF(link_text_descriptive) * 100 / COUNT(0), 2) AS pct_link_text_descriptive  
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') = '1' AS is_crawlable,
    JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') = '1' AS is_canonical,
    JSON_EXTRACT_SCALAR(report, '$.audits.document-title.score') = '1' AS has_title,
    JSON_EXTRACT_SCALAR(report, '$.audits.meta-description.score') = '1' AS has_meta_description,
    JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') = '1' AS img_alt_on_all,
    JSON_EXTRACT_SCALAR(report, '$.audits.robots-txt.score') = '1' AS robots_txt_valid,
    JSON_EXTRACT_SCALAR(report, '$.audits.link-text.score') = '1' AS link_text_descriptive
  FROM
    `httparchive.almanac.lighthouse_mobile_1k`
    )