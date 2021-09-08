#standardSQL
# Top 10 values of Max-Age and Expires cookie attributes.
-- SQL Linter cannot handle DETERMINISTIC keyword so needs noqa ignore command on previous line
CREATE TEMPORARY FUNCTION getCookieAgeValues(headers STRING, epochOfRequest NUMERIC)  -- noqa: PRS
  RETURNS STRING DETERMINISTIC
  LANGUAGE js AS '''
  const regexMaxAge = new RegExp(/max-age\\s*=\\s*(?<value>-*[0-9]+)/i);
  const regexExpires = new RegExp(/expires\\s*=\\s*(?<value>.*?)(;|$)/i);
  const parsed_headers = JSON.parse(headers);
  const cookies = parsed_headers.filter(h => h.name.match(/set-cookie/i));
  const cookieValues = cookies.map(h => h.value);
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

WITH age_values AS (
  SELECT
    client,
    getCookieAgeValues(JSON_EXTRACT(payload, '$.response.headers'), startedDateTime) AS values
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = "2021-07-01"
),

max_age_values AS (
SELECT
  client,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_max_age_values,
  COUNT(0) AS max_age_count,
  max_age_value
FROM age_values,
UNNEST(JSON_QUERY_ARRAY(values, "$.maxAge")) AS max_age_value
GROUP BY
  client,
  max_age_value
),

expires_values AS (
SELECT
  client,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_expires_values,
  COUNT(0) AS expires_count,
  expires_value
FROM age_values,
UNNEST(JSON_QUERY_ARRAY(values, "$.expires")) AS expires_value
GROUP BY
  client,
  expires_value
),

desktop_values AS (
  SELECT
    *
  FROM (
    SELECT
      *,
      ROW_NUMBER() OVER (ORDER BY max_age_count DESC) AS row
    FROM
      max_age_values
    WHERE
      client LIKE "%desktop%"
  )
  JOIN
  (
    SELECT
      *,
      ROW_NUMBER() OVER (ORDER BY expires_count DESC) AS row
    FROM
      expires_values
    WHERE
      client LIKE "%desktop%"
  ) USING (client, row)
    ORDER BY
      row
    LIMIT 10
),

mobile_values AS (
  SELECT *
  FROM (
    SELECT
      *,
      ROW_NUMBER() OVER (ORDER BY max_age_count DESC) AS row
    FROM
      max_age_values
    WHERE
      client LIKE "%mobile%"
  )
  JOIN
  (
    SELECT
      *,
      ROW_NUMBER() OVER (ORDER BY expires_count DESC) AS row
    FROM
      expires_values
    WHERE
      client LIKE "%mobile%"
  ) USING (client, row)
    ORDER BY
      row
    LIMIT 20
)

SELECT
  *
FROM
  desktop_values UNION DISTINCT (SELECT * FROM mobile_values)
ORDER BY
  client
