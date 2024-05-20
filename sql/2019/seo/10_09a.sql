#standardSQL
# 10_09a: Content - looking at word count, thin pages, header usage, alt attributes images
SELECT
  percentile,
  client,
  APPROX_QUANTILES(words_count, 1000)[OFFSET(percentile * 10)] AS words_count,
  APPROX_QUANTILES(word_elements, 1000)[OFFSET(percentile * 10)] AS word_elements,
  APPROX_QUANTILES(header_words_count, 1000)[OFFSET(percentile * 10)] AS header_words_count,
  APPROX_QUANTILES(header_elements, 1000)[OFFSET(percentile * 10)] AS header_elements
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-words'].wordsCount") AS INT64) AS words_count,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-words'].wordElements") AS INT64) AS word_elements,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-titles'].titleWords") AS INT64) AS header_words_count,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-titles'].titleElements") AS INT64) AS header_elements
  FROM
    `httparchive.pages.2019_07_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
