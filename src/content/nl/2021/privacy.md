---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Privacy
description: Privacyhoofdstuk van de Web Almanac 2021 over het gebruik en de impact van online tracking, privacyvoorkeurssignalen en browserinitiatieven voor een privacyvriendelijker web.
authors: [ydimova, victorlep]
reviewers: [maudnals]
analysts: [victorlep, max-ostapenko]
editors: [tunetheweb]
translators: [victorlep]
results: https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/
ydimova_bio: Yana Dimova is een doctoraatsstudente bij imec-DistriNet, waar ze werkt rond privacy op het web. Haar algemene interesses en werk focussen op online tracking, privacykwetsbaarheden en privacywetgeving en -beleid.
victorlep_bio: Victor Le Pochat is een doctoraatsstudent bij de <a hreflang="en" href="https://distrinet.cs.kuleuven.be/">imec-DistriNet</a>-onderzoeksgroep van KU Leuven in België. Zijn interesses liggen bij het bestuderen van webecosystemen, en in de methodologie van webbeveiligings- en privacyonderzoek, zowel het analyseren als verbeteren van de huidige methodes.
featured_quote: Browsers effenen het pad voor betere gebruikersprivacy&colon; Firefox en Safari hebben al verbeterde bescherming tegen volgen gelanceerd, terwijl Chrome nieuwe privacybeschermende technologieën voorstelt die openlijk besproken worden en door website-eigenaars getest kunnen worden.
featured_stat_1: 82,08%
featured_stat_label_1: Mobiele websites die minstens één tracker bevatten
featured_stat_2: 39,70%
featured_stat_label_2: Mobiele websites die een privacybeleidlink bevatten
featured_stat_3: 4,10%
featured_stat_label_3: Populaire sites die zich afmelden voor FLoC-cohorten
---

## Inleiding

[_"Op het internet weet niemand dat je een hond bent."_](https://en.wikipedia.org/wiki/On_the_Internet,_nobody_knows_you%27re_a_dog) Hoewel het enigszins waar is dat je anoniem kunt proberen blijven om het internet als dusdanig te gebruiken, kan het redelijk moeilijk zijn om je persoonlijke gegevens volledig privé te houden.

Een [hele industrie](https://crackedlabs.org/en/corporate-surveillance/) is toegewijd aan het online volgen van gebruikers, om gedetailleerde gebruikersprofielen te bouwen voor doeleinden als gerichte advertenties, fraudedetectie, prijsdifferentiatie, of zelfs kredietscores. Het delen van locatiegegevens met websites kan erg nuttig blijken in het dagelijkse leven, maar kan ook toelaten dat bedrijven <a hreflang="en" href="https://www.nytimes.com/interactive/2019/12/19/opinion/location-tracking-cell-phone.html">elke stap die je zet zien</a>. Zelfs als een dienst de privégegevens van een gebruiker zorgvuldig behandelt, biedt het louter opslaan van persoonlijke gegevens de kans aan hackers om <a hreflang="en" href="https://haveibeenpwned.com/">diensten te kraken en miljoenen persoonlijke gegevens online te lekken</a>.

Recente wetgevende initiatieven zoals de <a hreflang="nl" href="https://ec.europa.eu/info/law/law-topic/data-protection/data-protection-eu_nl">AVG</a> in Europa, <a hreflang="en" href="https://www.oag.ca.gov/privacy/ccpa">CCPA</a> in Californië, <a hreflang="pt-br" href="https://www.gov.br/cidadania/pt-br/acesso-a-informacao/lgpd">LGPD</a> in Brazilië, of de <a hreflang="en" href="https://www.meity.gov.in/data-protection-framework">PDP-wet</a> in India streven er allemaal naar om van bedrijven te eisen dat ze persoonlijke gegevens beschermen en privacy standaard implementeren, inclusief online. Grote technologiebedrijven zoals Google, Facebook en Amazon hebben al <a hreflang="en" href="https://en.wikipedia.org/wiki/GDPR_fines_and_notices">gigantische boetes</a> gekregen voor vermeende privacyinbreuken.

Deze nieuwe wetten hebben gebruikers veel meer inspraak gegeven in hoe comfortabel ze zich voelen bij het delen van persoonlijk gegevens. Je hebt waarschijnlijk al op een heel aantal cookietoestemmingsbanners geklikt die deze keuze toelaten. Daarenboven implementeren webbrowsers <a hreflang="en" href="https://privacysandbox.com/">technologische oplossingen</a> om privacy te verbeteren, van het blokkeren van cookies van derden over het verbergen van gevoelige gegevens tot innovatieve manieren om legitiem gebruik van persoonlijke attributen te balanceren met de privacy van individuen.

In dit hoofdstuk geven we overzicht van de huidige staat van privacy op het web. We beschouwen eerst hoe gebruikersprivacy geschaad kan worden: we bespreken hoe websites je profileren door [online tracking](#hoe-website-jou-profileren-online-tracking), en hoe ze [toegang krijgen tot jouw gevoelige gegevens](#hoe-websites-jouw-gevoelige-gegevens-behandelen). We kijken dan naar de impact van tools die gebruikers in staat stellen om hun privacy te beschermen. Daarna gaan we dieper in op de manieren waarop websites [gevoelige gegevens beschermen](#hoe-websites-jouw-gevoelige-gegevens-beschermen) en jou een keuze geven via [privacyvoorkeurssignalen](#hoe-websites-jou-een-privacykeuze-geven-privacyvoorkeurssignalen). We eindigen met een [vooruitblik op de inspanningen die browsers leveren om jouw privacy in de toekomst te vrijwaren](#hoe-browsers-hun-privacyaanpak-evolueren).


## Hoe website jou profileren: online tracking

Het [HTTP](./http)-protocol is inherent toestandsloos, dus standaard is er geen manier voor een website om te weten of twee bezoeken op twee verschillende websites, of zelfs twee bezoeken op dezelfde website, van dezelfde gebruiker komen. Zulke informatie zou echter nuttig kunnen zijn voor websites om meer gepersonaliseerde gebruikerservaringen te bouwen, en voor derden die profielen van gebruikersgedrag over websites heen opbouwen om inhoud op het web te financieren via gerichte advertenties of om diensten te verlenen zoals fraudedetectie.

Helaas berust het verkrijgen van deze informatie momenteel vaak op online tracking, waarrond [vele grote en kleine bedrijven hun handel hebben opgebouwd](https://crackedlabs.org/en/corporate-surveillance/). Dit heeft zelf geleid tot <a hreflang="en" href="https://www.forbrukerradet.no/wp-content/uploads/2021/06/20210622-final-report-time-to-ban-surveillance-based-advertising.pdf">oproepen om gerichte advertenties te verbieden</a>, aangezien ingrijpende tracking niet verenigbaar is met gebruikersprivacy. Gebruikers willen mogelijk niet dat eender wie hun sporen op het web kan volgen—in het bijzonder als ze websites rond gevoelige onderwerpen bezoeken. We zullen kijken naar de voornaamste bedrijven en technologieën die het onlinetrackingecosysteem vormen.

### Tracking door derden

Online tracking wordt vaak gedaan via bibliotheken van derden. Deze bibliotheken voorzien gewoonlijk een (nuttige) dienst, maar sommigen genereren daarbij ook een uniek identificatienummer voor elke gebruiker, dat dan gebruikt kan worden om gebruikers over websites heen te volgen en profileren. Het <a hreflang="en" href="https://whotracks.me/">WhoTracksMe</a>-project is toegewijd aan het ontdekken van de meest wijdverspreide online trackers. We gebruiken WhoTracksMe's classificatie van trackers maar beperken ons tot vier <a hreflang="en" href="https://whotracks.me/blog/tracker_categories.html">categorieën</a>, omdat deze het meest waarschijnlijk diensten omvatten waar tracking deel uitmaakt van hun voornaamste doel: _advertenties_, _pornoadvertenties_, _siteanalytics_ en _sociale media_.

{{ figure_markup(
  image="most_common_trackers.png",
  caption="10 populairste trackers en hun voorkomen.",
  description="Staafdiagram dat de 10 populairste trackers en het percentage van websites op mobiel en desktop dat deze bevat toont. Google_analytics (site_analytics) wordt gebruikt op 66,01% van desktop en 62,53% van mobiele sites, google (advertising) op respectievelijk 50,89% en 49,51%, doubleclick (advertising) op 49,99% en 47,51%, facebook (advertising) op 30,71% en 29,04%, google_adservices (advertising) op 21,17% en 19,98%, google_syndication (advertising) op 11,12% en 11,91%, wordpress_stats (site_analytics) op 6,63% en 6,79%, twitter (social_media) op 6,42% en 5,48%, adobe_audience_manager (advertising) op 4,35% en 5,49%, en ten slotte yandex (advertising) op 4,50% en 5,28%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=290736860&format=interactive",
  sheets_gid="1466954359",
  sql_file="most_common_trackers.sql",
  width=600,
  height=580
  )
}}

We zien dat domeinen die eigendom zijn van Google alomtegenwoordig zijn op de onlinetrackingmarkt. Google Analytics, dat websiteverkeer rapporteert, is aanwezig op bijna twee derde van alle websites. Rond de 30% van websites bevatten Facebook-bibliotheken, terwijl andere trackers minder dan 10% halen.

{{ figure_markup(
  image="most_common_tracker_categories.png",
  caption="Meest voorkomende trackercategorieën.",
  description="Staafdiagram dat de populairste trackercategorieën en het aantal websites dat een tracker uit die categorie bevat toont. 83,33% van desktopsites en 82,08% van mobiele sites gebruiken een tracker. `site_analytics` wordt gebruikt op respectievelijk 73,53% en 70,46%, `advertising` op 68,83% en 67,99%, `social_media` op 12,89% en 11,66%, en ten slotte  `pornvertising` op 0,56% en 0,60%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1126546581&format=interactive",
  sheets_gid="2084631443",
  sql_file="most_common_tracker_categories.sql",
  width=600,
  height=421
  )
}}

Over het algemeen bevatten 82,08% van mobiele sites en 83,33% van desktopsites minstens één tracker, meestal voor siteanalytics of advertentiedoeleinden.

{{ figure_markup(
  image="nb_websites_with_nb_trackers.png",
  caption="Het aantal trackers per website.",
  description="Lijndiagram dat het aantal trackers per websites toont, beginnend bij 15,62% van desktopsites en 16,31% van mobiele sites die één tracker hebben en naar beneden buigend voorbij respectievelijk 9,30% en 8,64% voor 5%, 0,38% en 0,41% voor 15 trackers en dan een lange staart afgekapt op 0,12% en 0,15% voor 25 trackers. Mobiel en desktop hebben doorlopend bijna identieke aantallen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=268105548&format=interactive",
  sheets_gid="690197217",
  sql_file="number_of_websites_with_nb_trackers.sql"
  )
}}

Drie op vier websites hebben minder dan 10 trackers, maar er is een lange staart van sites met veel meer trackers: één desktopsite contacteert 133 (!) verschillende trackers.

### Cookies van derden

De voornaamste technische aanpak om identificatienummers voor gebruikers op te slaan en op te vragen over sites heen is via cookies die blijvend opgeslagen worden in jouw browser. Merk op dat hoewel cookies van derden vaak gebruikt worden voor tracking over sites heen, ze ook gebruikt kunnen worden voor niet-trackingdoeleinden, zoals het delen van gegevens voor een widget van een derde over sites heen. We zochten naar de cookies die het vaakst voorkwamen tijdens het browsen van het web, en de domeinen die ze plaatsen.

{{ figure_markup(
  image="top100_domains_that_set_cookies_via_response_header.png",
  caption="Top 10 domeinen die cookies zetten vanuit headers.",
  description="Grafiek die het percentage toont van websites die een cookie zetten via een antwoordheader voor de 10 populairste trackingdomeinen die cookies zetten. `doubleclick.net` wordt gebruikt op 30,49% van desktoppagina's en 28,72% van mobiele pagina's, `facebook.com` respectievelijk op 23.07 en 21,43%, `youtube.com` op 10,02% en 8,83%, `google.com` op 8,62% en 8,45%, `yandex.ru` op 4,42% en 5,17%, `pubmatic.com` op 3,82% en 4,73%, `rlcdn.com` op 4,01% en 3,99%, `openx.net` op 3,57% en 4,42%, `adsrvr.org` op 4,00% en 3,90%, en ten slotte `yahoo.com` op 3,80% en 3,70%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=162165227&format=interactive",
  sheets_gid="1256177287",
  sql_file="top100_domains_that_set_cookies_via_response_header.sql",
  width=600,
  height=580
  )
}}

Googles dochteronderneming DoubleClick staat op de eerste plaats door cookies te zetten op 31,4% van desktopwebsites en 28,7% van mobiele websites. Een andere voorname speler is Facebook, die cookies opslaat op 21,4% van mobiele websites. De meeste andere topdomeinen die cookies zetten zijn verwant aan online advertenties.

{{ figure_markup(
  image="top100_cookies_set_from_header.png",
  caption="Top 10 cookies gezet vanuit headers.",
  description="Grafiek die de naam toont van de cookies die gezet worden op het grootste aantal websites. Deze cookies lijken vaker gezet te worden op desktopsites dan op mobiele sites. `test_cookie` voor doubleclick.net wordt gebruikt door 30,20% van desktopsites en 28,66% van mobiele sites, `fr` voor facebook.com door respectievelijk 23,04% en 20,96%, `IDE` voor doubleclick.net door 18,03% en 16,96%, `NID` voor google.com door 4,92% en 5,09%, `yandexuid` voor yandex.ru door 4,38% en 5,14%, `yuidss` voor yandex.ru door 4,38% en 5,14%, `i` voor yandex.ru door 4,34% en 5,09%, `ymex` voor yandex.ru door 4,32% en 5,08%, `yabs-sid` voor yandex.ru door 4,32% en 5,08%, `TDID` voor adsrvr.org door 3,71% en 3,89%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2052032481&format=interactive",
  sheets_gid="1599373042",
  sql_file="top100_cookies_set_from_header.sql",
  width=600,
  height=580
  )
}}

Als we kijken naar de specifieke cookies die deze websites zetten, is de meest voorkomende cookie van een tracker de `test_cookie` van doubleclick.net. De volgende meest voorkomende cookies zijn verwant aan advertenties en blijven veel langer aanwezig op het toestel van een gebruiker: Facebooks `fr`-cookie blijft gedurende <a hreflang="en" href="https://www.facebook.com/policy/cookies/">90 dagen</a>, terwijl DoubleClicks `IDE`-cookie voor <a hreflang="en" href="https://business.safety.google/adscookies/">13 maanden in Europa en 2 jaar elders</a> blijft.

Nu `Lax` de standaardwaarde van het <a hreflang="en" href="https://web.dev/samesite-cookies-explained/">`SameSite`-cookieattribuut</a> wordt, moeten sites die cookies van derden willen blijven delen dit attribuut expliciet op `None` zetten. Voor derden hebben 85% op mobiel en 64% op desktop dit reeds gedaan, mogelijk voor trackingdoeleinden. Je kan meer over het `SameSite`-cookieattribuut lezen in het [Beveiligingshoofdstuk](./security#samesite).


### Fingerprinting

Met de opkomst van privacybeschermende tools zoals adblockers en initiatieven van grote browsers zoals [Firefox](https://blog.mozilla.org/en/products/firefox/todays-firefox-blocks-third-party-tracking-cookies-and-cryptomining-by-default/), <a hreflang="en" href="https://webkit.org/blog/10218/full-third-party-cookie-blocking-and-more/">Safari</a>, en vanaf 2023 ook <a hreflang="en" href="https://blog.google/products/chrome/updated-timeline-privacy-sandbox-milestones/#:~:text=Chrome%20could%20then%20phase%20out%20third-party%20cookies%20over%20a%20three%20month%20period%2C%20starting%20in%20mid-2,23%20and%20ending%20in%20late%202023">Chrome</a> om cookies van derden uit te faseren, zijn trackers op zoek naar meer hardnekkige en verdoken manieren om gebruikers over sites heen te volgen.

Een van die technieken is _browser fingerprinting_ (letterlijk: "vingerafdrukken"). Een website verzamelt gegeven over een gebruikerstoestel, zoals de [user agent](https://developer.mozilla.org/docs/Glossary/User_agent), schermresolutie en geïnstalleerde lettertypes, en gebruikt de vaak unieke combinatie van deze waarden om een vingerafdruk te creëren. Deze vingerafdruk wordt opnieuw gecreëerd elke keer wanneer een gebruiker de website bezoekt en kan dan vergeleken worden om de gebruiker te identificeren. Hoewel deze methode gebruikt kan worden voor fraudedetectie, wordt ze ook gebruikt om terugkerende gebruikers aanhoudend te volgen, of om gebruikers te volgen over sites heen.

Het detecteren van fingerprinting is complex: het is effectief door een combinatie van methodeoproepen en _event listeners_ die ook gebruikt kunnen worden voor niet-trackingdoeleinden. In plaats van op deze individuele methoden te focussen, focussen we daarom op vijf populaire bibliotheken die het eenvoudig maken voor een website om fingerprinting te implementeren.

{{ figure_markup(
  image="nb_websites_using_each_fingerprinting.png",
  caption="Websites die elke bibliotheek voor fingerprinting gebruikt.",
  description="Grafiek die het percentage toont van websites die een van de fingerprintingbibliotheken bevatten. FingerprintJS wordt gebruikt door 0,74% van de desktopsites en 0,64% van de mobiele sites, ClientJS door respectievelijk 0,04% en 0,04%, MaxMind door 0,03% en 0,02%, TruValidate door 0,03% en 0,02%, ThreatMetrix door 0,00% en 0,00%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1537414997&format=interactive",
  sheets_gid="1785016530",
  sql_file="number_of_websites_using_each_fingerprinting.sql"
  )
}}

Op basis van het percentage van websites dat deze diensten van derden gebruikt, kunnen we zien dat de meest gebruikte bibliotheek, <a hreflang="en" href="https://fingerprintjs.com/">Fingerprint.js</a>, 19 keer meer gebruikt wordt op desktop dan de tweede populairste bibliotheek. Het algemene percentage van websites dat een externe bibliotheek gebruikt voor fingerprinting is echter vrij klein.

### CNAME-tracking

Verdergaand met technieken die blokkades op tracking door derden omzeilen, is <a hreflang="en" href="https://medium.com/nextdns/cname-cloaking-the-dangerous-disguise-of-third-party-trackers-195205dc522a">CNAME-tracking</a> een nieuwe aanpak waar een eerstepartijsubdomein het gebruik van een derdepartijdienst maskeert door een CNAME-record op [DNS-niveau](https://adguard.com/en/blog/cname-tracking.html) te gebruiken. Vanuit het standpunt van de browser gebeurt alles in een eerstepartijcontext, dus geen van de tegenmaatregelen voor derde partijen worden toegepast. Grote trackingbedrijven zoals Adobe en Orale bieden al CNAME-trackingoplossingen aan hun klanten aan. Voor de resultaten voor CNAME-gebaseerde tracking in dit hoofdstuk refereren we naar <a hreflang="en" href="https://sciendo.com/article/10.2478/popets-2021-0053">onderzoek</a> uitgevoerd door een van de auteurs van die hoofdstuk (en anderen) waar zij een methode hebben ontwikkeld om CNAME-gebaseerde tracking te detecteren, op basis van DNS-gegevens en verzoekgegevens van HTTP Archive.

{{ figure_markup(
  image="nb_sites_with_cname_tracking.png",
  caption="Websites die CNAME-gebaseerde tracking gebruiken op een desktopclient.",
  description="Grafiek die het aantal websites toont dat een CNAME-gebaseerde tracker gebruikt, gesorteerd op de populariteit van de tracker. Adobe Experience Cloud wordt gebruikt op 0,59% van de desktopsites en 0,41% van de mobiele sites, Pardot op respectievelijk 0,41% en 0,26%, Oracle Eloqua op 0,05% en 0,03%, Act-On Software op 0,05% en 0,03%, Webtrekk op 0,01% en 0,01%, en ten slotte Eulerian op 0,01% en 0,01%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=450379066&format=interactive",
  sheets_gid="1286114815",
  sql_file="nb_sites_with_cname_tracking.sql",
  width=600,
  height=516
  )
}}

Het populairste bedrijf dat CNAME-gebaseerde tracking uitvoert is Adobe, dat aanwezig is op 0,59% van desktopwebsites en 0,41% van mobiele websites. Ook opmerkelijk qua grootte is <a hreflang="en" href="https://www.pardot.com/">Pardot</a>, met respectievelijk 0,41% en 0,26%.

Deze getallen mogen kleine percentages lijken, maar die mening verandert wanneer we de gegevens opdelen op basis van websitepopulariteit.

{{ figure_markup(
  image="nb_sites_with_cname_tracking_per_rank.png",
  caption="Websites die CNAME-tracking gebruiken op rang.",
  description="Grafiek die het aantal websites toont dat CNAME-gebaseerde tracking gebruikt opgesplitst op hun populariteitsrang. Van de top 1.000 sites gebruiken 5,91% van de desktopsites en 5,53% van de mobiele sites CNAME-gebaseerde tracking, voor de top 10.000 is dit 5,67% en 5,35%, voor de top 100.000 is dit 2,95% en 2,78%, voor de top 1 miljoen is dit 1,31% en 1,21%, en ten slotte voor alle sites is dit 0.79 en 0,52%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2129255642&format=interactive",
  sheets_gid="518784663",
  sql_file="nb_sites_with_cname_tracking_per_rank.sql"
  )
}}

Wanneer we kijken naar de rang van de websites die CNAME-gebaseerde tracking gebruiken, zien we dat 5,53% van de top 1.000 websites op mobiel een CNAME-tracker bevatten. In de top 100.000 zakt dit tot 2,78% van de websites en wanneer we naar de volledige gegevens kijken zakt dit tot 0,52%.

{{ figure_markup(
  image="nb_sites_with_cname_tracking_per_public_suffix.png",
  caption="Publiek achtervoegsel van sites met CNAME-gebaseerde tracking.",
  description="Grafiek die het aantal websites toont dat CNAME-gebaseerde tracking gebruikt op een desktopclient, op basis van het publieke achtervoegsel van de website. 0,64% van de desktopwebsites en 0,42% van de mobiele websites met een `com`-achtervoegsel gebruiken CNAME-tracking, voor `edu` is dit respectievelijk 0,18% en 0,10%, voor `jp` it's 0,03% en 0,04%, voor `org` 0,04% en 0,03%, voor `co.jp` 0,03% en 0,02%, voor `ca` 0,02% en 0,01%, voor `de` 0,02% en 0,02%, voor `ru` 0,01% en 0,01%, voor `com.au` 0,02% en 0,01%, en ten slotte voor `edu.au` 0,02% en 0,01%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1816699194&format=interactive",
  sheets_gid="1155429637",
  sql_file="nb_sites_with_cname_tracking_per_public_suffix.sql",
  width=600,
  height=543
  )
}}

Afgezien van het `.com`-achtervoegsel, heeft een groot aantal van de websites die CNAME-gebaseerde tracking gebruikt een `.edu`-domein. Een opmerkelijk aantal CNAME-trackers is ook aanwezig op `.jp`- en `.org`-websites.

CNAME-gebaseerde tracking kan een tegenmaatregel zijn wanneer de gebruiker mogelijk beschermen tegen volgen door derden heeft ingeschakeld. Aangezien weinig trackerblokkerende tools en <a hreflang="en" href="https://www.cookiestatus.com/">browsers</a> al een verdediging tegen CNAME-tracking hebben geïmplementeerd, is het sterk aanwezig op een aantal websites tot op heden.

### (Re)targeting

_Advertisement retargeting_ refereert naar de praktijk om bij te houden welke producten een gebruiker bekeken maar niet gekocht heeft, en op te volgen met advertenties voor deze producten op verschillende websites. In plaats van te kiezen voor een agressieve marketingstrategie terwijl een gebruiker de website bezoekt, kiest de website ervoor om de gebruiker te overhalen om het product te kopen door deze voortdurend te herinneren aan het merk en product.

{{ figure_markup(
  image="nb_websites_using_each_retargeting.png",
  caption="Percentage van pagina's die een dienst voor retargeting gebruiken.",
  description="Staafdiagram dat de meest populaire diensten toont die gebruikt worden voor retargeting en het aantal websites dat die gebruikt. Google Remarketing Tag wordt gebruikt door 26,92% van de desktopsites en 26,64% van de mobiele sites, Criteo door respectievelijk 1,25% en 1,21%, AdRoll door 0,48% en 0,38%, SharpSpring Ads door 0,12% en 0,09%, Albacross door 0,04% en 0,03%, SteelHouse door 0,03% en 0,02%, Smarter Click door 0,02% en 0,01%, Blue door 0,02% en 0,01%, Cross Pixel door 0,02% en 0,01%, en ten slotte Picreel door 0,01% en 0,01%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=882622568&format=interactive",
  sheets_gid="1940290757",
  sql_file="number_of_websites_using_each_retargeting.sql",
  width=600,
  height=580
  )
}}

Een aantal trackers bieden een oplossing aan voor _retargeting_. De meest gebruikte, Google Remarketing Tag, is aanwezig op 26,92% van de websites op desktop en 26,64% van de websites op mobiel, ver boven alle andere diensten die elk door minder dan 1,25% van websites gebruikt worden.

## Hoe websites jouw gevoelige gegevens behandelen

Sommige websites vragen toegang tot specifieke functies en browser-API's die een impact kunnen hebben op de privacy van een gebruiker, bijvoorbeeld door het gebruiken van locatiegegevens, de microfoon, de camera, enz. Deze functies hebben meestal zeer nuttige toepassingen, zoals het ontdekken van nabijgelegen interessante locaties of het toelaten aan mensen om met elkaar te communiceren. Hoewel deze functie enkel worden geactiveerd wanneer een gebruiker toestemming geeft, is er een risico op het onthullen van gevoelige gegevens als een gebruiker niet volledig begrijpt hoe deze bronnen worden gebruikt, of als een website zich misdraagt.

We keken naar hoe vaak websites toegang vragen tot gevoelige bronnen. Daarnaast is er telkens wanneer een dienst gevoelige gegevens opslaat het gevaar dat hackers deze gegevens stelen en lekken. We zullen kijken naar recente gegevenslekken die aantonen dat dit gevaar reëel is.


### Toestelsensoren

Sensoren kunnen nuttig zijn om een website interactiever te maken maar kunnen ook misbruikt worden voor het <a hreflang="en" href="https://www.esat.kuleuven.be/cosic/publications/article-3078.pdf">fingerprinten van gebruikers</a>. Gebaseerd op het gebruik van JavaScript _event listeners_, wordt de oriëntatie van het toestel het meest opgevraagd, zowel op mobiel als op desktop. Merk op dat we zochten naar de aanwezigheid van _event listeners_ op websites, maar we weten niet of deze code effectief werd uitgevoerd. Het gebruik van toestelsensoren is in deze sectie daarom een bovengrens.

{{ figure_markup(
  image="nb_websites_with_device_sensor_events.png",
  caption="5 meest gebruikte sensorevents.",
  description="Staafdiagram dat de meest gebruikte sensorevents toont, gebaseerd op het gebruik van JavaScript _event listeners_. `deviceOrientation` wordt gevonden op 3,32% van de desktopsites en 3,23% van de mobiele sites, `deviceReady` op 1,12% en 1,23%, `devicemotion` op 0,65% en 0,66%, `deviceChange` op 0,03% en 0,02%, en ten slotte  `deviceproximity` op 0,03% en 0,02%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=40988621&format=interactive",
  sheets_gid="1513080238",
  sql_file="number_of_websites_with_device_sensor_events.sql"
  )
}}

### Mediatoestellen

De [MediaDevices API](https://developer.mozilla.org/docs/Web/API/MediaDevices) kan gebruikt worden om toegang te krijgen tot aangesloten media-invoerbronnen zoals camera's, microfoon en het delen van een scherm.

{{ figure_markup(
  caption="Percentage van desktoppagina's dat de `MediaDevicesEnumerateDevices`-API gebruikte.",
  content="7,23%",
  classes="big-number",
  sheets_gid="2141743069",
  sql_file="number_of_websites_with_mediadevices_blink_usage.sql"
)
}}

Op 7,23% van de desktopwebsites en 5,33% van de mobiele websites wordt de `enumerateDevices()`-methode opgeroepen, die een lijst teruggeeft van de aangesloten invoerbronnen.

### Geolocation-as-a-service

Geolocatiediensten voorzien GPS- en andere locatiegegevens (zoals [IP-adres](https://developer.mozilla.org/docs/Glossary/IP_Address)) van een gebruiker en kunnen gebruikt worden door trackers om relevantere inhoud weer te geven aan de gebruiker, naast andere zaken. We analyseren daarom het gebruik van "geolocation-as-a-service"-technologieën op websites, gebaseerd op bibliotheken gedetecteerd met [Wappalyzer](./methodology#wappalyzer).

{{ figure_markup(
  image="nb_websites_using_each_geolocation.png",
  caption="Percentage van websites die geolocatiediensten gebruiken.",
  description="Diagram dat het percentage van websites toont dat elk van de geolocatiediensten gebruikt. ipify wordt gebruik door 0,09% van de desktopsites en 0,07% van de mobiele sites, MaxMind door respectievelijk 0,03% en 0,02%, db-ip door 0,01% en 0,01%, en ten slotte ipstack door 0,01% en 0,01%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2115506749&format=interactive",
  sheets_gid="1274602607",
  sql_file="number_of_websites_using_each_geolocation.sql"
  )
}}

We zien dat de populairste dienst, <a hreflang="en" href="https://www.ipify.org/">ipify</a>, wordt gebruikt op 0,09% van de desktopwebsites en 0,07% van de mobiele websites. Het lijkt er dus op dat weinig websites locatiediensten gebruiken.

{{ figure_markup(
  image="nb_websites_with_geolocation_blink_usage.png",
  caption="Percentage van websites die geolocatiefuncties gebruiken.",
  description="Staafdiagram dat het percentage van websites toont dat elk van de geolocatiefuncties gebruikt. `GeolocationGetCurrentPosition` wordt gebruikt door 0,59% van de desktopsites en 0,63% van de mobiele sites, `GeolocationSecureOrigin` door respectievelijk 0,59% en 0,62%, `GeolocationInsecureOrigin` door 0,01% en 0,02%, `GeolocationWatchPosition` door 0,02% en 0,02%, `GeolocationSecureOriginIframe` door 0,02% en 0,02%, `GeolocationDisabledByFeaturePolicy` door 0,02% en 0,01%, en ten slotte `GeolocationInsecureOriginIframe` door 0,00% en 0,01%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1513111756&format=interactive",
  sheets_gid="1110372680",
  sql_file="number_of_websites_with_geolocation_blink_usage.sql"
  )
}}

Geolocatiegegevens kunnen ook opgevraagd worden door websites via een [webbrowser-API](https://developer.mozilla.org/docs/Web/API/Geolocation_API). We zien dat 0,59% van de websites op een desktopclient en 0,63% van de websites op een mobiele client de huidige positie van een gebruiker opvragen (gebaseerd op [Blinkfuncties](./methodology#blink-features)).

### Gegevenslekken

Slecht beveiligingsbeheer binnen een bedrijf kan een {significante impact hebben op de privégegevens van hun klanten. <a hreflang="en" href="https://haveibeenpwned.com/">Have I Been Pwned</a> laat aan gebruikers toe om te controleren of hun e-mailadres of telefoonnummer gelekt werd in een gegevenslek. Op het moment van schrijven heeft Have I Been Pwned 562 gegevenslekken bijgehouden, waarin 640 miljoen gegevens gelekt werden. Alleen al in 2020 werden 40 diensten gekraakt en de persoonlijke gegevens van miljoenen gebruikers gelekt. Drie van deze lekken werden gemarkeerd als _gevoelig_, wat verwijst naar de mogelijkheid om een negatieve impact te hebben op de gebruiker als iemand de gegevens van die gebruikers in het gegevenslek zou vinden. Een voorbeeld van een gevoelig gegevenslek is "[Carding Mafia](https://www.vice.com/en/article/v7m9jx/credit-card-hacking-forum-gets-hacked-exposing-300000-hackers-accounts)", een platform waar gestolen kredietkaarten worden verhandeld.

<p class="note">Merk op dat 40 gegevenslekken in het voorbije jaar een ondergrens is, aangezien veel gegevenslekken pas ontdekt of publiek gemaakt worden verschillende maanden nadat ze hebben plaatsgevonden.</p>

{{ figure_markup(
  image="data_breaches_pwned_accounts_per_class.png",
  caption='Het aantal betroffen accounts in gegevenslekken per gegevensklasse. (Bron: <a hreflang="en" href="https://haveibeenpwned.com/">Have I Been Pwned</a>)',
  description="Staafdiagram dat het aantal gebruikersaccounts toont dat betrokken is in gegevenslekken, op basis van de gegevensklasse die gelekt werd in het gegevenslek. 641 miljoen e-mailadressen waren aanwezig in gegevenslekken, 428 miljoen wachtwoorden, 369 miljoen namen, 173 miljoen geografische locaties, 149 miljoen telefoonnummers, 149 miljoen genders, 134 miljoen socialemediaprofielen, 127 miljoen onderwijsniveaus, 126 miljoen jobtitels, en ten slotte 110 miljoen fysieke adressen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1612339126&format=interactive",
  sheets_gid="1158689200",
  sql_file="data_breaches_pwned_websites_per_data_class.sql"
  )
}}

Elk gegevenslek dat Have I Been Pwned bijhoudt lekt e-mailadressen, aangezien gebruikers zo opvragen of hun gegevens gelekt zijn. Gelekte e-mailadressen zijn reeds een enorm privacyrisico, aangezien veel gebruikers hun volledige naam of gegevens gebruiken om hun e-mailadres aan te maken. Daarenboven wordt veel andere zeer gevoelige informatie gelekt in sommige gegevenslekken, zoals de genders van gebruikers, bankrekeningnummers of zelfs volledige fysieke adressen.

## Hoe websites jouw gevoelige gegevens beschermen

Wanneer je op het web browset, zijn er bepaalde gegevens die je mogelijk privé wilt houden: de webpagina's die je bezoekt, eventuele gevoelige gegevens die je in formulieren invult, je locatie, enzovoort. In het [Beveiligingshoofdstuk](./security#transport-security) kan je leren hoe 91,1% van de mobiele sites HTTPS hebben geactiveerd om jouw gegevens te beschermen tegen snuffelen terwijl die het internet doorkruisen. Hier zullen focussen op hoe websites browsers verder kunnen opleggen om privacy te verzekeren voor gevoelige bronnen.

### Permissions Policy / Feature Policy

De <a hreflang="en" href="https://www.w3.org/TR/permissions-policy-1/">_Permissions Policy_</a> ("toestemmingsbeleid", voorheen _Feature Policy_ of "functiebeleid" genoemd) laat websites toe om te definiëren welke webfuncties ze van plan zijn te gebruiken, en welke functies expliciet door de gebruiker goedgekeurd dienen te worden wanneer ze bijvoorbeeld door derden worden gevraagd. Dit geeft websites controle over de functies waartoe scripts van derden toegang kunnen vragen. Een Permissions Policy kan bijvoorbeeld door een website gebruikt worden om te verzekeren dat geen enkele derde partij op hun website toegang vraagt tot de microfoon. Dit beleid laat aan ontwikkelaars toe om fijnmazig te kiezen welke web-API's ze van plan zijn te gebruiken, door ze met het `allow`-attribuut te specificeren.


{{ figure_markup(
  image="most_common_featurepolicy_permissionspolicy_directives.png",
  caption="Aantal websites dat een Feature Policy-instructie gebruikt.",
  description="Staafdiagram dat de meest voorkomende instructies toont die gebruikt worden om de Feature Policy te definiëren en het aantal websites dat ze gebruikt. `geolocation` wordt gebruikt door 2.222 desktopsites en 2.323 mobiele sites, `microphone` door respectievelijk 2.199 en 2.310, `camera` door 2.082 en 2.197, `payment` door 1.748 en 1.879, `usb` door 1.354 en 1.492, `gyroscope` door 1.145 en 1.025, `magnetometer` door 1.141 en 1.024, `interest-cohort` door 1.037 en 1.019, `fullscreen` door 940 en 873, `accelerometer` door 892 en 852.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=820718961&format=interactive",
  sheets_gid="899874026",
  sql_file="most_common_featurepolicy_permissionspolicy_directives.sql",
  width=600,
  height=421
  )
}}

De meest gebruikte instructies in verband met de Feature Policy worden hierboven getoond. Op 3.049 websites op mobiel en 2.901 websites op desktop wordt het gebruik van de microfoonfunctie gespecificeerd. Een zeer kleine subset van onze gegevens, wat toont dat dit vooralsnog een nichetechnologie is. Andere functies die vaak beperkt worden zijn geolocatie, camera en betalingen.

Om een dieper begrip te krijgen over hoe de instructies gebruikt worden, keken we naar de 3 meest gebruikte instructies en de verdeling van de waarden die aan deze instructies toegekend worden.

{{ figure_markup(
  image="most_common_featurepolicy_permissionspolicy_directive_values.png",
  caption="Waarden gebruikt voor de 3 populairste Feature Policy-instructies.",
  description="Staafdiagram dat de verdeling toont van de waarden toegekend aan de drie populairste instructies voor de Feature Policy. `microphone` wordt gezet to `self` voor 0,08% van de mobiele sites, het wordt gezet op `none` voor 0,49% van de sites, en wordt gezet op `*` voor 0,03% van de sites. `geolocation` wordt gezet op `self` voor 0,17% van de mobiele sites, het wordt gezet op `none` voor 0,34% van de sites, en wordt gezet op `*` voor 0,05% van de sites. `camera` wordt gezet op `self` voor 0,09% van de mobiele sites, het wordt gezet op `none` voor 0,46% van de sites, en wordt gezet op `*` voor 0,03% van de sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=280518522&format=interactive",
  sheets_gid="436267650",
  sql_file="most_common_featurepolicy_permissionspolicy_directive_values.sql"
  )
}}

`none` is de meest gebruikte waarde. Dit specificeert dat de functie uitgeschakeld is in de topniveau- en geneste browsingcontexten. De tweede meest gebruikte waarde `self` wordt gebruikt om aan te geven dat de functie toegelaten is in het huidige document en binnen dezelfde oorsprong, terwijl `*` volledige toegang toelaat over oorsprongen heen.

### Referrer Policy

HTTP-verzoeken kunnen een optionele `Referer`-header ("verwijzer") bevatten, die de oorsprong of webpagina-URL aangeven waarvan een verzoek gemaakt werd. De `Referer`-header kan aanwezig zijn in verschillende types verzoeken:

* Navigatieverzoeken, wanneer een gebruiker op een link klikt.
* Verzoeken voor subbronnen, wanneer een browser afbeeldingen, iframes, scripts en andere bronnen die een pagina nodig heeft opvraagt.

Voor navigaties en iframes, kunnen deze gegevens ook opgevraagd worden via JavaScript door `document.referrer` te gebruiken.

De `Referer`-waarde kan goede inzichten bieden. Maar wanneer de volledige URL inclusief het pad en de vraagstring in de `Referer` over oorsprongen heen gestuurd wordt, kan dit privacyverhinderend zijn: URL's kunnen privé-informatie bevatten—soms zelfs identificerende of gevoelige informatie. Het stilletjes lekken hiervan over oorsprongen heen kan de privacy van gebruikers aantasten en beveiligingsrisico's inhouden. De HTTP-header [`Referrer-Policy`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Referrer-Policy) laat ontwikkelaars toe om te beperken welke verwijzergegevens toegankelijk wordt gemaakt aan verzoeken vanop hun website, om dit risico te verminderen.

{{ figure_markup(
  image="nb_websites_with_referrerpolicy.png",
  caption="Percentage van websites die een Referrer Policy specificeren.",
  description="Staafdiagram dat het percentage van websites toont dat een Referrer Policy specificeert op basis van hoe de websites dit beleid specificeerden. Eender welke Referrer Policy wordt gezet op 11,12% van de desktopsites en 10,38% van de mobiele sites, Entire document policy op 9,66% en 8,68%, Entire document policy header op 7,37% en 6,49%, Entire document policy meta op 2,65% en 2,51%, Any individual requests op 1,92% en 2,10%, Any link relations op 0,00% en 0,00%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2144839216&format=interactive",
  sheets_gid="1720798838",
  sql_file="number_of_websites_with_referrerpolicy.sql"
  )
}}

Een eerste punt om te noteren is dat de meeste sites niet expliciet een Referrer Policy zetten. Maar 11,12% van de desktopwebsites en 10,38% van de mobiele websites definiëren expliciet een Referrer Policy. De rest ervan (de overige 88,88% op desktop en 89,62% op mobiel) zullen terugvallen op het standaardbeleid van de browser. <a hreflang="en" href="https://web.dev/referrer-best-practices/#default-referrer-policies-in-browsers">De meeste grote browsers</a> hebben recent `strict-origin-when-cross-origin` als standaardbeleid geïntroduceerd, zoals <a hreflang="en" href="https://developers.google.com/web/updates/2020/07/referrer-policy-new-chrome-default">Chrome</a> in augustus 2020 en <a hreflang="en" href="https://blog.mozilla.org/security/2021/03/22/firefox-87-trims-http-referrers-by-default-to-protect-user-privacy/">Firefox</a> in maart 2021. `strict-origin-when-cross-origin` verwijdert het pad en vraagfragmenten van de URL op verzoeken over oorsprongen heen, wat beveiligings- en privacyrisico's vermindert.

{{ figure_markup(
  image="most_common_referrerpolicy_values.png",
  caption="Percentage van pagina's die waarden voor Referrer Policy gebruiken.",
  description="Staafdiagram dat het percentage van sites toont dat iedere waarde voor Referrer Policy gebruikt. `no-referrer-when-downgrade` wordt gebruikt op 3,63% van de desktopsites en 3,31% van de mobiele sites, `strict-origin-when-cross-origin` op respectievelijk 1,95% en 1,56%, `always` op 1,08% en 0,82%, `unsafe-url` op 0,47% en 0,52%, `same-origin` op 0,51% en 0,44%, `origin` op 0,39% en 0,51%, `no-referrer` op 0,34% en 0,31%, `origin-when-cross-origin` op 0,31% en 0,29%, `strict-origin` op 0,26% en 0,23%, en ten slotte `no-referrer, strict-origin-when-cross-origin` op 0,09% en 0,08%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=406890714&format=interactive",
  sheets_gid="1846818406",
  sql_file="most_common_referrerpolicy_values.sql",
  width=600,
  height=580
  )
}}

De meest voorkomende Referrer Policy die expliciet gezet wordt is `no-referrer-when-downgrade`. Deze wordt gezet op 3,38% van de websites op mobiele clients en 3,81% van de websites op desktopclients. `no-referrer-when-downgrade` is niet privacyverbeterend. Met dit beleid worden volledige URL's van de pagina's die een gebruiker bezoekt op een gegeven site gedeeld in HTTPS-verzoeken over oorsprongen heen (de overgrote meerderheid van verzoeken), wat deze informatie toegankelijk maakt voor andere partijen (oorsprongen).

Daarenboven zetten ongeveer 0,5% van de websites de waarde van de Referrer Policy op `unsafe-url`, wat toelaat dat de oorsprong, gastheer en vraagstring met _elk_ verzoek gestuurd worden, ongeacht het beveiligingsniveau van de ontvanger. In dit geval zou een verwijzer in klaartekst verzonden kunnen worden, wat potentieel privégegevens lekt. Wat verontrustend is, is dat er websites die actief geconfigureerd zijn om dit gedrag toe te laten.

<p class="note">Merk op: Websites kunnen de verwijzerinformatie ook als een URL-parameter naar de bestemmingssite sturen. We hebben het gebruik van dat mechanisme in dit rapport niet gemeten.</p>

### User-Agent Client Hints

Wanneer een webbrowser een HTTP-verzoek maakt, zal het een [`User-Agent`](https://developer.mozilla.org/docs/Web/HTTP/Headers/User-Agent)-header meesturen die informatie voorziet over de browser, het toestel en de netwerkmogelijkheden van de client. Dit kan echter misbruikt worden om gebruikers te profileren of uniek te identificeren door [fingerprinting](#fingerprinting).

<a hreflang="en" href="https://wicg.github.io/ua-client-hints/">User-Agent Client Hints</a> voorzien toegang tot dezelfde informatie als de `User-Agent`-string, maar op een meer privacybeschermende manier. Dit zal op zijn beurt aan browsers toelaten om uiteindelijk de hoeveelheid informatie die standaard door de `User-Agent`-string teruggegeven wordt ter verminderen, zoals Chrome voorstelt met een geleidelijk plan voor <a hreflang="en" href="https://www.chromium.org/updates/ua-reduction">_User Agent Reduction_</a> ("User Agent-vermindering").

Servers kunnen hun ondersteuning voor deze Client Hints aangeven door de `Accept-CH`-header te specificeren. Deze header lijst de attributen op die de server vraagt van de client om een toestel- of netwerkspecifieke bron terug te geven. Over het algemeen voorzien Client Hints een manier voor servers om enkel de minimaal nodige informatie te verkrijgen op inhoud op een efficiënte manier terug te geven.

{{ figure_markup(
  image="nb_websites_with_user_agent_client_hints.png",
  caption="Percentage van pagina's die User-Agent Client Hints gebruiken.",
  description="Staafdiagram dat het percentage van pagina's toont dat User-Agent Client Hints gebruikt gegroepeerd op de rang van de website. Voor de top 1.000 websites is het 3,67% op desktop en 3,56% op mobiel, voor de top 10.000 is het respectievelijk 1,35% en 1,44%, voor de top 100.000 is het 0,40% en 0,42%, voor de top 1 miljoen is het 0,14% en 0,15%, en ten slotte voor alle sites is het 0,15% en 0,20%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2107002085&format=interactive",
  sheets_gid="190615661",
  sql_file="number_of_websites_with_user_agent_client_hints.sql"
  )
}}

Op dit moment hebben echter weinig sites Client Hints geïmplementeerd. We zien ook een groot verschil tussen het gebruik van Client Hints op populair en minder populaire websites. 3,67% van de top 1.000 populairste websites op mobiel vragen Client Hints op. In de top10.000 websites daalt het implementatiepercentage tot 1,44%.

## Hoe websites jou een privacykeuze geven: Privacyvoorkeurssignalen

In het licht van de recente introductie van privacyreguleringen, zoals die vermeld in de introductie, zijn websites verplicht om expliciete gebruikerstoestemming te vragen om persoonlijke gegevens te verzamelen voor niet-essentiële functies zoals marketing en analytics.

Websites zijn daarom cookietoestemmingsbanners, privacybeleiden en andere mechanismen (die <a hreflang="en" href="https://sciendo.com/article/10.2478/popets-2021-0069">doorheen de tijd geëvolueerd zijn</a>) beginnen gebruiken om gebruikers te informeren over welke gegevens deze sites verwerken, en om ze een keuze te geven. In dit deel kijken we naar hoe vaak deze tools voorkomen.

### Platformen voor toestemmingsbeheer

{{ figure_markup(
  image="nb_websites_with_cmp.png",
  caption="Percentage van websites die een platform voor toestemmingsbeheer gebruiken.",
  description="Staafdiagram dat het percentage van websites toont dat een bibliotheek van derden gebruikt voor toestemmingsbeheer. 7,10% van de desktopsites en 6,97% van de mobiele sites gebruiken een dergelijk platform.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=246947280&format=interactive",
  sheets_gid="147308043",
  sql_file="number_of_websites_with_privacy_service.sql"
  )
}}

Platformen voor toestemmingsbeheer ("Consent Management Platforms" of ook CMP's) zijn bibliotheken van derden die websites kunnen insluiten om een cookietoestemmingsbanner aan hun gebruikers aan te bieden. We zagen dat rond de 7% van websites een platform voor toestemmingsbeheer gebruikten.

{{ figure_markup(
  image="nb_websites_using_each_cmp.png",
  caption="10 populairste platformen voor toestemmingsbeheer.",
  description="Staafdiagram dat het percentage van pagina's toont die de 10 populairste bibliotheken van derden gebruiken voor het aanbieden van toestemmingsbeheer. CookieYes wordt gebruikt op 1,65% van de desktopsites en 1,70% van de mobiele sites, Osano op respectievelijk 1,64% en 1,59%, OneTrust op 0,90% en 0,73%, Cookiebot op 0,74% en 0,64%, AdRoll CMP System op 0,50% en 0,36%, iubenda op 0,34% en 0,35%, Quantcast Choice op 0,37% en 0,34%, Didomi op 0,29% en 0,24%, Usercentrics op 0,18% en 0,19%, en ten slotte HubSpot Cookie Policy Banner op 0,26% en 0,17%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=619927070&format=interactive",
  sheets_gid="387302670",
  sql_file="number_of_websites_using_each_cmp.sql",
  width=600,
  height=421
  )
}}

De populairste bibliotheken zijn <a hreflang="en" href="https://www.cookieyes.com/">CookieYes</a> en <a hreflang="en" href="https://www.osano.com/">Osano</a>, maar we vonden meer dan 20 verschillende bibliotheken die aan websites toelaten om cookietoestemmingsbanners in te sluiten. Elke bibliotheek was maar aanwezig op een klein deel van websites, minder dan 2% elk.

### Toestemmingsframeworks van het IAB

Het <a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency and Consent Framework</a> (TCF) is een initiatief van het Interactive Advertising Bureau Europe (IAB) om een industriestandaard aan te bieden voor het communiceren van gebruikerstoestemming naar adverteerders. Het framework bestaat uit een <a hreflang="en" href="https://iabeurope.eu/vendor-list/">Global Vendor List</a>, waarin aanbieders het rechtmatige doel van de verwerkte gegevens kunnen specificeren, en een lijst van CMP's die als een tussenpartij tussen aanbieders en uitgevers handelen. Elke CMP is verantwoordelijk voor het communiceren van de wettelijke basis en het opslaan van de toestemmingsoptie die de gebruiker in de browser gegeven heeft. We verwijzen naar de opgeslagen cookie als de _toestemmingsstring_ ("consent string").

TCF is bedoeld om een mechanisme te zijn dat aan de AVG voldoet in Europa, hoewel <a hreflang="en" href="https://iabeurope.eu/all-news/update-on-the-belgian-data-protection-authoritys-investigation-of-iab-europe/">een recente beslissing door de Belgische Gegevensbeschermingsautoriteit</a> concludeerde dat dit systeem nog steeds de AVG overtreedt. Wanneer de CCPA in voege trad in Californië, ontwikkelde IAB Tech Lab US de technische specificaties voor <a hreflang="en" href="https://iabtechlab.com/standards/ccpa/">U.S. Privacy</a> (USP), op basis van dezelfde concepten.

{{ figure_markup(
  image="nb_websites_with_iab.png",
  caption="Percentage van websites die frameworks van het IAB gebruiken.",
  description="Staafdiagram dat het percentage van websites toont dat elk framework gebruikt voor zowel IAB Europe als US. IAB TCF v1 wordt gebruikt op 0,35% van de desktopsites en 0,30% van de mobiele sites, IAB TCF v2 op respectievelijk 1,58% en 1,49%, IAB TCF any op 1,67% en 1,57%, IAB USP op 3,13% en 3,19%, IAB USP op 3,13% en 3,19%, en ten slotte  IAB any op 3,92% en 3,97%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1697790298&format=interactive",
  sheets_gid="1662197018",
  sql_file="number_of_websites_with_iab.sql"
  )
}}

Hierboven tonen we de verdeling van het gebruik van beide versies van TCF en van USP. Merk op dat onze gegevensverzameling in de VS gebaseerd is, en dat we daarom niet verwachten dat veel websites TCF geïmplementeerd hebben. Minder dan 2% van de websites gebruiken eender welke versie van TCF, terwijl twee keer zo veel websites het US Privacy-framework gebruiken.

{{ figure_markup(
  image="most_common_cmps_for_iab_tcf_v2.png",
  caption="10 populairste platformen voor toestemmingsbeheer voor IAB.",
  description="Staafdiagram dat de 10 populairste platformen voor toestemmingsbeheer gebruikt voor IAB's toestemmingsframeworks toont. Quantcast wordt gebruikt op 0.31 van de desktopsites en 0,33% van de mobiele sites, Didomi op respectievelijk 0,29% en 0,24%, Wikia, Inc. op 0,23% en 0,19%, Google LLC op 0,08% en 0,09%, SIRDATA op 0,06% en 0,08%, iubenda op 0,07% en 0,07%, OneTrust LLC op 0,05% en 0,06%, Sourcepoint op 0,05% en 0,05%, consentmanager.net op 0,03% en 0,02%, en ten slotte LiveRamp op 0,02% en 0,01%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2085725571&format=interactive",
  sheets_gid="692122193",
  sql_file="most_common_cmps_for_iab_tcf_v2.sql"
  )
}}

In de 10 populairste platformen voor toestemmingsbeheer die deel uitmaken van het framework, vinden we bovenaan <a hreflang="en" href="https://www.quantcast.com/products/choice-consent-management-platform/">Quantcast</a> met 0,34% op mobiel. Andere populaire oplossingen zijn <a hreflang="en" href="https://www.didomi.io/">Didomi</a> met 0,24%, en Wikia, met 0,30%.

In het USP-framework, worden de privacyinstellingen van de website en gebruiker geëncodeerd in een <a hreflang="en" href="https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md">_privacystring_</a>.

{{ figure_markup(
  image="most_common_strings_for_iab_usp.png",
  caption="Percentage van websites die IAB US-privacystrings gebruiken.",
  description="Staafdiagram dat het percentage van websites toont dat elke privacystring voor het USP toestemmingsframework van IAB gebruikt. `1---` wordt gebruikt door 0,87% van de desktopwebsites en 0,80% van de mobiele websites, `1YNY` is respectievelijk 0,72% en 0,64%, `1YNN` is 0,07% en 0,06%, en blank is 0,01% en 0,00%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=2039463193&format=interactive",
  sheets_gid="1524219137",
  sql_file="most_common_strings_for_iab_usp.sql",
  width=600,
  height=421
  )
}}

De meest voorkomende privacystring is `1---`. Dit geeft aan dat de CCPA niet van toepassing is op de website en dat de website daarom niet verplicht is om de gebruiker de mogelijkheid te geven om zich af te melden. CCPA is enkel van toepassing op bedrijven waarvan de voornaamste handelspraktijk het verkopen van persoonlijke gegevens omvat, of op bedrijven die gegevens verwerken en een jaarlijkse omzet van meer dan 25 miljoen dollar hebben. De tweede meest voorkomende string is `1YNY`. Dit geeft aan dat de website "kennisgeving en de mogelijkheid heeft gegeven om zich af te melden voor de verkoop van gegevens", maar dat de gebruiker zich _niet_ heeft afgemeld voor de verkoop van hun persoonlijke gegevens.

### Privacybeleid

Tegenwoordig hebben de meeste websites een privacybeleid, waar gebruikers kunnen lezen welke types informatie over hen worden bijgehouden en verwerkt.

{{ figure_markup(
  caption="Percentage van de mobiele websites met een privacybeleidslink.",
  content="39,70%",
  classes="big-number",
  sheets_gid="473955086",
  sql_file="number_of_websites_with_privacy_links.sql"
)
}}

Door te zoeken naar trefwoorden zoals "privacybeleid", "cookiebeleid" en meer, in een <a hreflang="en" href="https://github.com/RUB-SysSec/we-value-your-privacy/blob/master/privacy_wording.json">aantal talen</a>, zien we dat 39,70% van de mobiele websites, en 43,02% van de desktopsites naar een of ander privacybeleid verwijzen. Hoewel het voor sommige websites niet nodig is dat ze zulk een beleid hebben, verwerken veel websites persoonlijke gegevens en zouden deze daarom een privacybeleid moeten hebben om volledig transparant te zijn naar hun gebruikers toe.

### Do Not Track - Global Privacy Control

De <a hreflang="en" href="https://www.eff.org/issues/do-not-track">Do Not Track</a> (DNT) HTTP-header kan gebruikt worden om naar websites te communiceren dat een gebruiker niet gevolgd wenst te worden. We kunnen het aantal websites dat de huidige waarde voor DNT lijkt op te vragen hier beneden zien, gebaseerd op de aanwezigheid van de [`Navigator.doNotTrack`](https://developer.mozilla.org/docs/Web/API/Navigator/doNotTrack) JavaScript-oproep.

{{ figure_markup(
  image="nb_websites_with_dnt_blink_usage.png",
  caption="Percentage van websites dat Do Not Track (DNT) gebruikt.",
  description="Staafdiagram dat het percentage van websites toont dat de waarde van DNT opvraagt door de `NavigatorDoNotTrack`-functie te gebruiken. 17,37% van de desktopsites en 17,39% van de mobiele sites vragen dit op.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1302428398&format=interactive",
  sheets_gid="485103492",
  sql_file="number_of_websites_with_dnt_blink_usage.sql"
  )
}}

Ongeveer hetzelfde percentage pagina's op mobiel en desktop gebruiken DNT. In de praktijk respecteert echter bijna geen enkele website effectief het verzoek tot afmelden via DNT. De Tracking Protection Working Group, die DNT specificeert, <a hreflang="en" href="https://www.w3.org/2016/11/tracking-protection-wg.html">sloot</a> in 2018, vanwege een <a hreflang="en" href="https://lists.w3.org/Archives/Public/public-tracking/2018Oct/0000.html">"gebrek aan steun"</a>. Safari <a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-12_1-release-notes#:~:text=Removed%20support%20for%20the%20expired%20Do%20Not%20Track">stopte dan met het ondersteunen van DNT</a> om potentieel misbruik voor [fingerprinting](#fingerprinting) te voorkomen.

DNT's opvolger <a hreflang="en" href="https://globalprivacycontrol.org/">Global Privacy Control</a> (GPC) werd uitgebracht in oktober 2020 en is bedoeld om een beter afdwingbaar alternatief te voorzien, met de hoop dat deze dan ook betere aanvaarding ziet. Dit privacyvoorkeurssignaal wordt geïmplementeerd met één enkele bit in alle HTTP-verzoeken. We hebben nog geen opname geobserveerd, maar we kunnen verwachten dat dit in de toekomst zal verbeteren, aangezien <a hreflang="en" href="https://www.washingtonpost.com/technology/2021/10/26/global-privacy-control-firefox/">grote browsers nu GPC beginnen te implementeren</a>.

## Hoe browsers hun privacyaanpak evolueren

Gegeven het streven om de privacy van gebruikers beter te beschermen terwijl ze op het web surfen, implementeren grote browsers nieuwe functies die de gevoelige gegevens van gebruikers beter zouden moeten beschermen. We hebben al manieren besproken waarop browsers meer privacybeschermende standaardinstellingen voor [`Referrer-Policy`-headers](#referrer-policy) en [`SameSite`-cookies](#cookies-van-derden) zijn beginnen afdwingen.

Verder trachten Firefox en Safari tracking te blokkeren door respectievelijk [Verbeterde bescherming tegen volgen](https://developer.mozilla.org/docs/Web/Privacy/Tracking_Protection) en <a hreflang="en" href="https://webkit.org/tracking-prevention/">Intelligente trackingpreventie</a>.

Naast het blokkeren van trackers, heeft Chrome de <a hreflang="en" href="https://privacysandbox.com/">Privacy Sandbox</a> gelanceerd om nieuwe webstandaarden te ontwikkelen die privacyvriendelijkere functionaliteit voor verscheidene doeleinden voorzien, zoals advertenties en fraudebescherming. We zullen deze opkomende technologieën, die ontworpen zijn om de mogelijkheid voor sites om gebruikers te volgen te verminderen, nader bekijken.

### Privacy Sandbox

Om feedback vanuit het ecosysteem te verkrijgen, worden vroege en experimentele versies van Privacy Sandbox-APIs initieel beschikbaar gemaakt door middel van <a hreflang="en" href="https://www.chromium.org/developers/how-tos/run-chromium-with-flags">functievlaggen</a> voor tests door individuele ontwikkelaars, en dan in Chrome via <a hreflang="en" href="https://developer.chrome.com/blog/origin-trials">_oorsprongsproeven_</a> ("origin trials"). Sites kunnen deelnemen in deze oorsprongsproeven}om experimentele webplatformfuncties te testen, en commentaar te geven naar de webstandaardengemeenschap over de gebruiksvriendelijkheid, uitvoerbaarheid en effectiviteit van een functie, vooraleer ze voor alle websites standaard beschikbaar wordt gemaakt.

<p class="note">**Disclaimer:** Oorsprongsproeven zijn enkel beschikbaar voor een beperkte tijd. De getallen hieronder geven de toestand van Privacy Sandbox oorsprongsproeven weer op het moment van schrijven, in oktober 2021.</p>

### FLoC

Een van de meest spraakmakende experimenten uit de Privacy Sandbox was <a hreflang="en" href="https://privacysandbox.com/proposals/floc">_Federated Learning of Cohorts_</a>, of kort _FLoC_. De oorsprongsproef voor FLoC eindigde in juli 2021.

Selectie van advertenties op basis van interesses wordt vaak gebruikt op het web. FLoC voorzag een API die voorzag in dit specifieke gebruiksscenario zonder de noodzaak om individuele gebruikers te identificeren en volgen. FLoC heeft wat <a hreflang="en" href="https://www.economist.com/the-economist-explains/2021/05/17/why-is-floc-googles-new-ad-technology-taking-flak">tegenwind</a> gehad: [Firefox](https://blog.mozilla.org/en/privacy-security/privacy-analysis-of-floc/) en <a hreflang="en" href="https://www.theverge.com/2021/4/16/22387492/google-floc-ad-tech-privacy-browsers-brave-vivaldi-edge-mozilla-chrome-safari">andere Chromium-gebaseerde browsers</a> hebben geweigerd om het te implementeren, en de Electronic Frontier Foundation heeft <a hreflang="en" href="https://www.eff.org/deeplinks/2021/03/googles-floc-terrible-idea">de bezorgdheid geuit dat het mogelijk nieuwe privacyrisico's kon introduceren</a>. FLoC was echter een eerste experiment. Toekomstige iteraties van de API zouden deze bezorgdheden kunnen verminderen en breder gebruikt kunnen worden.

In plaats van unieke identificatienummers aan gebruikers toe te wijzen, bepaalde de browser met FLoC de _cohorte_ van een gebruiker: een groep met duizenden mensen die gelijkaardige pagina's bezochten en daarom mogelijk interessant zijn voor dezelfde adverteerders.

Aangezien FLoC een experiment was, was het niet breed uitgerold. In de plaats daarvan konden websites dit testen door deel te nemen aan een oorsprongsproef. We vonden 62 en 64 websites die FLoC testten op respectievelijk desktop en mobiel.

Dit is hoe het eerste FLoC-experiment werkte: terwijl een gebruiker doorheen het web bewoog, gebruikte hun browser het FLoC-algoritme om hun _interessecohorte_ te bepalen, die dezelfde was voor duizenden browsers met een gelijkaardige recente browsergeschiedenis. De browser herberekende zijn cohorte regelmatig, op het toestel van de gebruiker, zonder individuele browsinggegevens te delen met de browserontwikkelaar of andere partijen. Tijdens het bepalen van zijn cohorte koos een browser uit cohorten <a hreflang="en" href="https://www.chromium.org/Home/chromium-privacy/privacy-sandbox/floc#:~:text=web%20pages%20on%20sensitive%20topics">die geen gevoelige categorieën onthulden</a>.

Individuele gebruikers en websites kunnen aangeven dat ze niet meegenomen willen worden bij de berekening van de cohort.

{{ figure_markup(
  image="nb_websites_with_floc_opt_out.png",
  caption="Percentage van websites dat zich afmeldt voor FLoC-cohorten.",
  description="Staafdiagram dat het percentage van pagina's toont dat zich afmeldt voor FLoC-cohorten, gegroepeerd op de rang van de website. Voor de top 1.000 sites meldt 3,29% van de desktopsites en 4,10% van de mobiele sites zich af, voor de top 10.000 is dit respectievelijk 1,10% en 1,26%, voor de top 100.000 is dit 0,64% en 0,67%, voor de top 1 miljoen is dit 0,69% en 0,69%, voor alle sites is dit 0,95% en 0,86%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=129384991&format=interactive",
  sheets_gid="637590731",
  sql_file="number_of_websites_with_floc_opt_out.sql"
  )
}}

We zien dat 4,10% van de top 1.000 websites zich hebben afgemeld voor FLoC. Over alle websites heen heeft minder dan 1% zich afgemeld.

### Andere Privacy Sandbox-experimenten

Binnen Googles Privacy Sandbox-initiatieven zijn een aantal experimenten in verscheidene stadia van ontwikkeling.

De <a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/attribution-reporting">_Attribution Reporting API_</a> (voorheen _Conversion Measurement_ genoemd) maakt het mogelijk om te meten wanneer gebruikersinteractie met een advertentie leidt tot een conversie—bijvoorbeeld, wanneer een klik op een advertenties uiteindelijk leidt tot een aankoop. We zagen de eerste oorsprongsproef (die eindigde in oktober 2021) geactiveerd op 10 oorsprongen.

<a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/fledge">_FLEDGE_</a> (First "Locally-Executed Decision over Groups" Experiment) tracht gerichte advertenties aan te pakken. De API kan in huidige versies van Chrome <a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/fledge">lokaal door individuele ontwikkelaars</a> getest worden maar er is geen oorsprongsproef in oktober 2021.

<a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/trust-tokens">_Trust Tokens_</a> laat aan een website toe om een beperkte hoeveelheid informatie over te brengen van de ene browsingcontext naar een andere om fraude te helpen bestrijden, zonder passieve tracking. We zagen de eerste <a hreflang="en" href="https://developer.chrome.com/blog/third-party-origin-trials">oorsprongsproef</a> (die zal eindigen in mei 2022) geactiveerd op 7 oorsprongen die waarschijnlijk ingesloten zijn op een aantal websites als dienstverleners.

<a hreflang="en" href="https://github.com/WICG/CHIPS">_CHIPS_</a> (Cookies Having Independent Partitioned State) laat aan websites toe om cookies over sites heen als "gepartitioneerd" aan te duiden, wat ze in een aparte _cookie jar_ per topniveausite steekt. (Firefox heeft reeds de gelijkaardige <a hreflang="en" href="https://blog.mozilla.org/security/2021/02/23/total-cookie-protection/">_Total Cookie Protection_</a>-functie voor cookiepartitionering geïntroduceerd.) In oktober 2021 was er geen oorsprongsproef voor CHIPS.

<a hreflang="en" href="https://github.com/shivanigithub/fenced-frame">_Fenced Frames_</a> beschermt toegang door frames tot gegevens van de pagina die ze insluit. In oktober 2021 was er geen oorsprongsproef.

{{ figure_markup(
  image="same_party_cookie_attribute.png",
  caption="Percentage van cookies met het SameParty-cookieattribuut.",
  description="Staafdiagram dat het percentage cookies toont met het SameParty-cookieattribuut gegroepeerd op de context van het verzoek. Voor eerstepartijcookies wordt `SameParty` gebruikt op 38 desktopsites en 73 mobiele sites, voor derdepartijcookies op 2.527 desktopsites en 1.805 mobiele sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=935824621&format=interactive",
  sheets_gid="858972835",
  sql_file="../security/cookie_attributes.sql"
  )
}}

Ten slotte laten <a hreflang="en" href="https://developer.chrome.com/docs/privacy-sandbox/first-party-sets">_First-Party Sets_</a> aan website-eigenaars toe om een verzameling van afzonderlijke domeinen te definiëren die eigenlijk aan dezelfde entiteit behoren. Eigenaars kunnen dan een `SameParty`-attribuut zetten op cookies die over sitecontexten heen verzonden zouden moeten worden, zolang de sites tot dezelfde _first-party set_ behoren. Een eerste oorsprongsproef eindigde in september 2021. We zagen het `SameParty`-attribuut op een duizendtal cookies.

## Besluit

De privacy van gebruikers blijft kwetsbaar op het web vandaag de dag: meer dan 80% van alle websites hebben een of andere vorm van tracking geactiveerd, en nieuwe trackingmechanismen zoals CNAME-tracking worden ontwikkeld. Sommige sites verwerken ook gevoelige gegevens zoals geolocaties, en als ze niet voorzichtig zijn, kunnen potentiële gegevenslekken ertoe leiden dat de persoonlijke gegevens van gebruikers onthuld worden.

Gelukkig heeft verhoogde bewustwording over de nood aan privacy op het web geleid tot concrete actie. Websites hebben nu toegang tot functie die hen toelaten om toegang tot gevoelige bronnen te beschermen. Wetgeving over de hele wereld dwingt expliciete gebruikerstoestemming af voor het delen van persoonlijke gegevens. Websites implementeren een privacybeleid en cookiebanners om daaraan te voldoen. Ten slotte zijn browsers innovatieve technologieën aan het voorstellen en ontwikkelen om doeleinden zoals advertenties en fraudedetectie op een privacyvriendelijkere manier te blijven ondersteunen.

Uiteindelijk zouden gebruikers gemachtigd moeten worden om inspraak te hebben in hoe hun persoonlijke gegevens worden behandeld. Ondertussen zouden browsers en website-eigenaars de technische mogelijkheden moeten ontwikkelen en uitrollen om te verzekeren dat de privacy van gebruikers beschermd wordt. Door privacy te verweven doorheen onze interacties met het web, kunnen gebruikers zich zekerder voelen dat hun persoonlijke gegevens goed beschermd worden.
