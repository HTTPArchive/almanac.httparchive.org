#standardSQL
# page almanac metrics grouped by device and html lang


# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_html_lang(almanac_string STRING)
RETURNS STRING LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string); 

    if (Array.isArray(almanac) || typeof almanac != 'object') return '';

    if (almanac.html_node && almanac.html_node.lang) {
      return almanac.html_node.lang.trim().toLowerCase();
    }

} catch (e) {}
return '';
''';

SELECT
  client,
  COUNT(0) AS freq,
  almanac_html_lang AS html_lang,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  (
    SELECT
      _TABLE_SUFFIX AS client,
      get_almanac_html_lang(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_html_lang
    FROM
      `httparchive.pages.2021_07_01_*`
  )
GROUP BY
  client,
  html_lang
ORDER BY
  client,
  freq DESC
