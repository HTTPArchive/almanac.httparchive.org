#standardSQL
-- Web Almanac — Top Lighthouse Accessibility issues by CMS
-- Switch between SAMPLE (default) and LIVE by toggling the `audits_flat` CTE block.

CREATE TEMPORARY FUNCTION getAudits(report_str STRING, category STRING)
RETURNS ARRAY<STRUCT<
  id          STRING,
  weight      FLOAT64,
  audit_group STRING,
  title       STRING,
  score       FLOAT64
>>
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
      score: score
    });
  }
  return out;
} catch (e) {
  return [];
}
""";

WITH
-- ===== SAMPLE (default) — safe, cheap: single-touch TABLESAMPLE =====
-- audits_flat AS (
--   SELECT
--     LOWER(t.technology) AS cms,
--     a.id                AS audit_id,
--     a.weight            AS weight,
--     a.audit_group       AS audit_group,
--     a.score             AS score
--   FROM `httparchive.crawl.pages` AS p
--   TABLESAMPLE SYSTEM (0.01 PERCENT)
--   CROSS JOIN UNNEST(p.technologies) AS t
--   CROSS JOIN UNNEST(t.categories) AS cat
--   CROSS JOIN UNNEST(getAudits(TO_JSON_STRING(p.lighthouse), 'accessibility')) AS a
--   WHERE p.date = DATE '2025-07-01'
--     AND p.lighthouse IS NOT NULL
--     AND TO_JSON_STRING(p.lighthouse) != '{}'
--     AND p.is_root_page
--     AND cat = 'CMS'
-- )

-- ===== LIVE (full) — uncomment block below, comment the SAMPLE block above =====
audits_flat AS (
  SELECT
    LOWER(t.technology) AS cms,
    a.id                AS audit_id,
    a.weight            AS weight,
    a.audit_group       AS audit_group,
    a.score             AS score
  FROM `httparchive.crawl.pages` AS p
  CROSS JOIN UNNEST(p.technologies) AS t
  CROSS JOIN UNNEST(t.categories) AS cat
  CROSS JOIN UNNEST(getAudits(TO_JSON_STRING(p.lighthouse), 'accessibility')) AS a
  WHERE p.date = DATE '2025-07-01'
    AND p.lighthouse IS NOT NULL
    AND TO_JSON_STRING(p.lighthouse) != '{}'
    AND p.is_root_page
    AND cat = 'CMS'
)

, agg AS (
  SELECT
    cms,
    audit_id,
    COUNTIF(score < 1)         AS num_pages_with_issue,
    COUNT(*)                   AS total_pages,
    COUNTIF(score IS NOT NULL) AS total_applicable,
    APPROX_QUANTILES(weight, 100)[OFFSET(50)] AS median_weight,
    MAX(audit_group)           AS audit_group
  FROM audits_flat
  GROUP BY cms, audit_id
)
, ranked AS (
  SELECT
    cms,
    audit_id,
    num_pages_with_issue,
    total_pages,
    total_applicable,
    FORMAT('%.1f%%', 100 * SAFE_DIVIDE(num_pages_with_issue, NULLIF(total_applicable, 0))) AS pct_pages_with_issue,
    median_weight,
    audit_group,
    ROW_NUMBER() OVER (
      PARTITION BY cms
      ORDER BY SAFE_DIVIDE(num_pages_with_issue, NULLIF(total_applicable, 0)) DESC,
               median_weight DESC,
               audit_id
    ) AS rn
  FROM agg
)

-- Final output (one SELECT), matching requested column names/order.
SELECT
  cms,
  audit_id,
  num_pages_with_issue,
  total_pages,
  total_applicable,
  pct_pages_with_issue,
  median_weight,
  audit_group
FROM ranked
ORDER BY cms, rn;
