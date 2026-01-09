-- Section: Development
-- Question: Are color fonts used for the sake of emojis?
-- Normalization: Requests (color only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

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

WITH
requests AS (
  SELECT
    date,
    client,
    HAS_EMOJI(JSON_EXTRACT_STRING_ARRAY(payload, '$._font_details.cmap.codepoints')) AS emoji,
    COUNT(0) OVER (PARTITION BY date, client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_COLOR(payload)
)

SELECT
  date,
  client,
  emoji,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion
FROM
  requests
GROUP BY
  date,
  client,
  emoji,
  total
ORDER BY
  date,
  client,
  emoji
