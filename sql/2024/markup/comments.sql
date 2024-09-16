WITH comments AS (
  SELECT
    client,
    CAST(JSON_VALUE(JSON_EXTRACT(custom_metrics, '$.wpt_bodies'), '$.raw_html.comment_count') AS INT64) AS num_comments,
    CAST(JSON_VALUE(JSON_EXTRACT(custom_metrics, '$.wpt_bodies'), '$.raw_html.conditional_comment_count') AS INT64) AS num_conditional_comments
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
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
