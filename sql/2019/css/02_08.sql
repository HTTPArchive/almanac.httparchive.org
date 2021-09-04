#standardSQL
# 02_08: % of sites that use classes or IDs in selectors
CREATE TEMPORARY FUNCTION getSelectorType(css STRING)
RETURNS STRUCT<class BOOLEAN, id BOOLEAN> LANGUAGE js AS '''
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
      if (selector.includes('.')) {
        values['class'] = true;
      }
      if (selector.includes(`#`)) {
        values['id'] = true;
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
  COUNTIF(class > 0) AS freq_class,
  COUNTIF(id > 0) AS freq_id,
  total,
  ROUND(COUNTIF(class > 0) * 100 / total, 2) AS pct_class,
  ROUND(COUNTIF(id > 0) * 100 / total, 2) AS pct_id
FROM (
  SELECT
    client,
    COUNTIF(type.class) AS class,
    COUNTIF(type.id) AS id
  FROM (
    SELECT
      client,
      page,
      getSelectorType(css) AS type
    FROM
      `httparchive.almanac.parsed_css`
    WHERE
      date = '2019-07-01')
  GROUP BY
    client,
    page)
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING
  (client)
GROUP BY
  client,
  total
