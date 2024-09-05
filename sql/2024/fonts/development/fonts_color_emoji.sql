-- Section: Development
-- Question: Are color fonts used for the sake of emojis?
-- Normalization: Fonts

-- INCLUDE ../common.sql

CREATE TEMPORARY FUNCTION HAS_EMOJI(codepoints ARRAY<STRING>)
RETURNS BOOL
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/text-utils.js"])
AS r"""
if (codepoints && codepoints.length) {
  const detected = detectWritingScript(codepoints.map((character) => parseInt(character, 10)), 0.1);
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
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  is_root_page AND
  type = 'font' AND
  IS_COLOR(payload)
GROUP BY
  client,
  emoji
ORDER BY
  client,
  emoji
