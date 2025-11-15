# html response content language
# Content-Language usage (device-only; no JS UDF; no DISTINCT)

WITH base AS (
  SELECT
    client,
    page,
    COALESCE(TO_JSON(custom_metrics.other.almanac), custom_metrics.other.almanac) AS almanac_json
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
),

nodes AS (
  SELECT
    client,
    page,
    JSON_VALUE(n, '$."http-equiv"') AS http_equiv,
    JSON_VALUE(n, '$.content')      AS content
  FROM base
  LEFT JOIN UNNEST(JSON_QUERY_ARRAY(almanac_json, '$."meta-nodes".nodes')) AS n
),

filtered AS (
  SELECT
    client,
    page,
    LOWER(TRIM(content)) AS lang
  FROM nodes
  WHERE LOWER(TRIM(http_equiv)) = 'content-language'
    AND content IS NOT NULL
    AND TRIM(content) <> ''
),

page_langs AS (
  SELECT
    client,
    page,
    IFNULL(ARRAY_AGG(DISTINCT lang IGNORE NULLS), []) AS langs
  FROM filtered
  GROUP BY client, page
),

page_langs_filled AS (
  SELECT
    client,
    page,
    IF(ARRAY_LENGTH(langs) = 0, ['NO TAG'], langs) AS langs
  FROM page_langs
),

expanded AS (
  SELECT
    client,
    page,
    lang AS content_language
  FROM page_langs_filled, UNNEST(langs) AS lang
)

SELECT
  client,
  content_language,
  COUNT(*) AS sites,
  SUM(COUNT(*)) OVER (PARTITION BY client) AS total,
  SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER (PARTITION BY client)) AS pct
FROM expanded
GROUP BY client, content_language
ORDER BY sites DESC, client DESC;
