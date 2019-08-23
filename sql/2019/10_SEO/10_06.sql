#standardSQL

# Indexability - looking at meta tags like <meta> noindex, <link> canonicals.

SELECT
    COUNT(url) AS total,

    #crawlable
    SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') AS NUMERIC)) AS crawlable_score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') AS NUMERIC)) AS crawlable_score_average,
    (SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') AS NUMERIC)) / COUNT(url)) AS crawlable_score_percentage,

    #canonical
    SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') AS NUMERIC)) AS canonical_score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') AS NUMERIC)) AS canonical_core_average,
    (SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') AS NUMERIC)) / COUNT(url)) AS canonical_score_percentage
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
