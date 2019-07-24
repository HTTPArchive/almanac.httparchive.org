#standardSQL
SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    SUM(CAST(JSON_EXTRACT(report, '$.audits.hreflang.score') as NUMERIC)) AS `scoreSum`,
    AVG(CAST(JSON_EXTRACT(report, '$.audits.hreflang.score') as NUMERIC)) AS `scoreAverage`,
    (SUM(CAST(JSON_EXTRACT(report, '$.audits.hreflang.score') as NUMERIC)) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.lighthouse.2019_07_01_mobile`

/* result: scorePercentage =  0.xxx% */
