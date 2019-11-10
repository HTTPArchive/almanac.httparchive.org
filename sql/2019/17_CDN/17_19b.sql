#standardSQL
# 17_19: Percentage of HTTPS responses by protocol
SELECT
  client, cdn, firstHtml,
  countif(ifnull(a.tlsVersion, b.tlsVersion) = 'TLS 1.0') as tls10,
  countif(ifnull(a.tlsVersion, b.tlsVersion) = 'TLS 1.1') as tls11,
  countif(ifnull(a.tlsVersion, b.tlsVersion) = 'TLS 1.2') as tls12,
  countif(ifnull(a.tlsVersion, b.tlsVersion) = 'TLS 1.3') as tls13,
  round(100*countif(ifnull(a.tlsVersion, b.tlsVersion) = 'TLS 1.0')/count(0), 2) as tls10_pct,
  round(100*countif(ifnull(a.tlsVersion, b.tlsVersion) = 'TLS 1.1')/count(0), 2) as tls11_pct,
  round(100*countif(ifnull(a.tlsVersion, b.tlsVersion) = 'TLS 1.2')/count(0), 2) as tls12_pct,
  round(100*countif(ifnull(a.tlsVersion, b.tlsVersion) = 'TLS 1.3')/count(0), 2) as tls13_pct,
  count(0) as total
FROM
(
  SELECT
    client, page, url, firstHtml,
    # WPT is inconsistent with protocol population.
    upper(ifnull(JSON_EXTRACT_SCALAR(payload, '$._protocol'), ifnull(nullif(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), nullif(concat("TLS ",  JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS ')))) as protocol,
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tlsVersion,

    # WPT joins CDN detection but we bias to the DNS detection which is the first entry
    ifnull(nullif(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') as cdn,
    CAST(JSON_EXTRACT(payload, "$.timings.ssl") AS INT64) AS tlstime,

    # isSecure reports what the browser thought it was going to use, but it can get upgraded with STS or UpgradeInsecure: 1
    if(STARTS_WITH(url, 'https') OR JSON_EXTRACT_SCALAR(payload, '$._tls_version') is not null OR CAST(JSON_EXTRACT(payload, '$._is_secure') AS INT64) = 1, true, false) AS isSecure,
    CAST(jSON_EXTRACT(payload, "$._socket") AS INT64) as socket
  FROM
    `httparchive.almanac.requests3`
  WHERE
    # WPT changes the response fields based on a redirect (url becomes the Location path instead of the original) causing insonsistencies in the counts, so we ignore them
    resp_location = '' or resp_location is null
) a
LEFT JOIN (
  SELECT
    client, page,
    CAST(jSON_EXTRACT(payload, "$._socket") AS INT64) as socket,
    ANY_VALUE(upper(ifnull(JSON_EXTRACT_SCALAR(payload, '$._protocol'), ifnull(nullif(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), nullif(concat("TLS ",  JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS '))))) as protocol,
    ANY_VALUE(JSON_EXTRACT_SCALAR(payload, '$._tls_version')) tlsVersion
  FROM `httparchive.almanac.requests3`
    WHERE
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL
    AND ifnull(JSON_EXTRACT_SCALAR(payload, '$._protocol'), ifnull(nullif(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), nullif(concat("TLS ",  JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS '))) IS NOT NULL
    AND jSON_EXTRACT(payload, "$._socket") IS NOT NULL
  GROUP BY client, page, socket
) b ON (a.client = b.client AND a.page = b.page AND a.socket = b.socket)

GROUP BY
  client,cdn,firstHtml
ORDER BY
  client DESC,
  total DESC