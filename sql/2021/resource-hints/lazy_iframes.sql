#standardSQL
# Count the number of lazily loaded iframes

CREATE TEMPORARY FUNCTION countLazyIframes(almanac_string STRING)
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
''';
WITH iframe_stats_tb AS (
  SELECT
    _TABLE_SUFFIX AS client,
    countLazyIframes(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS num_lazy_iframes
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  client,
  num_lazy_iframes,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  iframe_stats_tb
GROUP BY
  client,
  num_lazy_iframes
ORDER BY
  client,
  num_lazy_iframes
