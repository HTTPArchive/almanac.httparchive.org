#standardSQL
# distribution_of_tls_time_cdn_vs_origin.sql : Distribution of TLS negotiation for CDN vs Origin (ie, no CDN)
SELECT
  client,
  IF(cdn = "ORIGIN", "ORIGIN", "CDN") AS cdn,
  firstHtml,
  COUNT(0) AS requests,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(900)] AS p90
FROM (
    SELECT
      client,
      requestid,
      page,
      url,
      firstHtml,
      IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      CAST(JSON_EXTRACT(payload, "$.timings.ssl") AS INT64) AS tlstime,
      ARRAY_LENGTH(split(JSON_EXTRACT(payload, '$._securityDetails.sanList'), "")) AS sanLength,
      IF(NET.HOST(url) = NET.HOST(page), TRUE, FALSE) AS sameHost,
      IF(NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page), TRUE, FALSE) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01'
    GROUP BY
      client,
      requestid,
      page,
      url,
      firstHtml,
      cdn,
      tlstime,
      sanLength
)
WHERE
  tlstime != -1 AND
  sanLength IS NOT NULL
GROUP BY
  client,
  cdn,
  firstHtml
ORDER BY
  requests DESC
