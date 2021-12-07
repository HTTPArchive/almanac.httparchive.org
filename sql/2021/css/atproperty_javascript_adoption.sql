#standardSQL
# CSS.registerProperty adoption
# https://developer.mozilla.org/en-US/docs/Web/API/CSS/RegisterProperty
SELECT DISTINCT
  client,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  feature = 'CSSRegisterProperty'
