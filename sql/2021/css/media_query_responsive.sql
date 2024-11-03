#standardSQL
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
    date = '2021-07-01' AND
    feature IS NOT NULL
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client
)
USING (client)
WHERE
  REGEXP_CONTAINS(feature, r'(-width|-height|-aspect-ratio)$')
GROUP BY
  client,
  total
