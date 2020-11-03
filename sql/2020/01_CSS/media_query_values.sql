#standardSQL
CREATE TEMPORARY FUNCTION getMediaQueryValues(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  function compute(ast) {
    let ret = {};

    walkRules(ast, rule => {
      let queries = rule.media
                .replace(/\\s+/g, "")
                .match(/\\(.+?\\)/g);

      if (queries) {
        for (let query of queries) {
          incrementByKey(ret, query);
        }
      }
    }, {type: "media"});

    return ret;
  }

  const ast = JSON.parse(css);
  let values = compute(ast);
  return Object.keys(values);
} catch (e) {
  return [];
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  client,
  value,
  COUNT(DISTINCT page) AS pages,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM (
  SELECT DISTINCT
    client,
    page,
    LOWER(value) AS value
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getMediaQueryValues(css)) AS value
  WHERE
    date = '2020-08-01' AND
    value IS NOT NULL)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  total,
  value
HAVING
  pct >= 0.01
ORDER BY
  pct DESC