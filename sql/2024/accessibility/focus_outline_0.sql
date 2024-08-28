#standardSQL
# Adoption of :focus pseudoclass and outline: 0 style

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

    var focusRegEx = /:focus/;
    var fastFocusCheck = rule.selectors.some(selector => focusRegEx.test(selector));
    if (!fastFocusCheck) {
      return values;
    }

    var hasFocusPseudoClass = rule.selectors.some(selector => {
      var tokens = parsel.tokenize(selector);
      return tokens.some(token => token.type == 'pseudo-class' && token.name == 'focus');
    });

    if (!hasFocusPseudoClass) {
      return values;
    }

    var setsOutline0 = rule.declarations.some(d => d.property.toLowerCase() == 'outline' && d.value == '0');
    return values.concat(setsOutline0);
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

WITH focus_data AS (
  SELECT
    client,
    page,
    COUNTIF(sets_outline_0) > 0 AS sets_focus_outline_0
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(getFocusStylesOutline0(css)) AS sets_outline_0
  WHERE
    date = '2024-06-01'
  GROUP BY
    client, page
),
total_pages_data AS (
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  f.client,
  COUNTIF(f.sets_focus_outline_0) AS pages_focus_outline_0,
  tp.total_pages,
  COUNTIF(f.sets_focus_outline_0) / tp.total_pages AS pct_pages_focus_outline_0
FROM
  focus_data AS f
JOIN
  total_pages_data AS tp
ON
  f.client = tp.client
GROUP BY
  f.client, tp.total_pages
