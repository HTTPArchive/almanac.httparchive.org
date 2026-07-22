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
  element IN ('applet', 'acronym', 'basefont', 'bgsound', 'big', 'blink', 'center', 'dir', 'font', 'frame', 'frameset', 'isindex', 'keygen', 'listing', 'marquee', 'menuitem', 'multicol', 'nextid', 'nobr', 'noembed', 'noframes', 'param', 'plaintext', 'rb', 'rtc', 'spacer', 'strike', 'tt', 'xmp')
);

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY client
)

SELECT
  client,
  element_type AS obsolete_element_type,
  COUNT(DISTINCT page) AS pages,
  total AS total_pages,
  COUNT(DISTINCT page) / total AS pct_pages_with_obsolete_elements
FROM
  `httparchive.all.pages`
JOIN
  totals
USING (client),
  UNNEST(get_element_types(JSON_EXTRACT(custom_metrics, '$.element_count'))) AS element_type
WHERE
  date = '2024-06-01' AND
  is_obsolete(element_type)
GROUP BY
  client,
  total,
  obsolete_element_type
ORDER BY
  pct_pages_with_obsolete_elements DESC
