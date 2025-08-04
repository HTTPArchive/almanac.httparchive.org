-- Section: Design
-- Question: Which families are used broken down by script?
-- Normalization: Requests (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
requests AS (
  SELECT
    client,
    SCRIPTS(payload) AS scripts,
    FAMILY(payload) AS family,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload) AND
    -- Without the subsampling, the query throws “UDF out of memory.” To work
    -- around this, a random half is removed, and the counts are doubled.
    RAND() < 0.5
)

SELECT
  client,
  script,
  family,
  2 * COUNT(0) AS count,
  2 * total,
  ROUND(COUNT(0) / total, @precision) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, script ORDER BY COUNT(0) DESC) AS rank
FROM
  requests,
  UNNEST(scripts) AS script
WHERE
  family != 'Adobe Blank'
GROUP BY
  client,
  script,
  family,
  requests.total
QUALIFY
  rank <= 10
ORDER BY
  client,
  script,
  count DESC
