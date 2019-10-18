#standardSQL
# 17_19: Percentage of HTTPS responses by protocol
SELECT
  client, cdn, firstHtml,
  countif(protocol = 'HTTP/0.9') as http09,
  countif(protocol = 'HTTP/1.0') as http10,
  countif(protocol = 'HTTP/1.1') as http11,
  countif(protocol = 'HTTP/2') as http2,
  countif(protocol not in ('HTTP/0.9', 'HTTP/1.0', 'HTTP/1.1', 'HTTP/2')) as http_other,
  countif(isSecure or protocol = 'HTTP/2') as tls_total,
  round(100*countif(protocol = 'HTTP/0.9')/count(0), 2) as http09_pct,
  round(100*countif(protocol = 'HTTP/1.0')/count(0), 2) as http10_pct,
  round(100*countif(protocol = 'HTTP/1.1')/count(0), 2) as http11_pct,
  round(100*countif(protocol = 'HTTP/2')/count(0), 2) as http2_pct,
  round(100*countif(protocol not in ('HTTP/0.9', 'HTTP/1.0', 'HTTP/1.1', 'HTTP/2')) /count(0), 2) as http_other_pct,
  round(100*countif(isSecure or protocol = 'HTTP/2')/count(0), 2) as tls_pct,
  count(0) as total
FROM
(
  SELECT
    client, page, url, firstHtml,
    # WPT is inconsistent with protocol population.
    upper(ifnull(JSON_EXTRACT_SCALAR(payload, '$._protocol'), ifnull(nullif(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), nullif(concat("HTTP/",  JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'HTTP/')))) as protocol,
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tlsVersion,

    # WPT joins CDN detection but we bias to the DNS detection which is the first entry
    ifnull(nullif(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') as cdn,
    CAST(JSON_EXTRACT(payload, "$.timings.ssl") AS INT64) AS tlstime,

    # isSecure reports what the browser thought it was going to use, but it can get upgraded with STS or UpgradeInsecure: 1
    if(STARTS_WITH(url, 'https') OR JSON_EXTRACT_SCALAR(payload, '$._tls_version') is not null OR CAST(JSON_EXTRACT(payload, '$._is_secure') AS INT64) = 1, true, false) AS isSecure
  FROM
    `httparchive.almanac.requests3`
  WHERE
    # WPT changes the response fields based on a redirect (url becomes the Location path instead of the original) causing insonsistencies in the counts, so we ignore them
    resp_location = '' or resp_location is null
)
GROUP BY
  client,cdn,firstHtml