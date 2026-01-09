-- Section: Development
-- Question: What are the distributions of axes?
-- Normalization: Fonts (variable only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

CREATE TEMPORARY FUNCTION AXES(json STRING)
RETURNS ARRAY<STRUCT<name STRING, minimum FLOAT64, medium FLOAT64, maximum FLOAT64>>
LANGUAGE js
AS '''
try {
  const axes = JSON.parse(json);
  return Object.keys(axes).map((name) => {
    return {
      name: name,
      minimum: axes[name].min,
      medium: axes[name].default,
      maximum: axes[name].max
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
    `httparchive.all.requests`,
    UNNEST(AXES(JSON_EXTRACT(payload, '$._font_details.fvar'))) AS axis
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
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
  APPROX_QUANTILES(minimum, 1000)[OFFSET(percentile * 10)] AS minimum,
  APPROX_QUANTILES(medium, 1000)[OFFSET(percentile * 10)] AS medium,
  APPROX_QUANTILES(maximum, 1000)[OFFSET(percentile * 10)] AS maximum
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
