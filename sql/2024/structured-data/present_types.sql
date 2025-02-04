# standardSQL
# present_types.sql

# A count of pages which include each type of structured data
SELECT
  client,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.rdfa') AS BOOL)) AS rdfa,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.json_ld') AS BOOL)) AS json_ld,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microdata') AS BOOL)) AS microdata,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats2') AS BOOL)) AS microformats2,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats_classic') AS BOOL)) AS microformats_classic,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.dublin_core') AS BOOL)) AS dublin_core,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.twitter') AS BOOL)) AS twitter,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.facebook') AS BOOL)) AS facebook,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.opengraph') AS BOOL)) AS opengraph,
  COUNTIF(JSON_EXTRACT(structured_data, '$.structured_data') IS NOT NULL AND JSON_EXTRACT(structured_data, '$.log') IS NULL) AS total_structured_data_ran,
  COUNT(DISTINCT root_page) AS total_pages,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.rdfa') AS BOOL)) / COUNT(0) AS pct_rdfa,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.json_ld') AS BOOL)) / COUNT(0) AS pct_json_ld,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microdata') AS BOOL)) / COUNT(0) AS pct_microdata,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats2') AS BOOL)) / COUNT(0) AS pct_microformats2,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats_classic') AS BOOL)) / COUNT(0) AS pct_microformats_classic,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.dublin_core') AS BOOL)) / COUNT(0) AS pct_dublin_core,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.twitter') AS BOOL)) / COUNT(0) AS pct_twitter,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.facebook') AS BOOL)) / COUNT(0) AS pct_facebook,
  COUNTIF(CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.opengraph') AS BOOL)) / COUNT(0) AS pct_opengraph,
  COUNTIF(JSON_EXTRACT(structured_data, '$.structured_data') IS NOT NULL AND JSON_EXTRACT(structured_data, '$.log') IS NULL) / COUNT(0) AS pct_total_structured_data_ran
FROM (
  SELECT
    client,
    JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')) AS structured_data,
    root_page
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client
ORDER BY
  client
