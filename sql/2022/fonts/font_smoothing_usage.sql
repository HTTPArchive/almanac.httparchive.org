CREATE TEMPORARY FUNCTION getFontSmoothing(data STRING)
RETURNS ARRAY < STRING > LANGUAGE js AS '''

function parseCss(rule, acc) {
  if (rule.hasOwnProperty('rules')) {
    rule.rules.forEach(rule => parseCss(rule, acc));
  }

  if (rule.hasOwnProperty('declarations')) {
    rule.declarations.forEach(decl => {
      if (decl.property === '-webkit-font-smoothing') {
        acc.push('-webkit-font-smoothing: ' + decl.value);
      }

      if (decl.property === '-moz-osx-font-smoothing') {
        acc.push('-moz-osx-font-smoothing: ' + decl.value);
      }

      if (decl.property === 'font-smooth') {
        acc.push('font-smooth: ' + decl.value);
      }
    });
  }
}

function getData(json) {
  try {
    const css = JSON.parse(json);
    const result = [];

    parseCss(css.stylesheet, result);

    // Convert to set and back to array: we are only interested if
    // a property is used on a page, not how many times.
    return [...new Set(result)];
  } catch (e) {
    return [];
  }
}

return getData(data);
''';

SELECT
  client,
  font_smoothing,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    font_smoothing,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getFontSmoothing(css)) AS font_smoothing
  WHERE
    date = '2022-07-01'
  GROUP BY
    client,
    font_smoothing)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_07_01_*`
  GROUP BY
    client)
USING
  (client)
ORDER BY
  pct DESC
