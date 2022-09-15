CREATE TEMP FUNCTION getInputsPerForm(markup STRING) RETURNS ARRAY<INT64> LANGUAGE js AS r'''
try {
  markup = JSON.parse(markup);
  return markup.form.elements.map(i => i.total);
} catch {
  return [];
}
''';

WITH inputs AS (
  SELECT
    _TABLE_SUFFIX AS client,
    inputs_per_form
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST(getInputsPerForm(JSON_VALUE(payload, '$._markup'))) AS inputs_per_form
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(inputs_per_form, 1000)[OFFSET(percentile * 10)] AS inputs_per_form
FROM
  inputs,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
