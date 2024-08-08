#standardSQL
# 14_02: AMP plugin mode
SELECT
  client,
  amp_plugin_mode,
  COUNT(DISTINCT url) AS freq,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(DISTINCT url) * 100 / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client), 2) AS pct
FROM (
  SELECT
    client,
    page AS url,
    SPLIT(REGEXP_EXTRACT(body, '(?i)<meta[^>]+name=[\'"]?generator[^>]+content=[\'"]?AMP Plugin v(\\d+\\.\\d+[^\'">]*)'), ';')[SAFE_OFFSET(1)] AS amp_plugin_mode
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
INNER JOIN (SELECT _TABLE_SUFFIX AS client, url FROM `httparchive.technologies.2019_07_01_*` WHERE app = 'WordPress')
USING (client, url)
GROUP BY
  client,
  amp_plugin_mode
ORDER BY
  freq / total DESC
