#standardSQL
# cdn_usage_by_site_rank.sql : Distribution of HTML pages served by CDN vs Origin by rank

SELECT
  client,
  nested_rank,
  cdn,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client, nested_rank) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, nested_rank) AS pct_requests
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
    rank IS NOT NULL),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS nested_rank
WHERE
  rank <= nested_rank
GROUP BY
  client,
  cdn,
  nested_rank
ORDER BY
  client,
  nested_rank,
  cdn
