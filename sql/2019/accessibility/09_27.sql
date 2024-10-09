#standardSQL
# 09_27: Sites with elements that are in the tab order but have no interactive role, e.g. a paragraph
CREATE TEMPORARY FUNCTION getTagsWithTabIndex(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    if (!almanac['09.27']) {
      return [];
    }

    var interactive_elements =
        ['a', 'audio', 'button', 'details', 'input', 'select', 'textarea', 'video'];

    return almanac['09.27']
      .map(function(node) {
        var tabindex_value = parseInt(node.tabindex, 10);
        if (isNaN(tabindex_value) || tabindex_value < 0) {
          return null;
        }

        var name = node.tagName.toLowerCase();
        return interactive_elements.indexOf(name) < 0 ? name : null;
      })
      .filter(name => name)
  } catch (e) {
    return [];
  }
''';

SELECT
  _TABLE_SUFFIX AS client,
  tag_type,
  COUNT(tag_type) AS occurrences,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total_interactive_elements,
  ROUND(COUNT(tag_type) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS occurrence_perc,
  COUNT(DISTINCT url) AS pages,
  total AS total_pages,
  ROUND(COUNT(DISTINCT url) * 100 / total, 2) AS pages_perc
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getTagsWithTabIndex(payload)) AS tag_type
JOIN (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
GROUP BY client, tag_type, total
ORDER BY occurrences DESC
