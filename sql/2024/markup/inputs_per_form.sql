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
    client,
    inputs_per_form
  FROM
    `httparchive.all.pages`,
    UNNEST(getInputsPerForm(JSON_EXTRACT(custom_metrics, '$.markup'))) AS inputs_per_form
  WHERE
    date = '2024-06-01'
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
