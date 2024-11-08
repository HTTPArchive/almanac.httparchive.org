---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Mobiel internet
description: Het hoofdstuk over Mobiel Internet van de Web Almanac van 2020 behandelt het laden van pagina's, tekstuele inhoud, zoomen en schalen, knoppen en links en het gemak van het invullen van formulieren.
authors: [spanicker, mdiblasio]
reviewers: [foxdavidj]
analysts: [foxdavidj]
editors: [exterkamp]
translators: [noah-vdv]
spanicker_bio: Shubhie Panicker is de technische leider voor Chrome's betrokkenheid bij het webframework-ecosysteem, waar ze samenwerkt met open source-hulpmiddelen, frameworks en gemeenschappen. Als lid van Chrome's Web Platform-team heeft ze gewerkt aan webstandaarden en de implementatie van Chromium voor verschillende webprestatie-API's. Voordat ze bij Chrome kwam, werkte ze aan infrastructuur- en webframeworks voor Google-producten zoals Search, Google Photos enz.
mdiblasio_bio: Michael DiBlasio is Web Ecosystems Consultant bij Google. Hij richt zich op het helpen verbeteren van de gezondheid van het webecosysteem en om ervoor te zorgen dat het web commercieel levensvatbaar is voor videomakers en partners. Hij werkt nauw samen met strategische retailers om nieuwe moderne webtechnologieën toe te passen en de kwaliteit van bestaande webervaringen te verbeteren. Voordat hij bij Google kwam, was Michael consultant bij IBM.
discuss: 2048
results: https://docs.google.com/spreadsheets/d/1DGLY7UEWOlDL5_2dtS_j2eqMjiV-Rw5Fe2y6K6-ULvM/
featured_quote: Mobiel Internet is het afgelopen decennium explosief gegroeid en is nu de belangrijkste manier waarop veel mensen internet ervaren. Desondanks blijven engagement en online verkoop nog steeds achter bij desktop. In dit hoofdstuk kijken we naar recente trends op het mobiele web en analyseren we waarom gebruikersreis vaak moeilijk te voltooien zijn.
featured_stat_1: 41,20%
featured_stat_label_1: Percentage pagina's met afbeeldingen van onjuist formaat
featured_stat_2: 60,1%
featured_stat_label_2: Percentage van e-commerce-bestemmingspagina's zonder aanwezigheid van zoekinvoer
featured_stat_3: 2,6s
featured_stat_label_3: 75e percentiel LCP voor mobiel
---

## Inleiding
Mobiel Internet is het afgelopen decennium explosief gegroeid en is nu de belangrijkste manier waarop veel mensen internet ervaren. Desondanks blijven engagement en online verkoop nog steeds achter bij desktop. In dit hoofdstuk kijken we naar recente trends op het mobiele web en analyseren we waarom gebruikersreis vaak moeilijk te voltooien zijn.

In 2020 is het <a hreflang="en" href="https://www.nytimes.com/interactive/2020/04/07/technology/coronavirus-internet-use.html">internetgebruik</a> enorm gestegen, zowel op mobiel als op desktop, als gevolg van de wereldwijde pandemie. Het aantal bezoeken aan nieuwssites, e-commerce en sociale-mediasites is toegenomen doordat mensen over de hele wereld zich hebben aangepast aan een nieuwe levensstijl met lockdowns en sociale afstand. 2020 was een belangrijk jaar in de geschiedenis, zowel voor internet als voor mobiel gebruik.

### Gegevensbronnen
We hebben in dit hoofdstuk een aantal verschillende gegevensbronnen gebruikt:

* [CrUX](./methodology#chrome-ux-report)
* [HTTP Archive](./methodology#dataset)
* [Lighthouse](./methodology#lighthouse)

Bezoek de bovenstaande links voor meer informatie over de methodologie en kanttekeningen bij elke gegevensbron. Het is vermeldenswaard dat de HTTP Archive- en Lighthouse-gegevens beperkt zijn tot de gegevens die alleen op de startpagina's van websites worden geïdentificeerd, en niet op de hele site.

Naast het bovenstaande hebben we ook een niet-openbare Chrome-gegevensbron gebruikt in het gedeelte over het laden van pagina's in Chrome. Lees voor meer informatie over de <a hreflang="en" href="https://chromium.googlesource.com/chromium/src/+/master/services/metrics/ukm_api.md">gegevensverzamelings-API van Chrome</a>.

Hoewel deze gegevens alleen worden verzameld van een subset van (aangemelde) Chrome-gebruikers, hebben ze geen last van het feit dat ze beperkt zijn tot startpagina's. Het is pseudoniem en bestaat uit histogrammen en gebeurtenissen.

<p class="note">OPMERKING: Rapportage is ingeschakeld als de gebruiker een functie heeft ingeschakeld die browservensters synchroniseert, tenzij ze de instelling "Zoeken en browsen beter maken/URL's van pagina's die u bezoekt naar Google sturen" hebben uitgeschakeld.</p>

## Verkeerstrends voor mobiel internet en desktop

Hoeveel bezoeken gebruikers websites op mobiel internet en desktop? Zijn er patronen in het verkeer dat websites ontvangen van mobiel versus desktop? Om deze vragen te onderzoeken en wat het betekent voor websites, hebben we gekeken naar gegevens van een paar lenzen.

Een <a hreflang="en" href="https://www.perficient.com/insights/research-hub/mobile-vs-desktop-usage-study">rapport</a> dat op perficient.com is gepubliceerd, toont verkeerstrends op mobiel versus desktop over een aantal jaren, met <a hreflang="en" href="https://www.similarweb.com/">similarweb</a> als gegevensbron. Hoewel de meeste bezoeken - **58%** van de sitebezoeken - afkomstig waren van mobiele apparaten, vormden mobiele apparaten slechts 42% van de totale tijd die online werd doorgebracht. Bovendien is de gemiddelde tijd die per bezoek wordt doorgebracht ongeveer twee keer zo veel op desktop als op mobiel (11,52 minuten op desktop versus 5,95 minuten op mobiel).

### Paginaladingen in Chrome (Chrome gegevensbron)

Merk op dat deze sectie verwijst naar statistieken die specifiek voor dit hoofdstuk beschikbaar zijn gemaakt vanuit de niet-openbare Chrome-gegevensbron, [zie details hier](#gegevensbronnen). We gebruiken deze gegevens om het laden van pagina's op Android en Windows te beoordelen — als een proxy voor respectievelijk mobiel en desktop.

<p class="note">OPMERKING: we verwijzen naar de gegevens in deze sectie als mobiel voor Android en desktop voor Windows.</p>

#### Paginaladingen in verschillende herkomsten, gerangschikt op populariteit

We keken naar het verkeer naar de herkomst op populariteit: hoe vaak bezoeken gebruikers een bepaalde herkomst, en wat zegt dat ons over de wereldwijde verspreiding op internet?

Rick Byers [tweette](https://x.com/RickByers/status/1195342331588706306) deze distributie een jaar geleden, we keken naar de laatste gegevens. De grafiek toont ons de algehele verdeling over de herkomst op basis van hun populariteit, vastgelegd door hun bijdrage aan het percentage pagina's dat wordt geladen in Chrome.

{{ figure_markup(
  image="page-loads-across-origins-ranked-by-popularity.png",
  caption='Paginaladingen in verschillende herkomsten, gerangschikt op populariteit (in Chrome)',
  description="Grafiek waaruit blijkt dat een klein aantal herkomsten een groot deel van het verkeer vormt, zowel voor mobiel als voor desktop. De top 30 herkomsten vormen 25% van het totale verkeer op mobiele apparaten. De top 200 herkomsten vormen 33% van het totale verkeer op mobiele apparaten",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=949521302&format=interactive",
  sheets_gid="1301196247"
  )
}}

Belangrijke punten:

* Het gebruik van Chrome is ongeveer gelijk verdeeld over de top 200 sites, de volgende 10.000 en de rest.
* Het web heeft een **dikke kop**.
  * Een klein aantal herkomsten vormt een groot deel van het verkeer, zowel voor mobiel als voor desktop.
  * De top 30 herkomsten vormen 25% van het totale verkeer op mobiele apparaten.
  * De top 200 herkomsten vormen 33% van het totale verkeer op mobiele apparaten.
* Het web heeft een **brede romp**.
  * De top 10k-herkomsten vormen ongeveer tweederde van het verkeer: 64% van het verkeer op mobiele apparaten.
* Het web heeft een **lange staart**.
  * 3M herkomsten in de top 98% op Android versus 1,8M op Windows.
  * De staart is op Android ongeveer twee keer zo lang als op Windows. Dit is hoogstwaarschijnlijk toe te schrijven aan het grotere aantal mobiele apparaten en gebruikers in vergelijking met desktop.

#### Verkeer naar een site van mobiel versus desktop (CrUX)

*Zou een website kunnen redeneren over de verwachte distributie van mobiel verkeer versus desktop verkeer?*

Het is moeilijk te voorspellen, omdat de verdeling tussen mobiel en desktop sterk zal variëren per site. Bovendien hangt het sterk af van de branchecategorie (bijv. entertainment, winkelen) en of de site native apps heeft en hoe agressief native apps worden gepromoot, enz.

We hebben de CrUX-dataset bekeken om Chrome-verkeer naar sites vanaf mobiele apparaten versus desktop te beoordelen.

{{ figure_markup(
  image="mobile-traffic-distribution.png",
  caption='Verdeling van mobiel verkeer versus ander verkeer',
  description="Grafiek die laat zien hoe mobiel het merendeel van het verkeer is voor de meeste websites. 50% van de geanalyseerde websites ontvangt 77,61% of meer van hun verkeer via mobiele apparaten (een lichte daling ten opzichte van 79,93% in 2019).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=1290224874&format=interactive",
  sheets_gid="2049480794"
  )
}}

De distributie lijkt mobiel zwaar. Een reden hiervoor is dat er veel (2 miljoen + in CrUX) sites zijn die, hoewel ze weinig verkeer hebben, alleen verkeer van mobiel ontvangen. Mobiel heeft een veel langere "staart", zoals we in de vorige sectie hebben gezien.

Als we alle websites met CrUX-gegevens in een emmer plaatsen en er willekeurig een kiezen, zou 50% van de tijd de door u gekozen website 77,61% of meer van hun verkeer van mobiel ontvangen (een lichte daling van 79,93% in 2019).

Merk op dat hoewel dit een interessante observatie is, het moeilijk is om conclusies te trekken uit CrUX over brede trends voor mobiel versus desktop, omdat:
* CrUX bevat alleen gegevens van Chrome en mist andere browsers, waaronder Safari - een belangrijke mobiele browser.
* Zelfs voor Chrome is dit een subset van aangemelde gebruikers en wordt het beïnvloed door aanmeldingspercentages en variantie tussen platforms.

#### Trendconclusies

Dus wat hebben we geleerd in termen van redenering over mobiel versus desktopverkeer naar een website?

Verkeersverdeling van mobiel versus desktop is zeer specifiek voor een site en afhankelijk van de branchecategorie en andere factoren, zoals de aanwezigheid van native apps. De kans is echter groot dat voor sitebezoeken in Chrome een bepaalde website voornamelijk verkeer van mobiel internet ontvangt, ondanks dat gebruikers meer tijd op desktop doorbrengen. Dit komt door een veel langere staart voor mobiel Chrome.

Hoewel men de verwachte verkeersverdeling van mobiel versus desktop voor individuele websites niet kan generaliseren, is het de moeite waard om de distributie van uw site te vergelijken met <a hreflang="en" href="https://www.perficient.com/insights/research-hub/mobile-vs-desktop-usage-study">die van de branchecategorie</a>.

Als uw website aanzienlijk verschilt van het branchegemiddelde, kan het de moeite waard zijn om naar de reden te graven, bijvoorbeeld een slechte laadprestatie kan een van de redenen zijn.

## De gebruikersreis

Gebruikersreizen, inclusief commerciële reizen, op het mobiele web zijn vaak moeilijk te voltooien.

Hoewel mobiel 79,6% van de tijd die op winkelsites wordt doorgebracht, vertegenwoordigt, is het slechts goed voor 32,3% van de <a hreflang="en" href="https://www.emarketer.com/content/frictionless-commerce-2020">e-commerceverkopen</a>. Dit suggereert dat gebruikers hun reis vaak op mobiel beginnen, maar vaak eindigen op desktop. Hoe komt dat?

Om over dit soort vragen te redeneren, moeten we eerst de elementen van de gebruikersreis begrijpen.

We splitsen de gebruikersreis op in 4 fasen.

### 1. Acquisitie

Voor een website is het werven van bezoekers een cruciale instapfase. Acquisitie houdt in dat bezoekers naar de website worden getrokken, vaak via zoekmachines, advertentieklikken, links van andere sites en van sociale media.

#### SEO

SEO is cruciaal voor de acquisitiefase. Zoekmachines zijn een belangrijke bron van bezoekers die naar websites worden gestuurd en aan hun gebruikersreis beginnen. Het belangrijkste doel van SEO is ervoor te zorgen dat een website is geoptimaliseerd voor zoekmachines, d.w.z. zoekmachine-bots die de pagina's moeten crawlen en indexeren, evenals de gebruikers die op de website navigeren en de inhoud ervan consumeren.

Veel gebruikers beginnen hun zoektocht nu op mobiel.

##### Responsive webdesign

Vanwege de populariteit van mobiele apparaten om op internet te browsen en te zoeken, is Google search een paar jaar geleden overgeschakeld naar een <a hreflang="en" href="https://developers.google.com/search/blog/2016/11/mobile-first-indexing">mobiel-eerste Index</a>. Dit betekent dat in de zoekresultaten wordt gekeken naar pagina's zoals die worden gezien door mobiele gebruikers, en dat mobiele vriendelijkheid nu een rankingfactor is. Google schakelt in maart 2021 <a hreflang="en" href="https://developers.google.com/search/blog/2020/07/prepare-for-mobile-first-indexing-with">volledig over op een mobile-first index</a> voor alle sites.

Websites moeten mobielvriendelijkheid garanderen voor een goede zoekervaring en SEO, aangezien dit van invloed is op het verkeer van zoekgebruikers. <a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/responsive-design">Responsive webdesign</a> is de aanbevolen manier om dit te bereiken.

Responsieve websites gebruiken de viewport-metatag en CSS-mediaquery's om een mobielvriendelijke ervaring te bieden. Ga voor meer informatie over deze aspecten van mobielvriendelijkheid naar het [hoofdstuk SEO](./seo#mobile-friendliness).

Lees hier meer over <a hreflang="en" href="https://web.dev/responsive-web-design-basics/">responsive webdesign</a>.

Naast organisch verkeer van zoekmachines, kunnen **Advertentieklikken** een belangrijke bron zijn van bezoekers die naar websites worden gestuurd. Net als bij SEO kan het optimaliseren van advertenties belangrijk zijn voor websites die investeren in en verkeer ontvangen van advertenties.

#### Laadprestaties

De eerste indruk is belangrijk. Het tijdig leveren van pagina-inhoud is van cruciaal belang om te voorkomen dat bezoekers in de steek worden gelaten en gebruikersfrustratie voorkomen. Laadprestaties zijn een belangrijk aspect van de acquisitiefase, slechte laadprestaties leiden ertoe dat gebruikers deze reis verlaten.

Een <a hreflang="en" href="https://web.dev/milliseconds-make-millions/">recente studie</a> toonde aan dat een verbetering van de mobiele snelheid met 0,1 seconde de conversieratio's met +8,4% voor winkelsites en +10,1% voor reissites verhoogde.

Het laden van prestaties is een veelomvattend onderwerp, dus hebben we een aantal aspecten uitgekozen om hier te behandelen.

##### Largest Contentful Paint

Een belangrijk aspect van de laadervaring is hoe snel de hoofdinhoud van een webpagina wordt geladen en zichtbaar is voor gebruikers. Dit was moeilijk te meten, in het verleden heeft Google prestatiestatistieken aanbevolen, zoals <a hreflang="en" href="https://web.dev/first-meaningful-paint/">First Meaningful Paint</a> (FMP) om dit vast te leggen, maar het was moeilijk uit te leggen en vaak niet in staat om vast te stellen wanneer de hoofdinhoud van de pagina zichtbaar was.

Soms is eenvoudiger beter. Meer recentelijk is ontdekt dat een nauwkeurigere manier om te meten wanneer de hoofdinhoud van een pagina is geladen, is door simpelweg te kijken naar wanneer het grootste element is weergegeven. <a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a> (LCP) is een op timing gebaseerde statistiek die dit vastlegt: het tijdstip waarop de grootste element boven de vouw is weergegeven.

Een goede LCP-score is 2,5s op p75. We ontdekten dat het gemiddelde LCP op p75 2,6s op mobiel en 2,3s op desktop is. Vooral mobiel internet mist het doel op LCP.

{{ figure_markup(
  image="median-p75-lcp-score.png",
  caption="Mediane p75 LCP-score",
  description="Een grafiek die laat zien dat het gemiddelde LCP op p75 2,6s is op mobiel en 2,3s op desktop",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=964425991&format=interactive",
  sheets_gid="872081120"
  )
}}

##### Afbeeldingen

Hoewel elk type item, zoals lettertype, CSS, JavaScript, enz. een belangrijke rol speelt bij de laadprestaties, nemen we afbeeldingen onder de loep.

Het internet blijft evolueren naar pagina's met veel afbeeldingen, met de groei van bandbreedte en de alomtegenwoordigheid van smartphones. En afbeeldingen brengen kosten met zich mee voor de laadprestaties.

Afbeeldingen met een onjuist formaat en niet-geoptimaliseerde afbeeldingen zijn frequente bronnen voor problemen met de afbeeldingsprestaties. Maar liefst 41,20% van de pagina's heeft afbeeldingen met een onjuist formaat.

{{ figure_markup(
  image="pages-with-properly-sized-images.png",
  caption="Pagina's met afbeeldingen van het juiste formaat",
  description="Een grafiek die laat zien dat 41,20% van de mobiele pagina's afbeeldingen met een onjuist formaat heeft.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=1030767824&format=interactive",
  sheets_gid="699494809"
  )
}}

4,1% van de pagina's met afbeeldingen gebruikt het lazy loading-attribuut op hun afbeeldingen, fatsoenlijke acceptatie voor een relatief nieuwe primitief.

### 2. Betrokkenheid

De volgende fase van de gebruikersreis is het betrekken van gebruikers bij het consumeren van inhoud en het vervullen van hun intentie.

#### Inhoud verschuiven

Het verschuiven van inhoud is nadelig voor de ervaring van gebruikers die zich bezighouden met inhoud. Met name inhoud die van positie verandert naarmate de bronnen worden geladen, belemmert de gebruikerservaring. Omdat browsers inhoud downloaden en weergeven zodra ze daartoe in staat zijn, is het belangrijk om uw site zo te ontwerpen dat de gebruikerservaring soepeler verloopt.
Dit is vooral belangrijk voor mobiel internet, omdat verschuivende inhoud meer opvalt op kleine schermen.

{{ figure_markup(
  image="example-of-a-site-shifting-content-while-it-loads-lookzook.gif",
  caption="Voorbeeld van het verschuiven van inhoud die een lezer afleidt. CLS totaal van 42,59%. Afbeelding met dank aan LookZook",
  description="Een video die laat zien dat een website geleidelijk wordt geladen. De tekst wordt snel weergegeven, maar naarmate de afbeeldingen blijven laden, wordt de tekst elke keer steeds verder op de pagina verschoven, wat het lezen erg frustrerend maakt. De berekende CLS van dit voorbeeld is 42,59%. Afbeelding met dank aan LookZook",
  width=360,
  height=640
  )
}}

##### Cumulative Layout Shift

<a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a> (CLS) is een metriek die kwantificeert hoeveel inhoud in de viewport verschuift tijdens het bezoek van de gebruiker.

De <a hreflang="en" href="https://web.dev/articles/optimize-cls">meest voorkomende oorzaken van een slechte CLS</a> zijn:

* Afbeeldingen zonder afmetingen.
* Advertenties, embeds en iframes zonder afmetingen.
* Dynamisch geïnjecteerde inhoud.
* Web Fonts die FOIT/FOUT veroorzaken.
* Acties die wachten op een netwerkreactie voordat DOM wordt bijgewerkt.

Het is niet triviaal om deze oorzaken lokaal of in een ontwikkelomgeving te identificeren, aangezien het sterk afhankelijk is van hoe echte gebruikers de pagina ervaren. Inhoud van derden of gepersonaliseerde inhoud gedraagt zich bij de ontwikkeling vaak niet hetzelfde als bij de productie.

Volgens gegevens van CrUX heeft 60% van de mobiele sites en 54% van de desktopsites een goede CLS.

{{ figure_markup(
  image="aggregate-lcp-performance-by-device.png",
  caption='Aggregaat LCP-prestaties per apparaat',
  description="Een grafiek die laat zien dat 60% van de mobiele sites en 54% van de desktopsites een goede CLS heeft.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=277999653&format=interactive",
  sheets_gid="1730986965"
  )
}}

#### Ontwerp elementen

Om gebruikers te betrekken, is het belangrijk om ze te helpen snel te vinden wat ze zoeken en hun intentie te verwezenlijken.

##### Bestemmingspagina's

Eenvoudige ontwerpaanpassingen gaan een lange weg, bijvoorbeeld een duidelijke call-to-action, en de waardepropositie duidelijk maken voor de gebruiker, met een paar woorden.

{{ figure_markup(
  image="landing-page-cta.png",
  caption='Vier belangrijke onderdelen van de bestemmingspagina van de Pixel-telefoon.<br>(Bron: <a hreflang="en" href="https://winonmobile.withgoogle.com">Google</a>)',
  description="Een afbeelding die de vier delen van de bestemmingspagina van de Pixel-telefoon opsplitst: waardepropositie, call-to-action, geen afleiding, belangrijkste services.",
  width=1200,
  height=642
  )
}}

<a hreflang="en" href="https://www.nngroup.com/articles/auto-forwarding/">Onderzoek heeft aangetoond</a> dat carrousels met auto-forwarding schadelijk zijn voor de gebruikerservaring. Auto-forwarding carrousels op de startpagina moeten worden vermeden of hun frequentie moet worden verlaagd.

##### Kleur en contrast

Bekijk de volgende voorbeelden van <a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/">5 lessen die Eastpak heeft geleerd van zijn mobiele publiek</a>:

{{ figure_markup(
  image="eastpak-20-ctr.png",
  caption='De verbetering door Eastpak van het kleurcontrast van hun belangrijkste call-to-action leidde tot een toename van 20% in klikfrequentie.<br>(Bron: <a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/">Google</a>)',
  description="Een afbeelding die laat zien hoe Eastpak hun klikfrequentie met 20% verhoogde door het kleurcontrast van hun belangrijkste call-to-action-knop te verbeteren",
  width=1094,
  height=1122
  )
}}

Hier, een simpele verandering van een knop die moeilijk te zien is, naar een knop met contrasterende kleuren, verbeterde de klikfrequentie op de belangrijkste call-to-action met 20%.

{{ figure_markup(
  image="eastpak-12-ctr.png",
  caption='De verbetering door Eastpak van het kleurcontrast van hun afrekenknop leidde tot een stijging van 12% in conversieratio.<br>(Bron: <a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-154/marketing-strategies/app-and-mobile/5-lessons-eastpak-learned-its-mobile-audience/">Google</a>)',
  description="Een afbeelding die laat zien hoe Eastpak hun conversieratio met 12% verhoogde door het kleurcontrast van hun afrekenknop te verbeteren",
  width=1166,
  height=1102
  )
}}

Een simpele kleurverandering op de afrekenknop van zwart naar oranje, zorgde ervoor dat het meer opviel en hun conversieratio met 12% verhoogde.

Mckinsey & Company <a hreflang="en" href="https://www.mckinsey.com/business-functions/mckinsey-design/our-insights/the-business-value-of-design#">publiceerde een rapport</a> waaruit blijkt dat bedrijven die sterk zijn in ontwerp en UX betere financiële prestaties laten zien. Op design en UX gerichte bedrijven lieten een sterkere omzetgroei zien in vergelijking met hun tegenhangers in de sector.

Tekst met een lage contrastverhouding is moeilijk leesbaar, bijvoorbeeld lichtgrijze tekst op een witte achtergrond. Dit kan het begrijpend lezen en de leessnelheid voor gebruikers verminderen.

Lighthouse <a hreflang="en" href="https://web.dev/color-contrast/">controleert nu op kleurcontrast</a>, we ontdekten dat 78,94% - een meerderheid van de webpagina's - onvoldoende kleurcontrast hadden.

{{ figure_markup(
  image="sites-with-sufficient-color-contrast.png",
  caption='Sites met voldoende kleurcontrast',
  description="Een grafiek die laat zien dat 78,94%, het merendeel van de webpagina's, onvoldoende kleurcontrast had.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=524145395&format=interactive",
  sheets_gid="1180749800"
  )
}}

##### Tikdoelen

De mobiele gebruikerservaring is vatbaar voor "dikke vingerzetting", aangezien gebruikers sites bezoeken met hun vingers - een nogal onnauwkeurig hulpmiddel vergeleken met het gebruik van een muis op een desktop.

Op basis van onderzoek zijn er normen voor de minimale grootte van knoppen en tikdoelen, evenals de minimale afstand waarop ze van elkaar moeten worden verwijderd. <a hreflang="en" href="https://web.dev/tap-targets/">Lighthouse raadt aan</a> dat doelen niet kleiner mogen zijn dan 48 x 48 px en niet dichter dan 8 px uit elkaar. We ontdekten dat 63,69%, een meerderheid van de webpagina's, tikdoelen met een onjuist formaat had. Dit is een lichte verbetering ten opzichte van vorig jaar, toen 65,57% van de webpagina's tikdoelen met een onjuist formaat had.

{{ figure_markup(
  image="sites-with-properly-sized-tap-targets.png",
  caption='Sites met tikdoelen van de juiste grootte',
  description="Een grafiek die laat zien dat 63,69%, het merendeel van de webpagina's, tikdoelen met een onjuist formaat had. Dit is een lichte verbetering ten opzichte van vorig jaar, toen 65,57% van de webpagina's tikdoelen met een onjuist formaat had.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=1829334180&format=interactive",
  sheets_gid="38974332"
  )
}}

##### Zoek invoer

Zoekinvoer of een zoekbalk is een cruciaal hulpmiddel om gebruikers te boeien, het stelt hen in staat snel de informatie te vinden waarnaar ze op zoek zijn. Het is vooral belangrijk voor mobiele apparaten, omdat ze niet over voldoende schermruimte beschikken om gemakkelijk grote hoeveelheden informatie te kunnen consumeren.

Search wordt veel gebruikt op grote e-commercesites, sites met veel inhoud, nieuwssites en boekingssites om gebruikers te helpen gemakkelijk informatie te vinden. Hoewel een kleine website met een paar pagina's geen zoekinvoer nodig heeft, zal deze wel nodig zijn naarmate de website groeit. Voor sites met meer dan 100 pagina's wordt het aanbevolen om een prominente zoekbalk te hebben.

Een <a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-cee/marketing-strategies/data-and-measurement/lyst-increases-overall-conversion-rate-25-making-usability-improvements/">casestudy met modewebsite lyst.com</a> toonde aan dat het vervangen van het zoekpictogram door een zoekvak gebruikers in staat stelde de zoekfunctie gemakkelijker te vinden, waardoor het gebruik met 43% op desktop en met 13% op mobiel toenam.

{{ figure_markup(
  image="search-input-lyst.png",
  caption='Door het zoekpictogram te vervangen door een zoekvak op lyst.com, verbeterde de conversieratio met 13% op mobiel en 43% op desktop.<br>(Bron: <a hreflang="en" href="https://www.thinkwithgoogle.com/intl/en-cee/marketing-strategies/data-and-measurement/lyst-increases-overall-conversion-rate-25-making-usability-improvements/">Google</a>)',
  description="Een grafiek die laat zien hoe lyst.com het zoekpictogram op hun website heeft vervangen door een zoekvak, en als gevolg daarvan hun conversieratio met 13% op mobiel en 43% op desktop zag stijgen",
  width=1194,
  height=1170
  )
}}

Zoekinvoer wordt gebruikt in 17% van alle sites die elke invoer gebruiken. Met 60,10% mist een meerderheid van de bestemmingspagina's van e-commerce de aanwezigheid van zoekinvoer.

{{ figure_markup(
  image="ecommerce-sites-using-a-search-input.png",
  caption='E-commercesites die een zoekinvoer gebruiken',
  description="Een grafiek die laat zien dat 60,10%, het merendeel van de bestemmingspagina's voor e-commerce, de aanwezigheid van zoekinvoer mist.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=992212527&format=interactive",
  sheets_gid="91645550"
  )
}}

##### A/B-testen

A/B-testen is een cruciaal hulpmiddel voor het nemen van datagestuurde beslissingen over ontwerp- en UX-kwesties. A/B-testen maakt het mogelijk om te valideren dat de UX- en ontwerpwijzigingen de beoogde statistieken meetbaar verbeteren en geen onverwachte regressies veroorzaken.

Hier is een greep uit de ontwerpvragen die A/B kunnen worden getest:
* Zou het veranderen van de kleur van een knop de klikfrequentie verhogen?
* Zou het vergroten van de grootte van klikdoelen het aantal klikken verhogen?
* Zou het vervangen van het zoekpictogram door een zoekvak het aantal voltooide zoekopdrachten verhogen?

Volgens <a hreflang="en" href="https://www.thirdpartyweb.today/">thirdpartyweb.today</a>, is <a hreflang="en" href="https://www.optimizely.com">Optimizely</a> het meest populaire product van derden voor A/B-testen, het wordt gebruikt op meer dan 20.000 pagina's.

### 3. Conversie

Hoewel "conversie" klinkt als een concept dat betrekking heeft op e-commercesites, kan een conversie verwijzen naar een succesvolle gebruikerstransactie, zoals aanmelden voor een muziekstreamingservice, een huurwoning boeken, een recensie schrijven op een reissite, enzovoort.

Volgens Comscore Media Matrix vertegenwoordigt het verkeer van mobiele apparaten 79,6% van de tijd die op Amerikaanse winkelsites wordt doorgebracht, maar slechts 32,3% van de Amerikaanse e-commerceverkopen.

Vergeleken met desktop zijn transacties op mobiele apparaten foutgevoelig en vervelend, aangezien gebruikers persoonlijke informatie moeten invoeren met behulp van kleine toetsenborden en schermformaten. Afrekenstromen moeten eenvoudig en kort zijn om gebruikersfrustratie, of erger nog, verlating te voorkomen. 27% van de gebruikers verlaat het afrekenen vanwege een <a hreflang="en" href="https://www.smashingmagazine.com/2018/08/best-practices-for-mobile-form-design/">"te lang / ingewikkeld afrekenproces"</a>. 35% van de gebruikers verlaat het afrekenen als een winkel <a hreflang="en" href="https://baymard.com/blog/ecommerce-checkout-usability-report-and-benchmark">geen gastafrekenen aanbiedt</a>.

#### Vorm semantiek

Gebruikers kunnen de vereiste informatie gemakkelijker invoeren op mobiele apparaten als hun toetsenbord is geoptimaliseerd voor het juiste invoertype. Een numeriek toetsenbord is bijvoorbeeld handig voor het invoeren van telefoonnummers, terwijl toetsenborden met het "@"-symbool handig zijn voor het invoeren van e-mailadressen. Sites kunnen browserhints geven om de meest geschikte sleutels weer te geven met behulp van het `type` attribuut op `input` tags.

{{ figure_markup(
  image="sites-with-inputs-using-the-following-input-types.png",
  caption='Sites (met invoer) die de volgende invoertypes gebruiken',
  description="Een diagram met de meest gebruikte invoertypen op mobiele apparaten. text: 54,025%; hidden: 37,319%; submit: 29,611%; search: 17,100%; email: 15,164%; checkbox: 14,305%; password: 10,204%; button: 3,442%; radio: 3,391%; image: 2,585%; tel: 2,458%; number: 0,892%; file: 0,668%; range: 0,270%; reset: 0,132%; date: 0,122%; url: 0,104%; input: 0,063%; phone: 0,061%; name: 0,049%; No input type: 0,029%; mail: 0,017%; textbox: 0,016%; username: 0,014%; select: 0,013%; textfield: 0,013%; time: 0,010%; textarea: 0,005%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNyVui4x9yanLKpp8Zz92IJ9c2NKCN_2g7SH-vRoelqT3nABB_uTQnXXScCUo6D-Uis1_wDzwcdGzx/pubchart?oid=1866868829&format=interactive",
  sheets_gid="1443384706"
  )
}}

#### Aanmelden, inloggen en afrekenen

Tegenwoordig kunnen browsers helpen bij het invullen van de nodige gebruikersinformatie om een transactie te voltooien en mogelijke invoerfouten te verminderen. Het attribuut `autocomplete` kan browsers hints geven om invoerelementen te vullen met de juiste gebruikersinformatie. Gebruikers die Chrome Autofill gebruiken om hun gegevens in te voeren, gaan gemiddeld 30% sneller afrekenen <a hreflang="en" href="https://developers.google.com/web/fundamentals/design-and-ux/input/forms#use_metadata_to_enable_auto-complete">dan degenen die dat niet doen</a>.

Auto-complete kan vooral handig zijn bij het voltooien van betalingsstromen waarbij een gebruiker moet inloggen en dus zijn wachtwoord moet onthouden. Volgens een <a hreflang="en" href="https://www.hypr.com/hypr-password-study-findings/">onderzoek door HYPR</a> in 2019, vergat 78% van de gebruikers om een wachtwoord in de afgelopen 90 dagen opnieuw in te stellen.

Het is ook mogelijk om sommige formuliervelden helemaal te verwijderen. De API's voor Credential Management en Payment Request zijn op standaarden gebaseerde browser-API's die een programmatische interface bieden tussen sites en de browser voor naadloos inloggen en betalen. Slechts 0,61% van de eCommerce-sites gebruikt de Payment Request API en slechts 0,008% gebruikt de Credential Management API. Het is vermeldenswaard dat de acceptatie van de Payment Request API is toegenomen in vergelijking met 2019, met een 6x hogere voltooiingspercentage van betalingen.

### 4. Retentie

De laatste fase in de reis is gebruikersbehoud, dit betekent de gebruiker opnieuw betrekken en van hem een terugkerende cliënt of een loyale bezoeker maken.

#### Installeerbaarheid met PWA

Terugkerende gebruikers profiteren van een native app-achtige ervaring met een [PWA](./pwa). Een belangrijk waardevoorstel voor gebruikersbehoud is de installeerbaarheid van een PWA. Wanneer een PWA is geïnstalleerd, is deze beschikbaar vanaf de plaatsen waar een mobiele gebruiker een app verwacht te vinden: het startscherm en de app-lade. Wanneer de gebruiker op de PWA tikt en deze start, wordt deze op volledig scherm geladen en is deze beschikbaar in de taakwisselaar, net als een native app.

Rakuten 24 is een online winkel van Rakuten, een van de grootste e-commercebedrijven in Japan. Een recente <a hreflang="en" href="https://web.dev/rakuten-24/">casestudy met Rakuten 24</a> toonde aan dat het maken van hun webapp <a hreflang="en" href="https://web.dev/define-install-strategy/">installeerbaar</a>, resulteerde in maar liefst 450% in bezoekersbehoud in vergelijking met de vorige mobiele webstroom, over een periode van 1 maand.

Door installeerbaarheid te implementeren, zag Rakuten 24 ook deze verbeteringen over een tijdsbestek van 1 maand:
* 310% stijging van de bezoekfrequentie per gebruiker, vergeleken met de rest van hun internetgebruikers
* 150% stijging van de omzet per cliënt met 150%
* 200% stijging van de conversieratio

#### Een naadloze ervaring op verschillende apparaten
Ten slotte kan het bieden van een naadloze ervaring op verschillende apparaten een diepere gebruikersbetrokkenheid en -retentie ontgrendelen, de aangemelde ervaring maakt dit mogelijk.

Aan het begin van [de gebruikersreis](#de-gebruikersreis) zeiden we dat mobiel 79,6% van de tijd tussen winkelsites vertegenwoordigt, maar slechts 32,3% van de e-commerceverkopen. Dit suggereert dat gebruikers vaak op mobiele apparaten browsen en de gebruikersreis op mobiele apparaten starten, maar dat ze transacties vaak op desktop converteren of voltooien.

Hopelijk hebben we nu een beter begrip gekregen om hierover te redeneren, bijvoorbeeld redenen kunnen zijn: het gemak van het vinden en consumeren van inhoud, het gemak van typen, het invullen van formulieren enz.

Voor grotere sites is het vaak niet de vraag of u moet investeren in mobiel internet *of* desktop, omdat ze elkaar vaak aanvullen.

Het helpt om alle vier fasen van de gebruikersreis in overweging te nemen om het volledige spectrum van mogelijkheden voor het betrekken van de gebruiker te begrijpen, evenals de risico's en uitdagingen in elke fase van de reis.

## Gevolgtrekking

Mobiel is nu de belangrijkste manier om toegang te krijgen tot internet, en toegang tot internet is het afgelopen jaar des te belangrijker geworden. De behoeften van mobiel zijn anders dan die van desktop. Afbeeldingsformaten kunnen en zouden kleiner moeten zijn op mobiele apparaten vanwege kleinere schermen en vaak een beperkt netwerk, maar als we twee vijfde van de afbeeldingen met een onjuist formaat zien, blijkt dat we nog een weg te gaan hebben. Evenzo moeten tikdoelen groter zijn op mobiele apparaten, omdat we niet de precisie van een muis hebben, maar we hebben aangetoond dat dit nog steeds een probleem is. Al met al kunnen website-eigenaren veel doen om het gebruik van mobiel internet gemakkelijker te maken, maar het kan vaak een andere mindset vereisen dan desktop, maar ook niet helemaal de andere kant op gaan en ook desktopgebruikers vergeten.
