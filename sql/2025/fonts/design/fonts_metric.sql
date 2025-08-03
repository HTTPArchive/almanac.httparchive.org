-- Section: Performance
-- Question: What is the distribution of metrics?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    INT64(ANY_VALUE(payload)._font_details.head.unitsPerEm) AS granularity,
    [
      STRUCT(
        'granularity' AS name,
        INT64(ANY_VALUE(payload)._font_details.head.unitsPerEm) AS value
      ),
      STRUCT(
        'clipping_ascender' AS name,
        INT64(ANY_VALUE(payload)._font_details.OS2.usWinAscent) AS value
      ),
      STRUCT(
        'ascender' AS name,
        INT64(ANY_VALUE(payload)._font_details.OS2.sTypoAscender) AS value
      ),
      STRUCT(
        'cap_height' AS name,
        INT64(ANY_VALUE(payload)._font_details.OS2.sCapHeight) AS value
      ),
      STRUCT(
        'x_height' AS name,
        INT64(ANY_VALUE(payload)._font_details.OS2.sxHeight) AS value
      ),
      STRUCT(
        'descender' AS name,
        INT64(ANY_VALUE(payload)._font_details.OS2.sTypoDescender) AS value
      ),
      STRUCT(
        'clipping_descender' AS name,
        -INT64(ANY_VALUE(payload)._font_details.OS2.usWinDescent) AS value
      ),
      STRUCT(
        'line_gap' AS name,
        INT64(ANY_VALUE(payload)._font_details.OS2.sTypoLineGap) AS value
      ),
      STRUCT(
        'use_typographic_metrics' AS name,
        INT64(ANY_VALUE(payload)._font_details.OS2.fsSelection) & 128 AS value
      )
    ] AS metrics
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
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
