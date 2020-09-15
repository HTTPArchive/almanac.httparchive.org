#standardSQL
# 17_10b: Common vary headers as seen from CDNs

SELECT
  client, firstHtml, vary,
  if(_cdn_provider != '', 'CDN', 'Origin') as source,
  count(0) as total
FROM
  `httparchive.almanac.requests`,
  UNNEST(split(REGEXP_REPLACE(REGEXP_REPLACE(lower(resp_vary), '\"', ''), '[, ]+|\\\\0', ','), ',')) as vary
group by
  client, firstHtml, vary, source
having
  vary <> '' and vary is not null
order by
  client desc,
  firstHtml desc,
  total desc