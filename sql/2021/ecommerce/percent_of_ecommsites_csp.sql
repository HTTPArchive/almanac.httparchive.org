#standardSQL
# count the number of Content-Security-Policy and Content-Security-Policy-Report-Only headers across Ecommerce
CREATE TEMPORARY FUNCTION
hasHeader(headers STRING,
  headername STRING)
RETURNS BOOL DETERMINISTIC
LANGUAGE js AS '''
  const parsed_headers = JSON.parse(headers);
  const matching_headers = parsed_headers.filter(h => h.name.toLowerCase() == headername.toLowerCase());
  return matching_headers.length > 0;
''' ;
SELECT
  client,
  headername,
  COUNT(DISTINCT page) AS total_hosts,
  COUNT(DISTINCT
    IF(hasHeader(headers,
        headername),
      page,
      NULL)) AS num_with_header,
  COUNT(DISTINCT
    IF(hasHeader(headers,
        headername),
      page,
      NULL)) / COUNT(DISTINCT page) AS pct_with_header
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    page,
    JSON_EXTRACT(payload,
      '$.response.headers') AS headers
  FROM
    `httparchive.requests.2021_07_01_*`
  JOIN (
    SELECT DISTINCT
      _TABLE_SUFFIX,
      url
    FROM
      `httparchive.technologies.2021_07_01_*`
    WHERE
      category = 'Ecommerce' AND
      (app != 'Cart Functionality' AND
       app != 'Google Analytics Enhanced eCommerce'))
  USING
    (_TABLE_SUFFIX,
      url) ),
  UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only']) AS headername
GROUP BY
  client,
  headername
ORDER BY
  client,
  headername
