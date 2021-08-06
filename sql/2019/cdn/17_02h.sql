#standardSQL
# 17_02g: % of Pages using a library CDN Host

SELECT
  *,
  round(100*pageUseCount/ totalPagesCount,2) AS Pct
FROM
(
  SELECT
    client,
    IF(NET.HOST(url) in ('unpkg.com',
        'cdn.jsdelivr.net',
        'cdnjs.cloudflare.com',
        'ajax.aspnetcdn.com',
        'ajax.googleapis.com',
        'stackpath.bootstrapcdn.com',
        'maxcdn.bootstrapcdn.com',
        'use.fontawesome.com',
        'code.jquery.com',
        'fonts.googleapis.com'), NET.HOST(url), 'OTHER') jsCDN,
    count(distinct page) AS pageUseCount,
    SUM(countIF(firstHtml)) OVER (PARTITION BY client) AS totalPagesCount
    FROM `httparchive.almanac.requests3`
  GROUP BY
    client,
    jsCDN
)
ORDER BY
  client DESC,
  pageUseCount DESC
