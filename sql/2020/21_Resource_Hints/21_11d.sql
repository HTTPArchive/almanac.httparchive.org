#standardSQL
SELECT
    ARRAY_LENGTH(JSON_EXTRACT_ARRAY(report, '$.audits.uses-rel-preconnect.warnings')) warnings,
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
  warnings
ORDER BY
  warnings ASC