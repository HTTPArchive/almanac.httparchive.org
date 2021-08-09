#standardSQL
# pages markup metrics grouped by device and button type

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
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
  COUNTIF(button_type_info.freq > 0) AS freq_page_with_button,
  AS_PERCENT(COUNTIF(button_type_info.freq > 0), total) AS pct_page_with_button,
  SUM(button_type_info.freq) AS freq_button,
  AS_PERCENT(SUM(button_type_info.freq), SUM(SUM(button_type_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_button
FROM
    `httparchive.pages.2020_08_01_*`
    JOIN
      (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM
      `httparchive.pages.2020_08_01_*`
      GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
    USING (_TABLE_SUFFIX),
    UNNEST(get_markup_buttons_info(JSON_EXTRACT_SCALAR(payload, '$._markup'))) AS button_type_info
GROUP BY
  client,
  button_type,
  total
ORDER BY
  freq_page_with_button DESC
LIMIT 1000
