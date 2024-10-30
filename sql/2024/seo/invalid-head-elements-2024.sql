WITH pages AS (
  SELECT
    client,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    page,
    payload
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
),
total_sites AS (
  -- total number of distinct pages (URLs) per client and page type
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_sites
  FROM
    pages
  GROUP BY
    client,
    is_root_page
)
SELECT
  p.client,
  p.is_root_page,
  element,
  COUNT(DISTINCT p.page) AS invalid_sites, -- Count of distinct pages with invalid elements
  ts.total_sites
FROM
  pages p
JOIN
  total_sites ts ON p.client = ts.client AND p.is_root_page = ts.is_root_page,
  UNNEST(JSON_EXTRACT_ARRAY(p.payload, '$._valid-head.invalidElements')) AS element
GROUP BY
  p.client,
  p.is_root_page,
  ts.total_sites,
  element
ORDER BY
  p.client;
