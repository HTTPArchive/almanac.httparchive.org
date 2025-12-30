#standardSQL
# Iframe loading property usage
# Note: This query only reports if an attribute was ever used on a page. It is not a per iframe report.

# Returns all the data we need from _markup
CREATE TEMPORARY FUNCTION getIframeMarkupInfo(markup JSON)
RETURNS STRUCT<
  loading ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};

// Function to retrieve only keys if value is >0
function getKey(dict) {
  const arr = [],
        obj = Object.keys(dict);
  for (var x in obj) {
    if (dict[obj[x]] > 0) {
      arr.push(obj[x]);
    }
  }
  return arr;
}

try {
    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.iframes && markup.iframes.loading) {
      result.loading = getKey(markup.iframes.loading);
    }
} catch (e) {}
return result;
''';

WITH iframe_loading_table AS (
  SELECT
    client,
    root_page,
    page,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    getIframeMarkupInfo(custom_metrics.markup) AS iframe_markup_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  iframe_markup_info,
  COUNT(DISTINCT page) AS sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM
  iframe_loading_table,
  UNNEST(iframe_markup_info.loading) AS loading
GROUP BY
  client,
  is_root_page,
  iframe_markup_info
ORDER BY
  client,
  is_root_page,
  iframe_markup_info
