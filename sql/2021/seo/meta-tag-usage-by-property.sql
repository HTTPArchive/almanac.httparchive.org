#standardSQL
# Meta tag usage by property

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getMetaTagAlmanacInfo(almanac_string STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac && almanac["meta-nodes"] && almanac["meta-nodes"].nodes && almanac["meta-nodes"].nodes.filter) {
      result = almanac["meta-nodes"].nodes
        .filter(n => n["property"]) // just with a property attribute
        .map(am => am["property"].toLowerCase().trim()) // array of the property values
        .filter((v, i, a) => a.indexOf(v) === i); // remove duplicates
    }

} catch (e) {} // results show some issues with the validity of the payload
return result;
''';

SELECT
  client,
  meta_tag_property,
  total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), total) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    getMetaTagAlmanacInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS meta_tag_almanac_info
  FROM
    `httparchive.pages.2021_07_01_*`
  JOIN (

    SELECT _TABLE_SUFFIX, COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    GROUP BY _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
),
  UNNEST(meta_tag_almanac_info) AS meta_tag_property
GROUP BY
  total,
  meta_tag_property,
  client
ORDER BY
  count DESC
LIMIT 1000
