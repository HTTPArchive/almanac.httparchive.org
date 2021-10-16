#standardSQL
# A summary count of the pages run against
SELECT
  SUM(CASE
      WHEN success IS NOT NULL THEN 1
      ELSE
        0
    END
  ) AS success,
  SUM(CASE
      WHEN errors IS NOT NULL THEN 1
      ELSE
        0
    END
  ) AS errors,
  SUM(CASE
      WHEN success IS NOT NULL AND errors IS NULL THEN 1
      ELSE
        0
    END
  ) AS success_no_errors,
  SUM(CASE
      WHEN errors IS NOT NULL AND success IS NULL THEN 1
      ELSE
        0
    END
  ) AS errors_no_success,
  SUM(CASE
      WHEN success IS NOT NULL AND errors IS NOT NULL THEN 1
      ELSE
        0
    END
  ) AS success_errors,
  SUM(CASE
      WHEN success IS NULL AND errors IS NULL THEN 1
      ELSE
        0
    END
  ) AS no_success_no_errors
FROM (
  SELECT
    JSON_EXTRACT(structured_data,
      '$.structured_data') AS success,
    JSON_EXTRACT(structured_data,
      '$.log') AS errors
  FROM (
    SELECT
      JSON_VALUE(JSON_EXTRACT(payload,
          '$._structured-data')) AS structured_data
    FROM
      `httparchive.pages.2021_07_01_*`))
