#standardSQL
# Section: Cookies - Cookie Age
# Question: Which are the most common Max-Age and Expires cookie attribute values?
# Note: Expensive query could be combined with the other cookie queries to only go over the cookie headers once.
CREATE TEMPORARY FUNCTION getCookieAgeValues(cookie_value STRING, epochOfRequest NUMERIC)
RETURNS STRING DETERMINISTIC
LANGUAGE js AS '''
  const regexMaxAge = new RegExp(/max-age\\s*=\\s*(?<value>-*[0-9]+)/i);
  const regexExpires = new RegExp(/expires\\s*=\\s*(?<value>.*?)(;|$)/i);
  const cookieValues = [cookie_value];
  const result = {
      "maxAge": [],
      "expires": []
  };
  cookieValues.forEach(cookie => {
      let maxAge = null;
      let expires = null;
      if (regexMaxAge.exec(cookie)) {
          maxAge = Number(regexMaxAge.exec(cookie)[1]);
          result["maxAge"].push(maxAge);
      }
      if (regexExpires.exec(cookie)) {
          expires = regexExpires.exec(cookie)[1];
          result["expires"].push(expires);
      }
  });
  return JSON.stringify(result);
''';

WITH max_age_values AS (
  SELECT
    client,
    max_age_value
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS rh,
    UNNEST(JSON_QUERY_ARRAY(getCookieAgeValues(rh.value, INT64(summary.startedDateTime)), '$.maxAge')) AS max_age_value
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    LOWER(rh.name) = 'set-cookie'
),

expires_values AS (
  SELECT
    client,
    expires_value
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS rh,
    UNNEST(JSON_QUERY_ARRAY(getCookieAgeValues(rh.value, INT64(summary.startedDateTime)), '$.expires')) AS expires_value
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    LOWER(rh.name) = 'set-cookie'
),

max_age AS (
  SELECT
    client,
    'max-age' AS type,
    total_cookies_with_max_age AS total,
    COUNT(0) AS freq,
    COUNT(0) / total_cookies_with_max_age AS pct,
    max_age_value AS attribute_value
  FROM
    max_age_values
  JOIN
    (
      SELECT
        client,
        COUNT(0) AS total_cookies_with_max_age
      FROM
        max_age_values
      GROUP BY
        client
    )
  USING (client)
  GROUP BY
    client,
    total,
    attribute_value
  ORDER BY
    freq DESC
  LIMIT 50
),

expires AS (
  SELECT
    client,
    'expires' AS type,
    total_cookies_with_expires AS total,
    COUNT(0) AS freq,
    COUNT(0) / total_cookies_with_expires AS pct,
    expires_value AS attribute_value
  FROM
    expires_values
  JOIN
    (
      SELECT
        client,
        COUNT(0) AS total_cookies_with_expires
      FROM
        expires_values
      GROUP BY
        client
    )
  USING (client)
  GROUP BY
    client,
    total,
    attribute_value
  ORDER BY
    freq DESC
  LIMIT 50
)

SELECT *
FROM
  max_age
UNION ALL
SELECT *
FROM
  expires
ORDER BY
  client,
  type,
  freq DESC
