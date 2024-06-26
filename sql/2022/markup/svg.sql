WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
),

svgs AS (
  SELECT
    _TABLE_SUFFIX,
    CAST(JSON_VALUE(JSON_VALUE(payload, '$._markup'), '$.svgs.svg_total') AS INT64) AS svg
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(svg > 0) AS pages,
  ANY_VALUE(total) AS total,
  COUNTIF(svg > 0) / ANY_VALUE(total) AS pct_pages
FROM
  svgs
JOIN
  totals
USING (_TABLE_SUFFIX)
GROUP BY
  client
