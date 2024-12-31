# Pages that use Client Hints
WITH response_headers AS (
  SELECT
    client,
    page,
    LOWER(response_header.name) AS header_name,
    LOWER(response_header.value) AS header_value,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_websites
  FROM `httparchive.all.requests`,
    UNNEST(response_headers) response_header
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    is_main_document = TRUE
),

meta_tags AS (
  SELECT
    client,
    page,
    LOWER(JSON_VALUE(meta_node, '$.http-equiv')) AS tag_name,
    LOWER(JSON_VALUE(meta_node, '$.content')) AS tag_value
  FROM (
    SELECT
      client,
      page,
      JSON_QUERY(custom_metrics, '$.almanac') AS metrics
    FROM `httparchive.all.pages`
    WHERE
      date = '2024-06-01' AND
      is_root_page = TRUE
  ),
    UNNEST(JSON_QUERY_ARRAY(metrics, '$.meta-nodes.nodes')) meta_node
  WHERE JSON_VALUE(meta_node, '$.http-equiv') IS NOT NULL
)

SELECT
  client,
  IF(header_name = 'accept-ch', header_value, tag_value) AS value,
  COUNT(DISTINCT page) / ANY_VALUE(total_websites) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM response_headers
FULL OUTER JOIN meta_tags
USING (client, page)
WHERE
  header_name = 'accept-ch' OR
  tag_name = 'accept-ch'
GROUP BY
  client,
  value
ORDER BY pct_pages DESC
LIMIT 200
