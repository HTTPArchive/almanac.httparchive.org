#standardSQL
# 21_12a: Count of pages using native lazy loading
SELECT
  countif(REGEXP_CONTAINS(body, r'(?im)<(?:source|img)[^>]*loading=')) as lazyCount,
  COUNT(0) AS totalCount
FROM
  `httparchive.almanac.response_bodies`
WHERE
  edition = "2020"