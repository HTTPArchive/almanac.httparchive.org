#standardSQL
# Adoption of CSS contain property
CREATE TEMPORARY FUNCTION getContain(css STRING)
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

    var contain = !!rule.declarations.find(d => d.property == 'contain');
    return values.concat(contain);
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

SELECT
  client,
  COUNTIF(sets_contain) AS sets_contain,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(sets_contain) / ANY_VALUE(total_pages) AS pct_sets_contain
FROM (
  SELECT
    client,
    page,
    COUNTIF(contain) > 0 AS sets_contain
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getContain(css)) AS contain
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
