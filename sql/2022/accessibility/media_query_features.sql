#standardSQL
# Copy of sql/2022/css/media_query_features.sql
CREATE TEMPORARY FUNCTION getMediaQueryFeatures(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {};

    walkRules(ast, rule => {
      let features = rule.media
                .replace(/\\s+/g, "")
                .match(/\\([\\w-]+(?=[:\\)])/g);

      if (features) {
        features = features.map(s => s.slice(1));

        for (let feature of features) {
          incrementByKey(ret, feature);
        }
      }
    }, {type: "media"});

    return ret;
  }

  const ast = JSON.parse(css);
  let features = compute(ast);
  return Object.keys(features);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  feature,
  COUNT(DISTINCT page) AS pages,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM (
  SELECT DISTINCT
    client,
    page,
    LOWER(feature) AS feature
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getMediaQueryFeatures(css)) AS feature
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    feature IS NOT NULL
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  total,
  feature
HAVING
  pages >= 100
ORDER BY
  pct DESC
