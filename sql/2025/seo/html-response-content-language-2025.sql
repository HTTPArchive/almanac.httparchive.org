# html response content language
# Content-Language usage (device-only; no JS UDF; no DISTINCT)

# html response content language
# Content-Language usage (device-only; no JS UDF; no DISTINCT)

WITH nodes AS (
  SELECT
    client,
    page,
    LOWER(TRIM(JSON_VALUE(n, '$.content'))) AS lang
  FROM
    `httparchive.crawl.pages`
  LEFT JOIN
    UNNEST(JSON_QUERY_ARRAY(custom_metrics.other.almanac.`meta-nodes`.nodes)) AS n
  WHERE
    date = '2025-07-01' AND
    LOWER(TRIM(JSON_VALUE(n, '$."http-equiv"'))) = 'content-language' AND
    JSON_VALUE(n, '$.content') IS NOT NULL AND
    TRIM(JSON_VALUE(n, '$.content')) <> ''
),

page_langs AS (
  SELECT
    client,
    page,
    IFNULL(ARRAY_AGG(DISTINCT lang IGNORE NULLS), ['NO TAG']) AS langs
  FROM
    nodes
  GROUP BY
    client,
    page
),

expanded AS (
  SELECT
    client,
    page,
    lang AS content_language
  FROM
    page_langs,
    UNNEST(langs) AS lang
)

SELECT
  client,
  content_language,
  COUNT(0) AS sites,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct
FROM
  expanded
GROUP BY
  client,
  content_language
ORDER BY
  sites DESC,
  client DESC;
