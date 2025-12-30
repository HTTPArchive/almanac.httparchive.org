#standardSQL
# Invalid Head Elements

WITH invalid_elements AS (
  SELECT
    client,
    is_root_page,
    page,
    JSON_VALUE(el) AS element
  FROM
    `httparchive.crawl.pages`,
    UNNEST(IFNULL(JSON_EXTRACT_ARRAY(custom_metrics.other.`valid-head`.invalidElements), [])) AS el
  WHERE
    date = '2025-07-01'
),

total_sites AS (
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_sites
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    client,
    is_root_page
)

SELECT
  ie.client,
  CASE
    WHEN ie.is_root_page = FALSE THEN 'Secondarypage'
    WHEN ie.is_root_page = TRUE THEN 'Homepage'
    ELSE 'No Assigned Page'
  END AS is_root_page,
  ie.element,
  COUNT(DISTINCT ie.page) AS invalid_sites,
  ts.total_sites,
  SAFE_DIVIDE(COUNT(DISTINCT ie.page), ts.total_sites) AS pct_invalid
FROM
  invalid_elements ie
JOIN
  total_sites ts
ON
  ie.client = ts.client AND
  ie.is_root_page = ts.is_root_page
GROUP BY
  ie.client,
  is_root_page,
  ts.total_sites,
  ie.element
ORDER BY
  ie.client,
  is_root_page,
  ts.total_sites,
  ie.element
