#standardSQL

# <meta viewport> exists and valid

SELECT
    COUNT(url) AS total,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.viewport.score') as NUMERIC) = 1) AS score_sum,
    ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.viewport.score') as NUMERIC) = 1) * 100 / COUNT(url), 2) as score_percentage
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
