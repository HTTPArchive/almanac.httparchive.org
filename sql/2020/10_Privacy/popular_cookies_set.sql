#standardSQL
# Domains setting cookies to most of pages

CREATE TEMPORARY FUNCTION
  cookieNames(headers STRING)
  RETURNS ARRAY<STRING> DETERMINISTIC
  LANGUAGE js AS '''
try {
  var headers = JSON.parse(headers);
  let cookies = headers.filter(h => h.name.match(/set-cookie/i));
  cookieNames = cookies.map(h => {
    cookieSplit = h.value.split('=')
    name = cookieSplit.length>1 ? cookieSplit[0] : null;
    return name;
  })
  return cookieNames;
} catch (e) {
  return null;
}
''';

SELECT
  request_domain,
  ARRAY_AGG(DISTINCT cookies IGNORE NULLS) AS cookie_names,
  COUNT(DISTINCT page) AS pages_count,
FROM (
  SELECT
    page,
    NET.REG_DOMAIN(url) request_domain,
    cookieNames(JSON_EXTRACT(payload,
        '$.response.headers')) AS cookieNames,
  FROM
    `httparchive.almanac.requests_desktop_1k`
  GROUP BY
  page,
  url,
  payload
  having cookieNames IS NOT NULL),
  UNNEST (cookieNames) AS cookie_names
GROUP BY
  request_domain
HAVING
  cookie_names IS NOT NULL
ORDER BY
  pages_count DESC