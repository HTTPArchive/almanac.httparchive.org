WITH subquery AS (
  SELECT
    client,
    page,
    request_headers,
    CASE  
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page
  FROM
    `httparchive.all.requests` 
  WHERE
    date = "2024-06-01"
)

SELECT
  client,
  is_root_page,
  header.name AS request_header_name,
  header.value AS request_header_value,
  COUNT(DISTINCT page) AS sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER ()) AS pct
FROM
  subquery,
  UNNEST(request_headers) AS header
GROUP BY
  client,
  is_root_page,
  header.name,
  header.value
ORDER BY
  sites DESC,
  client;
