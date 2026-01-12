#standardSQL
# Section: Cookies - Cookie Age
# Question: How long are cookies valid? (Max-Age, Expires, Real Age)
# Note: Only incorporates values that are larger than 0; cookies set over all all requests on the root_page
# Note: Could be combined with the other cookie queries to run the expensive response_header unnesting only once?
CREATE TEMPORARY FUNCTION getCookieAgeValues(cookie_value STRING, epochOfRequest NUMERIC)
RETURNS STRING DETERMINISTIC
LANGUAGE js AS '''
  const regexMaxAge = new RegExp(/max-age\\s*=\\s*(?<value>-*[0-9]+)/i);
  const regexExpires = new RegExp(/expires\\s*=\\s*(?<value>.*?)(;|$)/i);
  const cookieValues = [cookie_value];
  const result = {
      "maxAge": [],
      "expires": [],
      "realAge": []
  };
  cookieValues.forEach(cookie => {
      let maxAge = null;
      let expires = null;
      if (regexMaxAge.exec(cookie)) {
          maxAge = Number(regexMaxAge.exec(cookie)[1]);
          result["maxAge"].push(maxAge);
      }
      if (regexExpires.exec(cookie)) {
          expires = Math.round(Number(new Date(regexExpires.exec(cookie)[1])) / 1000) - epochOfRequest;
          result["expires"].push(Number.isSafeInteger(expires) ? expires : null);
      }
      if (maxAge) {
          result["realAge"].push(maxAge);
      } else if (expires) {
          result["realAge"].push(expires);
      }
  });
  return JSON.stringify(result);
''';

WITH age_values AS (
  SELECT
    client,
    getCookieAgeValues(response_headers.value, UNIX_SECONDS(TIMESTAMP(STRING(payload.startedDateTime)))) AS values
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    LOWER(response_headers.name) = 'set-cookie'
),

max_age_values AS (
  SELECT
    client,
    percentile,
    APPROX_QUANTILES(SAFE_CAST(max_age_value AS NUMERIC), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS max_age
  FROM age_values,
    UNNEST(JSON_QUERY_ARRAY(values, '$.maxAge')) AS max_age_value,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  WHERE
    SAFE_CAST(max_age_value AS NUMERIC) > 0
  GROUP BY
    percentile,
    client
  ORDER BY
    percentile,
    client
),

expires_values AS (
  SELECT
    client,
    percentile,
    APPROX_QUANTILES(SAFE_CAST(expires_value AS NUMERIC), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS expires
  FROM age_values,
    UNNEST(JSON_QUERY_ARRAY(values, '$.expires')) AS expires_value,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  WHERE
    SAFE_CAST(expires_value AS NUMERIC) > 0
  GROUP BY
    percentile,
    client
  ORDER BY
    percentile,
    client
),

real_age_values AS (
  SELECT
    client,
    percentile,
    APPROX_QUANTILES(SAFE_CAST(real_age_value AS NUMERIC), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS real_age
  FROM age_values,
    UNNEST(JSON_QUERY_ARRAY(values, '$.realAge')) AS real_age_value,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  WHERE
    SAFE_CAST(real_age_value AS NUMERIC) > 0
  GROUP BY
    percentile,
    client
  ORDER BY
    percentile,
    client
)

SELECT
  client,
  percentile,
  max_age,
  expires,
  real_age
FROM
  max_age_values
JOIN expires_values
USING (client, percentile)
JOIN real_age_values
USING (client, percentile)
ORDER BY
  client,
  percentile
