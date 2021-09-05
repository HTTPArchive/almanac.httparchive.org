#standardSQL
  # A dump of the entire structured data custom metric for each rendered page
SELECT
  JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
        '$._structured-data')),
    '$.structured_data.rendered') AS rendered
FROM
  `httparchive.pages.2021_07_01_*`;
