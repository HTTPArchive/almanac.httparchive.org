-- Pages that use DNT feature

FROM `httparchive.blink_features.usage`
|> WHERE
  date = '2025-07-01' AND
  --rank <= 10000 AND
  feature = 'NavigatorDoNotTrack'
|> SELECT DISTINCT
  client,
  rank,
  num_urls,
  pct_urls
|> PIVOT (
  ANY_VALUE(num_urls) AS pages_count,
  ANY_VALUE(pct_urls) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop
|> ORDER BY rank ASC
