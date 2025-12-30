#standardSQL
# Structured data schema types

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION getStructuredSchemaWptBodies(wpt_bodies JSON)
RETURNS STRUCT<
  jsonld_and_microdata_types ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};
try {
  if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

  if (wpt_bodies.structured_data && wpt_bodies.structured_data.rendered) {
    var temp = wpt_bodies.structured_data.rendered.jsonld_and_microdata_types;
    result.jsonld_and_microdata_types = temp.map(a => a.name);
  }
} catch (e) {}
return result;
''';

WITH structured_data AS (
  SELECT
    client,
    root_page,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    getStructuredSchemaWptBodies(TO_JSON(custom_metrics.wpt_bodies)) AS structured_schema_wpt_bodies_info,
    COUNT(DISTINCT root_page) OVER (PARTITION BY client) AS total_sites
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  type,
  COUNT(DISTINCT root_page) AS sites,
  COUNT(DISTINCT root_page) / ANY_VALUE(total_sites) AS pct
FROM
  structured_data,
  UNNEST(structured_schema_wpt_bodies_info.jsonld_and_microdata_types) AS type
GROUP BY
  type,
  is_root_page,
  client
HAVING
  sites > 50
ORDER BY
  sites DESC
