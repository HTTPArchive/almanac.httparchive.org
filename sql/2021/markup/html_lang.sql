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
  IF(IFNULL(TRIM(almanac_html_lang), '') = '', '(not set)', almanac_html_lang) AS html_lang_country,
  IF(
    IFNULL(TRIM(SUBSTR(almanac_html_lang, 0, LENGTH(almanac_html_lang) - STRPOS(almanac_html_lang, '-'))), '') = '',
    '(not set)',
    SUBSTR(almanac_html_lang, 0, LENGTH(almanac_html_lang) - STRPOS(almanac_html_lang, '-'))
  ) AS html_lang,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
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
  almanac_html_lang
ORDER BY
  pct DESC,
  client,
  freq DESC
