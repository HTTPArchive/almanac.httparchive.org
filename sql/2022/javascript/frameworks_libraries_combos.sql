#standardSQL
# Top JS frameworks and libraries combinations
SELECT
  *
FROM (
  SELECT
    client,
    apps,
    COUNT(DISTINCT page) AS pages,
    total,
    COUNT(DISTINCT page) / total AS pct
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      url AS page,
      total,
      ARRAY_TO_STRING(ARRAY_AGG(app ORDER BY app), ', ') AS apps
    FROM
      `httparchive.technologies.2022_06_01_*`
    JOIN (
      SELECT
        _TABLE_SUFFIX,
        COUNT(0) AS total
      FROM
        `httparchive.summary_pages.2022_06_01_*`
      GROUP BY
        _TABLE_SUFFIX
    )
    USING (_TABLE_SUFFIX)
    WHERE
      category IN ('JavaScript frameworks', 'JavaScript libraries')
    GROUP BY
      client,
      url,
      total
  )
  GROUP BY
    client,
    apps,
    total
)
WHERE
  pages >= 10000
ORDER BY
  pct DESC
