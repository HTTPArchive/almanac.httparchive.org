#standardSQL
# 17_02g: % of Pages using a JS CDN Host
SELECT
  *,
  round(100*pageUseCount/ totalPagesCount,2) as Pct # doing the Pct calc causes memory problems with bigquery
FROM
(
  SELECT
    client,
    if(respBodySize > 0 and regexp_contains(resp_content_type, r'javascript|css|font'), NET.HOST(url), null) as host,
    count(distinct page) as pageUseCount,
    SUM(countif(firstHtml)) OVER (PARTITION BY client) AS totalPagesCount
    FROM `httparchive.almanac.requests3`
  GROUP BY
    client,
    host
) resp_content_type
WHERE host is not null AND pageUseCount > 1000
ORDER BY
  client DESC,
  pageUseCount DESC
