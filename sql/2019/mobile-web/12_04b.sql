#standardSQL
# 12_04b: Viewport directive usage
CREATE TEMPORARY FUNCTION getViewportDirectiveData(payload STRING)
RETURNS ARRAY<STRUCT<directive STRING, value STRING>> LANGUAGE js AS '''
  var viewport_separator_regex = new RegExp('(,|;| )+', 'gm');

  try {
    var $ = JSON.parse(payload);
    if (!$._meta_viewport) {
      return [];
    }

    var found_directives = new Set();
    var viewport_parts = $._meta_viewport.replace(viewport_separator_regex, ',').split(',');
    return viewport_parts
      .map(function(viewport_part) {
        var [directive, value] = viewport_part.split('=');

        if (found_directives.has(directive)) {
          return false;
        }
        found_directives.add(directive);

        return {
          directive: (directive || '').trim().toLowerCase(),
          value: (value || '').trim().toLowerCase(),
        };
      })
      .filter(v => v !== false);
  } catch (e) {
    return [];
  }
''';

SELECT
  total_pages,
  viewport_info.directive AS directive,
  viewport_info.value AS value,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY viewport_info.directive) AS total_sites_with_directive,

  COUNT(0) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY viewport_info.directive), 2) AS perc_value_in_directive,
  ROUND(COUNT(0) * 100 / total_pages, 2) AS perc_in_all_pages
FROM
  `httparchive.pages.2019_07_01_mobile`, (SELECT COUNT(0) AS total_pages FROM `httparchive.pages.2019_07_01_mobile`),
  UNNEST(getViewportDirectiveData(payload)) AS viewport_info
GROUP BY
  total_pages,
  viewport_info.directive,
  viewport_info.value
ORDER BY
  total DESC
