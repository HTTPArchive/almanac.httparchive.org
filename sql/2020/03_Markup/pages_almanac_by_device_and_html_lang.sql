#standardSQL
# page markup metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_html_lang(almanac_string STRING)
RETURNS STRING LANGUAGE js AS '''
try {
    // var almanac = JSON.parse(almanac_string); // LIVE

    // TEST
    var almanac = {    
      "html_node": {
          "tagName": "html",
          "xmlns": "http://www.w3.org/1999/xhtml",
          "xml:lang": "en-US",
          "prefix": "og: https://ogp.me/ns#"
      } 
    };
    if (Math.floor(Math.random() * 3) == 0) {
      almanac.html_node.lang = "en-AU";
    } else if (Math.floor(Math.random() * 2) == 0) {
      almanac.html_node.lang = "es-mx";
    } else if (Math.floor(Math.random() * 2) == 0) {
      almanac.html_node.lang = "EN-US";
    }

    if (Array.isArray(almanac) || typeof almanac != 'object') return '';

    if (almanac.html_node && almanac.html_node.lang) {
      return almanac.html_node.lang.trim().toLowerCase();
    }

} catch (e) {}
return '';
''';

SELECT
  client,
  COUNT(0) AS total,
  almanac_html_lang as html_lang,

  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct_m405

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_almanac_html_lang('') AS almanac_html_lang  # TEST
        #get_almanac_html_lang(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_html_lang # LIVE
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client,
  html_lang