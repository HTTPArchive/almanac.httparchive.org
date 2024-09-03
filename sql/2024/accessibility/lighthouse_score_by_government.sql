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
      -- United Nations
      WHEN REGEXP_CONTAINS(page, r'\.un\.org') THEN 'UN.org'
      WHEN REGEXP_CONTAINS(page, r'\.europa\.eu') THEN 'European Union'

      -- USA State Governments (must come before federal .gov check)
      WHEN REGEXP_CONTAINS(page, r'\.alabama\.gov|\.AL\.gov') THEN 'Alabama'
      WHEN REGEXP_CONTAINS(page, r'\.alaska\.gov|\.AK\.gov') THEN 'Alaska'
      WHEN REGEXP_CONTAINS(page, r'\.arizona\.gov|\.AZ\.gov') THEN 'Arizona'
      WHEN REGEXP_CONTAINS(page, r'\.arkansas\.gov|\.AR\.gov') THEN 'Arkansas'
      WHEN REGEXP_CONTAINS(page, r'\.california\.gov|\.CA\.gov') THEN 'California'
      WHEN REGEXP_CONTAINS(page, r'\.colorado\.gov|\.CO\.gov') THEN 'Colorado'
      WHEN REGEXP_CONTAINS(page, r'\.connecticut\.gov|\.CT\.gov') THEN 'Connecticut'
      WHEN REGEXP_CONTAINS(page, r'\.delaware\.gov|\.DE\.gov') THEN 'Delaware'
      WHEN REGEXP_CONTAINS(page, r'\.florida\.gov|\.FL\.gov') THEN 'Florida'
      WHEN REGEXP_CONTAINS(page, r'\.georgia\.gov|\.GA\.gov') THEN 'Georgia'
      WHEN REGEXP_CONTAINS(page, r'\.hawaii\.gov|\.HI\.gov') THEN 'Hawaii'
      WHEN REGEXP_CONTAINS(page, r'\.idaho\.gov|\.ID\.gov') THEN 'Idaho'
      WHEN REGEXP_CONTAINS(page, r'\.illinois\.gov|\.IL\.gov') THEN 'Illinois'
      WHEN REGEXP_CONTAINS(page, r'\.indiana\.gov|\.IN\.gov') THEN 'Indiana'
      WHEN REGEXP_CONTAINS(page, r'\.iowa\.gov|\.IA\.gov') THEN 'Iowa'
      WHEN REGEXP_CONTAINS(page, r'\.kansas\.gov|\.KS\.gov') THEN 'Kansas'
      WHEN REGEXP_CONTAINS(page, r'\.kentucky\.gov|\.KY\.gov') THEN 'Kentucky'
      WHEN REGEXP_CONTAINS(page, r'\.louisiana\.gov|\.LA\.gov') THEN 'Louisiana'
      WHEN REGEXP_CONTAINS(page, r'\.maine\.gov|\.ME\.gov') THEN 'Maine'
      WHEN REGEXP_CONTAINS(page, r'\.maryland\.gov|\.MD\.gov') THEN 'Maryland'
      WHEN REGEXP_CONTAINS(page, r'\.massachusetts\.gov|\.MA\.gov') THEN 'Massachusetts'
      WHEN REGEXP_CONTAINS(page, r'\.michigan\.gov|\.MI\.gov') THEN 'Michigan'
      WHEN REGEXP_CONTAINS(page, r'\.minnesota\.gov|\.MN\.gov') THEN 'Minnesota'
      WHEN REGEXP_CONTAINS(page, r'\.mississippi\.gov|\.MS\.gov') THEN 'Mississippi'
      WHEN REGEXP_CONTAINS(page, r'\.missouri\.gov|\.MO\.gov') THEN 'Missouri'
      WHEN REGEXP_CONTAINS(page, r'\.montana\.gov|\.MT\.gov') THEN 'Montana'
      WHEN REGEXP_CONTAINS(page, r'\.nebraska\.gov|\.NE\.gov') THEN 'Nebraska'
      WHEN REGEXP_CONTAINS(page, r'\.nevada\.gov|\.NV\.gov') THEN 'Nevada'
      WHEN REGEXP_CONTAINS(page, r'\.newhampshire\.gov|\.NH\.gov') THEN 'New Hampshire'
      WHEN REGEXP_CONTAINS(page, r'\.newjersey\.gov|\.NJ\.gov') THEN 'New Jersey'
      WHEN REGEXP_CONTAINS(page, r'\.newmexico\.gov|\.NM\.gov') THEN 'New Mexico'
      WHEN REGEXP_CONTAINS(page, r'\.newyork\.gov|\.NY\.gov') THEN 'New York'
      WHEN REGEXP_CONTAINS(page, r'\.northcarolina\.gov|\.NC\.gov') THEN 'North Carolina'
      WHEN REGEXP_CONTAINS(page, r'\.northdakota\.gov|\.ND\.gov') THEN 'North Dakota'
      WHEN REGEXP_CONTAINS(page, r'\.ohio\.gov|\.OH\.gov') THEN 'Ohio'
      WHEN REGEXP_CONTAINS(page, r'\.oklahoma\.gov|\.OK\.gov') THEN 'Oklahoma'
      WHEN REGEXP_CONTAINS(page, r'\.oregon\.gov|\.OR\.gov') THEN 'Oregon'
      WHEN REGEXP_CONTAINS(page, r'\.pennsylvania\.gov|\.PA\.gov') THEN 'Pennsylvania'
      WHEN REGEXP_CONTAINS(page, r'\.rhodeisland\.gov|\.RI\.gov') THEN 'Rhode Island'
      WHEN REGEXP_CONTAINS(page, r'\.southcarolina\.gov|\.SC\.gov') THEN 'South Carolina'
      WHEN REGEXP_CONTAINS(page, r'\.southdakota\.gov|\.SD\.gov') THEN 'South Dakota'
      WHEN REGEXP_CONTAINS(page, r'\.tennessee\.gov|\.TN\.gov') THEN 'Tennessee'
      WHEN REGEXP_CONTAINS(page, r'\.texas\.gov|\.TX\.gov') THEN 'Texas'
      WHEN REGEXP_CONTAINS(page, r'\.utah\.gov|\.UT\.gov') THEN 'Utah'
      WHEN REGEXP_CONTAINS(page, r'\.vermont\.gov|\.VT\.gov') THEN 'Vermont'
      WHEN REGEXP_CONTAINS(page, r'\.virginia\.gov|\.VA\.gov') THEN 'Virginia'
      WHEN REGEXP_CONTAINS(page, r'\.washington\.gov|\.WA\.gov') THEN 'Washington'
      WHEN REGEXP_CONTAINS(page, r'\.westvirginia\.gov|\.WV\.gov') THEN 'West Virginia'
      WHEN REGEXP_CONTAINS(page, r'\.wisconsin\.gov|\.WI\.gov') THEN 'Wisconsin'
      WHEN REGEXP_CONTAINS(page, r'\.wyoming\.gov|\.WY\.gov') THEN  'Wyoming'

      -- North American Federal Governments
      WHEN REGEXP_CONTAINS(page, r'\.va\.gov') THEN 'USA VA.gov'
      WHEN REGEXP_CONTAINS(page, r'\.gov') THEN 'USA'
      WHEN REGEXP_CONTAINS(page, r'\.mil') THEN 'USA Military'
      WHEN REGEXP_CONTAINS(page, r'\.gob\.mx') THEN 'Mexico'
      WHEN REGEXP_CONTAINS(page, r'\.gc\.ca|\.canada\.ca') THEN 'Canada'

      -- European Countries
      WHEN REGEXP_CONTAINS(page, r'\.gov\.uk') THEN 'UK'
      WHEN REGEXP_CONTAINS(page, r'\.gouv\.fr') THEN 'France'
      WHEN REGEXP_CONTAINS(page, r'\.bund\.de') THEN 'Germany'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.it') THEN 'Italy'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.gr') THEN 'Greece'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.pt') THEN 'Portugal'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.es') THEN 'Spain'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.se') THEN 'Sweden'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.no') THEN 'Norway'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.dk') THEN 'Denmark'
      WHEN REGEXP_CONTAINS(page, r'\.riik\.ee') THEN 'Estonia'
      WHEN REGEXP_CONTAINS(page, r'\.admin\.ch') THEN 'Switzerland'
      WHEN REGEXP_CONTAINS(page, r'\.public\.lu') THEN 'Luxembourg'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.fi') THEN 'Finland'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.hr') THEN 'Croatia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.cz') THEN 'Czech Republic'
      WHEN REGEXP_CONTAINS(page, r'\.government\.bg') THEN 'Bulgaria'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.be') THEN 'Belgium'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.hu') THEN 'Hungary'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.ie') THEN 'Ireland'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.pl') THEN 'Poland'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.lt') THEN 'Lithuania'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.nl') THEN 'Netherlands'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.si') THEN 'Slovenia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.sk') THEN 'Slovakia'
      WHEN REGEXP_CONTAINS(page, r'\.gv\.at') THEN 'Austria'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.al') THEN 'Albania'
      WHEN REGEXP_CONTAINS(page, r'\.gv\.ua') THEN 'Ukraine'

      -- Other Countries
      WHEN REGEXP_CONTAINS(page, r'\.gov\.in|\.nic\.in') THEN 'India'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.cn') THEN 'China'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.pk') THEN 'Pakistan'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.bd') THEN 'Bangladesh'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.ng') THEN 'Nigeria'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.ir') THEN 'Iran'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.il') THEN 'Israel'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.vn') THEN 'Vietnam'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.hk') THEN 'Hong Kong'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.mo') THEN 'Macau'
      WHEN REGEXP_CONTAINS(page, r'\.go\.ke') THEN 'Kenya'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.tr') THEN 'Turkey'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.sa') THEN 'Saudi Arabia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.za') THEN 'South Africa'
      WHEN REGEXP_CONTAINS(page, r'\.go\.kr') THEN 'South Korea'
      WHEN REGEXP_CONTAINS(page, r'\.go\.id') THEN 'Indonesia'
      WHEN REGEXP_CONTAINS(page, r'\.go\.jp') THEN 'Japan'
      WHEN REGEXP_CONTAINS(page, r'\.gob\.ar') THEN 'Argentina'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.au') THEN 'Australia'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.br') THEN 'Brazil'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.ru') THEN 'Russia'
      WHEN REGEXP_CONTAINS(page, r'\.govt\.nz') THEN 'New Zealand'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.tw') THEN 'Taiwan'
      WHEN REGEXP_CONTAINS(page, r'\.gov\.sg') THEN 'Singapore'
      WHEN REGEXP_CONTAINS(page, r'\.gub\.uy') THEN 'Uruguay'

    END AS gov_domain,
    performance_score,
    accessibility_score,
    best_practices_score,
    seo_score
  FROM
    score_data
  WHERE
    REGEXP_CONTAINS(page, r'\.un\.org|\.europa\.eu|\.gov\.uk|\.gouv\.fr|\.bund\.de|\.gov\.it|\.gc\.ca|\.canada\.ca|\.gov\.gr|\.gov\.pt|\.gov\.es|\.gov\.se|\.gov\.no|\.gov\.dk|\.riik\.ee|\.admin\.ch|\.public\.lu|\.gov\.fi|\.gov\.hr|\.gov\.cz|\.government\.bg|\.gov\.be|\.gov\.hu|\.gov\.ie|\.gov\.pl|\.gov\.lt|\.gov\.nl|\.gov\.si|\.gov\.sk|\.gv\.at|\.gov\.al|\.gv\.ua|\.alabama\.gov|\.AL\.gov|\.alaska\.gov|\.AK\.gov|\.arizona\.gov|\.AZ\.gov|\.arkansas\.gov|\.AR\.gov|\.california\.gov|\.CA\.gov|\.colorado\.gov|\.CO\.gov|\.connecticut\.gov|\.CT\.gov|\.delaware\.gov|\.DE\.gov|\.florida\.gov|\.FL\.gov|\.georgia\.gov|\.GA\.gov|\.hawaii\.gov|\.HI\.gov|\.idaho\.gov|\.ID\.gov|\.illinois\.gov|\.IL\.gov|\.indiana\.gov|\.IN\.gov|\.iowa\.gov|\.IA\.gov|\.kansas\.gov|\.KS\.gov|\.kentucky\.gov|\.KY\.gov|\.louisiana\.gov|\.LA\.gov|\.maine\.gov|\.ME\.gov|\.maryland\.gov|\.MD\.gov|\.massachusetts\.gov|\.MA\.gov|\.michigan\.gov|\.MI\.gov|\.minnesota\.gov|\.MN\.gov|\.mississippi\.gov|\.MS\.gov|\.missouri\.gov|\.MO\.gov|\.montana\.gov|\.MT\.gov|\.nebraska\.gov|\.NE\.gov|\.nevada\.gov|\.NV\.gov|\.newhampshire\.gov|\.NH\.gov|\.newjersey\.gov|\.NJ\.gov|\.newmexico\.gov|\.NM\.gov|\.newyork\.gov|\.NY\.gov|\.northcarolina\.gov|\.NC\.gov|\.northdakota\.gov|\.ND\.gov|\.ohio\.gov|\.OH\.gov|\.oklahoma\.gov|\.OK\.gov|\.oregon\.gov|\.OR\.gov|\.pennsylvania\.gov|\.PA\.gov|\.rhodeisland\.gov|\.RI\.gov|\.southcarolina\.gov|\.SC\.gov|\.southdakota\.gov|\.SD\.gov|\.tennessee\.gov|\.TN\.gov|\.texas\.gov|\.TX\.gov|\.utah\.gov|\.UT\.gov|\.vermont\.gov|\.VT\.gov|\.virginia\.gov|\.VA\.gov|\.washington\.gov|\.WA\.gov|\.westvirginia\.gov|\.WV\.gov|\.wisconsin\.gov|\.WI\.gov|\.wyoming\.gov|\.WY\.gov|\.gov|\.va\.gov|\.mil|\.gob\.mx|\.gov\.in|\.nic\.in|\.gov\.cn|\.gov\.pk|\.gov\.bd|\.gov\.ng|\.gov\.ir|\.gov\.il|\.gov\.vn|\.gov\.hk|\.gov\.mo|\.go\.ke|\.gov\.tr|\.gov\.sa|\.gov\.za|\.go\.kr|\.go\.id|\.go\.jp|\.gob\.ar|\.gov\.au|\.gov\.br|\.gov\.ru|\.govt\.nz|\.gov\.tw|\.gov\.sg|\.gub\.uy')
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
