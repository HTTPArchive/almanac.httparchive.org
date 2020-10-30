# Valid date in Date, Last-Modified, and Expires headers
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(uses_date) AS total_date,
  COUNTIF(uses_last_modified) AS total_last_modified,
  COUNTIF(uses_expires) AS total_expires,
  COUNTIF(uses_date AND uses_last_modified AND uses_expires) AS total_using_all,
  COUNTIF(uses_date AND NOT has_valid_date_header) AS total_invalid_date_header,
  COUNTIF(uses_last_modified AND NOT has_valid_last_modified) AS total_invalid_last_modified,
  COUNTIF(uses_expires AND NOT has_valid_expires) AS total_invalid_expires,
  COUNTIF((uses_date AND NOT has_valid_date_header) OR (uses_last_modified AND NOT has_valid_last_modified) OR (uses_expires AND NOT has_valid_expires)) AS total_has_invalid_header,
  COUNTIF(uses_date) / COUNT(0) AS pct_date,
  COUNTIF(uses_last_modified) / COUNT(0) AS pct_last_modified,
  COUNTIF(uses_expires) / COUNT(0) AS pct_expires,
  COUNTIF(uses_date AND NOT has_valid_date_header) / COUNTIF(uses_date) AS pct_invalid_date_header,
  COUNTIF(uses_last_modified AND NOT has_valid_last_modified) / COUNTIF(uses_last_modified) AS pct_invalid_last_modified,
  COUNTIF(uses_expires AND NOT has_valid_expires) / COUNTIF(uses_expires) AS pct_invalid_expires,
  COUNTIF(uses_date AND uses_last_modified AND uses_expires) / COUNT(0) AS pct_req_using_all,
  COUNTIF((uses_date AND NOT has_valid_date_header) OR (uses_last_modified AND NOT has_valid_last_modified) OR (uses_expires AND NOT has_valid_expires)) / COUNT(0) AS pct_req_with_invalid_header
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    TRIM(resp_date) != "" AS uses_date,
    TRIM(resp_last_modified) != "" AS uses_last_modified,
    TRIM(resp_expires) != "" AS uses_expires,
    REGEXP_CONTAINS(TRIM(resp_date), r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), \d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4} \d{2}:\d{2}:\d{2} GMT$') AS has_valid_date_header,
    REGEXP_CONTAINS(TRIM(resp_last_modified), r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), \d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4} \d{2}:\d{2}:\d{2} GMT$') AS has_valid_last_modified,
    REGEXP_CONTAINS(TRIM(resp_expires), r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), \d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4} \d{2}:\d{2}:\d{2} GMT$') AS has_valid_expires
  FROM
    `httparchive.summary_requests.2020_08_01_*`
)
GROUP BY
  client
