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
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
),

invalid_elements AS (
  SELECT
    client,
    is_root_page,
    page,
    element
  FROM
    pages,
    UNNEST(JSON_EXTRACT_ARRAY(payload, '$._valid-head.invalidElements')) AS element
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
  ie.client,
  ie.is_root_page,
  ie.element,
  COUNT(DISTINCT ie.page) AS invalid_sites, -- Count of distinct pages with invalid elements
  ts.total_sites
FROM
  invalid_elements ie
JOIN
  total_sites ts ON ie.client = ts.client AND ie.is_root_page = ts.is_root_page
GROUP BY
  ie.client,
  ie.is_root_page,
  ts.total_sites,
  ie.element
ORDER BY
  ie.client;
