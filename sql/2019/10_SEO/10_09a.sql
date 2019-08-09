#standardSQL

# Metric: Content - looking at word count, thin pages, header usage, alt attributes images

SELECT
    # words
    APPROX_QUANTILES(words_count, 1000)[OFFSET(250)] AS p25_content_words_count,
    APPROX_QUANTILES(words_count, 1000)[OFFSET(500)] AS median_content_words_count,
    APPROX_QUANTILES(words_count, 1000)[OFFSET(750)] AS p75_content_words_count,
    AVG(words_count) AS avg_words_count,
    AVG(word_elements) AS avg_words_elements,
    
    # headers
    APPROX_QUANTILES(header_words_count, 1000)[OFFSET(250)] AS p25_header_words_count,
    APPROX_QUANTILES(header_words_count, 1000)[OFFSET(500)] AS media_header_words_count,
    APPROX_QUANTILES(header_words_count, 1000)[OFFSET(750)] AS p75_header_words_count,
    ROUND(AVG(header_words_count), 2) AS avg_headers_count,
    ROUND(AVG(header_elements), 2) AS avg_headers_elements
FROM (
  SELECT
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-words'].wordsCount") AS INT64) AS words_count,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-words'].wordElements") AS INT64) AS word_elements,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-titles'].titleWords") AS INT64) AS header_words_count,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-titles'].titleElements") AS INT64) AS header_elements
  FROM
    `httparchive.pages.2019_07_01_*`
)
