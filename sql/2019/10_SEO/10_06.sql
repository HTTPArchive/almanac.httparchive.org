#standardSQL

# Indexability - looking at meta tags like <meta> noindex, <link> canonicals.

SELECT
    COUNT(url) AS total,

    #crawlable
    SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') as NUMERIC)) AS crawlable_score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') as NUMERIC)) AS crawlable_score_average,
    (SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') as NUMERIC)) / COUNT(url)) as crawlable_score_percentage,

    #canonical
    SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') as NUMERIC)) AS canonical_score_sum,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') as NUMERIC)) AS canonical_core_average,
    (SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') as NUMERIC)) / COUNT(url)) as canonical_score_percentage
FROM
    `httparchive.lighthouse.2019_07_01_mobile`
