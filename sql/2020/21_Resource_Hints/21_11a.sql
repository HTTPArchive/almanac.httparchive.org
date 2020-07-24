#standardSQL
# 21_11a: Distribution of Lighthouse scores for the 'Preconnect to required origins' audit
SELECT
    JSON_EXTRACT_SCALAR(report, "$.audits.uses-rel-preconnect.score") AS score,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER () AS total,
    ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
    `httparchive.almanac.summary_pages`
JOIN
    `httparchive.almanac.lighthouse`
USING
    (url)
GROUP BY
  score
ORDER BY
  freq / total DESC