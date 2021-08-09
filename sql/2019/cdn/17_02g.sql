#standardSQL
# 17_02g: % of Pages using a JS CDN Host
SELECT
  *,
  ROUND(100 * pageUseCount / totalPagesCount, 2) AS Pct # doing the Pct calc causes memory problems with bigquery
FROM
(
  SELECT
    client,
    IF(respBodySize > 0 AND REGEXP_CONTAINS(resp_content_type, r'javascript|css|font'), NET.HOST(url), NULL) AS host,
    COUNT(DISTINCT page) AS pageUseCount,
    SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client) AS totalPagesCount
    FROM `httparchive.almanac.requests3`
  GROUP BY
    client,
    host
)
WHERE host IS NOT NULL AND pageUseCount > 1000
ORDER BY
  client DESC,
  pageUseCount DESC
