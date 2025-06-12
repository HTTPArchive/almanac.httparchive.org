#standardSQL

# Percentage of requests for main site document using CDN and ALTSVC

WITH requests AS (
  SELECT
    client,
    CASE
      WHEN LENGTH(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider')) > 0 THEN 'from-cdn'
      ELSE 'non-cdn'
    END AS cdn,
    resp_headers.value AS altsvc
  FROM
    `httparchive.all.requests`
  LEFT OUTER JOIN
    UNNEST(response_headers) AS resp_headers
  ON LOWER(resp_headers.name) = 'alt-svc'
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document
)

SELECT
  client,
  cdn,
  COUNTIF(altsvc IS NOT NULL) AS sites_with_altsvc,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(altsvc IS NOT NULL) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_sites_with_altsvc
FROM
  requests
GROUP BY
  client,
  cdn
ORDER BY
  pct_sites_with_altsvc DESC
