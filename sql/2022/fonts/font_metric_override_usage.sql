CREATE TEMPORARY FUNCTION getFontMetricsOverride(css STRING)
RETURNS ARRAY < STRING > LANGUAGE js AS '''
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
            if (d.property.toLowerCase() == 'size-adjust') {
                values.push('size-adjust');
            }

            if (d.property.toLowerCase() == 'ascent-override') {
                values.push('ascent-override');
            }

            if (d.property.toLowerCase() == 'descent-override') {
                values.push('descent-override');
            }

            if (d.property.toLowerCase() == 'line-gap-override') {
                values.push('line-gap-override');
            }
        });
        return values;
    };
    var $ = JSON.parse(css);
    return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
    return [null];
}
''';

SELECT
  client,
  font_override,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_override
FROM (
  SELECT DISTINCT
    client,
    page,
    font_override
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getFontMetricsOverride(css)) AS font_override
  WHERE
    date = '2022-07-01')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page
  FROM
    `httparchive.pages.2022_07_01_*`
  GROUP BY
    _TABLE_SUFFIX,
    url,
    payload)
USING
  (client,
    page)
GROUP BY
  client,
  font_override
ORDER BY
  pages DESC
