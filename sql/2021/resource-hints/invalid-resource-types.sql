#standardSQL

# returns the number of valid and invalid preload resource types
CREATE TEMPORARY FUNCTION getInvalidTypes(almanac_string STRING) RETURNS ARRAY<STRUCT<type STRING, num_occurences NUMERIC>> 
LANGUAGE js AS '''
try {
    // obtained from https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types/preload#what_types_of_content_can_be_preloaded
    var validResourceTypes = ['audio', 'document', 'embed', 'fetch', 'font', 'image', 'object', 'script', 'style', 'track', 'worker', 'video']
    var almanac = JSON.parse(almanac_string)
    if (Array.isArray(almanac) || typeof almanac != 'object') return [];
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
          if (node['as'].toLowerCase() in invalidTypes) {
            invalidTypes[node['as'].toLowerCase()] += 1
          } else {
            invalidTypes[node['as'].toLowerCase()] = 1
          }
          invalidTypesCnt += 1
        }
      }
    }

    var result = [
        {"type": "validTypesCnt", num_occurences: validTypesCnt},
        {"type": "invalidTypesCnt", num_occurences: invalidTypesCnt}
    ]

    for(var type in invalidTypes) {
        result.push({
            type,
            num_occurences: invalidTypes[type]
        })
    }
    return result
} catch {
    return []
}
''';

SELECT
    client,
    type,
    SUM(num_occurences) AS total_occurences
FROM (
    SELECT 
        _TABLE_SUFFIX AS client,
        url,
        JSON_QUERY(payload, '$._almanac') AS almanac,
        rd.type,
        rd.num_occurences
    FROM
        `httparchive.pages.2021_06_01_*`,
        UNNEST(getInvalidTypes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS rd
    WHERE
        payload IS NOT NULL
)
GROUP BY
    client,
    type
ORDER BY
    total_occurences DESC
