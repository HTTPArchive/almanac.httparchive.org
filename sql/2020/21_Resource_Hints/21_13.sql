#standardSQL
# 21_13: Distribution of Lighthouse scores for the 'Defer offscreen images' audit
SELECT
    JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.score") AS score,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER () AS total,
    ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
    `httparchive.almanac.summary_pages`
WHERE
    edition = "2020"
JOIN
    `httparchive.almanac.lighthouse`
USING
(url)
GROUP BY
  score
ORDER BY
  freq / total DESC