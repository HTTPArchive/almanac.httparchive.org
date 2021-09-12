SELECT
  client,
  percentile,
  APPROX_QUANTILES(custom_elements, 1000)[
OFFSET
  (percentile * 10)] AS custom_elements,
    APPROX_QUANTILES(shadow_roots, 1000)[
OFFSET
  (percentile * 10)] AS shadow_roots,
    APPROX_QUANTILES(template, 1000)[
OFFSET
  (percentile * 10)] AS template
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload,
          '$._javascript'),
        '$.web_component_specs.custom_elements') AS INT64) AS custom_elements,
        CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload,
          '$._javascript'),
        '$.web_component_specs.shadow_roots') AS INT64) AS shadow_roots,
        CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload,
          '$._javascript'),
        '$.web_component_specs.template') AS INT64) AS template
  FROM
    `httparchive.sample_data.pages_*` ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client