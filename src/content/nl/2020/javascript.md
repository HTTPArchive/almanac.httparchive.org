---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: JavaScript-hoofdstuk van de Web Almanac 2020 waarin wordt beschreven hoeveel JavaScript we gebruiken op het web, compressie, bibliotheken en frameworks, laden en bronkaarten.
authors: [tkadlec]
reviewers: [ibnesayeed, denar90]
analysts: [rviscomi, paulcalvano]
editors: [rviscomi]
translators: [noah-vdv]
tkadlec_bio: Tim is een webprestatieadviseur en trainer gericht op het bouwen van een web dat iedereen kan gebruiken. Hij is de auteur van High Performance Images (O'Reilly, 2016) en Implementing Responsive Design (New Riders, 2012). Hij schrijft over alles wat met internet te maken heeft op <a hreflang="en" href="https://timkadlec.com/">timkadlec.com</a>. U kunt hem vinden op Twitter <a href="https://twitter.com/tkadlec">@tkadlec</a> waar hij zijn gedachten in een beknopter formaat deelt.
discuss: 2038
results: https://docs.google.com/spreadsheets/d/1cgXJrFH02SHPKDGD0AelaXAdB3UI7PIb5dlS0dxVtfY/
featured_quote: JavaScript heeft een lange weg afgelegd sinds zijn bescheiden oorsprong als de laatste van de drie web-hoekstenen, naast CSS en HTML. Tegenwoordig begint JavaScript een breed spectrum van de technische stack te infiltreren. Het is niet langer beperkt tot de cliëntzijde en het wordt een steeds populairdere keuze voor build-tools en server-side scripting. JavaScript sluipt ook zijn weg naar de CDN-laag dankzij edge computing-oplossingen.
featured_stat_1: 1,897ms
featured_stat_label_1: Mediane JS-hoofdthread-tijd op mobiel
featured_stat_2: 37,22%
featured_stat_label_2: Percentage ongebruikte JS op mobiel
featured_stat_3: 12,2%
featured_stat_label_3: Percentage scripts dat asynchroon is geladen
---

## Inleiding

JavaScript heeft een lange weg afgelegd sinds zijn bescheiden oorsprong als de laatste van de drie web-hoekstenen, naast CSS en HTML. Tegenwoordig begint JavaScript een breed spectrum van de technische stack te infiltreren. Het is niet langer beperkt tot de cliëntzijde en het wordt een steeds populairdere keuze voor <span lang="en">build-tools</span> en <span lang="en">server-side scripting</span>. JavaScript sluipt ook zijn weg naar de CDN-laag dankzij <span lang="en">edge computing</span>-oplossingen.

Ontwikkelaars houden van wat JavaScript. Volgens het hoofdstuk Opmaak is het `script` -element het [6e meest populaire HTML-element](./markup) dat in gebruik is (vóór elementen zoals `p` en `i`, naast talloze andere). We besteden er ongeveer 14 keer zoveel bytes aan als aan HTML, de bouwsteen van het web, en 6 keer zoveel bytes als CSS.

{{ figure_markup(
  image="../page-weight/bytes-distribution-content-type.png",
  caption="Mediane paginagewicht per inhoudstype.",
  description="Staafdiagram met het gemiddelde paginagewicht voor desktop- en mobiele pagina's in afbeeldingen, JS, CSS en HTML. De gemiddelde hoeveelheid bytes voor elk inhoudstype op mobiele pagina's zijn: 916 KB afbeeldingen, 411 KB JS, 62 KB CSS en 25 KB HTML. Desktoppagina's hebben doorgaans aanzienlijk zwaardere afbeeldingen (ongeveer 1000 KB) en iets grotere hoeveelheden JS (ongeveer 450 KB).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=1147150650&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1wG4u0LV5PT9aN-XB1hixSFtI8KIDARTOCX0sp7ZT3h0/#378779486",
  sql_file="../page-weight/bytes_per_type_2020.sql"
) }}

Maar niets is gratis, en dat geldt vooral voor JavaScript - al die code heeft een prijs. Laten we eens kijken hoeveel script we gebruiken, hoe we het gebruiken en wat de gevolgen zijn.

## Hoeveel JavaScript gebruiken we?

We zeiden dat de `script`-tag het 6e meest gebruikte HTML-element is. Laten we wat dieper graven om te zien hoeveel JavaScript dat eigenlijk is.

De gemiddelde site (het 50e percentiel) verzendt 444 KB JavaScript wanneer deze op een desktopapparaat wordt geladen, en iets minder (411 KB) naar een mobiel apparaat.

{{ figure_markup(
  image="bytes-2020.png",
  caption="Verdeling van het aantal geladen JavaScript-kilobytes per pagina.",
  description="Staafdiagram met de verdeling van JavaScript-bytes per pagina met ongeveer 10%. Desktoppagina's laden consequent meer JavaScript-bytes dan mobiele pagina's. Het 10e, 25e, 50e, 75e en 90e percentiel voor desktop zijn: 87 KB, 209 KB, 444 KB, 826 KB en 1.322 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=441749673&format=interactive",
  sheets_gid="2139688512",
  sql_file="bytes_2020.sql"
) }}

Het valt een beetje tegen dat er hier geen grotere kloof is. Hoewel het gevaarlijk is om te veel aannames te doen over netwerk- of verwerkingskracht op basis van of het gebruikte apparaat een telefoon of een desktop is (of ergens tussenin), is het vermeldenswaard dat [HTTP Archive mobiele tests](./methodology#webpagetest) worden gedaan door een Moto G4 en een 3G-netwerk te emuleren. Met andere woorden, als er werk werd verzet om zich aan te passen aan minder dan ideale omstandigheden door minder code door te geven, zouden deze tests dat moeten laten zien.

De trend lijkt ook in het voordeel te zijn van het gebruik van meer JavaScript, niet minder. In vergelijking met [de resultaten van vorig jaar](../2019/javascript#how-much-javascript-do-we-use), zien we bij de mediaan een toename van 13,4% in JavaScript zoals getest op een desktopapparaat, en een 14,4% toename van de hoeveelheid JavaScript die naar een mobiel apparaat wordt verzonden.

<figure>
  <table>
    <thead>
      <tr>
        <th>cliënt</th>
        <th>2019</th>
        <th>2020</th>
        <th>Verandering</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">391</td>
        <td class="numeric">444</td>
        <td class="numeric">13,4%</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">359</td>
        <td class="numeric">411</td>
        <td class="numeric">14,4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Jaar-op-jaar verandering in het mediaan aantal JavaScript-kilobytes per pagina.",
      sheets_gid="86213362",
      sql_file="bytes_2020.sql"
    ) }}
  </figcaption>
</figure>

Een deel van dit gewicht lijkt in ieder geval niet nodig te zijn. Als we kijken naar een uitsplitsing van hoeveel van dat JavaScript ongebruikt is bij het laden van een bepaalde pagina, zien we dat de mediaanpagina 152 KB ongebruikt JavaScript verzendt. Dat aantal springt naar 334 KB op het 75e percentiel en 567 KB op het 90e percentiel.

{{ figure_markup(
  image="unused-js-bytes-distribution.png",
  caption="Verdeling van de hoeveelheid verspilde JavaScript-bytes per mobiele pagina.",
  description="Staafdiagram met de verdeling van de hoeveelheid verspilde JavaScript-bytes per pagina. Van de 10, 25, 50, 75 en 90 percentielen gaat de distributie: 0, 57, 153, 335 en 568 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=773002950&format=interactive",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

Als onbewerkte cijfers, kunnen die al dan niet naar u uitspringen, afhankelijk van hoeveel u van prestatie houdt, maar als u ernaar kijkt als een percentage van het totale JavaScript dat op elke pagina wordt gebruikt, wordt het een beetje gemakkelijker om te zien hoeveel afval we sturen.

{{ figure_markup(
  caption="Percentage van de mediaan JavaScript-bytes van de mobiele pagina dat niet wordt gebruikt.",
  content="37.22%",
  classes="big-number",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

Die 153 KB komt overeen met ~ 37% van de totale scriptgrootte die we naar mobiele apparaten verzenden. Er is hier zeker ruimte voor verbetering.

### `module` en `nomodule`
Een van de mechanismen die we hebben om de hoeveelheid code die we naar beneden sturen mogelijk te verminderen, is om te profiteren van het <a hreflang="en" href="https://web.dev/serve-modern-code-to-modern-browsers/">`module` / `nomodule` patroon</a>. Met dit patroon maken we twee sets bundels: één bundel bedoeld voor moderne browsers en één bedoeld voor oudere browsers. De bundel bedoeld voor moderne browsers krijgt een `type=module` en de bundel bedoeld voor oudere browsers krijgt een `type=nomodule`.

Met deze benadering kunnen we kleinere bundels maken met moderne syntaxis die zijn geoptimaliseerd voor de browsers die dit ondersteunen, terwijl we voorwaardelijk geladen polyfills en verschillende syntaxis bieden aan de browsers die dat niet doen.

Ondersteuning voor `module` en `nomodule` wordt steeds breder, maar nog relatief nieuw. Als gevolg hiervan is de acceptatie nog steeds een beetje laag. Slechts 3,6% van de mobiele pagina's gebruikt ten minste één script met `type=module` en slechts 0,7% van de mobiele pagina's gebruikt ten minste één script met `type=nomodule` om oudere browsers te ondersteunen.

### Aantal aanvragen

Een andere manier om te kijken hoeveel JavaScript we gebruiken, is door te kijken hoeveel JavaScript-verzoeken er op elke pagina worden gedaan. Hoewel het verminderen van het aantal verzoeken van cruciaal belang was om goede prestaties te behouden met HTTP/1.1, is met HTTP/2 het tegenovergestelde het geval: JavaScript opsplitsen in <a hreflang="en" href="https://web.dev/granular-chunking-nextjs/">kleinere, individuele bestanden</a> is [doorgaans beter voor prestaties](../2019/http#impact-of-http2).

{{ figure_markup(
  image="requests-2020.png",
  caption="Verdeling van JavaScript-verzoeken per pagina.",
  description="Staafdiagram met de verdeling van JavaScript-verzoeken per pagina in 2020. De 10, 25, 50, 75 en 90 percentielen voor mobiele pagina's zijn: 4, 10, 19, 34 en 55. Desktoppagina's hebben meestal alleen 0 of 1 meer JavaScript-verzoeken per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=153746548&format=interactive",
  sheets_gid="1804671297",
  sql_file="requests_2020.sql"
) }}

Bij de mediaan doen pagina's 20 JavaScript-verzoeken. Dat is slechts een kleine stijging ten opzichte van vorig jaar, toen de mediaanpagina 19 JavaScript-verzoeken deed.

{{ figure_markup(
  image="requests-2019.png",
  caption="Verdeling van JavaScript-verzoeken per pagina in 2019.",
  description="Staafdiagram met de verdeling van JavaScript-verzoeken per pagina in 2019. De 10, 25, 50, 75 en 90 percentielen voor mobiele pagina's zijn: 4, 9, 18, 32 en 52. Vergelijkbaar met de resultaten van 2020, alleen desktoppagina's hebben meestal 0 of 1 meer verzoeken per pagina. Deze resultaten zijn iets lager dan de resultaten van 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=528431485&format=interactive",
  sheets_gid="1983394384",
  sql_file="requests_2019.sql"
) }}

## Waar komt het vandaan?

Een trend die waarschijnlijk bijdraagt aan de toename van JavaScript dat op onze pagina's wordt gebruikt, is het schijnbaar steeds groter wordende aantal scripts van derden dat aan pagina's wordt toegevoegd om te helpen met alles, van A/B-tests en analyses aan de cliëntzijde tot het weergeven van advertenties en omgaan met personalisatie.

Laten we daar een beetje op ingaan om te zien hoeveel script van derden we serveren.

Tot aan de mediaan gebruiken sites ongeveer hetzelfde aantal eerste partij scripts als scripts van derden. Bij de mediaan zijn 9 scripts per pagina eerste partij, vergeleken met 10 per pagina van derden. Vanaf daar wordt de kloof een beetje groter: hoe meer scripts een site in het totaal gebruikt, hoe waarschijnlijker het is dat de meerderheid van die scripts afkomstig is van externe bronnen.

{{ figure_markup(
  image="requests-by-3p-desktop.png",
  caption="Verdeling van het aantal JavaScript-verzoeken per host voor desktop.",
  description="Staafdiagram met de verdeling van JavaScript-verzoeken per host voor desktop. De 10, 25, 50, 75 en 90 percentielen voor eerste partij-verzoeken zijn: 2, 4, 9, 17 en 30 verzoeken per pagina. Het aantal verzoeken van derden per pagina is iets hoger in de bovenste percentielen met 1 tot 6 verzoeken.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1566679225&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

{{ figure_markup(
  image="requests-by-3p-mobile.png",
  caption="Verdeling van het aantal JavaScript-verzoeken per host voor mobiel.",
  description="Staafdiagram met de verdeling van JavaScript-verzoeken per host voor mobiel. De 10, 25, 50, 75 en 90 percentielen voor eerste partij-verzoeken zijn: 2, 4, 9, 17 en 30 verzoeken per pagina. Dit is hetzelfde als voor desktop. Het aantal verzoeken van derden per pagina is iets hoger in de bovenste percentielen met 1 tot 5 verzoeken, vergelijkbaar met desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1465647946&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

Hoewel het aantal JavaScript-verzoeken vergelijkbaar is bij de mediaan, wordt de werkelijke grootte van die scripts iets zwaarder gewogen (bedoelde woordspeling) ten opzichte van bronnen van derden. De gemiddelde site stuurt 267 KB JavaScript van derden naar desktopapparaten, vergeleken met 147 KB van eerste partijen. De situatie is vergelijkbaar op mobiele apparaten, waar de mediaan-site 255 KB aan scripts van derden verzendt, vergeleken met 134 KB aan eigen scripts.

{{ figure_markup(
  image="bytes-by-3p-desktop.png",
  caption="Verdeling van het aantal JavaScript-bytes per host voor desktop.",
  description="Staafdiagram met de verdeling van JavaScript-bytes per host voor desktop. De 10, 25, 50, 75 en 90 percentielen voor eerste partij bytes zijn: 21, 67, 147, 296 en 599 KB per pagina. Het aantal verzoeken van derden per pagina stijgt veel hoger in de bovenste percentielen tot 343 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1749995505&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

{{ figure_markup(
  image="bytes-by-3p-mobile.png",
  caption="Verdeling van het aantal JavaScript-bytes per host voor mobiel.",
  description="Staafdiagram met de verdeling van JavaScript-bytes per host voor mobiel. De 10, 25, 50, 75 en 90 percentielen voor first party bytes zijn: 18, 60, 134, 275 en 560 KB. Deze waarden zijn constant kleiner dan de desktopwaarden, maar slechts 10-30 KB. Net als bij desktops zijn de bytes van derden hoger dan die van de eerste partij, op mobiel is dit verschil niet zo groot, slechts tot 328 KB bij het 90e percentiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=231883913&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

## Hoe laden we ons JavaScript?

De manier waarop we JavaScript laden, heeft een aanzienlijke invloed op de algehele ervaring.

JavaScript is standaard _parser-blokkerend_. Met andere woorden, wanneer de browser een `script`-element ontdekt, moet hij het ontleden van de HTML pauzeren totdat het script is gedownload, ontleed en uitgevoerd. Het is een aanzienlijk knelpunt en een veelvoorkomende oorzaak van pagina's die traag worden weergegeven.

We kunnen beginnen met het compenseren van een deel van de kosten van het laden van JavaScript door scripts asynchroon te laden (met het `async`-attribuut), waardoor de HTML-parser alleen wordt gestopt tijdens de ontleed- en uitvoeringsfase en niet tijdens de downloadfase, of uitgesteld (met het `defer`-attribuut), wat de HTML-parser helemaal niet stopt. Beide attributen zijn alleen beschikbaar op externe scripts; inline scripts kunnen ze niet laten toepassen.

Op mobiele apparaten omvatten externe scripts 59,0% van alle gevonden scriptelementen.

<p class="note">
  Even terzijde: toen we het hadden over hoeveel JavaScript eerder op een pagina is geladen, hield dat totaal geen rekening met de grootte van deze inline scripts - omdat ze deel uitmaken van het HTML-document, worden ze meegeteld bij de opmaak-grootte . Dit betekent dat we nog meer script laden dat de cijfers laten zien.
</p>

{{ figure_markup(
  image="external-inline-mobile.png",
  caption="Verdeling van het aantal externe en inline scripts per mobiele pagina.",
  description="Cirkeldiagram laat zien dat 41,0% van de mobiele scripts inline is en 59,0% extern.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1326937127&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

Van die externe scripts wordt slechts 12,2% geladen met het `async`-attribuut en 6,0% ervan wordt geladen met het `defer`-attribuut.

{{ figure_markup(
  image="async-defer-mobile.png",
  caption="Verdeling van het aantal `async` en `defer`-scripts per mobiele pagina.",
  description="Cirkeldiagram dat laat zien dat 12,2% van de externe mobiele scripts `async` gebruikt, 6,0% gebruikt `defer` en 81,8% geen van beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=662584253&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

Gezien het feit dat `defer` ons de beste laadprestaties biedt (door ervoor te zorgen dat het downloaden van het script parallel met ander werk gebeurt, en de uitvoering wacht tot nadat de pagina kan worden weergegeven), hopen we dat dit percentage iets hoger ligt. In feite is die 6,0% lichtjes opgeblazen.

Toen het ondersteunen van IE8 en IE9 vaker voorkwam, was het relatief gebruikelijk om _allebei_ de `async`- en `defer`-attributen te gebruiken. Met beide attributen op hun plaats, zal elke browser die beide ondersteunt `async` gebruiken. IE8 en IE9, die `async` niet ondersteunen, vallen terug op `defer`.

Tegenwoordig is het patroon voor de overgrote meerderheid van de sites niet nodig en elk script dat met het patroon wordt geladen, zal de HTML-parser onderbreken wanneer deze moet worden uitgevoerd, in plaats van uit te stellen totdat de pagina is geladen. Het patroon wordt nog steeds verrassend vaak gebruikt, met 11,4% van de mobiele pagina's die ten minste één script met dat patroon weergeven. Met andere woorden, ten minste enkele van de 6% van de scripts die `defer` gebruiken, profiteren niet van de volledige voordelen van het `defer`-attribuut.

There is an encouraging story here, though.

Harry Roberts [tweette over het antipatroon op Twitter](https://twitter.com/csswizardry/status/1331721659498319873), wat ons ertoe aanzette om te kijken hoe vaak dit in het wild voorkwam. [Rick Viscomi controleerde wie de grootste boosdoeners waren](https://twitter.com/rick_viscomi/status/1331735748060524551), en het blijkt dat "stats.wp.com" de bron was van de meest voorkomende overtreders. @Kraft van Automattic antwoordde, en het patroon wordt nu [in de toekomst verwijderd](https://twitter.com/Kraft/status/1336772912414601224).

Een van de geweldige dingen aan de openheid van het web is hoe één observatie kan leiden tot betekenisvolle verandering en dat is precies wat hier gebeurde.

### Hulpbronnenhints

Een ander hulpmiddel dat we tot onze beschikking hebben om een deel van de netwerkkosten voor het laden van JavaScript te compenseren, zijn [hulpbronnenhints](./resource-hints), in het bijzonder `prefetch` en `preload`.

Met de `prefetch`-hint kunnen ontwikkelaars aangeven dat een bron zal worden gebruikt bij de volgende paginanavigatie, daarom moet de browser proberen om het te downloaden wanneer de browser niet actief is.

De `preload`-hint geeft aan dat een bron op de huidige pagina zal worden gebruikt en dat de browser deze meteen met een hogere prioriteit moet downloaden.

In totaal zien we 16,7% van de mobiele pagina's die ten minste één van de twee bronhints gebruiken om JavaScript proactiever te laden.

Daarvan is bijna al het gebruik afkomstig van `preload`. Terwijl 16,6% van de mobiele pagina's ten minste één `preload` hint gebruikt om JavaScript te laden, gebruikt slechts 0,4% van de mobiele pagina's ten minste één `prefetch`-hint.

Er is een risico, vooral bij `preload`, dat er te veel hints worden gebruikt en de effectiviteit ervan wordt verminderd, dus het is de moeite waard om naar de pagina's te kijken die deze hints gebruiken om te zien hoeveel ze gebruiken.

{{ figure_markup(
  image="prefetch-distribution.png",
  caption="Verdeling van het aantal `prefetch`-hints per pagina met eventuele `prefetch`-hints.",
  description="Staafdiagram met de verdeling van `prefetch`-hints per pagina met eventuele `prefetch`-hints. Het 10, 25 en 50e percentiel voor desktop- en mobiele pagina's is 1, 2 en 3 `prefetch`-hints per pagina. Bij het 75e percentiel voor desktoppagina's is dat 6 en 4 voor mobiel. Op het 90e percentiel gebruiken desktoppagina's 14 `prefetch`-hints per pagina en 12 voor mobiele pagina's.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1874381460&format=interactive",
  sheets_gid="1910228743",
  sql_file="resource-hints-preload-prefetch-distribution.sql"
) }}

{{ figure_markup(
  image="preload-distribution.png",
  caption="Verdeling van het aantal `preload`-hints per pagina met eventuele `preload`-hints.",
  description="Staafdiagram met de verdeling van `preload` hints per pagina met eventuele `preload` hints. 75% van de desktop- en mobiele pagina's die `preload`-hints gebruiken, gebruikt dit precies één keer. Het 90e percentiel is 5 `preload` hints per pagina voor desktop en 7 voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=320533828&format=interactive",
  sheets_gid="1910228743",
  sql_file="resource-hints-preload-prefetch-distribution.sql"
) }}

Bij de mediaan gebruiken pagina's die een `prefetch`-hint gebruiken om JavaScript te laden er drie, terwijl pagina's die een `preload`-hint gebruiken er slechts één gebruiken. De lange staart wordt een beetje interessanter, met 12 `prefetch`-hints gebruikt op het 90e percentiel en 7 `preload`-hints die ook op de 90e worden gebruikt. Voor meer informatie over hulpbronnenhints, bekijk het hoofdstuk [Hulpbronnenhints](./resource-hints) van dit jaar.

## Hoe serveren we JavaScript?

Zoals met elke op tekst gebaseerde bron op internet, kunnen we een aanzienlijk aantal bytes besparen door middel van minimalisatie en compressie. Dit zijn geen van beide nieuwe optimalisaties - ze bestaan al een tijdje - dus we zouden verwachten dat ze in meer gevallen worden toegepast dan niet.

Een van de audits in [Lighthouse](./methodology#lighthouse) controleert op niet-geminimaliseerd JavaScript en geeft een score (0,00 is de slechtste, 1,00 is de beste) op basis van de bevindingen.

{{ figure_markup(
  image="lighthouse-unminified-js.png",
  caption="Verdeling van niet-verkleinde JavaScript Lighthouse-auditscores per mobiele pagina.",
  description="Staafdiagram toont 0% van de mobiele pagina's die niet-verkleinde JavaScript krijgen Lighthouse-auditscores onder de 0,25, 4% van de pagina's met een score tussen 0,25 en 0,5, 10% van de pagina's tussen 0,5 en 0,75, 8% van de pagina's tussen 0,75 en 0,9 en 77% van de pagina's tussen 0.9 en 1.0.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=158284816&format=interactive",
  sheets_gid="362705605",
  sql_file="lighthouse_unminified_js.sql"
) }}

De bovenstaande grafiek laat zien dat de meeste geteste pagina's (77%) een score van 0,90 of hoger halen, wat betekent dat er maar weinig niet-verkleinde scripts worden gevonden.

In totaal is slechts 4,5% van de geregistreerde JavaScript-verzoeken niet geminimaliseerd.

Interessant is dat, hoewel we een beetje hebben gekozen voor verzoeken van derden, dit een gebied is waar scripts van derden het beter doen dan scripts van eersten. 82% van de gemiddelde niet-verkleinde JavaScript-bytes van een mobiele pagina is afkomstig van eigen code.

{{ figure_markup(
  image="lighthouse-unminified-js-by-3p.png",
  caption="Gemiddelde distributie van niet-verkleinde JavaScript-bytes per host.",
  description="Cirkeldiagram dat laat zien dat 17,7% van de niet-verkleinde JS-bytes scripts van derden zijn en 82,3% eigen scripts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=2073491355&format=interactive",
  sheets_gid="1169731612",
  sql_file="lighthouse_unminified_js_by_3p.sql"
) }}

### Compressie

Minificatie is een geweldige manier om de bestandsgrootte te helpen verkleinen, maar compressie is nog effectiever en daarom belangrijker: het levert vaker wel dan niet het grootste deel van de netwerkbesparingen op.

{{ figure_markup(
  image="compression-method-request.png",
  caption="Verdeling van het percentage JavaScript-verzoeken per compressiemethode.",
  description="Staafdiagram met de verdeling van het percentage JavaScript-verzoeken per compressiemethode. De waarden voor desktop en mobiel lijken erg op elkaar. 65% van de JavaScript-verzoeken gebruikt Gzip-compressie, 20% gebruikt br (Brotli), 15% gebruikt geen compressie, en lopen leeg, UTF-8, identiteit, en geen enkele lijkt 0% te hebben",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=263239275&format=interactive",
  sheets_gid="1270710983",
  sql_file="compression_method.sql"
) }}

Bij 85% van alle JavaScript-verzoeken is een bepaald niveau van netwerkcompressie toegepast. Gzip maakt het grootste deel daarvan uit, met 65% van de scripts waarop Gzip-compressie is toegepast, vergeleken met 20% voor Brotli (br). Hoewel het percentage van Brotli (dat effectiever is dan Gzip) laag is in vergelijking met de browserondersteuning, gaat het in de goede richting, met een stijging van 5 procentpunten in het afgelopen jaar.

Nogmaals, dit lijkt een gebied te zijn waar scripts van derden het eigenlijk beter doen dan eerste partij scripts. Als we de compressiemethoden uitsplitsen door eerste en derde partij, zien we dat 24% van de scripts van derden Brotli heeft toegepast, vergeleken met slechts 15% van de scripts van eersten.

{{ figure_markup(
  image="compression-method-3p.png",
  caption="Verdeling van het percentage mobiele JavaScript-verzoeken per compressiemethode en host.",
  description="Staafdiagram met de verdeling van het percentage mobiele JavaScript-verzoeken per compressiemethode en host. 66% en 64% van de JavaScript-verzoeken van eerste en derde partijen gebruiken Gzip. 15% van de eerste partij en 24% van de derden scriptverzoeken gebruikt Brotli. En 19% van de eerste partij scripts en 12% van de derden scripts hebben geen compressiemethode ingesteld.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1402692197&format=interactive",
  sheets_gid="564760060",
  sql_file="compression_method_by_3p.sql"
) }}

Scripts van derden worden ook het minst waarschijnlijk zonder enige compressie aangeboden: 12% van de scripts van derden heeft noch Gzip noch Brotli toegepast, vergeleken met 19% van de eerste partij scripts.

Het is de moeite waard om die scripts die _geen_ compressie hebben van naderbij te bekijken. Compressie wordt efficiënter in termen van besparingen naarmate het meer inhoud moet gebruiken. Met andere woorden, als het bestand klein is, wegen de kosten voor het comprimeren van het bestand soms niet op tegen de minuscule verkleining van de bestandsgrootte.

{{ figure_markup(
  caption="Percentage niet-gecomprimeerde JavaScript-verzoeken van derden onder 5 KB.",
  content="90,25%",
  classes="big-number",
  sheets_gid="347926930",
  sql_file="compression_none_by_bytes.sql"
) }}

Gelukkig is dat precies wat we zien, vooral in scripts van derden, waar 90% van de niet-gecomprimeerde scripts minder dan 5 KB groot is. Aan de andere kant is 49% van de niet-gecomprimeerde eerste partij scripts minder dan 5 KB en 37% van de ongecomprimeerde eerste partij scripts groter dan 10 KB. Dus hoewel we veel kleine niet-gecomprimeerde eerste partij scripts zien, zijn er nog steeds een flink aantal die baat zouden hebben bij enige compressie.

## Wat gebruiken we?

Omdat we steeds meer JavaScript hebben gebruikt om onze sites en applicaties van stroom te voorzien, is er ook een toenemende vraag naar open-source bibliotheken en frameworks om de productiviteit van ontwikkelaars en de algehele onderhoudbaarheid van de code te verbeteren. Sites die _niet_ een van deze hulpmiddelen gebruiken, zijn beslist de minderheid op het internet van vandaag - jQuery alleen is te vinden op bijna 85% van de mobiele pagina's die worden bijgehouden door HTTP Archive.

Het is belangrijk dat we kritisch nadenken over de hulpmidellen die we gebruiken om het web te bouwen en wat de afwegingen zijn, dus het is logisch om goed te kijken naar wat we vandaag in gebruik zien.

### Bibliotheken

HTTP Archive gebruikt [Wappalyzer](./methodology#wappalyzer) om technologieën te detecteren die op een bepaalde pagina worden gebruikt. Wappalazyer houdt zowel JavaScript-bibliotheken bij (zie deze als een verzameling fragmenten of helperfuncties om de ontwikkeling te vergemakkelijken, zoals jQuery) en JavaScript-frameworks (dit zijn waarschijnlijker steigers en bieden sjablonen en structuur, zoals React).

De populaire bibliotheken die in gebruik zijn, zijn grotendeels ongewijzigd ten opzichte van vorig jaar, waarbij jQuery het gebruik blijft domineren en slechts één van de 21 beste bibliotheken valt uit (lazy.js, vervangen door <span lang="en">DataTables</span>). Zelfs de percentages van de topbibliotheken zijn nauwelijks veranderd ten opzichte van vorig jaar.

{{ figure_markup(
  image="frameworks-libraries.png",
  caption="Overname van de beste JavaScript-frameworks en -bibliotheken als percentage van de pagina's.",
  description="Staafdiagram dat de acceptatie van de belangrijkste frameworks en bibliotheken weergeeft als percentage van de pagina's (niet paginaweergaven of npm-downloads). jQuery is de overweldigende leider, te vinden op 83% van de mobiele pagina's. Het wordt gevolgd door jQuery migrate op 30%, jQuery UI op 21%, Modernizr op 15%, FancyBox op 7%, Slick en Lightbox op 6%, en de resterende frameworks en bibliotheken op 4% of 3%: Moment.js, Underscore.js, Lodash, React, GSAP, Select2, RequireJS en prettyPhoto.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=419887153&format=interactive",
  sheets_gid="1654577118",
  sql_file="frameworks_libraries.sql"
) }}

Vorig jaar stelde [Houssein een paar redenen voor waarom de dominantie van jQuery voortduurt](../2019/javascript#open-source-libraries-and-frameworks):

> <span lang="en">WordPress</span>, dat op meer dan 30% van de sites wordt gebruikt, bevat standaard jQuery.
> Het overschakelen van jQuery naar een nieuwere cliëntzijde bibliotheek kan enige tijd duren, afhankelijk van hoe groot een applicatie is, en veel sites kunnen bestaan uit jQuery naast nieuwere cliëntzijde bibliotheken.

Beide zijn zeer goede gissingen, en het lijkt erop dat de situatie op geen van beide fronten veel is veranderd.

In feite wordt de dominantie van jQuery nog verder ondersteund als u bedenkt dat van de top 10 bibliotheken er 6 jQuery zijn of jQuery nodig hebben om te kunnen worden gebruikt: jQuery UI, jQuery <span lang="en">Migrate</span>, <span lang="en">FancyBox, Lightbox</span> en Slick .

### Frameworks

Als we naar de frameworks kijken, zien we ook niet veel van een dramatische verandering in termen van adoptie in de belangrijkste frameworks die vorig jaar naar voren kwamen. Vue.js heeft een aanzienlijke toename gezien en AMP is een beetje gegroeid, maar de meeste zijn min of meer waar ze een jaar geleden waren.

Het is vermeldenswaard dat het <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">detectieprobleem dat vorig jaar werd opgemerkt nog steeds van toepassing is</a>, en nog steeds van invloed is op de resultaten hier. Het is mogelijk dat er een aanzienlijke verandering in populariteit _is_ opgetreden voor nog een paar van deze hulpmddelen, maar we zien het gewoon niet met de manier waarop de gegevens momenteel worden verzameld.

### Wat het allemaal betekent

Interessanter voor ons dan de populariteit van de hulpmiddelen zelf is de impact die ze hebben op de dingen die we bouwen.

Ten eerste is het vermeldenswaard dat hoewel we misschien denken aan het gebruik van de ene hulpmiddel in plaats van de andere, we in werkelijkheid zelden slechts één enkele bibliotheek of framework gebruiken bij de productie. Slechts 21% van de geanalyseerde pagina's rapporteert slechts één bibliotheek of framework. Twee of drie frameworks komen vrij vaak voor, en de lange staart wordt erg lang, erg snel.

Als we kijken naar de veel voorkomende combinaties die we in de productie zien, zijn de meeste te verwachten. Gezien de dominantie van jQuery, is het niet verwonderlijk dat de meeste populaire combinaties jQuery en een willekeurig aantal jQuery-gerelateerde plug-ins bevatten.

<figure>
  <table>
    <thead>
      <tr>
        <th>Combinaties</th>
        <th>Pagina's</th>
        <th>(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">1.312.601</td>
        <td class="numeric">20,7%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery <span lang="en">Migrate</span></td>
        <td class="numeric">658.628</td>
        <td class="numeric">10,4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery UI</td>
        <td class="numeric">289.074</td>
        <td class="numeric">4,6%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery</td>
        <td class="numeric">155.082</td>
        <td class="numeric">2,4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery <span lang="en">Migrate</span>, jQuery UI</td>
        <td class="numeric">140.466</td>
        <td class="numeric">2,2%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery <span lang="en">Migrate</span></td>
        <td class="numeric">85.296</td>
        <td class="numeric">1,3%</td>
      </tr>
      <tr>
        <td><span lang="en">FancyBox</span>, jQuery</td>
        <td class="numeric">84.392</td>
        <td class="numeric">1,3%</td>
      </tr>
      <tr>
        <td>Slick, jQuery</td>
        <td class="numeric">72.591</td>
        <td class="numeric">1,1%</td>
      </tr>
      <tr>
        <td>GSAP, Lodash, React, <span lang="en">RequireJS</span>, Zepto</td>
        <td class="numeric">61.935</td>
        <td class="numeric">1,0%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery UI</td>
        <td class="numeric">61.152</td>
        <td class="numeric">1,0%</td>
      </tr>
      <tr>
        <td><span lang="en">Lightbox</span>, jQuery</td>
        <td class="numeric">60.395</td>
        <td class="numeric">1,0%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery <span lang="en">Migrate</span>, jQuery UI</td>
        <td class="numeric">53.924</td>
        <td class="numeric">0,8%</td>
      </tr>
      <tr>
        <td>Slick, jQuery, jQuery <span lang="en">Migrate</span></td>
        <td class="numeric">51.686</td>
        <td class="numeric">0,8%</td>
      </tr>
      <tr>
        <td><span lang="en">Lightbox</span>, jQuery, jQuery <span lang="en">Migrate</span></td>
        <td class="numeric">50.557</td>
        <td class="numeric">0,8%</td>
      </tr>
      <tr>
        <td><span lang="en">FancyBox</span>, jQuery, jQuery UI</td>
        <td class="numeric">44.193</td>
        <td class="numeric">0,7%</td>
      </tr>
      <tr>
        <td>Modernizr, YUI</td>
        <td class="numeric">42.489</td>
        <td class="numeric">0,7%</td>
      </tr>
      <tr>
        <td>React, jQuery</td>
        <td class="numeric">37.753</td>
        <td class="numeric">0,6%</td>
      </tr>
      <tr>
        <td>Moment.js, jQuery</td>
        <td class="numeric">32.793</td>
        <td class="numeric">0,5%</td>
      </tr>
      <tr>
        <td><span lang="en">FancyBox</span>, jQuery, jQuery <span lang="en">Migrate</span></td>
        <td class="numeric">31.259</td>
        <td class="numeric">0,5%</td>
      </tr>
      <tr>
        <td><span lang="en">MooTools</span>, jQuery, jQuery <span lang="en">Migrate</span></td>
        <td class="numeric">28.795</td>
        <td class="numeric">0,5%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>
    {{ figure_link(
      caption="De meest populaire combinaties van bibliotheken en frameworks op mobiele pagina's.",
      sheets_gid="795160444",
      sql_file="frameworks_libraries_combos.sql"
    ) }}
  </figcaption>
</figure>

We zien ook een behoorlijk aantal meer "moderne" frameworks zoals React, Vue en Angular in combinatie met jQuery, bijvoorbeeld als gevolg van migratie of opname door derden.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Combinatie</th>
        <th scope="col">Zonder jQuery</th>
        <th scope="col">Met jQuery</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>GSAP, Lodash, React, <span lang="en">RequireJS</span>, Zepto</td>
        <td class="numeric">1,0%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>React, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0,6%</td>
      </tr>
      <tr>
        <td>React</td>
        <td class="numeric">0,4%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>React, jQuery, jQuery <span lang="en">Migrate</span></td>
        <td>&nbsp;</td>
        <td class="numeric">0,4%</td>
      </tr>
      <tr>
        <td>Vue.js, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0,3%</td>
      </tr>
      <tr>
        <td>Vue.js</td>
        <td class="numeric">0,2%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>AngularJS, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0,2%</td>
      </tr>
      <tr>
        <td>GSAP, Hammer.js, Lodash, React, <span lang="en">RequireJS</span>, Zepto</td>
        <td class="numeric">0,2%</td>
        <td>&nbsp;</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">Eindtotaal</th>
        <th scope="col" class="numeric">1,7%</th>
        <th scope="col" class="numeric">1,4%</th>
      </tr>
    </tfoot>
  </table>
  <figcaption>
    {{ figure_link(
      caption="De meest populaire combinaties van React, Angular en Vue met en zonder jQuery.",
      sheets_gid="795160444",
      sql_file="frameworks_libraries_combos.sql"
    ) }}
  </figcaption>
</figure>

Wat nog belangrijker is, al deze hulpmiddelen betekenen doorgaans meer code en meer verwerkingstijd.

Als we specifiek naar de gebruikte frameworks kijken, zien we dat de mediaan JavaScript-bytes voor pagina's die deze gebruiken, enorm variëren, afhankelijk van _wat_ wordt gebruikt.

De onderstaande grafiek toont de mediaan bytes voor pagina's waar een van de top 35 meest gedetecteerde frameworks is gevonden, uitgesplitst naar cliënt.

{{ figure_markup(
  image="frameworks-bytes.png",
  caption="Het gemiddelde aantal JavaScript-kilobytes per pagina door JavaScript-framework.",
  description="Staafdiagram met het gemiddelde aantal JavaScript-kilobytes per pagina, uitgesplitst en gesorteerd op populariteit van het JavaScript-framework. Het meest populaire framework, React, heeft een mediaan van 1.328 JS op mobiele pagina's. Andere frameworks zoals RequireJS en Angular hebben een hoog aantal mediane JS-bytes per pagina. Pagina's met MooTools, Prototype, AMP, RightJS, Alpine.js en Svelte hebben medianen van minder dan 500 KB per mobiele pagina. Ember.js heeft een uitbijter van ongeveer 1.800 KB mediane JS per mobiele pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=955720480&format=interactive",
  sheets_gid="1206934500",
  width="600",
  height="835",
  sql_file="frameworks-bytes-by-framework.sql"
) }}

Op één van de spectrums staan frameworks zoals React of Angular of Ember, die de neiging hebben om veel code te verzenden, ongeacht de cliënt. Aan de andere kant zien we minimalistische frameworks zoals Alpine.js en Svelte veelbelovende resultaten laten zien. Standaarden zijn erg belangrijk, en het lijkt erop dat Svelte en Alpine er allebei in slagen (tot dusver&hellip; is de steekproefomvang vrij klein) om een lichtere set pagina's te creëren door te beginnen met zeer performante standaarden.

We krijgen een vergelijkbaar beeld als we kijken naar de hoofdthread-tijd voor pagina's waarop deze hulpmiddelen zijn gedetecteerd.

{{ figure_markup(
  image="frameworks-main-thread.png",
  caption="De mediane hoofdthread-tijd per pagina door JavaScript-framework.",
  description="Staafdiagram met de mediane hoofdthread-tijd per framework. Het is moeilijk om iets anders op te merken dan Ember.js, waarvan de mediane mobiele hoofdthread-tijd meer dan 20.000 milliseconden (20 seconden) is. De rest van de frameworks zijn in vergelijking klein.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=691531699&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Ember's mobiele hoofdthread-tijd springt eruit en vervormt de grafiek enigszins met hoe lang het duurt. (Ik heb hier wat meer tijd aan besteed en het lijkt sterk beïnvloed te worden <a hreflang="en" href="https://timkadlec.com/remembers/2021-01-26-what-about-ember/">door een bepaald platform dat dit framework inefficiënt gebruikt</a>, in plaats van een onderliggend probleem met Ember zelf). Door het eruit te trekken, wordt de afbeelding een beetje gemakkelijker te begrijpen.

{{ figure_markup(
  image="frameworks-main-thread-no-ember.png",
  caption="De mediane hoofdthread-tijd per pagina door JavaScript-framework, met uitzondering van Ember.js.",
  description="Staafdiagram met de mediane hoofdthread-tijd per framework, exclusief Ember.js. De mobiele hoofdthread-tijden zijn allemaal hoger vanwege de testmethodologie van het gebruik van langzamere CPU-snelheden voor mobiel. De meest populaire frameworks zoals React, GSAP en RequireJS hebben hoge threads van ongeveer 2-3 seconden voor desktop en 5-7 seconden voor mobiel. Polymer valt ook verderop op de populariteitslijst op. MooToos, Prototype, Alpine.js en Svelte hebben meestal lagere hoofdthread-tijden, minder dan 2 seconden.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=77448759&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Hulpmiddelen zoals React, GSAP en RequireJS besteden vaak veel tijd aan de hoofdthread van de browser, ongeacht of het een desktop- of mobiele paginaweergave is. Dezelfde hulpmiddelen die in het algemeen tot minder code leiden - hulpmiddelen zoals Alpine en Svelte - hebben ook de neiging om de impact op de hoofdthread te verkleinen.

De kloof tussen de ervaring die een framework biedt voor desktop en mobiel, is ook de moeite waard om in te graven. Mobiel verkeer wordt steeds dominanter en het is van cruciaal belang dat onze hulpmiddelen zo goed mogelijk presteren voor mobiele paginaweergaven. Hoe groter de kloof die we zien tussen desktop- en mobiele prestaties voor een framework, hoe groter de rode vlag.

{{ figure_markup(
  image="frameworks-main-thread-no-ember-diff.png",
  caption="Verschil tussen de mediaan van de hoofdthread-tijd voor desktop en mobiel per pagina volgens JavaScript-framework, met uitzondering van Ember.js.",
  description="Staafdiagram met de absolute en relatieve verschillen tussen de mediaan van de hoofdthread-tijd op desktop en mobiel per pagina volgens JavaScript-framework, met uitzondering van Ember.js. Polymer springt later in de populariteitslijst naar voren met een groot verschil: ongeveer 5 seconden en 250% langzamere mediane hoofdthread-tijd op mobiele pagina's dan op desktoppagina's. Andere frameworks die opvallen zijn GSAP en RequireJS heeft een verschil van 4 seconden of 150%. frameworks met het laagste verschil zijn Mustache en RxJS, die slechts ongeveer 20-30% langzamer zijn op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1758266664&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Zoals u zou verwachten, is er een gat voor alle gebruikte hulpmiddelen vanwege de lagere verwerkingskracht van de [geëmuleerde Moto G4](methodology#webpagetest). Ember en Polymer lijken eruit te springen als bijzonder flagrante voorbeelden, terwijl hulpmiddelen zoals RxJS en Mustache slechts in geringe mate variëren van desktop tot mobiel.

## Wat is de impact?

We hebben nu een redelijk goed beeld van hoeveel JavaScript we gebruiken, waar het vandaan komt en waarvoor we het gebruiken. Hoewel dat op zichzelf al interessant genoeg is, is de echte kicker de "<span lang="en">so what</span>?" Welke impact heeft al dit script eigenlijk op de beleving van onze pagina's?

Het eerste dat we moeten overwegen, is wat er gebeurt met al dat JavaScript nadat het is gedownload. Downloaden is slechts het eerste deel van de JavaScript-reis. De browser moet nog steeds al dat script ontleden, compileren en uiteindelijk uitvoeren. Hoewel browsers constant op zoek zijn naar manieren om een deel van die kosten over te dragen aan andere threads, gebeurt veel van dat werk nog steeds op de hoofdthread, waardoor de browser wordt geblokkeerd om lay-out- of verfgerelateerd werk te doen, en ook om te kunnen reageren op gebruikersinteractie.

Als u zich herinnert, was er slechts een verschil van 30 KB tussen wat naar een mobiel apparaat wordt verzonden en een desktopapparaat. Afhankelijk van uw standpunt, zou het u kunnen worden vergeven dat u niet al te boos bent over het kleine verschil in de hoeveelheid code die naar een desktopbrowser wordt verzonden versus een mobiele browser - wat is tenslotte ongeveer 30 KB extra bij de mediaan?

Het grootste probleem ontstaat wanneer al die code wordt geserveerd op een <span lang="en">low-to-middle-end</span> apparaat, iets minder dan het soort apparaten dat de meeste ontwikkelaars waarschijnlijk hebben, en een beetje meer het soort apparaten dat u zult zien van de meerderheid van de mensen over de hele wereld. Die relatief kleine kloof tussen desktop en mobiel is veel dramatischer als we ernaar kijken in termen van verwerkingstijd.

De gemiddelde desktopsite besteedt 891 ms aan de hoofdthread van een browser die met al dat JavaScript werkt. De gemiddelde mobiele site besteedt echter 1897 ms, meer dan twee keer de tijd die op de desktop wordt doorgebracht. Het is zelfs nog erger voor de lange staart van sites. Op het 90e percentiel besteden mobiele sites maar liefst 8.921 ms aan hoofdthread-tijd aan JavaScript, vergeleken met 3.838 ms voor desktopsites.

{{ figure_markup(
  image="main-thread-time.png",
  caption="Verdeling van de hoofdthread-tijd.",
  description="Staafdiagram met de verdeling van de hoofdthread-tijd voor desktop en mobiel. Mobiel is 2-3 keer hoger tijdens de distributie. De 10, 25, 50, 75 en 90 percentielen voor desktop zijn: 137, 356, 891, 1.988 en 3.838 milliseconden.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=740020507&format=interactive",
  sheets_gid="2039579122",
  sql_file="main_thread_time.sql"
) }}

### Het correleren van JavaScript-gebruik met Lighthouse-scores

Een manier om te zien hoe dit zich vertaalt in het beïnvloeden van de gebruikerservaring, is door te proberen een aantal JavaScript-statistieken die we eerder hebben geïdentificeerd te correleren met Lighthouse-scores voor verschillende statistieken en categorieën.

{{ figure_markup(
  image="correlations.png",
  caption="Correlaties van JavaScript op verschillende aspecten van gebruikerservaring.",
  description='Staafdiagram met de Pearson-correlatiecoëfficiënt voor verschillende aspecten van gebruikerservaring. De correlatie van bytes met de prestatiescore van Lighthouse heeft een correlatiecoëfficiënt van -0,47. Bytes en Lighthouse toegankelijkheidsscore: 0,08. Bytes en <span lang="en">Total Blocking Time</span> (TBT): 0,55. Bytes van derden en prestatiescore van Lighthouse: -0,37. Bytes van derden en de toegankelijkheidsscore van Lighthouse: 0,00. Bytes van derden en TBT: 0,48. Het aantal asynchrone scripts per pagina en de prestatiescore van Lighthouse: -0,19. Asynchrone scripts en Lighthouse toegankelijkheidsscore: 0,08. Asynchrone scripts en TBT: 0,36.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=649523941&format=interactive",
  sheets_gid="2035770638",
  sql_file="correlations.sql"
) }}

De bovenstaande grafiek gebruikt de [Pearson correlatiecoëfficiënt](https://nl.wikipedia.org/wiki/Correlatieco%C3%ABffici%C3%ABnt). Er is een lange, nogal complexe definitie van wat dat precies betekent, maar de kern is dat we zoeken naar de sterkte van de correlatie tussen twee verschillende getallen. Als we een coëfficiënt van 1,00 vinden, hebben we een directe positieve correlatie. Een correlatie van 0,00 zou geen verband tussen twee getallen aantonen. Alles onder de 0,00 duidt op een negatieve correlatie - met andere woorden, als het ene getal stijgt, neemt het andere af.

Ten eerste lijkt er niet echt een meetbare correlatie te bestaan tussen onze JavaScript-statistieken en de Lighthouse-score voor toegankelijkheid ("LH A11y" in de grafiek) hier. Dat staat in schril contrast met wat elders is gevonden, met name via <a hreflang="en" href="https://webaim.org/projects/million/#frameworks">het jaarlijkse onderzoek van WebAim</a>.

De meest waarschijnlijke verklaring hiervoor is dat de toegankelijkheidstests van Lighthouse (nog!) Niet zo uitgebreid zijn als wat beschikbaar is via andere hulpmiddelen, zoals WebAIM, die toegankelijkheid als hun primaire focus hebben.

Waar we wel een sterke correlatie zien, is tussen het aantal JavaScript-bytes ("Bytes") en zowel de algehele prestatie van Lighthouse ("LH Perf") score als de <span lang="en">Total Blocking Time</span> ("TBT").

De correlatie tussen JavaScript-bytes en de prestatiescores van Lighthouse is -0,47. Met andere woorden, naarmate JS-bytes toenemen, nemen de prestatiescores van Lighthouse af. De totale bytes hebben een sterkere correlatie dan het aantal bytes van derden ("3P bytes"), wat erop duidt dat hoewel ze zeker een rol spelen, we niet alle schuld bij derden kunnen leggen.

Het verband tussen de totale blokkeringstijd en JavaScript-bytes is zelfs nog belangrijker (0,55 voor totale bytes, 0,48 voor bytes van derden). Dat is niet zo verwonderlijk, gezien wat we weten over al het werk dat browsers moeten doen om JavaScript op een pagina te laten werken - meer bytes betekent meer tijd.

### Beveiligingskwetsbaarheden

Een andere nuttige audit die Lighthouse uitvoert, is om te controleren op bekende beveiligingsproblemen in bibliotheken van derden. Het doet dit door te detecteren welke bibliotheken en frameworks op een bepaalde pagina worden gebruikt en welke versie van elk wordt gebruikt. Vervolgens controleert het <a hreflang="en" href="https://snyk.io/vuln?type=npm">Snyk's open-source kwetsbaarheidsdatabase</a> om te zien welke kwetsbaarheden zijn ontdekt in de geïdentificeerde hulpmiddelen.

{{ figure_markup(
  caption="Het percentage mobiele pagina's bevat ten minste één kwetsbare JavaScript-bibliotheek.",
  content="83,50%",
  classes="big-number",
  sheets_gid="1326928130",
  sql_file="lighthouse_vulnerabilities.sql"
) }}

Volgens de audit gebruikt 83,5% van de mobiele pagina's een JavaScript-bibliotheek of -framework met minstens één bekende beveiligingslek.

Dit is wat we het jQuery-effect noemen. Weet u nog hoe we zagen dat jQuery op maar liefst 83% van de pagina's wordt gebruikt? Verschillende oudere versies van jQuery bevatten bekende kwetsbaarheden, die de overgrote meerderheid van de kwetsbaarheden omvatten die deze audit controleert.

Van de ongeveer 5 miljoen mobiele pagina's waartegen wordt getest, bevat 81% een kwetsbare versie van jQuery - een aanzienlijke voorsprong op de tweede meest gevonden kwetsbare bibliotheek - jQuery UI met 15,6%.

<figure>
  <table>
    <thead>
      <tr>
        <th>Bibliotheek</th>
        <th>Kwetsbare pagina's</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">80,86%</td>
      </tr>
      <tr>
        <td>jQuery UI</td>
        <td class="numeric">15,61%</td>
      </tr>
      <tr>
        <td><span lang="en">Bootstrap</span></td>
        <td class="numeric">13,19%</td>
      </tr>
      <tr>
        <td>Lodash</td>
        <td class="numeric">4,90%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">2,61%</td>
      </tr>
      <tr>
        <td><span lang="en">Handlebars</span></td>
        <td class="numeric">1,38%</td>
      </tr>
      <tr>
        <td>AngularJS</td>
        <td class="numeric">1,26%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0,77%</td>
      </tr>
      <tr>
        <td>Dojo</td>
        <td class="numeric">0,58%</td>
      </tr>
      <tr>
        <td>jQuery <span lang="en">Mobile</span></td>
        <td class="numeric">0,53%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top 10 bibliotheken die volgens Lighthouse bijdragen aan het hoogste aantal kwetsbare mobiele pagina's.",
      sheets_gid="1803013938",
      sql_file="lighthouse_vulnerable_libraries.sql"
    ) }}
  </figcaption>
</figure>

Met andere woorden, als we mensen zover kunnen krijgen om weg te migreren van die verouderde, kwetsbare versies van jQuery, zouden we het aantal sites met bekende kwetsbaarheden zien dalen (tenminste, totdat we er enkele in de nieuwere frameworks beginnen te vinden).

Het merendeel van de gevonden kwetsbaarheden valt in de categorie "gemiddeld".

{{ figure_markup(
  image="vulnerabilities-by-severity.png",
  caption="Verdeling van het percentage mobiele pagina's met JavaScript-kwetsbaarheden naar ernst.",
  description="Cirkeldiagram toont 13,7% van de mobiele pagina's zonder JavaScript-kwetsbaarheden, 0,7% met zwakke kwetsbaarheden, 69,1% met middelmatige ernst en 16,4% met zeer ernstige kwetsbaarheden.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1932740277&format=interactive",
  sheets_gid="1409147642",
  sql_file="lighthouse_vulnerabilities_by_severity.sql"
) }}

## Gevolgtrekking

JavaScript wordt gestaag populair, en daar is veel positiefs over. Het is ongelooflijk om te bedenken wat we dankzij JavaScript op het internet van vandaag kunnen bereiken, dat zelfs een paar jaar geleden onvoorstelbaar zou zijn geweest.

Maar het is duidelijk dat we ook voorzichtig moeten zijn. De hoeveelheid JavaScript stijgt elk jaar consequent (als de aandelenmarkt zo voorspelbaar was, zouden we allemaal ongelooflijk rijk zijn), en dat komt met afwegingen. Meer JavaScript is verbonden met een toename van de verwerkingstijd, wat een negatief effect heeft op belangrijke statistieken zoals de totale blokkeringstijd. En als we die bibliotheken laten wegkwijnen zonder ze actueel te houden, lopen ze het risico gebruikers bloot te stellen aan bekende beveiligingsproblemen.

Een zorgvuldige afweging van de kosten van de scripts die we aan onze pagina's toevoegen en bereid zijn om onze hulpmiddelen kritisch in de gaten te houden en er meer van te vragen, zijn onze beste weddenschappen om ervoor te zorgen dat we een web bouwen dat toegankelijk, performant en veilig is.
