#standardSQL
# Pages that provide `/.well-known/gpc.json` for Global Privacy Control

WITH pages_well_known AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._well-known") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  client,
  COUNT(0) AS number_of_websites -- crawled sites containing at leat one origin trial
FROM
  pages_well_known
WHERE
  JSON_VALUE(pages_well_known.metrics, '$."/.well-known/gpc.json".found') = "true"
GROUP BY
  client
ORDER BY
  client ASC
