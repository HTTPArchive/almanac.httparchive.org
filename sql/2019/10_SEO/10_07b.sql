#standardSQL

# <title> length

SELECT
    APPROX_QUANTILES(CHAR_LENGTH(REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>')), 1000)[OFFSET(250)] AS p25_title_length,
    APPROX_QUANTILES(CHAR_LENGTH(REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>')), 1000)[OFFSET(500)] AS median_title_length,
    APPROX_QUANTILES(CHAR_LENGTH(REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>')), 1000)[OFFSET(750)] AS p75_title_length,
    AVG(CHAR_LENGTH(REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>'))) AS avg_title_length
FROM
    `httparchive.almanac.summary_response_bodies`
WHERE
    firstHtml
