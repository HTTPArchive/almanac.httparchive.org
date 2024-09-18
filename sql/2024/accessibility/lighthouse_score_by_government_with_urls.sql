

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
    is_root_page,
    wptid
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
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.un\\.org(/|$)|(?i)\\.worldbank\\.org(/|$)|(?i)\\.undp\\.org(/|$)|(?i)\\.reliefweb.int(/|$)|(?i)\\.who.int(/|$)|(?i)\\.unfccc.int(/|$)|(?i)\\.unccd.int(/|$)|(?i)\\.unesco.org(/|$)') THEN 'United Nations'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.europa\\.eu(/|$)') THEN 'European Union'

      -- USA State Governments (must come before federal .gov check)
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.alabama\\.gov(/|$)|(?i)\\.al\\.gov(/|$)') THEN 'Alabama'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.alaska\\.gov(/|$)|(?i)\\.ak\\.gov(/|$)') THEN 'Alaska'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.arizona\\.gov(/|$)|(?i)\\.az\\.gov(/|$)') THEN 'Arizona'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.arkansas\\.gov(/|$)|(?i)\\.ar\\.gov(/|$)') THEN 'Arkansas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.california\\.gov(/|$)|(?i)\\.ca\\.gov(/|$)') THEN 'California'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.colorado\\.gov(/|$)|(?i)\\.co\\.gov(/|$)') THEN 'Colorado'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.connecticut\\.gov(/|$)|(?i)\\.ct\\.gov(/|$)') THEN 'Connecticut'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.delaware\\.gov(/|$)|(?i)\\.de\\.gov(/|$)') THEN 'Delaware'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.florida\\.gov(/|$)|(?i)\\.fl\\.gov(/|$)|(?i)\\.myflorida\\.com(/|$)') THEN 'Florida'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.georgia\\.gov(/|$)|(?i)\\.ga\\.gov(/|$)') THEN 'Georgia State' -- To avoid confusion with the country
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.hawaii\\.gov(/|$)|(?i)\\.hi\\.gov(/|$)|(?i)\\.ehawaii\\.gov(/|$)') THEN 'Hawaii'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.idaho\\.gov(/|$)|(?i)\\.id\\.gov(/|$)') THEN 'Idaho'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.illinois\\.gov(/|$)|(?i)\\.il\\.gov(/|$)') THEN 'Illinois'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.indiana\\.gov(/|$)|(?i)\\.in\\.gov(/|$)') THEN 'Indiana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.iowa\\.gov(/|$)|(?i)\\.ia\\.gov(/|$)') THEN 'Iowa'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kansas\\.gov(/|$)|(?i)\\.ks\\.gov(/|$)') THEN 'Kansas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kentucky\\.gov(/|$)|(?i)\\.ky\\.gov(/|$)') THEN 'Kentucky'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.louisiana\\.gov(/|$)|(?i)\\.la\\.gov(/|$)') THEN 'Louisiana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.maine\\.gov(/|$)|(?i)\\.me\\.gov(/|$)') THEN 'Maine'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.maryland\\.gov(/|$)|(?i)\\.md\\.gov(/|$)') THEN 'Maryland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.massachusetts\\.gov(/|$)|(?i)\\.ma\\.gov(/|$)|(?i)\\.mass\\.gov(/|$)') THEN 'Massachusetts'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.michigan\\.gov(/|$)|(?i)\\.mi\\.gov(/|$)') THEN 'Michigan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.minnesota\\.gov(/|$)|(?i)\\.mn\\.gov(/|$)') THEN 'Minnesota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mississippi\\.gov(/|$)|(?i)\\.ms\\.gov(/|$)') THEN 'Mississippi'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.missouri\\.gov(/|$)|(?i)\\.mo\\.gov(/|$)') THEN 'Missouri'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.montana\\.gov(/|$)|(?i)\\.mt\\.gov(/|$)') THEN 'Montana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nebraska\\.gov(/|$)|(?i)\\.ne\\.gov(/|$)') THEN 'Nebraska'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nevada\\.gov(/|$)|(?i)\\.nv\\.gov(/|$)') THEN 'Nevada'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.newhampshire\\.gov(/|$)|(?i)\\.nh\\.gov(/|$)') THEN 'New Hampshire'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.newjersey\\.gov(/|$)|(?i)\\.nj\\.gov(/|$)') THEN 'New Jersey'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.newmexico\\.gov(/|$)|(?i)\\.nm\\.gov(/|$)') THEN 'New Mexico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.newyork\\.gov(/|$)|(?i)\\.ny\\.gov(/|$)') THEN 'New York'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.northcarolina\\.gov(/|$)|(?i)\\.nc\\.gov(/|$)') THEN 'North Carolina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.northdakota\\.gov(/|$)|(?i)\\.nd\\.gov(/|$)') THEN 'North Dakota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ohio\\.gov(/|$)|(?i)\\.oh\\.gov(/|$)') THEN 'Ohio'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.oklahoma\\.gov(/|$)|(?i)\\.ok\\.gov(/|$)') THEN 'Oklahoma'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.oregon\\.gov(/|$)|(?i)\\.or\\.gov(/|$)') THEN 'Oregon'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pennsylvania\\.gov(/|$)|(?i)\\.pa\\.gov(/|$)') THEN 'Pennsylvania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.rhodeisland\\.gov(/|$)|(?i)\\.ri\\.gov(/|$)') THEN 'Rhode Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.southcarolina\\.gov(/|$)|(?i)\\.sc\\.gov(/|$)') THEN 'South Carolina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.southdakota\\.gov(/|$)|(?i)\\.sd\\.gov(/|$)') THEN 'South Dakota'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tennessee\\.gov(/|$)|(?i)\\.tn\\.gov(/|$)') THEN 'Tennessee'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.texas\\.gov(/|$)|(?i)\\.tx\\.gov(/|$)') THEN 'Texas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.utah\\.gov(/|$)|(?i)\\.ut\\.gov(/|$)') THEN 'Utah'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.vermont\\.gov(/|$)|(?i)\\.vt\\.gov(/|$)') THEN 'Vermont'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.virginia\\.gov(/|$)') THEN 'Virginia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.washington\\.gov(/|$)|(?i)\\.wa\\.gov(/|$)') THEN 'Washington'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.westvirginia\\.gov(/|$)|(?i)\\.wv\\.gov(/|$)') THEN 'West Virginia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.wisconsin\\.gov(/|$)|(?i)\\.wi\\.gov(/|$)') THEN 'Wisconsin'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.wyoming\\.gov(/|$)|(?i)\\.wy\\.gov(/|$)') THEN 'Wyoming'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.dc\\.gov(/|$)') THEN 'DC'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pr\\.gov(/|$)') THEN 'Puerto Rico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.guam\\.gov(/|$)') THEN 'Guam'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.americansamoa\\.gov(/|$)') THEN 'American Samoa'

      -- North American Federal Governments
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.va\\.gov(/|$)') THEN 'USA VA.gov'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cms\\.gov(/|$)') THEN 'USA CMS.gov'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov(/|$)|(?i)\\.us(/|$)') THEN 'United States (USA)' -- States and specific departments are listed first to make them distinct.
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mil(/|$)') THEN 'USA Military'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gob\\.mx(/|$)') THEN 'Mexico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gc\\.ca(/|$)|(?i)\\.canada\\.ca(/|$)|(?i)\\.alberta\\.ca(/|$)|(?i)\\.gov\\.ab\\.ca(/|$)|(?i)\\.gov\\.bc\\.ca(/|$)|(?i)\\.manitoba\\.ca(/|$)|(?i)\\.gov\\.mb\\.ca(/|$)|(?i)\\.gnb\\.ca(/|$)|(?i)\\.gov\\.nb\\.ca(/|$)|(?i)\\.gov\\.nl\\.ca(/|$)|(?i)\\.novascotia\\.ca(/|$)|(?i)\\.gov\\.ns\\.ca(/|$)|(?i)\\.ontario\\.ca(/|$)|(?i)\\.gov\\.on\\.ca(/|$)|(?i)\\.gov\\.pe\\.ca(/|$)|(?i)\\.quebec\\.ca(/|$)|(?i)\\.gouv\\.qc\\.ca(/|$)|(?i)\\.revenuquebec\\.ca(/|$)|(?i)\\.saskatchewan\\.ca(/|$)|(?i)\\.gov\\.sk\\.ca(/|$)|(?i)\\.gov\\.nt\\.ca(/|$)|(?i)\\.gov\\.nu\\.ca(/|$)|(?i)\\.yukon\\.ca(/|$)|(?i)\\.gov\\.yk\\.ca') THEN 'Canada'

      -- European Countries
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.al(/|$)') THEN 'Albania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ax(/|$)') THEN 'Åland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ad(/|$)|(?i)\\.govern\\.ad(/|$)|(?i)\\.exteriors\\.ad(/|$)|(?i)\\.consellgeneral\\.ad(/|$)') THEN 'Andorra'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.am(/|$)') THEN 'Armenia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gv\\.at(/|$)') THEN 'Austria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.az(/|$)') THEN 'Azerbaijan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.eus(/|$)') THEN 'Basque Country'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.by(/|$)') THEN 'Belarus'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.belgium\\.be(/|$)|(?i)\\.gov\\.be(/|$)|(?i)\\.fgov\\.be(/|$)|(?i)\\.vlaanderen\\.be(/|$)|(?i)\\.wallonie\\.be(/|$)|(?i)\\.brussels\\.be(/|$)|(?i)\\.mil\\.be(/|$)') THEN 'Belgium'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ba(/|$)') THEN 'Bosnia and Herzegovina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.government\\.bg(/|$)') THEN 'Bulgaria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.hr(/|$)') THEN 'Croatia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cy(/|$)') THEN 'Cyprus'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.cz(/|$)') THEN 'Czechia (Czech Republic)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.dk(/|$)|(?i)\\.ft\\.dk(/|$)|(?i)\\.nemkonto\\.dk(/|$)|(?i)\\.nemlog-in\\.dk(/|$)|(?i)\\.mitid\\.dk(/|$)|(?i)\\.digst\\.dk(/|$)|(?i)\\.sikkerdigital\\.dk(/|$)|(?i)\\.forsvaret\\.dk(/|$)|(?i)\\.skat\\.dk(/|$)|(?i)\\.stps\\.dk(/|$)|(?i)\\.ufm\\.dk(/|$)|(?i)\\.urm\\.dk(/|$)|(?i)\\.uvm\\.dk(/|$)|(?i)\\.politi\\.dk(/|$)|(?i)\\.dataetiskraad\\.dk(/|$)|(?i)\\.at\\.dk(/|$)|(?i)\\.kum\\.dk(/|$)') THEN 'Denmark'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.riik\\.ee(/|$)|(?i)\\.riigiteataja\\.ee(/|$)|(?i)\\.eesti\\.ee(/|$)|(?i)\\.valitsus\\.ee(/|$)') THEN 'Estonia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.fi(/|$)|(?i)\\.valtioneuvosto\\.fi(/|$)|(?i)\\.minedu\\.fi(/|$)|(?i)\\.formin\\.fi(/|$)|(?i)\\.intermin\\.fi(/|$)|(?i)\\.suomi\\.fi(/|$)|(?i)\\.ym\\.fi(/|$)|(?i)\\.stm\\.fi(/|$)|(?i)\\.tem\\.fi(/|$)|(?i)\\.lvm\\.fi(/|$)|(?i)\\.mmm\\.fi(/|$)|(?i)\\.okm\\.fi(/|$)|(?i)\\.vm\\.fi(/|$)|(?i)\\.defmin\\.fi(/|$)|(?i)\\.oikeusministerio\\.fi(/|$)|(?i)\\.um\\.fi(/|$)|(?i)\\.vero\\.fi(/|$)|(?i)\\.kela\\.fi(/|$)') THEN 'Finland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gouv\\.fr(/|$)') THEN 'France'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ge(/|$)') THEN 'Georgia Country'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bund\\.de(/|$)') THEN 'Germany'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gi(/|$)') THEN 'Gibraltar'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.gr(/|$)') THEN 'Greece'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.hu(/|$)') THEN 'Hungary'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.is(/|$)') THEN 'Iceland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ie(/|$)') THEN 'Ireland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.im(/|$)') THEN 'Isle of Man'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.it(/|$)|(?i)\\.governo\\.it(/|$)') THEN 'Italy'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kz(/|$)') THEN 'Kazakhstan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.lv(/|$)') THEN 'Latvia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.li(/|$)') THEN 'Liechtenstein'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.lt(/|$)|(?i)\\.vrm\\.lt(/|$)|(?i)\\.sam\\.lt(/|$)|(?i)\\.ukmin\\.lt(/|$)|(?i)\\.lrv\\.lt(/|$)|(?i)\\.uzt\\.lt(/|$)|(?i)\\.migracija\\.lt(/|$)|(?i)\\.kam\\.lt(/|$)|(?i)\\.lrs\\.lt(/|$)|(?i)\\.urm\\.lt(/|$)') THEN 'Lithuania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.public\\.lu(/|$)|(?i)\\.etat\\.lu(/|$)') THEN 'Luxembourg'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mt(/|$)') THEN 'Malta'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.md(/|$)') THEN 'Moldova'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mc(/|$)') THEN 'Monaco'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.me(/|$)') THEN 'Montenegro'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.nl(/|$)|(?i)\\.overheid\\.nl(/|$)|(?i)\\.mijnoverheid\\.nl(/|$)') THEN 'Netherlands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mk(/|$)') THEN 'Macedonia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.no(/|$)') THEN 'Norway'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.pl(/|$)') THEN 'Poland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.pt(/|$)') THEN 'Portugal'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ro(/|$)') THEN 'Romania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.ru(/|$)|(?i)\\.govvrn\\.ru(/|$)') THEN 'Russia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sm(/|$)') THEN 'San Marino'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.rs(/|$)') THEN 'Serbia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.sk(/|$)') THEN 'Slovakia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.si(/|$)') THEN 'Slovenia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.es|gob\\.es|ine\\.es|boe\\.es(/|$)') THEN 'Spain'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sj(/|$)') THEN 'Svalbard and Jan Mayen Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.se(/|$)|(?i)\\.1177\.se(/|$)|(?i)\\.funktionstjanster\\.se(/|$)|(?i)\\.hemnet\\.se(/|$)|(?i)\\.smhi\\.se(/|$)|(?i)\\.sverigesradio\\.se(/|$)|(?i)\\.klart\\.se(/|$)|(?i)\\.bankid\\.com(/|$)|(?i)\\.synonymer\\.se(/|$)|(?i)\\.arbetsformedlingen\\.se(/|$)|(?i)\\.skatteverket\\.se(/|$)|(?i)\\.schoolsoft\\.se(/|$)|(?i)\\.postnord\\.se(/|$)|(?i)\\.grandid\\.com(/|$)|(?i)\\.viaplay\\.se(/|$)|(?i)\\.skola24\.se(/|$)|(?i)\\.forsakringskassan\\.se(/|$)|(?i)\\.vklass\\.se|sl\\.se(/|$)|(?i)\\.familjeliv\\.se((/|$)|(?i)\\.$)') THEN 'Sweden'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.admin\\.ch(/|$)') THEN 'Switzerland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gv\\.ua(/|$)') THEN 'Ukraine'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.uk(/|$)') THEN 'United Kingdom (UK)'

      -- Other Countries
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.af(/|$)') THEN 'Afghanistan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.dz(/|$)') THEN 'Algeria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.as(/|$)') THEN 'American Samoa'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ao(/|$)') THEN 'Angola'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ai(/|$)') THEN 'Anguilla'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.aq(/|$)') THEN 'Antarctica'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ag(/|$)') THEN 'Antigua and Barbuda'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gub\\.ar(/|$)|(?i)\\.gov\\.ar(/|$)') THEN 'Argentina'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.aw(/|$)') THEN 'Aruba'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ac(/|$)') THEN 'Ascension Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.au(/|$)') THEN 'Australia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bs(/|$)') THEN 'Bahamas'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bh(/|$)') THEN 'Bahrain'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bd(/|$)') THEN 'Bangladesh'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bb(/|$)') THEN 'Barbados'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bz(/|$)') THEN 'Belize'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bj(/|$)') THEN 'Benin'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bm(/|$)') THEN 'Bermuda'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bt(/|$)') THEN 'Bhutan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bo(/|$)') THEN 'Bolivia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bq(/|$)') THEN 'Bonaire'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bw(/|$)') THEN 'Botswana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bv(/|$)') THEN 'Bouvet Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.br(/|$)') THEN 'Brazil'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.io(/|$)') THEN 'British Indian Ocean Territory'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.vg(/|$)') THEN 'British Virgin Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bn(/|$)') THEN 'Brunei'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bf(/|$)') THEN 'Burkina Faso'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mm(/|$)') THEN 'Burma (officially: Myanmar)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.bi(/|$)') THEN 'Burundi'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kh(/|$)') THEN 'Cambodia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cm(/|$)') THEN 'Cameroon'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ca(/|$)') THEN 'Canada'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cv(/|$)') THEN 'Cape Verde (in Portuguese: Cabo Verde)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cat(/|$)') THEN 'Catalonia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ky(/|$)') THEN 'Cayman Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cf(/|$)') THEN 'Central African Republic'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.td(/|$)') THEN 'Chad'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cl(/|$)') THEN 'Chile'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cn(/|$)') THEN 'China'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cx(/|$)') THEN 'Christmas Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cc(/|$)') THEN 'Cocos (Keeling) Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.co(/|$)') THEN 'Colombia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.km(/|$)') THEN 'Comoros'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cd(/|$)') THEN 'Congo, Democratic Republic of the (Congo-Kinshasa)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cg(/|$)') THEN 'Congo, Republic of the (Congo-Brazzaville)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ck(/|$)') THEN 'Cook Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cr(/|$)') THEN 'Costa Rica'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ci(/|$)') THEN 'Ivory Coast'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cu(/|$)') THEN 'Cuba'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.cw(/|$)') THEN 'Curaçao'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.dj(/|$)') THEN 'Djibouti'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.dm(/|$)') THEN 'Dominica'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.do(/|$)') THEN 'Dominican Republic'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tl(/|$)') THEN 'East Timor (Timor-Leste)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tp(/|$)') THEN 'East Timor (Timor-Leste)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ec(/|$)') THEN 'Ecuador'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.eg(/|$)') THEN 'Egypt'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sv(/|$)') THEN 'El Salvador'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gq(/|$)') THEN 'Equatorial Guinea'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.er(/|$)') THEN 'Eritrea'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.et(/|$)') THEN 'Ethiopia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.eu(/|$)') THEN 'European Union'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.fk(/|$)') THEN 'Falkland Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.fo(/|$)') THEN 'Faeroe Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.fm(/|$)') THEN 'Federated States of Micronesia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.fj(/|$)') THEN 'Fiji'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gf(/|$)') THEN 'French Guiana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pf(/|$)') THEN 'French Polynesia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tf(/|$)') THEN 'French Southern and Antarctic Lands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ga(/|$)') THEN 'Gabon'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gal(/|$)') THEN 'Galicia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gm(/|$)') THEN 'Gambia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ps(/|$)') THEN 'Gaza'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gh(/|$)') THEN 'Ghana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gl(/|$)') THEN 'Greenland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gd(/|$)') THEN 'Grenada'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gp(/|$)') THEN 'Guadeloupe'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gu(/|$)') THEN 'Guam'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gt(/|$)') THEN 'Guatemala'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gg(/|$)') THEN 'Guernsey'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gn(/|$)') THEN 'Guinea'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gw(/|$)') THEN 'Guinea-Bissau'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gy(/|$)') THEN 'Guyana'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ht(/|$)') THEN 'Haiti'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.hm(/|$)') THEN 'Heard Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.hn(/|$)') THEN 'Honduras'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.hk(/|$)') THEN 'Hong Kong'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gov\\.in(/|$)|(?i)\\.nic\\.in(/|$)') THEN 'India'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.id(/|$)') THEN 'Indonesia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ir(/|$)') THEN 'Iran'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.iq(/|$)') THEN 'Iraq'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.il(/|$)') THEN 'Israel'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.it(/|$)') THEN 'Italy'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.jm(/|$)') THEN 'Jamaica'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.jp(/|$)') THEN 'Japan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.je(/|$)') THEN 'Jersey'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.jo(/|$)') THEN 'Jordan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ke(/|$)') THEN 'Kenya'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ki(/|$)') THEN 'Kiribati'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kw(/|$)') THEN 'Kuwait'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kg(/|$)') THEN 'Kyrgyzstan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.la(/|$)') THEN 'Laos'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.lb(/|$)') THEN 'Lebanon'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ls(/|$)') THEN 'Lesotho'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.lr(/|$)') THEN 'Liberia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ly(/|$)') THEN 'Libya'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mo(/|$)') THEN 'Macau'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mg(/|$)') THEN 'Madagascar'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mw(/|$)') THEN 'Malawi'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.my(/|$)') THEN 'Malaysia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mv(/|$)') THEN 'Maldives'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ml(/|$)') THEN 'Mali'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mh(/|$)') THEN 'Marshall Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mq(/|$)') THEN 'Martinique'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mr(/|$)') THEN 'Mauritania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mu(/|$)') THEN 'Mauritius'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.yt(/|$)') THEN 'Mayotte'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mx(/|$)') THEN 'Mexico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mn(/|$)') THEN 'Mongolia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ms(/|$)') THEN 'Montserrat'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ma(/|$)') THEN 'Morocco'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mz(/|$)') THEN 'Mozambique'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mm(/|$)') THEN 'Myanmar'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.na(/|$)') THEN 'Namibia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nr(/|$)') THEN 'Nauru'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.np(/|$)') THEN 'Nepal'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nl(/|$)') THEN 'Netherlands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nc(/|$)') THEN 'New Caledonia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nz(/|$)') THEN 'New Zealand'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ni(/|$)') THEN 'Nicaragua'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ne(/|$)') THEN 'Niger'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ng(/|$)') THEN 'Nigeria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nu(/|$)') THEN 'Niue'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.nf(/|$)') THEN 'Norfolk Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kp(/|$)') THEN 'North Korea'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.mp(/|$)') THEN 'Northern Mariana Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.om(/|$)') THEN 'Oman'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pk(/|$)') THEN 'Pakistan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pw(/|$)') THEN 'Palau'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ps(/|$)') THEN 'Palestine'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pa(/|$)') THEN 'Panama'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pg(/|$)') THEN 'Papua New Guinea'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.py(/|$)') THEN 'Paraguay'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pe(/|$)') THEN 'Peru'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ph(/|$)') THEN 'Philippines'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pn(/|$)') THEN 'Pitcairn Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pr(/|$)') THEN 'Puerto Rico'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.qa(/|$)') THEN 'Qatar'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.rw(/|$)') THEN 'Rwanda'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.re(/|$)') THEN 'Réunion Island'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sh(/|$)') THEN 'Saint Helena'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kn(/|$)') THEN 'Saint Kitts and Nevis'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.lc(/|$)') THEN 'Saint Lucia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.pm(/|$)') THEN 'Saint-Pierre and Miquelon'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.vc(/|$)') THEN 'Saint Vincent and the Grenadines'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ws(/|$)') THEN 'Samoa'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.st(/|$)') THEN 'São Tomé and Príncipe'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sa(/|$)') THEN 'Saudi Arabia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sn(/|$)') THEN 'Senegal'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sc(/|$)') THEN 'Seychelles'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sl(/|$)') THEN 'Sierra Leone'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sg(/|$)') THEN 'Singapore'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sx(/|$)') THEN 'Sint Maarten'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sb(/|$)') THEN 'Solomon Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.so(/|$)') THEN 'Somalia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.za(/|$)') THEN 'South Africa'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.gs(/|$)') THEN 'South Georgia and the South Sandwich Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.kr(/|$)') THEN 'South Korea'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ss(/|$)') THEN 'South Sudan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.es(/|$)') THEN 'Spain'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.lk(/|$)') THEN 'Sri Lanka'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sd(/|$)') THEN 'Sudan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sr(/|$)') THEN 'Suriname'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sz(/|$)') THEN 'Swaziland'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.se(/|$)') THEN 'Sweden'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.sy(/|$)') THEN 'Syria'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tw(/|$)') THEN 'Taiwan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tj(/|$)') THEN 'Tajikistan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tz(/|$)') THEN 'Tanzania'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.th(/|$)') THEN 'Thailand'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tg(/|$)') THEN 'Togo'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tk(/|$)') THEN 'Tokelau'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.to(/|$)') THEN 'Tonga'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tt(/|$)') THEN 'Trinidad & Tobago'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tn(/|$)') THEN 'Tunisia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tr(/|$)') THEN 'Turkey'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tm(/|$)') THEN 'Turkmenistan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tc(/|$)') THEN 'Turks and Caicos Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.tv(/|$)') THEN 'Tuvalu'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ug(/|$)') THEN 'Uganda'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ua(/|$)') THEN 'Ukraine'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ae(/|$)') THEN 'United Arab Emirates (UAE)'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.vi(/|$)') THEN 'United States Virgin Islands'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.uy(/|$)') THEN 'Uruguay'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.uz(/|$)') THEN 'Uzbekistan'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.vu(/|$)') THEN 'Vanuatu'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.va(/|$)') THEN 'Vatican City'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ve(/|$)') THEN 'Venezuela'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.vn(/|$)') THEN 'Vietnam'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.wf(/|$)') THEN 'Wallis and Futuna'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.eh(/|$)') THEN 'Western Sahara'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.ye(/|$)') THEN 'Yemen'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.zm(/|$)') THEN 'Zambia'
      WHEN REGEXP_CONTAINS(page, r'(?i)\\.zw(/|$)') THEN 'Zimbabwe'
      ELSE 'Other'
    END AS gov_domain,
    is_root_page,
    performance_score,
    accessibility_score,
    best_practices_score,
    seo_score,
    wptid
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

      '|(\\w+\\.)*\\.govern\\.ad(/|$)'  -- Andorra
      '|(\\w+\\.)*\\.exteriors\\.ad(/|$)'
      '|(\\w+\\.)*\\.consellgeneral\\.ad(/|$)'

      ')')
)

SELECT
  gov_domain,
  page,
  is_root_page,
  performance_score,
  accessibility_score,
  best_practices_score,
  seo_score,
  wptid
FROM
  domain_scores
WHERE gov_domain IS NOT NULL
ORDER BY gov_domain;
