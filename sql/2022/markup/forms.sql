WITH forms AS (
  SELECT
    _TABLE_SUFFIX,
    url,
    CAST(IFNULL(JSON_VALUE(JSON_EXTRACT_SCALAR(payload, '$._element_count'), '$.form'), '0') AS INT64) AS forms_count
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  _TABLE_SUFFIX AS client,
  forms_count,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_pages
FROM
  forms
GROUP BY
  client,
  forms_count
ORDER BY
  forms_count DESC
