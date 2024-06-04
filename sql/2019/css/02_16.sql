#standardSQL
# 02_16: % of pages using min/max-width in media queries
CREATE TEMPORARY FUNCTION getMediaType(css STRING)
RETURNS STRUCT<max_width BOOLEAN, min_width BOOLEAN> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if (rule.type != 'media') {
      return values;
    }

    if (rule.media.toLowerCase().includes('max-width')) {
      values['max_width'] = true;
    }
    if (rule.media.toLowerCase().includes('min-width')) {
      values['min_width'] = true;
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
  COUNTIF(max_width > 0) AS freq_max_width,
  COUNTIF(min_width > 0) AS freq_min_width,
  COUNTIF(max_width > 0 AND min_width > 0) AS freq_both,
  total,
  ROUND(COUNTIF(max_width > 0) * 100 / total, 2) AS pct_max_width,
  ROUND(COUNTIF(min_width > 0) * 100 / total, 2) AS pct_min_width,
  ROUND(COUNTIF(max_width > 0 AND min_width > 0) * 100 / total, 2) AS pct_both
FROM (
  SELECT
    client,
    COUNTIF(type.max_width) AS max_width,
    COUNTIF(type.min_width) AS min_width
  FROM (
    SELECT
      client,
      page,
      getMediaType(css) AS type
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
