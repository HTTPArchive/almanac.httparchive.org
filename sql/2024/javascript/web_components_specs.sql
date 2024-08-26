#web_components_specs.sql
SELECT
  client,
  percentile,
  APPROX_QUANTILES(custom_elements, 1000)[OFFSET(percentile * 10)] AS custom_elements,
  APPROX_QUANTILES(shadow_roots, 1000)[OFFSET(percentile * 10)] AS shadow_roots,
  APPROX_QUANTILES(template, 1000)[OFFSET(percentile * 10)] AS template
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    ARRAY_LENGTH(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.web_component_specs.custom_elements')) AS custom_elements,
    ARRAY_LENGTH(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.web_component_specs.shadow_roots')) AS shadow_roots,
    ARRAY_LENGTH(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._javascript'), '$.web_component_specs.template')) AS template
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
