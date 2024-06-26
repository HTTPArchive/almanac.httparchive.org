#standardSQL
# 06_16: % of pages that declare a font with local()
CREATE TEMPORARY FUNCTION countLocalSrc(css STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }
    if (rule.type != 'font-face') {
      return values;
    }

    rule.declarations.forEach(d => {
      if (d.property.toLowerCase() == 'src' && d.value.includes('local(')) {
        values++;
      }
    });
    return values;
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, 0);
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  COUNTIF(local > 0) AS freq,
  total,
  ROUND(COUNTIF(local > 0) * 100 / total, 2) AS pct
FROM (
  SELECT
    client,
    SUM(countLocalSrc(css)) AS local
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
GROUP BY
  client,
  total
