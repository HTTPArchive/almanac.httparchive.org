#standardSQL
# Adoption of :focus pseudoclass and outline: 0 style
# Copy of sql/2021/css/focus_outline_0.sql
CREATE TEMPORARY FUNCTION getFocusStylesOutline0(css STRING) RETURNS ARRAY<BOOL> LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js") AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    // Oversimplified but fast regex check.
    var focusRegEx = /:focus/;
    var fastFocusCheck = rule.selectors.find(selector => {
      return focusRegEx.test(selector);
    });
    if (!fastFocusCheck) {
      return values;
    }

    var hasFocusPseudoClass = rule.selectors.find(selector => {
      var tokens = parsel.tokenize(selector);
      return tokens.find(token => {
        return token.type == 'pseudo-class' && token.name == 'focus';
      });
    });

    if (!hasFocusPseudoClass) {
      return values;
    }

    var setsOutline0 = !!rule.declarations.find(d => d.property.toLowerCase() == 'outline' && d.value == '0');
    return values.concat(setsOutline0);
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

SELECT
  client,
  COUNTIF(sets_focus_style) AS pages_focus,
  COUNTIF(sets_focus_outline_0) AS pages_focus_outline_0,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(sets_focus_style) / ANY_VALUE(total_pages) AS pct_pages_focus,
  COUNTIF(sets_focus_outline_0) / ANY_VALUE(total_pages) AS pct_pages_focus_outline_0
FROM (
  SELECT
    client,
    page,
    COUNT(0) > 0 AS sets_focus_style,
    COUNTIF(sets_outline_0) > 0 AS sets_focus_outline_0
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getFocusStylesOutline0(css)) AS sets_outline_0
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    _TABLE_SUFFIX
)
USING (client)
GROUP BY
  client
