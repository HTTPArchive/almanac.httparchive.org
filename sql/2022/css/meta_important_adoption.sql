#standardSQL
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
  percentile,
  client,
  COUNTIF(pct_important = 100) AS all_important_pages,
  APPROX_QUANTILES(pct_important, 1000)[OFFSET(percentile * 10)] AS pct_important_props
FROM (
  SELECT
    client,
    page,
    SAFE_DIVIDE(SUM(properties.important), SUM(properties.total)) AS pct_important
  FROM (
    SELECT
      client,
      page,
      getImportantProperties(css) AS properties
    FROM
      `httparchive.almanac.parsed_css`
    WHERE
      date = '2022-07-01' -- noqa: CV09
  )
  GROUP BY
    client,
    page
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
