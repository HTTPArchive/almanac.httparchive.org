#standardSQL
CREATE TEMPORARY FUNCTION getDeclarationCounts(css STRING)
RETURNS STRUCT<
  total NUMERIC,
  unique NUMERIC
>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
    function compute() {
        let ret = {total: 0};
        let unique = new Set();

        walkDeclarations(ast, ({property, value}) => {
          if (!property.startsWith("--")) { // Custom props are case sensitive
              property = property.toLowerCase();
          }

          ret.total++;
          unique.add(`${property}: ${value}`);
        });

        ret.unique = unique.size;

        return ret;
    }

  const ast = JSON.parse(css);
  return compute(ast);
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(total, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS total,
  APPROX_QUANTILES(unique, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS unique,
  APPROX_QUANTILES(SAFE_DIVIDE(unique, total), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS unique_ratio
FROM (
  SELECT
    client,
    SUM(info.total) AS total,
    SUM(info.unique) AS unique
  FROM (
    SELECT
      client,
      page,
      getDeclarationCounts(css) AS info
    FROM
      `httparchive.almanac.parsed_css`
    WHERE
      date = '2022-07-01' -- noqa: CV09
  )
  GROUP BY
    client,
    page
),
  UNNEST([10, 25, 50, 75, 90, 95, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
