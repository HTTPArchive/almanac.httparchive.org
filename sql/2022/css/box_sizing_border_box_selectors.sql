#standardSQL
# Top selectors used with box-sizing: border-box
CREATE TEMP FUNCTION
getBorderBoxSelectors(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(css);
  return $.stylesheet.rules.flatMap(rule => {
    if (!rule.selectors) {
      return [];
    }

    const boxSizingPattern = /^(-(o|moz|webkit|ms)-)?box-sizing$/;
    const borderBoxPattern = /border-box/;
    if (!rule.declarations.find(d => {
      return boxSizingPattern.test(d.property) && borderBoxPattern.test(d.value);
    })) {
      return [];
    }

    return rule.selectors;
  });
} catch (e) {
  return [];
}
''';
SELECT
  *
FROM (
  SELECT
    client,
    selector,
    COUNT(DISTINCT page) AS pages,
    ANY_VALUE(total_pages) AS total_pages,
    COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
  FROM (
    SELECT
      client,
      page,
      selector
    FROM
      `httparchive.almanac.parsed_css`,
      UNNEST(getBorderBoxSelectors(css)) AS selector
    WHERE
      date = '2022-07-01' -- noqa: CV09
  )
  JOIN (
    SELECT
      _TABLE_SUFFIX AS client,
      COUNT(0) AS total_pages
    FROM
      `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
    GROUP BY
      client
  )
  USING (client)
  GROUP BY
    client,
    selector
)
ORDER BY
  pct DESC
LIMIT 1000
