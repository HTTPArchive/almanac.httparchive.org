#standardSQL
# List of invalid Cache-Control directive names.
SELECT
  client,
  total_directives,
  total_using_cache_control,
  directive_name,
  directive_occurrences,
  directive_occurrences / total_using_cache_control AS pct_of_cache_control,
  directive_occurrences / total_directives AS pct_of_total_directives
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    directive_name,
    COUNT(0) AS directive_occurrences,
    SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total_directives,
    SUM(COUNTIF(TRIM(resp_cache_control) != '')) OVER (PARTITION BY _TABLE_SUFFIX) AS total_using_cache_control
  FROM
    `httparchive.summary_requests.2021_07_01_*`
  LEFT JOIN
    UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_cache_control), r'([a-z][^,\s="\']*)')) AS directive_name
  GROUP BY
    client,
    directive_name
)
WHERE
  directive_name NOT IN (
    'max-age', 'public', 'no-cache', 'must-revalidate', 'no-store',
    'private', 'proxy-revalidate', 's-maxage', 'no-transform',
    'immutable', 'stale-while-revalidate', 'stale-if-error',
    'pre-check', 'post-check'
  )
ORDER BY
  client,
  directive_occurrences DESC
