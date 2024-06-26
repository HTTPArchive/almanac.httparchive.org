#standardSQL
# 11_06: beforeinstallprompt usage
SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client),
  UNNEST(REGEXP_EXTRACT_ALL(body, 'beforeinstallprompt'))
WHERE
  date = '2019-07-01' AND (
    firstHtml OR
    type = 'script'
  )
GROUP BY
  client,
  total
