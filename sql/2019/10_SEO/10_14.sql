#standardSQL

# Descriptive link text usage

SELECT
    COUNT(url) AS total,
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.link-text.score') as NUMERIC)) AS score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.link-text.score') as NUMERIC)) AS score_average,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.link-text.score') as NUMERIC)) * 100 / COUNT(url)) as score_percentage
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
