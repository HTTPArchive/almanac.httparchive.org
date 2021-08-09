#standardSQL
# List of Vary directive names.
SELECT
  client,
  total_requests,
  total_using_vary,
  vary_header,
  occurrences,
  pct_of_vary,
  pct_of_total_requests,
  total_using_both / total_using_vary AS pct_of_vary_with_cache_control,
  total_using_vary / total_requests AS pct_using_vary
FROM
(
  (
     SELECT
      "desktop" AS client,
      total_requests,
      total_using_vary,
      total_using_both,
      vary_header,
      COUNT(0) AS occurrences,
      COUNT(0) / total_using_vary AS pct_of_vary,
      COUNT(0) / total_requests AS pct_of_total_requests
    FROM
      `httparchive.summary_requests.2020_08_01_desktop`,
      UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_vary), r'([a-z][^,\s="\']*)')) AS vary_header
    CROSS JOIN (
      SELECT
        COUNT(0) AS total_requests,
        COUNTIF(TRIM(resp_vary) != "") AS total_using_vary,
        COUNTIF(TRIM(resp_vary) != "" AND TRIM(resp_cache_control) != "") AS total_using_both
      FROM
        `httparchive.summary_requests.2020_08_01_desktop`
    )
    GROUP BY
      client,
      total_requests,
      total_using_vary,
      total_using_both,
      vary_header
  )
  UNION ALL
  (
    SELECT
      "mobile" AS client,
      total_requests,
      total_using_vary,
      total_using_both,
      vary_header,
      COUNT(0) AS occurrences,
      COUNT(0) / total_using_vary AS pct_of_vary,
      COUNT(0) / total_requests AS pct_of_total_requests
    FROM
      `httparchive.summary_requests.2020_08_01_mobile`,
      UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_vary), r'([a-z][^,\s="\']*)')) AS vary_header
    CROSS JOIN (
      SELECT
        COUNT(0) AS total_requests,
        COUNTIF(TRIM(resp_vary) != "") AS total_using_vary,
        COUNTIF(TRIM(resp_vary) != "" AND TRIM(resp_cache_control) != "") AS total_using_both
      FROM
        `httparchive.summary_requests.2020_08_01_mobile`
    )
    GROUP BY
      client,
      total_requests,
      total_using_vary,
      total_using_both,
      vary_header
  )
)
ORDER BY
  client, occurrences DESC
