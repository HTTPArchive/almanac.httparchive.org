#standardSQL
# Count the number of cookies where the Max-Age-attribute, Expires-attribute and real age (Max-Age has precedence) of cookies are negative
CREATE TEMPORARY FUNCTION getCookieAgeValues(headers STRING, epochOfRequest NUMERIC)
RETURNS STRING DETERMINISTIC
LANGUAGE js AS '''
  const regexMaxAge = new RegExp(/max-age\\s*=\\s*(?<value>-*[0-9]+)/i);
  const regexExpires = new RegExp(/expires\\s*=\\s*(?<value>.*?)(;|$)/i);
  const parsed_headers = JSON.parse(headers);
  const cookies = parsed_headers.filter(h => h.name.match(/set-cookie/i));
  const cookieValues = cookies.map(h => h.value);
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
    page,
    NET.HOST(urlShort) AS host,
    getCookieAgeValues(response_headers, startedDateTime) AS values
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01'
),

max_age_values AS (
  SELECT
    client,
    COUNTIF(SAFE_CAST(max_age_value AS NUMERIC) <= 0) AS count_negative_max_age,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total_max_age_cookies,
    COUNT(DISTINCT IF(SAFE_CAST(max_age_value AS NUMERIC) <= 0, page, NULL)) AS num_max_age_pages,
    COUNT(DISTINCT page) AS total_max_age_pages,
    COUNT(DISTINCT IF(SAFE_CAST(max_age_value AS NUMERIC) <= 0, host, NULL)) AS num_max_age_hosts,
    COUNT(DISTINCT host) AS total_max_age_hosts
  FROM age_values,
    UNNEST(JSON_QUERY_ARRAY(values, '$.maxAge')) AS max_age_value
  GROUP BY
    client
  ORDER BY
    client
),

expires_values AS (
  SELECT
    client,
    COUNTIF(SAFE_CAST(expires_value AS NUMERIC) <= 0) AS count_negative_expires,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total_expires_cookies,
    COUNT(DISTINCT IF(SAFE_CAST(expires_value AS NUMERIC) <= 0, page, NULL)) AS num_expires_pages,
    COUNT(DISTINCT page) AS total_expires_pages,
    COUNT(DISTINCT IF(SAFE_CAST(expires_value AS NUMERIC) <= 0, host, NULL)) AS num_expires_hosts,
    COUNT(DISTINCT host) AS total_expires_hosts
  FROM age_values,
    UNNEST(JSON_QUERY_ARRAY(values, '$.expires')) AS expires_value
  GROUP BY
    client
  ORDER BY
    client
),

real_age_values AS (
  SELECT
    client,
    COUNTIF(SAFE_CAST(real_age_value AS NUMERIC) <= 0) AS count_negative_real_age,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total_real_age_cookies,
    COUNT(DISTINCT IF(SAFE_CAST(real_age_value AS NUMERIC) <= 0, page, NULL)) AS num_real_age_pages,
    COUNT(DISTINCT page) AS total_real_age_pages,
    COUNT(DISTINCT IF(SAFE_CAST(real_age_value AS NUMERIC) <= 0, host, NULL)) AS num_real_age_hosts,
    COUNT(DISTINCT host) AS total_real_age_hosts
  FROM age_values,
    UNNEST(JSON_QUERY_ARRAY(values, '$.realAge')) AS real_age_value
  GROUP BY
    client
  ORDER BY
    client
)

SELECT
  client,
  count_negative_max_age,
  count_negative_max_age / total_max_age_cookies AS pct_negative_max_age,
  num_max_age_pages,
  num_max_age_pages / total_max_age_pages AS pct_max_age_pages,
  num_max_age_hosts,
  num_max_age_hosts / total_max_age_hosts AS pct_max_age_hosts,
  count_negative_expires,
  count_negative_expires / total_expires_cookies AS pct_negative_expires,
  num_expires_pages,
  num_expires_pages / total_expires_pages AS pct_expires_pages,
  num_expires_hosts,
  num_expires_hosts / total_expires_hosts AS pct_expires_hosts,
  count_negative_real_age,
  count_negative_real_age / total_real_age_cookies AS pct_negative_real_age,
  num_real_age_pages,
  num_real_age_pages / total_real_age_pages AS pct_real_age_pages,
  num_real_age_hosts,
  num_real_age_hosts / total_real_age_hosts AS pct_real_age_hosts
FROM
  max_age_values
JOIN expires_values
USING (client)
JOIN real_age_values
USING (client)
ORDER BY
  client
