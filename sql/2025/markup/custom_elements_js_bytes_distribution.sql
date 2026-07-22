WITH js_bytes AS (
  SELECT
    client,
    page,
    INT64(summary.bytesJS) / 1024 AS kbytes_js
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
),

custom_elements AS (
  SELECT
    client,
    page,
    COALESCE(ARRAY_LENGTH(JSON_VALUE_ARRAY(custom_metrics.wpt_bodies.web_components.rendered.customElements.names)) > 0, FALSE) AS has_custom_elements
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  percentile,
  client,
  has_custom_elements,
  APPROX_QUANTILES(kbytes_js, 1000)[OFFSET(percentile * 10)] AS kbytes_js,
  COUNT(DISTINCT page) AS pages
FROM
  custom_elements
JOIN
  js_bytes
USING (client, page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  has_custom_elements
ORDER BY
  percentile,
  client,
  has_custom_elements
