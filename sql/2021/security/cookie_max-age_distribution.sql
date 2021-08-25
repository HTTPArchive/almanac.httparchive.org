#standardSQL
# Distribution of the Max-Age cookie attribute in Set-Cookie headers
-- SQL Linter cannot handle DETERMINISTIC keyword so needs noqa ignore command on previous line
CREATE TEMPORARY FUNCTION getSetCookieMaxAge(headers STRING)  -- noqa: PRS
  RETURNS ARRAY<NUMERIC> DETERMINISTIC
  LANGUAGE js AS '''
  const regex = new RegExp(/max-age=(?<value>-*[0-9]+)/i);
  const parsed_headers = JSON.parse(headers);
  const cookies = parsed_headers.filter(h => h.name.match(/set-cookie/i));
  const cookieValues = cookies.map(h => h.value);
  maxAgeValues = cookieValues.map(cookie => regex.exec(cookie) ? regex.exec(cookie)[1] : null);
  return maxAgeValues;
''';

SELECT
    client,
    percentile,
    APPROX_QUANTILES(max_age_value, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS max_age
FROM (
        SELECT
            client,
            GETSETCOOKIEMAXAGE(
                JSON_EXTRACT(payload, '$.response.headers')
            ) AS max_age_values
  FROM
    `httparchive.sample_data.requests`
        WHERE
            date = "2021-07-01"
),
UNNEST(max_age_values) as max_age_value,
UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
    percentile,
    client
ORDER BY
    percentile,
    client
