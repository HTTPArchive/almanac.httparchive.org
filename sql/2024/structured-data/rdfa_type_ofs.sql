# standardSQL
# rdfa_type_ofs.sql
# Count RDFa Type Ofs
CREATE TEMP FUNCTION getRDFaTypeOfs(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS r"""
  try {
    rendered = JSON.parse(rendered);
    return rendered.rdfa_typeofs.map(typeOf => typeOf.toLowerCase().trim().split(/\s+/)).flat();
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    client,
    root_page AS url,
    getRDFaTypeOfs(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS rdfa_type_ofs
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
),

page_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_pages
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  client,
  rdfa_type_of,
  COUNT(rdfa_type_of) AS freq_rdfa_type_of,
  SUM(COUNT(rdfa_type_of)) OVER (PARTITION BY client) AS total_rdfa_type_of,
  COUNT(rdfa_type_of) / SUM(COUNT(rdfa_type_of)) OVER (PARTITION BY client) AS pct_rdfa_type_of,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(rdfa_type_ofs) AS rdfa_type_of
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  rdfa_type_of,
  total_pages
ORDER BY
  pct_rdfa_type_of DESC,
  client
