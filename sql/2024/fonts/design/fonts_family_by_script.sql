-- Section: Design
-- Question: Which families are used broken down by script?
-- Normalization: Links

-- INCLUDE ../common.sql

WITH
links AS (
  SELECT
    client,
    SCRIPTS(payload) AS scripts,
    FAMILY(payload) AS family,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload) AND
    RAND() > 0.5
)

SELECT
  client,
  script,
  family,
  2 * COUNT(0) AS count,
  2 * total AS total,
  COUNT(0) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, script ORDER BY COUNT(0) DESC) AS rank
FROM
  links,
  UNNEST(scripts) AS script
WHERE
  family != 'Adobe Blank'
GROUP BY
  client,
  script,
  family,
  links.total
QUALIFY
  rank <= 10
ORDER BY
  client,
  script,
  proportion DESC
