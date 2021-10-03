#standardSQL
# Number of pages all of whose properties have !important
CREATE TEMPORARY FUNCTION getImportantProperties(css STRING)
RETURNS STRUCT<total INT64, important INT64>
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

  return ret;
} catch (e) {
  return [];
}
''';

SELECT
  client,
  COUNTIF(important = total) AS all_important_pages
FROM (
  SELECT
    client,
    page,
    SUM(properties.important) AS important,
    SUM(properties.total) AS total
  FROM (
      SELECT
        client,
        page,
        getImportantProperties(css) AS properties
      FROM
        `httparchive.almanac.parsed_css`
      WHERE
        date = '2021-07-01')
  GROUP BY
    client,
    page)
GROUP BY
  client
