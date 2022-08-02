WITH comments AS (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_VALUE(JSON_VALUE(payload, '$._wpt_bodies'), '$.raw_html.comment_count') AS INT64) AS num_comments,
    CAST(JSON_VALUE(JSON_VALUE(payload, '$._wpt_bodies'), '$.raw_html.conditional_comment_count') AS INT64) AS num_conditional_comments
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  COUNTIF(num_comments > 0) AS num_comments,
  COUNTIF(num_conditional_comments > 0) AS num_conditional_comments,
  COUNT(0) AS total,
  COUNTIF(num_comments > 0) / COUNT(0) AS pct_comments,
  COUNTIF(num_conditional_comments > 0) / COUNT(0) AS pct_conditional_comments
FROM
  comments
GROUP BY
  client
