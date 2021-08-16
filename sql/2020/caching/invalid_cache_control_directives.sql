#standardSQL
# List of invalid Cache-Control directive names.
SELECT
  client,
  total_requests,
  total_using_cache_control,
  directive_name,
  directive_occurrences,
  pct_of_cache_control,
  pct_of_total_requests
FROM
  (
    (
      SELECT
        "desktop" AS client,
        total_requests,
        total_using_cache_control,
        directive_name,
        COUNT(0) AS directive_occurrences,
        COUNT(0) / total_using_cache_control AS pct_of_cache_control,
        COUNT(0) / total_requests AS pct_of_total_requests
      FROM
        `httparchive.summary_requests.2020_08_01_desktop`,
        UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_cache_control), r'([a-z][^,\s="\']*)')) AS directive_name
      CROSS JOIN (
        SELECT
          COUNT(0) AS total_requests,
          COUNTIF(TRIM(resp_cache_control) != "") AS total_using_cache_control
        FROM
          `httparchive.summary_requests.2020_08_01_desktop`
      )
      GROUP BY
        client,
        total_requests,
        total_using_cache_control,
        directive_name
    )
    UNION ALL
    (
      SELECT
        "mobile" AS client,
        total_requests,
        total_using_cache_control,
        directive_name,
        COUNT(0) AS directive_occurrences,
        COUNT(0) / total_using_cache_control AS pct_of_cache_control,
        COUNT(0) / total_requests AS pct_of_total_requests
      FROM
        `httparchive.summary_requests.2020_08_01_mobile`,
        UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_cache_control), r'([a-z][^,\s="\']*)')) AS directive_name
      CROSS JOIN (
        SELECT
          COUNT(0) AS total_requests,
          COUNTIF(TRIM(resp_cache_control) != "") AS total_using_cache_control
        FROM
          `httparchive.summary_requests.2020_08_01_mobile`
      )
      GROUP BY
        client,
        total_requests,
        total_using_cache_control,
        directive_name
    )
  )
WHERE
  directive_name NOT IN ('max-age', 'public', 'no-cache', 'must-revalidate', 'no-store', 'private', 'proxy-revalidate', 's-maxage', 'no-transform', 'immutable', 'stale-while-revalidate', 'stale-if-error', 'pre-check', 'post-check')
ORDER BY
  client, directive_occurrences DESC
