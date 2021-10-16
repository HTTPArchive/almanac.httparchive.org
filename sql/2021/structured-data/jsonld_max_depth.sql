# standardSQL
# Find the most nested entity in a JSON-LD document
CREATE TEMP FUNCTION getJSONLDEntitiesRelationships(rendered STRING)
RETURNS ARRAY<STRUCT<_from STRING, relationship STRING, _to STRING, depth NUMERIC>>
LANGUAGE js AS """
  try {
    const types = new Map();

    const loadTypes = (o) => {
      if (Array.isArray(o)) {
        o.forEach(loadTypes);
      } else if (o instanceof Object) {
        if (o['@id'] && o['@type']) {
          types.set(o['@id'], o['@type']);
        }

        Object.values(o).forEach(loadTypes);
      }
    }

    const arrayify = (value) => Array.isArray(value) ? value : [value];

    const getEntitiesAndRelationships = (o, _from, relationship, depth = 0) => {
      if (Array.isArray(o)) return o.map(value => getEntitiesAndRelationships(value, _from, relationship, depth)).flat();

      if (o instanceof Object) {
        const type = types.get(o['@id']) || o['@type'];
        return [{_from, relationship, _to: type, depth}, ...Object.entries(o).map(([k, value]) => getEntitiesAndRelationships(value, type, k, depth + 1))].flat();
      }

      return [];
    }

    rendered = JSON.parse(rendered);
    const jsonld_scripts = rendered.jsonld_scripts.map(JSON.parse);
    loadTypes(jsonld_scripts);

    return jsonld_scripts.map(jsonld_script => getEntitiesAndRelationships(jsonld_script, undefined, undefined, 0)).flat();
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    getJSONLDEntitiesRelationships(rendered) AS jsonld_entities_relationships,
    client
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered,
      _TABLE_SUFFIX AS client
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  MAX(jsonld_entity_relationship.depth) AS max_depth,
  client
FROM
  rendered_data,
  UNNEST(jsonld_entities_relationships) AS jsonld_entity_relationship
GROUP BY
  client
