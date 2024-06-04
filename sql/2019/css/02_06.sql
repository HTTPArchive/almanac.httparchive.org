#standardSQL
# 02_06: % of sites that use each color format
CREATE TEMPORARY FUNCTION getColorFormats(css STRING)
RETURNS STRUCT<hsl BOOLEAN, hsla BOOLEAN, rgb BOOLEAN, rgba BOOLEAN, hex BOOLEAN> LANGUAGE js AS '''
try {
  var getColorFormat = (value) => {
    value = value.toLowerCase();
    if (value.includes('hsl(')) {
      return 'hsl';
    }
    if (value.includes('hsla(')) {
      return 'hsla';
    }
    if (value.includes('rgb(')) {
      return 'rgb';
    }
    if (value.includes('rgba(')) {
      return 'rgba';
    }
    if (value.match(/#\\d{3,}/)) {
      return 'hex';
    }
    return null;
  }

  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    rule.declarations.forEach(d => {
      var format = getColorFormat(d.value);
      if (format) {
        values[format] = true;
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
  COUNTIF(hsl > 0) AS freq_hsl,
  COUNTIF(hsla > 0) AS freq_hsla,
  COUNTIF(rgb > 0) AS freq_rgb,
  COUNTIF(rgba > 0) AS freq_rgba,
  COUNTIF(hex > 0) AS freq_hex,
  total,
  ROUND(COUNTIF(hsl > 0) * 100 / total, 2) AS pct_hsl,
  ROUND(COUNTIF(hsla > 0) * 100 / total, 2) AS pct_hsla,
  ROUND(COUNTIF(rgb > 0) * 100 / total, 2) AS pct_rgb,
  ROUND(COUNTIF(rgba > 0) * 100 / total, 2) AS pct_rgba,
  ROUND(COUNTIF(hex > 0) * 100 / total, 2) AS pct_hex
FROM (
  SELECT
    client,
    COUNTIF(color.hsl) AS hsl,
    COUNTIF(color.hsla) AS hsla,
    COUNTIF(color.rgb) AS rgb,
    COUNTIF(color.rgba) AS rgba,
    COUNTIF(color.hex) AS hex
  FROM (
    SELECT
      client,
      page,
      getColorFormats(css) AS color
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
