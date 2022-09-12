CREATE TEMP FUNCTION detect(codepoints ARRAY<STRING>)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/text-utils.js"])
AS r"""
if (codepoints && codepoints.length) {
  return detectWritingScript(codepoints.map(c => parseInt(c, 10)), 0.05);
} else {
  return [];
}
""";

WITH
fonts AS (
  SELECT
    url,
    payload
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    url,
    payload
)

SELECT
  writing_system,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct_freq
FROM
  fonts,
  UNNEST(detect(JSON_EXTRACT_STRING_ARRAY(payload, '$._font_details.cmap.codepoints'))) AS writing_system
GROUP BY
  writing_system
ORDER BY
  pct_freq DESC
