#standardSQL
  # returns the number preload script tags that are not used later with the right script type
CREATE TEMPORARY FUNCTION
  numMissingCrossOriginTags(almanac_string STRING)
  RETURNS INT64
  LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string);
    if (almanac === null || Array.isArray(almanac) || typeof almanac !== "object") return null;

    var nodes = almanac["link-nodes"] ? almanac["link-nodes"]["nodes"] : [];
    nodes = typeof nodes == "string" ? JSON.parse(nodes) : nodes;

    var scriptNodes = almanac["scripts"] ? almanac["scripts"]["nodes"] : [];
    scriptNodes = typeof scriptNodes == "string" ? JSON.parse(scriptNodes) : scriptNodes;

    // all script nodes with non-empty or non-js type
    const incompatibleScriptSrcs = scriptNodes.filter(sn => !!sn['type'] && sn['type'].length > 0 && sn['type'].toLowerCase() !== "text/javascript" && sn['src']).map(sn => sn['src'])

    var possibleDupDownloads = 0
    for (var node of nodes) {
      if (node["rel"] && node["rel"].toLowerCase() === "preload" && node["as"] && node["as"].toLowerCase() === "script" && incompatibleScriptSrcs.indexOf(node['src']) >= 0) {
        possibleDupDownloads++
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
    JSON_EXTRACT_SCALAR(payload,
      '$._almanac') AS almanac,
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
  2
