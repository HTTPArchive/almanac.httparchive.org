#standardSQL

# Content - looking at word count, thin pages, header usage, alt attributes images


SELECT
    url,
    JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$.seo-words.wordsCount") as wordsCount,
    JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$.seo-words.wordElements") as wordElements,
    JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$.seo-titles.titleWords") as titleWordsCount,
    JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$.seo-words.titleElements") as titleElements,
FROM
    `httparchive.pages.2019_07_01_desktop`
/* group by for counting SUM */
LIMIT 10
