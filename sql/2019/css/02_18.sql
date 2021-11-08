#standardSQL
# 02_18: % of pages using all/print/screen/speech in media queries
CREATE TEMPORARY FUNCTION getMediaType(css STRING)
RETURNS STRUCT<all_media BOOLEAN, print_media BOOLEAN, screen_media BOOLEAN, speech_media BOOLEAN> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if (rule.type != 'media') {
      return values;
    }

    var media = rule.media.toLowerCase();
    var types = ['all', 'print', 'screen', 'speech'];
    types.forEach(type => {
      if (media.includes(type)) {
        values[type + '_media'] = true;
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
  COUNTIF(all_media > 0) AS freq_all,
  COUNTIF(print_media > 0) AS freq_print,
  COUNTIF(screen_media > 0) AS freq_screen,
  COUNTIF(speech_media > 0) AS freq_speech,
  total,
  ROUND(COUNTIF(all_media > 0) * 100 / total, 2) AS pct_all,
  ROUND(COUNTIF(print_media > 0) * 100 / total, 2) AS pct_print,
  ROUND(COUNTIF(screen_media > 0) * 100 / total, 2) AS pct_screen,
  ROUND(COUNTIF(speech_media > 0) * 100 / total, 2) AS pct_speech
FROM (
  SELECT
    client,
    COUNTIF(type.all_media) AS all_media,
    COUNTIF(type.print_media) AS print_media,
    COUNTIF(type.screen_media) AS screen_media,
    COUNTIF(type.speech_media) AS speech_media
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
