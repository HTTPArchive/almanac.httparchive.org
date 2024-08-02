# TODO: Reporting 0 pages for all pages

WITH lh AS (
  SELECT
    client,
    page,
    rank,
    JSON_VALUE(lighthouse, '$.audits.no-unload-listeners.score') = '0' AS has_unload
  FROM
    `httparchive.all.pages` TABLESAMPLE SYSTEM(1 PERCENT)
  WHERE
    date = '2024-06-01' AND
    is_root_page
)


SELECT
  client,
  _rank AS rank,
  COUNTIF(has_unload) AS pages,
  COUNT(0) AS total,
  COUNTIF(has_unload) / COUNT(0) AS pct
FROM
  lh,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS _rank
WHERE
  rank <= _rank
GROUP BY
  client,
  rank
ORDER BY
  rank,
  client
