#standardSQL

CREATE TEMPORARY FUNCTION getMediaQueryFeatures(css JSON)
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

  let features = compute(css);
  return Object.keys(features);
} catch (e) {
  return [];
}
''';

WITH media_query_data AS (
  -- Extracting media query features from the CSS data
  SELECT
    client,
    page,
    LOWER(feature) AS feature
  FROM
    `httparchive.crawl.parsed_css`,
    UNNEST(getMediaQueryFeatures(css)) AS feature
  WHERE
    date = '2025-07-01' AND
    feature IS NOT NULL
  GROUP BY
    client, page, feature
),

total_pages_data AS (
  -- Calculating the total number of pages per client
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    client
)

SELECT
  m.client,
  m.feature,
  COUNT(DISTINCT m.page) AS pages,
  tp.total_pages,
  SAFE_DIVIDE(COUNT(DISTINCT m.page), tp.total_pages) AS pct_pages_with_feature
FROM
  media_query_data AS m
JOIN
  total_pages_data AS tp
ON
  m.client = tp.client
GROUP BY
  m.client, m.feature, tp.total_pages
HAVING
  pages >= 100
ORDER BY
  pct_pages_with_feature DESC;
