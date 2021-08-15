#standardSQL
# Most used apps by domain rank
SELECT
  rank,
  total_in_rank,

  category,
  app,
  COUNT(0) AS sites_with_app,
  COUNT(0) / total_in_rank AS pct_sites_with_app
FROM
  `httparchive.technologies.2021_07_01_mobile`
JOIN (
  SELECT
    url,
    rank,
  FROM
    `httparchive.summary_pages.2021_07_01_mobile`
) USING (url)
JOIN (
  SELECT
    rank,
    COUNT(0) AS total_in_rank
  FROM
    `httparchive.summary_pages.2021_07_01_mobile`
  GROUP BY
    rank
) USING (rank)
GROUP BY
  rank,
  total_in_rank,
  category,
  app
ORDER BY
  category,
  app,
  rank
