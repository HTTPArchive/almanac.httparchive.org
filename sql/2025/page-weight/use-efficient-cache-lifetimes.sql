-- looks at the distribution of wasted bytes from resources identified by the Lighthouse "Use Efficient Cache Lifetimes" audit
-- https://developer.chrome.com/docs/performance/insights/cache
SELECT
  percentile,
  client,
  is_root_page,
  --get the wasted bytes from resources that could be cached longer, in KB
  APPROX_QUANTILES((CAST(JSON_VALUE(lighthouse.audits['uses-long-cache-ttl'].numericValue) AS FLOAT64) / 1024), 1000)[OFFSET(percentile * 10)] AS wasted_kb
FROM
  `httparchive.crawl.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-07-01'
GROUP BY
  percentile,
  client,
  is_root_page
ORDER BY
  client,
  is_root_page,
  percentile
