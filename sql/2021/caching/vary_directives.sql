#standardSQL
# List of Vary directive names.
SELECT
  client,
  ANY_VALUE(total_requests) AS total_requests,
  ANY_VALUE(total_using_vary) AS total_using_vary,
  vary_header,
  ANY_VALUE(occurrences) AS occurrences,
  ANY_VALUE(occurrences) / ANY_VALUE(total_using_vary) AS pct_of_vary,
  ANY_VALUE(occurrences) / ANY_VALUE(total_requests) AS pct_of_total_requests,
  ANY_VALUE(total_using_both) / ANY_VALUE(total_using_vary) AS pct_of_vary_with_cache_control,
  ANY_VALUE(total_using_vary) / ANY_VALUE(total_requests) AS pct_using_vary
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_requests,
    COUNTIF(TRIM(resp_vary) != '') AS total_using_vary,
    COUNTIF(TRIM(resp_vary) != '' AND TRIM(resp_cache_control) != '') AS total_using_both
  FROM
    `httparchive.summary_requests.2021_07_01_*`
  GROUP BY
    client)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    vary_header,
    COUNT(0) AS occurrences
  FROM
    `httparchive.summary_requests.2021_07_01_*`
  LEFT JOIN
    UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_vary), r'([a-z][^,\s="\']*)')) AS vary_header
  GROUP BY
    client,
    vary_header)
USING
  (client)
WHERE
  vary_header IS NOT NULL
GROUP BY
  client,
  vary_header
ORDER BY
  occurrences DESC
