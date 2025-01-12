#standardSQL
# Counted metrics of invalid head elements in HTML

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    element
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(JSON_EXTRACT_ARRAY(payload, '$._valid-head.invalidElements')) AS element
)

SELECT
  client,
  element,
  COUNT(DISTINCT url) AS pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  pages
JOIN
  totals
USING (client)
GROUP BY
  client,
  total_pages,
  element
ORDER BY
  pct_pages DESC,
  client
LIMIT 1000
