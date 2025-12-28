#standardSQL
# cdn_usage_by_site_rank.sql : Distribution of HTML pages served by CDN vs Origin by rank

WITH requests AS (
  SELECT
    client,
    resp.rank, -- Need to validate this should be resp.rank and not pages.rank
    IF(IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(resp.summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = '', 'ORIGIN', 'CDN') AS cdn
  FROM
    `httparchive.crawl.requests` AS resp
  INNER JOIN
    `httparchive.crawl.pages`
  USING (page, client, date)
  WHERE
    date = '2025-07-01' AND
    is_main_document
)

SELECT
  client,
  nested_rank,
  cdn,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client, nested_rank) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, nested_rank) AS pct_requests
FROM
  requests,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS nested_rank
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
