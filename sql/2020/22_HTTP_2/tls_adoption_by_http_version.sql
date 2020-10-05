# standardSQL
# Distribution of TLS versions
SELECT
  req.client,
  JSON_EXTRACT_SCALAR(payload, '$._protocol') AS protocol,
  domain.tls_version,
  COUNT(0) AS freq,
  COUNTIF(firstHtml) AS freq_firstHtml,
  COUNTIF(firstReq) AS freq_firstReq
FROM
  `httparchive.almanac.requests` req,
    (SELECT
    client,
    NET.HOST(url) AS domain,
    MAX(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._tls_version'), JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol'))) AS tls_version
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-09-01' AND
    url like 'https://%'
  GROUP BY
    client,
    domain) domain
WHERE
  req.client = domain.client AND
  NET.HOST(req.url) = domain.domain AND
  req.date = '2020-08-01' AND
  req.url like 'https://%'
GROUP BY
  client,
  protocol,
  tls_version
ORDER BY
  freq desc,
  client,
  protocol
