#standardSQL

# dataset: `httparchive.lighthouse.2019_07_01_mobile`
# sample: `httparchive.almanac.lighthouse_mobile_1k`

# <title> and <meta description> present

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,

    #title
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) AS `titleScoreSum`,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) AS `titleScoreAverage`,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) / COUNT(url)) as `titleScorePercentage`,

    #description
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) AS `descriptionScoreSum`,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) AS `descriptionScoreAverage`,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) / COUNT(url)) as `descriptionScorePercentage`

FROM
    `httparchive.almanac.lighthouse_mobile_1k`

/* result: scorePercentage =  0.xxx% */
