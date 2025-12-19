#standardSQL
# Define the function outside the WITH clause
CREATE TEMPORARY FUNCTION getAudits(report JSON, category STRING)
RETURNS ARRAY<STRUCT<id STRING, weight INT64, audit_group STRING, title STRING, score INT64>> LANGUAGE js AS '''
  try {
    var auditrefs = report.categories[category].auditRefs;
    var audits = report.audits;
    var results = [];
    for (auditref of auditrefs) {
      results.push({
        id: auditref.id,
        weight: auditref.weight,
        audit_group: auditref.group,
        title: audits[auditref.id].title,  // Keep title, not description
        score: audits[auditref.id].score
      });
    }
    return results;
  } catch (e) {
    return [{}];
  }
''';

# Step 1: Sample the data once and store in a temporary table, then combine with accessibility issues
WITH sampled_data AS (
  SELECT
    page,
    lighthouse,
    technologies
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    lighthouse IS NOT NULL AND
    lighthouse.categories IS NOT NULL AND
    is_root_page
),

top_cms AS (
  SELECT
    t.technology AS cms,
    AVG(CAST(JSON_VALUE(lighthouse.categories.accessibility.score) AS FLOAT64)) AS avg_accessibility_score,
    COUNT(DISTINCT page) AS total_pages,
    RANK() OVER (ORDER BY AVG(CAST(JSON_VALUE(lighthouse.categories.accessibility.score) AS FLOAT64)) DESC) AS rank
  FROM
    sampled_data,
    UNNEST(technologies) AS t,
    UNNEST(t.categories) AS category
  WHERE
    category = 'CMS'
  GROUP BY
    cms
  ORDER BY
    avg_accessibility_score DESC
  LIMIT 1000  -- Limit to top 1000 CMS platforms
),

accessibility_issues AS (
  SELECT
    t.technology AS cms,
    audits.id AS audit_id,
    COUNTIF(audits.score < 1) AS num_pages_with_issue,
    COUNT(0) AS total_pages,  -- Total number of pages
    COUNTIF(audits.score IS NOT NULL) AS total_applicable,  -- Total number of applicable pages
    SAFE_DIVIDE(COUNTIF(audits.score < 1), COUNT(0)) AS pct_pages_with_issue,  -- Revised calculation based on total pages
    APPROX_QUANTILES(audits.weight, 100)[OFFSET(50)] AS median_weight,
    MAX(audits.audit_group) AS audit_group
  FROM
    sampled_data,
    UNNEST(technologies) AS t,
    UNNEST(t.categories) AS category,
    UNNEST(getAudits(lighthouse, 'accessibility')) AS audits
  WHERE
    category = 'CMS' AND
    t.technology IN (SELECT cms FROM top_cms)  -- Filter by top CMS platforms
  GROUP BY
    t.technology,
    audits.id
)

# Step 4: Combine and select top 10 issues per CMS
SELECT
  cms,
  audit_id,
  num_pages_with_issue,
  total_pages,
  total_applicable,
  pct_pages_with_issue,
  median_weight,
  audit_group
FROM
  accessibility_issues
ORDER BY
  cms,
  pct_pages_with_issue DESC,
  median_weight DESC
