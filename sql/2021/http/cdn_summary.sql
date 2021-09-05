# standardSQL
# CDN Sumamry
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
    COUNTIF(LOWER(http_version) IN ('http/2', 'http/3', 'quic', 'h3-29', 'h3-q050')) / COUNT(0) AS http2_3_pct
  FROM (
    SELECT
      client,
      page,
      firstHTML,
      IF(IFNULL(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), '') = '', FALSE, TRUE) AS CDN,
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
