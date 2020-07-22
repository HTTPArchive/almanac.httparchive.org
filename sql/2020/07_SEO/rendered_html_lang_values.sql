#standardSQL
# html lang values
# See related: sql/2019/10_SEO/10_02.sql

CREATE TEMPORARY FUNCTION getHtmlLang(payload STRING)
RETURNS STRING LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);

   return almanac['html-lang'].toLowerCase();  
  } catch (e) {
    return null;
  }
''';

SELECT
  client,
  COUNT(0) AS freq,
  html_lang,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total, # total for the relevant client
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_html_lang
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getHtmlLang(payload) AS html_lang # NULL if not present
  FROM
    `httparchive.almanac.pages_*`)
GROUP BY
  client,
  html_lang
ORDER BY
  freq / total DESC
LIMIT 100