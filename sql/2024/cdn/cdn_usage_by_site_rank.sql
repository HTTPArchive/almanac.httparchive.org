#standardSQL
# cdn_usage_by_site_rank.sql : Distribution of HTML pages served by CDN vs Origin by rank

WITH requests AS (
  SELECT
    client,
    rank,
    -- _cdn_provider is now in requests.summary table
    -- Also it returns empty string ('')rather than 'ORIGIN' when no CDN 
    IF(IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(resp.summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = '', 'ORIGIN', 'CDN') AS cdn
  FROM
    --`httparchive.almanac.requests` -- OLD table
    `httparchive.all.requests` AS resp -- NEW table
  -- `httparchive.sample_data.requests_1k` AS resp -- SAMPLE table (quicker)
  INNER JOIN
    `httparchive.all.pages` -- NEW pages table
  -- `httparchive.sample_data.pages_1k` AS pages -- SAMPLE pages table (quicker)
  USING (page, client, date)
  WHERE
    date = '2024-06-01' AND -- Uncomment this when running on full table
    is_main_document -- new name for firstHtml
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
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS nested_rank -- Note extra rank since 2022
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
