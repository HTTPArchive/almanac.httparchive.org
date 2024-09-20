---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Prestatie
description: Prestatiehoofdstuk van de Web Almanac 2020 met betrekking tot Core Web Vitals, Lighthouse Performance Score, First Contentful Paint (FCP) en Time to First Byte (TTFB).
authors: [thefoxis]
reviewers: [borisschapira, rviscomi, foxdavidj, noamr, Zizzamia, exterkamp]
analysts: [max-ostapenko, dooman87]
editors: [tunetheweb]
translators: [noah-vdv]
thefoxis_bio: Karolina is Product Design Lead bij <a hreflang="en" href="https://calibreapp.com/">Calibre</a> en werkt aan het creëren van het meest uitgebreide platform voor snelheidscontrole. Ze beheert de <a hreflang="en" lang="en" href="https://perf.email/">Performance Newsletter</a>, uw bron van nieuws over prestaties en bronnen. Karolina <a hreflang="en" href="https://calibreapp.com/blog/category/web-platform">schrijft ook regelmatig</a> over hoe prestaties de gebruikerservaring beïnvloeden.
discuss: 2045
results: https://docs.google.com/spreadsheets/d/164FVuCQ7gPhTWUXJl1av5_hBxjncNi0TK8RnNseNPJQ/
featured_quote: Slechte prestaties veroorzaken niet alleen frustratie of hebben een negatieve invloed op de conversie, het creëert ook echte toetredingsdrempels. De wereldwijde pandemie van dit jaar heeft die bestaande barrières nog duidelijker gemaakt.
featured_stat_1: 25%
featured_stat_label_1: Sites met een goede FCP op mobiel
featured_stat_2: 18%
featured_stat_label_2: Sites met een goede TTFB op mobiel
featured_stat_3: 4%
featured_stat_label_3: Sites met ongewijzigde Prestatiescore in LH6
---

## Inleiding

Er is een onbetwistbaar nadelig effect dat lage snelheid heeft op de algehele gebruikerservaring en bijgevolg op conversies. Maar slechte prestaties veroorzaken niet alleen frustratie of hebben een negatieve invloed op de bedrijfsdoelen, het creëert ook echte toetredingsdrempels. De wereldwijde pandemie van dit jaar <a hreflang="en" href="https://www.weforum.org/agenda/2020/04/coronavirus-covid-19-pandemic-digital-divide-internet-data-broadband-mobbile/">maakte die bestaande barrières nog duidelijker</a>. Met de verschuiving naar leren op afstand, werken en socializen, werd plotseling ons hele leven online verplaatst. Slechte connectiviteit en gebrek aan toegang tot geschikte apparaten maakten deze verandering op zijn best pijnlijk, zo niet onmogelijk, voor velen. Het is een echte test geweest, waarbij connectiviteit, apparaat- en snelheidsverschillen over de hele wereld naar voren zijn gekomen.

Prestatiehulpmiddelen blijven evolueren om die diverse aspecten van de gebruikerservaring weer te geven en het gemakkelijker maken om onderliggende problemen te vinden. Sinds [het hoofdstuk Prestaties van vorig jaar](../2019/performance) zijn er tal van belangrijke ontwikkelingen geweest in de ruimte die de manier waarop we snelheidsmonitoring benaderen al hebben veranderd.

Met een belangrijke release van de populaire hulpmiddel voor kwaliteitscontrole, Lighthouse 6, <a hreflang="en" href="https://calibreapp.com/blog/how-performance-score-works">het algoritme achter de beroemde Prestatiescore is aanzienlijk veranderd</a>, en dat gold ook voor de scores. <a hreflang="en" href="https://calibreapp.com/blog/core-web-vitals"><span lang="en">Core Web Vitals</span></a>, een reeks nieuwe statistieken die verschillende aspecten van gebruikerservaring weergeven, is vrijgegeven. Het zal een van de factoren zijn voor het rangschikken van zoekresultaten in de toekomst, waardoor de ogen van de ontwikkelingsgemeenschap op de nieuwe snelheidssignalen worden gericht.

In dit hoofdstuk kijken we naar echte wereld prestatiegegevens die worden geleverd door het <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report"><span lang="en">Chrome User Experience Report</span> (CrUX)</a> via de lens van die nieuwe ontwikkelingen en het analyseren van een handvol andere relevante statistieken. Het is belangrijk op te merken dat als gevolg van de beperkingen van iOS, de mobiele resultaten van CrUX geen apparaten met het mobiele besturingssysteem van Apple omvatten. Dit feit zal onmiskenbaar van invloed zijn op onze analyse, vooral wanneer we de metrische prestaties per land onderzoeken.

Laten we erin duiken.

## Prestatiescore van Lighthouse

In mei 2020 werd <a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/releases/tag/v6.0.0">Lighthouse 6 uitgebracht</a>. De nieuwe hoofdversie van de populaire prestatie-auditing-suite introduceerde opmerkelijke wijzigingen in het Prestatiescore-algoritme. De Prestatiescore is een weergave op hoog niveau van de sitesnelheid. In Lighthouse 6 wordt de score gemeten met zes - niet vijf - statistieken: <i lang="en">First Meaningful Paint</i> en <i lang ="en">First CPU Idle</i> zijn verwijderd en vervangen door <i lang="en">Largest Contentful Paint (LCP), Total Blocking Time</i> (TBT, het labequivalent van First Input Delay) en <i lang="en">Cumulative Layout Shift</i> (CLS).

Het nieuwe scoringsalgoritme geeft prioriteit aan de nieuwe generatie prestatiestatistieken: <i lang="en">Core Web Vitals</i> en deprioritering van <i lang="en">First Contentful Paint (FCP), Time to Interactive (TTI)</i> en Speed Index, naarmate hun score afneemt. Het algoritme legt nu ook duidelijk de nadruk op drie aspecten van gebruikerservaring: *interactiviteit* (totale blokkeringstijd en tijd tot interactief), *visuele stabiliteit* (cumulatieve verschuiving van lay-out) en *waargenomen belasting* (First Contentful Paint, Speed Index, Largest Contentful Paint).

Bovendien wordt de score nu berekend met behulp van verschillende referentiepunten voor desktop en mobiel. Wat dit in de praktijk betekent, is dat het minder vergevingsgezind zal zijn op desktop (verwacht snelle websites) en meer ontspannen op mobiel (aangezien benchmarkprestaties op mobiel minder snel zijn dan desktop). U kunt het verschil in score van Lighthouse 5 en 6 vergelijken in <a hreflang="en" href="https://googlechrome.github.io/lighthouse/scorecalc/">de Lighthouse Score rekenmachine</a>. Dus, hoe veranderden de scores echt?

{{ figure_markup(
  image="performance-change-in-lighthouse-score.png",
  caption="Verschil in Lighthouse Prestatiescore tussen versie 5 en 6.",
  description="Kolomdiagram dat de verandering in Prestatiescore tussen versie 5 en 6 weergeeft. Het hoogste percentage websites (4%) nam geen veranderingen in de score waar, en het aantal sites met een afname van de score weegt zwaarder dan de verbetering van de score.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=786955541&format=interactive",
  sheets_gid="518150031",
  sql_file="lh6_vs_lh5_performance_score_02.sql"
  )
}}

Hierboven zien we dat 4% van de websites geen wijziging in de Prestatiescore registreerde, maar het aantal sites met negatieve wijzigingen weegt op tegen de sites met scoreverbeteringen. De scores van de Prestatiescore zijn slechter geworden (met de meest prominente afnamecurve in het gebied van 10-25 punten), wat hieronder nog directer wordt weergegeven:

{{ figure_markup(
  image="performance-lighthouse-score-distributions-yoy.png",
  caption="Distributie van Lighthouse Prestatiescore voor Lighthouse 5 en 6.",
  description="Spreidingsdiagram met het percentage sites dat een 0-100 Prestatiescore ontvangt in Lighthouse 5 en 6. Met het algoritme Lighthouse 6 stijgt het percentage sites met scores tussen 0-25 en neemt het aantal sites met scores tussen 50 en 100 af.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=926035471&format=interactive",
  sheets_gid="1303574513",
  sql_file="lh6_vs_lh5_performance_score_distribution.sql"
  )
}}

In de vergelijking van Lighthouse 5 en Lighthouse 6 kunnen we direct zien hoe de verdeling van de score is veranderd. Met het Lighthouse 6-algoritme zien we een stijging van het percentage pagina's dat scores ontvangt tussen 0 en 25 en een daling tussen 50 en 100. In Lighthouse 5 zagen we 3% van de pagina's die 100 scores kregen, op Lighthouse 6, daalde dat aantal tot slechts 1%.

Deze algemene veranderingen zijn niet onverwacht, gezien een groot aantal wijzigingen in het algoritme zelf.

## <span lang="en"> Core Web Vitals: Largest Contentful Paint</span> {core-web-vitals-largest-contentful-paint}

<span lang="en">Largest Contentful Paint</span> (LCP) is een op timing gebaseerde statistiek van een mijlpaal die de tijd rapporteert waarop het grootste <a hreflang="en" href="https://web.dev/articles/lcp#what-elements-are-considered">boven-de-vouw-element</a> was weergegeven.

### LCP per apparaat

{{ figure_markup(
  image="performance-lcp-by-device.png",
  caption="Geaggregeerde LCP-prestaties opgesplitst per apparaattype.",
  description="Staafdiagram waaruit blijkt dat 53% van de desktop- en 43% van de mobiele website-ervaringen als goed worden gecategoriseerd.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=696629857&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

In de bovenstaande grafiek kunnen we zien dat tussen 43% en 53% van de websites goede LCP-prestaties heeft (minder dan 2,5 seconden): de meerderheid van de websites slaagt erin prioriteiten te stellen en hun kritieke boven-de-vouw media snel te laden. Voor een relatief nieuwe statistiek is dit een optimistisch signaal. Het kleine verschil tussen desktop en mobiel wordt waarschijnlijk veroorzaakt door variërende netwerksnelheden, apparaatcapaciteiten en afbeeldingsgrootte (het duurt langer om grote, desktop-specifieke afbeeldingen te downloaden en weer te geven).

### LCP op geografische locatie

{{ figure_markup(
  image="performance-lcp-by-geo.png",
  caption="Geaggregeerde LCP-prestaties uitgesplitst per land.",
  description="Staafdiagram waaruit blijkt dat de hoogste percentages goede LCP-prestaties worden verdeeld over Europese en Aziatische landen. De Republiek Korea leidt met 76% goede lezingen, terwijl India de laatste is met 16% goede lezingen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1936626175&format=interactive",
  width="645",
  height="792",
  sheets_gid="263037691",
  sql_file="web_vitals_by_country.sql"
  )
}}

Het hoogste percentage goede LCP-metingen wordt voornamelijk verspreid onder Europese en Aziatische landen, waarbij de Republiek Korea (Zuid-Korea) voorop staat met 76% van goede metrische metingen. Zuid-Korea is een constante leider op het gebied van mobiele snelheden, met een indrukwekkende download van 145 Mbps <a hreflang="en" href="https://www.speedtest.net/global-index">gerapporteerd door Speedtest Global Index</a> voor oktober. Japan, Tsjechië, Taiwan, Duitsland en België zijn ook een handvol landen met betrouwbaar hoge mobiele snelheden. Australië is toonaangevend op het gebied van mobiele netwerksnelheden, maar wordt in de steek gelaten door langzame desktopverbindingen en latentie, waardoor het onderaan in de bovenstaande ranglijst staat.

India blijft de laatste in onze reeks gegevens, met slechts 16% goede ervaringen. Hoewel de populatie van mensen die voor het eerst verbinding maken met internet voortdurend toeneemt, zijn de snelheden van mobiele en desktopnetwerken <a hreflang="en" href="https://www.opensignal.com/reports/2020/04/india/mobile-network-experience">nog steeds een probleem</a>, met gemiddelde downloads van 10 Mbps voor 4G, 3 Mbps voor 3G en minder dan 50 Mbps voor desktop.

### LCP per verbindingstype

{{ figure_markup(
  image="performance-lcp-by-connection-type.png",
  caption="Geaggregeerde LCP-prestaties opgesplitst per verbindingstype.",
  description="Staafdiagram waaruit blijkt dat 48% van de websites een goed LCP heeft op 4G. Het aantal goed beoordeelde websites daalt tot 8% op 3G, 1% op 2G, 0% op langzame 2G en 18% op offline verbindingen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=97874305&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

Aangezien LCP een timing is die laat zien wanneer het grootste boven-de-vouw-element is gerenderd (inclusief beelden, video's of blokniveau-elementen die tekst bevatten), is het niet verrassend dat hoe langzamer het netwerk, hoe groter het deel van de metingen slecht is.

Er is een duidelijke correlatie tussen netwerksnelheid en betere LCP-prestaties, maar zelfs op 4G wordt slechts 48% van de resultaten als goed gecategoriseerd, waardoor de helft van de metingen moet worden verbeterd. Het automatiseren van media-optimalisatie, het bedienen van de juiste afmetingen en formaten, en het optimaliseren voor Low Data Mode, zou kunnen helpen om de naald te verplaatsen. Lees meer over <a hreflang="en" href="https://web.dev/articles/optimize-lcp">LCP optimaliseren in deze gids</a>.

## <span lang="en">Core Web Vitals: Cumulative Layout Shift</span> {core-web-vitals-cumulative-layout-shift}

<span lang="en">Cumulative Layout Shift</span> (CLS) kwantificeert hoeveel elementen in de viewport tijdens het paginabezoek bewegen. Het helpt bij het vaststellen van de mate waarin onverwachte bewegingen plaatsvinden op uw websites om de gebruikerservaring te beoordelen, in plaats van te proberen een specifiek deel van de interactie te meten met behulp van een eenheid zoals seconden of milliseconden.

Op die manier is CLS een ander, nieuw type van een Gebruikerervaring-holistische metriek in vergelijking met andere die in dit hoofdstuk worden genoemd.

### CLS per apparaat

{{ figure_markup(
  image="performance-cls-by-device.png",
  caption="Geaggregeerde CLS-prestaties opgesplitst per apparaattype.",
  description="Staafdiagram waaruit blijkt dat meer dan de helft van de websites goede CLS heeft met 54% op desktop en 60% op mobiel. In beide scenario's wordt slechts 21% van de websites beoordeeld als slechte CLS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1672696367&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

Volgens gegevens van CrUX, zowel in het geval van desktop als mobiele apparaten, heeft meer dan de helft van de websites een goede CLS-score. Er is een klein verschil (6 procentpunten) tussen het aantal goed beoordeelde websites tussen desktop en mobiel, in het voordeel van de laatste. We zouden kunnen speculeren dat telefoons goede CLS-beoordelingen behalen vanwege voor mobiel geoptimaliseerde ervaringen die meestal minder feature- en visuals bevatten.

### CLS op geografische locatie

{{ figure_markup(
  image="performance-cls-by-geo.png",
  caption="Geaggregeerde CLS-prestaties uitgesplitst per land.",
  description="Staafdiagram waaruit blijkt dat de top 28-landen ten minste 50% van de websites hebben die goede CLS rapporteren. Matige (moet worden verbeterd) metingen zijn stabiel op 11-15% over de hele linie.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1861585123&format=interactive",
  width="645",
  height="792",
  sheets_gid="47865955",
  sql_file="web_vitals_by_country.sql"
  )
}}

De CLS-prestaties in verschillende geografische regio's zijn voornamelijk goed, met minstens 56% van de sites met een goede beoordeling. Dit is uitstekend nieuws voor de waargenomen visuele stabiliteit. We kunnen vergelijkbare landen zien die voorop lopen in de geografische distributie van het LCP: Republiek Korea, Japan, Tsjechië, Duitsland, Polen.

Visuele stabiliteit wordt minder beïnvloed door geografie en latentie voor andere statistieken, zoals LCP. Het verschil in percentage goede scores tussen het bovenste en onderste land is 61% voor LCP en slechts 13% voor CLS. Het percentage websites met matige beoordelingen is over de hele linie relatief laag en maakt plaats voor 19% -29% van de slechte ervaringen over de hele linie. Er zijn tal van factoren die kunnen bijdragen aan slechte CLS - leer hoe u ze aanpakt in de <a hreflang="en" href="https://web.dev/articles/optimize-cls">Gids voor Cumulatieve Layoutverschuiving Optimaliseren</a>.

### CLS per verbindingstype

{{ figure_markup(
  image="performance-cls-by-connection-type.png",
  caption="Geaggregeerde CLS-prestaties opgesplitst per verbindingstype.",
  description="Staafdiagram met een gelijkmatige verdeling van goede, verbetering behoefte en slechte CLS-metingen. Offline en 4G leiden met respectievelijk 70% en 64% aan goede ervaringen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=151288279&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

Er is een redelijk gelijkmatige verdeling van CLS-scores over de meeste verbindingstypen, behalve offline en 4G. In het offline scenario kunnen we speculeren dat Service Workers websites bedienen. Bijgevolg is er geen vertraging bij het downloaden als gevolg van het verbindingstype, wat resulteert in het grootste deel van de goede cijfers.

Het is een uitdaging om definitieve conclusies te trekken over 4G, maar we kunnen speculeren dat misschien 4G + -verbindingen worden gebruikt als een methode voor internettoegang op desktopapparaten. Als die aanname klopte, zouden weblettertypen en afbeeldingen zwaar in de cache kunnen worden opgeslagen, wat een positief effect heeft op CLS-metingen.

## <span lang="en">Core Web Vitals: First Input Delay</span> {core-web-vitals-first-input-delay}

<span lang="en">First Input Delay</span> (FID) meet de tijd tussen de eerste gebruikersinteractie en wanneer de browser in staat is om op die interactie te reageren. FID is een goede indicator van hoe interactief uw websites zijn.

### FID per apparaat

{{ figure_markup(
  image="performance-fid-by-device.png",
  caption="Geaggregeerde FID-prestaties opgesplitst per apparaattype.",
  description="Staafdiagram met hoge percentages goede FID-prestaties op desktop (100%) en mobiel (80%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2090682651&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

Het is relatief ongebruikelijk om goede scores te zien verdeeld over zo'n hoog percentage websites. Op desktop, gebaseerd op het 75e percentiel van de distributies van sites, rapporteert 100% van de sites snelle timing voor FID, wat betekent dat het aantal mensen dat vertragingen in de interactie ervaart erg laag is.

Op mobiele apparaten wordt 80% van de sites als goed beoordeeld. Een waarschijnlijke verklaring zijn de verminderde CPU-mogelijkheden in vergelijking met desktop, netwerklatentie op mobiel (wat een vertraging in het downloaden en uitvoeren van scripts veroorzaakt), evenals batterij-efficiëntie en temperatuurbeperkingen, waardoor het CPU-potentieel van mobiele apparaten wordt beperkt. Die allemaal rechtstreeks van invloed zijn op interactiviteitsstatistieken zoals FID.

### FID op geografische locatie

{{ figure_markup(
  image="performance-fid-by-geo.png",
  caption="Geaggregeerde FID-prestaties opgesplitst per land.",
  description="Staafdiagram met uitstekende FID-prestaties per land. De top 28 landen rapporteren tussen 79% en 97% goede FID-ervaringen met bijna tot geen slechte ervaringen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1107653062&format=interactive",
  width="645",
  height="792",
  sheets_gid="2120295762",
  sql_file="web_vitals_by_country.sql"
  )
}}

De geografische spreiding van de FID-score bevestigt de bevindingen in de eerder gedeelde apparaatgrafiek. In het slechtste geval heeft 79% van de websites een goede FID, met een indrukwekkende 97% op de eerste plaats, met de Republiek Korea opnieuw voorop. Interessant is dat sommige topkandidaten uit de CLS- en LCP-ranglijst, zoals Tsjechië, Polen, Oekraïne en de Russische Federatie, hier onderaan de hiërarchie vallen.

Nogmaals, we kunnen speculeren waarom dat zo is, maar we hebben verdere analyse nodig om echt zeker te zijn. Ervan uitgaande dat FID correleert met JavaScript-uitvoeringsmogelijkheden, kunnen landen waar meer capabele apparaten duurder zijn en als luxeartikelen worden behandeld, een lagere FID-ranking rapporteren. Polen is een goed voorbeeld - met een van de <a hreflang="en" href="https://qz.com/1106603/where-the-iphone-x-is-cheapest-and-most-expensive-in-dollars-pounds-en-yuan/">hoogste iPhone-prijzen</a> vergeleken met de Amerikaanse markt, gecombineerd met [relatief lagere lonen](https://en.wikipedia.org/wiki/List_of_European_countries_by_average_wage#Net_average_monthly_salary), is een enkel salaris niet voldoende om het vlaggenschipproduct van Apple te kopen. Daarentegen stellen Australiërs met <a hreflang="en" href="https://www.news.com.au/finance/average-australian-salary-how-much-you-have-to-earn-to-be-better-off-than-most/news-story/6fcdde092e87872b9957d2ab8eda1cbd">gemiddelde salarissen</a> zich in staat om een iPhone te kopen met een loon van een week. Gelukkig is het percentage websites met een lage beoordeling meestal 0, met een paar uitzonderingen van 1-2% lezingen, wat wijst op een relatief snelle reactie op de interactie.

### FID per verbindingstype

{{ figure_markup(
  image="performance-fid-by-connection-type.png",
  caption="Geaggregeerde FID-prestaties opgesplitst per type verbinding.",
  description="Staafdiagram met een consistent hoge verdeling van goede FID-prestaties over verschillende soorten netwerken. Offline, 3G en 4G leiden met meer dan 80% goed beoordeelde website-ervaringen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=808962538&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

We kunnen een directe correlatie waarnemen tussen netwerksnelheid en snelle FID, variërend van 73% op 2G tot 87% op 4G-netwerken. Snellere netwerken zullen helpen bij het sneller downloaden van scripts, waardoor het begin van het parseren wordt versneld en minder taken de hoofdthread blokkeren. Het is optimistisch om dergelijke resultaten te zien, vooral wanneer het percentage slecht beoordeelde site-ervaringen niet hoger is dan 5%.

## <span lang="en">First Contentful Paint</span> {first-contentful-paint}

<span lang="en">First Contentful Paint</span> (FCP) meet de eerste keer dat de browser tekst, afbeeldingen, niet-wit canvas of SVG-inhoud weergeeft. FCP is een goede indicator van de waargenomen snelheid omdat het laat zien hoe lang mensen wachten om de eerste tekenen van het laden van een site te zien.

### FCP per apparaat

{{ figure_markup(
  image="performance-fcp-desktop-distribution.png",
  caption="Distributie van websites met het label snelle, gemiddelde en trage FCP-prestaties op desktop.",
  description="Distributie van websites met het label snelle, gemiddelde en trage FCP-prestaties op desktop. De distributie van snelle websites lijkt lineair met een bult in het midden. Er zijn meer snelle en langzame FCP-ervaringen vergeleken met 2019, terwijl het aantal gemiddelde ervaringen afneemt door veranderingen in de FCP-categorisering.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1953305743&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

{{ figure_markup(
  image="performance-fcp-mobile-distribution.png",
  caption="Distributie van websites met het label snelle, gemiddelde en trage FCP-prestaties op mobiel.",
  description="Distributie van websites met het label snelle, gemiddelde en trage FCP-prestaties op desktop. De distributie van snelle websites lijkt lineair en er wordt minder bolling waargenomen op de desktopgrafiek. Er zijn meer snelle en langzame FCP-ervaringen vergeleken met 2019, terwijl het aantal gemiddelde ervaringen afneemt door veranderingen in de FCP-categorisering.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=38297781&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

In de bovenstaande grafieken zijn de FCP-distributies uitgesplitst naar desktop en mobiel. [Vergeleken met vorig jaar](../2019/performance#fcp-by-device), zijn er merkbaar minder gemiddelde FCP-metingen, terwijl het percentage snelle en langzame gebruikerservaringen is gestegen, ongeacht het type apparaat. We kunnen nog steeds dezelfde trend waarnemen, waarbij mobiele gebruikers vaker tragere FCP zullen ervaren dan desktopgebruikers. Over het algemeen hebben gebruikers meer kans op een goede of slechte ervaring dan op een middelmatige ervaring.

{{ figure_markup(
  image="performance-fcp-mobile-year-on-year.png",
  caption="Een vergelijking van de distributie van websites die zijn gelabeld als goed, behoeft verbetering en slechte mobiele prestaties van FCP tussen 2019 en 2020.",
  description="Staafdiagram dat laat zien hoe de verdeling van goed, behoeft verbetering en slecht mobiel FCP is veranderd tussen 2019 en 2020. In 2020 heeft 75% van de websites een ondermaats FCP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2037503700&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

Als we FCP op mobiele apparaten op jaarbasis vergelijken, zien we minder goede ervaringen en meer gematigde en slechte ervaringen. 75% van de websites heeft een ondermaatse FCP. We kunnen speculeren dat dit hoge percentage van minder dan ideale FCP-metingen een bron van frustratie en verminderde gebruikerservaring is.

Talrijke factoren kunnen verven vertragen, zoals serverlatentie (gemeten aan de hand van een handvol metrische gegevens, zoals [<span Lang="en">Time to First Byte</span> (TTFB)](#time-to-first-byte) en RTT), het blokkeren van JavaScript-verzoeken of ongepaste behandeling van aangepaste lettertypen om er maar een paar te noemen.<!-- markdownlint-disable-line MD051 -->

### FCP op geografische locatie

{{ figure_markup(
  image="performance-fcp-by-geo.png",
  caption="Geaggregeerde FCP-prestaties uitgesplitst per land.",
  description="Staafdiagram waaruit blijkt dat slechts 7 van de 28 landen meer dan 40% websites hebben met goede FCP-prestaties. Het aantal goede en slechte resultaten stijgt ten opzichte van 2019 door veranderingen in waardebereiken voor FCP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=78259488&format=interactive",
  sheets_gid="1708427314",
  width="645",
  height="792",
  sql_file="web_vitals_by_country.sql"
  )
}}

Voordat we ingaan op de analyse, is het opmerkelijk om te vermelden dat in het hoofdstuk Prestaties 2019 de drempels voor de classificatie 'goed' en 'slecht' verschilden van 2020. In 2019 werden sites met een FCP onder 1 s als goed beschouwd, terwijl die met FCP boven 3 s als slecht werden gecategoriseerd. In 2020 zijn die bereiken verschoven naar 1,5 s voor goed en 2,5 s voor slecht.

Deze wijziging betekent dat de distributie zou verschuiven naar meer ‘goed’ en ‘slecht’ beoordeelde websites. We kunnen die trend waarnemen in vergelijking met [resultaten van vorig jaar](../2019/performance#fcp-by-geography), aangezien het percentage goede en slechte websites stijgt. De top tien van regio's met het hoogste percentage snelle websites blijven relatief ongewijzigd ten opzichte van 2019, met de toevoeging van Tsjechië en België en de val van de Verenigde Staten en het Verenigd Koninkrijk. De Republiek Korea leidt met 62% van de websites die een snelle FCP rapporteren, bijna een verdubbeling sinds vorig jaar (wat waarschijnlijk opnieuw te wijten is aan hercategorisering van de resultaten). Andere landen die bovenaan de ranglijst staan, verdubbelen ook het aantal goede ervaringen.

Terwijl het middelmatige percentage ("moet worden verbeterd") kleiner wordt, stijgt het aantal slecht presterende FCP-sites, wat vooral duidelijk is aan de onderkant van de ranglijst met Latijns-Amerikaanse en Zuid-Aziatische regio's.

Nogmaals, er zijn verschillende redenen die FCP negatief beïnvloeden, zoals slechte TTFB-waarden, maar het is moeilijk om ze te bewijzen zonder de nodige context. Als we bijvoorbeeld de prestaties van specifieke landen zouden analyseren, zoals Australië, vinden we deze verrassend genoeg aan de onderkant. Australië heeft een van de hoogste penetratieniveaus voor smartphones ter wereld, een van de snelste mobiele netwerken en een relatief hoog gemiddeld inkomen. We zouden gemakkelijk aannemen dat het hoger zou moeten zijn. Rekening houdend met trage vaste verbindingen, latentie en gebrek aan iOS-vertegenwoordiging in CrUX, begint de positionering ervan logischer te worden. Met een voorbeeld als dit (alleen aan de oppervlakte aangeraakt), kunnen we zien hoe moeilijk het is om de context voor elk van de landen te begrijpen.

### FCP per verbindingstype

{{ figure_markup(
  image="performance-fcp-by-connection-type.png",
  caption="Geaggregeerde FCP-prestaties opgesplitst per verbindingstype.",
  description="Staafdiagram waaruit blijkt dat slechts 31% van de websites goede FCP op 4G rapporteert. Offline daalt dat aantal tot 10%, terwijl de resterende verbindingstypen bijna uitsluitend slechte FCP-ervaringen bieden.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1949864731&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

Net als bij andere statistieken wordt FCP beïnvloed door verbindingssnelheden. Op 3G scoort slechts 2% van de ervaringen goed, terwijl op 4G 31%. Het is geen ideale staat van FCP-prestaties, maar het [is verbeterd sinds 2019](../2019/performance#fcp-by-effectieve-verbindingstype) op sommige gebieden, wat opnieuw kan worden veroorzaakt door de verandering in categorisering van goede en slechte categorisering. We zien dezelfde stijging in het percentage goede websites en slechte websites, waardoor het aantal matige ("moet worden verbeterd") site-ervaringen worden verkleind.

Deze trend illustreert de groeiende digitale kloof, waarbij ervaringen op langzamere netwerken en mogelijk minder capabele apparaten consequent slechter zijn. Het verbeteren van FCP op langzame verbindingen hangt direct samen met het verbeteren van TTFB, wat we zien in [Geaggregeerde TTFB-prestaties per diagram met verbindingstypes](#ttfb-per-verbindingstype) - slecht TTFB = slecht FCP.

De keuze van <a hreflang="en" href="https://ismyhostfastyet.com/">hostingprovider</a> of <a hreflang="en" href="https://www.cdnperf.com/">CDN</a> zal een trapsgewijs effect hebben op de snelheid. Het nemen van deze beslissingen op basis van de snelst mogelijke levering zal helpen bij het verbeteren van FCP en TTFB, vooral op langzamere netwerken. FCP wordt ook aanzienlijk beïnvloed door de laadtijd van lettertypen, dus <a hreflang="en" href="https://web.dev/font-display/">ervoor zorgen dat tekst zichtbaar is terwijl weblettertypen worden gedownload</a> is ook een waardevolle strategie (vooral waar bij langzamere verbindingen deze bronnen kostbaar zijn om te halen).

Als we naar de "offline" statistieken kijken, kunnen we afleiden dat een aanzienlijk aantal FCP-problemen ook _niet_ gecorreleerd zijn met het netwerktype. We zien geen significante winsten in deze categorie, wat we wel zouden als die bewering waar was. Het lijkt erop dat de weergave niet zozeer wordt vertraagd door het ophalen van JavaScript, maar wordt beïnvloed door het parseren en uitvoeren.

## <span lang="en">Time to First Byte</span> {time-to-first-byte}

<span lang="en">Time to First Byte</span> (TTFB) is de tijd die nodig is vanaf het initiële HTML-verzoek totdat de eerste byte terugkomt in de browser. Problemen met het snel verwerken van verzoeken kunnen snel overlopen in andere prestatiestatistieken, omdat ze niet alleen verven maar ook het ophalen van bronnen vertragen.

### TTFB per apparaat

{{ figure_markup(
  image="performance-ttfb-by-device.png",
  caption="Geaggregeerde TTFB-prestaties opgesplitst per apparaattype.",
  description="Staafdiagram waaruit blijkt dat 76% van de websites een slechte TTFB heeft op desktop en 83% op mobiel. Het aantal websites met een goede TTFB is niet hoger dan 24%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1981576071&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

Op desktop heeft 76% van de websites een "niet goede" TTFB, terwijl dat percentage op mobiel stijgt tot 83%. We zouden kunnen aannemen dat de gegevens laten zien hoe TTFB vaak een over het hoofd gezien gegeven statistiek is wanneer wordt aangenomen dat de meeste prestatiemetingen en werk geconcentreerd zijn in front-end en visuele weergave, niet in levering van activa en server-side werk. Een hoge TTFB zal een directe, negatieve impact hebben op een overvloed aan andere prestatiesignalen, een gebied dat nog moet worden aangepakt.

### TTFB op geografische locatie

{{ figure_markup(
  image="performance-ttfb-by-geo.png",
  caption="Geaggregeerde TTFB-prestaties uitgesplitst per land.",
  description="Staafdiagram dat aantoont dat de TTFB-prestaties consistent ondermaats zijn, met slechts 4 van de 28 landen met meer dan 30% websites met goede TTFB. Er is een aanzienlijk aantal websites dat gecategoriseerd moet worden als verbetering behoeft (altijd meer dan 40%), waarbij het aantal slechte ervaringen stijgt naarmate de ranking lager is.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1135415956&format=interactive",
  width="645",
  height="792",
  sheets_gid="1440255644",
  sql_file="web_vitals_by_country.sql"
  )
}}

De TTFB-geo-uitlezingen van dit jaar vergelijken met [resultaten 2019] (../2019/performance#ttfb-by-geo) wijst opnieuw op snellere websites, maar net als bij FCP zijn de drempels veranderd.Eerder beschouwden we TTFB onder 200 ms snel en boven 1000 ms langzaam. In 2020 is TTFB onder 500 ms goed en boven 1500 ms slecht. Dergelijke genereuze veranderingen in categorisering kunnen verklaren dat we significante veranderingen waarnemen, zoals een stijging van 36% in goede website-ervaringen in de Republiek Korea of 22% stijging in Taiwan. Over het algemeen zien we nog steeds vergelijkbare regio's, zoals Azië-Pacific en geselecteerde Europese landen die toonaangevend zijn.

### TTFB per verbindingstype

{{ figure_markup(
  image="performance-ttfb-by-connection-type.png",
  caption="Geaggregeerde TTFB-prestaties opgesplitst per verbindingstype.",
  description="Staafdiagram dat laat zien dat TTFB sterk wordt beïnvloed door het verbindingstype met respectievelijk slechts 21% en 22% goede ervaringen op 4G en offline. Andere verbindingstypen bieden bijna geen (met uitzondering van 1% op 3G) goede TTFB-waarden.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=810992122&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

TTFB wordt beïnvloed door netwerklatentie en verbindingstype. Hoe hoger de latentie en hoe langzamer de verbinding, hoe slechter de TTFB-metingen, zoals we hierboven kunnen zien. Zelfs op mobiele verbindingen die als snel worden beschouwd (4G), heeft slechts 21% van de websites een snelle TTFB. Er zijn bijna geen sites die zijn gecategoriseerd als snel onder de 4G-snelheden.

Kijkend naar de <a hreflang="en" href="https://www.speedtest.net/insights/blog/content/images/2020/02/Ookla_Mobile-Speeds-Poster_2020.png">mobiele snelheden wereldwijd voor december 2018-november 2019</a>, kunnen we zien dat wereldwijd mobiele verbindingen niet supersnel zijn. Die netwerksnelheden en technologiestandaarden voor mobiele netwerken (zoals 5G) zijn niet gelijkmatig verdeeld en beïnvloeden TTFB. Zie als voorbeeld <a hreflang="en" href="https://www.mobilecoveragemaps.com/map_ng#7/8.744/7.670">deze kaart met netwerken in Nigeria</a> - het grootste deel van het land heeft 2G- en 3G-dekking, met weinig 4G-bereik.

Wat verrassend is, is het relatief evenveel goede TTFB-resultaat tussen offline en 4G-bronnen. Met Service Workers konden we verwachten dat sommige van de TTFB-problemen zouden worden beperkt, maar die trend wordt niet weerspiegeld in de bovenstaande grafiek.

## <span lang="en">Performance Observer</span> gebruik {performance-observer-gebruik}

Er zijn tientallen verschillende gebruikersgerichte statistieken die kunnen worden gebruikt om websites en applicaties te beoordelen. Soms passen de vooraf gedefinieerde statistieken echter niet helemaal bij onze specifieke scenario's en behoeften. Met de [PerformanceObserver API](https://developer.mozilla.org/docs/Web/API/PerformanceObserver) kunnen we aangepaste metrische gegevens verkrijgen die zijn verkregen met [User Timing API](https://developer.mozilla.org/docs/Web/API/User_Timing_API), [Long Task API](https://developer.mozilla.org/docs/Web/API/Long_Tasks_API), <a hreflang="en" href="https://web.dev/custom-metrics/#event-timing-api">Event Timing API</a> en <a hreflang="en" href="https://web.dev/custom-metrics/">een handvol andere low-level API's</a>. Met hun hulp kunnen we bijvoorbeeld de timingovergangen tussen pagina's vastleggen of de hydratatie van de server-side-rendered (SSR) -toepassing kwantificeren.

{{ figure_markup(
  image="performance-performance-observer-usage.png",
  caption="Performance Observer-gebruik per apparaattype.",
  description="Staafdiagram dat laat zien dat de acceptatie van Performance Observer API laag is, met 6,6% op desktop en 7% op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=632678090&format=interactive",
  sheets_gid="934401790",
  sql_file="performance_observer.sql"
  )
}}

De bovenstaande grafiek laat zien dat Performance Observer wordt gebruikt door 6-7% van de gevolgde sites, afhankelijk van het apparaattype. Die websites zullen de low-level API's gebruiken om aangepaste metrische gegevens te maken, en de Performance Observer API om ze te verzamelen, en deze vervolgens mogelijk gebruiken met andere prestatierapportagetools. Dergelijke acceptatiegraden kunnen wijzen op de neiging om te leunen op vooraf gedefinieerde statistieken (bijvoorbeeld afkomstig van Lighthouse), maar zijn ook indrukwekkend voor een relatief niche-API.

## Gevolgtrekking

Gebruikerservaring is niet alleen een spectrum, maar hangt ook af van een groot aantal factoren. Om te proberen de staat van prestaties te begrijpen zonder de ondermaatse, kansarme ervaringen uit te sluiten, moeten we deze intersectie benaderen. Elk websitebezoek vertelt een verhaal. Onze sociaaleconomische status op persoonlijk en landelijk niveau bepaalt het type apparaat en internetprovider dat we ons kunnen veroorloven. De plaats van waar we wonen beïnvloedt de latentie (wij Australiërs voelen deze pijn regelmatig), en de economie dicteert de beschikbare dekking van het mobiele netwerk. Welke websites bezoeken we? Waar bezoeken we ze voor? Context is van cruciaal belang om niet alleen gegevens te analyseren, maar ook om de nodige empathie en zorg te ontwikkelen bij het bouwen van toegankelijke, snelle ervaringen voor iedereen.

Oppervlakkig gezien hebben we optimistische signalen gezien over de nieuwe prestatiestatistieken van Core Web Vitals. Minstens de helft van de ervaringen is goed voor zowel desktop- als mobiele apparaten, _als_ we niet beperken tot consistent slechte ervaringen op langzamere netwerken voor Largest Contentful Paint. Hoewel de nieuwere statistieken kunnen suggereren dat er een voortdurende toename is van het aanpakken van prestatieproblemen, is het gebrek aan significante verbeteringen in First Contentful Paint en Time to First Byte ontnuchterend. Hier zijn dezelfde netwerktypen het meest benadeeld als bij Largest Contentful Paint, evenals snelle verbindingen en desktopapparaten. De prestatiescore geeft ook een afname in snelheid weer (of misschien een nauwkeuriger weergave dan wat we in het verleden hebben gemeten).

Wat de gegevens ons laten zien, is dat we moeten blijven investeren in het verbeteren van de prestaties voor scenario's (zoals langzamere connectiviteit) die we vaak niet ervaren vanwege meerdere aspecten van ons voorrecht (landen met middelhoge tot hoge inkomens, hoge lonen en nieuwe, geschikte apparaten). Het benadrukt ook dat er nog veel werk aan de winkel is op het gebied van het versnellen van de eerste verf (LCP en FCP) en levering van activa (TTFB). Prestaties voelen vaak aan als een inherent front-end-probleem, terwijl tal van significante verbeteringen kunnen worden bereikt aan de achterkant en door de juiste infrastructuurkeuzes. Nogmaals, gebruikerservaring is een spectrum dat afhangt van een verscheidenheid aan factoren, en we moeten het holistisch behandelen.

Nieuwe statistieken brengen nieuwe lenzen om de gebruikerservaring te analyseren, maar we mogen bestaande signalen niet vergeten. Laten we ons concentreren op het verplaatsen van de naald in de gebieden die de meeste verbetering behoeven, wat zal resulteren in positieve verschuivingen in ervaring voor de meest onderbedienden. Snel en toegankelijk internet is een mensenrecht.
