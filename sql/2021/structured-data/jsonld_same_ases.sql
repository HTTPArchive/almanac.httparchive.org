# standardSQL
  # Count JSON-LD sameAs values
CREATE TEMP FUNCTION
  getJSONLDSameAses(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
  try {
    class URL {
      constructor(str) {
        this._str = str.trim();
      }

      get host() {
        return this._str.split('/')[2];
      }
    }

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
    const jsonld_scripts = rendered.jsonld_scripts
    return jsonld_scripts.map(jsonld_script => {
      jsonld_script = JSON.parse(jsonld_script)
      return getDeep('sameAs', jsonld_script)
    }).flat().map(url => {
        try {
          return new URL(url).host
        } catch {}
    })
  } catch (e) {
    return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getJSONLDSameAses(rendered) AS jsonld_sameases,
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
  jsonld_sameas,
  COUNT(jsonld_sameas) AS count,
  client
FROM
  rendered_data,
  UNNEST(jsonld_sameases) AS jsonld_sameas
GROUP BY
  jsonld_sameas,
  client
ORDER BY
  count DESC
