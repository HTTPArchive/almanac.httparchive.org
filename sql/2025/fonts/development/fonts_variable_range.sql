-- Section: Development
-- Question: What are the distributions of axes?
-- Normalization: Fonts (variable only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

CREATE TEMPORARY FUNCTION AXES(fvar JSON)
RETURNS ARRAY<STRUCT<name STRING, minimum FLOAT64, medium FLOAT64, maximum FLOAT64>>
LANGUAGE js
AS '''
try {
  return Object.keys(fvar).map((name) => {
    return {
      name: name,
      minimum: fvar[name].min,
      medium: fvar[name].default,
      maximum: fvar[name].max
    };
  });
} catch (e) {
  return [];
}
''';

WITH
fonts AS (
  SELECT
    client,
    url,
    axis.name,
    ANY_VALUE(axis.minimum) AS minimum,
    ANY_VALUE(axis.medium) AS medium,
    ANY_VALUE(axis.maximum) AS maximum
  FROM
    `httparchive.crawl.requests`,
    UNNEST(AXES(payload._font_details.fvar)) AS axis
  WHERE
    date = @date AND
    type = 'font' AND
    is_root_page AND
    IS_VARIABLE(payload)
  GROUP BY
    client,
    url,
    name
)

SELECT
  client,
  name,
  percentile,
  COUNT(0) AS count,
  ROUND(APPROX_QUANTILES(minimum, 1000)[OFFSET(percentile * 10)], @precision) AS minimum,
  ROUND(APPROX_QUANTILES(medium, 1000)[OFFSET(percentile * 10)], @precision) AS medium,
  ROUND(APPROX_QUANTILES(maximum, 1000)[OFFSET(percentile * 10)], @precision) AS maximum
FROM
  fonts,
  UNNEST([10, 25, 50, 75, 90, 99]) AS percentile
GROUP BY
  client,
  name,
  percentile
ORDER BY
  client,
  name,
  percentile
