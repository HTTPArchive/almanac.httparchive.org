# standardSQL
  # Count JSON-LD contexts
CREATE TEMP FUNCTION
  getJSONLDContexts(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
  try {
    const getDeep = (key, o) => {
      if (Array.isArray(o)) return o.map(child => getDeep(key, child)).flat();

      if (o instanceof Object) {
        return Object.entries(o).map(([k, value]) => {
          if (k === key) return [value, ...getDeep(value)];
          return getDeep(value);
        }).flat();
      }

      return [];
    }

    rendered = JSON.parse(rendered);
    const jsonld_scripts = rendered.jsonld_scripts
    return jsonld_scripts.map(jsonld_script => {
      jsonld_script = JSON.parse(jsonld_script)
      return getDeep('@context', jsonld_script)
    }).flat()
  } catch (e) {
    return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getJSONLDContexts(rendered) AS jsonld_contexts
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  jsonld_context,
  COUNT(jsonld_context) AS count
FROM
  rendered_data,
  UNNEST(jsonld_contexts) AS jsonld_context
GROUP BY
  jsonld_context
ORDER BY
  count DESC
