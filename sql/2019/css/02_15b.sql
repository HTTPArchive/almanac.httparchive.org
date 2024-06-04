#standardSQL
# 02_15b: % of pages using landscape/portrait orientation in media queries
CREATE TEMPORARY FUNCTION getOrientation(css STRING)
RETURNS STRUCT<landscape BOOLEAN, portrait BOOLEAN> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if (rule.type != 'media') {
      return values;
    }

    if (rule.media.toLowerCase().includes('landscape')) {
      values['landscape'] = true;
    }
    if (rule.media.toLowerCase().includes('portrait')) {
      values['portrait'] = true;
    }
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
  COUNTIF(landscape > 0) AS freq_landscape,
  COUNTIF(portrait > 0) AS freq_portrait,
  COUNTIF(landscape > 0 AND portrait > 0) AS freq_both,
  total,
  ROUND(COUNTIF(landscape > 0) * 100 / total, 2) AS pct_landscape,
  ROUND(COUNTIF(portrait > 0) * 100 / total, 2) AS pct_portrait,
  ROUND(COUNTIF(landscape > 0 AND portrait > 0) * 100 / total, 2) AS pct_both
FROM (
  SELECT
    client,
    COUNTIF(orientation.landscape) AS landscape,
    COUNTIF(orientation.portrait) AS portrait
  FROM (
    SELECT
      client,
      page,
      getOrientation(css) AS orientation
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
