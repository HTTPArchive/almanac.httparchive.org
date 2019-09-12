#standardSQL
# 09_31: Sites containing links and buttons with accessible text
SELECT
  COUNT(0) AS total_sites,
  COUNTIF(uses_buttons) AS total_using_buttons,
  COUNTIF(uses_links) AS total_using_links,
  COUNTIF(uses_either) AS total_using_either,

  ROUND(COUNTIF(uses_buttons AND good_or_na_buttons) * 100 / COUNTIF(uses_buttons), 2) AS perc_good_buttons,
  ROUND(COUNTIF(uses_links AND good_or_na_links) * 100 / COUNTIF(uses_links), 2) AS perc_good_links,
  ROUND(COUNTIF(uses_either AND good_or_na_buttons AND good_or_na_links) * 100 / COUNTIF(uses_either), 2) AS perc_both_good
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.button-name.score') IS NOT NULL AS uses_buttons,
    JSON_EXTRACT_SCALAR(report, '$.audits.link-name.score') IS NOT NULL AS uses_links,
    JSON_EXTRACT_SCALAR(report, '$.audits.button-name.score') IS NOT NULL OR JSON_EXTRACT_SCALAR(report, '$.audits.link-name.score') IS NOT NULL AS uses_either,

    IFNULL(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.button-name.score') as NUMERIC), 1) = 1 AS good_or_na_buttons,
    IFNULL(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.link-name.score') as NUMERIC), 1) = 1 AS good_or_na_links
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
