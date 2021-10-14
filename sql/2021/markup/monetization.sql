#standardSQL

# returns the value of the monetization meta node
CREATE TEMPORARY FUNCTION get_almanac_meta_monetization(almanac_string STRING)
RETURNS STRING LANGUAGE js AS '''
try {
    const almanac = JSON.parse(almanac_string); 
    if (Array.isArray(almanac) || typeof almanac != 'object') return '';

    let nodes = almanac["meta-nodes"]["nodes"];
    nodes = typeof nodes === "string" ? JSON.parse(nodes) : nodes;
    
    const filteredNode = nodes.filter(n => n.name && n.name.toLowerCase() == "monetization");    

    if (filteredNode.length === 0) {
      return "";
    }
    
    return filteredNode[0].content;
} catch (e) { 
  return "";
}
''';

SELECT
  client,
  COUNTIF(monetization != "") AS freq,
  COUNT(0) AS total,
  COUNTIF(monetization != "") / COUNT(0) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    get_almanac_meta_monetization(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS monetization
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
ORDER BY
  client,
  freq DESC
