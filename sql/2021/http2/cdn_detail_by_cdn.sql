# standardSQL
# CDN Detail by CDN
SELECT
  percentile,
  client,
  firstHTML,
  CDN,
  ROUND(APPROX_QUANTILES(http2_3_pct, 1000)[OFFSET(percentile * 10)], 2) AS http2_3_pct
FROM (
  SELECT
    client,
    page,
    firstHTML,
    CDN,
    COUNTIF(http_version IN ('HTTP/2', 'HTTP/3', 'QUIC', 'h3-29', 'h3-Q050')) / COUNT(0) AS http2_3_pct
  FROM (
    SELECT
      client,
      page,
      firstHTML,
      IFNULL(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), '') AS CDN,
      url,
      protocol AS http_version
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01')
  GROUP BY
    client,
    page,
    firstHTML,
    CDN),
  UNNEST([0, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 100])
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
