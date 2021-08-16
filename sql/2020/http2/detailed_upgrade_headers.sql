# standardSQL
# Detailed upgrade headers for 20.04, 20.05 and 20.06
SELECT
  client,
  firstHtml,
  JSON_EXTRACT_SCALAR(payload, '$._protocol') AS protocol,
  IF(url LIKE 'https://%', 'https', 'http') AS http_or_https,
  regexp_extract(regexp_extract(respOtherHeaders, r'(?is)Upgrade = (.*)'), r'(?im)^([^=]*?)(?:, [a-z-]+ = .*)') IS NOT NULL AS upgrade,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01'
GROUP BY
  client,
  firstHtml,
  protocol,
  http_or_https,
  upgrade
HAVING
  num_requests >= 100
ORDER BY
  num_requests DESC
