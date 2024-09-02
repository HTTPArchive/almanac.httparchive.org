#standardSQL
# Calculate average Lighthouse scores and the number of pages for government-related domains

WITH score_data AS (
  SELECT
    client,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.performance.score') AS FLOAT64) AS performance_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS accessibility_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.best-practices.score') AS FLOAT64) AS best_practices_score, 
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.seo.score') AS FLOAT64) AS seo_score,
    page
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    lighthouse IS NOT NULL AND 
    lighthouse != '{}' AND
    is_root_page
),

domain_scores AS (
  SELECT
    CASE
      WHEN REGEXP_CONTAINS(page, r'\.un\.org') THEN 'UN.org'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.uk') THEN 'Gov.uk'
      WHEN REGEXP_CONTAINS(page, r'\.va\.gov') THEN 'USA VA.gov'
      WHEN REGEXP_CONTAINS(page, r'\.gc\.ca') OR REGEXP_CONTAINS(page, r'\.canada\.ca') THEN 'Canada'
      WHEN REGEXP_CONTAINS(page, r'\.gov') THEN 'USA'
      WHEN REGEXP_CONTAINS(page, r'\.gob\.ar') THEN 'Argentina'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.au') THEN 'Australia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.br') THEN 'Brazil'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.cn') THEN 'China'
      WHEN REGEXP_CONTAINS(page, r'\.gouv\.fr') THEN 'France'
      WHEN REGEXP_CONTAINS(page, r'\.bund\.de') THEN 'Germany'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.in') THEN 'India'
      WHEN REGEXP_CONTAINS(page, r'\.go\.id') THEN 'Indonesia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.it') THEN 'Italy'
      WHEN REGEXP_CONTAINS(page, r'\.go\.jp') THEN 'Japan'
      WHEN REGEXP_CONTAINS(page, r'\.gob\.mx') THEN 'Mexico'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.ru') THEN 'Russia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.sa') THEN 'Saudi Arabia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.za') THEN 'South Africa'
      WHEN REGEXP_CONTAINS(page, r'\.go\.kr') THEN 'South Korea'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.tr') THEN 'Turkey'
      WHEN REGEXP_CONTAINS(page, r'\.europa\.eu') THEN 'European Union'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.dk') THEN 'Denmark'
      WHEN REGEXP_CONTAINS(page, r'\.riik\.ee') THEN 'Estonia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.il') THEN 'Israel'
      WHEN REGEXP_CONTAINS(page, r'\.govt\.nz') THEN 'New Zealand'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.pt') THEN 'Portugal'
      WHEN REGEXP_CONTAINS(page, r'\.gub\.uy') THEN 'Uruguay'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.al') THEN 'Albania'
      WHEN REGEXP_CONTAINS(page, r'\.gv\.at') THEN 'Austria'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.be') THEN 'Belgium'
      WHEN REGEXP_CONTAINS(page, r'\.government\.bg') THEN 'Bulgaria'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.hr') THEN 'Croatia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.cz') THEN 'Czech Republic'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.fi') THEN 'Finland'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.gr') THEN 'Greece'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.hu') THEN 'Hungary'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.ie') THEN 'Ireland'
      WHEN REGEXP_CONTAINS(page, r'\.public\.lu') THEN 'Luxembourg'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.no') THEN 'Norway'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.se') THEN 'Sweden'
      WHEN REGEXP_CONTAINS(page, r'\.admin\.ch') THEN 'Switzerland'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.tw') THEN 'Taiwan'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.sg') THEN 'Singapore'
    END AS gov_domain,
    performance_score,
    accessibility_score,
    best_practices_score, 
    seo_score
  FROM
    score_data
  WHERE
    REGEXP_CONTAINS(page, r'\.un\.org|\.gov\.uk|\.gov|\.va\.gov|\.gc\.ca|\.canada\.ca|\.gob\.ar|\.gov\.au|\.gov\.br|\.gov\.cn|\.gouv\.fr|\.bund\.de|\.gov\.in|\.go\.id|\.gov\.it|\.go\.jp|\.gob\.mx|\.gov\.ru|\.gov\.sa|\.gov\.za|\.go\.kr|\.gov\.tr|\.europa\.eu|\.gov\.dk|\.riik\.ee|\.gov\.il|\.govt\.nz|\.gov\.pt|\.gub\.uy|\.gov\.al|\.gv\.at|\.gov\.be|\.government\.bg|\.gov\.hr|\.gov\.cz|\.gov\.fi|\.gov\.gr|\.gov\.hu|\.gov\.ie|\.public\.lu|\.gov\.no|\.gov\.se|\.admin\.ch|\.gov\.tw|\.gov\.sg')
)

SELECT
  gov_domain,
  AVG(performance_score) AS average_performance_score,
  AVG(accessibility_score) AS average_accessibility_score,
  AVG(best_practices_score) AS average_best_practices_score, 
  AVG(seo_score) AS average_seo_score,
  COUNT(*) AS total_domains
FROM
  domain_scores
GROUP BY
  gov_domain
ORDER BY
  average_accessibility_score DESC;
