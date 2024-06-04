#standardSQL
# 02_17: % of pages using em/rem/px in media queries
CREATE TEMPORARY FUNCTION getUnits(css STRING)
RETURNS STRUCT<em BOOLEAN, rem BOOLEAN, px BOOLEAN> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if (rule.type != 'media') {
      return values;
    }

    rule.media.split(',').filter(query => {
      return query.match(/(min|max)-(width|height)/i) && query.match(/\\d+(\\w*)/);
    }).forEach(query => {
      var unit = query.match(/\\d+(\\w*)/)[1];
      values[unit] = true;
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
  COUNTIF(em > 0) AS freq_em,
  COUNTIF(rem > 0) AS freq_rem,
  COUNTIF(px > 0) AS freq_px,
  total,
  ROUND(COUNTIF(em > 0) * 100 / total, 2) AS pct_em,
  ROUND(COUNTIF(rem > 0) * 100 / total, 2) AS pct_rem,
  ROUND(COUNTIF(px > 0) * 100 / total, 2) AS pct_px
FROM (
  SELECT
    client,
    COUNTIF(unit.em) AS em,
    COUNTIF(unit.rem) AS rem,
    COUNTIF(unit.px) AS px
  FROM (
    SELECT
      client,
      page,
      getUnits(css) AS unit
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
