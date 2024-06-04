#standardSQL
# Most common directives for Permissions Policy

-- https://www.w3.org/TR/permissions-policy-1/#algo-parse-policy-directive
CREATE TEMP FUNCTION parse_policy_directive(policy STRING)
RETURNS ARRAY<STRUCT<directive STRING, feature_name STRING, allowlist ARRAY<STRING>>>
LANGUAGE js AS r"""
  policy = policy.replaceAll(/\,/g, ';')  // swap directive delimiter
  policy_directives = policy.split(';')

  result_array = []
  for (directive of policy_directives) {
    tokens = directive
      .replaceAll(/\=/g, ' ')  // replace '=' with ' '
      .replaceAll(/(\(|\'|\")/g, ' $1')  // add space before parentheses and quotes
      .trim().split(' ')

    feature_name = tokens.shift().replaceAll(/[^a-z0-9\-]+/g, '')

    tokens = tokens
      .join(' ')
      .replaceAll( /\(|\'|\"|\)/g, '')  // remove parentheses and quotes
      .replaceAll(/ +/g, ' ')  // collapse whitespace
      .trim().split(' ')

    if(feature_name && !['self', 'none'].includes(feature_name)) {
      result_array.push({
        directive: feature_name+"=("+tokens.join(' ')+")",
        feature_name: feature_name,
        allowlist: tokens
      })
    }
  }

  return result_array;
""";

WITH response_headers AS (
  SELECT
    client,
    page,
    LOWER(JSON_VALUE(response_header, '$.name')) AS header_name,
    LOWER(JSON_VALUE(response_header, '$.value')) AS header_value
  FROM
    `httparchive.almanac.requests`,
    UNNEST(JSON_QUERY_ARRAY(response_headers)) response_header
  WHERE
    date = '2022-06-01' AND
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
      JSON_VALUE(payload, '$._almanac') AS metrics
    FROM
      `httparchive.pages.2022_06_01_*`
  ),
    UNNEST(JSON_QUERY_ARRAY(metrics, '$.meta-nodes.nodes')) meta_node
  WHERE
    JSON_VALUE(meta_node, '$.http-equiv') IS NOT NULL
),

totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_websites
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    firstHtml = TRUE
  GROUP BY
    client
),

merged_policy AS (
  SELECT
    client,
    page,
    parse_policy_directive(IF(header_name IN ('feature-policy', 'permissions-policy'), header_value, tag_value)) AS directives
  FROM
    response_headers
  FULL OUTER JOIN
    meta_tags
  USING (client, page)
  WHERE (
    header_name IN ('feature-policy', 'permissions-policy') OR
    tag_name IN ('feature-policy', 'permissions-policy')
  ) AND
  header_value IS NOT NULL AND
  tag_value IS NOT NULL
)

SELECT
  client,
  directive.feature_name,
  IF(allowlist IN ('*', 'self', 'none'), allowlist, 'custom origin') AS allowlist,
  COUNT(DISTINCT page) AS number_of_websites_with_directive,
  COUNT(DISTINCT page) / ANY_VALUE(total_websites) AS pct_websites_with_directive
FROM
  merged_policy,
  UNNEST(merged_policy.directives) AS directive,
  UNNEST(directive.allowlist) AS allowlist
JOIN
  totals
USING (client)
GROUP BY
  client,
  directive.feature_name,
  allowlist
ORDER BY
  client,
  pct_websites_with_directive DESC
