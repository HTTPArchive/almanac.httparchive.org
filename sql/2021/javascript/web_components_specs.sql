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
    # Note: We're intentionally querying the September dataset here because of a bug in the custom metric.
    # See https://github.com/HTTPArchive/legacy.httparchive.org/pull/231.
    `httparchive.pages.2021_09_01_*`),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
