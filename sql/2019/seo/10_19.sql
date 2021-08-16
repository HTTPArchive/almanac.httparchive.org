#standardSQL
# 10_19: Zero count of type of link
SELECT
  client,
  ROUND(COUNTIF(internal = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS internal_link_zero,
  ROUND(COUNTIF(external = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS external_link_zero,
  ROUND(COUNTIF(_hash = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS _hash_link_zero
FROM (
  SELECT
    client,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].internal") AS INT64) AS internal,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].external") AS INT64) AS external,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].hash") AS INT64) AS _hash
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
    FROM
      `httparchive.pages.2019_07_01_*`)
)
GROUP BY
  client
ORDER BY
  client
