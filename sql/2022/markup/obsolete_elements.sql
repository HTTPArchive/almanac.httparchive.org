CREATE TEMPORARY FUNCTION get_element_types(element_count_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    if (!element_count_string) return []; // 2019 had a few cases

    var element_count = JSON.parse(element_count_string); // should be an object with element type properties with values of how often they are present

    if (Array.isArray(element_count)) return [];
    if (typeof element_count != 'object') return [];

    return Object.keys(element_count);
} catch (e) {
    return [];
}
''';

CREATE TEMPORARY FUNCTION is_obsolete(element STRING) AS (
  element IN ('applet', 'acronym', 'bgsound', 'dir', 'frame', 'frameset', 'noframes', 'isindex', 'keygen', 'listing', 'menuitem', 'nextid', 'noembed', 'plaintext', 'rb', 'rtc', 'strike', 'xmp', 'basefont', 'big', 'blink', 'center', 'font', 'marquee', 'multicol', 'nobr', 'spacer', 'tt')
);

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  element_type AS obsolete_element_type,
  COUNT(DISTINCT url) AS pages,
  total AS total_pages,
  COUNT(DISTINCT url) / total AS pct_pages_with_obsolete_elements
FROM
  `httparchive.pages.2022_06_01_*`
JOIN
  totals
USING (_TABLE_SUFFIX),
  UNNEST(get_element_types(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type
WHERE
  is_obsolete(element_type)
GROUP BY
  client,
  total,
  obsolete_element_type
ORDER BY
  pct_pages_with_obsolete_elements DESC
