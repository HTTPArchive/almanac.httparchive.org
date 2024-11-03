#standardSQL
# beforeinstallprompt usage - based on 2019/14_06.sql
SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2020_08_01_*` GROUP BY _TABLE_SUFFIX)
USING (client),
  UNNEST(REGEXP_EXTRACT_ALL(body, 'beforeinstallprompt'))
WHERE
  date = '2020-08-01' AND (firstHtml OR type = 'script')
GROUP BY
  client,
  total
