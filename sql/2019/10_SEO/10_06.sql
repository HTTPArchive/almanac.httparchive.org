#standardSQL

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    #crawlable
    SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') as NUMERIC)) AS `crawlableScoreSum`,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') as NUMERIC)) AS `crawlableScoreAverage`,
    (SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') as NUMERIC)) / COUNT(url)) as `crawlableScorePercentage`,
    #canonical
    SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') as NUMERIC)) AS `canonicalScoreSum`,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') as NUMERIC)) AS `canonicalScoreAverage`,
    (SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') as NUMERIC)) / COUNT(url)) as `canonicalScorePercentage`
FROM
    `httparchive.lighthouse.2019_07_01_mobile`

/* result: scorePercentage =  0.xxx% */
