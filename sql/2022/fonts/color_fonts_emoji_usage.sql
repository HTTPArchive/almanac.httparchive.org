CREATE TEMP FUNCTION
hasEmoji(codepoints ARRAY<STRING>)
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
  hasEmoji(JSON_EXTRACT_STRING_ARRAY(
    payload,
    '$._font_details.cmap.codepoints'
  )) AS emoji,
  COUNT(0) AS total,
  COUNT(0) * 1.0 / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  type = 'font' AND
  REGEXP_CONTAINS(JSON_EXTRACT(
    payload,
    '$._font_details.color.formats'
  ), '(?i)(sbix|CBDT|SVG|COLRv0|COLRv1)')
GROUP BY
  client,
  emoji
