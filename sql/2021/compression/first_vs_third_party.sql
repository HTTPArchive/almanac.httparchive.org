#standardSQL
# first_vs_third_party.sql : content encoding summary by party
SELECT
  client,
  IF(NET.HOST(url) IN (
    SELECT
      domain
    FROM
      `httparchive.almanac.third_parties`
    WHERE
      date = '2021-07-01' AND
      category != 'hosting'
  ), 'third party', 'first party') AS party,
  resp_content_encoding,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client,
  party,
  resp_content_encoding
ORDER BY
  num_requests DESC
