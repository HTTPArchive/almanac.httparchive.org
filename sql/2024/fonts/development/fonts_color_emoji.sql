-- Section: Development
-- Question: Are color fonts used for the sake of emojis?
-- Normalization: Fonts on sites

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
  date,
  client,
  HAS_EMOJI(JSON_EXTRACT_STRING_ARRAY(payload, '$._font_details.cmap.codepoints')) AS emoji,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
  is_root_page AND
  type = 'font' AND
  IS_COLOR(payload)
GROUP BY
  date,
  client,
  emoji
ORDER BY
  date,
  client,
  emoji
