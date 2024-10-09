#standardSQL
# 09_28: Pages that auto refresh, e.g. http-equiv="refresh" attribute in the meta tag
CREATE TEMPORARY FUNCTION getTotalMetaRefresh(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    if (!almanac['meta-nodes']) {
      return 0;
    }

    return almanac['meta-nodes'].reduce(function(acc, node) {
      if (!node['http-equiv']) {
        return acc;
      }

      if (node['http-equiv'].toLowerCase() === 'refresh') {
        return acc + 1;
      }

      return acc;
    }, 0);
  } catch (e) {
    return 0;
  }
''';

SELECT
  client,
  COUNTIF(total_matches > 0) AS occurrences,
  total_pages,
  ROUND(COUNTIF(total_matches > 0) * 100 / total_pages, 2) AS occurrence_percentage
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    getTotalMetaRefresh(payload) AS total_matches
  FROM
    `httparchive.pages.2019_07_01_*`
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total_pages FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
GROUP BY client, total_pages
ORDER BY occurrences DESC
