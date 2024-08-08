#standardSQL
# 14_02: AMP plugin version
SELECT
  client,
  amp_plugin_version,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    url,
    REGEXP_EXTRACT(body, '(?i)<meta[^>]+name=[\'"]?generator[^>]+content=[\'"]?AMP Plugin v(\\d+\\.\\d+[^\'">]*)') AS amp_plugin_version
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
JOIN (SELECT _TABLE_SUFFIX AS client, url FROM `httparchive.technologies.2019_07_01_*` WHERE app = 'WordPress')
USING (client, url)
GROUP BY
  client,
  amp_plugin_version
