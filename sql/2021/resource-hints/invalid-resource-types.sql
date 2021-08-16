#standardSQL

# returns the number of valid and invalid preload resource types
CREATE TEMPORARY FUNCTION getInvalidTypes(almanac_string STRING) RETURNS ARRAY<STRUCT<type STRING, num_occurrences NUMERIC>>
LANGUAGE js AS '''
try {
    // obtained from https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types/preload#what_types_of_content_can_be_preloaded
    var validResourceTypes = [
      "audio",
      "document",
      "embed",
      "fetch",
      "font",
      "image",
      "object",
      "script",
      "style",
      "track",
      "worker",
      "video",
    ];
    
    var almanac = JSON.parse(almanac_string);
    if (almanac === null || Array.isArray(almanac) || typeof almanac !== "object") return [];

    var nodes = almanac["link-nodes"] ? almanac["link-nodes"]["nodes"] : [];
    nodes = typeof nodes == "string" ? JSON.parse(nodes) : nodes;

    var validTypesCnt = 0;
    var invalidTypesCnt = 0;
    var invalidTypes = {};

    for (var node of nodes) {
      if (node["rel"] && node["rel"].toLowerCase() === "preload") {
        if (!node["as"]){
          invalidTypes["missing_as"] = ++invalidTypes["missing_as"] || 1;
          invalidTypesCnt += 1;
        }
        else if (validResourceTypes.indexOf(node["as"].toLowerCase()) >= 0) {
          validTypesCnt += 1;
        } else {
          invalidTypes[node["as"].toLowerCase()] = ++invalidTypes[node["as"].toLowerCase()] || 1
          invalidTypesCnt += 1;
        }
      }
    }

    var result = [
      { type: "valid", num_occurrences: validTypesCnt },
      { type: "invalid", num_occurrences: invalidTypesCnt },
    ];

    for (var type in invalidTypes) {
      result.push({
        type,
        num_occurrences: invalidTypes[type],
      });
    }
    return result;
} catch (error) {
    return [{type: "ERROR: " + error, num_occurrences: 1}]
}
''';

SELECT
    client,
    type,
    SUM(num_occurrences) AS total_occurrences
FROM
  (
    SELECT
        _TABLE_SUFFIX AS client,
        rd.type,
        rd.num_occurrences
    FROM
        # `httparchive.sample_data.pages*`,
        `httparchive.pages.2021_06_01_*`,
        UNNEST(getInvalidTypes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS rd
    WHERE
        payload IS NOT NULL
  )
GROUP BY
    client,
    type
ORDER BY
    total_occurrences DESC
