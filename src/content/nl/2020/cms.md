---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: CMS-hoofdstuk van de Web Almanac van 2020 over CMS-acceptatie, hoe CMS-suites worden gebouwd, gebruikerservaring van CMS-aangedreven websites en CMS-innovatie.
hero_alt: Hero image of Web Almanac charactes on a type writer writing a web page.
authors: [alexdenning]
reviewers: [sirjonathan, ernee, amedina]
analysts: [GregBrimble, rviscomi]
editors: [tunetheweb]
translators: [noah-vdv]
alexdenning_bio: Alex Denning is de oprichter van <a hreflang="en" href="https://getellipsis.com/">Ellipsis Marketing</a>, een marketingbureau voor WordPress-bedrijven. Alex is een WordPress Core-bijdrager en heeft geholpen bij het organiseren van <a hreflang="en" href="https://london.wordcamp.org/">WordCamp London</a>.
discuss: 2051
results: https://docs.google.com/spreadsheets/d/1vTf459CcCbBuYeGvgo-RSidppR62SfM-VTkW-dfS3K4/
featured_quote: De term Contentmanagement Systeem (CMS) verwijst naar systemen waarmee individuen en organisaties inhoud kunnen creëren, beheren en publiceren. Een CMS voor webcontent is met name een systeem dat is gericht op het creëren, beheren en publiceren van content die via internet kan worden geconsumeerd en ervaren.
featured_stat_1: 42%
featured_stat_label_1: Webpagina's worden aangedreven door een CMS
featured_stat_2: 1,5 grams
featured_stat_label_2: CO2 uitgestoten door de gemiddelde CMS-paginalaad
featured_stat_3: 74%
featured_stat_label_3: CMS met WordPress (hetzelfde als vorig jaar!)
---

## Inleiding

De term Content Management System (CMS) verwijst naar systemen waarmee individuen en organisaties inhoud kunnen creëren, beheren en publiceren. Een CMS voor webcontent is met name een systeem dat is gericht op het creëren, beheren en publiceren van inhoud die via internet kan worden geconsumeerd en ervaren.

Elk CMS implementeert een deelverzameling van een breed scala aan inhoudbeheermogelijkheden en de bijbehorende mechanismen waarmee gebruikers eenvoudig en effectief websites kunnen bouwen rond hun inhoud. Inhoud wordt vaak opgeslagen in een soort database, waardoor gebruikers de flexibiliteit hebben om deze te hergebruiken waar dat nodig is voor hun inhoudstrategie. CMS'en bieden ook beheermogelijkheden om het voor gebruikers gemakkelijk te maken om naar behoefte inhoud te uploaden en te beheren.

Er is een grote variatie in het type en de omvang van de ondersteunende CMS'en voor bouwterreinen; sommige bieden kant-en-klare sjablonen die worden aangevuld met gebruikersinhoud, en andere vereisen veel meer gebruikersbetrokkenheid voor het ontwerpen en bouwen van de sitestructuur.

Als we aan CMS'en denken, moeten we rekening houden met alle componenten die een rol spelen bij de levensvatbaarheid van een dergelijk systeem om een platform te bieden voor het publiceren van inhoud op internet. Al deze componenten vormen een ecosysteem rond het CMS-platform en omvatten hostingproviders, extensieontwikkelaars, ontwikkelingsbureaus, sitebouwers, enz. Dus als we het hebben over een CMS, verwijzen we meestal naar zowel het platform zelf als het omliggende ecosysteem.

Er zijn veel interessante en belangrijke aspecten die moeten worden geanalyseerd en vragen die moeten worden beantwoord in onze zoektocht naar de CMS-ruimte en zijn rol in het heden en de toekomst van het web. We erkennen de uitgestrektheid en complexiteit van de CMS-platformruimte en brengen onze nieuwsgierigheid en diepgaande expertise naar enkele van de belangrijkste spelers in de ruimte.

In dit hoofdstuk proberen we inzicht te krijgen in de huidige staat van de CMS-ecosystemen, de rol die ze spelen bij het vormgeven van de perceptie van gebruikers over hoe inhoud kan worden geconsumeerd en ervaren op internet, en hun impact op het milieu. Ons doel is om aspecten te bespreken die verband houden met het CMS-landschap in het algemeen, en de kenmerken van webpagina's die door deze systemen worden gegenereerd.

Deze tweede editie van de Web Almanac bouwt voort op het werk van vorig jaar. We hebben nu het voordeel dat we de resultaten van 2020 kunnen vergelijken met 2019 om trends vast te stellen. Laten we in onze analyse duiken.

## Waarom een CMS gebruiken in 2020?

Mensen en organisaties gebruiken in 2020 een CMS, omdat CMS'en in veel gevallen een snelkoppeling bieden om een website te maken die aan hun behoeften voldoet. Zoals we later zullen bespreken, zijn er zowel algemene als gespecialiseerde CMS'en. De algemene CMS'en zijn vaak uitbreidbaar met add-ons, en de gespecialiseerde CMS'en zijn vaak gericht op specifieke branchebehoeften of functionaliteit.

Welk CMS er ook wordt gebruikt, het wordt gebruikt omdat het een probleem oplost voor de gebruiker of organisatie. Het valt buiten ons bereik om te onderzoeken waarom elk CMS wordt gekozen, maar later onderzoeken we waarom het meest populaire CMS, WordPress, onevenredig wordt gekozen.

## CMS-adoptie

Onze analyse tijdens dit werk kijkt naar desktop- en mobiele websites. De overgrote meerderheid van de URL's die we hebben bekeken, bevindt zich in beide datasets, maar sommige URL's zijn alleen toegankelijk voor desktop- of mobiele apparaten. Hierdoor kunnen kleine verschillen in de data ontstaan en kijken we dus apart naar desktop- en mobiele resultaten.

Meer dan 42% van de webpagina's wordt aangedreven door een CMS-platform, een stijging van meer dan 5% ten opzichte van 2019. Dit komt neer op 42,18% op desktop, tegen 40,01% in 2019, en 42,27% op mobiel, tegen 39,61% in 2019.

{{ figure_markup(
  image="cms-adoption.png",
  caption="CMS-acceptatietrend.",
  description="Staafdiagram met de toename van het niveau van CMS-acceptatie in 2019 en 2020. Mobiel is gestegen van 39,61% naar 42,47%. Desktop is gestegen van 40,01% naar 42,18.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=2061880890&format=interactive",
  sheets_gid="1638210080",
  sql_file="cms_adoption_compared_to_2019.sql"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>Jaar</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>2019</td>
        <td class="numeric">39,61%</td>
        <td class="numeric">40,01%</td>
      </tr>
      <tr>
        <td>2020</td>
        <td class="numeric">42,27%</td>
        <td class="numeric">42,18%</td>
      </tr>
      <tr>
        <td>% Verandering</td>
        <td class="numeric">6,71%</td>
        <td class="numeric">5,43%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CMS-adoptiestatistieken.", sheets_gid="1638210080", sql_file="cms_adoption_compared_to_2019.sql") }}</figcaption>
</figure>

De toename van desktopwebpagina's aangedreven door een CMS-platform is 5,43% ten opzichte van vorig jaar. Op mobiel is deze stijging ongeveer een kwart hoger, namelijk 6,71%.

Net als bij [vorig jaar](../2019/cms#cms-adoption), zien we andere resultaten van andere datasets voor het bijhouden van marktaandeel van CMS-platforms, zoals <a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management">W3Techs</a>. W3Techs meldt op het moment van schrijven dat 60,6% van de webpagina's wordt gemaakt door CMS'en, tegen 56,4% een jaar geleden. Dit is een stijging van 6,4%, wat in grote lijnen overeenkomt met onze bevindingen.

De afwijking tussen onze analyse en de analyse van W3Techs kan worden verklaard door een verschil in onderzoeksmethodologieën. U kunt meer over de onze lezen op de pagina [Methodologie](./methodology).

Ons onderzoek identificeerde 222 individuele CMS'en, variërend van een enkele installatie tot miljoenen op één CMS.

Sommigen van hen zijn open source (bijvoorbeeld WordPress, Joomla, anderen) en sommige zijn eigendom (bijvoorbeeld Wix, Squarespace, anderen). Zoals we later zullen bespreken, zijn de top 3 CMS'en op basis van adoptieaandeel allemaal open source, maar bij propriëtaire platforms is het adoptieaandeel dit jaar sterk gestegen. Sommige CMS-platforms kunnen worden gebruikt op "gratis" gehoste of door uzelf gehoste abonnementen, en er zijn ook opties om deze platforms te gebruiken op abonnementen met een hoger niveau, zelfs op bedrijfsniveau.

De CMS-ruimte als geheel is een complex, gefedereerd universum van CMS-ecosystemen, allemaal gescheiden en tegelijkertijd met elkaar verweven. Ons onderzoek toont aan dat CMS'en alleen maar belangrijker worden. De minimale toename van 5% in het gebruik van CMS'en toont aan dat in een jaar waarin COVID-19 voor enorme onzekerheid heeft gezorgd, solide CMS-platforms voor enige stabiliteit hebben gezorgd. Zoals we vorig jaar hebben besproken, spelen deze platforms een sleutelrol voor ons om te slagen in onze collectieve zoektocht naar een groenblijvend, gezond en levendig web. Dit is sindsdien meer waar geworden en we verwachten dat dit in de toekomst zo zal blijven.

## Top CMS'en

Onze analyse telde 222 afzonderlijke CMS'en. Hoewel dit een hoog aantal is, hebben 204 hiervan (92%) een adoptieaandeel van 0,01% of lager. Hierdoor blijven er slechts 13 CMS'en over met een adoptieaandeel tussen 0,1 en 1%, en vier met een aandeel tussen 1 en 2%, en één met een aandeel daarover.

Het enige CMS met een aandeel van meer dan 2% is WordPress, dat een gebruiksaandeel van 31% heeft. Dit is meer dan 15 keer het aandeel van het op één na populairste CMS, Joomla:

{{ figure_markup(
  image="cms-adoption-share-for-top-5-cmss.png",
  caption="CMS-adoptieaandeel voor de top 5 CMS'en.",
  description="Staafdiagram waarop te zien is dat WordPress domineert met een aandeel van 28,91% in 2019, groeiend tot 31,04% in 2020. Dit wordt gevolgd door 4 andere CMS'en met elk minder dan 2,5% aandeel: Joomla (2,24% voor 2019 en 2,05% voor 2020), Drupal (2,21%) % en 1,98% respectievelijk), Wix (0,91% en 1,28%) en Squarespace (0,76% en 0,97%). Drupal en Joomla zijn in 2020 in gebruik gedaald, terwijl de rest is toegenomen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1429803707&format=interactive",
  sheets_gid="1594044364",
  sql_file="top_cms_platforms_compared_to_2019.sql"
  )
}}

Joomla en Drupal hebben respectievelijk 8% en 10% van hun adoptieaandeel verloren, terwijl Wix en Squarespace respectievelijk 41% en 28% extra adoptie-aandeel hebben gewonnen. WordPress heeft het afgelopen jaar een extra adoptieaandeel van 7% gewonnen, wat een grotere absolute stijging is dan het totale aandeel voor Joomla, het op één na populairste CMS.

Deze cijfers zijn in grote lijnen consistent wanneer ze worden verdeeld over desktop en mobiel:

{{ figure_markup(
  image="cms-top-5-cms-by-client.png",
  caption="Top 5 CMS'en per cliënt.",
  description="Staafdiagram dat laat zien dat WordPress domineert met een aandeel van 31,37% op desktop en 31,39% op mobiel vergeleken met minder dan 2,5% voor de andere CMS'en: Drupal heeft 2,32% op desktop en 1,99% op mobiel, Joomla heeft 1,96% op desktop en 2,12% op mobiel, Squarespace heeft 1,08% op desktop en 0,85% op mobiel, en Wiz heeft 1,05% op desktop en 1,24% op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=2098327336&format=interactive",
  sheets_gid="908727245",
  sql_file="top_cmss_yoy_all_clients.sql"
  )
}}

Voor WordPress lijken de cijfers erg op elkaar; voor de andere CMS'en is het verschil groter. Drupal en Squarespace hebben respectievelijk 16,7 en 26,3% meer websites op desktop dan op mobiel, terwijl Joomla en Wix 7,5 en 15,2% vaker op mobiel zijn dan op desktop.

De categorie adoptieaandelen van 0,1 tot 1% kent aanzienlijk meer beweging. Deze zijn goed voor CMS'en die tot 50.000 websites aansturen.

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>2019</th>
        <th>2020</th>
        <th>% verandering</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">28,91%</td>
        <td class="numeric">31,04%</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">2,24%</td>
        <td class="numeric">2,05%</td>
        <td class="numeric">-8%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">2,21%</td>
        <td class="numeric">1,98%</td>
        <td class="numeric">-10%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">0,91%</td>
        <td class="numeric">1,28%</td>
        <td class="numeric">41%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">0,76%</td>
        <td class="numeric">0,97%</td>
        <td class="numeric">28%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">0,55%</td>
        <td class="numeric">0,61%</td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>TYPO3 CMS</td>
        <td class="numeric">0,53%</td>
        <td class="numeric">0,52%</td>
        <td class="numeric">-2%</td>
      </tr>
      <tr>
        <td>Weebly</td>
        <td class="numeric">0,39%</td>
        <td class="numeric">0,33%</td>
        <td class="numeric">-15%</td>
      </tr>
      <tr>
        <td>Jimdo</td>
        <td class="numeric">0,28%</td>
        <td class="numeric">0,24%</td>
        <td class="numeric">-16%</td>
      </tr>
      <tr>
        <td>Adobe Experience Manager</td>
        <td class="numeric">0,27%</td>
        <td class="numeric">0,23%</td>
        <td class="numeric">-14%</td>
      </tr>
      <tr>
        <td>Duda</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0,22%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>GoDaddy Website Builder</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0,18%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>DNN</td>
        <td class="numeric">0,20%</td>
        <td class="numeric">0,16%</td>
        <td class="numeric">-19%</td>
      </tr>
      <tr>
        <td>DataLife Engine</td>
        <td class="numeric">0,19%</td>
        <td class="numeric">0,16%</td>
        <td class="numeric">-12%</td>
      </tr>
      <tr>
        <td>Tilda</td>
        <td class="numeric">0,08%</td>
        <td class="numeric">0,16%</td>
        <td class="numeric">100%</td>
      </tr>
      <tr>
        <td>Liferay</td>
        <td class="numeric">0,12%</td>
        <td class="numeric">0,11%</td>
        <td class="numeric">-10%</td>
      </tr>
      <tr>
        <td>Microsoft SharePoint</td>
        <td class="numeric">0,15%</td>
        <td class="numeric">0,11%</td>
        <td class="numeric">-25%</td>
      </tr>
      <tr>
        <td>Kentico CMS</td>
        <td class="numeric">0,00%</td>
        <td class="numeric">0,11%</td>
        <td class="numeric">10819%</td>
      </tr>
      <tr>
        <td>Contao</td>
        <td class="numeric">0,09%</td>
        <td class="numeric">0,09%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>Craft CMS</td>
        <td class="numeric">0,08%</td>
        <td class="numeric">0,09%</td>
        <td class="numeric">5%</td>
      </tr>
      <tr>
        <td>MyWebsite</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0,09%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>Concrete5</td>
        <td class="numeric">0,10%</td>
        <td class="numeric">0,09%</td>
        <td class="numeric">-12%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Relatief % adoptie van kleinere CMS'en (0,1% - 1% adoptieaandeel)", sheets_gid="1594044364", sql_file="top_cmss_yoy_all_clients.sql") }}</figcaption>
</figure>

We zien hier drie nieuwkomers: Duda, GoDaddy Website Builder en MyWebsite. Two, Tilda en Kentico CMS, hebben het afgelopen jaar een wijziging in het adoptieaandeel van meer dan 100% gezien. Deze "lange staart" van CMS'en omvat een mix van open source en propriëtaire platforms en omvat alles van consumentvriendelijk tot branchespecifiek. Een ongelooflijke kracht van de CMS-platforms als geheel is dat er gespecialiseerde software beschikbaar is voor elk denkbaar type website.

Als we kijken naar het aandeel van CMS-adoptie ten opzichte van andere CMS'en (dus websites zonder CMS uitgezonderd), wordt de dominantie van WordPress duidelijk. Het adoptieaandeel van websites met een CMS is 74,2%. Met deze relatieve cijfers ontvangen Joomla, Drupal, Wix en Squarespace hogere acceptatiegraad: respectievelijk 4,9%, 4,7%, 3,1% en 2,3%:

{{ figure_markup(
  image="cms-adoption-share-2020.png",
  caption="CMS-adoptieaandeel 2020.",
  description="Cirkeldiagram toont de acceptatie van CMS'en die worden gedomineerd door WordPress die bijna driekwart van het aandeel (74,92%) in beslag nemen, en andere CMS'en die elk minder dan 5% vertegenwoordigen: Joomla 4,9%, Drupal 4,7%, Wix 3,1%, Squarespace 2,3%, 1C-Bitrix 1,5% en TYPO3 CMS 1,2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=701401011&format=interactive",
  sheets_gid="1594044364",
  sql_file="top_cmss_yoy_all_clients.sql"
  )
}}

### WordPress gebruik

WordPress domineert deze ruimte en verdient daarom verdere discussie.

<a href="https://nl.wordpress.org/about/">WordPress is een open source project</a> met als missie "publiceren democratiseren". Het CMS is gratis. Hoewel dit waarschijnlijk een belangrijke factor is in het adoptiegedeelte, zijn de twee op één na populairste CMS'en - Joomla en Drupal - ook gratis. De WordPress-gemeenschap, bijdragers en het zakelijke ecosysteem zijn waarschijnlijk de belangrijkste onderscheidende factoren.

Een "kern" WordPress-gemeenschap handhaaft de CMS- en servicevereisten voor aanvullende functionaliteit door middel van aangepaste services en producten (thema's en plug-ins). Deze gemeenschap heeft een grote impact, met een relatief klein aantal mensen die zowel het CMS zelf onderhouden als de extra functionaliteit bieden die WordPress krachtig en flexibel genoeg maakt om de meeste soorten websites te kunnen bedienen. Deze flexibiliteit is belangrijk bij het uitleggen van het marktaandeel.

Als gevolg van deze flexibiliteit heeft WordPress ook een lage toetredingsdrempel voor ontwikkelaars en "bouwers" of "uitvoerders" van sites. We zien een positieve cyclus: flexibele extensies maken het bouwen van sites steeds eenvoudiger, waardoor steeds meer gebruikers steeds krachtigere sites kunnen bouwen met WordPress. Deze toename van gebruikers maakt het voor ontwikkelaars aantrekkelijker om steeds betere extensies te maken, waardoor de cyclus wordt bevorderd.

{{ figure_markup(
  image="cms-wordpress-plugin-resource-per-page.png",
  caption="WordPress-plug-ins middelen per pagina.",
  description="Staafdiagram met het aantal WordPress-plug-ins per pagina met 4 plug-ins voor mobiel en desktop op het 10e percentiel, 8 voor beide op het 25e percentiel, 22 voor beide op het 50e percentiel, 46 voor desktop en 44 voor mobiel op het 75e percentiel, 76 voor desktop en 74 voor mobiel op het 90e percentiel en 1918 voor desktop en 1948 voor mobiel op 100e percentiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1286172532&format=interactive",
  sheets_gid="1543932766",
  sql_file="wp_resources.sql"
  )
}}

We hebben onderzocht hoe WordPress-sites deze extensies gebruiken, meestal WordPress-plug-ins. De gemiddelde WordPress-site (op desktop en mobiel) laadt 22 bronnen voor plug-ins per pagina, waarbij sites op het 90e percentiel respectievelijk 76 en 74 bronnen per pagina laden op desktop en mobiel. Op het 100e percentiel gaat dit zo hoog als 1918 en 1948 bronnen per pagina op respectievelijk desktop en mobiel. Hoewel we dit niet kunnen vergelijken met andere CMS'en, lijkt het waarschijnlijk dat het extensie-ecosysteem van WordPress een belangrijke bijdrage levert aan de hoge acceptatiegraad.

De groei van het adoptieaandeel van WordPress van 7,40% tussen 2019 en 2020 overtreft de algehele toename van de acceptatie van CMS'en als geheel. Dit suggereert dat WordPress aantrekkelijker is dan het "gemiddelde" CMS.

2020 heeft de impact van COVID-19 gezien. Dit kan de toename van het marktaandeel verklaren. Anekdotisch kunnen we suggereren dat met veel fysieke bedrijven die permanent of tijdelijk sluiten, er een toenemende vraag is naar websites in het algemeen en WordPress, aangezien het grootste CMS,  heeft hiervan geprofiteerd. Om de volledige impact vast te stellen, is de komende jaren verder onderzoek nodig.

Nu het adoptie-aandeel van CMS'en is onderzocht, gaan we nu onze aandacht richten op de gebruikerservaring.

## CMS-gebruikerservaring

CMS'en moeten een goede gebruikerservaring bieden. Omdat een groot deel van het web afhankelijk is van CMS'en om pagina's te bedienen, is het de verantwoordelijkheid van het CMS op platformniveau om ervoor te zorgen dat de gebruikerservaring goed is. Ons doel is om licht te werpen op de echte gebruikerservaring bij het gebruik van CMS-aangedreven websites.

Om dit te bereiken, richten we onze analyse op een aantal door de gebruiker waargenomen prestatiestatistieken, die zijn vastgelegd in de drie Core Web Vitals-statistieken, evenals de Lighthouse-scores in de categorieën SEO en Toegankelijkheid.

### Chrome User Experience Report

In dit gedeelte bekijken we drie belangrijke factoren die worden geboden door het [Chrome User Experience Report](./methodology#chrome-ux-report), dat licht kan werpen op ons begrip van hoe gebruikers CMS-aangedreven webpagina's ervaren in het wild:

- First Contentful Paint (FCP)
- First Input Delay (FID)
- Cumulative Layout Shift (CLS)

Deze statistieken zijn bedoeld om de kernelementen te dekken die indicatief zijn voor een geweldige webgebruikerservaring. Het hoofdstuk [Performance](./performance) zal deze in meer detail behandelen, maar hier zijn we geïnteresseerd in het bekijken van deze statistieken in het bijzonder in termen van CMS'en. Laten we ze allemaal eens bekijken.

#### Largest Contentful Paint

Largest Contentful Paint (LCP) meet het punt waarop de belangrijkste inhoud van de pagina waarschijnlijk is geladen en dus is de pagina nuttig voor de gebruiker. Het doet dit door de weergavetijd te meten van het grootste beeld of tekstblok dat zichtbaar is in de viewport.

Dit is anders dan First Contentful Pain (FCP), dat meet vanaf het laden van de pagina totdat inhoud zoals tekst of een afbeelding voor het eerst wordt weergegeven. LCP wordt beschouwd als een goede proxy om te meten wanneer de hoofdinhoud van een pagina wordt geladen.

Een "goed" LCP wordt beschouwd als minder dan 2,5 seconden. De gemiddelde website op een van de vijf beste CMS'en heeft geen goed LCP. Alleen Drupal op desktop scoort hier meer dan 50%. We zien grote verschillen tussen desktop- en mobiele scores: WordPress scoort redelijk zelfs 33% op desktop en 25% op mobiel, maar Squarespace scoort 37% op desktop en slechts 12% op mobiel.

{{ figure_markup(
  image="cms-real-user-largest-contentful-paint-experiences.png",
  caption="Largest Contentful Paint-ervaringen door echte gebruikers.",
  description="Staafdiagram met de top 5 CMS'en en of ze een “goede” Largest Contentful Paint-ervaring hebben. WordPress is middelmatig met 33% op desktop en 25% op mobiel, Drupal is de beste met 61% op desktop en 47% op mobiel, Joomla is de tweede beste met 48% op desktop en 28% op mobiel, Squarespace heeft 37% op desktop maar slechts 12% op mobiel en Wix is het laagste met 9% op desktop en 9% op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=188727692&format=interactive",
  sheets_gid="465267881",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

Hoewel we graag zouden zien dat CMS'en hier veel beter presteren, zijn er nog steeds enkele positieve punten uit deze resultaten. Ten eerste valt het feit dat 61% van de Drupal-websites een goede LCP heeft, vooral op omdat het veel beter is dan de wereldwijde distributie van 48% van de websites met een goede LCP, volgens het [Chrome UX Report](https://x.com/ChromeUXReport/status/1293306510509039616). Dat 1 op de 3 of 4 WordPress-websites een goede LCP heeft, is ook best verbazingwekkend, gezien de enorme omvang van het aantal WordPress-websites. Wix heeft wel wat in te halen, maar het is bemoedigend om te zien dat de technici van Wix [actief](https://x.com/DanShappir/status/1308043752712343552) bezig zijn met het oplossen van prestatieproblemen, dus dit is iets om door de jaren heen in de gaten te houden.

#### First Input Delay

First Input Delay (FID) meet de tijd vanaf het moment waarop een gebruiker voor het eerst interactie heeft met uw site (dat wil zeggen wanneer ze op een link klikken, op een knop tikken of een aangepast, JavaScript-aangedreven besturingselement gebruiken) tot het moment waarop de browser daadwerkelijk in staat is om op die interactie te reageren. Een "snelle" FID vanuit het perspectief van een gebruiker zou onmiddellijke feedback zijn van hun acties op een site in plaats van een vastgelopen ervaring. Elke vertraging is een pijnpunt en kan verband houden met interferentie door andere aspecten van het laden van de site wanneer de gebruiker probeert te communiceren met de site.

FID is erg snel voor de gemiddelde CMS-website op desktop - alleen Wix scoort lager dan 100% - en gemengd op mobiel. De meeste CMS'en leveren mobiele FID op een gemiddelde site binnen een redelijk bereik van de desktopscore. Voor Wix is het aantal websites met een goede FID op mobiel bijna de helft van het desktop-totaal.

{{ figure_markup(
  image="cms-real-user-first-input-delay-experiences.png",
  caption="First Input Delay-ervaringen door echte gebruikers.",
  description="Staafdiagram met de top 5 CMS'en en of ze een “goede” ervaring met de eerste invoervertraging hebben. Ze hebben allemaal een ervaringsscore van 100% op desktop, behalve Wix met 87%. Voor mobiel heeft WordPress 88%, Drupal 76%, Joomla 71%, Squarespace 91% en Wix 46%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=893606466&format=interactive",
  sheets_gid="465267881",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

De FID-scores zijn hier over het algemeen goed, in tegenstelling tot de LCP-scores. Zoals gesuggereerd, zou het gewicht van individuele pagina's op CMS'en, naast de kwaliteit van de mobiele verbinding of de lagere prestaties van mobiele apparaten ten opzichte van desktops, een rol kunnen spelen in de prestatieverschillen die we hier zien en die FID minder beïnvloeden.

Er is een kleine verschilmarge tussen de bronnen die naar desktopversies en mobiele versies van een website worden verzonden. Vorig jaar merkten we op dat optimaliseren voor de mobiele ervaring noodzakelijk was. De gemiddelde scores op desktop en mobiel zijn gestegen, maar op mobiel is meer aandacht vereist.

#### Cumulative Layout Shift

Cumulatieve Layout Shift (CLS) meet de instabiliteit van inhoud op een webpagina na de eerste 500 ms gebruikersinvoer en na de eerste gebruikersinvoer. Dit is met name belangrijk op mobiele apparaten, waar de gebruiker zal tikken waar hij een actie wil ondernemen, zoals een zoekbalk, alleen om de locatie te verplaatsen als aanvullende afbeeldingen, advertenties of soortgelijke ladingen.

Een score van 0,1 of lager wordt gemeten als "goed", meer dan 0,25 is "slecht" en alles daartussenin is "moet worden verbeterd".

{{ figure_markup(
  image="cms-real-user-cumulative-layout-shift-experiences.png",
  caption="Cumulatieve Layout Shift-ervaringen door echte gebruikers.",
  description="Staafdiagram met de top 5 CMS'en en of ze een “goede” ervaring hebben met Cumulative Layout Shift. WordPress heeft 47% van de desktopsites met een “goede ervaring” en 57% van de mobiele sites. Drupal heeft 58% voor desktop en 70% voor mobiel, Joomla heeft 51% voor desktop en 63% voor mobiel, Squarespace heeft 35% voor desktop en 44% voor mobiel, en Wix heeft 58% voor desktop en 59% voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1265001868&format=interactive",
  sheets_gid="465267881",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

De top 5 CMS'en zouden hier kunnen verbeteren. Slechts 50% van de webpagina's die worden geladen door een top 5 CMS heeft een "goede" CLS-ervaring, en dit cijfer stijgt tot 59% op mobiele apparaten. Voor alle CMS'en is de gemiddelde desktopscore 59% en de gemiddelde mobiele score 67%. Dit laat zien dat alle CMS'en hier werk aan de winkel hebben, maar met name de top 5 CMS'en behoeven verbetering.

### Lighthouse scores

[Lighthouse](./methodology#lighthouse) is een open-source, geautomatiseerd hulpmiddel dat is ontworpen om ontwikkelaars te helpen bij het beoordelen en verbeteren van de kwaliteit van hun websites. Een belangrijk aspect van de hulpmiddel is dat het een reeks audits biedt om de status van een website te beoordelen in termen van prestaties, toegankelijkheid, SEO, progressieve web-apps en meer. Voor het hoofdstuk van dit jaar hebben we gekeken naar twee specifieke categorieën van audits: SEO en toegankelijkheid.

#### SEO

Zoekmachineoptimalisatie (of SEO) is het optimaliseren van websites om ervoor te zorgen dat de inhoud van uw website gemakkelijker vindbaar is in zoekmachines. Dit wordt dieper behandeld in ons hoofdstuk [SEO](./seo), maar een deel betreft het verzekeren dat de site zo is gecodeerd dat de crawlers van zoekmachines zoveel mogelijk informatie kunnen verstrekken om het hen zo gemakkelijk mogelijk te maken om uw site op de juiste manier weer te geven in de resultaten van zoekmachines. In vergelijking met een op maat gemaakte website, zou u verwachten dat een CMS goede SEO-mogelijkheden biedt, en de Lighthouse-scores in deze categorie laten hoge cijfers zien:

{{ figure_markup(
  image="cms-seo-lighthouse-score.png",
  caption="SEO Lighthouse scores voor Top 5 CMS'en.",
  description="Staafdiagram met de gemiddelde SEO-score voor elk van de top 5 CMS'en. WordPress heeft een gemiddelde score van 0,9, Joomla 0,86, Drupal 0,83, Wix 0,93 en Squarespace 0,93",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=895876622&format=interactive",
  sheets_gid="1671385936",
  sql_file="median_lighthouse_score.sql"
  )
}}

Alle top 5 CMS'en scoren hier hoog met mediane scores van 0,83 of hoger, sommige zelfs tot 0,93. SEO kan ervan afhangen dat de website-eigenaar gebruik maakt van de mogelijkheden van een CMS, maar als deze opties gemakkelijk te gebruiken zijn in een CMS, en goede standaardinstellingen, kan dit grote voordelen hebben voor sites die op die CMS'en draaien.

#### Toegankelijkheid

Een toegankelijke website is een site die zo is ontworpen en ontwikkeld dat mensen met een handicap deze kunnen gebruiken. Webtoegankelijkheid komt ook ten goede aan mensen zonder handicap, zoals mensen met langzame internetverbindingen. <a hreflang="en" href="https://www.w3.org/WAI/fundamentals/accessibility-intro/#what">Een volledige discussie is hier te zien</a>, en in ons hoofdstuk [Toegankelijkheid](./accessibility).

Lighthouse biedt een reeks toegankelijkheidscontroles en retourneert een gewogen gemiddelde van alle audits (zie <a hreflang="en" lang="en" href="https://web.dev/accessibility-scoring/">Scoring Details</a> voor een volledige lijst van hoe elke audit wordt gewogen).

Elke toegankelijkheidscontrole is ofwel geslaagd of mislukt, maar in tegenstelling tot andere Lighthouse-audits krijgt een pagina geen punten voor het gedeeltelijk slagen voor een toegankelijkheidscontrole. Als sommige elementen bijvoorbeeld schermlezersvriendelijke namen hebben, maar andere niet, krijgt die pagina een 0 voor de controle van schermlezersvriendelijke namen.

{{ figure_markup(
  image="cms-accessibility-lighthouse-score.png",
  caption="Toegankelijkheid Lighthouse scores voor Top 5 CMS'en.",
  description="Staafdiagram met de mediane nalevingsscore voor toegankelijkheid voor elk van de top 5 CMS'en. WordPress heeft een mediane score van 0,84, Joomla 0,80, Drupal 0,84, Wiz leidt met 0,94 en Squarespace heeft 0,90",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=721104287&format=interactive",
  sheets_gid="1671385936",
  sql_file="median_lighthouse_score.sql"
  )
}}

De mediane toegankelijkheidsscore van Lighthouse voor de top 5 CMS'en is allemaal hoger dan 0,80. Voor alle CMS'en is de gemiddelde mediane Lighthouse-score 0,78, met een minimum van 0,44 en een maximum van 0,98. We zien dus dat de top 5 CMS'en beter zijn dan gemiddeld, met sommige beter dan andere. Wix en Squarespace hebben de hoogste scores van de top 5. Mogelijk helpt het feit dat deze platforms eigendom zijn hier, omdat ze de sites die worden gemaakt beter kunnen controleren.

De lat zou hier echter hoger moeten zijn. Een gemiddelde score van 0,78 voor alle CMS-en laat nog aanzienlijke ruimte voor verbetering, en de maximale score van 0,98 laat zien dat zelfs het "beste" CMS voor naleving van toegankelijkheid voor verbetering vatbaar is. Het verbeteren van de toegankelijkheid is essentieel en urgent.

## Milieu-impact

Dit jaar hebben we geprobeerd de impact van CMS'en op het milieu beter te begrijpen. <a hreflang="en" href="https://www.nature.com/articles/d41586-018-06610-y">De informatie- en communicatietechnologie (ICT) -industrie is verantwoordelijk voor 2% van de wereldwijde koolstofemissies</a>, en datacentra zijn specifiek verantwoordelijk voor 0,3% van wereldwijde koolstofemissies. Hiermee komt de CO2-voetafdruk van de ICT-industrie overeen met de uitstoot van brandstof door de luchtvaartindustrie. We hebben hier geen gegevens over de rol van CMS'en, maar uit ons onderzoek blijkt dat 42% van de websites een CMS gebruikt, het is duidelijk dat CMS'en een belangrijke rol spelen bij de efficiëntie van websites en hun impact op het milieu.

In ons onderzoek is gekeken naar het gemiddelde CMS-paginagewicht in KB en dit in kaart gebracht op de CO2-uitstoot met behulp van logica van <a hreflang="en" href="https://gitlab.com/wholegrain/carbon-api-2-0/-/blob/master/include/carbonapi.php#L342">carbonapi</a>. Dit leverde de volgende resultaten op, uitgesplitst naar desktop en mobiel:

{{ figure_markup(
  image="cms-carbon-emissions-per-cms-page-view.png",
  caption="CO2-uitstoot per CMS-paginaweergave.",
  description="Staafdiagram met de grammen CO2-uitstoot voor CMS-pagina's per percentiel. Bij het 10e percentiel is het 0,5 gram voor desktop en 0,4 voor mobiel, bij het 25e percentiel is het 0,8 gram voor zowel mobiel als desktop, bij de 50% is dit 1,5 gram voor beide, bij het 75e percentiel 2,8 gram voor desktop en 2,7 voor mobiel en op het 90e percentiel is dit 4,9 gram voor desktop en 4,7 voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1375803209&format=interactive",
  sheets_gid="1594044364",
  sql_file="distribution_of_page_weight_requests_and_co2_grams_per_cms_web_page.sql"
  )
}}

We ontdekten dat de mediane CMS-paginalading resulteerde in de overdracht van 2,41 MB en dus de uitstoot van 1,5 g CO2. Dit was hetzelfde voor desktop en mobiel. Het meest efficiënte percentiel van CMS-webpagina's resulteert in de generatie van minstens een derde minder CO2, terwijl het minst efficiënte percentiel van CMS-webpagina's de andere kant op gaat: meer dan een derde minder efficiënt dan de mediaan. Het meest efficiënte percentiel van pagina's is ongeveer tien keer efficiënter dan het minst efficiënte percentiel.

CMS'en ondersteunen elk type website, dus deze discrepantie is niet verrassend. CMS'en kunnen echter op platformniveau invloed hebben op de efficiëntie van websites die ze maken.

Paginagewicht is hier belangrijk. De gemiddelde desktop CMS-webpagina laadt 2,4 MB HTML, CSS, JavaScript, media, enz. 10% van de pagina's laadt echter meer dan 7 MB van deze gegevens. Op mobiele apparaten laadt de gemiddelde webpagina 0,1 MB minder dan op een desktop, waarbij dit aantal in ieder geval geldt voor alle percentielen:

{{ figure_markup(
  image="cms-distribution-of-cms-pages-sizes.png",
  caption="Verdeling van CMS-paginaformaten.",
  description="Staafdiagram met de paginagrootte in MB voor elk percentiel voor CMS-pagina's. Bij het 10e percentiel is dit 0,8 MB voor desktop en 0,7 voor mobiel, bij het 25e percentiel is het 1,3 MB voor zowel mobiel als desktop, bij 50% is dit 2,4 MB voor desktop en 2,3 MB voor mobiel, bij 75 percentiel 4,4 MB voor desktop en 4,3 voor mobiel en bij het 90e percentiel is dit 7,7 MB voor desktop en 7,4 voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1039607732&format=interactive",
  sheets_gid="1074693681",
  sql_file="distribution_of_page_weight_requests_and_co2_grams_per_cms_web_page.sql"
  )
}}

CMS laadt vaak bronnen van derden, zoals externe afbeeldingen, video's, scripts of stylesheets:

{{ figure_markup(
  image="cms-third-party-bytes.png",
  caption="Bytes van derden.",
  description="Staafdiagram met het aantal bytes van derden (in KB) voor elk percentiel voor CMS-pagina's. Op het 10e percentiel is dit 68,03 KB voor desktop en 52,97 voor mobiel, bij het 25e percentiel is dit 179,97 KB voor mobiel en 147,52 KB voor mobiel, bij 50% is dit 436,44 KB voor desktop en 397,33 MB voor mobiel, op het 75e percentiel 936,18 KB voor desktop en 927,64 voor mobiel en bij het 90e percentiel is dit 1.735,25 KB voor desktop en 1.766,15 voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=1932733912&format=interactive",
  sheets_gid="1916130433",
  sql_file="third_party_bytes_and_requests_on_cmss.sql"
  )
}}

We constateren dat de gemiddelde desktop-CMS-pagina 27 verzoeken van derden heeft met 436 KB inhoud, terwijl het mobiele equivalent 26 verzoeken genereert met 397 KB inhoud.

Een van de belangrijkste manieren waarop een CMS de grootte van de pagina kan beïnvloeden, is door het gebruik van efficiëntere formaten te ondersteunen en aan te moedigen. Afbeeldingen staan alleen achter video in hun bijdrage aan het paginagewicht.

{{ figure_markup(
  image="cms-median-cms-kb-per-resource-type.png",
  caption="Mediane CMS KB per brontype.",
  description="Staafdiagram met de mediane brongrootte in KB van elk brontype voor CMS'en. Audio 14 KB op desktop en 10 KB op mobiel, CSS is 102 KB op desktop en 98 op mobiel, lettertypen zijn 152 KB op desktop en 125 op mobiel, afbeeldingen zijn 1.273 KB op desktop en 1.280 op mobiel, video is 1.665 KB op desktop en 2.139 KB op mobiel en XML is 1 KB voor zowel desktop als mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=74536341&format=interactive",
  sheets_gid="1846606749",
  sql_file="third_party_bytes_and_requests_on_cmss.sql"
  )
}}

Video draagt hier een groter percentage per brontype bij. Het efficiënter maken van video of andere mechanismen, zoals de impact van het stoppen van automatisch afspelen, zijn interessante gebieden voor toekomstig onderzoek. Hier ligt onze focus op afbeeldingen. Populaire afbeeldingsindelingen zijn JPEG, PNG, GIF, SVG, WebP en ICO. Hiervan is <a hreflang="en" href="https://developers.google.com/speed/webp/">WebP is het meest efficiënt in de meeste situaties</a>, met WebP lossless afbeeldingen <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_lossless_alpha_study#results">26% kleiner</a> dan vergelijkbare PNG's en <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">25-34% kleiner</a> dan vergelijkbare JPG's. We zien echter dat WebP het op één na minst populaire afbeeldingsformaat is op alle CMS-pagina's:

{{ figure_markup(
  image="cms-popularity-of-image-formats.png",
  caption="Populariteit van afbeeldingsformaten.",
  description="Staafdiagram met het percentage afbeeldingen per type op CMS'en. Desktop volgt mobiel gebruik op de voet. jpg is 33% van de afbeeldingsindelingen op zowel desktop als mobiel, onbekend is 25% voor desktop en 26% voor mobiel, png is 25% voor desktop en 23% voor mobiel, gif is 13% voor beide, svg is 2% voor beide, webp 1% voor beide net zoals ico.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTkUxfuK-FCn3_IYDJiEsKDmdmyKb0TSEhG8dFc0XBIXej1NO2uUOmd-9NCbWuh-MZ3xzMhK_kNT-4u/pubchart?oid=2011368432&format=interactive",
  sheets_gid="748745523",
  sql_file="adoption_of_image_formats_in_cmss.sql"
  )
}}

Van de top 5 CMS'en converteert en levert alleen Wix automatisch afbeeldingen in het WebP-formaat. WordPress, Drupal en Joomla ondersteunen WebP met extensies, terwijl Squarespace op het moment van schrijven geen WebP ondersteunt.

Zoals we eerder zagen, had Wix het laagste percentage sites met een "goed" LCP. Hoewel we weten dat Wix efficiënt gebruikmaakt van afbeeldingsbytes in WebP, zijn er duidelijk andere problemen die de LCP-prestaties beïnvloeden buiten de afbeeldingsindelingen die we hier niet controleren. WebP is echter een efficiënter formaat en verbeterde native ondersteuning voor het formaat door de meest populaire CMS'en zou gunstig zijn.

Afbeeldingsformaten zijn een mechanisme om afbeeldingen efficiënter te maken. Andere mechanismen zoals "luie laden" van beelden zouden baat hebben bij toekomstig onderzoek.

We kunnen de vraag naar de impact van CMS'en op het milieu niet volledig beantwoorden, maar we dragen bij aan een antwoord. CMS'en hebben de verantwoordelijkheid om de impact op het milieu serieus te nemen en het verlagen van het gemiddelde paginagewicht is belangrijk werk.

## Gevolgtrekking

CMS'en zijn het afgelopen jaar alleen maar belangrijker geworden. Ze zijn essentieel voor de manier waarop inhoud op internet wordt gemaakt en geconsumeerd, en er zijn geen tekenen dat dit in de nabije toekomst zal veranderen. CMS'en zullen elk jaar belangrijker worden.

We hebben de acceptatie van CMS'en, de gebruikerservaring van websites die door deze CMS'en zijn gemaakt, bekeken en hebben voor het eerst gekeken naar de impact van CMS'en op het milieu. We hebben hier veel vragen beantwoord, maar laten verdere vragen onbeantwoord. Verder onderzoek dat voortbouwt op dit hoofdstuk zal dankbaar worden ontvangen. We hebben ook enkele gebieden belicht die aandacht behoeven door de CMS'en. We hopen dat er vooruitgang zal worden geboekt in het rapport voor 2021.

CMS'en zijn essentieel voor het succes van internet en open web. Laten we toewerken naar voortdurende vooruitgang.
