#standardSQL
# Adoption of CSS aspect-ratio
CREATE TEMPORARY FUNCTION getAspectRatio(css STRING)
RETURNS ARRAY<BOOL> LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js") AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    var aspectRatio = !!rule.declarations.find(d => d.property == 'aspect-ratio');
    return values.concat(aspectRatio);
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

SELECT
  client,
  COUNTIF(sets_aspect_ratio) AS sets_aspect_ratio,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(sets_aspect_ratio) / ANY_VALUE(total_pages) AS pct_sets_aspect_ratio
FROM (
  SELECT
    client,
    page,
    COUNTIF(aspect_ratio) > 0 AS sets_aspect_ratio
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getAspectRatio(css)) AS aspect_ratio
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*`  -- noqa: CV09
  GROUP BY
    _TABLE_SUFFIX
)
USING (client)
GROUP BY
  client
