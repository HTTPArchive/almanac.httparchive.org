#standardSQL
-- Web Almanac — Lighthouse Accessibility audits summary
--
-- Flattens Lighthouse audits for the "accessibility" category per {client, is_root_page}.
-- Counts pages with score > 0 (passing), total applicable pages (score IS NOT NULL).
-- Outputs counts + formatted percentage, with median audit weight and audit metadata.
--
-- ===== SWITCH TARGET HERE =====================================================
-- In `src_base`, keep the SAMPLE block for smoke tests, or switch to the LIVE block.
-- ============================================================================

CREATE TEMPORARY FUNCTION getAudits(report_str STRING, category STRING)
RETURNS ARRAY<
  STRUCT<
    id           STRING,
    weight       FLOAT64,
    audit_group  STRING,
    title        STRING,
    description  STRING,
    score        FLOAT64
  >
>
LANGUAGE js AS r"""
try {
  const lhr = JSON.parse(report_str || "{}");
  const cat = (lhr.categories && lhr.categories[category]) ? lhr.categories[category] : null;
  const refs = (cat && Array.isArray(cat.auditRefs)) ? cat.auditRefs : [];
  const audits = (lhr.audits && typeof lhr.audits === "object") ? lhr.audits : {};

  const out = [];
  for (const ref of refs) {
    const id = ref && ref.id ? String(ref.id) : null;
    if (!id) continue;

    const a = audits[id] || {};
    const score  = (typeof a.score === "number") ? a.score : null;   // 0..1 or null
    const weight = (typeof ref.weight === "number") ? ref.weight : 0;

    out.push({
      id: id,
      weight: weight,
      audit_group: (ref && ref.group) ? String(ref.group) : null,
      title: (a && a.title) ? String(a.title) : null,
      description: (a && a.description) ? String(a.description) : null,
      score: score
    });
  }
  return out;
} catch (e) {
  return [];
}
""";

WITH
-- ===== choose ONE of the two blocks below =====
src_base AS (
  -- SAMPLE (default): cheap, fast
  -- SELECT client, is_root_page, lighthouse
  -- FROM `httparchive.sample_data.pages_10k`
  -- WHERE lighthouse IS NOT NULL
  --   AND TO_JSON_STRING(lighthouse) != '{}'

  -- LIVE (full scan with partition filter) — uncomment next 5 lines and comment out the SAMPLE block
  SELECT client, is_root_page, lighthouse
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'
    AND lighthouse IS NOT NULL
    AND TO_JSON_STRING(lighthouse) != '{}'
),
audits_flat AS (
  SELECT
    b.client,
    b.is_root_page,
    a.id,
    a.weight,
    a.audit_group,
    a.title,
    a.description,
    a.score
  FROM src_base AS b
  CROSS JOIN UNNEST(getAudits(TO_JSON_STRING(b.lighthouse), 'accessibility')) AS a
),
agg AS (
  SELECT
    client,
    is_root_page,
    id,
    COUNTIF(score > 0)            AS num_pages,
    COUNT(*)                      AS total,
    COUNTIF(score IS NOT NULL)    AS total_applicable,
    APPROX_QUANTILES(weight, 100)[OFFSET(50)] AS median_weight,
    MAX(audit_group)              AS audit_group,
    MAX(description)              AS description
  FROM audits_flat
  GROUP BY client, is_root_page, id
)

-- Final output (single SELECT)
SELECT
  client,
  is_root_page,
  id,
  num_pages,
  total,
  total_applicable,
  FORMAT('%.0f%%', 100 * SAFE_DIVIDE(num_pages, NULLIF(total_applicable, 0))) AS pct,
  median_weight,
  audit_group,
  description
FROM agg
ORDER BY client, is_root_page, median_weight DESC, id;
