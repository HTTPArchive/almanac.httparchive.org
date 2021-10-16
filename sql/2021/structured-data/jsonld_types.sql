# standardSQL
# Count JSON-LD types
CREATE TEMP FUNCTION getJSONLDTypes(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    const arrayify = (value) => Array.isArray(value) ? value : [value];

    const getDeep = (key, o) => {
      if (Array.isArray(o)) return o.map(child => getDeep(key, child)).flat();

      if (o instanceof Object) {
        return Object.entries(o).map(([k, value]) => {
          if (k === key) return [...arrayify(value), ...getDeep(value)];
          return getDeep(value);
        }).flat();
      }

      return [];
    }

    rendered = JSON.parse(rendered);
    const jsonld_scripts = rendered.jsonld_scripts;
    return jsonld_scripts.map(jsonld_script => {
      jsonld_script = JSON.parse(jsonld_script);
      return getDeep('@type', jsonld_script);
    }).flat();
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    getJSONLDTypes(rendered) AS jsonld_types,
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
  jsonld_type,
  COUNT(jsonld_type) AS count,
  SUM(COUNT(jsonld_type)) OVER (PARTITION BY client) AS total,
  COUNT(jsonld_type) / SUM(COUNT(jsonld_type)) OVER (PARTITION BY client) AS pct,
  client
FROM
  rendered_data,
  UNNEST(jsonld_types) AS jsonld_type
GROUP BY
  jsonld_type,
  client
ORDER BY
  count DESC
