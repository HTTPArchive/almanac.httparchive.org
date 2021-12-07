#standardSQL
# 17_02g: % of Pages using a library CDN Host

SELECT
  *,
  ROUND(100 * pageUseCount / totalPagesCount, 2) AS Pct
FROM
  (
    SELECT
      client,
      IF(NET.HOST(url) IN ('unpkg.com',
          'cdn.jsdelivr.net',
          'cdnjs.cloudflare.com',
          'ajax.aspnetcdn.com',
          'ajax.googleapis.com',
          'stackpath.bootstrapcdn.com',
          'maxcdn.bootstrapcdn.com',
          'use.fontawesome.com',
          'code.jquery.com',
          'fonts.googleapis.com'), NET.HOST(url), 'OTHER') AS jsCDN,
      COUNT(DISTINCT page) AS pageUseCount,
      SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client) AS totalPagesCount
    FROM `httparchive.almanac.requests3`
    GROUP BY
      client,
      jsCDN
  )
ORDER BY
  client DESC,
  pageUseCount DESC
