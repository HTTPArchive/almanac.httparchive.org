#standardSQL
# CSS in JS. Show number of sites that using each framework or not using any.
CREATE TEMPORARY FUNCTION getCssInJS(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var css = JSON.parse($._css);

    if (!Array.isArray(css.css_in_js)) {
      return [];
    }

    // Use a safe-list to avoid parse error garbage.
    var frameworks = new Set([
      "Styled Components",
      "Radium",
      "React JSS",
      "Emotion",
      "Goober",
      "Merge Styles",
      "Styled Jsx",
      "Aphrodite",
      "Fela",
      "Styletron",
      "React Native for Web",
      "Glamor"
    ]);

    return css.css_in_js.filter(i => frameworks.has(i));
  } catch (e) {
    return [];
  }
''';

SELECT
  client,
  cssInJs,
  COUNT(DISTINCT url) AS pages,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    cssInJs
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getCssInJS(payload)) AS cssInJs)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client)
USING (client)
GROUP BY
  client,
  cssInJs,
  total
ORDER BY
  pct DESC
