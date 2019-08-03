#standardSQL

# <meta viewport> not scaleble

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.meta-viewport.score') as NUMERIC)=1) AS `scoreSum`,
    (COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.meta-viewport.score') as NUMERIC) = 1) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
