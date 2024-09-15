#standardSQL
# Calculate average Lighthouse scores and the number of pages for government-related domains

WITH score_data AS (
  SELECT
    client,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.performance.score') AS FLOAT64) AS performance_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS accessibility_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.best-practices.score') AS FLOAT64) AS best_practices_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.seo.score') AS FLOAT64) AS seo_score,
    page,
    is_root_page
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    lighthouse IS NOT NULL AND
    lighthouse != '{}'
),

domain_scores AS (
  SELECT
    page,
    CASE
      -- United Nations
      WHEN REGEXP_CONTAINS(page, r'(?i)\.un\.org/|\.worldbank.org/|\.undp.org/|\.reliefweb.int/|\.who.int/|\.unfccc.int/|\.unccd.int/|\.unesco.org/') THEN 'United Nations'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.europa\.eu/') THEN 'European Union'

      -- USA State Governments (must come before federal .gov check)
      WHEN REGEXP_CONTAINS(page, r'(?i)\.alabama\.gov/|\.AL\.gov/') THEN 'Alabama'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.alaska\.gov/|\.AK\.gov/') THEN 'Alaska'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.arizona\.gov/|\.AZ\.gov/') THEN 'Arizona'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.arkansas\.gov/|\.AR\.gov/') THEN 'Arkansas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.california\.gov/|\.CA\.gov/') THEN 'California'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.colorado\.gov/|\.CO\.gov/') THEN 'Colorado'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.connecticut\.gov/|\.CT\.gov/') THEN 'Connecticut'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.delaware\.gov/|\.DE\.gov/') THEN 'Delaware'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.florida\.gov/|\.FL\.gov/') THEN 'Florida'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.georgia\.gov/|\.GA\.gov/') THEN 'Georgia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.hawaii\.gov/|\.HI\.gov/') THEN 'Hawaii'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.idaho\.gov/|\.ID\.gov/') THEN 'Idaho'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.illinois\.gov/|\.IL\.gov/') THEN 'Illinois'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.indiana\.gov/|\.IN\.gov/') THEN 'Indiana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.iowa\.gov/|\.IA\.gov/') THEN 'Iowa'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.kansas\.gov/|\.KS\.gov/') THEN 'Kansas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.kentucky\.gov/|\.KY\.gov/') THEN 'Kentucky'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.louisiana\.gov/|\.LA\.gov/') THEN 'Louisiana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.maine\.gov/|\.ME\.gov/') THEN 'Maine'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.maryland\.gov/|\.MD\.gov/') THEN 'Maryland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.massachusetts\.gov/|\.MA\.gov/|\.mass\.gov/') THEN 'Massachusetts'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.michigan\.gov/|\.MI\.gov/') THEN 'Michigan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.minnesota\.gov/|\.MN\.gov/') THEN 'Minnesota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.mississippi\.gov/|\.MS\.gov/') THEN 'Mississippi'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.missouri\.gov/|\.MO\.gov/') THEN 'Missouri'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.montana\.gov/|\.MT\.gov/') THEN 'Montana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.nebraska\.gov/|\.NE\.gov/') THEN 'Nebraska'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.nevada\.gov/|\.NV\.gov/') THEN 'Nevada'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.newhampshire\.gov/|\.NH\.gov/') THEN 'New Hampshire'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.newjersey\.gov/|\.NJ\.gov/') THEN 'New Jersey'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.newmexico\.gov/|\.NM\.gov/') THEN 'New Mexico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.newyork\.gov/|\.NY\.gov/') THEN 'New York'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.northcarolina\.gov/|\.NC\.gov/') THEN 'North Carolina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.northdakota\.gov/|\.ND\.gov/') THEN 'North Dakota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.ohio\.gov/|\.OH\.gov/') THEN 'Ohio'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.oklahoma\.gov/|\.OK\.gov/') THEN 'Oklahoma'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.oregon\.gov/|\.OR\.gov/') THEN 'Oregon'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.pennsylvania\.gov/|\.PA\.gov/') THEN 'Pennsylvania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.rhodeisland\.gov/|\.RI\.gov/') THEN 'Rhode Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.southcarolina\.gov/|\.SC\.gov/') THEN 'South Carolina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.southdakota\.gov/|\.SD\.gov/') THEN 'South Dakota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.tennessee\.gov/|\.TN\.gov/') THEN 'Tennessee'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.texas\.gov/|\.TX\.gov/') THEN 'Texas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.utah\.gov|\.UT\.gov/') THEN 'Utah'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.vermont\.gov|\.VT\.gov/') THEN 'Vermont'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.virginia\.gov/') THEN 'Virginia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.washington\.gov/|\.WA\.gov/') THEN 'Washington'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.westvirginia\.gov/|\.WV\.gov/') THEN 'West Virginia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.wisconsin\.gov/|\.WI\.gov/') THEN 'Wisconsin'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.wyoming\.gov/|\.WY\.gov/') THEN 'Wyoming'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.DC\.gov/') THEN 'DC'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.PR\.gov/') THEN 'Puerto Rico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.guam\.gov/') THEN 'Guam'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.americansamoa\.gov/') THEN 'American Samoa'

      -- North American Federal Governments
      WHEN REGEXP_CONTAINS(page, r'(?i)\.va\.gov/') THEN 'USA VA.gov'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.cms\.gov/') THEN 'USA CMS.gov'
      -- WHEN REGEXP_CONTAINS(page, r'(?i)\.gov') THEN 'United States (USA)'
      WHEN REGEXP_CONTAINS(page, r'(?i)://(?:.*\.)?.gov/?$') THEN 'United States (USA)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.mil/') THEN 'USA Military'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gob\.mx/') THEN 'Mexico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gc\.ca/|\.canada\.ca') THEN 'Canada'

      -- European Countries
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.uk/') THEN 'United Kingdom (UK)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gouv\.fr/') THEN 'France'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.bund\.de/') THEN 'Germany'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.it/') THEN 'Italy'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.gr/') THEN 'Greece'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.pt/') THEN 'Portugal'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.es/') THEN 'Spain'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.se|1177\.se|funktionstjanster\.se|hemnet\.se|smhi\.se|sverigesradio\.se|klart\.se|bankid\.com|synonymer\.se|arbetsformedlingen\.se|skatteverket\.se|schoolsoft\.se|postnord\.se|grandid\.com|viaplay\.se|skola24\.se|forsakringskassan\.se|vklass\.se|sl\.se|familjeliv\.se') THEN 'Sweden'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.no/') THEN 'Norway'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.dk/') THEN 'Denmark'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.riik\.ee/') THEN 'Estonia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.admin\.ch/') THEN 'Switzerland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.public\.lu/') THEN 'Luxembourg'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.fi|\.valtioneuvosto\.fi|\.minedu\.fi|\.formin\.fi|\.intermin\.fi/') THEN 'Finland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.hr/') THEN 'Croatia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.cz/') THEN 'Czech Republic'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.government\.bg/') THEN 'Bulgaria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.be/') THEN 'Belgium'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.belgium\.be$|\.fgov\.be$|\.vlaanderen\.be$|\.wallonie\.be$|\.brussels\.be$|\.economie\.fgov\.be$|\.health\.belgium\.be$|\.justice\.belgium\.be$|\.mobilit\.belgium\.be$|\.mil\.be$') THEN 'Belgium'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.hu/') THEN 'Hungary'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.ie/') THEN 'Ireland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.pl/') THEN 'Poland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.lt|\.vrm.lt|\.sam.lt|\.ukmin.lt/') THEN 'Lithuania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.nl|\.overheid\.nl|\.mijnoverheid\.nl') THEN 'Netherlands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.si/') THEN 'Slovenia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.sk/') THEN 'Slovakia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gv\.at/') THEN 'Austria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.al/') THEN 'Albania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gv\.ua/') THEN 'Ukraine'

      -- Other Countries
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.in/|\.nic\.in/') THEN 'India'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.cn/') THEN 'China'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.pk/') THEN 'Pakistan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.bd/') THEN 'Bangladesh'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.ng/') THEN 'Nigeria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.ir/') THEN 'Iran'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.il/') THEN 'Israel'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.vn/') THEN 'Vietnam'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.hk/') THEN 'Hong Kong'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.mo/') THEN 'Macau'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.go\.ke/') THEN 'Kenya'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.tr/') THEN 'Turkey'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.sa/') THEN 'Saudi Arabia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.za/') THEN 'South Africa'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.go\.kr/') THEN 'South Korea'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.go\.id/') THEN 'Indonesia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.go\.jp/') THEN 'Japan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gob\.ar/') THEN 'Argentina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.au/') THEN 'Australia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.br/') THEN 'Brazil'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.ru/') THEN 'Russia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.govt\.nz/') THEN 'New Zealand'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.tw/') THEN 'Taiwan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gov\.sg/') THEN 'Singapore'
      WHEN REGEXP_CONTAINS(page, r'(?i)\.gub\.uy/') THEN 'Uruguay'
      ELSE 'Other'
    END AS gov_domain,
    is_root_page,
    performance_score,
    accessibility_score,
    best_practices_score,
    seo_score
  FROM
    score_data
  WHERE
FROM
  score_data
WHERE
  REGEXP_CONTAINS(page, r'(?i)('
    || '\\.un\\.org/|\\.worldbank\\.org/|\\.undp\\.org/|\\.reliefweb\\.int/|\\.who\\.int/|\\.unfccc\\.int/|\\.unccd\\.int/|\\.unesco\\.org/'  -- United Nations
    || '\\.europa\\.eu/'               -- European Union
    || '\.gov/'                        -- Catch-all for any USA .gov domains
    || '\.mil/'                        -- Catch-all for any USA .mil domains
    || '\\.gov(\\.[a-z]{2,3})?/'       -- Global .gov domains, including .gov.uk, .gov.au, .gov.uk, .gov.au, .gov.tw etc.
    || '\\.mil(\\.[a-z]{2,3})?/'       -- Global military domains
    || '(?i)(\w+\.){0,3}(gouv|gob|go|gv|gub|govt)\.[a-z]{2,3}/' -- Other generic government formats
    || '\\.gc\\.ca/|\\.canada\\.ca/'   -- Canada and provinces
    || '\\.belgium\\.be/|\\.fgov\\.be/|\\.vlaanderen\\.be/|\\.wallonie\\.be/|\\.brussels\\.be/|\\.economie\\.fgov\\.be/|\\.health\\.belgium\\.be/|\\.justice\\.belgium\\.be/|\\.mobilit\\.belgium\\.be/|\\.mil\\.be/' -- Belgium
    || '\\.gov\\.se\\b|1177\\.se|funktionstjanster\\.se|hemnet\\.se|smhi\\.se|sverigesradio\\.se|klart\\.se|bankid\\.com|synonymer\\.se|arbetsformedlingen\\.se|skatteverket\\.se|schoolsoft\\.se|postnord\\.se|grandid\\.com|viaplay\\.se|skola24\\.se|forsakringskassan\\.se|vklass\\.se|sl\\.se|familjeliv\\.se/' -- Sweden
    || '\\.gov\\.fi|\\.valtioneuvosto\\.fi|\\.minedu\\.fi|\\.formin\\.fi|\\.intermin\\.fi/' -- Finland
    || '\\.riik\\.ee/'                 -- Estonia
    || '\\.admin\\.ch/'                -- Switzerland
    || '\\.public\\.lu/'               -- Luxembourg
    || '\\.gov\\.nl/|\\.overheid\\.nl/|\\.mijnoverheid\\.nl/'  -- Netherlands
    || ')')
)

SELECT
  gov_domain,
  AVG(performance_score) AS average_performance_score,
  AVG(accessibility_score) AS average_accessibility_score,
  AVG(best_practices_score) AS average_best_practices_score,
  AVG(seo_score) AS average_seo_score,
  COUNT(0) AS total_domains
FROM
  domain_scores
GROUP BY
  gov_domain
ORDER BY
  average_accessibility_score DESC;
