#standardSQL
CREATE TEMPORARY FUNCTION getResourceHintAttrs(link_nodes STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload']);
var attributes = ['as'];
try {
  var linkNodes = JSON.parse(link_nodes);
  return linkNodes.nodes.reduce((results, link) => {
    var hint = link.rel.toLowerCase();
    if (!hints.has(hint)) {
      return results;
    }
    attributes.forEach(attribute => {
      var value = link[attribute];
      results.push({
        name: hint,
        attribute: attribute,
        // Support empty strings.
        value: typeof value == 'string' ? value : null
      });
    });
    return results;
  }, []);
} catch (e) {
  return [];
}
''';

WITH total_pages AS (
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client,
    is_root_page
)

SELECT
  client,
  is_root_page,
  as_value,
  total,
  COUNT(DISTINCT IF(preload_hints > 0, page, NULL)) AS preload_pages,
  COUNT(DISTINCT IF(preload_hints > 0, page, NULL)) / total AS preload_pages_pct
FROM (
  SELECT
    client,
    is_root_page,
    page,
    as_value,
    COUNT(0) AS preload_hints
  FROM (
    SELECT
      client,
      is_root_page,
      page,
      hint.value AS as_value
    FROM
      `httparchive.all.pages`
    JOIN
      UNNEST(getResourceHintAttrs(JSON_QUERY(custom_metrics, '$.almanac.link-nodes'))) AS hint
    WHERE
      date = '2024-06-01'
  )
  GROUP BY
    client,
    is_root_page,
    page,
    as_value
)
JOIN
  total_pages
USING (client, is_root_page)
GROUP BY
  client,
  is_root_page,
  as_value,
  total
ORDER BY
  preload_pages_pct DESC
