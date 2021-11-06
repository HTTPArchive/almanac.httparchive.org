# standardSQL
# Count JSON-LD entities and relationships
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
    _TABLE_SUFFIX AS client,
    url,
    getJSONLDEntitiesRelationships(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS jsonld_entities_relationships
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
  jsonld_entity_relationship._from,
  jsonld_entity_relationship.relationship,
  jsonld_entity_relationship._to,
  jsonld_entity_relationship.depth,
  COUNT(0) AS freq_relationship,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_relationship,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_relationship,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(jsonld_entities_relationships) AS jsonld_entity_relationship
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  jsonld_entity_relationship._from,
  jsonld_entity_relationship.relationship,
  jsonld_entity_relationship._to,
  jsonld_entity_relationship.depth,
  total_pages
ORDER BY
  pct_relationship DESC,
  client
LIMIT 1000
