-- Section: Performance
-- Question: What is the usage of link relationship in HTML?
-- Normalization: Pages

CREATE TEMPORARY FUNCTION HINTS(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
// Keep it in sync with SERVICE in common.sql.
const services = [
  /(fonts|use)\\.typekit\\.(net|com)/,
  /cloud\\.typenetwork\\.com/,
  /cloud\\.typography\\.com/,
  /cloud\\.webtype\\.com/,
  /f\\.fontdeck\\.com/,
  /fast\\.fonts\\.(com|net)\\/(jsapi|cssapi)/,
  /fnt\\.webink\\.com/,
  /fontawesome\\.com/,
  /fonts\\.(gstatic|googleapis)\\.com|themes.googleusercontent.com|ssl.gstatic.com/,
  /fonts\\.typonine\\.com/,
  /fonts\\.typotheque\\.com/,
  /kernest\\.com/,
  /typefront\\.com/,
  /typesquare\\.com/,
  /use\\.edgefonts\\.net|webfonts\\.creativecloud\\.com/,
  /webfont\\.fontplus\\.jp/,
  /webfonts\\.fontslive\\.com/,
  /webfonts\\.fontstand\\.com/,
  /webfonts\\.justanotherfoundry\\.com/,
];

const globalHints = new Set([
  'dns-prefetch',
  'preconnect',
]);
const localHints = new Set([
  'prefetch',
  'preload',
]);

try {
  const $ = JSON.parse(json);
  return $.almanac['link-nodes'].nodes.reduce((results, link) => {
    const hint = link.rel.toLowerCase();
    if (globalHints.has(hint)) {
      if (services.some((service) => service.test(link.href))) {
        results.push(hint);
      }
    } else if (localHints.has(hint)) {
      if (link.as.toLowerCase() === 'font') {
        results.push(hint);
      }
    }
    return results;
  }, []);
} catch (e) {
  return [];
}
''';

WITH
hints AS (
  SELECT
    client,
    hint,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.pages`,
    UNNEST(HINTS(custom_metrics)) AS hint
  WHERE
    date = '2024-07-01'
  GROUP BY
    client,
    hint
),
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-07-01'
  GROUP BY
    client
)

SELECT
  client,
  hint,
  count,
  total,
  count / total AS proportion
FROM
  hints
LEFT JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
