# standardSQL
# CDN Sumamry
SELECT
  percentile,
  client,
  firstHTML,
  CDN,
  ROUND(APPROX_QUANTILES(http2_pct, 1000)[OFFSET(percentile * 10)], 2) AS http2_pct
FROM (
  SELECT
    client,
    page,
    firstHTML,
    CDN,
    COUNTIF(http_version IN ('HTTP/2', 'QUIC', 'http/2+quic/46')) / COUNT(0) AS http2_pct
FROM (
  SELECT
    client,
    page,
    firstHTML,
    IF(IFNULL(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), '') = '', FALSE, TRUE) AS CDN,
    url,
    JSON_EXTRACT_SCALAR(payload, '$._protocol') AS http_version
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01')
GROUP BY
  client,
  page,
  firstHTML,
  CDN),
UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
GROUP BY
  percentile,
  client,
  firstHTML,
  CDN
ORDER BY
  percentile,
  client,
  firstHTML,
  CDN
