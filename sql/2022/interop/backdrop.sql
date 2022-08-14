#standardSQL
CREATE TEMPORARY FUNCTION countBackdrop(css STRING)
RETURNS INT64 LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = 0;

    walkSelectors(ast, selector => {
      let sast = parsel.parse(selector, {list: false});

      parsel.walk(sast, node => {
        if (node.type == 'pseudo-element' && node.name == 'backdrop') {
          ret++;
        }
      }, {subtree: true});
    });

    return ret;
  }

  const ast = JSON.parse(css);
  return compute(ast);
} catch (e) {
  return 0;
}
''';

WITH backdrop AS (
  SELECT
    client,
    page,
    SUM(countBackdrop(css)) > 0 AS uses_backdrop
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01'
  GROUP BY
    client,
    page
)

SELECT
  client,
  COUNTIF(uses_backdrop) AS pages,
  COUNT(0) AS total,
  COUNTIF(uses_backdrop) / COUNT(0) AS pct
FROM
  backdrop
GROUP BY
  client
