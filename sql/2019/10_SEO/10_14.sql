#standardSQL

# Descriptive link text usage

# sample: `httparchive.almanac.lighthouse_mobile_1k`
# dataset: `httparchive.lighthouse.2019_07_01_desktop`

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.link-text.score') as NUMERIC)) AS `scoreSum`,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.link-text.score') as NUMERIC)) AS `scoreAverage`,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.link-text.score') as NUMERIC)) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.almanac.lighthouse_mobile_1k`

/* result: scorePercentage =  0.xxx% */
