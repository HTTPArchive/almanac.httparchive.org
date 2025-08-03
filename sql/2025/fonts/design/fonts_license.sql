-- Section: Design
-- Question: Which licenses are used?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

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
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  LICENSE(STRING(JSON_QUERY(payload, '$._font_details.names[14]'))) AS license,
  COUNT(DISTINCT page) AS count,
  total,
  COUNT(DISTINCT page) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
FROM
  `httparchive.crawl.requests`
INNER JOIN
  pages
USING (client)
WHERE
  date = @date AND
  type = 'font' AND
  is_root_page AND
  IS_PARSED(payload)
GROUP BY
  client,
  license,
  total
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
