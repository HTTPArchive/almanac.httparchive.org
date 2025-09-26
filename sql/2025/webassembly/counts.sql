# Query for wasm requests' counts by page

SELECT
 client,
 COUNT(DISTINCT page) AS pages,
 ANY_VALUE(total_pages) AS total_pages,
 COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
 SUM(COUNT(0)) OVER (PARTITION BY client) AS total_wasm_requests,
 COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_wasm_requests
FROM (
 SELECT
   client,
   page
 FROM
   `httparchive.crawl.requests`
 WHERE
   date = '2025-06-01' AND
   type = 'wasm'
)
JOIN (
 SELECT
   client,
   COUNT(0) AS total_pages
 FROM
   `httparchive.crawl.pages`
 WHERE
   date = '2025-06-01'
 GROUP BY
   client
)
USING (client)
GROUP BY
 client
ORDER BY
 pct_wasm_requests DESC
