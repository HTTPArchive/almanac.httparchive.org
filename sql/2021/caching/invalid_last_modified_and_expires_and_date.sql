#standardSQL
# Valid date in Last-Modified, Expires, and Date headers
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(uses_date) AS total_using_date,
  COUNTIF(uses_last_modified) AS total_using_last_modified,
  COUNTIF(uses_expires) AS total_using_expires,
  COUNTIF(uses_date AND NOT has_valid_date) AS total_using_invalid_date,
  COUNTIF(uses_last_modified AND NOT has_valid_last_modified) AS total_using_invalid_last_modified,
  COUNTIF(uses_expires AND NOT has_valid_expires) AS total_using_invalid_expires,
  COUNTIF(uses_date) / COUNT(0) AS pct_using_date,
  COUNTIF(uses_last_modified) / COUNT(0) AS pct_using_last_modified,
  COUNTIF(uses_expires) / COUNT(0) AS pct_using_expires,
  COUNTIF(uses_date AND NOT has_valid_date) / COUNT(uses_date) AS pct_using_invalid_date,
  COUNTIF(uses_last_modified AND NOT has_valid_last_modified) / COUNT(uses_last_modified) AS pct_using_invalid_last_modified,
  COUNTIF(uses_expires AND NOT has_valid_expires) / COUNT(uses_expires) AS pct_using_invalid_expires
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    TRIM(resp_date) != "" AS uses_date,
    TRIM(resp_last_modified) != "" AS uses_last_modified,
    TRIM(resp_expires) != "" AS uses_expires,
    REGEXP_CONTAINS(TRIM(resp_date), r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), \d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4} \d{2}:\d{2}:\d{2} GMT$') AS has_valid_date,
    REGEXP_CONTAINS(TRIM(resp_last_modified), r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), \d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4} \d{2}:\d{2}:\d{2} GMT$') AS has_valid_last_modified,
    REGEXP_CONTAINS(TRIM(resp_expires), r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), \d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4} \d{2}:\d{2}:\d{2} GMT$') AS has_valid_expires
  FROM
    `httparchive.summary_requests.2021_07_01_*`
)
GROUP BY
  client
