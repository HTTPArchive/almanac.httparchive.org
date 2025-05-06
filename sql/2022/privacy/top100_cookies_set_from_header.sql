#standardSQL
# Top100 popular cookies and their origins

CREATE TEMPORARY FUNCTION cookieNames(headers STRING)
RETURNS ARRAY<STRING> DETERMINISTIC
LANGUAGE js AS '''
try {
  var headers = JSON.parse(headers);
  let cookies = headers.filter(h => h.name.match(/^set-cookie$/i));
  cookieNames = cookies.map(h => {
    name = h.value.split('=')[0]
    return name;
  })
  return cookieNames;
} catch (e) {
  return null;
}
''';

WITH whotracksme AS (
  SELECT
    domain,
    category,
    tracker
  FROM
    `httparchive.almanac.whotracksme`
  WHERE
    date = '2022-06-01'
),

request_headers AS (
  SELECT
    client,
    page,
    NET.REG_DOMAIN(url) AS request,
    cookieNames(response_headers) AS cookie_names,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS websites_per_client
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01'
  GROUP BY
    client,
    page,
    url,
    response_headers
),

cookies AS (
  SELECT
    client,
    request,
    cookie,
    COUNT(DISTINCT page) AS websites_count,
    websites_per_client,
    COUNT(DISTINCT page) / websites_per_client AS pct_websites
  FROM
    request_headers,
    UNNEST(cookie_names) AS cookie
  WHERE
    cookie IS NOT NULL AND
    cookie != ''
  GROUP BY
    client,
    request,
    cookie,
    websites_per_client
)

SELECT
  *
FROM (
  SELECT
    client,
    whotracksme.category,
    request,
    cookie,
    cookie || ' - ' || request AS cookie_and_request,
    websites_count,
    websites_per_client,
    pct_websites,
    RANK() OVER (PARTITION BY client, category ORDER BY pct_websites DESC) AS rank
  FROM
    cookies
  LEFT JOIN
    whotracksme
  ON NET.HOST(request) = domain
  ORDER BY
    pct_websites DESC,
    client
)
WHERE rank <= 10
