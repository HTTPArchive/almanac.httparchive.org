# standardSQL
# jsonld_contexts.sql
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
    client,
    root_page AS url,
    getJSONLDContexts(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS jsonld_context
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
  NET.REG_DOMAIN(jsonld_context) AS jsonld_context,
  COUNT(0) AS freq_jsonld_context,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_jsonld_context,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_jsonld_context,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(jsonld_context) AS jsonld_context
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  jsonld_context,
  total_pages
ORDER BY
  pct_jsonld_context DESC,
  client
