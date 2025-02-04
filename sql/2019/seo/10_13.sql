#standardSQL
# 10_13: % of desktop pages that include a stylesheet with a breakpoint under 600px.
# See also 12_06
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
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM (SELECT page, css FROM `httparchive.almanac.parsed_css` WHERE client = 'desktop'), (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_desktop`)
WHERE
  date = '2019-07-01' AND
  hasBreakpoint(css)
GROUP BY
  total
