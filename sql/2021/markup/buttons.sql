#standardSQL
# pages markup metrics grouped by device and button type

# returns button struct
CREATE TEMPORARY FUNCTION get_markup_buttons_info(markup_string STRING)
RETURNS ARRAY<STRUCT<
  name STRING,
  freq INT64
  >> LANGUAGE js AS '''
var result = [];
try {
    var markup = JSON.parse(markup_string);

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.buttons && markup.buttons.types) {
      var total = markup.buttons.total;
      var withType = 0;
      result = Object.entries(markup.buttons.types).map(([name, freq]) => { withType+=freq; return  {name: name.toLowerCase().trim(), freq};});

      result.push({name:"NO_TYPE", freq: total - withType})

      return result;
    }

} catch (e) {}
return result;
''';

SELECT
  _TABLE_SUFFIX AS client,
  button_type_info.name AS button_type,
  COUNTIF(button_type_info.freq > 0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(button_type_info.freq > 0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_page_with_button_type
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(get_markup_buttons_info(JSON_EXTRACT_SCALAR(payload, '$._markup'))) AS button_type_info
GROUP BY
  client,
  button_type
ORDER BY
  client,
  freq_page_with_button DESC
LIMIT 1000
