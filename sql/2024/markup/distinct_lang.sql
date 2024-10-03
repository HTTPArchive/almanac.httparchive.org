WITH langs AS (
  SELECT
    client,
    TRIM(LOWER(JSON_EXTRACT(custom_metrics, '$.almanac.html_node.lang'))) AS lang
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)

SELECT
  client,
  COUNT(DISTINCT IFNULL(lang, '(not set)')) AS distinct_lang_count
FROM
  langs
GROUP BY
  client
ORDER BY
  distinct_lang_count DESC;
