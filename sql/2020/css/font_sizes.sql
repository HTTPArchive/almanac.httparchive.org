#standardSQL
CREATE TEMPORARY FUNCTION getFontSizes(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var ast = JSON.parse(css);
  var fontSizes = [];
  walkDeclarations(ast, ({property, value}) => {
    for (let fontSize of value.matchAll(/^(?<px>[\\d]+)(px|.\\d+px)/g)) {
      fontSizes.push(fontSize.groups.px);
    }
  }, {properties: /^font/});
  return fontSizes;
} catch (e) {
  return [];
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(px, 1000)[OFFSET(percentile * 10)] AS font_size_px,
  APPROX_QUANTILES(LENGTH(px), 1000)[OFFSET(percentile * 10)] AS font_size_digits
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getFontSizes(css)) AS px,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2020-08-01'
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
