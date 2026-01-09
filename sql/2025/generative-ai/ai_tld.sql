#standardSQL
# .ai domains per exclusive rank bucket, 2022 vs 2025

WITH base AS (
  SELECT
    date,
    client,
    rank,
    NET.HOST(page) AS host
  FROM
    `httparchive.crawl.pages`
  WHERE
    is_root_page AND
    client IN ('desktop', 'mobile') AND
    date IN ('2022-06-01', '2025-07-01') AND
    rank <= 10000000 AND -- later years go beyond 10,000,000 but let's keep to this limit for consistency
    ENDS_WITH(NET.HOST(page), '.ai')
),

bucketed AS (
  SELECT
    date,
    client,
    CASE
      WHEN rank <= 1000 THEN 1000
      WHEN rank <= 10000 THEN 10000
      WHEN rank <= 100000 THEN 100000
      WHEN rank <= 1000000 THEN 1000000
      WHEN rank <= 10000000 THEN 10000000
    END AS rank_bucket,
    host
  FROM
    base
)

SELECT
  date,
  client,
  rank_bucket,
  COUNT(DISTINCT host) AS ai_domains
FROM
  bucketed
GROUP BY
  date,
  client,
  rank_bucket
ORDER BY
  date,
  client,
  rank_bucket;
