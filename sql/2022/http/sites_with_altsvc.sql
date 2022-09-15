#standardSQL
# Fraction of sites with alt-svc header
SELECT
  client,
  COUNTIF(CONTAINS_SUBSTR(response_headers, 'alt-svc')) AS sites_with_altsvc,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(CONTAINS_SUBSTR(response_headers, 'alt-svc')) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_sites_with_altsvc
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  firstHtml
GROUP BY
  client
ORDER BY
  pct_sites_with_altsvc DESC
