#standardSQL
# Pages that opt out of FLoC

WITH response_headers AS (
  SELECT
    client,
    page,
    rank,
    JSON_VALUE(response_header, '$.name') AS name,
    JSON_VALUE(response_header, '$.value') AS value
  FROM
    `httparchive.almanac.summary_response_bodies`,
    UNNEST(JSON_QUERY_ARRAY(response_headers)) response_header
  WHERE
    date = '2021-07-01'
  AND
    firstHtml = TRUE
)

SELECT
  client,
  rank,
  COUNT(DISTINCT page) AS nb_websites,
  ROUND(COUNT(0) / (SELECT COUNT(0) FROM response_headers), 2) AS pct_websites
FROM
  response_headers
WHERE
  name = 'Permissions-Policy'
  AND
  value LIKE 'interest-cohort=()' # value could contain other policies
GROUP BY
  1, 2
