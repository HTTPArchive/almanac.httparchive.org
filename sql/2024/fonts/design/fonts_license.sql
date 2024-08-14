-- Section: Design
-- Question: Which licenses are used?

CREATE TEMPORARY FUNCTION LICENSE(value STRING) AS (
  CASE
    WHEN REGEXP_CONTAINS(value, 'adobe|typekit') THEN 'Adobe'
    WHEN REGEXP_CONTAINS(value, 'apache') THEN 'Apache'
    WHEN REGEXP_CONTAINS(value, 'fontawesome') THEN 'Font Awesome'
    WHEN REGEXP_CONTAINS(value, 'linotype|monotype|myfonts') THEN 'Monotype'
    WHEN REGEXP_CONTAINS(value, '(?i)(ofl|openfontlicense)') THEN 'OFL'
    ELSE NULLIF(TRIM(value), '')
  END
);

SELECT
  client,
  LICENSE(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[14]')) AS license,
  COUNT(DISTINCT page) AS count,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font'
GROUP BY
  client,
  license
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
