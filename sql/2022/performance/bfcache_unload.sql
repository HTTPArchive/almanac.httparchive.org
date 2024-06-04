WITH lh AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(report, '$.audits.no-unload-listeners.score') = '0' AS has_unload
  FROM
    `httparchive.lighthouse.2022_06_01_*`
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    rank
  FROM
    `httparchive.summary_pages.2022_06_01_*`
)


SELECT
  client,
  _rank AS rank,
  COUNTIF(has_unload) AS pages,
  COUNT(0) AS total,
  COUNTIF(has_unload) / COUNT(0) AS pct
FROM
  lh
JOIN
  pages
USING (client, page),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS _rank
WHERE
  rank <= _rank
GROUP BY
  client,
  rank
ORDER BY
  rank,
  client
