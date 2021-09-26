#standardSQL

# returns the number preload font tags without crossorigin attribute
CREATE TEMPORARY FUNCTION
  numMissingCrossOriginTags(almanac_string STRING)
  RETURNS INT64
  LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string);
    if (almanac === null || Array.isArray(almanac) || typeof almanac !== "object") return null;

    var nodes = almanac["link-nodes"] ? almanac["link-nodes"]["nodes"] : [];
    nodes = typeof nodes == "string" ? JSON.parse(nodes) : nodes;

    var possibleDupDownloads = 0
    for (var node of nodes) {
      if (node["rel"] && node["rel"].toLowerCase() === "preload" && node["as"] && node["as"].toLowerCase() === "font") {
        const missingCrossOrigin = Object.keys(node).filter(k => k.toLowerCase().indexOf("crossorigin") === 0).length === 0
        if(missingCrossOrigin) {
            possibleDupDownloads++
        }
      }
    }
    // if this is 0 it could be either be the dev used the preload tag properly with cardinality attr everywhere or they did not have any such tags
    return possibleDupDownloads; 
} catch (error) {
    return null
}
''';
SELECT
  *
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    # JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac,
    numMissingCrossOriginTags(JSON_EXTRACT_SCALAR(payload,
        '$._almanac')) AS numDupDownlaods
  FROM
    `httparchive.sample_data.pages*`
    # `httparchive.pages.2021_07_01_*`
  WHERE
    payload IS NOT NULL )
WHERE
  numDupDownlaods IS NOT NULL
  AND numDupDownlaods > 0
LIMIT
  5