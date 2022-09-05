#standardSQL

# Percentage of requests with HTTP/3 support broken down by whether the
# request was served from CDN.

SELECT
  client,
  _cdn_provider,
  CASE
    WHEN respHttpVersion IN ('HTTP/3', 'h3', 'h3-29') OR
      reqHttpVersion IN ('HTTP/3', 'h3', 'h3-29') OR
      REGEXP_EXTRACT(REGEXP_EXTRACT(respOtherHeaders, r'alt-svc = (.*)'), r'(.*?)(?:, [^ ]* = .*)?$') LIKE '%h3=%' OR
      REGEXP_EXTRACT(REGEXP_EXTRACT(respOtherHeaders, r'alt-svc = (.*)'), r'(.*?)(?:, [^ ]* = .*)?$') LIKE '%h3-29=%' THEN 'h3_supported'
    ELSE 'h3_not_supported'
  END AS h3_status,
  COUNT(0) AS num_reqs,
  SUM(COUNT(0)) OVER (PARTITION BY client, _cdn_provider) AS total_reqs,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, _cdn_provider) AS pct_reqs
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  LENGTH(_cdn_provider) > 0
GROUP BY
  client,
  _cdn_provider,
  h3_status
ORDER BY
  client ASC,
  num_reqs DESC
