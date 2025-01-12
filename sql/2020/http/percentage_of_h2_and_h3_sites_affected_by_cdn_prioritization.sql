# standardSQL
# Percentage of H2 and H3 sites affected by CDN prioritization issues
SELECT
  client,
  http_version,
  IF(pages.cdn = '', 'Not using CDN', pages.cdn) AS CDN,
  IF(prioritization_status IS NOT NULL, prioritization_status, 'Unknown') AS prioritizes_correctly,
  COUNT(0) AS num_pages,
  ROUND(COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client), 4) AS pct
FROM (
  SELECT
    date,
    client,
    JSON_EXTRACT_SCALAR(payload, '$._protocol') AS http_version,
    url,
    _cdn_provider AS cdn
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    firstHtml AND (
      LOWER(JSON_EXTRACT_SCALAR(payload, '$._protocol')) LIKE 'http/2' OR
      LOWER(JSON_EXTRACT_SCALAR(payload, '$._protocol')) LIKE '%quic%' OR
      LOWER(JSON_EXTRACT_SCALAR(payload, '$._protocol')) LIKE 'h3%' OR
      LOWER(JSON_EXTRACT_SCALAR(payload, '$._protocol')) LIKE 'http/3%'
    )
) AS pages
LEFT JOIN
  `httparchive.almanac.h2_prioritization_cdns`
USING (cdn, date)
GROUP BY
  client,
  http_version,
  CDN,
  prioritizes_correctly
ORDER BY
  num_pages DESC
