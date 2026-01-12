#standardSQL
# SW controlled pages by rank (2025)

SELECT
  FORMAT_DATE('%Y%m%d', date) AS date,
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM (
  SELECT DISTINCT
    date,
    client,
    page AS url,
    rank
  FROM
    `httparchive.crawl.pages`,
    UNNEST(features) AS feat
  WHERE
    date >= DATE '2022-05-01' AND
    is_root_page AND
    feat.feature = 'ServiceWorkerControlledPage'
), UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
JOIN (
  SELECT
    date,
    client,
    rank_grouping,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping AND
    is_root_page
  GROUP BY
    date,
    rank_grouping,
    client
) totals
USING (date, client, rank_grouping)
WHERE
  rank <= rank_grouping
GROUP BY
  date,
  client,
  total,
  rank_grouping
ORDER BY
  date DESC,
  rank_grouping,
  client;
