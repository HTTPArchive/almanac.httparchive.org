#standardSQL
# Pages that opt out of FLoC

WITH response_headers AS (
  SELECT
    client,
    page,
    rank,
    LOWER(JSON_VALUE(response_header, '$.name')) AS name,
    LOWER(JSON_VALUE(response_header, '$.value')) AS value
  FROM
    `httparchive.almanac.summary_response_bodies`,
    UNNEST(JSON_QUERY_ARRAY(response_headers)) response_header
  WHERE
    date = '2021-07-01'
  AND
    firstHtml = TRUE
),

total_nb_pages AS (
  SELECT
    client,
    rank,
    COUNT(DISTINCT page) AS total_nb_pages
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2021-07-01'
  AND
    firstHtml = TRUE
  GROUP BY
    1, 2
)

SELECT
  client,
  rank,
  COUNT(DISTINCT page) AS nb_websites,
  ROUND(COUNT(DISTINCT page) / MIN(total_nb_pages.total_nb_pages), 2) AS pct_websites
FROM
  response_headers JOIN total_nb_pages USING (client, rank)
WHERE
  name = 'permissions-policy'
  AND
  value LIKE 'interest-cohort=()' # value could contain other policies
GROUP BY
  1, 2
