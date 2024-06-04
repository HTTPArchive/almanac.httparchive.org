#standardSQL
# 02_11: Top reset utils
SELECT
  client,
  CASE LOWER(util)
    WHEN 'normalize.css' THEN 'Normalize.css'
    WHEN 'pure-css' THEN 'Pure CSS'
    WHEN 'http://meyerweb.com/eric/tools/css/reset/' THEN 'Reset CSS'
    ELSE util
  END AS util,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM (SELECT client, page, body FROM `httparchive.almanac.summary_response_bodies` WHERE date = '2019-07-01' AND type = 'css')
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING (client),
  # Search for reset util fingerprints in stylesheet comments.
  UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)(normalize\\.css|pure\\-css|http://meyerweb\\.com/eric/tools/css/reset/)')) AS util
GROUP BY
  client,
  total,
  util
ORDER BY
  freq / total DESC
