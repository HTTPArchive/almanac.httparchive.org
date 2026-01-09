#standardSQL
CREATE TEMPORARY FUNCTION getPaintWorklets(css STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var ast = JSON.parse(css);
  var ret = {};
  walkDeclarations(ast, ({property, value}) => {
    for (let paint of extractFunctionCalls(value, {names: "paint"})) {
      let name = paint.args.match(/^[-\\w+]+/)[0];

      if (name) {
        incrementByKey(ret, name);
      }
    }
  }, {
    properties: /^--|-image$|^background$|^content$/,
    values: /\\bpaint\\(/
  });

  return Object.entries(ret).map(([name, freq]) => ({name, freq}))
} catch (e) {
  return [];
}
''';

SELECT
  client,
  page,
  url,
  paint.name AS worklet,
  paint.freq
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getPaintWorklets(css)) AS paint
WHERE
  date = '2022-07-01' -- noqa: CV09
ORDER BY
  freq DESC
