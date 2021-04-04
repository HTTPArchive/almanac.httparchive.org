#standardSQL

# % of pages that include a stylesheet with a breakpoint under 600px.
# (!) 7.71 TB

CREATE TEMPORARY FUNCTION hasBreakpoint(css STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
function matchAll(re, str) {
  var results = [];
  while ((matches = re.exec(str)) !== null) {
    results.push(matches[1]);
  }
  return results;
}

try {
  var $ = JSON.parse(css);
  return $.stylesheet.rules.some(rule => {
    return rule.type == 'media' &&
        rule.media &&
        matchAll(/width:\\s*(\\d+)px/ig, rule.media).some(match => +match < 600);
  });
} catch (e) {
  false;
}
''';

SELECT
  COUNT(DISTINCT page) AS pages,
  ROUND(COUNT(DISTINCT page) * 100 / (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_mobile`), 2) AS pct
FROM
  `httparchive.almanac.parsed_css`
WHERE
  date = '2019-07-01' AND
  client = 'mobile' AND
  hasBreakpoint(css)
