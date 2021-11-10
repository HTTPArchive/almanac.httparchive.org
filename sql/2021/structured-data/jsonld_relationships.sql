# standardSQL
# Count JSON-LD relationships
CREATE TEMP FUNCTION getJSONLDRelationships(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    const arrayify = (value) => Array.isArray(value) ? value : [value];

    const getRelationships = (o) => {
      if (Array.isArray(o)) return o.map(child => getRelationships(child)).flat();

      if (o instanceof Object) {
        return Object.entries(o).map(([k, value]) => {
          if (!k.startsWith('@')) return [k, ...getRelationships(value)];
          return getRelationships(value);
        }).flat();
      }

      return [];
    }

    rendered = JSON.parse(rendered);
    const jsonld_scripts = rendered.jsonld_scripts;
    return jsonld_scripts.map(jsonld_script => {
      jsonld_script = JSON.parse(jsonld_script);
      return getRelationships(jsonld_script);
    }).flat();
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    getJSONLDRelationships(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS jsonld_relationships
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
  jsonld_relationship,
  COUNT(jsonld_relationship) AS freq_relationship,
  SUM(COUNT(jsonld_relationship)) OVER (PARTITION BY client) AS total_relationship,
  COUNT(jsonld_relationship) / SUM(COUNT(jsonld_relationship)) OVER (PARTITION BY client) AS pct_relationship,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(jsonld_relationships) AS jsonld_relationship
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  jsonld_relationship,
  total_pages
ORDER BY
  pct_relationship DESC,
  client
LIMIT 1000
