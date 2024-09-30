-- Section: Design
-- Question: Which licenses are used?
-- Normalization: Sites

CREATE TEMPORARY FUNCTION LICENSE(value STRING) AS (
  CASE
    WHEN REGEXP_CONTAINS(value, 'adobe|typekit') THEN 'Adobe'
    WHEN REGEXP_CONTAINS(value, 'apache') THEN 'Apache'
    WHEN REGEXP_CONTAINS(value, 'fontawesome') THEN 'Font Awesome'
    WHEN REGEXP_CONTAINS(value, 'linotype|monotype|myfonts') THEN 'Monotype'
    WHEN REGEXP_CONTAINS(value, r'(?i)(ofl|open\s?font\s?license|sil\.org)') THEN 'OFL'
    ELSE NULLIF(NULLIF(TRIM(value), ''), '-')
  END
);

WITH
sites AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  LICENSE(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[14]')) AS license,
  COUNT(DISTINCT page) AS count,
  total,
  COUNT(DISTINCT page) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
FROM
  `httparchive.all.requests`
INNER JOIN
  sites USING (client)
WHERE
  date = '2024-07-01' AND
  type = 'font' AND
  is_root_page
GROUP BY
  client,
  license,
  total
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
