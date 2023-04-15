#standardSQL
# 02_45: Distribution of classes per element
SELECT
  client,
  APPROX_QUANTILES(classes, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(classes, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(classes, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(classes, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(classes, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    ARRAY_LENGTH(SPLIT(value, ' ')) AS classes
  FROM
    `httparchive.almanac.summary_response_bodies`,
    UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)class=[\'"]([^\'"]+)')) AS value
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
GROUP BY
  client
