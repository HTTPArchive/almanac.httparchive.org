#standardSQL
# 09_30b: Usage of aria-label or aria-labelledby
CREATE TEMPORARY FUNCTION getAriaLabelUsage(payload STRING)
RETURNS ARRAY<BOOLEAN> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    if (!almanac['input-elements']) {
      return [];
    }

    return almanac['input-elements'].map(function(node) {
      return !!(node['aria-label'] || node['aria-labelledby']);
    });
  } catch (e) {
    return [];
  }
''';

SELECT
  _TABLE_SUFFIX AS client,
  uses_aria_label,
  COUNT(uses_aria_label) AS occurrences,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total_inputs,
  ROUND(COUNT(uses_aria_label) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS perc_in_all_inputs,
  COUNT(DISTINCT url) AS pages_using_aria,
  total AS total_pages,
  ROUND(COUNT(DISTINCT url) * 100 / total, 2) AS pages_perc
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getAriaLabelUsage(payload)) AS uses_aria_label
JOIN (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
GROUP BY client, uses_aria_label, total
ORDER BY occurrences DESC
