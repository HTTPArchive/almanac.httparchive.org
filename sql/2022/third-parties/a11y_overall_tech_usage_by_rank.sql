#standardSQL
# Overall A11Y technology usage by domain rank

WITH a11y_technologies AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'Accessibility'
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    rank_grouping
  FROM
    `httparchive.summary_pages.2022_06_01_*`,
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
    `httparchive.summary_pages.2022_06_01_*`,
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
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
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
  client
ORDER BY
  client,
  rank
