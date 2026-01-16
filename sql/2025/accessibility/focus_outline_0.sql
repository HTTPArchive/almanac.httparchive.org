#standardSQL
# Web Almanac — Adoption of :focus pseudoclass and outline: 0 style (2025-07-01)
# Google Sheet: focus_outline_0
#
# Purpose
#   • Measure how many pages define custom styles for the :focus pseudoclass.
#   • Identify how often those styles also disable focus outlines with `outline: 0`.
#
# Method
#   1. Read parsed CSS JSON from `httparchive.crawl.parsed_css`.
#   2. Extract top-level rules and one level of nested rules (@media etc.) using
#        JSON_QUERY_ARRAY(css, '$.stylesheet.rules') and UNION ALL.
#   3. For each page:
#        - sets_focus_style      = TRUE if any selector includes ":focus"
#        - sets_focus_outline_0  = TRUE if any :focus rule declares "outline: 0"
#   4. Aggregate to count pages per {client}, then join with total page counts
#      from `httparchive.crawl.pages`.
#   5. Compute percentages of pages that set focus styles or set outline: 0.
#
# Output columns
#   client                   — "desktop" | "mobile"
#   pages_focus              — number of pages with a :focus style
#   pages_focus_outline_0    — number of pages with :focus + outline: 0
#   total_pages              — total distinct pages per client
#   pct_pages_focus          — fraction of pages with :focus style
#   pct_pages_focus_outline_0 — fraction with :focus + outline: 0
#
# Key change from 2024 query
#   • Removed the JavaScript UDF (getFocusStylesOutline0) that parsed CSS via
#     an external library (css-utils.js).
#   • Replaced with native BigQuery JSON functions:
#       - JSON_QUERY_ARRAY() to iterate rules, selectors, and declarations.
#       - JSON_VALUE() to extract scalar strings for LIKE and equality checks.
#   • This makes the query cheaper, more portable, and avoids row-by-row JS.
#   • Query structure (focus_data, total_pages_data, final SELECT) is preserved
#     to mirror the 2024 original for comparability.
WITH rules AS (
  -- Top-level rules
  SELECT
    client,
    page,
    JSON_QUERY_ARRAY(css, '$.stylesheet.rules') AS rules
  FROM
    `httparchive.crawl.parsed_css`
  -- `httparchive.sample_data.parsed_css_10k`
  WHERE date = DATE '2025-07-01' -- Comment out with `httparchive.sample_data.parsed_css_10k`

  UNION ALL

  -- One nested level (e.g. @media)
  SELECT
    client,
    page,
    JSON_QUERY_ARRAY(parent_rule, '$.rules') AS rules
  FROM
    `httparchive.crawl.parsed_css`
  -- `httparchive.sample_data.parsed_css_10k`
  CROSS JOIN UNNEST(JSON_QUERY_ARRAY(css, '$.stylesheet.rules')) AS parent_rule
  WHERE
    JSON_TYPE(JSON_QUERY(parent_rule, '$.rules')) = 'array' AND
    date = DATE '2025-07-01' -- Comment out with `httparchive.sample_data.parsed_css_10k`

),

focus_data AS (
  SELECT
    t.client,
    t.page,

    -- any rule with a :focus selector
    MAX(
      EXISTS (
        SELECT 1
        FROM UNNEST(t.rules) AS r,
          UNNEST(JSON_QUERY_ARRAY(r, '$.selectors')) AS sel
        WHERE JSON_VALUE(sel) LIKE '%:focus%'           -- CHANGED
      )
    ) AS sets_focus_style,

    -- any :focus rule that also declares outline: 0
    MAX(
      EXISTS (
        SELECT 1
        FROM UNNEST(t.rules) AS r
        WHERE EXISTS (
            SELECT 1
            FROM UNNEST(JSON_QUERY_ARRAY(r, '$.selectors')) AS sel
            WHERE JSON_VALUE(sel) LIKE '%:focus%'   -- CHANGED
          ) AND
          EXISTS (
            SELECT 1
            FROM UNNEST(JSON_QUERY_ARRAY(r, '$.declarations')) AS d
            WHERE LOWER(JSON_VALUE(d, '$.property')) = 'outline' AND
              TRIM(JSON_VALUE(d, '$.value')) = '0'
          )
      )
    ) AS sets_focus_outline_0
  FROM rules AS t
  GROUP BY t.client, t.page
),

total_pages_data AS (
  SELECT client, COUNT(0) AS total_pages
  FROM
    `httparchive.crawl.pages`
  -- `httparchive.sample_data.pages_10k`
  WHERE date = DATE '2025-07-01' -- Comment out with `httparchive.sample_data.parsed_css_10k`
  GROUP BY client
)

SELECT
  f.client,
  COUNTIF(f.sets_focus_style) AS pages_focus,
  COUNTIF(f.sets_focus_outline_0) AS pages_focus_outline_0,
  tp.total_pages,
  COUNTIF(f.sets_focus_style) / tp.total_pages AS pct_pages_focus,
  COUNTIF(f.sets_focus_outline_0) / tp.total_pages AS pct_pages_focus_outline_0
FROM
  focus_data AS f
JOIN
  total_pages_data AS tp
ON f.client = tp.client
GROUP BY
  f.client, tp.total_pages
ORDER BY
  pct_pages_focus DESC;
