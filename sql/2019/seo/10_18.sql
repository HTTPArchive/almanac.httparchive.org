#standardSQL
# 10_18: Zero count words and headers
SELECT
  client,
  ROUND(COUNTIF(words_count = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS word_count_zero,
  ROUND(COUNTIF(header_elements = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS header_count_zero
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-words'].wordsCount") AS INT64) AS words_count,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-titles'].titleElements") AS INT64) AS header_elements
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
