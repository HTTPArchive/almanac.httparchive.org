#standardSQL
# Web Almanac — % of pages with a valid <html lang> (Lighthouse)
#
# Purpose
#   Quantify language metadata quality using Lighthouse audits:
#     • html-has-lang: page declares a lang attribute on <html>
#     • html-lang-valid: declared lang value is syntactically valid
#   Report counts and percentages by {client, is_root_page}.
#
# Data
#   Table:  httparchive.crawl.pages
#   Date:   2025-07-01
#   Field:  lighthouse (JSON-typed). Keys contain hyphens → use bracketed JSON paths.
#
# Metrics (per group)
#   total                  — total pages
#   has_lang               — pages passing html-has-lang (score == 1)
#   valid_lang             — pages passing html-lang-valid (score == 1)
#   pct_has_of_total       — has_lang / total   (formatted, e.g. "86.9%")
#   pct_valid_of_total     — valid_lang / total (formatted)
#   pct_valid_of_has_lang  — valid_lang / has_lang (formatted)
#
WITH src AS (
  SELECT
    client,
    is_root_page,
    CAST(JSON_VALUE(lighthouse, '$."audits"."html-has-lang"."score"') AS FLOAT64) = 1 AS has_lang,
    CAST(JSON_VALUE(lighthouse, '$."audits"."html-lang-valid"."score"') AS FLOAT64) = 1 AS valid_lang
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)  -- enable for cheap tests only
  WHERE
    date = DATE '2025-07-01'
    AND lighthouse IS NOT NULL
    AND JSON_TYPE(lighthouse) = 'object'
)
SELECT
  client,
  is_root_page,
  COUNT(*) AS total,
  COUNTIF(valid_lang) AS valid_lang,
  COUNTIF(has_lang) AS has_lang,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(has_lang),  COUNT(*)))                     AS pct_has_of_total,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(valid_lang), COUNT(*)))                     AS pct_valid_of_total,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(valid_lang), NULLIF(COUNTIF(has_lang), 0))) AS pct_valid_of_has_lang  -- was "has_lang / valid_lang" in 2024
FROM src
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
