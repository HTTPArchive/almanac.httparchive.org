---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: E-commerce
description: E-commerce hoofdstuk van de Web Almanac 2020 met betrekking tot e-commerceplatforms, payloads, afbeeldingen, derden, prestaties, SEO en PWA's.
hero_alt: Hero image of a Web Almanac character at a super market checkout loading items from a shopping basket onto the conveyor belt while another character payes with a credit card.
authors: [rockeynebhwani, jrharalson]
reviewers: [alankent]
analysts: [jrharalson, rockeynebhwani]
editors: [tunetheweb]
translators: [noah-vdv]
rockeynebhwani_bio: Rockey Nebhwani is een onafhankelijke consultant die sinds 2001 in retail en e-commerce heeft gewerkt en uitgebreide ervaring heeft in de branche door samen te werken met retailers zoals Amazon, Wal-Mart, Tesco, M&S, Safeway enz. in de VS en het VK. Rockey is een occasionele spreker op e-commerce evenementen en tweet ook op <a href="https://x.com/rnebhwani">@rnebhwani</a>.
#jrharalson_bio: TODO
discuss: 2052
results: https://docs.google.com/spreadsheets/d/1Hvsh_ZBKg2vWhouJ8vIzLmp0nLIMzrT2mr6RQbIkxqY/
featured_quote: Covid-19 heeft de groei van e-commerce in 2020 enorm versneld en veel kleinere spelers moesten snel online aanwezig zijn en moesten manieren vinden om door te gaan met handelen tijdens lockdowns. Platformen zoals WooCommerce / Shopify / Wix / BigCommerce speelden een zeer belangrijke rol bij het online brengen van steeds meer kleine bedrijven. Covid-19 zag ook de lancering van D2C-aanbiedingen (direct to consumer) per merk en dit zal naar verwachting in de toekomst toenemen.
featured_stat_1: 21,27%
featured_stat_label_1: Mobiele sites die zijn geïdentificeerd als e-commercesites
featured_stat_2: 5,19%
featured_stat_label_2: Sites die WooCommerce gebruiken, het populairste e-commerceplatform
featured_stat_3: 30
featured_stat_label_3: Mediaan aantal JavaScript-verzoeken van e-commercesites
---

## Inleiding

Een "e-commerceplatform" is een set van software of services waarmee u een online winkel kunt opzetten en beheren. Er zijn verschillende soorten e-commerceplatforms, bijvoorbeeld:

- Betaalde services zoals Shopify die uw winkel hosten en u op weg helpen. Ze bieden websitehosting, site- en paginasjablonen, productgegevensbeheer, winkelwagentjes en betalingen.
- Softwareplatforms zoals Magento Open Source die u zelf opzet, host en beheert. Deze platforms kunnen krachtig en flexibel zijn, maar kunnen complexer zijn om op te zetten en uit te voeren dan services zoals Shopify.
- Gehoste platforms zoals Magento Commerce die dezelfde functies bieden als hun zelfgehoste tegenhangers, behalve dat hosting wordt beheerd als een service door een derde partij.

De analyse van vorig jaar kon alleen sites detecteren die op een e-commerceplatform waren gebouwd. Dit betekent dat de meeste grote online winkels en marktplaatsen, zoals Amazon, JD en eBay of andere e-commercesites die zijn gebouwd met interne platforms (meestal door grotere bedrijven), geen deel uitmaakten van de analyse. Voor de analyse van dit jaar werd deze beperking aangepakt door de detectie van e-commercesites door Wappalyzer te verbeteren. Zie de sectie [Platformdetectie](#platformdetectie) voor meer details.

Merk ook op dat de gegevens hier alleen voor startpagina's zijn: niet voor categorie-, product- of andere pagina's. Lees meer over onze [methodologie](./methodology).

## Platformdetectie

Hoe controleren we of een pagina zich op een e-commerceplatform bevindt? Detectie gebeurt via Wappalyzer. Wappalyzer is een platformonafhankelijk hulpprogramma dat de technologieën onthult die op websites worden gebruikt. Het detecteert contentmanagementsystemen, e-commerceplatforms, webservers, JavaScript-frameworks, analysehulpmiddelen en nog veel meer technologieën.

Vergeleken met 2019 zult u merken dat in 2020 het % van e-commerce websites aanzienlijk is toegenomen. Dit is voornamelijk te danken aan een verbeterde detectie in Wappalyzer dit jaar met behulp van secundaire signalen. Deze secundaire signalen zijn onder meer:
- Sites die Google Analytics Enhanced Ecommerce-tagging gebruiken, worden geteld als een e-commercesite.
- Secundair signaal omvat ook het zoeken naar de meest gebruikte patronen voor het identificeren van 'winkelwagen'-links.

Deze wijziging in methodologie biedt verbeterde dekking voor bedrijfsplatforms en sites die zijn gebouwd met headless-oplossingen.

### Beperkingen

Onze methodologie heeft de volgende beperkingen:
- Headless e-commerceplatforms zoals <a hreflang="en" href="https://commercetools.com/">commercetools</a> worden mogelijk niet gedetecteerd als e-commerceplatform, maar als we de aanwezigheid van een winkelwagentje op dergelijke sites kunnen detecteren, zullen we sites die dergelijke platforms gebruiken nog steeds opnemen in onze algemene dekkingsstatistieken.
- Technologieën die doorgaans buiten homepagina's worden ingezet (bijv. WebAR op productdetailpagina's) worden niet gedetecteerd.
- Omdat onze crawl afkomstig is uit de VS, kan er een voorkeur zijn voor specifieke Amerikaanse platforms. Als een wereldwijd bedrijf bijvoorbeeld e-commercesites heeft die zijn gebouwd op verschillende platforms voor verschillende landen (met landspecifieke domeinen/subdomeinen), worden deze regionale verschillen mogelijk niet weergegeven in onze analyse.
- Het is gebruikelijk voor B2B-sites om de winkelwagenfunctionaliteit achter een login te verbergen en daarom is dit onderzoek geen correcte weergave van de B2B-markt.

## E-commerceplatforms

{{ figure_markup(
  image="ecommerce-comparison-2019-to-2020.png",
  caption="E-commerce vergelijking 2019 tot 2020.",
  description="Een staafdiagram dat de desktopdetectie van e-commerce websites laat zien, is gestegen van 9,67% van de sites naar 21,72%. Mobiel is op dezelfde manier gestegen van 9,41% naar 21,27%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1775630157&format=interactive",
  sheets_gid="856812465",
  sql_file="pct_ecommsites_bydevice_compare20192020.sql"
) }}

In totaal gebruikte 21,72% van de mobiele websites en 21,27% van de desktopwebsites een e-commerceplatform. Voor 2019 was hetzelfde aantal 9,41% voor mobiele websites en 9,67% voor desktopwebsites.

<p class="note">Opmerking: deze toename is voornamelijk het gevolg van verbeteringen die zijn aangebracht in Wappalyzer om e-commercewebsites te detecteren en mag niet worden toegeschreven aan andere factoren, zoals groei als gevolg van Covid-19. Ook werd achteraf een kleine correctie toegepast op 2019-statistieken om rekening te houden met een fout en daarom zijn de 2019-percentages iets anders dan die gegeven in het <a href="../2019/ecommerce">2019 E-commerce</a> hoofdstuk .</p>

### Top e-commerceplatforms

{{ figure_markup(
  image="top-ecommerce-platforms.png",
  caption="Top e-commerceplatforms",
  description="Een staafdiagram dat in aflopende volgorde het gebruik van e-commerceplatforms toont met 5,12% voor WooCommerce op desktop en 5,19% op mobiel, gevolgd door Shopify (respectievelijk 2,55% en 2,48%), Wix (1,05% en 1,24%), Magneto (1,03% en 0,96%), PrestaShop (0,91%, 0,94%), 1C-Bitrix (0,64% en 0,65%), Bigcommerce (0,24% en 0,21%), Cafe24 (0,21% en 0,12%), Shopware (0,14% voor beide), en Loja Integrade met respectievelijk 0,08% en 0,09%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=795567278&format=interactive",
  sheets_gid="872326386",
  sql_file="top_vendors.sql"
) }}

Onze analyse telde 145 afzonderlijke e-commerceplatforms (vergeleken met [116 in de analyse van vorig jaar](../2019/ecommerce#ecommerce-platforms)). Hiervan hebben slechts 9 platforms een marktaandeel van meer dan 0,1%. WooCommerce is het meest voorkomende e-commerceplatform en heeft zijn nummer één positie behouden. Wix verschijnt dit jaar voor het eerst in deze analyse, nadat Wappalyzer het vanaf 30 juni 2019 begon te identificeren als e-commerceplatform.

### Topplatforms voor zakelijke e-commerce

Hoewel het moeilijk is om het precieze niveau van een platform te onderscheiden, laten we vier leveranciers benadrukken die zich sterk richten op het Enterprise-niveau: Salesforce, HCL, SAP en Oracle.

{{ figure_markup(
  image="enterprise-ecommerce-platforms.png",
  caption="Zakelijke e-commerceplatforms (desktop).",
  description="Een staafdiagram met Salesforce Commerce Cloud met 2.653 en 3.347, HCL WebSphere Commerce wordt gebruikt door 2.268 desktop-sites in 2019 en 2.604 in 2020, SAP Commerce Cloud met 1.979 en 2.371, en Oracle Commerce Cloud met 1.095 en 917.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=783560373&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

Salesforce Commerce Cloud blijft het leidende platform van deze groep. De 3.437 desktopwebsites in 2020 vertegenwoordigen een stijging van 29,5% ten opzichte van de 2.653 desktopwebsites in 2019. De websites van Salesforce zijn goed voor 36,8% van de vier zakelijke e-commerceplatforms.

HCL Technologies nam WebSphere Commerce over van IBM in juli 2019. De overgang had gemengde resultaten in 2020. Hoewel HCL's WebSphere Commerce het aantal desktopwebsites dit jaar met 14,8% verhoogde tot 2.604 ten opzichte van de 2.268 desktopwebsites van 2019, was er een terugval in populariteit. met 0,5% binnen deze groep tot 27,9%. Iets om naar te kijken in de toekomst.

SAP Commerce Cloud, formeel bekend als Hybris, blijft het op twee na populairste e-commerceplatform voor ondernemingen met 25,4%, een lichte stijging ten opzichte van de 24,8% van vorig jaar. De 2.371 desktopwebsites zijn een stijging van 19,8% ten opzichte van de 1.979 desktopwebsites die in 2019 zijn gevonden en toegeschreven aan Hybris.

Ten slotte verloor Oracle Commerce Cloud helaas een beetje grip tussen 2019 en 2020. De desktopwebsites daalden van 1.095 naar 917, een daling van 16%, en op zijn beurt daalde de positie van hun Zakelijke e-commerceplatform van 13,7% naar 9,8%.

{{ figure_markup(
  image="enterprise-ecommerce-platforms-2019.png",
  caption="Zakelijke e-commerceplatforms - 2019-desktop",
  description="Een cirkeldiagram met Salesforce Commerce Cloud die gebruikt werd door 33,2% van de zakelijke e-commercemarkt in 2019, HCL WebSphere Commerce door 28,4%, SAP Commerce Cloud door 24,8% en Oracle Commerce Cloud door 13,7%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1864431795&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

{{ figure_markup(
  image="enterprise-ecommerce-platforms-2020.png",
  caption="Zakelijke e-commerceplatforms - 2020-desktop",
  description="Een cirkeldiagram met Salesforce Commerce Cloud die gebruikt werd door 36,8% van de zakelijke e-commercemarkt in 2020, HCL WebSphere Commerce door 27,9%, SAP Commerce Cloud door 25,4% en Oracle Commerce Cloud door 9,8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1013485197&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

Shopify's Shopify Plus, Adobe's Magento Enterprise en Bigcommerce's Enterprise-aanbiedingen zijn beschikbaar en winnen aan populariteit, maar de beperkingen van Platformdetectie belemmeren elke mogelijkheid om de Enterprise-websites te isoleren van hun Community- of Commerciële websites.

## COVID-19 impact op e-commerce

COVID-19 heeft een enorme impact op de wereld gehad en maakte een nog grotere online verhuizing noodzakelijk. Het meten van de totale toename van e-commerceplatforms wordt beïnvloed door de sterk toegenomen detectie die gedeeltelijk voor dit hoofdstuk is ondernomen. Dus in plaats daarvan kijken we naar enkele van de platforms die al werden gedetecteerd en zien we een toename in hun gebruik - vooral sinds maart 2020, toen COVID grote delen van de wereld begon te beïnvloeden:

{{ figure_markup(
  image="ecommerce-vendor-growth-covid-19-impact.png",
  caption="E-commerceplatform groei Covid-19 impact",
  description="Een lijndiagram met de groei van vijf populaire e-commerceplatforms: WooCommerce, Shopify, Wix, Magneto en PrestaShop. WooCommerce laat een gestage groei zien met een merkbare hobbel in februari 2020 en opnieuw in juni en juli. Shopify laat hetzelfde zien, maar voor een kleiner percentage en de andere drie laten minder van een dergelijke impact zien.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1475961371&format=interactive",
  sheets_gid="535254570",
  sql_file="ecomm_vendors_covid_growth.sql"
) }}

Er is absoluut een meetbare toename van WooCommerce- en Shopify-sites rond de tijd dat COVID echt invloed op de wereld begon te hebben.

<p class="note">Opmerking: <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/pull/2731/commits/f44f20f03618f6a5fd868dd38ce9db5e2e2f1407">Wappalyzer-detectie voor Wix</a> maakt geen onderscheid als een site Wix gebruikt als CMS of e-commerceplatform. Hierdoor wordt de groei van Wix als e-commerceplatform mogelijk niet correct weergegeven in de bovenstaande grafiek.</p>

## Paginagewicht en verzoeken

Het paginagewicht van een e-commerceplatform omvat alle HTML, CSS, JavaScript, JSON, XML, afbeeldingen, audio en video.

{{ figure_markup(
  image="page-requests-distribution.png",
  caption="Distributie van paginaverzoeken.",
  description="Een staafdiagram met het aantal verzoeken, waarbij het 10e percentiel 46 verzoeken op desktop en 44 op mobiel heeft, het 25e percentiel respectievelijk 68 en 65, het 50e met 103 en 98, 75e met 151 en 146 en het 90e percentiel met 217 op desktop en 208 op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1278986228&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

{{ figure_markup(
  image="page-weight-distribution.png",
  caption="Paginagewicht verdeling.",
  description="Een staafdiagram met het paginagewicht in MB, waarbij het 10e percentiel 0.94 MB op desktop en 0.85 op mobiel heeft, het 25e percentiel 1.55 en 1.45 respectievelijk, 50e met 2.62 en 2.48, 75e met 4.52 en 4.26, en 90e percentiel met 7.89 MB op desktop en 7,3 MB op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1078671906&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

Het is veelbelovend dat het gewicht van mobiele pagina's in alle percentielen is gedaald [vergeleken met 2019](../2019/ecommerce#page-weight-and-requests), terwijl het gewicht van desktoppagina's min of meer hetzelfde is gebleven (behalve het 90e percentiel). Verzoeken per pagina daalden ook op mobiel (9-11 verzoeken minder voor alle percentielen behalve 90e percentiel) en op desktop.

E-commercesites zijn nog steeds groter in termen van verzoeken en omvang in vergelijking met alle sites, zoals wordt getoond in het hoofdstuk [Paginagewicht](./page-weight).

### Paginagewicht op resourcetype

Als we dit uitsplitsen naar resourcetype, zien we voor mediaanpagina's dat afbeeldingen en JavaScript-verzoeken e-commercepagina's domineren:

{{ figure_markup(
  image="median-page-requests-by-type.png",
  caption="Mediaan paginaverzoeken per type.",
  description="Een staafdiagram met een verzoek per pagina voor het bestandstype in aflopende volgorde voor de mediaanpagina. Afbeeldingen zijn 37 verzoeken op desktop en 34 op mobiel, scripts zijn respectievelijk 31 en 30, css 8 voor beide, lettertypen 5 voor beide, andere 4 voor beide, html 4 voor beide, video 3 voor beide, en xml, tekst en audio allemaal 1 voor beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1680167507&format=interactive",
  sheets_gid="1479463761",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

Als we echter kijken naar de werkelijk geleverde bytes, zijn media verreweg de grootste troef:

{{ figure_markup(
  image="median-page-kilobytes-by-type.png",
  caption="Mediane aantal kilobytes per type.",
  description="Een staafdiagram met een kilobytes per pagina voor het bestandstype in aflopende volgorde voor de mediaanpagina. Afbeeldingen zijn 1.754 KB op desktop en 2.176 KB op mobiel, scripts zijn respectievelijk 1.271 en 1.208, css 643 en 611, lettertypen 143 en 123, html 35 en 34, audio 14 en 9, xml 1 en 1 en tekst en andere 0 voor beide .",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1077946836&format=interactive",
  sheets_gid="1479463761",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

Video is, ondanks een klein aantal verzoeken, verreweg de grootste bron op e-commercesites, gevolgd door afbeeldingen en vervolgens JavaScript.

### HTML-payloadgrootte

{{ figure_markup(
  image="distribution-of-html-bytes-per-ecommerce-page.png",
  caption="Verdeling van HTML-bytes per e-commercepagina",
  description="Een staafdiagram met het aantal HTML-kilobytes, waarbij het 10e percentiel 12 KB op desktop en 13 KB op mobiele apparaten heeft, het 25e percentiel respectievelijk 20 en 21, het 50e percentiel 35 en 36, 75e 76 en 74 en het 90e percentiel heeft 133 KB op desktop en 134 KB op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1956748774&format=interactive",
  sheets_gid="1032303587",
  sql_file="pagestats_html_bydevice.sql"
) }}

Houd er rekening mee dat HTML-payloads andere code zoals inline JSON, JavaScript of CSS rechtstreeks in de opmaak zelf kunnen bevatten, in plaats van dat er naar wordt verwezen als externe links. De gemiddelde grootte van de HTML-payload voor e-commercepagina's is 35 KB op mobiele apparaten en 36 KB op desktops. [Vergeleken met 2019](../2019/ecommerce#html-payload-size) zijn de mediane payload-grootte en het 10e, 25e en 50e percentiel ongeveer hetzelfde gebleven. Bij het 75e en 90e percentiel zien we echter een toename van respectievelijk ongeveer 10 KB en 15 KB op mobiel en desktop.

De grootte van de mobiele HTML-payload is niet erg verschillend van de desktop. Met andere woorden, het lijkt erop dat sites geen significant verschillende HTML-bestanden leveren voor verschillende apparaten of viewportgroottes.

### Gebruik van afbeeldingen

Laten we vervolgens kijken hoe afbeeldingen worden gebruikt op e-commercesites. Houd er rekening mee dat omdat onze methodologie voor gegevensverzameling geen gebruikersinteracties op pagina's zoals klikken of scrollen simuleert, afbeeldingen die lui geladen zijn, niet in deze resultaten worden weergegeven.

{{ figure_markup(
  image="distribution-of-image-requests-for-ecommerce.png",
  caption="Distributie van afbeeldingsverzoeken voor e-commerce",
  description="Een staafdiagram met het aantal afbeeldingsverzoeken, waarbij het 10e percentiel 14 verzoeken op desktop en 12 op mobiel heeft, het 25e percentiel respectievelijk 22 en 20, 50e 37 en 34, 75e 60 en 56, en 90e percentiel 101 verzoeken op desktop en 91 op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=286315936&format=interactive",
  sheets_gid="898563708",
  sql_file="pagestats_image_bydevice.sql"
) }}

{{ figure_markup(
  image="distribution-of-image-bytes-for-ecommerce.png",
  caption="Verdeling van afbeeldingsbytes voor e-commerce",
  description="Een staafdiagram met het aantal afbeeldingskilobytes, waarbij het 10e percentiel 242 KB op desktop en 189 KB op mobiel heeft, het 25e percentiel respectievelijk 546 en 486, het 50e met 1.271 en 1.208, 75e met 2.835 en 2.737 en het 90e percentiel met 5.819 KB op desktop en 5.459 KB op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=416820889&format=interactive",
  sheets_gid="898563708",
  sql_file="pagestats_image_bydevice.sql"
) }}

De bovenstaande cijfers laten zien dat de gemiddelde e-commercepagina 34 afbeeldingen heeft en een afbeeldingspayload van 1.208 KB op mobiel, 37 afbeeldingen en 1.271 KB op desktop. 10% van de homepagina's heeft 90 of meer afbeeldingen en een afbeeldingsbelasting van bijna 5,5 MB op mobiele apparaten en 5,8 MB op desktopcomputers.

[Vergeleken met 2019](../2019/ecommerce#image-stats) zijn zowel de mediaan beeldverzoeken als de mediane payloads voor afbeeldingen gedaald. Mediane afbeeldingsverzoeken zijn met 3 gedaald voor zowel mobiel als desktop. De mediane payload van afbeeldingen daalde ook met ongeveer 200 kb-250 kb op mobiel en desktop. Deze daling kan worden veroorzaakt door sites die luie laadtechnieken toepassen, zoals het gebruik van het attribuut `loading="lazy"` dat nu <a hreflang="en" href="https://caniuse.com/loading-lazy-attr"> ondersteund is door steeds meer browsers</a>. In het [Opmaak](./markup#data--attributen) hoofdstuk van dit jaar blijkt dat het gebruik van observaties voor native lui laden lijkt toe te nemen en ongeveer 3,86% van de pagina's gebruikt dit in aug-2020 en dit is constant gestegen (zoals te zien in [deze tweet](https://x.com/rick_viscomi/status/1344380340153016321?s=20)).

#### Populaire afbeeldingsformaten

{{ figure_markup(
  image="popular-image-formats-on-ecommerce-sites.png",
  caption="Populaire afbeeldingsindelingen op e-commercesites",
  description="Een staafdiagram met afbeeldingsindelingen in aflopende volgorde van populariteit met mobiele nummers met jpg op 50,19%, png op 26,54%, gif op 17,35%, svg op 2,61%, webp op 1,17% en geen formaat op 0,07%. Desktopgebruik lijkt vrijwel identiek te zijn.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=753462591&format=interactive",
  sheets_gid="943479146",
  sql_file="pagestats_image_bydevice_format.sql"
) }}

<p class="note">Merk op dat sommige afbeeldingsservices of CDN's automatisch WebP (in plaats van JPEG of PNG) leveren aan platforms die WebP ondersteunen, zelfs voor een URL met een <code>.jpg</code> of <code>.png</code> achtervoegsel . <code>IMG_20190113_113201.jpg</code> retourneert bijvoorbeeld een WebP-afbeelding in Chrome. De manier waarop HTTP Archive afbeeldingsindelingen detecteert, is door eerst te controleren op trefwoorden in het MIME-type en vervolgens terug te vallen op de bestandsextensie. Dit betekent dat het formaat voor afbeeldingen met URL's zoals de bovenstaande wordt gegeven als WebP, aangezien WebP wordt ondersteund door HTTP Archive als user-agent.</p>

Het PNG-gebruik bleef ongeveer op [hetzelfde niveau als 2019](../2019/ecommerce#png) (op 27% voor zowel desktop als mobiel). We zagen een daling van het JPEG-gebruik (4% voor desktop en 6% voor mobiel). Van deze daling ging het meeste naar een verhoogd GIF-gebruik. GIF's komen vrij vaak voor op e-commerce-homepagina's, terwijl GIF's misschien niet veel worden gebruikt op productdetailpagina's. Omdat onze methodologie alleen naar homepagina's kijkt, verklaart dit het aanzienlijk hoge gebruik van GIF's op e-commercesites. Lighthouse heeft een audit die het gebruik van "videoformaten voor geanimeerde inhoud" aanbeveelt. Dit is een techniek die e-commercesites kunnen gebruiken om de prestaties te optimaliseren, maar toch de animatie-eigenschappen van GIF's te behouden. Zie <a hreflang="en" href="https://web.dev/replace-gifs-with-videos/">dit artikel</a> voor meer details.

Het gebruik van WebP op e-commercesites blijft nog steeds erg laag, hoewel het gebruik verdubbeld is en van een totaal gebruik van 1% in 2019 naar 2% in 2020 is gestegen. element, is het gebruik laag gebleven. In 2020 kreeg WebP een tweede leven toen Safari ondersteuning introduceerde in <a hreflang="en" href="https://caniuse.com/webp">Safari 14</a>. De Web Almanac voor dit jaar is echter gebaseerd op augustus 2020 en Safari-ondersteuning kwam in september 2020, dus de hier gepresenteerde statistieken geven niet de impact weer van de ondersteuning die door Safari is toegevoegd.

Dit jaar zagen we in Chrome 85 (uitgebracht in augustus 2020) ook ondersteuning voor AVIF, een <a hreflang="en" href="https://www.ctrl.blog/entry/webp-avif-comparison.html">efficiënter afbeeldingsformaat vergeleken met WebP</a>. In de analyse van volgend jaar hopen we AVIF-gebruik op e-commercesites te dekken. Net als bij WebP is AVIF ook een progressieve verbetering en kan het worden geïmplementeerd met behulp van het element `picture` om <a hreflang="en" href="https://caniuse.com/avif">problemen tussen browsers</a> aan te pakken.

Volgens de ervaring van de auteur is er een gebrek aan bewustzijn bij engineeringteams over beeldoptimalisatiediensten die worden aangeboden door CDN's, waar CDN's het grootste deel van het zware werk kunnen doen zonder enige code aan te raken. Adobe Scene7 biedt dit bijvoorbeeld aan onder hun <a hreflang="en" href="https://helpx.adobe.com/uk/experience-manager/6-3/assets/using/imaging-faq.html">Smart Imaging oplossing</a>. Klanten op Salesforce Commerce Cloud die de ingebouwde CDN-mogelijkheid van het platform gebruiken (die Cloudflare gebruikt), kunnen dit met een simpele schakelaar inschakelen. Door het bewustzijn van dergelijke oplossingen te vergroten, kunnen we proberen de naald te verplaatsen ten gunste van efficiëntere formaten.

Een ander punt voor lezers die geïnteresseerd zijn in het verbeteren van CRUX-statistieken met afbeeldingsgroottes/-indelingen, de huidige progressieve afbeeldingen wegen niet mee in de richting van de Largest Contentful Paint, ondanks dat ze nuttig zijn voor de door de gebruiker waargenomen prestaties. Er is een fascinerende <a hreflang="en" href="https://github.com/WICG/largest-contentful-paint/issues/68">discussie</a> in de gemeenschap over dit onderwerp en in de toekomst is het mogelijk dat progressieve beelden bijdragen aan LCP. Als gevolg hiervan en de opname van Core Web Vitals in Page Experience-signalen vanaf mei 2021 kan er in de e-commercegemeenschap hernieuwde belangstelling zijn voor formaten die progressief laden ondersteunen.

### Verzoeken en bytes van derden

E-commerceplatforms en -sites maken vaak gebruik van inhoud van [derden](./third-party). We gebruiken het [Third Party Web project](./methodology#third-party-web) om gebruik door derden te detecteren.

{{ figure_markup(
  image="distribution-of-third-party-requests.png",
  caption="Verspreiding van verzoeken van derden",
  description="Een staafdiagram met het aantal verzoeken van derden voor e-commercesites, met het 10e percentiel met 8 verzoeken op desktop en 7 op mobiel, het 25e percentiel met respectievelijk 16 en 15, 50e met 32 en 30, 75e met 60 en 58, en 90e percentiel met 103 verzoeken van derden op desktop en 98 op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1577985571&format=interactive",
  sheets_gid="1199548164",
  sql_file="pct_3pusage_bydevice.sql"
) }}

{{ figure_markup(
  image="distribution-of-third-party-bytes.png",
  caption="Distributie van bytes van derden",
  description="Een staafdiagram met het aantal kilobytes van derden voor e-commercesites, met het 10e percentiel met 88 KB op desktop en 67 KB op mobiel, het 25e percentiel met respectievelijk 242 en 208, het 50e met 547 en 489, het 75e met 1.179 en 1.098 , en 90e percentiel met 2.367 KB op desktop en 2.155 KB op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1165664044&format=interactive",
  sheets_gid="1199548164",
  sql_file="pct_3pusage_bydevice.sql"
) }}

We zien een aanzienlijke toename in het gebruik van verzoeken en bytes van derden [vergeleken met de gegevens van derden van vorig jaar](../2019/ecommerce#third-party-requests-and-bytes), maar we konden een bepaalde oorzaak of opmerkelijke verandering in detectie niet identificeren. We horen graag <a hreflang="en" href="https://discuss.httparchive.org/t/2052">de mening van lezers</a> hierover, aangezien het gebruik door derden in feite lijkt te zijn verdubbeld het laatste jaar!

## E-commerce gebruikerservaring

Bij e-commerce draait alles om het converteren van klanten en om dat te doen is een snel presterende website van het grootste belang. In deze sectie proberen we licht te werpen op de echte gebruikerservaring van e-commerce websites. Om dit te bereiken, richten we onze analyse op enkele door de gebruiker waargenomen prestatiestatistieken, die zijn vastgelegd in de drie <a hreflang="en" href="https://web.dev/articles/vitals">Core Web Vitals</a> statistieken.

### Chrome User Experience Report

In dit gedeelte bekijken we drie belangrijke factoren die worden geboden door het [Chrome User Experience Report](./methodology#chrome-ux-report), dat licht kan werpen op ons begrip van hoe gebruikers e-commerce websites in het wild ervaren:

- Largest Contentful Paint (LCP)
- First Input Delay (FID)
- Cumulative Layout Shift (CLS)

Deze statistieken zijn bedoeld om de kernelementen te dekken die indicatief zijn voor een geweldige webgebruikerservaring. Het hoofdstuk [Prestatie](./performance) behandelt deze in meer detail, maar hier zijn we geïnteresseerd in het bekijken van deze statistieken specifiek voor e-commerce websites. Laten we ze allemaal om beurten bekijken.

#### Largest Contentful Paint

Largest Contentful Paint (LCP) meet het punt waarop de belangrijkste inhoud van de pagina waarschijnlijk is geladen en dus is de pagina nuttig voor de gebruiker. Het doet dit door de rendertijd te meten van het grootste beeld of tekstblok dat zichtbaar is in de viewport.

Dit is anders dan First Contentful Paint (FCP), dat meet vanaf het laden van de pagina totdat inhoud zoals tekst of een afbeelding voor het eerst wordt weergegeven. LCP wordt beschouwd als een goede proxy om te meten wanneer de hoofdinhoud van een pagina wordt geladen.

In de context van e-commerce geeft deze statistiek een zeer goede indicatie van de meest bruikbare inhoud voor de gebruikers (bijv. Hero-bannerafbeelding voor bestemmingspagina's, afbeelding van eerste product weergegeven op zoek-/vermeldingspagina's, productafbeelding in het geval van een productdetailpagina). Vóór deze statistiek moesten sites sites expliciet instrumenteren in hun RUM-oplossing, maar deze statistiek democratiseert de meting voor iedereen die mogelijk geen middelen of expertise heeft om dit te doen.

{{ figure_markup(
  image="ecommerce-real-user-largest-contentful-paint-experiences.png",
  caption="Largest Contentful Paint-ervaringen voor echte gebruikers",
  description="Een staafdiagram met het aantal sites met een goede LCP-score voor de top 5 van populairste e-commerceplatforms. WooCommerce heeft 21,73% voor desktop en 14,27% voor mobiel, Shopify heeft respectievelijk 64% en 47,47%, Magneto heeft 39,45% en 28,17%, Wix heeft 7,46% en 7,40% en PrestaShop heeft 53,03% voor desktop en 38,08% voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1881724605&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

We zien grote mate van variabiliteit tussen de grote platforms met Wix, en WooCommerce die in het bijzonder erg laag scoren. Als twee van de drie meest gebruikte e-commerceplatforms, lijkt het erop dat ze verbeteringen moeten aanbrengen!

#### First Input Delay

First Input Delay (FID) probeert interactiviteit te meten, of nog belangrijker, eventuele belemmeringen voor interactiviteit wanneer een pagina niet reageert terwijl deze bezig is met het verwerken van de pagina.

{{ figure_markup(
  image="ecommerce-real-user-first-input-delay-experiences.png",
  caption="First Input Delay-ervaringen voor echte gebruikers",
  description="Een staafdiagram met het aantal sites met een goede LCP-score voor de top 5 van populairste e-commerceplatforms. WooCommerce heeft 99,95% voor desktop en 92,36% voor mobiel, Shopify heeft respectievelijk 99,96% en 96,49%, Magneto heeft 99,99% en 89,02%, Wix heeft 88,30% en 37,95% en PrestaShop heeft 99,93% voor desktop en 92,96% voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=490091603&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

Over het algemeen zijn FID-scores doorgaans hoger dan de andere Core Web Vitals, en het is veelbelovend dat e-commercesites, ondanks het gebruik van veel media en JavaScript, zoals we eerder hebben gezien, hoge scores behouden in deze categorie.

#### Cumulative Layout Shift

Cumulative Layout Shift (CLS) meet hoeveel de pagina "springt" wanneer nieuwe inhoud wordt geladen en op de pagina wordt geplaatst. Op basis van onze crawls is dit beperkt tot het laden van de eerste pagina boven "de vouw", maar e-commercesites moeten begrijpen dat onder de paginavouw of andere interacties CLS meer kunnen beïnvloeden dan onze statistieken laten zien.

{{ figure_markup(
  image="ecommerce-real-user-cumulative-layout-shift-experiences.png",
  caption="Cumulative Layout Shift-ervaringen voor echte gebruikers",
  description="Een staafdiagram met het aantal sites met een goede LCP-score voor de top 5 van populairste e-commerceplatforms. WooCommerce heeft 37,98% voor desktop en 51,40% voor mobiel, Shopify heeft respectievelijk 40,72% en 40,55%, Magneto heeft 38,11% en 38,28%, Wix heeft 58,15% en 57,47%, en PrestaShop heeft 51,56% voor desktop en 49,83% voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1137826141&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

Ongeveer de helft van e-commercesites heeft goede CLS-scores en interessant genoeg is er weinig verschil tussen mobiel en desktop, ondanks de gebruikelijke conventie dat mobiele apparaten meestal onder aangedreven en vaak variabele netwerkveranderingen ondergaan.

#### Core Web Vitals in het algemeen

Als we kijken naar Core Web Vitals in het algemeen, waarvoor sites aan alle drie de kernstatistieken voldoen, zien we het volgende:

{{ figure_markup(
  image="ecommerce-real-user-core-web-vitals-exeriences.png",
  caption="Core Web Vitals-ervaringen voor echte gebruikers",
  description="Een staafdiagram met het aantal sites met een goede LCP-score voor de top 5 van populairste e-commerceplatforms. WooCommerce heeft 10,72% voor desktop en 8,63% voor mobiel, Shopify heeft respectievelijk 28,78% en 21,24%, Magneto heeft 18,33% en 11,14%, Wix heeft 5,23% en 3,30%, en PrestaShop heeft 30,43% voor desktop en 19,10% voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=733851599&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

Dit lijkt erg op het LCP-diagram van eerder, misschien enigszins niet verrassend aangezien het het diagram was met de meeste variabiliteit en de meeste sites die niet aan deze statistiek voldeden.

## Hulpmiddelen

Hoe gebruiken e-commercesites veelgebruikte hulpmiddelen zoals Analytics, Tagmanagers, Toestemmingsbeheerplatformen en Toegankelijkheidsoplossingen?

### Analytics

{{ figure_markup(
  image="top-analytics-solutions-on-ecommerce-sites.png",
  caption="Topanalyseoplossingen op e-commercesites",
  description="Een staafdiagram met de belangrijkste Analytics-providers voor e-commerceplatforms in aflopende volgorde. Voor mobiel heeft Google Analytics 77% gebruik, GA Enhanced eCommerce 22%, Hotjar 6%, New Relic 4%, TrackJs 3%, Yandex.Metrika 3%, Matomo Analytics 2%, BugSnag 2%, Liveinternet heeft 2%, comScore heeft 1% en Quantcast Measure heeft 1%. Desktopgebruik lijkt bijna identiek.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=431305389&format=interactive",
  sheets_gid="618573782",
  sql_file="top_analytics_bydevice_vendor.sql"
) }}

Google Analytics scoort hoogst niet verrassend op 77% van de mobiele e-commercesites, maar wat misschien nog meer verrassend is, is dat Google Analytics Enhanced Ecommerce slechts door 22% van de e-commercesites wordt gebruikt, wat een mogelijkheid voor 55% van de sites weerspiegelt om meer uit hun sites te halen. Google Analytics, of misschien een weerspiegeling van een andere beperking van onze methodologie die beperkt is tot homepagina's, aangezien sommige sites dit mogelijk alleen laden op afrekentrechters.

HotJar is another tool often used by ecommerce sites to analyze and improve usage of the site, and so conversions but usage is very low at 6% of mobile sites.

### Tagmanagers

Google Tag Manager blijft de meest gebruikte tagmanager op e-commercesites, gevolgd door Adobe Tag Manager. We verwachten niet dat dit zal veranderen vanwege het vrije karakter van Google Tag Manager. In augustus 2020 lanceerde Google ook <a hreflang="en" href="https://developers.google.com/tag-manager/serverside">server-side tagging</a> in Google Tag Manager. Het implementeren van tagging aan de serverzijde brengt kleine kosten met zich mee voor e-commercesites, maar het kan sites helpen overhead van derden te elimineren en zo statistieken zoals Total Blocking Time (TBT), First Input Delay (FID) en Time to Interactive (TTI) te verbeteren. Simon Ahava heeft <a hreflang="en" href="https://www.simoahava.com/analytics/server-side-tagging-google-tag-manager/">veel nuttige informatie op zijn blog</a> die we de lezers aanbevelen.

Het gebruik van tagging aan de serverzijde is afhankelijk van de vraag of derde partijen sjablonen aan de serverzijde leveren om de migratie te vergemakkelijken. Dit zijn vroege dagen voor GTM server-side tagging en op het moment van schrijven van dit hoofdstuk, vonden we geen server-side sjablonen in openbaar beschikbare <a hreflang="en" href="https://tagmanager.google.com/gallery/#/?context=server&page=1">community gallery</a>. Maar als de acceptatie toeneemt, zal het interessant zijn om de prestatiescores van sites met tagging aan de clientzijde en aan de serverzijde te vergelijken. Andere leveranciers zoals Adobe en Signal bieden ook vergelijkbare serverzijde oplossingen die sites zouden moeten overwegen om te gebruiken om de prestaties te verbeteren.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Tagmanager</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Google Tag Manager</td>
        <td class="numeric">48,45%</td>
        <td class="numeric">46,56%</td>
      </tr>
      <tr>
        <td>Adobe DTM</td>
        <td class="numeric">0,41%</td>
        <td class="numeric">0,38%</td>
      </tr>
      <tr>
        <td>Ensighten</td>
        <td class="numeric">0,13%</td>
        <td class="numeric">0,13%</td>
      </tr>
      <tr>
        <td>TagCommander</td>
        <td class="numeric">0,08%</td>
        <td class="numeric">0,07%</td>
      </tr>
      <tr>
        <td>Signal</td>
        <td class="numeric">0,05%</td>
        <td class="numeric">0,03%</td>
      </tr>
      <tr>
        <td>Matomo Tag Manager</td>
        <td class="numeric">0,02%</td>
        <td class="numeric">0,02%</td>
      </tr>
      <tr>
        <td>Yahoo! Tag Manager</td>
        <td class="numeric">0,00%</td>
        <td class="numeric">0,00%</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">Totaal</th>
        <th scope="col" class="numeric">49,14%</th>
        <th scope="col" class="numeric">47,20%</th>
      </tr>
    </tfoot>
  </table>
  <figcaption>{{ figure_link(caption="Tagmanager-gebruik op e-commercesites.", sheets_gid="2045910168", sql_file="percent_of_ecommsites_using_each_tag_managers.sql") }}</figcaption>
</figure>

<p class="note">Opmerking: de bovenstaande analyse is gebaseerd op Wappalyzer-detectie, die kan verschillen van de analyse die is uitgevoerd met behulp van de <a href="./methodology#third-party-web">Third Party Web</a> dataset die wordt gebruikt voor <a href="./third-parties">Derden</a> hoofdstuk.</p>

### Toestemmingsbeheerplatformen

Het hoofdstuk [Privacy](./ privacy) van dit jaar behandelde de invoering van Toestemmingsbeheerplatformen op alle soorten websites. Wanneer we de acceptatie op e-commercesites vergelijken met alle sites, zien we een iets hogere acceptatie op zowel mobiel (4,2% op e-commercesites versus 4,0% op alle sites) als desktop (4,6% op e-commercesites versus 4,4% op alle sites).

{{ figure_markup(
  image="ecommerce-consent-management-platform-adoption.png",
  caption="Acceptatie van Toestemmingsbeheerplatformen",
  description="Een staafdiagram laat zien dat 4,4% van alle desktopwebsites en 4,0% van de mobiele sites een Toestemmingsbeheerplatformen gebruiken, vergeleken met respectievelijk 4,6% en 4,2% voor e-commercesites. E-commercesites hebben dus een iets hoger gebruik van CMP's.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=285357141&format=interactive",
  sheets_gid="1374272999",
  sql_file="percent_of_ecommsites_using_cmp.sql"
) }}

Wat betreft het aandeel van verschillende CMP's, was de trend voor e-commerce websites vergelijkbaar met alle websites die worden behandeld in het hoofdstuk [Privacy](./privacy). In toekomstige edities van de Web Almanac verwachten we dat deze acceptatie zal toenemen naarmate steeds meer landen met hun eigen regels komen. Ook is onlangs het "Content Management Platform"(Toestemmingsbeheerplatform) aan Wappalyzer toegevoegd door het Web Almanac-team. Hoewel het team de meest populaire CMP's heeft toegevoegd, verwachten we dat er na verloop van tijd extra CMP's zullen worden toegevoegd en dus een verwachte toename van de adoptiestatistieken.

### Toegankelijkheidsoplossingen

In de introductie van het [Toegankelijkheid](./accessibility) -hoofdstuk van dit jaar spreekt het Web Almanac-team over de gevaren van het implementeren van toegankelijkheidsoplossingen voor snelle oplossingen en verwijst naar het briljante artikel van Lainey Feingold, <a hreflang="en" href="https://www.lflegal.com/2020/08/quick-fix/" lang="en">Honor the ADA: Avoid Web Accessibility Quick Fix Overlays</a>.

Hoewel het niet wordt aanbevolen, hebben we gekeken naar het gebruik van dergelijke oplossingen op e-commercewebsites en ontdekten dat 0,47% van de mobiele websites en 0,54% van de desktopwebsites dergelijke oplossingen heeft geïmplementeerd.

In de huidige methodologie die voor dit hoofdstuk is aangenomen, is er geen gemakkelijke manier voor ons om te kijken of een van de topwebsites voor e-commerce deze snelle oplossing heeft gevolgd in plaats van te proberen toegankelijkheid te bereiken met het ontwerp. Het zal mogelijk zijn om dit in de toekomst te achterhalen door HTTP Archive-gegevens te combineren met publicaties zoals Top 500 VK-sites van internationale detailhandel of vergelijkbare publicaties.

### AMP adoption

{{ figure_markup(
  caption="AMP-gebruik op e-commercesites (mobiel).",
  content="0,61%",
  classes="big-number",
  sheets_gid="1317152621",
  sql_file="pct_ampusage_bydevice_vendor.sql"
)
}}

In het SEO-hoofdstuk behandelden we statistieken over [AMP-gebruik op alle websites](./seo#amp). In dit hoofdstuk kijken we naar de acceptatie van AMP op e-commerce websites. AMP-acceptatie blijft laag op e-commercewebsites (0,61% op mobiel en 0,66% op desktop), aangezien AMP nog steeds niet alle gebruiksscenario's voor e-commerce ondersteunt. In deze analyse vertrouwen we ook op detectie met behulp van Wappalyzer en dit kan resulteren in dubbeltellingen van e-commercesites waar AMP is geïmplementeerd als een ander domein met behulp van het `<link rel="amphtml"...>` element. Dit zou geen probleem moeten zijn bij het bekijken van percentages, aangezien dergelijke domeinen ook twee keer worden geteld bij het bedenken van totale e-commerce websites.

We hebben ook overwogen om te kijken naar CRUX-prestaties van e-commercewebsites met hun AMP-tegenhanger (indien geïmplementeerd op een ander domein met behulp van het attribuut `amphtml`). Een dergelijke analyse helpt ons te identificeren of er een significant verschil was in de prestaties van het AMP-domein, maar vanwege de lage acceptatiegraad van AMP op e-commercewebsites, levert een dergelijke analyse mogelijk geen zinvolle resultaten op en hebben we de analyse uitgesteld voor toekomstige jaren (als adoptiepercentages stijgen).

### Web push-meldingen

Marketeers zijn dol op pushmeldingen, maar volgens de ervaring van de auteur is het bewustzijn van marketeers over webpushmeldingen nog steeds erg laag, ondanks de introductie van <a hreflang="en" href="https://developers.google.com/web/updates/2015/03/push-notifications-on-the-open-web">Push API</a> in 2015 voor het eerst in Chrome. We hebben geprobeerd te kijken naar de acceptatie van webpushmeldingen (die mogelijk zijn met behulp van technologieën zoals service workers) op e-commercesites. Als onderdeel van de toestemmingsgegevens van CRUX-meldingen hebben we toegang tot statistieken zoals push-acceptatiepercentages, push-prompts ontslagpercentages. Raadpleeg <a hreflang="en" href="https://developers.google.com/web/updates/2020/02/notification-permission-data-in-crux">dit Google-artikel</a> voor meer details over hoe deze gegevens worden vastgelegd en welke statistieken beschikbaar zijn.

In onze analyse ontdekten we dat slechts 0,68% van de desktop-e-commercesites en 0,69% van de mobiele e-commercesites webpushmeldingen gebruiken. Als het om push-meldingen gaat, is het belangrijk dat klanten push-meldingen nuttig vinden. De sleutel hiervoor is om op het juiste moment in de klantreis toestemming te vragen en gebruikers niet te bombarderen met irrelevante meldingen. Om de vermoeidheid van de klant aan te pakken met pushmeldingen, schrijft Chrome automatisch sites met zeer lage acceptatiepercentages in voor <a hreflang="en" href="https://blog.chromium.org/2020/05/protecting-chrome-users-from-abusive.html">stillere gebruikersinterface voor meldingen</a> (hoewel de exacte drempel nog niet is gedefinieerd). Standaard gebruikersinterface wordt hersteld voor de site wanneer de acceptatiegraad binnen de controlegroep verbetert.

PJ Mclachlan (Product Manager, Google) heeft gesproken over <a hreflang="en" href="https://www.youtube.com/watch?v=J_t8c9HOjBc">streven naar een acceptatiepercentage van ten minste 50%</a> om op een veilig gebied te zijn om te voorkomen dat u in een stillere gebruikersinterface voor meldingen terechtkomt en streeft naar een acceptatiegraad van 80% en hoger. De mediane acceptatiepercentages voor meldingen voor een e-commercewebsite zijn 13,6% op mobiel en 13,2% op desktop. Op mediaan niveau hebben deze acceptatiegraden veel te wensen over. Zelfs op het 90e percentielniveau zien de cijfers er niet erg goed uit (36,9% voor mobiel en 36,8% voor desktop). E-commercesites kunnen verwijzen naar deze <a hreflang="en" href="https://www.youtube.com/watch?v=riKmez3sHaM">bespreking voor aanbevolen patronen om ervoor te zorgen dat de push-acceptatiepercentages gezond blijven</a> en ze niet overrompeld worden door aanstaande wijzigingen in misbruikmeldingen.

{{ figure_markup(
  image="web-push-notification-acceptance-rates.png",
  caption="Acceptatiepercentages voor webpushmeldingen",
  description="Een staafdiagram met de acceptatiepercentages van webpushmeldingen, waarbij het 10e percentiel 4% op mobiel heeft, het 25e percentiel 9%, 50e 14%, 75e 20%, en 90e percentiel 37%, en het 100e percentiel met een acceptatiegraad van 89%. De acceptatiegraad voor desktops lijkt vrijwel identiek.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1062364223&format=interactive",
  sheets_gid="2129008669",
  sql_file="webpushstats_ecommsites.sql"
) }}

## Toekomstige analysemogelijkheden

Het zal ook interessant zijn om te kijken naar de acceptatie van native apps door e-commercesites door gebruik te maken van native app-associatiestandaarden zoals `.well-known/assetlinks.json` in de Play Store en `.well-known/apple-app-site-association` in de app store. Google heeft het PWA's gemakkelijk gemaakt om dit te bereiken met Trusted Web Activity, maar momenteel zijn er geen openbare statistieken beschikbaar over hoeveel sites deze techniek gebruiken om hun PWA's in de Play Store in te dienen.

Het hoofdstuk [SEO](./seo) van dit jaar bevat analyse van websites met behulp van de attributen `hreflang` en `lang` en de HTTP-header `content-langauge`. Dit in combinatie met Wappalyzer-detectie van grensoverschrijdende handelsoplossingen zoals Global-e, Flow, Borderfree kan de mogelijkheid bieden om alleen naar grensoverschrijdende handelsaspecten van de e-commerce websites te kijken. Momenteel heeft Wappalyzer geen aparte categorie voor `grensoverschrijdende handel` en daarom is dit type analyse niet mogelijk tenzij we zelf een repository van dergelijke oplossingen bouwen.

Wappalyzer biedt ook detectie van betalingsoplossingen (Apple Pay / PayPal / ShopPay etc.), maar op basis van de soorten implementatie en oplossing is het niet altijd mogelijk om dit te detecteren door alleen naar de startpagina te kijken, maar voor oplossingen waarbij detectie kan worden gedaan door gewoon te kijken op de homepagina kan een dergelijke analyse handig zijn om naar de jaar-tot-jaar trends te kijken.

## Gevolgtrekking

Covid-19 heeft de groei van e-commerce in 2020 enorm versneld en veel kleinere spelers moesten snel online aanwezig zijn en moesten manieren vinden om door te gaan met handelen tijdens lockdowns. Platformen zoals WooCommerce/Shopify/Wix/BigCommerce speelden een zeer belangrijke rol bij het online brengen van steeds meer kleine bedrijven. Covid-19 zag ook de lancering van D2C-aanbiedingen (direct naar de consument) per merk en dit zal naar verwachting in de toekomst toenemen. De volledige impact van Covid-19 is mogelijk niet zichtbaar in de Web Almanac van dit jaar, aangezien deze nieuwe bedrijven eerst een bepaalde verkeersdrempel moeten overschrijden om deel uit te maken van de CRUX-dataset die we gebruiken voor onze analyse. Om deze reden kunnen we mogelijk ook in de analyse van volgend jaar een aanhoudende groei zien.

Het verbeteren van de web vitals score zal een prioriteit zijn voor e-commercebedrijven vanwege veranderingen die zijn aangekondigd door Google en marketingteams die webpushmeldingen gebruiken, moeten hun notificatiestatistieken in de gaten houden met behulp van CRUX om niet gepakt te worden door aanstaande wijzigingen in misbruikmeldingen. Tagmanagers lijken nog steeds voor veel wrijving te zorgen tussen marketing- en engineeringteams en oplossingen zoals Google Tag Manager-tagging aan de serverzijde zullen wat opgang maken, maar we verwachten niet dat er veel zal veranderen in 2021 en dit zal meer zijn als een reis van 3-5 jaar. De gemeenschap moet hun respectieve derde partijen vragen om compatibele oplossingen te bieden om dit ecosysteem verder te ontwikkelen.

Terwijl we ons de beperking herinneren dat we voor deze analyse alleen homepagina-gegevens zoeken, zouden we graag van de gemeenschap willen horen wat we nog meer zouden moeten bespreken in de analyse van volgend jaar. We hebben enkele mogelijkheden voor verdere analyse besproken in de sectie hierboven en <a hreflang="en" href="https://discuss.httparchive.org/t/2052">feedback wordt zeer op prijs gesteld</a>.
