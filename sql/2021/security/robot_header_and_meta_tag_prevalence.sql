#standardSQL
# Prevalence of X-robots-tag header values and robots meta values.
WITH meta_tags AS (
  SELECT
    client,
    url AS page,
    LOWER(JSON_VALUE(meta_node, '$.content')) AS robots_content
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      url,
      JSON_VALUE(payload, "$._almanac") AS metrics
    FROM
      `httparchive.pages.2021_07_01_*`
    ),
    UNNEST(JSON_QUERY_ARRAY(metrics, "$.meta-nodes.nodes")) meta_node
  WHERE LOWER(JSON_VALUE(meta_node, '$.name')) = "robots"
),

robot_headers AS (
  SELECT
    client,
    url AS page,
    LOWER(JSON_VALUE(response_header, '$.value')) AS robot_header_value
  FROM (
    SELECT
      client,
      url,
      response_headers
    FROM
      `httparchive.almanac.requests`
    WHERE
      firstHtml = TRUE AND
      date = '2021-07-01'
    ),
    UNNEST(JSON_QUERY_ARRAY(response_headers)) AS response_header
  WHERE
    LOWER(JSON_VALUE(response_header, '$.name')) = "x-robots-tag"
),

total_nb_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS total_nb_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    client
)

SELECT
  client,
  total_nb_pages AS total,
  COUNTIF(robots_content IS NOT NULL OR robot_header_value IS NOT NULL) AS count_robots,
  COUNTIF(robots_content IS NOT NULL OR robot_header_value IS NOT NULL) / MIN(total_nb_pages.total_nb_pages) AS pct_robots,
  COUNT(robots_content) AS count_robots_content,
  COUNT(robots_content) / total_nb_pages AS pct_robots_content,
  COUNT(robot_header_value) AS count_robot_header_value,
  COUNT(robot_header_value) / total_nb_pages AS pct_robot_header_value,
  COUNTIF(REGEXP_CONTAINS(robots_content, r'.*noindex.*') OR REGEXP_CONTAINS(robot_header_value, r'.*noindex.*')) AS count_noindex,
  COUNTIF(REGEXP_CONTAINS(robots_content, r'.*noindex.*') OR REGEXP_CONTAINS(robot_header_value, r'.*noindex.*')) / COUNTIF(robots_content IS NOT NULL OR robot_header_value IS NOT NULL) AS pct_noindex,
  COUNTIF(REGEXP_CONTAINS(robots_content, r'.*nofollow.*') OR REGEXP_CONTAINS(robot_header_value, r'.*nofollow.*')) AS count_nofollow,
  COUNTIF(REGEXP_CONTAINS(robots_content, r'.*nofollow.*') OR REGEXP_CONTAINS(robot_header_value, r'.*nofollow.*')) / COUNTIF(robots_content IS NOT NULL OR robot_header_value IS NOT NULL) AS pct_nofollow,
  COUNTIF(REGEXP_CONTAINS(robots_content, r'.*nosnippet.*') OR REGEXP_CONTAINS(robot_header_value, r'.*nosnippet.*')) AS count_nosnippet,
  COUNTIF(REGEXP_CONTAINS(robots_content, r'.*nosnippet.*') OR REGEXP_CONTAINS(robot_header_value, r'.*nosnippet.*')) / COUNTIF(robots_content IS NOT NULL OR robot_header_value IS NOT NULL) AS pct_nosnippet,
  COUNTIF(REGEXP_CONTAINS(robots_content, r'.*noarchive.*') OR REGEXP_CONTAINS(robot_header_value, r'.*noarchive.*')) AS count_noarchive,
  COUNTIF(REGEXP_CONTAINS(robots_content, r'.*noarchive.*') OR REGEXP_CONTAINS(robot_header_value, r'.*noarchive.*')) / COUNTIF(robots_content IS NOT NULL OR robot_header_value IS NOT NULL) AS pct_noarchive
FROM
  meta_tags FULL OUTER JOIN robot_headers USING (client, page)
JOIN
  total_nb_pages
USING (client)
GROUP BY
  client,
  total_nb_pages
ORDER BY
  client
