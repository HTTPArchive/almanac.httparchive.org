#standardSQL

# breakpoint under 600px width
# @issue: how to group by page domain/url?

CREATE TEMPORARY FUNCTION hasBreakpoint(css STRING)
RETURNS BOOLEAN LANGUAGE js AS '''

try {
  var reduceValues = (values, rule) => {
    if (rule.type == 'media') {
      var minValue = rule.media.matchAll(/max-width: ([0-9]+)px/i);
      var maxValue = rule.media.matchAll(/min-width: ([0-9]+)px/i);
      if(minValue[0] < 600 || maxValue[0] < 600) {
        return true
      }

      return reduceValues(values, rule.rules);
    }
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);

} catch (e) {
  return [];
}
''';

#SELECT
#    COUNT(0) as count,
#    COUNTIF(hasBreakpoint(payload)) AS occurence,
#    ROUND(COUNTIF(hasBreakpoint(payload)) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
#FROM
#    `httparchive.almanac.parsed_css`
