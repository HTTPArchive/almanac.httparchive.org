#standardSQL
# LCP element node
# This is a simplified query - the lcp_element_data.sql one will probably be used instead. Leaving this here for reference for now.

SELECT
  _TABLE_SUFFIX AS client,
  JSON_EXTRACT_SCALAR(payload, "$._performance.lcp_elem_stats[0].nodeName") AS lcp_node,
  COUNT(DISTINCT url) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT url) / ANY_VALUE(total) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (_TABLE_SUFFIX)
GROUP BY
  client,
  lcp_node
HAVING
  pages > 1000
ORDER BY
  pct DESC
