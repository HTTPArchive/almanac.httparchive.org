WITH comments AS (
  SELECT
    client,
    INT64(custom_metrics.wpt_bodies.raw_html.comment_count) AS num_comments,
    INT64(custom_metrics.wpt_bodies.raw_html.conditional_comment_count) AS num_conditional_comments
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
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
