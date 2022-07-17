WITH web_components AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    CAST(JSON_VALUE(payload, '$._metadata.rank') AS INT64) AS rank,
    ARRAY_LENGTH(JSON_VALUE_ARRAY(JSON_VALUE(payload, '$._wpt_bodies'), '$.web_components.rendered.customElements.names')) AS num_web_components
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  url,
  num_web_components
FROM
  web_components
WHERE
  rank = 1000 AND
  num_web_components >= 2
ORDER BY
  num_web_components DESC
