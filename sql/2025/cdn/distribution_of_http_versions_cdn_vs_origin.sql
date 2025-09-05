#standardSQL
# distribution_of_http_versions_cdn_vs_origin.sql 17_19: Percentage of HTTPS responses by protocol
SELECT
  a.client,
  IF(cdn = 'Origin', 'Origin', 'CDN') AS cdn,
  is_main_document,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/1.1') AS http11,
  COUNTIF(IFNULL(a.protocol, b.protocol) IN ('HTTP/2', 'H3-29', 'H3-Q050')) AS http2plus,
  COUNTIF(IFNULL(a.protocol, b.protocol) NOT IN ('HTTP/1.1', 'HTTP/2', 'H3-29', 'H3-Q050')) AS http_other,
  COUNT(0) AS total,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/1.1') / COUNT(0) AS http11_pct,
  COUNTIF(IFNULL(a.protocol, b.protocol) IN ('HTTP/2', 'H3-29', 'H3-Q050')) / COUNT(0) AS http2plus_pct,
  COUNTIF(IFNULL(a.protocol, b.protocol) NOT IN ('HTTP/1.1', 'HTTP/2', 'H3-29', 'H3-Q050')) / COUNT(0) AS http_other_pct
FROM (
  SELECT
    client,
    page,
    url,
    is_main_document,
    SAFE_CAST(JSON_VALUE(payload, '$._socket') AS INT64) AS socket,
    # WPT is inconsistent with protocol population.
    UPPER(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(concat('HTTP/', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'HTTP/')))) AS protocol,

    # WPT joins CDN detection but we bias to the DNS detection which is the first entry
    IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'Origin') AS cdn
  FROM
    `httparchive.crawl.requests`
  CROSS JOIN UNNEST(response_headers) AS r
  WHERE
    # WPT changes the response fields based on a redirect (url becomes the Location path instead of the original) causing insonsistencies in the counts, so we ignore them
    date = '2025-07-01' AND
    r.name = 'location' AND
    (r.value = '' OR r.value IS NULL)
) AS a
LEFT JOIN (
  SELECT
    client,
    page,
    SAFE_CAST(JSON_VALUE(payload, '$._socket') AS INT64) AS socket,
    ANY_VALUE(UPPER(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(CONCAT('HTTP/', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'HTTP/'))))) AS protocol
  FROM
    `httparchive.crawl.requests`
  WHERE
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL AND
    IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(CONCAT('HTTP/', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'HTTP/'))) IS NOT NULL AND
    JSON_EXTRACT(payload, '$._socket') IS NOT NULL AND
    date = '2025-07-01'
  GROUP BY
    client,
    page,
    socket
) AS b
ON
  a.client = b.client AND
  a.page = b.page AND
  a.socket = b.socket
GROUP BY
  client,
  cdn,
  is_main_document
ORDER BY
  client DESC,
  total DESC
