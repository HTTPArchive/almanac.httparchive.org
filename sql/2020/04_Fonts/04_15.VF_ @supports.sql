#standardSQL
#VF_@supports(??NoResult) 
CREATE TEMPORARY FUNCTION checksSupports(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    var reduceValues = (values, rule) => {
        if (rule.type == 'supports' && rule.supports.toLowerCase().includes('font-variation-settings')) {
            values.push(rule.supports.toLowerCase());
        }
        return values;
    };
    var $ = JSON.parse(css);
    return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
    return [];
}
''';

SELECT
  client,
  COUNT(DISTINCT page) AS freq_support_vf,
  total_page,
  ROUND(COUNT(DISTINCT page) * 100 / total_page, 2) AS pct_support_vf
FROM (
  SELECT
    *
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date='2020-08-01')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client)
WHERE
  ARRAY_LENGTH(checksSupports(css)) > 0
GROUP BY
  client,
  total_page
