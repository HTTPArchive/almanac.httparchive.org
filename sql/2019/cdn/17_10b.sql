#standardSQL
# 17_10b: Common vary headers as seen from CDNs

SELECT
  client, firstHtml, vary,
  if(_cdn_provider != '', 'CDN', 'Origin') as source,
  count(0) as total
FROM
  `httparchive.almanac.requests`,
  UNNEST(split(REGEXP_REPLACE(REGEXP_REPLACE(lower(resp_vary), '\"', ''), '[, ]+|\\\\0', ','), ',')) as vary
WHERE
  date = '2019-07-01'
GROUP BY
  client, firstHtml, vary, source
HAVING
  vary <> '' AND vary IS NOT NULL
ORDER BY
  client DESC,
  firstHtml DESC,
  total DESC
