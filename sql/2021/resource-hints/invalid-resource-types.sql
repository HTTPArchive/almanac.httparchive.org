#standardSQL
# returns the number of valid and invalid preload resource types
CREATE TEMPORARY FUNCTION getInvalidTypes(almanac_string STRING)
RETURNS STRING LANGUAGE js AS '''
try {
    // obtained from https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types/preload#what_types_of_content_can_be_preloaded
    var validResourceTypes = ['audio', 'document', 'embed', 'fetch', 'font', 'image', 'object', 'script', 'style', 'track', 'worker', 'video']
    var almanac = JSON.parse(almanac_string)
    if (Array.isArray(almanac) || typeof almanac != 'object') return '{}';
    var nodes = almanac["link-nodes"]["nodes"]
    nodes = typeof nodes == 'string' ? JSON.parse(nodes) : nodes
    var validTypesCnt = 0
    var invalidTypesCnt = 0
    var invalidTypes = {}
    for (var node of nodes) {
      if (node['rel'].toLowerCase() === 'preload') {
        if (validResourceTypes.indexOf(node['as'].toLowerCase()) >= 0) {
          validTypesCnt += 1
        } else {
          if(node['as'].toLowerCase() in invalidTypes) {
            invalidTypes[node['as'].toLowerCase()] += 1
          } else {
            invalidTypes[node['as'].toLowerCase()] = 1
          }
          invalidTypesCnt += 1
        }
      }
    }
    return JSON.stringify({ validTypesCnt, invalidTypesCnt, as: invalidTypes });
  }
  catch {
    return '{}'
  }
''';
SELECT
    client,
    types,
    COUNT(0) as count
FROM (
    SELECT
        client,
        CAST(JSON_EXTRACT_SCALAR(invalidTypes, '$.invalidTypesCnt') AS NUMERIC) AS invalid,
        JSON_QUERY(invalidTypes, '$.as') as types,
    FROM (
        SELECT
            _TABLE_SUFFIX AS client,
            JSON_QUERY(payload, '$._almanac') AS almanac, 
            getInvalidTypes(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS invalidTypes
        FROM
            `httparchive.sample_data.pages*`
    )
)
WHERE
    invalid > 0
GROUP BY 
    client,
    types
ORDER BY 
    count DESC