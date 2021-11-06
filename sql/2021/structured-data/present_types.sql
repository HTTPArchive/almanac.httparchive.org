#standardSQL
  # A count of pages which include each type of structured data
SELECT
  client,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.rdfa') AS BOOL) = TRUE) AS rdfa,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.json_ld') AS BOOL) = TRUE) AS json_ld,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microdata') AS BOOL) = TRUE) AS microdata,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats2') AS BOOL) = TRUE) AS microformats2,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats_classic') AS BOOL) = TRUE) AS microformats_classic,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.dublin_core') AS BOOL) = TRUE) AS dublin_core,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.twitter') AS BOOL) = TRUE) AS twitter,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.facebook') AS BOOL) = TRUE) AS facebook,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.opengraph') AS BOOL) = TRUE) AS opengraph,
  COUNTIF(JSON_EXTRACT(structured_data, '$.structured_data') IS NOT NULL AND JSON_EXTRACT(structured_data, '$.log') IS NULL) AS total_structured_data_ran,
  COUNT(0) AS total_pages,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.rdfa') AS BOOL) = TRUE) / COUNT(0) AS pct_rdfa,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.json_ld') AS BOOL) = TRUE) / COUNT(0) AS pct_json_ld,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microdata') AS BOOL) = TRUE) / COUNT(0) AS pct_microdata,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats2') AS BOOL) = TRUE) / COUNT(0) AS pct_microformats2,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats_classic') AS BOOL) = TRUE) / COUNT(0) AS pct_microformats_classic,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.dublin_core') AS BOOL) = TRUE) / COUNT(0) AS pct_dublin_core,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.twitter') AS BOOL) = TRUE) / COUNT(0) AS pct_twitter,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.facebook') AS BOOL) = TRUE) / COUNT(0) AS pct_facebook,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.opengraph') AS BOOL) = TRUE) / COUNT(0) AS pct_opengraph,
  COUNTIF(JSON_EXTRACT(structured_data, '$.structured_data') IS NOT NULL AND JSON_EXTRACT(structured_data, '$.log') IS NULL) / COUNT(0) AS pct_total_structured_data_ran,
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')) AS structured_data
  FROM
    `httparchive.pages.2021_07_01_*`)
GROUP BY
  client
ORDER BY
  client
