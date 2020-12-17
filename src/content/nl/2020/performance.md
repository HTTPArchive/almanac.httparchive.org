---
part_number: II
chapter_number: 9
title: Prestatie
description: Prestatiehoofdstuk van de Web Almanac 2020 met betrekking tot <i lang="en">Core Web Vitals, Lighthouse Performance Score, First Contentful Paint (FCP)</i> en <i lang="en">Time to First Byte</i> (TTFB).
authors: [thefoxis]
reviewers: [borisschapira, rviscomi, obto, noamr, Zizzamia, exterkamp]
analysts: [max-ostapenko, dooman87]
translators: [noah-vdv]
thefoxis_bio: Karolina is Product Design Lead bij <a href="https://calibreapp.com/">Calibre</a> en werkt aan het creëren van het meest uitgebreide platform voor snelheidscontrole. Ze beheert de <a href="https://perf.email/" lang="en">Performance Newsletter</a>, uw bron van nieuws over prestaties en bronnen. Karolina <a href="https://calibreapp.com/blog/category/web-platform">schrijft ook regelmatig</a> over hoe prestaties de gebruikerservaring beïnvloeden.
discuss: 2045
results: https://docs.google.com/spreadsheets/d/164FVuCQ7gPhTWUXJl1av5_hBxjncNi0TK8RnNseNPJQ/
queries: 09_Performance
featured_quote: Slechte prestaties veroorzaken niet alleen frustratie of hebben een negatieve invloed op de conversie, het creëert ook echte toetredingsdrempels. De wereldwijde pandemie van dit jaar heeft die bestaande barrières nog duidelijker gemaakt.
featured_stat_1: 25%
featured_stat_label_1: Sites met een goede FCP op mobiel
featured_stat_2: 18%
featured_stat_label_2: Sites met een goede TTFB op mobiel
featured_stat_3: 4%
featured_stat_label_3: Sites met ongewijzigde Prestatiescore in LH6
---

## Introductie

Er is een onbetwistbaar nadelig effect dat lage snelheid heeft op de algehele gebruikerservaring en bijgevolg op conversies. Maar slechte prestaties veroorzaken niet alleen frustratie of hebben een negatieve invloed op de bedrijfsdoelen, het creëert ook echte toetredingsdrempels. De wereldwijde pandemie van dit jaar [maakte die bestaande barrières nog duidelijker](https://www.weforum.org/agenda/2020/04/coronavirus-covid-19-pandemic-digital-divide-internet-data-broadband-mobbile/). Met de verschuiving naar leren op afstand, werken en socializen, werd plotseling ons hele leven online verplaatst. Slechte connectiviteit en gebrek aan toegang tot geschikte apparaten maakten deze verandering op zijn best pijnlijk, zo niet onmogelijk, voor velen. Het is een echte test geweest, waarbij connectiviteit, apparaat- en snelheidsverschillen over de hele wereld naar voren zijn gekomen.

Prestatiehulpmiddelen blijven evolueren om die diverse aspecten van de gebruikerservaring weer te geven en het gemakkelijker maken om onderliggende problemen te vinden. Sinds [het hoofdstuk Prestaties van vorig jaar](../2019/performance) zijn er tal van belangrijke ontwikkelingen geweest in de ruimte die de manier waarop we snelheidsmonitoring benaderen al hebben veranderd.

Met een belangrijke release van de populaire hulpmiddel voor kwaliteitscontrole, Lighthouse 6, [het algoritme achter de beroemde Prestatiescore is aanzienlijk veranderd](https://calibreapp.com/blog/how-performance-score-works), en dat gold ook voor de scores. [Core Web Vitals](https://calibreapp.com/blog/core-web-vitals), een reeks nieuwe statistieken die verschillende aspecten van gebruikerservaring weergeven, is vrijgegeven. Het zal een van de factoren zijn voor het rangschikken van zoekresultaten in de toekomst, waardoor de ogen van de ontwikkelingsgemeenschap op de nieuwe snelheidssignalen worden gericht.

In dit hoofdstuk kijken we naar echte wereld prestatiegegevens die worden geleverd door het [Chrome User Experience Report (CrUX)](https://developers.google.com/web/tools/chrome-user-experience-report) via de lens van die nieuwe ontwikkelingen en het analyseren van een handvol andere relevante statistieken. Het is belangrijk op te merken dat als gevolg van de beperkingen van iOS, de mobiele resultaten van CrUX geen apparaten met het mobiele besturingssysteem van Apple omvatten. Dit feit zal onmiskenbaar van invloed zijn op onze analyse, vooral wanneer we de metrische prestaties per land onderzoeken.

Laten we erin duiken.

## Prestatiescore van Lighthouse

In mei 2020 werd [Lighthouse 6 uitgebracht](https://github.com/GoogleChrome/lighthouse/releases/tag/v6.0.0). De nieuwe hoofdversie van de populaire prestatie-auditing-suite introduceerde opmerkelijke wijzigingen in het Prestatiescore-algoritme. De Prestatiescore is een weergave op hoog niveau van de sitesnelheid. In Lighthouse 6 wordt de score gemeten met zes - niet vijf - statistieken: <i lang="en">First Meaningful Paint</i> en <i lang ="en">First CPU Idle</i> zijn verwijderd en vervangen door <i lang="en">Largest Contentful Paint (LCP), Total Blocking Time</i> (TBT, het labequivalent van First Input Delay) en <i lang="en">Cumulative Layout Shift</i> (CLS).

Het nieuwe scoringsalgoritme geeft prioriteit aan de nieuwe generatie prestatiestatistieken: <i lang="en">Core Web Vitals</i> en deprioritering van <i lang="en">First Contentful Paint (FCP), Time to Interactive (TTI)</i> en Speed Index, naarmate hun score afneemt. Het algoritme legt nu ook duidelijk de nadruk op drie aspecten van gebruikerservaring: *interactiviteit* (totale blokkeringstijd en tijd tot interactief), *visuele stabiliteit* (cumulatieve verschuiving van lay-out) en *waargenomen belasting* (First Contentful Paint, Speed Index, Largest Contentful Paint).

Bovendien wordt de score nu berekend met behulp van verschillende referentiepunten voor desktop en mobiel. Wat dit in de praktijk betekent, is dat het minder vergevingsgezind zal zijn op desktop (verwacht snelle websites) en meer ontspannen op mobiel (aangezien benchmarkprestaties op mobiel minder snel zijn dan desktop). U kunt het verschil in score van Lighthouse 5 en 6 vergelijken in [de Lighthouse Score rekenmachine](https://googlechrome.github.io/lighthouse/scorecalc/). Dus, hoe veranderden de scores echt?

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

## Core Web Vitals: Largest Contentful Paint

Largest Contentful Paint (LCP) is een op timing gebaseerde statistiek van een mijlpaal die de tijd rapporteert waarop het grootste [boven-de-vouw-element](https://web.dev/lcp/#what-elements-are-considered) was weergegeven.

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

Het hoogste percentage goede LCP-metingen wordt voornamelijk verspreid onder Europese en Aziatische landen, waarbij de Republiek Korea (Zuid-Korea) voorop staat met 76% van goede metrische metingen. Zuid-Korea is een constante leider op het gebied van mobiele snelheden, met een indrukwekkende download van 145 Mbps [gerapporteerd door Speedtest Global Index](https://www.speedtest.net/global-index) voor oktober. Japan, Tsjechië, Taiwan, Duitsland en België zijn ook een handvol landen met betrouwbaar hoge mobiele snelheden. Australië is toonaangevend op het gebied van mobiele netwerksnelheden, maar wordt in de steek gelaten door langzame desktopverbindingen en latentie, waardoor het onderaan in de bovenstaande ranglijst staat.

India blijft de laatste in onze reeks gegevens, met slechts 16% goede ervaringen. Hoewel de populatie van mensen die voor het eerst verbinding maken met internet voortdurend toeneemt, zijn de snelheden van mobiele en desktopnetwerken [nog steeds een probleem](https://www.opensignal.com/reports/2020/04/india/mobile-netwerkervaring), met gemiddelde downloads van 10 Mbps voor 4G, 3 Mbps voor 3G en minder dan 50 Mbps voor desktop.

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

Er is een duidelijke correlatie tussen netwerksnelheid en betere LCP-prestaties, maar zelfs op 4G wordt slechts 48% van de resultaten als goed gecategoriseerd, waardoor de helft van de metingen moet worden verbeterd. Het automatiseren van media-optimalisatie, het bedienen van de juiste afmetingen en formaten, en het optimaliseren voor Low Data Mode, zou kunnen helpen om de naald te verplaatsen. Lees meer over [LCP optimaliseren in deze gids](https://web.dev/optimize-lcp/).

## Core Web Vitals: Cumulative Layout Shift

Cumulative Layout Shift (CLS) kwantificeert hoeveel elementen in de viewport tijdens het paginabezoek bewegen. Het helpt bij het vaststellen van de mate waarin onverwachte bewegingen plaatsvinden op uw websites om de gebruikerservaring te beoordelen, in plaats van te proberen een specifiek deel van de interactie te meten met behulp van een eenheid zoals seconden of milliseconden.

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

Visuele stabiliteit wordt minder beïnvloed door geografie en latentie voor andere statistieken, zoals LCP. Het verschil in percentage goede scores tussen het bovenste en onderste land is 61% voor LCP en slechts 13% voor CLS. Het percentage websites met matige beoordelingen is over de hele linie relatief laag en maakt plaats voor 19% -29% van de slechte ervaringen over de hele linie. Er zijn tal van factoren die kunnen bijdragen aan slechte CLS - leer hoe u ze aanpakt in de [Gids voor Cumulatieve Layoutverschuiving Optimaliseren](https://web.dev/optimize-cls/).

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

## Core Web Vitals: First Input Delay

First Input Delay (FID) meet de tijd tussen de eerste gebruikersinteractie en wanneer de browser in staat is om op die interactie te reageren. FID is een goede indicator van hoe interactief uw websites zijn.

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

Nogmaals, we kunnen speculeren waarom dat zo is, maar we hebben verdere analyse nodig om echt zeker te zijn. Ervan uitgaande dat FID correleert met JavaScript-uitvoeringsmogelijkheden, kunnen landen waar meer capabele apparaten duurder zijn en als luxeartikelen worden behandeld, een lagere FID-ranking rapporteren. Polen is een goed voorbeeld - met een van de [hoogste iPhone-prijzen](https://qz.com/1106603/where-the-iphone-x-is-cheapest-and-most-expensive-in-dollars-pounds-en-yuan/) vergeleken met de Amerikaanse markt, gecombineerd met [relatief lagere lonen](https://en.wikipedia.org/wiki/List_of_European_countries_by_average_wage#Net_average_monthly_salary), is een enkel salaris niet voldoende om het vlaggenschipproduct van Apple te kopen. Daarentegen stellen Australiërs met [gemiddelde salarissen](https://www.news.com.au/finance/average-australian-salary-how-much-you-have-to-earn-to-be-better-off-than-most/news-story/6fcdde092e87872b9957d2ab8eda1cbd) zich in staat om een iPhone te kopen met een loon van een week. Gelukkig is het percentage websites met een lage beoordeling meestal 0, met een paar uitzonderingen van 1-2% lezingen, wat wijst op een relatief snelle reactie op de interactie.

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

## First Contentful Paint

First Contentful Paint (FCP) meet de eerste keer dat de browser tekst, afbeeldingen, niet-wit canvas of SVG-inhoud weergeeft. FCP is een goede indicator van de waargenomen snelheid omdat het laat zien hoe lang mensen wachten om de eerste tekenen van het laden van een site te zien.

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

Talrijke factoren kunnen verven vertragen, zoals serverlatentie (gemeten aan de hand van een handvol metrische gegevens, zoals [Time to First Byte (TTFB)](#time-to-first-byte-ttfb) en RTT), het blokkeren van JavaScript-verzoeken of ongepaste behandeling van aangepaste lettertypen om er maar een paar te noemen.

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

Voordat we ingaan op de analyse, is het opmerkelijk om te vermelden dat in het hoofdstuk Prestaties 2019 de drempels voor de classificatie 'goed' en 'slecht' verschilden van 2020. In 2019 werden sites met een FCP onder 1s als goed beschouwd, terwijl die met FCP boven 3s als slecht werden gecategoriseerd. In 2020 zijn die bereiken verschoven naar 1,5s voor goed en 2,5s voor slecht.

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

Similarly to other metrics, FCP is affected by connection speeds. On 3G, only 2% of experiences rate good, while on 4G, 31%. It is not an ideal state of FCP performance, but it [has improved since 2019](../2019/performance#fcp-by-effective-connection-type) in some areas, which again might be driven by the change in categorization of good and poor categorization. We see the same rise in the percentage of good websites and poor websites, narrowing the number of moderate ("needs improvement") site experiences.

This trend illustrates the furthering digital divide, where experiences on slower networks and potentially less capable devices are consistently worse. Improving FCP on slow connections directly correlates to enhancing TTFB, which we observe in [Aggregate TTFB performance by connection type chart](#ttfb-by-connection-type)—poor TTFB = poor FCP.

The choice of [hosting provider](https://ismyhostfastyet.com/) or [CDN](https://www.cdnperf.com/) will have a cascading effect on speed. Making these decisions based on the fastest possible delivery will help in improving FCP and TTFB, especially on slower networks. FCP is also significantly affected by font load time, so [ensuring text is visible while web fonts are downloaded](https://web.dev/font-display/) is also a worthwhile strategy (especially where on slower connections these resources will be costly to fetch).

Looking at the "offline" statistics, we can deduce that a substantial number of FCP issues are also _not_ correlated to the network type. We don't observe significant gains in this category, which we would if that statement was true. It appears would seem rendering is not so much delayed by fetching JavaScript, but it is affected by parsing and execution.

## Time to First Byte

Time to First Byte (TTFB) is the time taken from the initial HTML request being made until the first byte arrives back to the browser. Issues with swiftly processing requests can quickly cascade into affecting other performance metrics as they will delay not only paints but also any resource fetching.

### TTFB by device

{{ figure_markup(
  image="performance-ttfb-by-device.png",
  caption="Aggregate TTFB performance split by device type.",
  description="Bar chart showcasing that 76% websites have poor TTFB on desktop and 83% on mobile. The number of websites with good TTFB doesn't exceed 24%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1981576071&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

On desktop, 76% of websites have a "not good" TTFB, while on mobile, that percentage rises to 83%. We might assume that the data portrays how TTFB is often an overlooked metric when it is assumed that most performance measurements and work is concentrated within front-end and visual rendering, not asset delivery and server-side work. High TTFB will have a direct, negative impact on a plethora of other performance signals, which is an area that still needs addressing.

### TTFB by geographic location

{{ figure_markup(
  image="performance-ttfb-by-geo.png",
  caption="Aggregate TTFB performance split by country.",
  description="Bar chart showcasing that TTFB performance is consistently sub-par, with only 4 out of 28 countries having more than 30% websites with good TTFB. There is a significant number of websites categorized as needs improvement (always above 40%) with the fraction of poor experiences rising as the ranking position is lower.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1135415956&format=interactive",
  width="645",
  height="792",
  sheets_gid="1440255644",
  sql_file="web_vitals_by_country.sql"
  )
}}

Likening this years' TTFB geo readings to [2019 results](../2019/performance#ttfb-by-geo) again points to more fast websites, but similarly to FCP, the thresholds have changed. Previously, we considered TTFB below 200ms fast, and above 1000ms slow. In 2020, TTFB below 500ms is good and above 1500ms poor. Such generous changes in categorization can explain that we observe significant changes, such as a 36% rise in good website experiences in The Republic of Korea or 22% rise in Taiwan. Overall, we still observe similar regions, such as Asia-Pacific and selected European locales leading.

### TTFB by connection type

{{ figure_markup(
  image="performance-ttfb-by-connection-type.png",
  caption="Aggregate TTFB performance split by connection type.",
  description="Bar chart showing that TTFB is heavily affected by connection type with only 21% and 22% of good experiences on 4G and offline, respectively. Other connection types provide nearly none (with the exception of 1% on 3G) good TTFB readings.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=810992122&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

TTFB is affected by network latency and connection type. The higher the latency and the slower the connection, the worse TTFB measurements, as we can observe above. Even on mobile connections considered as fast (4G), only 21% of websites have a fast TTFB. There are nearly no sites categorized as quick below 4G speeds.

Looking at the [mobile speeds worldwide for December 2018-November 2019](https://www.speedtest.net/insights/blog/content/images/2020/02/Ookla_Mobile-Speeds-Poster_2020.png), we can see that globally, mobile connections aren't high-speed. Those network speeds and technology standards for cellular networks (such as 5G) are not evenly distributed and affect TTFB. As an example, [see this map of networks in Nigeria](https://www.mobilecoveragemaps.com/map_ng#7/8.744/7.670)—most of the country area has 2G and 3G coverage, with little 4G range.

What's surprising is the relatively the same number of good TTFB results between offline and 4G origins. With service workers, we could expect some of the TTFB issues to be mitigated, but that trend is not reflected in the chart above.

## Performance Observer usage

There are dozens of different user-centric metrics that can be used to assess websites and applications. However, sometimes the predefined metrics don't quite fit our specific scenarios and needs. The [PerformanceObserver API](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceObserver) allows us to obtain custom metric data obtained with [User Timing API](https://developer.mozilla.org/en-US/docs/Web/API/User_Timing_API), [Long Task API](https://developer.mozilla.org/en-US/docs/Web/API/Long_Tasks_API), [Event Timing API](https://web.dev/custom-metrics/#event-timing-api) and [a handful of other low-level APIs](https://web.dev/custom-metrics/). For example, with their help, we could record the timing transitions between pages or quantify server-side-rendered (SSR) application hydration.

{{ figure_markup(
  image="performance-performance-observer-usage.png",
  caption="Performance Observer usage by device type.",
  description="Bar chart showing that the adoption of Performance Observer API is low, at 6.6% on desktop and 7% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=632678090&format=interactive",
  sheets_gid="934401790",
  sql_file="performance_observer.sql"
  )
}}

The chart above showcases that Performance Observer is used by 6-7% of tracked sites, depending on device type. Those websites will be leveraging the low-level APIs to create custom metrics, and the PerformanceObserver API to collate them, and then potentially use it with other performance reporting tooling. Such adoption rates might indicate the tendency to lean on predefined metrics (for example, coming from Lighthouse), but also are impressive for a relatively niche API.

## Conclusion

User experience is not only a spectrum but also depends on a wide variety of factors. To attempt understanding the state of performance without excluding the sub-par, underprivileged experiences, we must approach it intersectionally. Each website visit tells a story. Our personal and country-level socioeconomic status dictates the type of device and internet provider we can afford. The geopositioning of where we live affects latency (we Australians feel this pain regularly), and the economy dictates available cellular network coverage. What websites do we visit? What do we visit them for? Context is critical to not only analyzing data but also developing necessary empathy and care in building accessible, fast experiences for all.

On the surface, we have seen optimistic signals about the new Core Web Vitals performance metrics. At least half of the experiences are good across both desktop and mobile devices, _if_ we don't narrow down to consistently poor experiences on slower networks for Largest Contentful Paint. While the newer metrics might suggest that there's an ongoing uptake in addressing performance issues, the lack of significant improvements in First Contentful Paint and Time to First Byte is sobering. Here the same network types are most disadvantaged as with Largest Contentful Paint, as well as fast connections and desktop devices. The Performance Score also portrays a decline in speed (or perhaps, a more accurate portrayal than what we measured in the past).

What the data shows us, is that we must keep investing in improving performance for scenarios (such as slower connectivity) that we often don't experience due to multiple aspects of our privilege (middle to high-income countries, high pay and new, capable devices). It also highlights that there's still plenty of work to be done in the areas of speeding up initial paints (LCP and FCP) and asset delivery (TTFB). Often, performance feels like an inherently front-end issue, while numerous significant improvements can be achieved on the back-end and through appropriate infrastructure choices. Again, user experience is a spectrum that depends on a variety of factors, and we need to treat it holistically.

New metrics bring new lenses to analyze user experience through, but we must not forget existing signals. Let's focus on moving the needle in the areas that need the most improvement and will result in positive shifts in experience for most underserved. Fast and accessible internet is a human right.
