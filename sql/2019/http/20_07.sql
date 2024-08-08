#standardSQL
# 20.07 - % of sites affected by CDN prioritization issues (H2 and served by CDN)
SELECT
  client,
  IF(pages.cdn = '', 'Not using CDN', pages.cdn) AS CDN,
  IF(prioritization_status IS NOT NULL, prioritization_status, 'Unknown') AS prioritizes_correctly,
  COUNT(0) AS num_pages,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM (
  SELECT
    date,
    client,
    url,
    JSON_EXTRACT_SCALAR(payload, '$._cdn_provider') AS cdn
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'HTTP/2' AND
    firstHtml
) AS pages
LEFT JOIN
  `httparchive.almanac.h2_prioritization_cdns` AS h2_pri
ON pages.date = h2_pri.date AND pages.cdn = h2_pri.cdn
GROUP BY
  client,
  CDN,
  prioritizes_correctly
ORDER BY num_pages DESC
