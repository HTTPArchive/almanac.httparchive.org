#standardSQL
# Most common directives for Feature-Policy or Permissions-Policy

WITH page_ranks AS (
  SELECT
    client,
    page,
    rank
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml = TRUE
),

response_headers AS (
  SELECT
    client,
    page,
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
),

merged_feature_policy AS (
  SELECT
    client,
    page,
    IF(header_name = 'feature-policy', header_value, tag_value) AS feature_policy_value
  FROM
    response_headers
  FULL OUTER JOIN
    meta_tags
  USING (client, page)
  WHERE
    header_name = 'feature-policy' OR
    tag_name = 'feature-policy'
),

merged_permissions_policy AS (
  SELECT
    client,
    page,
    IF(header_name = 'permissions-policy', header_value, tag_value) AS permissions_policy_value
  FROM
    response_headers
  FULL OUTER JOIN
    meta_tags
  USING (client, page)
  WHERE
    header_name = 'permissions-policy' OR
    tag_name = 'permissions-policy'
),

normalized_feature_policy AS (  -- normalize
  SELECT
    client,
    page,
    REPLACE(feature_policy_value, "'", "") AS policy_value  -- remove quotes
  FROM
    merged_feature_policy
),

normalized_permissions_policy AS (  -- normalize
  SELECT
    client,
    page,
    REPLACE(REPLACE(
        REPLACE(REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(permissions_policy_value, ',', ';'),  -- swap directive delimiter
                '=', ' '), -- drop name/value delimiter
              "()", "none" -- special case for feature disabling
            ),
            "(", ""), ")", ""), -- remove parentheses
        '"', ""), "'", "") -- remove quotes
    AS policy_value
  FROM
    merged_permissions_policy
)


SELECT
  client,
  rank,
  SPLIT(TRIM(directive), ' ')[OFFSET(0)] AS directive_name,
  TRIM(origin) AS origin,
  COUNT(DISTINCT page) AS number_of_websites_with_directive,
  total_websites,
  COUNT(DISTINCT page) / ANY_VALUE(total_websites) AS pct_websites_with_directive
FROM
  (
    SELECT DISTINCT * FROM (
      SELECT * FROM normalized_feature_policy
      UNION ALL
      SELECT * FROM normalized_permissions_policy
    )
  )
JOIN
  page_ranks
USING (client, page)
JOIN
  totals
USING (client, rank),
  UNNEST(SPLIT(policy_value, ";")) directive,
  UNNEST(  -- Directive may specify explicit origins or not.
    IF(
      ARRAY_LENGTH(SPLIT(TRIM(directive), ' ')) = 1,  -- test if any explicit origin is provided
      [TRIM(directive), ''],  -- if not, add a dummy empty origin to make the query work
      SPLIT(TRIM(directive), ' '  -- if it is, split the different origins
      )
    )
  ) AS origin WITH OFFSET AS offset
WHERE
  TRIM(directive) != "" AND
  offset > 0
GROUP BY
  client,
  rank,
  directive_name,
  origin,
  total_websites
ORDER BY
  rank ASC,
  client ASC,
  number_of_websites_with_directive DESC,
  directive_name ASC,
  origin ASC
