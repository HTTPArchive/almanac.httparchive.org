#standardSQL
# Gather data from the body grouped by device
# ### are lines removed so I can test on a different table

SELECT
###  client,
  COUNT(0) AS total,

  # has hreflang
  COUNTIF(raw_hreflang_count > 0) AS raw_has_hreflang,
  ROUND(COUNTIF(raw_hreflang_count > 0) * 100 / COUNT(0), 2) AS pct_raw_has_hreflang

FROM (
  SELECT
###   client,
    # REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>') AS titletag,
    # REGEXP_EXTRACT(body, '(?i)<h1>([^(</h1>)]*)</h1>') AS h1
    ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, '(?i)<link[^>]*hreflang=[\'"]?([^\'"\\s>]+)')) AS raw_hreflang_count
  FROM
    `httparchive.almanac.response_bodies_desktop_1k`  # should be httparchive.almanac.summary_response_bodies and uncomment ###s real one costs a lot!
###  WHERE
###    firstHtml
    )
###GROUP BY
###  client