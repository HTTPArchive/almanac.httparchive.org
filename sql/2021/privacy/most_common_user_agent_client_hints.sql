#standardSQL
# Pages that use User-Agent Client Hints

WITH response_headers AS (
  SELECT
    client,
    page,
    rank,
    LOWER(JSON_VALUE(response_header, '$.name')) AS header_name,
    LOWER(JSON_VALUE(response_header, '$.value')) AS header_value
  FROM
    `httparchive.almanac.requests`,
    UNNEST(JSON_QUERY_ARRAY(response_headers)) response_header
  WHERE
    date = '2021-07-01' AND
    firstHtml = TRUE
),

meta_tags AS (
  SELECT
    client,
    url AS page,
    LOWER(JSON_VALUE(meta_node, '$.http-equiv')) AS tag_name,
    LOWER(JSON_VALUE(meta_node, '$.content')) AS tag_value
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      url,
      JSON_VALUE(payload, "$._almanac") AS metrics
    FROM
      `httparchive.pages.2021_07_01_*`
    ),
    UNNEST(JSON_QUERY_ARRAY(metrics, "$.meta-nodes.nodes")) meta_node
  WHERE
    JSON_VALUE(meta_node, '$.http-equiv') IS NOT NULL
),

totals AS (
  SELECT
    client,
    rank,
    COUNT(DISTINCT page) AS total_websites
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml = TRUE
  GROUP BY
    client,
    rank
)

SELECT
  client,
  rank,
  IF(header_name = 'accept-ch', header_value, tag_value) AS value,
  COUNT(DISTINCT page) AS nb_websites,
  total_websites,
  COUNT(DISTINCT page) / ANY_VALUE(total_websites) AS pct_websites
FROM
  response_headers
FULL OUTER JOIN
  meta_tags
USING (client, page)
JOIN
  totals
USING (client, rank)
WHERE
  header_name = 'accept-ch' OR
  tag_name = 'accept-ch'
GROUP BY
  client,
  rank,
  value,
  total_websites
ORDER BY
  rank ASC,
  client ASC,
  nb_websites DESC
