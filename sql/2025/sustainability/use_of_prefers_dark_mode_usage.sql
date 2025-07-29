#standardSQL

WITH combined_data AS (
  SELECT
    client,
    page,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages,
    SUM(
      CASE
        WHEN EXISTS (
        SELECT 1
        FROM
        UNNEST(
            JSON_EXTRACT_ARRAY(css, '$.stylesheet.rules')
        ) AS rule
        WHERE JSON_EXTRACT_SCALAR(rule, '$.type') = 'media' AND
        JSON_EXTRACT_SCALAR(
            rule, '$.media'
        ) = '(prefers-color-scheme:dark)'
    )
    THEN 1
        ELSE 0
      END
    ) OVER (PARTITION BY client, page) AS is_dark_mode_page
  FROM
    `httparchive.crawl.parsed_css`
  WHERE
    date = '2025-06-01'
)

SELECT
  client,
  MAX(total_pages) AS total_pages,
  SUM(is_dark_mode_page) AS pages_using_dark_mode,
  SUM(is_dark_mode_page) / MAX(total_pages) * 100 AS percentage_of_pages
FROM
  combined_data
GROUP BY
  client
ORDER BY
  percentage_of_pages DESC, client ASC;
