#standardSQL
# What are the most common values for sizes attributes (lots of auto!)
# ❕ Updated in 2024 to use all.requests instead of almanac.summary_response_bodies
# image_sizes_attribute_strings.sql

SELECT
  client,
  sizes,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY 0) AS pct
FROM
  `httparchive.all.requests`,
  UNNEST(REGEXP_EXTRACT_ALL(response_body, r'(?im)<(?:source|img)[^>]*sizes=[\'"]?([^\'"]*)')) AS sizes
WHERE
  date = '2024-06-01' AND
  is_main_document
GROUP BY
  client,
  sizes
ORDER BY
  freq DESC
LIMIT
  100
