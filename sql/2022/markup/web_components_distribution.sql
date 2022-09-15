WITH web_components AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    ARRAY_LENGTH(JSON_VALUE_ARRAY(JSON_VALUE(payload, '$._wpt_bodies'), '$.web_components.rendered.customElements.names')) AS num_web_components
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  num_web_components,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  web_components
WHERE
  num_web_components > 0
GROUP BY
  client,
  num_web_components
ORDER BY
  num_web_components
