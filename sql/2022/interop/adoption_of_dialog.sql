#standardSQL
# Number of pages that contain a <dialog> element

CREATE TEMPORARY FUNCTION hasDialogElement(str STRING)
RETURNS BOOL LANGUAGE js AS '''
  try {
    const element_count = JSON.parse(str);

    if (Array.isArray(element_count) || typeof element_count !== "object") {
      return null;
    }

    return Object.keys(element_count).find(n => n === "dialog");
  } catch (e) {
    return null;
  }
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX as client,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    client
)

SELECT
  client,
  COUNTIF(has_dialog = TRUE) AS has_dialog,
  total,
  COUNTIF(has_dialog = TRUE) / total AS pct_has_dialog
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    hasDialogElement(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS has_dialog
  FROM
    `httparchive.pages.2022_06_01_*`
)
JOIN
  totals
USING (client)
GROUP BY
  client,
  total
ORDER BY
  client,
  pct_has_dialog DESC
