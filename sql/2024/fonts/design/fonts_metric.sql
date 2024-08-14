-- Section: Performance
-- Question: What is the distribution of metrics?

WITH
fonts AS (
  SELECT
    client,
    url,
    ANY_VALUE(payload) AS payload
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url
),
metrics AS (
  SELECT
    client,
    metric.name,
    metric.value
  FROM
    fonts,
    UNNEST([
      STRUCT('granularity' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.head.unitsPerEm') AS INTEGER) AS value),
      STRUCT('clipping_ascender' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.usWinAscent') AS INTEGER) AS value),
      STRUCT('ascender' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.sTypoAscender') AS INTEGER) AS value),
      STRUCT('cap_height' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.sCapHeight') AS INTEGER) AS value),
      STRUCT('x_height' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.sxHeight') AS INTEGER) AS value),
      STRUCT('baseline_at_zero' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.flags') AS INTEGER) & 1 AS value),
      STRUCT('descender' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.sTypoDescender') AS INTEGER) AS value),
      STRUCT('clipping_descender' AS name, -SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.usWinDescent') AS INTEGER) AS value),
      STRUCT('line_gap' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.sTypoLineGap') AS INTEGER) AS value),
      STRUCT('use_typographic_metrics' AS name, SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.fsSelection') AS INTEGER) & 128 AS value)
    ]) AS metric
)

SELECT
  client,
  name,
  percentile,
  COUNT(0) AS count,
  APPROX_QUANTILES(value, 1000)[OFFSET(percentile * 10)] AS value
FROM
  metrics,
  UNNEST([10, 25, 50, 75, 90, 99]) AS percentile
GROUP BY
  client,
  name,
  percentile
ORDER BY
  client,
  name,
  percentile
