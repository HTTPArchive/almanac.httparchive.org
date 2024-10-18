#standardSQL
# 02_43: % of sites that use [id="foo"] selectors
CREATE TEMPORARY FUNCTION getAttributeSelectorType(css STRING)
RETURNS STRUCT<`=` BOOLEAN, `*=` BOOLEAN, `^=` BOOLEAN, `$=` BOOLEAN, `~=` BOOLEAN>
LANGUAGE js
AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    var selectors = rule.selectors || rule.selector && [rule.selector];
    if (!selectors) {
      return values;
    }

    selectors.forEach(selector => {
      var match = selector.match(/\\[id([*^$~]?=)/);
      if (match) {
        var operator = match[1];
        values[operator] = true;
      }
    });
    return values;
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, {});
} catch (e) {
  return {};
}
''';

SELECT
  client,
  COUNTIF(equals > 0) AS freq_equals,
  COUNTIF(star_equals > 0) AS freq_star_equals,
  COUNTIF(caret_equals > 0) AS freq_caret_equals,
  COUNTIF(dollar_equals > 0) AS freq_dollar_equals,
  COUNTIF(tilde_equals > 0) AS freq_tilde_equals,
  total,
  ROUND(COUNTIF(equals > 0) * 100 / total, 2) AS pct_equals,
  ROUND(COUNTIF(star_equals > 0) * 100 / total, 2) AS pct_star_equals,
  ROUND(COUNTIF(caret_equals > 0) * 100 / total, 2) AS pct_caret_equals,
  ROUND(COUNTIF(dollar_equals > 0) * 100 / total, 2) AS pct_dollar_equals,
  ROUND(COUNTIF(tilde_equals > 0) * 100 / total, 2) AS pct_tilde_equals
FROM (
  SELECT
    client,
    COUNTIF(type.`=`) AS equals, -- noqa: RF05
    COUNTIF(type.`*=`) AS star_equals, -- noqa: RF05
    COUNTIF(type.`^=`) AS caret_equals, -- noqa: RF05
    COUNTIF(type.`$=`) AS dollar_equals, -- noqa: RF05
    COUNTIF(type.`~=`) AS tilde_equals -- noqa: RF05
  FROM (
    SELECT
      client,
      page,
      getAttributeSelectorType(css) AS type
    FROM
      `httparchive.almanac.parsed_css`
    WHERE
      date = '2019-07-01'
  )
  GROUP BY
    client,
    page
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING (client)
GROUP BY
  client,
  total
