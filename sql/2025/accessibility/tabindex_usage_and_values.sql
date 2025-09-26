#standardSQL
/********************************************************************************************
 Positive tabindex value occurrences (page-level prevalence)
 --------------------------------------------------------------------------------------------
 What this query does
   • For each page, counts elements with numeric `tabindex`, split by sign: >0, =0, <0.
   • Aggregates by (client, is_root_page) and reports totals & percentages, comparable to 2024.

 Data sources & JSON paths (two places the same info can live)
   • Preferred:  custom_metrics.other.almanac["09.27"].nodes
   • Fallback :  payload._almanac  (stringified JSON)

 How to run
   1) Toggle SAMPLE vs LIVE in the `src` CTE (comment/uncomment).
   2) For LIVE, set the `date`. Optionally enable the rank-based deterministic sampler.

 Notes
   • BigQuery StandardSQL does not support TABLESAMPLE; use the provided FARM_FINGERPRINT sampler.
   • Only finite numeric tabindex values are counted; non-numeric or missing values are ignored.
********************************************************************************************/

-- JS UDF: given a STRINGified almanac JSON, count tabindex buckets.
CREATE TEMP FUNCTION getTabindexStats(almanac_json STRING)
RETURNS STRUCT<
  total INT64,
  total_positive INT64,
  total_negative INT64,
  total_zero INT64
>
LANGUAGE js AS '''
try {
  const root = JSON.parse(almanac_json || '{}');
  const ala = root.almanac ? root.almanac : root;          // support both layouts
  const branch = (ala && ala['09.27']) ? ala['09.27'] : {};
  const nodes = Array.isArray(branch.nodes) ? branch.nodes : [];

  let total = 0, total_positive = 0, total_negative = 0, total_zero = 0;

  for (const node of nodes) {
    const n = Number(node && node.tabindex);
    if (!Number.isFinite(n)) continue;
    total++;
    if (n > 0) total_positive++;
    else if (n < 0) total_negative++;
    else total_zero++;
  }

  return { total, total_positive, total_negative, total_zero };
} catch (e) {
  return { total: 0, total_positive: 0, total_negative: 0, total_zero: 0 };
}
''';

WITH src AS (
  /* ========================== SAMPLE (fast/dev) ==========================
  SELECT
    client,
    is_root_page,
    payload,
    custom_metrics.other AS cm_other,
    rank
  FROM `httparchive.sample_data.pages_10k`
  */

  /* =========================== LIVE (full crawl) ========================  */
  SELECT
    client,
    is_root_page,
    payload,
    custom_metrics.other AS cm_other,
    rank
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'
    -- Optional deterministic ~0.1% sampler for quick smoke tests:
    -- AND MOD(ABS(FARM_FINGERPRINT(CAST(rank AS STRING))), 1000) = 0
),

-- Normalize to ONE STRING that the UDF can parse (make all CASE arms STRING).
norm AS (
  SELECT
    client,
    is_root_page,
    CASE
      WHEN JSON_QUERY(cm_other, '$.almanac') IS NOT NULL
        THEN TO_JSON_STRING(JSON_QUERY(cm_other, '$.almanac'))           -- STRING
      WHEN JSON_EXTRACT(payload, '$._almanac') IS NOT NULL
        THEN TO_JSON_STRING(JSON_EXTRACT(payload, '$._almanac'))          -- STRING
      ELSE '{}'
    END AS almanac_json_str
  FROM src
),

per_page AS (
  SELECT
    client,
    is_root_page,
    getTabindexStats(almanac_json_str) AS tab_index_stats
  FROM norm
)

SELECT
  client,
  is_root_page,
  COUNT(*) AS total_sites,
  COUNTIF(tab_index_stats.total > 0)          AS total_with_tab_indexes,
  COUNTIF(tab_index_stats.total_positive > 0) AS total_with_positive_tab_indexes,
  COUNTIF(tab_index_stats.total_negative > 0) AS total_with_negative_tab_indexes,
  COUNTIF(tab_index_stats.total_zero > 0)     AS total_with_zero_tab_indexes,
  COUNTIF(tab_index_stats.total_negative > 0 OR tab_index_stats.total_zero > 0)
    AS total_with_negative_or_zero,
  SAFE_DIVIDE(COUNTIF(tab_index_stats.total > 0),          COUNT(*)) AS pct_with_tab_indexes,
  SAFE_DIVIDE(COUNTIF(tab_index_stats.total_positive > 0), COUNT(*)) AS pct_with_positive_tab_indexes,
  SAFE_DIVIDE(
    COUNTIF(tab_index_stats.total_positive > 0),
    NULLIF(COUNTIF(tab_index_stats.total > 0), 0)
  ) AS pct_positive_in_sites_with_tab_indexes
FROM per_page
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
