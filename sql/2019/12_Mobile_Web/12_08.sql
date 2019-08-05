#standardSQL

# password-inputs-can-be-pasted-into

SELECT
    COUNT(url) AS total,
    COUNT(DISTINCT url) AS distinct_total,
    COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.password-inputs-can-be-pasted-into.score') as NUMERIC) = 1) AS score_sum,
    ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.password-inputs-can-be-pasted-into.score') as NUMERIC) = 1) * 100 / COUNT(url), 2) as score_percentage
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
