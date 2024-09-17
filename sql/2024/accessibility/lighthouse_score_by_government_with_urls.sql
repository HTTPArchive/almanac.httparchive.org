#standardSQL
# List all included government domains along with scores

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
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.un\\.org(/|$)|\\.worldbank.org(/|$)|\\.undp.org(/|$)|\\.reliefweb.int(/|$)|\\.who.int(/|$)|\\.unfccc.int(/|$)|\\.unccd.int(/|$)|\\.unesco.org(/|$)') THEN 'United Nations'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.europa\\.eu(/|$)') THEN 'European Union'

      -- USA State Governments (must come before federal .gov check)
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.alabama\\.gov(/|$)|\\.Al\\.gov(/|$)') THEN 'Alabama'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.alaska\\.gov(/|$)|\\.Ak\\.gov(/|$)') THEN 'Alaska'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.arizona\\.gov(/|$)|\\.AZ\.gov(/|$)') THEN 'Arizona'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.arkansas\\.gov(/|$)|\\.Ar\\.gov(/|$)') THEN 'Arkansas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.california\\.gov(/|$)|\\.Ca\\.gov(/|$)') THEN 'California'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.colorado\\.gov(/|$)|\\.Co\\.gov(/|$)') THEN 'Colorado'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.connecticut\\.gov(/|$)|\\.Ct\\.gov(/|$)') THEN 'Connecticut'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.delaware\\.gov(/|$)|\\.De\\.gov(/|$)') THEN 'Delaware'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.florida\\.gov(/|$)|\\.Fl\\.gov(/|$)|\\.myflorida\\.com(/|$)') THEN 'Florida'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.georgia\\.gov(/|$)|\\.Ga\\.gov(/|$)') THEN 'Georgia State' -- To avoid confusion with the country
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.hawaii\\.gov(/|$)|\\.hi\\.gov(/|$)|\\.ehawaii\\.gov(/|$)') THEN 'Hawaii'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.idaho\\.gov(/|$)|\\.id\\.gov(/|$)') THEN 'Idaho'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.illinois\\.gov(/|$)|\\.Il\\.gov(/|$)') THEN 'Illinois'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.indiana\\.gov(/|$)|\\.in\\.gov(/|$)') THEN 'Indiana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.iowa\\.gov(/|$)|\\.ia\\.gov(/|$)') THEN 'Iowa'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kansas\\.gov(/|$)|\\.Ks\\.gov(/|$)') THEN 'Kansas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kentucky\\.gov(/|$)|\\.Ky\\.gov(/|$)') THEN 'Kentucky'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.louisiana\\.gov(/|$)|\\.La\\.gov(/|$)') THEN 'Louisiana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.maine\\.gov(/|$)|\\.Me\\.gov(/|$)') THEN 'Maine'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.maryland\\.gov(/|$)|\\.Md\\.gov(/|$)') THEN 'Maryland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.massachusetts\\.gov(/|$)|\\.Ma\\.gov(/|$)|\\.mass\\.gov(/|$)') THEN 'Massachusetts'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.michigan\\.gov(/|$)|\\.Mi\\.gov(/|$)') THEN 'Michigan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.minnesota\\.gov(/|$)|\\.Mn\\.gov(/|$)') THEN 'Minnesota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mississippi\\.gov(/|$)|\\.Ms\\.gov(/|$)') THEN 'Mississippi'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.missouri\\.gov(/|$)|\\.Mo\\.gov(/|$)') THEN 'Missouri'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.montana\\.gov(/|$)|\\.Mt\\.gov(/|$)') THEN 'Montana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nebraska\\.gov(/|$)|\\.Ne\\.gov(/|$)') THEN 'Nebraska'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nevada\\.gov(/|$)|\\.Nv\\.gov(/|$)') THEN 'Nevada'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.newhampshire\\.gov(/|$)|\\.NH\.gov(/|$)') THEN 'New Hampshire'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.newjersey\\.gov(/|$)|\\.NJ\.gov(/|$)') THEN 'New Jersey'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.newmexico\\.gov(/|$)|\\.Nm\\.gov(/|$)') THEN 'New Mexico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.newyork\\.gov(/|$)|\\.Ny\\.gov(/|$)') THEN 'New York'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.northcarolina\\.gov(/|$)|\\.Nc\\.gov(/|$)') THEN 'North Carolina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.northdakota\\.gov(/|$)|\\.Nd\\.gov(/|$)') THEN 'North Dakota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ohio\\.gov(/|$)|\\.OH\.gov(/|$)') THEN 'Ohio'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.oklahoma\\.gov(/|$)|\\.Ok\\.gov(/|$)') THEN 'Oklahoma'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.oregon\\.gov(/|$)|\\.Or\\.gov(/|$)') THEN 'Oregon'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pennsylvania\\.gov(/|$)|\\.Pa\\.gov(/|$)') THEN 'Pennsylvania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.rhodeisland\\.gov(/|$)|\\.Ri\\.gov(/|$)') THEN 'Rhode Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.southcarolina\\.gov(/|$)|\\.Sc\\.gov(/|$)') THEN 'South Carolina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.southdakota\\.gov(/|$)|\\.Sd\\.gov(/|$)') THEN 'South Dakota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tennessee\\.gov(/|$)|\\.Tn\\.gov(/|$)') THEN 'Tennessee'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.texas\\.gov(/|$)|\\.TX\.gov(/|$)') THEN 'Texas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.utah\.gov(/|$)|\\.Ut\\.gov(/|$)') THEN 'Utah'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.vermont\\.gov(/|$)|\\.Vt\\.gov(/|$)') THEN 'Vermont'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.virginia\\.gov(/|$)') THEN 'Virginia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.washington\\.gov(/|$)|\\.Wa\\.gov(/|$)') THEN 'Washington'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.westvirginia\\.gov(/|$)|\\.Wv\\.gov(/|$)') THEN 'West Virginia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.wisconsin\\.gov(/|$)|\\.Wi\\.gov(/|$)') THEN 'Wisconsin'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.wyoming\\.gov(/|$)|\\.Wy\\.gov(/|$)') THEN 'Wyoming'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.dc\\.gov(/|$)') THEN 'DC'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pr\\.gov(/|$)') THEN 'Puerto Rico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.guam\\.gov(/|$)') THEN 'Guam'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.americansamoa\\.gov(/|$)') THEN 'American Samoa'

      -- North American Federal Governments
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.va\\.gov(/|$)') THEN 'USA VA.gov'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cms\\.gov(/|$)') THEN 'USA CMS.gov'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov(/|$)') THEN 'United States (USA)' -- States and specific departments are listed first to make them distinct.
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mil(/|$)') THEN 'USA Military'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gob\\.mx(/|$)') THEN 'Mexico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gc\\.ca(/|$)|\\.canada\\.ca(/|$)|\\.alberta\\.ca(/|$)|\\.gov\\.ab\\.ca(/|$)|\\.gov\\.bc\\.ca(/|$)|\\.manitoba\\.ca(/|$)|\\.gov\\.mb\\.ca(/|$)|\\.gnb\\.ca(/|$)|\\.gov\\.nb\\.ca(/|$)|\\.gov\\.nl\\.ca(/|$)|\\.novascotia\\.ca(/|$)|\\.gov\\.ns\\.ca(/|$)|\\.ontario\\.ca(/|$)|\\.gov\\.on\\.ca(/|$)|\\.gov\\.pe\\.ca(/|$)|\\.quebec\\.ca(/|$)|\\.gouv\\.qc\\.ca(/|$)|\\.revenuquebec\\.ca(/|$)|\\.saskatchewan\\.ca(/|$)|\\.gov\\.sk\\.ca(/|$)|\\.gov\\.nt\\.ca(/|$)|\\.gov\\.nu\.ca(/|$)|\\.yukon\\.ca(/|$)|\\.gov\\.yk\\.ca') THEN 'Canada'

      -- European Countries
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.uk(/|$)') THEN 'United Kingdom (UK)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gouv\\.fr(/|$)') THEN 'France'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bund\\.de(/|$)') THEN 'Germany'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.it/|governo.it(/|$)') THEN 'Italy'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.gr(/|$)') THEN 'Greece'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ge(/|$)') THEN 'Georgia Country'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.pt(/|$)') THEN 'Portugal'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.es|gob\\.es|ine\\.es|boe\\.es(/|$)') THEN 'Spain'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.se/|1177\.se/|funktionstjanster\\.se/|hemnet\\.se/|smhi\\.se/|sverigesradio\\.se/|klart\\.se/|bankid\\.com/|synonymer\\.se/|arbetsformedlingen\\.se/|skatteverket\\.se/|schoolsoft\\.se/|postnord\\.se/|grandid\\.com/|viaplay\\.se/|skola24\.se/|forsakringskassan\\.se/|vklass\\.se|sl\\.se/|familjeliv\\.se(/|$)') THEN 'Sweden'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.fi/|valtioneuvosto\\.fi/|minedu\.fi/|formin\\.fi/|intermin\\.fi/|suomi\\.fi/|ym\\.fi/|stm\\.fi/|tem\\.fi/|lvm\\.fi/|mmm\\.fi/|okm\\.fi/|vm\\.fi/|defmin\\.fi/|oikeusministerio\\.fi/|um\\.fi/|vero\\.fi/|kela\\.fi(/|$)') THEN 'Finland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.no(/|$)') THEN 'Norway'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.dk(/|$)|\\.ft\\.dk(/|$)|\\.nemkonto\\.dk(/|$)|\\.nemlog-in\\.dk(/|$)|\\.mitid\\.dk(/|$)|\\.digst\\.dk(/|$)|\\.sikkerdigital\\.dk(/|$)|\\.forsvaret\\.dk(/|$)|\\.skat\\.dk(/|$)|\\.stps\\.dk(/|$)|\\.ufm\\.dk(/|$)|\\.urm\\.dk(/|$)|\\.uvm\\.dk(/|$)|\\.politi\\.dk(/|$)|\\.dataetiskraad\\.dk(/|$)|\\.at\\.dk(/|$)|\\.kum\\.dk(/|$)') THEN 'Denmark'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.riik\\.ee(/|$)|\\.riigiteataja\\.ee(/|$)|\\.eesti\\.ee(/|$)|\\.valitsus\\.ee(/|$)') THEN 'Estonia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.admin\\.ch(/|$)') THEN 'Switzerland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.public\\.lu(/|$)|\\.etat\\.lu(/|$)') THEN 'Luxembourg'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.fi|\\.valtioneuvosto\\.fi(/|$)|\\.minedu\.fi(/|$)|\\.formin\\.fi(/|$)|\\.intermin\\.fi(/|$)') THEN 'Finland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.hr(/|$)') THEN 'Croatia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.cz(/|$)') THEN 'Czech Republic'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.government\\.bg(/|$)') THEN 'Bulgaria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.belgium\\.be(/|$)|\\.gov\\.be/\.fgov\\.be(/|$)|\\.vlaanderen\\.be(/|$)|\\.wallonie\\.be(/|$)|\\.brussels\\.be(/|$)|\\.mil\\.be(/|$)') THEN 'Belgium'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.hu(/|$)') THEN 'Hungary'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ie(/|$)') THEN 'Ireland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.pl(/|$)') THEN 'Poland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.lt(/|$)|\\.vrm\\.lt(/|$)|\\.sam\\.lt(/|$)|\\.ukmin\\.lt(/|$)|\\.lrv\\.lt(/|$)|\\.uzt\\.lt(/|$)|\\.migracija\\.lt(/|$)|\\.kam\\.lt(/|$)|\\.lrs\\.lt(/|$)|\\.urm\\.lt(/|$)') THEN 'Lithuania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.nl(/|$)|\\.overheid\\.nl(/|$)|\\.mijnoverheid\\.nl(/|$)') THEN 'Netherlands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.si(/|$)') THEN 'Slovenia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.sk(/|$)') THEN 'Slovakia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gv\\.at(/|$)') THEN 'Austria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.al(/|$)') THEN 'Albania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gv\\.ua(/|$)') THEN 'Ukraine'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.rs(/|$)') THEN 'Serbia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ge(/|$)') THEN 'Georgia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.by(/|$)') THEN 'Belarus'

      -- Other Countries
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.in(/|$)|\\.nic\\.in(/|$)') THEN 'India'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.cn(/|$)') THEN 'China'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.pk(/|$)') THEN 'Pakistan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.bd(/|$)') THEN 'Bangladesh'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ng(/|$)') THEN 'Nigeria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ir(/|$)') THEN 'Iran'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.il(/|$)') THEN 'Israel'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.vn(/|$)') THEN 'Vietnam'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.hk(/|$)') THEN 'Hong Kong'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.mo(/|$)') THEN 'Macau'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.go\\.ke(/|$)') THEN 'Kenya'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.tr(/|$)') THEN 'Turkey'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.sa(/|$)') THEN 'Saudi Arabia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.za(/|$)') THEN 'South Africa'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.go\\.kr(/|$)') THEN 'South Korea'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.go\\.id(/|$)') THEN 'Indonesia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.go\\.jp(/|$)') THEN 'Japan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gob\\.ar(/|$)') THEN 'Argentina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.au(/|$)') THEN 'Australia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.br(/|$)') THEN 'Brazil'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ru|\\.govvrn\\.ru(/|$)') THEN 'Russia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.govt\\.nz(/|$)') THEN 'New Zealand'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.tw(/|$)') THEN 'Taiwan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.sg(/|$)') THEN 'Singapore'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gub\\.uy(/|$)') THEN 'Uruguay'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.lk(/|$)') THEN 'Sri Lanka'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.my(/|$)') THEN 'Malaysia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gub\\.ar(/|$)|\\.gov\\.ar(/|$)') THEN 'Argentina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ae(/|$)') THEN 'United Arab Emirates'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.co(/|$)') THEN 'Columbia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ma(/|$)') THEN 'Morocco'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.eg(/|$)') THEN 'Egypt'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ph(/|$)') THEN 'Philippines'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.np(/|$)') THEN 'Nepal'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.jo(/|$)') THEN 'Paraguay'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.uy(/|$)') THEN 'Jordan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.gh(/|$)') THEN 'Ghana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.mn(/|$)') THEN 'Mongolia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.kh(/|$)') THEN 'Cambodia'


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
    REGEXP_CONTAINS(page, r'(?i)('
      '(\\w+\\.)*\\.un\\.org(/|$)'  -- United Nations and International Organizations
      '|(\\w+\\.)*\\.worldbank\\.org(/|$)'
      '|(\\w+\\.)*\\.undp\\.org(/|$)'
      '|(\\w+\\.)*\\.reliefweb\\.int(/|$)'
      '|(\\w+\\.)*\\.who\\.int(/|$)'
      '|(\\w+\\.)*\\.unfccc\\.int(/|$)'
      '|(\\w+\\.)*\\.unccd\\.int(/|$)'
      '|(\\w+\\.)*\\.unesco\\.org(/|$)'

      '|(\\w+\\.)*\\.europa\\.eu(/|$)'  -- European Union

      '|(\\w+\\.)*\\.gov(\\.[a-z]{2,3})?(/|$)'  -- US Government and global .gov domains (e.g., .gov.uk, .gov.au)
      '|(\\w+\\.)*\\.mil(\\.[a-z]{2,3})?(/|$)'  -- US Military and global .mil domains

      '|(\\w+\\.)*\\.myflorida\\.com(/|$)' -- Florida

      '|(\\w+\\.){0,2}(gov|mil|gouv|gob|gub|go|govt|gv|nic|government)\\.(taipei|[a-z]{2})?(/|$)' -- Other generic government formats (e.g., gouv.fr, gob.mx, go.jp)

      '|(\\w+\\.)*\\.gc\\.ca(/|$)'  -- Canada and provinces
      '|(\\w+\\.)*\\.canada\\.ca(/|$)'
      '|(\\w+\\.)*\\.alberta\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.ab\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.bc\\.ca(/|$)'
      '|(\\w+\\.)*\\.manitoba\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.mb\\.ca(/|$)'
      '|(\\w+\\.)*\\.gnb\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.nb\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.nl\\.ca(/|$)'
      '|(\\w+\\.)*\\.novascotia\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.ns\\.ca(/|$)'
      '|(\\w+\\.)*\\.ontario\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.on\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.pe\\.ca(/|$)'
      '|(\\w+\\.)*\\.quebec\\.ca(/|$)'
      '|(\\w+\\.)*\\.gouv\\.qc\\.ca(/|$)'
      '|(\\w+\\.)*\\.revenuquebec\\.ca(/|$)'
      '|(\\w+\\.)*\\.saskatchewan\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.sk\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.nt\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.nu\\.ca(/|$)'
      '|(\\w+\\.)*\\.yukon\\.ca(/|$)'
      '|(\\w+\\.)*\\.gov\\.yk\\.ca(/|$)'

      '|(\\w+\\.)*\\.bund\\.de(/|$)'  -- Germany

      '|(\\w+\\.)*\\.belgium\\.be(/|$)'  -- Belgium
      '|(\\w+\\.)*\\.fgov\\.be(/|$)'
      '|(\\w+\\.)*\\.vlaanderen\\.be(/|$)'
      '|(\\w+\\.)*\\.wallonie\\.be(/|$)'
      '|(\\w+\\.)*\\.brussels\\.be(/|$)'
      '|(\\w+\\.)*\\.mil\\.be(/|$)'

      '|(\\w+\\.)*\\.gov\\.se(/|$)'  -- Sweden
      '|(\\w+\\.)*\\.1177\\.se(/|$)'
      '|(\\w+\\.)*\\.funktionstjanster\\.se(/|$)'
      '|(\\w+\\.)*\\.hemnet\\.se(/|$)'
      '|(\\w+\\.)*\\.smhi\\.se(/|$)'
      '|(\\w+\\.)*\\.sverigesradio\\.se(/|$)'
      '|(\\w+\\.)*\\.klart\\.se(/|$)'
      '|(\\w+\\.)*\\.bankid\\.com(/|$)'
      '|(\\w+\\.)*\\.synonymer\\.se(/|$)'
      '|(\\w+\\.)*\\.arbetsformedlingen\\.se(/|$)'
      '|(\\w+\\.)*\\.skatteverket\\.se(/|$)'
      '|(\\w+\\.)*\\.schoolsoft\\.se(/|$)'
      '|(\\w+\\.)*\\.postnord\\.se(/|$)'
      '|(\\w+\\.)*\\.grandid\\.com(/|$)'
      '|(\\w+\\.)*\\.viaplay\\.se(/|$)'
      '|(\\w+\\.)*\\.skola24\\.se(/|$)'
      '|(\\w+\\.)*\\.forsakringskassan\\.se(/|$)'
      '|(\\w+\\.)*\\.vklass\\.se(/|$)'
      '|(\\w+\\.)*\\.sl\\.se(/|$)'
      '|(\\w+\\.)*\\.familjeliv\\.se(/|$)'

      '|(\\w+\\.)*\\.valtioneuvosto\\.fi(/|$)'  -- Finland
      '|(\\w+\\.)*\\.minedu\\.fi(/|$)'
      '|(\\w+\\.)*\\.formin\\.fi(/|$)'
      '|(\\w+\\.)*\\.intermin\\.fi(/|$)'
      '|(\\w+\\.)*\\.suomi\\.fi(/|$)'
      '|(\\w+\\.)*\\.ym\\.fi(/|$)'
      '|(\\w+\\.)*\\.stm\\.fi(/|$)'
      '|(\\w+\\.)*\\.tem\\.fi(/|$)'
      '|(\\w+\\.)*\\.lvm\\.fi(/|$)'
      '|(\\w+\\.)*\\.mmm\\.fi(/|$)'
      '|(\\w+\\.)*\\.okm\\.fi(/|$)'
      '|(\\w+\\.)*\\.vm\\.fi(/|$)'
      '|(\\w+\\.)*\\.defmin\\.fi(/|$)'
      '|(\\w+\\.)*\\.oikeusministerio\\.fi(/|$)'
      '|(\\w+\\.)*\\.um\\.fi(/|$)'
      '|(\\w+\\.)*\\.vero\\.fi(/|$)'
      '|(\\w+\\.)*\\.kela\\.fi(/|$)'

      '|(\\w+\\.)*\\.lrv\\.lt(/|$)'  -- Lithuania
      '|(\\w+\\.)*\\.uzt\\.lt(/|$)'
      '|(\\w+\\.)*\\.migracija\\.lt(/|$)'
      '|(\\w+\\.)*\\.kam\\.lt(/|$)'
      '|(\\w+\\.)*\\.lrs\\.lt(/|$)'
      '|(\\w+\\.)*\\.urm\\.lt(/|$)'

      '|(\\w+\\.)*\\.riik\\.ee(/|$)'  -- Estonia
      '|(\\w+\\.)*\\.riigiteataja\\.ee(/|$)'
      '|(\\w+\\.)*\\.eesti\\.ee(/|$)'
      '|(\\w+\\.)*\\.valitsus\\.ee(/|$)'

      '|(\\w+\\.)*\\.admin\\.ch(/|$)'  -- Switzerland

      '|(\\w+\\.)*\\.seg-social\\.es(/|$)'  -- Spain
      '|(\\w+\\.)*\\.ine\\.es(/|$)'
      '|(\\w+\\.)*\\.boe\\.es(/|$)'

      '|(\\w+\\.)*\\.ft\\.dk(/|$)'  -- Denmark
      '|(\\w+\\.)*\\.nemkonto\\.dk(/|$)'
      '|(\\w+\\.)*\\.nemlog-in\\.dk(/|$)'
      '|(\\w+\\.)*\\.mitid\\.dk(/|$)'
      '|(\\w+\\.)*\\.digst\\.dk(/|$)'
      '|(\\w+\\.)*\\.sikkerdigital\\.dk(/|$)'
      '|(\\w+\\.)*\\.forsvaret\\.dk(/|$)'
      '|(\\w+\\.)*\\.skat\\.dk(/|$)'
      '|(\\w+\\.)*\\.stps\\.dk(/|$)'
      '|(\\w+\\.)*\\.ufm\\.dk(/|$)'
      '|(\\w+\\.)*\\.urm\\.dk(/|$)'
      '|(\\w+\\.)*\\.uvm\\.dk(/|$)'
      '|(\\w+\\.)*\\.politi\\.dk(/|$)'
      '|(\\w+\\.)*\\.dataetiskraad\\.dk(/|$)'
      '|(\\w+\\.)*\\.at\\.dk(/|$)'
      '|(\\w+\\.)*\\.kum\\.dk(/|$)'

      '|(\\w+\\.)*\\.govvrn\\.ru(/|$)' -- Russia

      '|(\\w+\\.)*\\.public\\.lu(/|$)'  -- Luxembourg
      '|(\\w+\\.)*\\.etat\\.lu(/|$)' 

      '|(\\w+\\.)*\\.governo\\.it(/|$)'  -- Italy

      '|(\\w+\\.)*\\.overheid\\.nl(/|$)'  -- Netherlands
      '|(\\w+\\.)*\\.mijnoverheid\\.nl(/|$)'

      ')')
)

SELECT
  gov_domain,
  page,
  is_root_page,
  performance_score,
  accessibility_score,
  best_practices_score,
  seo_score
FROM
  domain_scores
WHERE gov_domain IS NOT NULL
ORDER BY gov_domain;
