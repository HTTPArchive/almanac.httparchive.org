#standardSQL
# pages markup metrics grouped by device and input type

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_inputs_info(markup_string STRING)
RETURNS ARRAY<STRUCT<
  name STRING,
  freq INT64
  >> LANGUAGE js AS '''
var result = [];
try {
    var markup = JSON.parse(markup_string);

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.inputs && markup.inputs.types) {
      var total = markup.inputs.total;
      var withType = 0;
      result = Object.entries(markup.inputs.types).map(([name, freq]) => { withType+=freq; return  {name: name.toLowerCase().trim(), freq};});

      result.push({name:"NO_TYPE", freq: total - withType})

      return result;
    }

} catch (e) {}
return result;
''';

SELECT
  _TABLE_SUFFIX AS client,
  markup_input_info.name AS input_type,
  COUNTIF(markup_input_info.freq > 0) AS freq_page_with_input,
  AS_PERCENT(COUNTIF(markup_input_info.freq > 0), total) AS pct_page_with_input,
  SUM(markup_input_info.freq) AS freq_input,
  AS_PERCENT(SUM(markup_input_info.freq), SUM(SUM(markup_input_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_input
FROM
  `httparchive.pages.2020_08_01_*`
JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM
      `httparchive.pages.2020_08_01_*`
    GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
USING (_TABLE_SUFFIX),
  UNNEST(get_markup_inputs_info(JSON_EXTRACT_SCALAR(payload, '$._markup'))) AS markup_input_info
GROUP BY
  client,
  input_type,
  total
ORDER BY
  freq_page_with_input DESC
LIMIT 1000
