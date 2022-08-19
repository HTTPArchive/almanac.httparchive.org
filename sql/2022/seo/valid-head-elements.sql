#standardSQL
# Counted metrics of invalid head elements in HTML

WITH pages AS (
  SELECT
    url,
    JSON_QUERY(payload, '$._valid-head.invalidHead') AS invalidHead,
    JSON_EXTRACT_ARRAY(payload, '$._valid-head.invalidElements') AS invalidElements,
    ARRAY_LENGTH(JSON_EXTRACT_ARRAY(payload, '$._valid-head.invalidElements')) AS invalidCount
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: L062
)

SELECT
  element,
  COUNT(element) AS elementCount
FROM
  pages
CROSS JOIN
  UNNEST(invalidElements) AS element
GROUP BY
  element
ORDER BY
  elementCount DESC
