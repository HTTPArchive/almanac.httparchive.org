#standardSQL
# List of Vary directive names.
SELECT
  client,
  total_requests,
  total_using_vary,
  vary_header,
  occurrences,
  occurrences / total_using_vary AS pct_of_vary,
  occurrences / total_requests AS pct_of_total_requests,
  total_using_both / total_using_vary AS pct_of_vary_with_cache_control,
  total_using_vary / total_requests AS pct_using_vary
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    vary_header,
    COUNT(0) AS occurrences,
    SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total_requests,
    SUM(COUNTIF(TRIM(resp_vary) != '')) OVER (PARTITION BY _TABLE_SUFFIX) AS total_using_vary,
    SUM(COUNTIF(TRIM(resp_vary) != '' AND TRIM(resp_cache_control) != '')) OVER (PARTITION BY _TABLE_SUFFIX) AS total_using_both
  FROM
    `httparchive.summary_requests.2021_07_01_*`
  LEFT JOIN
    UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_vary), r'([a-z][^,\s="\']*)')) AS vary_header
  GROUP BY
    client,
    vary_header)
WHERE
  vary_header IS NOT NULL
ORDER BY
  client, occurrences DESC
