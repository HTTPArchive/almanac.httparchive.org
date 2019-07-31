#standardSQL

# <title> length

CREATE TEMP FUNCTION analyse(body STRING)
RETURNS STRING
LANGUAGE js AS """

return body.match(/<title>([^<]*)<\\/title>/i);

""";

SELECT
    APPROX_QUANTILES(CHAR_LENGTH(analyse(body)), 1000)[OFFSET(250)] as quantP25TitleLength,
    APPROX_QUANTILES(CHAR_LENGTH(analyse(body)), 1000)[OFFSET(500)] as quantMedianTitleLength,
    APPROX_QUANTILES(CHAR_LENGTH(analyse(body)), 1000)[OFFSET(750)] as quantP75TitleLength,
    AVG(CHAR_LENGTH(analyse(body))) as avgTitleLength
FROM
    `httparchive.almanac.response_bodies_mobile_1k`

/* result: scorePercentage =  0.xxx% */
