#standardSQL
# Pages that provide `/.well-known/gpc.json` for Global Privacy Control

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_websites
  FROM
    `httparchive.technologies.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  total_websites AS total_websites,
  COUNT(0) AS number_of_websites, -- crawled sites containing at least one origin trial
  COUNT(0) / total_websites AS percent_of_websites
FROM
  `httparchive.pages.2021_07_01_*`
JOIN totals USING (_TABLE_SUFFIX)
WHERE
  JSON_VALUE(payload, '$._well-known."/.well-known/gpc.json".found') = "true"
GROUP BY
  client,
  total_websites
ORDER BY
  client
