#standardSQL
# 21_12b: Values of the 'loading' attribute
SELECT
    SUM(ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, r'(?im)<(?:source|img)[^>]*loading=[\'"]?auto'))) as autoCount,
    SUM(ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, r'(?im)<(?:source|img)[^>]*loading=[\'"]?lazy'))) as lazyCount,
    SUM(ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, r'(?im)<(?:source|img)[^>]*loading=[\'"]?eager'))) as eagerCount,
    SUM(ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, r'(?im)<(?:source|img)[^>]'))) as imgCount,
FROM
  `httparchive.almanac.response_bodies`
WHERE
  edition = "2020"