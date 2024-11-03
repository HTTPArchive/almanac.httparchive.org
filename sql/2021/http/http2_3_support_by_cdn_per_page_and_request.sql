# standardSQL
# HTTP/2+ support per CDN by page and request
SELECT
  client,
  CDN,
  COUNTIF(firstHTML) AS pages,
  COUNTIF(http2_3 AND firstHTML) AS http2_3_pages,
  SAFE_DIVIDE(COUNTIF(http2_3 AND firstHTML), COUNTIF(firstHTML)) AS http2_3_page_pct,
  COUNTIF(http2_3) AS http2_3_requests,
  COUNTIF(http2_3) / COUNT(0) AS http2_3_request_pct
FROM (
  SELECT
    client,
    page,
    firstHTML,
    IFNULL(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), '') AS CDN,
    url,
    LOWER(protocol) IN ('http/2', 'http/3', 'quic', 'h3-29', 'h3-q050') AS http2_3
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01'
)
GROUP BY
  client,
  CDN
ORDER BY
  http2_3_request_pct DESC,
  client,
  CDN
