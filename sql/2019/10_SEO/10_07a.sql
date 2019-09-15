#standardSQL

# <title> and <meta description> present

SELECT
    COUNT(url) AS total,

    #title
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') AS NUMERIC)) AS title_score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') AS NUMERIC)) AS title_score_average,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') AS NUMERIC)) / COUNT(url)) AS title_score_percentage,

    #description
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') AS NUMERIC)) AS description_score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') AS NUMERIC)) AS description_score_average,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') AS NUMERIC)) / COUNT(url)) AS description_score_percentage

FROM
    `httparchive.lighthouse.2019_07_01_mobile`
