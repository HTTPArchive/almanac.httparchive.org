#standardSQL

# color-contrast
# score is not binary


# sample: `httparchive.almanac.lighthouse_mobile_1k`
# dataset: `httparchive.lighthouse.2019_07_01_mobile`

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC)=1) AS `scoreSum`,
    AVG(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC)) AS `scoreAverage`,
    (COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC) = 1) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.almanac.lighthouse_mobile_1k`
