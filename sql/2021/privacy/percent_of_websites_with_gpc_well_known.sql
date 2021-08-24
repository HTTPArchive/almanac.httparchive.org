#standardSQL
# Pages that provide `/.well-known/gpc.json` for Global Privacy Control

WITH pages_well_known AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._well-known") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)

SELECT
  client,
  COUNT(0) AS nb_websites -- crawled sites containing at leat one origin trial
FROM
  pages_well_known
WHERE
  JSON_VALUE(pages_well_known.metrics, '$."/.well-known/gpc.json".found') = "true"
GROUP BY
  1
