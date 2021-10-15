#standardSQL
# Table stats. Total all, captioned and presentational
SELECT
  client,
  COUNT(0) AS total_sites,

  COUNTIF(total_tables > 0) AS sites_with_table,
  COUNTIF(total_captioned > 0) AS sites_with_captions,
  COUNTIF(total_presentational > 0) AS sites_with_presentational,

  COUNTIF(total_tables > 0) / COUNT(0) AS pct_sites_with_table,
  COUNTIF(total_captioned > 0) / COUNTIF(total_tables > 0) AS pct_table_sites_with_captioned,
  COUNTIF(total_presentational > 0) / COUNTIF(total_tables > 0) AS pct_table_sites_with_presentational,

  SUM(total_tables) AS total_tables,
  SUM(total_captioned) AS total_captioned,
  SUM(total_presentational) AS total_presentational,

  SUM(total_captioned) / SUM(total_tables) AS pct_captioned,
  SUM(total_presentational) / SUM(total_tables) AS pct_presentational
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.tables.total') AS INT64) AS total_tables,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.tables.total_with_caption') AS INT64) AS total_captioned,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._a11y'), '$.tables.total_with_presentational') AS INT64) AS total_presentational
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
