#standardSQL
# 10_06: Indexability - looking at meta tags like <meta> noindex, <link> canonicals.
SELECT
  COUNTIF(is_crawlable) AS crawlable,
  COUNTIF(is_canonical) AS canonical,
  COUNT(0) AS total,
  ROUND(COUNTIF(is_crawlable) * 100 / COUNT(0), 2) AS pct_crawlable,
  ROUND(COUNTIF(is_canonical) * 100 / COUNT(0), 2) AS pct_canonical
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') = '1' AS is_crawlable,
    JSON_EXTRACT_SCALAR(report, '$.audits.canonical.score') = '1' AS is_canonical
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`)
