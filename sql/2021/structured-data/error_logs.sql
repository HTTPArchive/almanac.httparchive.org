#standardSQL
  # A list of the error logs created in the run
SELECT
  *
FROM (
  SELECT
    JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
          '$._structured-data')),
      '$.log') AS `logs`
  FROM
    `httparchive.pages.2021_07_01_*`)
WHERE
  `logs` IS NOT NULL;
