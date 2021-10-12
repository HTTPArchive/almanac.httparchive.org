# standardSQL
  # Count JSON-LD relationships
CREATE TEMP FUNCTION
  getJSONLDRelationships(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
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
    const jsonld_scripts = rendered.jsonld_scripts
    return jsonld_scripts.map(jsonld_script => {
      jsonld_script = JSON.parse(jsonld_script)
      return getRelationships(jsonld_script)
    }).flat();
  } catch (e) {
    return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getJSONLDRelationships(rendered) AS jsonld_relationships,
    client
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered,
      _TABLE_SUFFIX AS client
    FROM
      `httparchive.pages.2021_07_01_*` LIMIT 1000)
)

SELECT
  jsonld_relationship,
  COUNT(jsonld_relationship) AS count,
  client
FROM
  rendered_data,
  UNNEST(jsonld_relationships) AS jsonld_relationship
GROUP BY
  jsonld_relationship,
  client
ORDER BY
  count DESC
