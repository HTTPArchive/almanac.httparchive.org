# standardSQL
# Detailed alt-svc headers
CREATE TEMPORARY FUNCTION getUpgradeHeader(payload STRING)
RETURNS STRING LANGUAGE js AS """
try {
  var $ = JSON.parse(payload);
  var headers = $.response.headers;
  return headers.find(h => h.name.toLowerCase() === 'alt-svc').value.trim();
} catch (e) {
  return '';
}
""";

SELECT
  client,
  firstHtml,
  JSON_EXTRACT_SCALAR(payload, '$._protocol') AS protocol,
  IF(url LIKE 'https://%', 'https', 'http') AS http_or_https,
  NORMALIZE_AND_CASEFOLD(getUpgradeHeader(payload)) AS upgrade,
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
