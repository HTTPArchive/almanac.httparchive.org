#standardSQL
# Section: Well-know URIs - robots.txt (?)
# Question: What is the prevalence of /robots.txt and what is the prevalence of potentially sensitive endpoints in disallow directives ('login', 'log-in', 'signin', 'sign-in', 'admin', 'auth', 'sso', 'account')
CREATE TEMPORARY FUNCTION getAllDisallowedEndpoints(data STRING)
RETURNS ARRAY<STRING> DETERMINISTIC
LANGUAGE js AS '''
  let parsed_data;
  try {
    parsed_data = JSON.parse(data);
  } catch (e) {
      return [];
  }
  if (parsed_data == null || parsed_data["/robots.txt"] == undefined || !parsed_data["/robots.txt"]["found"]) {
      return [];
  }
  const parsed_endpoints = parsed_data["/robots.txt"]["data"]["matched_disallows"];
  const endpoints_list = Object.keys(parsed_endpoints).map(key => parsed_endpoints[key]).flat();
  return Array.from(new Set(endpoints_list));
''';

SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT(CASE WHEN has_robots_txt = 'true' THEN page END)) AS count_robots_txt,
  COUNT(DISTINCT(CASE WHEN has_robots_txt = 'true' THEN page END)) / COUNT(DISTINCT page) AS pct_robots_txt,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/admin/.*') THEN page END)) AS count_disallow_admin,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/admin/.*') THEN page END)) / COUNT(DISTINCT(CASE WHEN has_robots_txt = 'true' THEN page END)) AS pct_disallow_admin,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/log-*in/.*') THEN page END)) AS count_disallow_login,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/log-*in/.*') THEN page END)) / COUNT(DISTINCT(CASE WHEN has_robots_txt = 'true' THEN page END)) AS pct_disallow_login,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/sign-*in/.*') THEN page END)) AS count_disallow_signin,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/sign-*in/.*') THEN page END)) / COUNT(DISTINCT(CASE WHEN has_robots_txt = 'true' THEN page END)) AS pct_disallow_signin,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/auth./*') THEN page END)) AS count_disallow_auth,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/auth/.*') THEN page END)) / COUNT(DISTINCT(CASE WHEN has_robots_txt = 'true' THEN page END)) AS pct_disallow_auth,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/sso/.*') THEN page END)) AS count_disallow_sso,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/sso/.*') THEN page END)) / COUNT(DISTINCT(CASE WHEN has_robots_txt = 'true' THEN page END)) AS pct_disallow_sso,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/account/.*') THEN page END)) AS count_disallow_account,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(disallowed_endpoint, r'.*/account/.*') THEN page END)) / COUNT(DISTINCT(CASE WHEN has_robots_txt = 'true' THEN page END)) AS pct_disallow_account
FROM
  (
    SELECT
      client,
      page,
      JSON_VALUE(JSON_VALUE(payload, '$._well-known'), '$."/robots.txt".found') AS has_robots_txt,
      getAllDisallowedEndpoints(JSON_VALUE(payload, '$._well-known')) AS disallowed_endpoints
    FROM
      `httparchive.all.pages`
    WHERE
      date = '2024-06-01' AND
      is_root_page
  )
LEFT JOIN UNNEST(disallowed_endpoints) AS disallowed_endpoint
GROUP BY
  client
