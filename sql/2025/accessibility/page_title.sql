#standardSQL
/********************************************************************************************
 Page title stats (usage, descriptiveness, stability)
 --------------------------------------------------------------------------------------------
 What this query does
   • Counts how many pages have <title>, how many titles have ≥4 words,
     and how many titles changed between initial HTML and rendered DOM.
   • Groups results by {client, is_root_page}.
   • Outputs both absolute counts and percentages, aligned with the 2024 table structure.

 Data sources
   • httparchive.crawl.pages
   • custom_metrics.wpt_bodies.title.* fields:
       - rendered.primary.words              → word count in final rendered <title>
       - title_changed_on_render (boolean)  → whether the <title> changed

 How to run
   • Default is limited by `rank = 1000` for cheap smoke tests.
   • Remove that filter for the full crawl.
********************************************************************************************/

SELECT
  client,
  is_root_page,

  COUNT(*) AS total_sites,

  COUNTIF(total_title_words > 0) AS total_has_title,
  COUNTIF(total_title_words > 3) AS total_title_with_four_or_more_words,
  COUNTIF(title_changed_on_render) AS total_title_changed,

  -- Percentages (formatted)
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(total_title_words > 0), COUNT(*)))
    AS pct_with_title,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(total_title_words > 3),
                                     NULLIF(COUNTIF(total_title_words > 0),0)))
    AS pct_titles_four_or_more_words,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(title_changed_on_render),
                                     NULLIF(COUNTIF(total_title_words > 0),0)))
    AS pct_titles_changed_on_render

FROM (
  SELECT
    client,
    is_root_page,
    SAFE_CAST(JSON_EXTRACT_SCALAR(custom_metrics.wpt_bodies.title.title_changed_on_render) AS BOOL)
      AS title_changed_on_render,
    SAFE_CAST(JSON_EXTRACT_SCALAR(custom_metrics.wpt_bodies.title.rendered.primary.words) AS INT64)
      AS total_title_words
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
    -- AND rank = 1000   -- remove for full dataset
)
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
