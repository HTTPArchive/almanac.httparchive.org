#standardSQL

# <title> length

SELECT
    APPROX_QUANTILES(CHAR_LENGTH(REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>')), 1000)[OFFSET(250)] as p25_title_length,
    APPROX_QUANTILES(CHAR_LENGTH(REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>')), 1000)[OFFSET(500)] as median_title_length,
    APPROX_QUANTILES(CHAR_LENGTH(REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>')), 1000)[OFFSET(750)] as p75_title_length,
    AVG(CHAR_LENGTH(REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>'))) as avg_title_length
FROM
    `httparchive.almanac.summary_response_bodies`
WHERE
    firstHtml
