#standardSQL
CREATE TEMPORARY FUNCTION getImportantProperties(css STRING)
RETURNS ARRAY<STRUCT<property STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var ast = JSON.parse(css);
  let ret = {
    total: 0,
    important: 0,
    properties: {}
  };

  walkDeclarations(ast, ({property, important}) => {
    ret.total++;

    if (important) {
      ret.important++;
      incrementByKey(ret.properties, property);
    }
  });

  ret.properties = sortObject(ret.properties);

  return Object.entries(ret.properties).map(([property, freq]) => {
    return {property, freq};
  });
} catch (e) {
  return [];
}
''';

SELECT
  client,
  property,
  COUNT(DISTINCT page) AS pages,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    important.property,
    important.freq
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getImportantProperties(css)) AS important
  WHERE
    date = '2021-07-01'
)
GROUP BY
  client,
  property
ORDER BY
  pct DESC
LIMIT 500
