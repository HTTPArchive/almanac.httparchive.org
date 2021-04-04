#standardSQL
# 17_02f: % of Pages using a JS CDN Host

SELECT
  client,
  countif(jscdnHits > 0 ) hasJSCDNHits,
  count(0) hits,
  round(100*countif(jscdnHits > 0 ) / count(0), 2) pct
FROM
(
  SELECT
    client,
    page,
    countif(
      NET.HOST(url) in ('unpkg.com',
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
