CREATE TEMP FUNCTION detect(codepoints ARRAY<STRING>)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/text-utils.js"])
AS r"""
if (codepoints && codepoints.length) {
  return detectWritingScript(codepoints.map(c => parseInt(c, 10)), 0.25);
} else {
  return [];
}
""";

SELECT
  client,
  script,
  COUNT(DISTINCT page) AS pages_script,
  total_page,
  COUNT(DISTINCT page) / total_page AS pct_script
FROM (
  SELECT
    client,
    page,
    payload
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client),
  UNNEST(detect(JSON_EXTRACT_STRING_ARRAY(payload, '$._font_details.cmap.codepoints'))) AS script
GROUP BY
  client,
  total_page,
  script
ORDER BY
  pages_script DESC
