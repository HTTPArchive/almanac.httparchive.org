#standardSQL
  # A summary count of the pages run against
SELECT
  COUNT(JSON_EXTRACT(`structured_data`,
      '$.structured_data')) AS `success`,
  COUNT(JSON_EXTRACT(`structured_data`,
      '$.log')) AS `errors`,
  COUNT(*) AS `total`
FROM (
  SELECT
    JSON_VALUE(JSON_EXTRACT(payload,
        '$._structured-data')) AS `structured_data`
  FROM
    `httparchive.pages.2021_07_01_*`);