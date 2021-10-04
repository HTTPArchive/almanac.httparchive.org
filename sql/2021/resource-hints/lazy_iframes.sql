#standardSQL
  # Count the number of lazily loaded iframes
CREATE TEMPORARY FUNCTION
countLazyIframes(almanac_string STRING)
RETURNS INT64
LANGUAGE js AS ''' 
try {
    var almanac = JSON.parse(almanac_string)
    if (Array.isArray(almanac) || typeof almanac != 'object') return null;
    
    var iframes = almanac["iframes"]["iframes"]["nodes"]
    return iframes.filter(i => (i.loading || "").toLowerCase() === "lazy").length
}
catch {
    return null
}
''' ;
WITH iframe_stats_tb AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload,
      '$._almanac') AS almanac,
    countLazyIframes(JSON_EXTRACT_SCALAR(payload,
        '$._almanac')) AS res
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  client,
  res AS numLazyIframes,
  COUNT(0) AS numPages
FROM
  iframe_stats_tb
WHERE
  res > 0
GROUP BY
  client,
  res
