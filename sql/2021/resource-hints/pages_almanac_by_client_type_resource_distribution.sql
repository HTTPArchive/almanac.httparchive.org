  # standardSQL
  # Analyze resource hints by distribution

CREATE TEMPORARY FUNCTION getResourceHints(almanacJsonStr STRING)
RETURNS ARRAY<STRUCT<linkRel STRING, linkType STRING, numOccurrences NUMERIC>>
LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanacJsonStr)
    if (Array.isArray(almanac) || typeof almanac != 'object' || almanac == null) return null;

    var nodes = almanac["link-nodes"]["nodes"]
    nodes = typeof nodes == 'string' ? JSON.parse(nodes) : nodes

    // gather aggregates with custom encoded key for easy lookup
    const res = {}
    for(let node of nodes) {
      key = `${node.rel || "UNK"}____${node.as || "UNK"}`
      if(key in res) {
        res[key] += 1
      } else {
        res[key] = 1
      }
    }

    // prepare result using the intermediate representation from above
    const finalRes = []
    for(let key in res) {
      const [linkRel, linkType] = key.split("____")
      finalRes.push({linkRel, linkType, numOccurrences: res[key]})
    }

    return finalRes;
}
catch {
    return null
}
''' ;
WITH ResourceHints AS (
  SELECT
    _TABLE_SUFFIX AS client,
    res.linkRel,
    res.linkType,
    res.numOccurrences,
    JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getResourceHints(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS res)

SELECT
  client,
  linkRel,
  linkType,
  COUNT(0) AS total,
  AVG(numOccurrences) AS avgUsagePerDomain,
  APPROX_QUANTILES(numOccurrences, 100)[
    OFFSET
    (10)] AS P10,
  APPROX_QUANTILES(numOccurrences, 100)[
    OFFSET
    (25)] AS P25,
  APPROX_QUANTILES(numOccurrences, 100)[
    OFFSET
    (50)] AS P50,
  APPROX_QUANTILES(numOccurrences, 100)[
    OFFSET
    (75)] AS P75,
  APPROX_QUANTILES(numOccurrences, 100)[
    OFFSET
    (90)] AS P90,
  APPROX_QUANTILES(numOccurrences, 100)[
    OFFSET
    (99)] AS P99
FROM
  ResourceHints
WHERE
  linkType <> 'UNK'
GROUP BY
  client,
  linkRel,
  linkType
