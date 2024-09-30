-- Section: Design
-- Question: Which families are used broken down by script?
-- Normalization: Links

-- INCLUDE ../common.sql

SELECT
  client,
  script,
  FAMILY(payload) AS family,
  2 * COUNT(0) AS count,
  2 * SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, script ORDER BY COUNT(0) DESC) AS rank
FROM
  `httparchive.all.requests`,
  UNNEST(SCRIPTS(payload)) AS script
WHERE
  date = '2024-07-01' AND
  type = 'font' AND
  is_root_page AND
  FAMILY(payload) NOT IN ('Adobe Blank') AND
  RAND() > 0.5
GROUP BY
  client,
  script,
  family
QUALIFY
  rank <= 10
ORDER BY
  client,
  script,
  proportion DESC
