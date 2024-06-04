# standardSQL
# Percentage of H2 and H3 sites affected by CDN prioritization issues
SELECT
  client,
  IF(pages.cdn = '', 'Not using CDN', pages.cdn) AS CDN,
  IF(prioritization_status IS NOT NULL, prioritization_status, 'Unknown') AS prioritizes_correctly,
  COUNT(0) AS num_pages,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    date,
    client,
    protocol AS http_version,
    url,
    _cdn_provider AS cdn
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml AND (
      LOWER(protocol) = 'http/2' OR
      LOWER(protocol) LIKE '%quic%' OR
      LOWER(protocol) LIKE 'h3%' OR
      LOWER(protocol) = 'http/3'
    )
) AS pages
LEFT JOIN
  `httparchive.almanac.h2_prioritization_cdns`
USING (cdn, date)
GROUP BY
  client,
  CDN,
  prioritizes_correctly
ORDER BY
  num_pages DESC
