# standardSQL
# Count RDFa Type Ofs
CREATE TEMP FUNCTION getRDFaTypeOfs(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
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
    _TABLE_SUFFIX AS client,
    url,
    getRDFaTypeOfs(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS rdfa_type_ofs
  FROM
    `httparchive.pages.2021_07_01_*`
),

page_totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
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
