WITH subquery AS (
  SELECT
    client,
    request_headers,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  REGEXP_CONTAINS(LOWER(IFNULL(request_headers[SAFE_OFFSET(0)].name, '')), r'user-agent') AS resp_vary_user_agent,
  COUNT(0) AS freq,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER ()) AS pct
FROM
  subquery
GROUP BY
  client,
  is_root_page,
  resp_vary_user_agent
ORDER BY
  freq DESC,
  client;
