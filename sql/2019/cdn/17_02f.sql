#standardSQL
# 17_02f: % of Pages using a JS CDN Host

SELECT
  client,
  COUNTIF(jscdnHits > 0 ) hasJSCDNHits,
  COUNT(0) hits,
  ROUND(100*COUNTIF(jscdnHits > 0 ) / COUNT(0), 2) pct
FROM
(
  SELECT
    client,
    page,
    COUNTIF(
      NET.HOST(url) IN ('unpkg.com',
        'www.jsdelivr.net',
        'cdnjs.cloudflare.com',
        'ajax.aspnetcdn.com',
        'ajax.googleapis.com',
        'stackpath.bootstrapcdn.com',
        'maxcdn.bootstrapcdn.com',
        'use.fontawesome.com',
        'code.jquery.com',
        'fonts.googleapis.com')
        ) jscdnHits
  FROM `httparchive.almanac.requests3`
  GROUP BY
    client,
    page
)
GROUP BY
  client
ORDER BY
  client DESC
