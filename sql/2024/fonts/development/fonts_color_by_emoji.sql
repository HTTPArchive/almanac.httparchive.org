-- Section: Development
-- Question: Are color fonts used for the sake of emojis?

CREATE TEMPORARY FUNCTION COLOR_FORMATS(json STRING) AS (
  REGEXP_EXTRACT_ALL(
    JSON_EXTRACT(json, '$._font_details.color.formats'),
    '(?i)(sbix|CBDT|COLRv0|COLRv1|SVG)'
  )
);

CREATE TEMPORARY FUNCTION HAS_EMOJI(codepoints ARRAY<STRING>)
RETURNS BOOL
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/text-utils.js"])
AS r"""
if (codepoints && codepoints.length) {
  const detected = detectWritingScript(codepoints.map(c => parseInt(c, 10)), 0.1);
  const scripts = [
    'Emoji',
    'Emoji_Component',
    'Emoji_Modifier',
    'Emoji_Modifier_Base',
    'Emoji_Presentation'
  ];
  for (script of scripts) {
    if (detected.includes(script)) {
      return true;
    }
  }
  return false;
} else {
  return false;
}
""";

SELECT
  client,
  HAS_EMOJI(JSON_EXTRACT_STRING_ARRAY(payload, '$._font_details.cmap.codepoints')) AS emoji,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-06-01' AND
  type = 'font' AND
  ARRAY_LENGTH(COLOR_FORMATS(payload)) > 0
GROUP BY
  client,
  emoji
ORDER BY
  client,
  emoji
