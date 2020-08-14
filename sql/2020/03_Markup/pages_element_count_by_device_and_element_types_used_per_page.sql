#standardSQL
# Element types per page M203
# See related: sql/2019/03_Markup/03_06b.sql

CREATE TEMPORARY FUNCTION get_element_types_used(element_count_string STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
    if (!element_count_string) return null;

    var element_count = JSON.parse(element_count_string); // should be an object with element type properties with values of how often they are present

    if (Array.isArray(element_count) || typeof element_count != 'object') return null;
    
    return Object.keys(element_count).length; // number of properties defined

} catch (e) { 
  return null;
}

''';

SELECT
  _TABLE_SUFFIX AS client,
  get_element_types_used(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS element_types_used,
  COUNT(0) AS freq
FROM
  `httparchive.sample_data.pages_*` # TEST
GROUP BY
  client,
  element_types_used
HAVING
  element_types_used IS NOT NULL
ORDER BY
  element_types_used,
  client
