#standardSQL
# 08_40: Check for 'Vulnerable JS' noted in Lighthouse run
# 
#  Lighthouse score = 0 - means site contains at min 1 vulnerable JS 
#
#   `httparchive.almanac.lighthouse_mobile_1k` archive = 245 MB
#   `httparchive.lighthouse.2019_07_01_mobile` = 1.22 TB 

SELECT
    COUNT(url) AS total,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.no-vulnerable-libraries.score') as NUMERIC) = 1) AS score_sum,
    ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.no-vulnerable-libraries.score') as NUMERIC) = 1) * 100 / COUNT(url), 2) as score_percentage
FROM
    `httparchive.almanac.lighthouse_mobile_1k`
