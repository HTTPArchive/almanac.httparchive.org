#standardSQL
# - average of stylesheet comments per page, per year
# - maximum of stylesheet comments per page, per year
CREATE TEMPORARY FUNCTION getComments(css STRING)
RETURNS INT64
LANGUAGE js
AS '''

try {
  if (css === null)
    return 0;

  const comments = css.match(/\\/\\*.*?\\*\\//g);
  if (comments === null)
    return 0;
  else
    return comments.length;
} catch (e) {
  return null;
}
''';

WITH
basedata AS (
  SELECT
    EXTRACT(YEAR FROM `date`) AS report_year,
    page,
    getComments(response_body) AS comments
  FROM
    `httparchive.crawl.requests` TABLESAMPLE SYSTEM (0.01 PERCENT)
  WHERE
    `date` IN ('2025-07-01', '2024-07-01', '2023-07-01', '2022-07-01', '2021-07-01', '2020-07-01', '2019-07-01') AND
    type = 'css'
),

per_page AS (
  SELECT
    report_year,
    page,
    SUM(comments) AS comments
  FROM basedata
  GROUP BY
    report_year, page
)

SELECT
  report_year,
  AVG(comments) AS avg_comments,
  MAX(comments) AS max_comments
FROM
  per_page
GROUP BY
  report_year
ORDER BY
  report_year;
