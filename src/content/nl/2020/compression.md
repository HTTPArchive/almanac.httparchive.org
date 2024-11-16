---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Compressie
description: Het hoofdstuk over compressie van de Web Almanac van 2020 behandelt HTTP-compressie, algoritmen, inhoudstypen, compressie van de eerste partij en van derden en mogelijkheden.
hero_alt: Hero image of Web Almanac charactes using a ray gun to shrink an HTML page to make it much smaller.
authors: [mo271, veluca93, sboukortt, jyrkialakuijala]
reviewers: [paulcalvano]
analysts: [AbbyTsai]
editors: [exterkamp]
translators: [noah-vdv]
jyrkialakuijala_bio: Jyrki Alakuijala is een actief lid van de open source-softwaregemeenschap en onderzoeker naar datacompressie. Jyrki werkt bij Google als technisch leider/manager, en zijn recent gepubliceerde werk was met Zopfli, Butteraugli, Guetzli, Gipfeli, WebP lossless, Brotli en JPEG XL-compressie-indelingen en -algoritmen, en twee hashing-algoritmen, CityHash en HighwayHash. Voordat hij bij Google ging werken, ontwikkelde hij software voor de planning van neurochirurgie en bestralingstherapie.
sboukortt_bio: Sami kwam bij Google nadat hij zijn studie technische wiskunde had afgerond. Na een paar jaar verre interesse in compressie, maakte hij er uiteindelijk in 2018 zijn fulltime werkonderwerp van.
mo271_bio: Moritz Firsching is software-engineer bij Google Zwitserland, waar hij werkt aan progressieve afbeeldingsindelingen en lettertypecompressie. Daarvoor deed Moritz onderzoek als wiskundige die polytopen bestudeerde.
veluca93_bio: Luca Versari is een software-engineer bij Google en werkt aan <a hreflang="en" href="https://gitlab.com/wg1/jpeg-xl">JPEG XL</a>. Hij is bezig met het afronden van een doctoraat in grafiekcompressie en heeft een achtergrond in wiskunde.
discuss: 2055
results: https://docs.google.com/spreadsheets/d/1NKbP4AqMkgCNCsVD3yLhO2d0aqIsgZ7AGLEtUDHl9yY/
featured_quote: Door het gebruik van HTTP-compressie laadt een website sneller en is daardoor een betere gebruikerservaring gegarandeerd.
featured_stat_1: 23%
featured_stat_label_1: Gecomprimeerde reacties die Brotli gebruiken
featured_stat_2: 77%
featured_stat_label_2: Gecomprimeerde reacties die Gzip gebruiken
featured_stat_3: 74%
featured_stat_label_3: Websites die de Lighthouse-audit doorstaan met maximale score op tekstcompressie
---

## Inleiding

Door het gebruik van HTTP-compressie laadt een website sneller en is daardoor een betere gebruikerservaring gegarandeerd. Het niet uitvoeren van compressie op HTTP zorgt voor een slechtere gebruikerservaring, kan de groeisnelheid van de gerelateerde webservice beïnvloeden en heeft invloed op de zoekresultaten. Effectief gebruik van compressie kan [paginagewicht](./page-weight) verminderen, [webprestaties](./performance) verbeteren, en is daarom een belangrijk onderdeel van [zoekmachineoptimalisatie](./seo).

Hoewel compressie met verlies vaak acceptabel is voor afbeeldingen en andere typen [media](./media), willen we voor tekst compressie zonder verlies gebruiken, d.w.z. de exacte tekst herstellen na decompressie.

## Welk type inhoud moeten we comprimeren?

Voor de meeste op tekst gebaseerde items, zoals [HTML](./markup), [CSS](./css), [JavaScript](./javascript), JSON of SVG, evenals bepaalde niet-tekstindelingen zoals woff, ttf, ico, wordt het gebruik van compressie aanbevolen.

{{ figure_markup(
  image="compession-methods-by-content-type.png",
  caption="Compressiemethoden voor verschillende inhoudstypen",
  description="Een gestapeld staafdiagram met de gebruikssnelheid van verschillende compressiealgoritmen, uitgesplitst naar het inhoudstype. De gestapelde staven verdelen het gebruik van Brotli, Gzip en geen compressie. `text/html` is het enige inhoudstype dat minder dan 50% van de tijd wordt gecomprimeerd. `application/json` en `image/svg+xml` zijn elk ongeveer 64% gecomprimeerd. `text/css` en `application/javascript` zijn elk ongeveer 85% gecomprimeerd. `application/x-javascript` en `text/javascript` zijn voor meer dan 90% gecomprimeerd.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1658254159&format=interactive",
  sheets_gid="107138856",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

De afbeelding toont het percentage reacties van een bepaald inhoudstype met Brotli, Gzip of zonder tekstcompressie.
Het is verrassend dat hoewel al deze inhoudstypen zouden profiteren van compressie, het bereik van de percentages sterk varieert over de verschillende inhoudstypen: slechts 44% gebruikt compressie voor `text/html` tegen 93% voor `application/x-javascript`.

Voor op afbeeldingen gebaseerde middelen is op tekst gebaseerde compressie minder nuttig en wordt deze niet algemeen toegepast. Uit de gegevens blijkt dat het percentage afbeeldingsreacties dat Brotli of Gzip gebruikt, erg laag is, minder dan 4%. Voor meer informatie over niet op tekst gebaseerde middelen, bekijk het hoofdstuk [Media](./media).

{{ figure_markup(
  image="http-compression-methods-for-image-types.png",
  caption="Compressiemethoden voor afbeeldingstypen op desktop.",
  description="Dit geeft aan welke compressiemethoden, indien van toepassing, worden gebruikt voor alle inhoudstypen die afbeeldingen zijn. Voor alle drie de afbeeldingstypen, d.w.z. jpeg, png en gif, wordt ongeveer 96,5% gebruikt, er wordt geen compressie gebruikt.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1287110333&format=interactive",
  sheets_gid="449339162",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

## Hoe gebruikt u HTTP-compressie?

Om de grootte van de bestanden die we willen aanbieden te verkleinen, kan men eerst enkele minimizers gebruiken, bijv. <a hreflang="en" href="https://github.com/kangax/html-minifier">HTMLMinifier</a>, <a hreflang="en" href="https://github.com/ben-eb/cssnano">CSSNano</a> of <a hreflang="en" href="https://github.com/mishoo/UglifyJS2">UglifyJS</a>. Er worden echter grotere voordelen verwacht van het gebruik van compressie.

Er zijn twee manieren om de compressie aan de serverzijde uit te voeren:

  - Voorgecomprimeerd (middelen van tevoren comprimeren en opslaan)
  - Dynamisch gecomprimeerd (bestanden on-the-fly comprimeren nadat een verzoek is gedaan)

Omdat voorcompressie vooraf wordt gedaan, kunnen we meer tijd besteden aan het comprimeren van de activa. Voor dynamisch gecomprimeerde bronnen moeten we de compressieniveaus zo kiezen dat compressie minder tijd kost dan het tijdsverschil tussen het verzenden van een niet-gecomprimeerd versus een gecomprimeerd bestand. Dit verschil wordt bevestigd als we kijken naar de aanbevelingen voor compressieniveaus voor beide methoden.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Brotli</th>
        <th scope="col">Gzip</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Voorgecomprimeerd</td>
        <td>11</td>
        <td>9 of Zopfli</td>
      </tr>
      <tr>
        <td>Dynamisch gecomprimeerd</td>
        <td>5</td>
        <td>6</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Aanbevolen compressieniveaus om te gebruiken.") }}</figcaption>
</figure>

Momenteel wordt praktisch alle tekstcompressie uitgevoerd door een van de twee HTTP-inhoudscoderingen: <a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a> en <a hreflang="en" href="https://github.com/google/brotli">Brotli</a>. Beide worden breed ondersteund door browsers: <a hreflang="en" href="https://caniuse.com/?search=brotli">kan ik Brotli gebruiken</a>/<a hreflang="en" href="https://caniuse.com/?search=gzip">kan ik Gzip gebruiken</a>

Als u Gzip wilt gebruiken, overweeg dan om [Zopfli](https://en.wikipedia.org/wiki/Zopfli) te gebruiken, die kleinere Gzip-compatibele bestanden genereert. Dit moet vooral worden gedaan voor voorgecomprimeerde bronnen, aangezien hier de grootste <a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">winst wordt verwacht</a>. Zie deze <a hreflang="en" href="https://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/">vergelijking tussen Gzip en Zopfli</a> die rekening houdt met verschillende compressieniveaus voor Gzip.

Veel [populaire servers](https://en.wikipedia.org/wiki/HTTP_compression#Servers_that_support_HTTP_compression) ondersteunen dynamisch en/of voorgecomprimeerd HTTP en veel van hen ondersteunen [Brotli](https://en.wikipedia.org/wiki/Brotli).

## Huidige status van HTTP-compressie

Ongeveer 60% van de HTTP-reacties wordt geleverd zonder tekstgebaseerde compressie. Dit lijkt misschien een verrassende statistiek, maar houd er rekening mee dat deze is gebaseerd op alle HTTP-reacties in de dataset. Sommige inhoud, zoals afbeeldingen, zal niet profiteren van deze compressie-algoritmen en wordt daarom niet vaak gebruikt, zoals weergegeven in figuur 19.2.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Inhoud Codering</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobiel</th>
        <th scope="col">Gecombineerd</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Geen Tekstcompressie</em></td>
        <td class="numeric">60,06%</td>
        <td class="numeric">59,31%</td>
        <td class="numeric">59,67%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">30,82%</td>
        <td class="numeric">31,56%</td>
        <td class="numeric">31,21%</td>
      </tr>
      <tr>
        <td>Brotli</td>
        <td class="numeric">9,10%</td>
        <td class="numeric">9,11%</td>
        <td class="numeric">9,11%</td>
      </tr>
      </tr>
      <tr>
        <td><em>Andere</em></td>
        <td class="numeric">0,02%</td>
        <td class="numeric">0,02%</td>
        <td class="numeric">0,02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Overname van compressie-algoritmen.", sheets_gid="1365871671", sql_file="19_01.type_of_content_encoding.sql") }}</figcaption>
</figure>

Van de bronnen die gecomprimeerd worden aangeboden, gebruikt de meerderheid Gzip (77%) of Brotli (23%). De andere compressie-algoritmen worden niet vaak gebruikt.

{{ figure_markup(
  image="compression-algorithms-for-http-responses.png",
  caption="Compressie-algoritme voor HTTP-reacties.",
  description="Een staafdiagram met de gebruikssnelheden van verschillende compressie-algoritmen voor HTTP-reacties. 77,39% van de HTTP-reacties die compressie gebruiken, maakt gebruik van het Gzip-algoritme, 22,59% gebruikt Brotli en 0,03% gebruikt een andere methode.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1523202090&format=interactive",
  sheets_gid="1365871671",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

In de onderstaande grafiek worden de top 11 inhoudstypen weergegeven met vakgroottes die het relatieve aantal reacties vertegenwoordigen. De kleur van elk vak geeft aan hoeveel van deze bronnen gecomprimeerd werden bediend, oranje geeft een laag compressiepercentage aan, terwijl blauw een hoog compressiepercentage aangeeft. De meeste media-inhoud is oranje gearceerd, wat wordt verwacht aangezien Gzip en Brotli weinig tot geen voordeel voor hen zouden hebben. De meeste tekstinhoud is blauw gearceerd om aan te geven dat ze worden gecomprimeerd. De lichtblauwe arcering voor sommige inhoudstypen geeft echter aan dat ze niet zo consistent worden gecomprimeerd als de andere.

{{ figure_markup(
  image="compression-algorithms-by-content-type-desktop.png",
  caption="Compressie op type op desktoppagina's.",
  description="Boomkaart-diagram met afbeelding/jpeg (91.926.198 reacties - 3,27% gecomprimeerd), applicatie/javascript (80.360.676 reacties - 84,88% gecomprimeerd), afbeelding/png (66.351.767 reacties - 3,7% gecomprimeerd), tekst/css (54.104.482 reacties - 84,0% gecomprimeerd), tekst/html (48.670.006 reacties - 44,25% gecomprimeerd), afbeelding/gif (39.390.408 reacties - 3,42% gecomprimeerd), tekst/javascript (35.491.375 reacties - 90,74% gecomprimeerd), applicatie/x-javascript (22.714.896 reacties - 93,14% gecomprimeerd), applicatie/json (13.453.942 reacties - 63,02% gecomprimeerd), tekst/plain (4.629.644 reacties - 32,89% gecomprimeerd).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=777357707&format=interactive",
  sheets_gid="449339162",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

In figuur 19.1 hierboven wordt het percentage compressie gebruikt per inhoud-type uitgesplitst, in figuur 19.6 wordt dit percentage aangeduid met kleur. De twee figuren vertellen vergelijkbare verhalen: niet op tekst gebaseerde middelen worden zelden gecomprimeerd, terwijl op tekst gebaseerde middelen vaak worden gecomprimeerd. De compressiesnelheden zijn ook vergelijkbaar voor zowel mobiel als desktop.

## Eerste-partij versus derden compressie

In het hoofdstuk [Derden](./third-parties) leren we over derden en hun invloed op de prestaties. Het gebruik van derden kan ook gevolgen hebben voor de compressie.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Desktop</th>
        <th scope="colgroup" colspan="2">Mobiel</th>
      </tr>
      <tr>
        <th scope="col">Inhoud Codering</th>
        <th scope="col">Eerste-Partij</th>
        <th scope="col">Derden</th>
        <th scope="col">Eerste-Partij</th>
        <th scope="col">Derden</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Geen Tekstcompressie</em></td>
        <td class="numeric">61,93%</td>
        <td class="numeric">57,81%</td>
        <td class="numeric">60,36%</td>
        <td class="numeric">58,11%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">30,95%</td>
        <td class="numeric">30,66%</td>
        <td class="numeric">32,36%</td>
        <td class="numeric">30,65%</td>
      </tr>
      <tr>
        <td>br</td>
        <td class="numeric">7,09%</td>
        <td class="numeric">11,51%</td>
        <td class="numeric">7,26%</td>
        <td class="numeric">11,22%</td>
      </tr>
      <tr>
        <td lang="en">deflate</td>
        <td class="numeric">0,02%</td>
        <td class="numeric">0,01%</td>
        <td class="numeric">0,02%</td>
        <td class="numeric">0,01%</td>
      </tr>
      <tr>
        <td><em>Anders / ongeldig</em></td>
        <td class="numeric">0,01%</td>
        <td class="numeric">0,01%</td>
        <td class="numeric">0,01%</td>
        <td class="numeric">0,01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Eerste-partij versus derden compressie per apparaattype.", sheets_gid="862864630", sql_file="19_03.party_of_content_encoding.sql") }}</figcaption>
</figure>

Wanneer we compressietechnieken tussen eerste en derde partijen vergelijken, kunnen we zien dat inhoud van derden de neiging heeft om meer gecomprimeerd te worden dan eerste inhoud. Bovendien is het percentage Brotli-compressie hoger voor inhoud van derden. Dit komt waarschijnlijk door het aantal bronnen dat wordt geleverd door de grotere derde partijen die doorgaans Brotli ondersteunen, zoals Google en Facebook.

Vergeleken met [de resultaten van vorig jaar](../2019/compression#eerste-partij-versus-derden-compressie), kunnen we zien dat er een aanzienlijke toename was in het gebruik van compressie, met name Brotli voor eerste-partijen, bijna tot het punt dat het gebruik van compressie ongeveer 40% is voor zowel eerste als derde partij, en voor desktop en mobiel. Binnen de reacties die wel compressie gebruiken, is voor eerste partijen de ratio van Brotli-compressie slechts 18%, terwijl de ratio voor derden 27% is.

## Hoe u compressie op uw sites kunt analyseren

U kunt [Firefox Developer Tools](https://developer.mozilla.org/docs/Tools) of <a hreflang="en" href="https://developers.google.com/web/tools/chrome-devtools">Chrome DevTools</a> gebruiken om snel uit te zoeken welke inhoud een website al comprimeert. Ga hiervoor naar het tabblad Netwerk, klik met de rechtermuisknop en activeer "Content Encoding" onder Response Headers. Als u over de grootte van individuele bestanden zweeft, ziet u "transferred over network" en "resource size". Geaggregeerd voor de hele site kan men de grootte/overgedragen grootte voor Firefox en "transferred" en "resources" voor Chrome linksonder op het tabblad Netwerk zien.

{{ figure_markup(
  image="content-encoding.png",
  caption='Gebruik DevTools om te controleren of er inhoudscodering op uw site wordt gebruikt',
  description="Afbeelding die laat zien hoe DevTools te gebruiken om te zien of inhoudscodering wordt gebruikt.",
  width=591,
  height=939
  )
}}

Een ander hulpmiddel om compressie op uw site beter te begrijpen, is de Google-hulpmiddel<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>, waarmee u een reeks audits op webpagina's kunt uitvoeren. De <a hreflang="en" href="https://web.dev/uses-text-compression/">tekstcompressie-audit</a> evalueert of een site kan profiteren van aanvullende tekstgebaseerde compressie. Het doet dit door te proberen bronnen te comprimeren en te evalueren of de grootte van een object kan worden verminderd met ten minste 10% en 1.400 bytes. Afhankelijk van de score ziet u mogelijk een compressieadvies in de resultaten, met een lijst met specifieke bronnen die kunnen worden gecomprimeerd.

Omdat het [HTTP Archive Lighthouse-audits uitvoert](./methodology#lighthouse) voor elke mobiele pagina, kunnen we de scores van alle sites samenvoegen om te zien hoeveel kans er is om meer inhoud te comprimeren. In totaal slaagt 74% van de websites voor deze audit, terwijl bijna 13% van de websites onder de 40 scoort. Dit is een verbetering van 11,5% in vergelijking met 62,5% van de passerende scores [vorig jaar](../2019/compression#het-identificeren-van-compressiemogelijkheden).

{{ figure_markup(
  image="text-compression-lighthouse-scores.png",
  caption="Tekstcompressie Lighthouse scores.",
  description='Gestapeld staafdiagram waarin de pagina\'s met scores worden opgesplitst die worden ontvangen voor de Lighthouse-audit "tekstcompressie inschakelen". Het laat zien dat 7% van de sites minder dan 10% scoort, 6% van de sites scoort tussen 10-39%, 10% van sites scoort tussen 40-79%, 3% van sites scoort tussen 80-99% en 74% van de sites heeft een pas met meer dan 100% van de tekstitems die worden gecomprimeerd.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1438276663&format=interactive",
  sheets_gid="1284073179",
  sql_file="19_04.distribution_of_text_compression_lighthouse.sql"
  )
}}

## Gevolgtrekking

In vergelijking met [de Almanac van vorig jaar](../2019/compression) is er een duidelijke trend om meer tekstcompressie te gebruiken. Het aantal reacties dat geen gebruik maakt van tekstcompressie is met iets meer dan 2% gedaald, terwijl het gebruik van Brotli met bijna 2% is toegenomen. De Lighthouse-scores zijn aanzienlijk verbeterd.

Tekstcompressie wordt veel gebruikt voor de relevante indelingen, hoewel er nog steeds een aanzienlijk percentage HTTP-reacties is dat baat zou kunnen hebben bij extra compressie. U kunt profiteren door de configuratie van uw server onder de loep te nemen en de compressiemethoden en -niveaus naar wens in te stellen. Een grote impact voor een positievere gebruikerservaring zou kunnen worden bereikt door zorgvuldig de standaardinstellingen te kiezen voor de meest populaire HTTP-servers.
