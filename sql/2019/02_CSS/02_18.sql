#standardSQL
# 02_18: % of pages using all/print/screen/speech in media queries
CREATE TEMPORARY FUNCTION getMediaType(css STRING)
RETURNS STRUCT<all BOOLEAN, print BOOLEAN, screen BOOLEAN, speech BOOLEAN> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if (rule.type != 'media') {
      return values;
    }

    var media = rule.media.toLowerCase();
    var types = ['all', 'print', 'screen', 'speech'];
    types.forEach(type => {
      if (media.includes(type)) {
        values[type] = true;
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
  COUNTIF(all > 0) AS freq_all,
  COUNTIF(print > 0) AS freq_print,
  COUNTIF(screen > 0) AS freq_screen,
  COUNTIF(speech > 0) AS freq_speech,
  total,
  ROUND(COUNTIF(all > 0) * 100 / total, 2) AS pct_all,
  ROUND(COUNTIF(print > 0) * 100 / total, 2) AS pct_print,
  ROUND(COUNTIF(screen > 0) * 100 / total, 2) AS pct_screen,
  ROUND(COUNTIF(speech > 0) * 100 / total, 2) AS pct_speech
FROM (
  SELECT
    client,
    COUNTIF(type.all) AS all,
    COUNTIF(type.print) AS print,
    COUNTIF(type.screen) AS screen,
    COUNTIF(type.speech) AS speech
  FROM (
    SELECT
      client,
      page,
      getMediaType(css) AS type
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
