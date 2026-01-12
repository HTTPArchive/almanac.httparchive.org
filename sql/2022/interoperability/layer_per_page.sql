#standardSQL
CREATE TEMPORARY FUNCTION countSelectors(css STRING)
RETURNS INT64 LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS r'''
try {
  function compute(ast) {
    let ret = 0;

    walkSelectors(ast, selector => {
      if (/@layer\b/.test(selector)) {
        ret++;
      }
    });

    return ret;
  }

  const ast = JSON.parse(css);
  return compute(ast);
} catch (e) {
  return 0;
}
''';

WITH detections AS (
  SELECT
    client,
    page,
    SUM(countSelectors(css)) AS per_page
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(per_page, 1000)[OFFSET(percentile * 10)] AS layers_per_page
FROM
  detections,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
