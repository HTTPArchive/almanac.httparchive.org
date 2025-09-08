#standardSQL
-- Pages with search input (formatted percentages)

CREATE TEMPORARY FUNCTION hasSearchInput(almanac_str STRING)
RETURNS BOOL
LANGUAGE js AS r'''
  try {
    const almanac = JSON.parse(almanac_str || '{}');
    const nodes = almanac?.input_elements?.nodes;
    if (!Array.isArray(nodes)) return false;

    return nodes.some((node) => {
      const type = String(node?.type || '').toLowerCase();
      const ph   = String(node?.placeholder || '');
      if (type === 'search') return true;
      if (type === 'text' && /^\s*search(\s|$)/i.test(ph)) return true;
      return false;
    });
  } catch (_) {
    return false;
  }
''';

WITH base AS (
  SELECT
    client,
    is_root_page,
    COALESCE(
      TO_JSON_STRING(custom_metrics.other.almanac),   -- 2025 location
      JSON_EXTRACT_SCALAR(payload, '$._almanac')      -- legacy fallback
    ) AS almanac_str
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)
  WHERE date = DATE '2025-07-01'
),
flags AS (
  SELECT
    client,
    is_root_page,
    SAFE_CAST(JSON_VALUE(almanac_str, '$.input_elements.total') AS INT64) > 0 AS has_inputs,
    hasSearchInput(almanac_str) AS has_search_input
  FROM base
)
SELECT
  client,
  is_root_page,
  COUNT(*) AS total_sites,
  COUNTIF(has_inputs) AS total_with_inputs,
  COUNTIF(has_search_input) AS total_with_search_input,

  -- Percent of all sites with a search input
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNTIF(has_search_input), COUNT(*))
  ) AS perc_sites_with_search_input,

  -- Among sites that have inputs, percent that have a search input
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNTIF(has_search_input),
                           NULLIF(COUNTIF(has_inputs), 0))
  ) AS perc_input_sites_with_search_input
FROM flags
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
