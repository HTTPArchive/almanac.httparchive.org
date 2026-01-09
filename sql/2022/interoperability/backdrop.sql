#standardSQL
# Percentage of pages that have a ::backdrop selector.
CREATE TEMPORARY FUNCTION countSelectors(css STRING)
RETURNS INT64 LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = 0;

    walkSelectors(ast, selector => {
      if (/::backdrop/.test(selector)) {
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
    SUM(countSelectors(css)) > 0 AS detected
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
)

SELECT
  client,
  COUNTIF(detected) AS pages,
  COUNT(0) AS total,
  COUNTIF(detected) / COUNT(0) AS pct
FROM
  detections
GROUP BY
  client
