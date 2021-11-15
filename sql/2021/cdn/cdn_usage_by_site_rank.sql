#standardSQL
# cdn_usage_by_site_rank.sql : Distribution of HTML pages served by CDN vs Origin by rank

SELECT client, cdn, rank,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client, cdn, rank) AS total_compressed,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, cdn, rank) AS pct
FROM (
  SELECT
    client,
    IF(IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') = "ORIGIN", "ORIGIN", "CDN") AS cdn,
    rank
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml AND
    rank IS NOT NULL
  )
GROUP BY client, cdn, rank
ORDER BY client, rank, cdn
