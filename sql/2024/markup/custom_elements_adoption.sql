WITH custom_elements AS (
  SELECT
    client,
    page,
    COALESCE(ARRAY_LENGTH(JSON_VALUE_ARRAY(JSON_EXTRACT(custom_metrics, '$.wpt_bodies'), '$.web_components.rendered.customElements.names')) > 0, FALSE) AS has_custom_elements
  FROM
    `httparchive.all.pages`
  WHERE
    date IN ('2022-06-01', '2023-06-01', '2024-06-01')
)

SELECT
  date,
  client,
  COUNT(0) AS total,
  COUNTIF(has_custom_elements) AS freq,
  COUNTIF(has_custom_elements) / COUNT(0) AS pct_custom_elements
FROM
  custom_elements
GROUP BY
  date, client
ORDER BY
  date ASC
