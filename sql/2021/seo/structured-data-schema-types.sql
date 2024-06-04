#standardSQL
# Structured data schema types


# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION getStructuredSchemaWptBodies(wpt_bodies_string STRING)
RETURNS STRUCT<
  jsonld_and_microdata_types ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};


try {
    var wpt_bodies = JSON.parse(wpt_bodies_string);

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.structured_data && wpt_bodies.structured_data.rendered) {
        var temp = wpt_bodies.structured_data.rendered.jsonld_and_microdata_types;
        result.jsonld_and_microdata_types = temp.map(a => a.name);
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  type,
  total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), total) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    getStructuredSchemaWptBodies(JSON_EXTRACT_SCALAR(
      payload,
      '$._wpt_bodies'
    )) AS structured_schema_wpt_bodies_info
  FROM
    `httparchive.pages.2021_07_01_*`
  JOIN (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    GROUP BY
      _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
),
  UNNEST(structured_schema_wpt_bodies_info.jsonld_and_microdata_types) AS type
GROUP BY
  total,
  type,
  client
HAVING
  count > 50
ORDER BY
  count DESC
