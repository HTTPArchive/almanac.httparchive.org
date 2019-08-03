#standardSQL

# note: not sure how interesting this number is

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    # alt score
    SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') as NUMERIC)) AS `imageAltScoreSum`
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
