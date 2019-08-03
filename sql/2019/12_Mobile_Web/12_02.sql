#standardSQL

# font-size
# score is not binary

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.font-size.score') as NUMERIC)=1) AS `scoreSum`,
    AVG(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.font-size.score') as NUMERIC)) AS `scoreAverage`,
    (COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.font-size.score') as NUMERIC) = 1) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
