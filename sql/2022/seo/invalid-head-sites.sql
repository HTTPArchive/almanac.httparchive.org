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
    JSON_QUERY(payload, '$._valid-head.invalidHead') AS invalidHead,
    ARRAY_LENGTH(JSON_EXTRACT_ARRAY(payload, '$._valid-head.invalidElements')) AS invalidCount
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
)

SELECT
  client,
  COUNTIF(invalidHead = 'true') AS invalidHeads,
  SUM(invalidCount) AS invalidCount,
  total_pages,
  COUNTIF(invalidHead = 'true') / total_pages AS pct_invalidHeads
FROM
  pages
JOIN
  totals
USING (client)
GROUP BY
  client,
  total_pages
ORDER BY
  client
