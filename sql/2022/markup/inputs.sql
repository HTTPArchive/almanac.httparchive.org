CREATE TEMPORARY FUNCTION get_markup_inputs_info(markup_string STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
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

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  markup_input_info.name AS input_type,
  COUNTIF(markup_input_info.freq > 0) AS freq_page_with_input,
  COUNTIF(markup_input_info.freq > 0) / ANY_VALUE(total) AS pct_page_with_input,
  SUM(markup_input_info.freq) AS freq_input,
  SUM(markup_input_info.freq) / SUM(SUM(markup_input_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_input
FROM
  `httparchive.pages.2022_06_01_*`
JOIN
  totals
USING (_TABLE_SUFFIX),
  UNNEST(get_markup_inputs_info(JSON_EXTRACT_SCALAR(payload, '$._markup'))) AS markup_input_info
GROUP BY
  client,
  input_type
ORDER BY
  freq_page_with_input DESC
LIMIT
  1000
