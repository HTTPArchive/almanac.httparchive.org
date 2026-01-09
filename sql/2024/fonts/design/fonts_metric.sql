-- Section: Performance
-- Question: What is the distribution of metrics?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    SAFE_CAST(
      JSON_EXTRACT_SCALAR(
        ANY_VALUE(payload),
        '$._font_details.head.unitsPerEm'
      ) AS INTEGER
    ) AS granularity,
    [
      STRUCT(
        'granularity' AS name,
        SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.head.unitsPerEm'
          ) AS INTEGER
        ) AS value
      ),
      STRUCT(
        'clipping_ascender' AS name,
        SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.OS2.usWinAscent'
          ) AS INTEGER
        ) AS value
      ),
      STRUCT(
        'ascender' AS name,
        SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.OS2.sTypoAscender'
          ) AS INTEGER
        ) AS value
      ),
      STRUCT(
        'cap_height' AS name,
        SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.OS2.sCapHeight'
          ) AS INTEGER
        ) AS value
      ),
      STRUCT(
        'x_height' AS name,
        SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.OS2.sxHeight'
          ) AS INTEGER
        ) AS value
      ),
      STRUCT(
        'descender' AS name,
        SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.OS2.sTypoDescender'
          ) AS INTEGER
        ) AS value
      ),
      STRUCT(
        'clipping_descender' AS name,
        -SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.OS2.usWinDescent'
          ) AS INTEGER
        ) AS value
      ),
      STRUCT(
        'line_gap' AS name,
        SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.OS2.sTypoLineGap'
          ) AS INTEGER
        ) AS value
      ),
      STRUCT(
        'use_typographic_metrics' AS name,
        SAFE_CAST(
          JSON_EXTRACT_SCALAR(
            ANY_VALUE(payload),
            '$._font_details.OS2.fsSelection'
          ) AS INTEGER
        ) & 128 AS value
      )
    ] AS metrics
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  name AS metric,
  percentile,
  COUNT(0) AS count,
  APPROX_QUANTILES(
    IF(name = 'granularity', value, SAFE_DIVIDE(value, granularity)),
    1000
  )[OFFSET(percentile * 10)] AS value
FROM
  fonts,
  UNNEST(metrics) AS metric,
  UNNEST([10, 25, 50, 75, 90, 99]) AS percentile
GROUP BY
  client,
  name,
  percentile
ORDER BY
  client,
  name,
  percentile
