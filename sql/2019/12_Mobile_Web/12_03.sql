#standardSQL

# color-contrast
# score is not binary

SELECT
    COUNT(url) AS total,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC) = 1) AS score_sum,
    AVG(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC)) AS score_average,
    ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC) = 1) * 100 / COUNT(url), 2) as score_percentage
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
