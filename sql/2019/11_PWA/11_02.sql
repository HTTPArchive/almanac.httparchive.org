#standardSQL
# 08_40: Check for 'Installable Manifest' missing noted in Lighthouse run
# 
#  Lighthouse score = 0 - means site does not contain an installable Manifest file
#
#   Per Lighthouse : The manifest that Lighthouse fetches is separate from the one that 
#      Chrome is using on the page, which can possibly cause inaccurate results.
#
#   Follow up on deeper review
#
#   `httparchive.almanac.lighthouse_mobile_1k` archive = 245 MB
#   `httparchive.lighthouse.2019_07_01_mobile` = 1.22 TB 

SELECT
    COUNT(url) AS total,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.installable-manifest.score') as NUMERIC) = 1) AS score_sum,
    ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.installable-manifest.score') as NUMERIC) = 1) * 100 / COUNT(url), 2) as score_percentage
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
