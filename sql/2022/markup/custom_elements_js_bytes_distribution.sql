WITH js_bytes AS (
  SELECT
    _TABLE_SUFFIX,
    url,
    bytesJs / 1024 AS kbytes_js
  FROM
    `httparchive.summary_pages.2022_06_01_*`
),

custom_elements AS (
  SELECT
    _TABLE_SUFFIX,
    url,
    COALESCE(ARRAY_LENGTH(JSON_VALUE_ARRAY(JSON_VALUE(payload, '$._wpt_bodies'), '$.web_components.rendered.customElements.names')) > 0, FALSE) AS has_custom_elements
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  has_custom_elements,
  APPROX_QUANTILES(kbytes_js, 1000)[OFFSET(percentile * 10)] AS kbytes_js,
  COUNT(DISTINCT url) AS pages
FROM
  custom_elements
JOIN
  js_bytes
USING (_TABLE_SUFFIX, url),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  has_custom_elements
ORDER BY
  percentile,
  client,
  has_custom_elements
