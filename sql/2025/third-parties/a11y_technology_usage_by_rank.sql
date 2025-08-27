#standardSQL
# A11Y technology usage by domain rank

WITH a11y_technologies AS (
  SELECT
    _TABLE_SUFFIX AS client,
    app,
    url
  FROM
    `httparchive.technologies.2025_07_01_*`
  WHERE
    category = 'Accessibility'
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    rank_grouping
  FROM
    `httparchive.summary_pages.2025_07_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
),

rank_totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_grouping,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2025_07_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    client,
    rank_grouping
)

SELECT
  client,
  rank_grouping AS rank,
  app,
  COUNT(0) AS freq,
  total,
  (COUNT(0) / total) * 100 AS pct
FROM
  a11y_technologies
LEFT OUTER JOIN
  pages
USING (client, url)
JOIN
  rank_totals
USING (client, rank_grouping)
GROUP BY
  rank_grouping,
  total,
  client,
  app
ORDER BY
  client,
  rank,
  pct DESC
