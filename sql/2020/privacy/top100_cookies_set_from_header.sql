#standardSQL
# Top100 popular cookies and their origins

CREATE TEMPORARY FUNCTION cookieNames(headers STRING) -- noqa: PRS
-- SQL Linter cannot handle DETERMINISTIC keyword so needs noqa ignore command on previous line
RETURNS ARRAY<STRING>
DETERMINISTIC
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

WITH request_headers AS (
  SELECT
    _TABLE_SUFFIX AS client,
    page,
    NET.REG_DOMAIN(url) AS request,
    cookieNames(JSON_EXTRACT(payload, '$.response.headers')) AS cookie_names,
    COUNT(0) OVER (PARTITION BY _TABLE_SUFFIX) AS websites_per_client
  FROM
    `httparchive.requests.2020_08_01_*`
  GROUP BY
    client,
    page,
    url,
    payload
),

cookies AS (
  SELECT
    client,
    request,
    cookie,
    COUNT(DISTINCT page) AS websites_count,
    COUNT(DISTINCT page) / ANY_VALUE(websites_per_client) AS pct_websites
  FROM request_headers,
    UNNEST(cookie_names) AS cookie
  WHERE
    cookie IS NOT NULL AND
    cookie != ""
  GROUP BY
    client,
    request,
    cookie
)

SELECT
  client,
  request,
  cookie,
  websites_count,
  pct_websites
FROM cookies
ORDER BY
  websites_count DESC
LIMIT 100
