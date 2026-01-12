#standardSQL
# Total page weight distribution BY CMS
# page_weight_distribution.sql
SELECT
  percentile,
  client,
  cms,
  COUNT(0) AS pages,
  APPROX_QUANTILES(total_kb, 1000)[OFFSET(percentile * 10)] AS total_kb
FROM (
  SELECT DISTINCT
    client,
    page AS url,
    technologies.technology AS cms
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2025-07-01' AND
    is_root_page
)
JOIN (
  SELECT
    client,
    page AS url,
    CAST(INT64(summary.bytesTotal) AS INT64) / 1024 AS total_kb
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
)
USING (client, url),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  cms
HAVING
  pages > 1000
ORDER BY
  percentile,
  pages DESC
