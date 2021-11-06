#standardSQL
# A summary count of the pages run against
SELECT
  client,
  COUNTIF(success IS NOT NULL) AS success,
  COUNTIF(errors IS NOT NULL) AS errors,
  COUNTIF(success IS NOT NULL AND errors IS NULL) AS success_no_errors,
  COUNTIF(errors IS NOT NULL AND success IS NULL) AS errors_no_success,
  COUNTIF(success IS NOT NULL AND errors IS NOT NULL) AS success_errors,
  COUNTIF(success IS NULL AND errors IS NULL) AS no_success_no_errors,
  COUNTIF(success IS NOT NULL) / COUNT(0) AS pct_success,
  COUNTIF(errors IS NOT NULL) / COUNT(0) AS pct_errors,
  COUNTIF(success IS NOT NULL AND errors IS NULL) / COUNT(0) AS pct_success_no_errors,
  COUNTIF(errors IS NOT NULL AND success IS NULL) / COUNT(0) AS pct_errors_no_success,
  COUNTIF(success IS NOT NULL AND errors IS NOT NULL) / COUNT(0) AS pct_success_errors,
  COUNTIF(success IS NULL AND errors IS NULL) / COUNT(0) AS pct_no_success_no_errors
FROM (
  SELECT
    client,
    JSON_EXTRACT(structured_data, '$.structured_data') AS success,
    JSON_EXTRACT(structured_data, '$.log') AS errors
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')) AS structured_data
    FROM
      `httparchive.pages.2021_07_01_*`
  )
)
GROUP BY
  client
ORDER BY
  client
