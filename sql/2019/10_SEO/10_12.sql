#standardSQL

# robots.txt

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.robots-txt.score') as NUMERIC)) AS `scoreSum`,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.robots-txt.score') as NUMERIC)) AS `scoreAverage`,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.robots-txt.score') as NUMERIC)) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
