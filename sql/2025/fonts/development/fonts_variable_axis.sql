-- Section: Development
-- Question: Which axes are used in variable fonts?
-- Normalization: Fonts (variable only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

CREATE TEMPORARY FUNCTION AXES(fvar JSON)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
try {
  return Object.keys(fvar);
} catch (e) {
  return [];
}
''';

WITH
fonts AS (
  SELECT
    client,
    url,
    AXES(ANY_VALUE(payload)._font_details.fvar) AS axes,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
    type = 'font' AND
    is_root_page AND
    IS_VARIABLE(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  axis,
  COUNT(0) AS count,
  total,
  ROUND(COUNT(0) / total, @precision) AS proportion
FROM
  fonts,
  UNNEST(axes) AS axis
GROUP BY
  client,
  axis,
  total
ORDER BY
  client,
  count DESC
