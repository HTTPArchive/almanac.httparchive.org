#standardSQL

# <link rel="manifest">

# dataset: `httparchive.lighthouse.2019_07_01_mobile`
# sample: `httparchive.almanac.lighthouse_mobile_1k`

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.installable-manifest.score') as NUMERIC)=1) AS `scoreSum`,
    (COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.installable-manifest.score') as NUMERIC) = 1) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.almanac.lighthouse_mobile_1k`
