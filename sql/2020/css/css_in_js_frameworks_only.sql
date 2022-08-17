#standardSQL
# CSS in JS. Show number of sites that using each framework or not using any.
CREATE TEMPORARY FUNCTION getCssInJS(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var css = JSON.parse($._css);

    return css && Array.isArray(css.css_in_js) && css.css_in_js.length > 0 ? css.css_in_js : ['NONE'];
  } catch (e) {
    return ['Error:' + e.message];
  }
''';

SELECT
  client,
  cssInJs,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    cssInJs
  FROM
    `httparchive.pages.2020_08_01_*`
  CROSS JOIN
    UNNEST(getCssInJS(payload)) AS cssInJs
)
WHERE
  cssInJs != 'NONE'
GROUP BY
  client,
  cssInJs
ORDER BY
  freq
