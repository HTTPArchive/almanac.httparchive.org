#standardSQL
# Validation query to check what's in the payload for invalid head elements
# This will help us understand the actual structure

SELECT
  client,
  page,
  -- Check different possible paths
  JSON_QUERY(TO_JSON_STRING(payload), '$._valid-head.invalidHead') AS invalidHead_with_underscore,
  JSON_QUERY(TO_JSON_STRING(payload), '$.valid_head.invalidHead') AS invalidHead_without_underscore,
  JSON_QUERY(TO_JSON_STRING(payload), '$._valid-head.invalidElements') AS invalidElements_with_underscore,
  JSON_QUERY(TO_JSON_STRING(payload), '$.valid_head.invalidElements') AS invalidElements_without_underscore,
  -- Check if the paths exist at all
  JSON_QUERY(TO_JSON_STRING(payload), '$._valid-head') AS valid_head_with_underscore,
  JSON_QUERY(TO_JSON_STRING(payload), '$.valid_head') AS valid_head_without_underscore,
  -- Sample some payload keys to understand structure
  JSON_KEYS(payload) AS payload_keys
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01'
  AND is_root_page = TRUE
LIMIT 10 