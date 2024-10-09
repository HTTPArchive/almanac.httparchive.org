SELECT
  client,
  custom_elements,
  shadow_roots,
  templates,
  total,
  custom_elements / total AS pct_custom_elements,
  shadow_roots / total AS pct_shadow_roots,
  templates / total AS pct_templates
FROM (
  SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(ARRAY_LENGTH(JSON_EXTRACT_ARRAY(js, '$.web_component_specs.custom_elements')) > 0) AS custom_elements,
    COUNTIF(ARRAY_LENGTH(JSON_EXTRACT_ARRAY(js, '$.web_component_specs.shadow_roots')) > 0) AS shadow_roots,
    COUNTIF(ARRAY_LENGTH(JSON_EXTRACT_ARRAY(js, '$.web_component_specs.template')) > 0) AS templates
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT_SCALAR(payload, '$._javascript') AS js
    FROM
      `httparchive.pages.2021_09_01_*`
  )
  GROUP BY
    client
)
