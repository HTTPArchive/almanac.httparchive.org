#standardSQL
# 17_02g: % of Pages using a library CDN Host

SELECT 
  *,
  round(100*pageUseCount/ totalPagesCount,2) as Pct
FROM
(
  SELECT
    client,
    if(NET.HOST(url) in ('unpkg.com',
        'cdn.jsdelivr.net',
        'cdnjs.cloudflare.com',
        'ajax.aspnetcdn.com',
        'ajax.googleapis.com',
        'stackpath.bootstrapcdn.com',
        'maxcdn.bootstrapcdn.com',
        'use.fontawesome.com',
        'code.jquery.com',
        'fonts.googleapis.com'), NET.HOST(url), 'OTHER') jsCDN,
    count(distinct page) as pageUseCount,
    SUM(countif(firstHtml)) OVER (PARTITION BY client) AS totalPagesCount
    FROM `httparchive.almanac.requests3`
  GROUP BY
    client,
    jsCDN
)
ORDER BY 
  client DESC,
  pageUseCount DESC