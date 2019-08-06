#standardSQL

# <title> and <meta description> present

SELECT
    COUNT(url) AS total,
    COUNT(DISTINCT url) AS distinct_total,

    #title
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) AS title_score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) AS title_score_average,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) / COUNT(url)) as title_score_percentage,

    #description
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) AS description_score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) AS description_score_average,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) / COUNT(url)) as description_score_percentage

FROM
    `httparchive.lighthouse.2019_07_01_mobile`
