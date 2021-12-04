#standardSQL
# 16_06_3rd_party: Validity of Dates in Last-Modified and Date headers by party
SELECT
  client,
  party,
  COUNT(0) AS total_requests,

  COUNTIF(uses_date) AS total_date,
  COUNTIF(uses_last_modified) AS total_last_modified,
  COUNTIF(uses_date AND uses_last_modified) AS total_using_both,
  ROUND(COUNTIF(uses_date AND uses_last_modified) * 100 / COUNT(0), 2) AS pct_req_using_both,

  COUNTIF(uses_date AND NOT has_valid_date_header) AS total_invalid_date_header,
  COUNTIF(uses_last_modified AND NOT has_valid_last_modified) AS total_invalid_last_modified,
  COUNTIF((uses_date AND NOT has_valid_date_header) OR (uses_last_modified AND NOT has_valid_last_modified)) AS total_has_invalid_header,

  ROUND(COUNTIF(uses_date AND NOT has_valid_date_header) * 100 / COUNTIF(uses_date), 2) AS pct_invalid_date_header,
  ROUND(COUNTIF(uses_last_modified AND NOT has_valid_last_modified) * 100 / COUNTIF(uses_last_modified), 2) AS pct_invalid_last_modified,
  ROUND(COUNTIF((uses_date AND NOT has_valid_date_header) OR (uses_last_modified AND NOT has_valid_last_modified)) * 100 / COUNT(0), 2) AS pct_req_with_invalid_header
FROM (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    TRIM(resp_date) != "" AS uses_date,
    TRIM(resp_last_modified) != "" AS uses_last_modified,

    REGEXP_CONTAINS(TRIM(resp_date), r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), \d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4} \d{2}:\d{2}:\d{2} GMT$') AS has_valid_date_header,
    REGEXP_CONTAINS(TRIM(resp_last_modified), r'^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), \d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4} \d{2}:\d{2}:\d{2} GMT$') AS has_valid_last_modified
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
)
GROUP BY
  client,
  party
ORDER BY
  client,
  party
