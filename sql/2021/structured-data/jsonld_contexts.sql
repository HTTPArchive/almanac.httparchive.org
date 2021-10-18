# standardSQL
# Count JSON-LD contexts
CREATE TEMP FUNCTION getJSONLDContexts(rendered STRING)
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
      return getDeep('@context', jsonld_script);
    }).flat().filter(context => typeof context === 'string');
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    getJSONLDContexts(rendered) AS jsonld_contexts,
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
  NET.REG_DOMAIN(jsonld_context) AS jsonld_context,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct,
  client
FROM
  rendered_data,
  UNNEST(jsonld_contexts) AS jsonld_context
GROUP BY
  jsonld_context,
  client
ORDER BY
  count DESC
