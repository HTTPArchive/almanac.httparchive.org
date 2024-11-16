---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP/2
description: HTTP/2-hoofdstuk van de Web Almanac 2020, dat de acceptatie en impact van HTTP/2, HTTP/2 Push, HTTP/2 Issues en HTTP/3 behandelt.
hero_alt: Hero image of Web Almanac chracters driving vehicles in various lanes carrying script and images resources.
authors: [dotjs, rmarx, MikeBishop]
reviewers: [LPardue, tunetheweb, ibnesayeed]
analysts: [gregorywolf]
editors: [rviscomi]
translators: [noah-vdv]
dotjs_bio: Andrew werkt bij <a hreflang="en" href="https://www.cloudflare.com/">Cloudflare</a> om het internet sneller en veiliger te maken. Hij besteedt zijn tijd aan het implementeren, meten en verbeteren van nieuwe protocollen en levering van activa om de prestaties van de website van eindgebruikers te verbeteren.
rmarx_bio: Robin is een webprotocol- en prestatieonderzoeker bij <a href="https://www.uhasselt.be/expertisecentrum-voor-digitale-media">Universiteit Hasselt, België</a>. Hij heeft gewerkt aan het gebruiksklaar maken van QUIC en HTTP/3 door hulpmiddelen te maken zoals <a hreflang="en" href="https://github.com/quiclog">qlog en qvis</a>.
MikeBishop_bio: Editor van HTTP/3 met de <a hreflang="en" href="https://quicwg.org/">QUIC Working Group</a>. Architect in de Foundry-groep van <a hreflang="en" href="https://www.akamai.com/">Akamai</a>.
discuss: 2058
results: https://docs.google.com/spreadsheets/d/1M1tijxf04wSN3KU0ZUunjPYCrVsaJfxzuRCXUeRQ-YU/
featured_quote: Dit hoofdstuk bespreekt de huidige status van de implementatie van HTTP/2 en gQUIC, om vast te stellen hoe goed sommige van de nieuwere functies van het protocol, zoals prioriteitstelling en serverpush, zijn overgenomen. Vervolgens kijken we naar de motivaties voor HTTP/3, beschrijven we de belangrijkste verschillen tussen de protocolversies en bespreken we de mogelijke uitdagingen bij het upgraden naar een UDP-gebaseerd transportprotocol met QUIC.
featured_stat_1: 64%
featured_stat_label_1: Verzoeken geleverd via HTTP/2
featured_stat_2: 31,7%
featured_stat_label_2: CDN-verzoeken met onjuiste HTTP/2-prioriteitstelling
featured_stat_3: 80%
featured_stat_label_3: Pagina's die worden bediend via HTTP/2 als een CDN wordt gebruikt, 30% als CDN niet wordt gebruikt
---

## Inleiding

HTTP is een applicatielaagprotocol dat is ontworpen om informatie tussen netwerkapparaten uit te wisselen en wordt uitgevoerd bovenop andere lagen van de netwerkprotocolstapel. Nadat HTTP/1.x was uitgebracht, duurde het meer dan 20 jaar voordat de eerste grote update, HTTP/2, in 2015 een standaard werd.

Daar bleef het niet bij: de afgelopen vier jaar zijn HTTP/3 en QUIC (een nieuw latentieverminderend, betrouwbaar en veilig transportprotocol) in standaarden ontwikkeld in de IETF QUIC-werkgroep. Er zijn eigenlijk twee protocollen die dezelfde naam hebben: "Google QUIC" (afgekort "gQUIC"), het oorspronkelijke protocol dat is ontworpen en gebruikt door Google, en de nieuwere IETF-gestandaardiseerde versie (IETF QUIC/QUIC). IETF QUIC was gebaseerd op gQUIC, maar is uitgegroeid tot een heel ander ontwerp en implementatie. Op 21 oktober 2020 bereikte concept 32 van IETF QUIC een belangrijke mijlpaal toen het werd verplaatst naar <a hreflang="en" href="https://mailarchive.ietf.org/arch/msg/quic/ye1LeRl7oEz898RxjE6D3koWhn0/">Last Call</a>. Dit is het deel van het standaardisatieproces wanneer de werkgroep denkt dat ze bijna klaar zijn en vraagt om een laatste beoordeling van de bredere IETF-gemeenschap.

In dit hoofdstuk wordt de huidige status van HTTP/2 en gQUIC-implementatie besproken. Het onderzoekt hoe goed sommige van de nieuwere functies van het protocol, zoals prioriteitstelling en server-push, zijn overgenomen. Vervolgens kijken we naar de motivaties voor HTTP/3, beschrijven we de belangrijkste verschillen tussen de protocolversies en bespreken we de mogelijke uitdagingen bij het upgraden naar een UDP-gebaseerd transportprotocol met QUIC.

### HTTP/1.0 naar HTTP/2

Terwijl het HTTP-protocol is geëvolueerd, is de semantiek van HTTP hetzelfde gebleven; er zijn geen wijzigingen in de HTTP-methoden (zoals GET of POST), statuscodes (200 of de gevreesde 404), URI's of headervelden. Waar het HTTP-protocol is veranderd, zijn de verschillen de draadcodering en het gebruik van functies van het onderliggende transport.

HTTP/1.0, gepubliceerd in 1996, definieerde het op tekst gebaseerde applicatieprotocol, waardoor cliënten en servers berichten kunnen uitwisselen om bronnen aan te vragen. Voor elk verzoek/antwoord was een nieuwe TCP-verbinding vereist, waardoor overhead werd geïntroduceerd. TCP-verbindingen gebruiken een algoritme voor congestiecontrole om te maximaliseren hoeveel gegevens er tijdens de vlucht kunnen zijn. Dit proces kost tijd voor elke nieuwe verbinding. Deze "langzame start" betekent dat niet alle beschikbare bandbreedte onmiddellijk wordt gebruikt.

In 1997 werd HTTP/1.1 geïntroduceerd om hergebruik van TCP-verbindingen mogelijk te maken door <span lang="en">"keep-alives"</span> toe te voegen, gericht op het verlagen van de totale kosten van het opstarten van verbindingen. Na verloop van tijd leidden de toenemende prestatieverwachtingen van de website tot de behoefte aan gelijktijdigheid van verzoeken. HTTP/1.1 kon alleen een andere bron opvragen nadat het vorige antwoord was voltooid. Daarom moesten extra TCP-verbindingen tot stand worden gebracht, waardoor de impact van de keep-alive-verbindingen werd verkleind en de overhead nog groter werd.

HTTP/2, gepubliceerd in 2015, is een binair protocol dat het concept van bidirectionele streams tussen cliënt en server introduceerde. Met behulp van deze streams kan een browser optimaal gebruik maken van een enkele TCP-verbinding om meerdere HTTP-verzoeken/-antwoorden tegelijkertijd te _multiplexen_. HTTP/2 introduceerde ook een prioriteitsschema om deze _multiplexing_ te sturen; cliënten kunnen een verzoekprioriteit aangeven waardoor belangrijkere bronnen vóór anderen kunnen worden verzonden.

## HTTP/2-adoptie

De gegevens die in dit hoofdstuk worden gebruikt, zijn afkomstig uit het HTTP Archive en testen meer dan zeven miljoen websites met een Chrome-browser. Net als bij andere hoofdstukken, wordt de analyse opgesplitst in mobiele en desktopwebsites. Wanneer de resultaten tussen desktop en mobiel vergelijkbaar zijn, worden statistieken uit de mobiele dataset gepresenteerd. U kunt meer details vinden op de pagina [Methodologie](./methodology). Houd er bij het bekijken van deze gegevens rekening mee dat elke website evenveel gewicht krijgt, ongeacht het aantal verzoeken. We raden u aan dit meer te zien als het onderzoeken van de trends op een breed scala aan actieve websites.

{{ figure_markup(
  image="http2-h2-usage.png",
  link="https://httparchive.org/reports/state-of-the-web#h2",
  caption='HTTP/2-gebruik op verzoek. (Bron: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#h2">HTTP Archive</a>)',
  description="Tijdreeksdiagram van HTTP / 2-gebruik met een acceptatie van 64% voor zowel desktop als mobiel vanaf juli 2019. De trend groeit gestaag met ongeveer 15 punten per jaar.",
  width=600,
  height=321
  )
}}

Uit de analyse van HTTP Archive-gegevens vorig jaar bleek dat HTTP/2 werd gebruikt voor meer dan 50% van de verzoeken en, zoals te zien is, is de lineaire groei in 2020 voortgezet; nu wordt meer dan 60% van de verzoeken bediend via HTTP/2.

{{ figure_markup(
  caption="Het percentage verzoeken dat gebruikmaakt van HTTP/2.",
  content="64%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

Wanneer Figuur 22.3 wordt vergeleken met de resultaten van vorig jaar, is er een toename van **10% in HTTP/2-verzoeken** en een overeenkomstige afname van 10% in HTTP/1.x-verzoeken. Dit is het eerste jaar dat gQUIC in de dataset te zien is.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocol</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">**34,47%</td>
        <td class="numeric">34,11%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">63,70%</td>
        <td class="numeric">63,80%</td>
      </tr>
      <tr>
        <td>gQUIC</td>
        <td class="numeric">1,72%</td>
        <td class="numeric">1,71%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="Gebruik van HTTP-versie op verzoek.", sheets_gid="2122693316", sql_file="adoption_of_http_2_by_site_and_requests.sql") }}</figcaption>
</figure>

<p class="note">
  ** Net als bij de crawl van vorig jaar, meldde ongeveer 4% van de desktopverzoeken geen protocolversie. Analyse toont aan dat dit meestal HTTP/1.1 is en we hebben eraan gewerkt om dit gat in onze statistieken voor toekomstige crawls en analyses te dichten. Hoewel we de gegevens baseren op de crawl van augustus 2020, hebben we de correctie in de gegevensset van oktober 2020 vóór publicatie bevestigd, die inderdaad aantoonde dat dit HTTP/1.1-verzoeken waren en hebben ze daarom aan die statistiek in de bovenstaande tabel toegevoegd.
</note>

Bij het beoordelen van het totale aantal websiteverzoeken, zal er een voorkeur zijn voor algemene domeinen van derden. Om een beter begrip te krijgen van de HTTP/2-acceptatie door serverinstallatie, zullen we in plaats daarvan kijken naar het protocol dat wordt gebruikt om de HTML aan te bieden vanaf de startpagina van een site.

Vorig jaar werd ongeveer 37% van de startpagina's bediend via HTTP/2 en 63% via HTTP/1. Dit jaar is de combinatie van mobiel en desktop ongeveer gelijk, met iets meer desktopsites die voor het eerst via HTTP/2 worden bediend, zoals weergegeven in figuur 22.4.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocol</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0,06%</td>
        <td class="numeric">0,05%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">49,22%</td>
        <td class="numeric">50,05%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">49,97%</td>
        <td class="numeric">49,28%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="HTTP-versiegebruik voor startpagina's.", sheets_gid="1447413141", sql_file="measure_of_all_http_versions_for_main_page_of_all_sites.sql") }}</figcaption>
</figure>

gQUIC wordt om twee redenen niet gezien in de gegevens van de startpagina. Om een website over gQUIC te meten, zou de HTTP Archivecrawl protocolonderhandelingen moeten uitvoeren via de [alternative services](#alternative-services)-header en vervolgens dit eindpunt gebruiken om de site over gQUIC te laden. Dit werd dit jaar niet ondersteund, maar verwacht dat het volgend jaar beschikbaar zal zijn in de Web Almanac. gQUIC wordt ook voornamelijk gebruikt voor Google-tools van derden in plaats van startpagina's weer te geven.

De drang om [beveiliging](./security) en [privacy](./privacy) op het web te verbeteren, heeft geleid tot een toename van het aantal verzoeken over TLS met <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">meer dan 150% in de afgelopen 4 jaar</a>. Tegenwoordig is meer dan 86% van alle verzoeken op mobiel en desktop versleuteld. Als we alleen naar startpagina's kijken, zijn de cijfers nog steeds een indrukwekkende 78,1% van de desktop en 74,7% van de mobiele apparaten. Dit is belangrijk omdat HTTP/2 alleen wordt ondersteund door browsers via TLS. Het aandeel dat via HTTP/2 wordt bediend, zoals weergegeven in figuur 22.5, is ook met 10 procentpunten gestegen ten opzichte van [vorig jaar](../2019/http#fig-5), van 55% naar 65%.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocol</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">36,05%</td>
        <td class="numeric">34,04%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">63,95%</td>
        <td class="numeric">65,96%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="HTTP-versiegebruik voor HTTPS-startpagina's.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

Nu meer dan 60% van de websites wordt bediend via HTTP/2 of gQUIC, gaan we wat dieper kijken naar het patroon van protocoldistributie voor alle verzoeken die op individuele sites worden gedaan.

{{ figure_markup(
  image="http2-h2-or-gquic-requests-per-page.png",
  caption="Vergelijk de verdeling van fractie van HTTP/2-aanvragen per pagina in 2020 met 2019.",
  description="Een staafdiagram van de fractie van HTTP/2-aanvragen per pagina percentage. Het mediane percentage van HTTP/2- of GQUIC-aanvragen per pagina is toegenomen tot 76% in 2020 van 46% in 2019. Op de 10, 25, 75 en 90e percentielen, de fractie van HTTP/2- of GQUIC-aanvragen per pagina in 2020 is 5%, 24%, 98% en 100% vergeleken met 3%, 15%, 93% en 100% in 2019.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1328744214&format=interactive",
  sheets_gid="152400778",
  sql_file="percentiles_of_resources_loaded_over_HTTP2_or_better_per_site.sql"
  )
}}

Figuur 22.6 Vergelijkt hoeveel HTTP/2 of GQUIC wordt gebruikt op een website tussen dit jaar en vorig jaar. De meest opvallende verandering is dat meer dan de helft van de sites nu 75% of meer van hun verzoeken heeft geserveerd via HTTP/2 of GQUIC vergeleken met 46% vorig jaar. Minder dan 7% van de sites maakt geen HTTP/2- of GQUIC-aanvragen, terwijl (alleen) 10% van de sites volledig HTTP/2- of GQUIC-verzoeken is.

Hoe zit het met de uitsplitsing van de pagina zelf? We praten meestal over het verschil tussen inhoud van de eerste partij en derden. Derde-partij wordt gedefinieerd als inhoud die niet binnen de directe controle van de eigenaar van de site, functionaliteit, zoals reclame, marketing of analyse biedt. De definitie van bekende derden is afkomstig van de <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5">third party web</a> repository.

Figuur 22.7 bestelt van elke website door de fractie van HTTP/2-verzoeken voor bekende derden of eerste partijverzoeken in vergelijking met andere verzoeken. Er is een merkbaar verschil als meer dan 40% van alle sites geen HTTP/2 of GQUIC-aanvragen heeft. Daarentegen heeft zelfs de laagste 5% van de pagina's 30% van de inhoud van derden geserveerd via HTTP/2. Dit geeft aan dat een groot deel van de brede goedkeuring van HTTP/2 wordt aangedreven door de derde partijen.

{{ figure_markup(
  image="http2-first-and-third-party-http2-usage.png",
  caption="De verdeling van de fractie van derden en eerste-Partij HTTP/2-aanvragen per pagina.",
  description="Een lijndiagram vergelijkt de fractie van HTTP/2-aanvragen van de eerste partijen met HTTP/2- of GQUIC-verzoeken van derden. De grafiek bestelt de websites per fractie van HTTP/2-aanvragen. 45% van de websites heeft geen HTTP/2 eerste-partij-aanvragen. Meer dan de helft van de websites serveren alleen aanvragen van derden via HTTP/2 of GQUIC. 80% van de websites heeft 76% of meer HTTP/2- of GQUIC-aanvragen van derden.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1409316276&format=interactive",
  sql_file="http2_1st_party_vs_3rd_party.sql",
  sheets_gid="733872185"
)
}}

Is er een verschil in welke inhoud-typen worden geserveerd via HTTP/2 of GQUIC? Figuur 22.8 toont bijvoorbeeld dat 90% van de websites 100% van de lettertypen van derden en audio via HTTP/2 of GQUIC serveert, slechts 5% boven HTTP/1.1 en 5% zijn een mix. De meerderheid van de activa van derden is scripts of afbeeldingen en worden uitsluitend geserveerd over HTTP/2 of GQUIC op respectievelijk 60% en 70% van de websites.

{{ figure_markup(
  image="http2-third-party-http2-usage-by-content-type.png",
  caption="De fractie van bekende HTTP/2- of GQUIC-verzoeken van derden door inhoudstype per website.",
  description="Een staafdiagram vergelijken met de fractie van HTTP/2-aanvragen van derden door inhoudstype. Alle vragen van derden worden geserveerd via HTTP/2 of GQUIC voor 90% van audio en lettertypen, 80% van CSS en video, 70% van HTML, beeld en tekst en 60% van de scripts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1264128523&format=interactive",
  sheets_gid="419557288",
  sql_file="http2_1st_party_vs_3rd_party_by_type.sql"
)
}}

Advertenties, Analytics, Content Delivery Network (CDN)-bronnen en tag-managers worden voornamelijk geserveerd via HTTP/2 of GQUIC zoals getoond in Figuur 22.9. Customer-success en Marketing-inhoud wordt waarschijnlijk meer geserveerd via HTTP/1.

{{ figure_markup(
  image="http2-third-party-http2-usage-by-category.png",
  caption="De fractie van bekende HTTP/2- of GQUIC-verzoeken van derden per categorie per website.",
  description="Een staafdiagram die vergelijkt de fractie van HTTP/2- of GQUIC-aanvragen van derden per categorie. Alle vragen van derden voor alle websites worden geserveerd via HTTP / 2 of GQUIC voor 95% van de tagmanagers, 90% van de analyse en CDN, 80% van de advertenties, sociale, hosting en nut, 40% van de marketing en 30% van de klant -succes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1419102835&format=interactive",
  sheets_gid="1059610651",
  sql_file="http2_3rd_party_by_types.sql"
)
}}

### Serverondersteuning

Browser auto-update-mechanismen zijn een drijffactor voor de aanneming van de klantzijde van nieuwe webnormen. Het is <a hreflang="en" href="https://caniuse.com/http2">geschat</a> dat meer dan 97% van de wereldwijde gebruikers HTTP/2 ondersteunt, enigszins omhoog van 95% gemeten vorig jaar.

Helaas is het verbeteringspad voor servers moeilijker, vooral met de eis om TLS te ondersteunen. Voor mobiel en desktop kunnen we zien vanaf figuur 22.10, dat de meerderheid van de HTTP/2-sites worden bediend door NGINX, CloudFlare en Apache. Bijna de helft van de HTTP/1.1-sites wordt bediend door Apache.

{{ figure_markup(
  image="http2-server-protocol-usage.png",
  caption="Servergebruik door HTTP-protocol op mobiel",
  description="Een staafdiagram met het aantal websites dat wordt gediend door HTTP/1.x of HTTP/2 voor de populairste servers naar mobiele klanten. NGINX serveert 727.181 HTTP/1.1 en 1.023.575 HTTP/2 sites. Cloudflare 59.981 HTTP/1.1 en 679.616 HTTP/2. Apache 1.521.753 HTTP/1.1 en 585.096 HTTP/2. Litespeed 50.502 HTTP/1.1 en 166.721 HTTP/2. Microsoft-IIS 284.047 HTTP/1.1 en 81.490 HTTP/2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=718663369&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
)
}}

Hoe wordt HTTP/2-adoptie in het laatste jaar voor elke server gewijzigd? Figuur 22.11 toont een algemene HTTP/2-goedkeuring van ongeveer 10% in alle servers sinds vorig jaar. Apache en IIS zijn nog steeds minder dan 25% HTTP/2. Dit suggereert dat nieuwe servers de neiging hebben NGINX te zijn of het wordt gezien als te moeilijk of niet de moeite waard om Apache of IIS naar HTTP/2 en/of TLS te upgraden.

{{ figure_markup(
  image="http2-h2-usage-by-server.png",
  caption="Percentage pagina's geserveerd via HTTP/2 per server",
  description="Een staafdiagram die het percentage van websites die geserveerd worden via HTTP/2 tussen 2019 en 2020 vergelijkt. Cloudflare steeg tot 93,08% van 85,40%. Litespeed steeg tot 81,91% van 70,80%. Openstations steeg tot 66,24% van 51,40%. NGINX steeg tot 60,84% van 49,20%. Apache steeg tot 27,19% van 18,10% en MIcorSoft-IIS steeg tot 22,82% van 14,10%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=936321266&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

Een aanbeveling op lange termijn om de website-prestaties te verbeteren, is geweest om een CDN te gebruiken. Het voordeel is een vermindering van de latentie door zowel de inhoud en het beëindigen van verbindingen dichter bij de eindgebruiker. Dit helpt de snelle evolutie in Protocol-implementatie en de extra complexiteiten in tuningservers en besturingssystemen te beperken (zie de sectie [Prioritering](#prioritering) voor meer informatie). Om de nieuwe protocollen effectief te gebruiken, kan het gebruik van een CDN worden gezien als de aanbevolen aanpak.

CDN's kunnen worden geclassificeerd in twee brede categorieën: degenen die de startpagina en/of activa-subdomeinen serveren, en degenen die voornamelijk worden gebruikt om inhoud van derden te dienen. Voorbeelden van de eerste categorie zijn de grotere generieke CDN's (zoals Cloudflare, Akamai of Fastly) en de specifieker (zoals WordPress of Netlify). Kijkend naar het verschil in HTTP/2-goedkeuringscijfers voor startpagina's geserveerd met of zonder een CDN, zien we:

- **80%** van de mobiele startpagina's wordt bediend via HTTP/2 als een CDN wordt gebruikt
- **30%** van de mobiele startpagina's wordt bediend via HTTP/2 als er geen CDN wordt gebruikt

Figuur 22.12 toont de meer specifieke en moderne CDN's die een groter deel van het verkeer bedienen via HTTP/2.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="colgroup" class="no-wrap">HTTP/2 (%)</th>
        <th scope="colgroup">CDN</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>100%</td>
        <td>Bison Grid, CDNsun, LeaseWeb CDN, NYI FTW, QUIC.cloud, Roast.io, Sirv CDN, Twitter, Zycada Networks</td>
      </tr>
      <tr>
        <td>90 - 99%</td>
        <td>Automattic, Azion, BitGravity, Facebook, KeyCDN, Microsoft Azure, NGENIX, Netlify, Yahoo, section.io, Airee, BunnyCDN, Cloudflare, GoCache, NetDNA, SFR, Sucuri Firewall</td>
      </tr>
      <tr>
        <td>70 - 89%</td>
        <td>Amazon CloudFront, BelugaCDN, CDN, CDN77, Erstream, Fastly, Highwinds, OVH CDN, Yottaa, Edgecast, Myra Security CDN, StackPath, XLabs Security</td>
      </tr>
      <tr>
        <td>20 - 69%</td>
        <td>Akamai, Aryaka, Google, Limelight, Rackspace, Incapsula, Level 3, Medianova, OnApp, Singular CDN, Vercel, Cachefly, Cedexis, Reflected Networks, Universal CDN, Yunjiasu, CDNetworks</td>
      </tr>
      <tr>
        <td> < 20%</td>
        <td>Rocket CDN, BO.LT, ChinaCache, KINX CDN, Zenedge, ChinaNetCenter </td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentage HTTP/2-verzoeken dat wordt geleverd door de eerste-partij CDN's via mobiel.", sheets_gid="781660433", sql_file="cdn_detail_by_cdn.sql") }}</figcaption>
</figure>

Typen inhoud in de tweede categorie zijn doorgaans gedeelde bronnen (JavaScript of lettertype-CDN's), advertenties of analyses. In al deze gevallen zal het gebruik van een CDN de prestaties en ontlasting voor de verschillende SaaS-oplossingen verbeteren.

{{ figure_markup(
  image="http2-cdn-http2-usage.png",
  caption="Vergelijking van HTTP/2- en gQUIC-gebruik voor websites die een CDN gebruiken.",
  description="Een lijndiagram dat de fractie van verzoeken die met HTTP/2 of gQUIC worden bediend, voor websites die een CDN gebruiken, vergelijkt met sites die dat niet doen. De x-as toont de percentielen van webpagina's, gesorteerd op percentage verzoeken. 23% van de websites die geen CDN gebruiken, heeft geen HTTP/2- of gQUIC-gebruik. Ter vergelijking: de 60% van de websites die een CDN gebruiken, hebben allemaal HTTP/2- of gQUIC-gebruik. 93% van de websites die een CDN gebruiken en 47% van de niet-CDN-sites hebben 50% of meer HTTP/2- of gQUIC-gebruik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1779365083&format=interactive",
  sheets_gid="1457263817",
  sql_file="cdn_summary.sql"
)
}}

In figuur 22.13 kunnen we het grote verschil zien in HTTP/2- en gQUIC-acceptatie wanneer een website een CDN gebruikt. 70% van de pagina's gebruikt HTTP/2 voor alle verzoeken van derden wanneer een CDN wordt gebruikt. Zonder CDN gebruikt slechts 25% van de pagina's HTTP/2 voor alle verzoeken van derden.

## HTTP/2-impact

Het meten van de impact van hoe een protocol presteert is moeilijk met de huidige HTTP Archive [benadering](./methodology). Het zou echt fascinerend zijn om de impact van gelijktijdige verbindingen, het effect van pakketverlies en verschillende mechanismen voor congestiecontrole te kunnen kwantificeren. Om de prestaties echt te kunnen vergelijken, zou elke website via elk protocol over verschillende netwerkomstandigheden moeten worden gecrawld. Wat we in plaats daarvan kunnen doen, is kijken naar de impact op het aantal verbindingen dat een website gebruikt.

### Verbindingen verminderen

Zoals [eerder](#http10-naar-http2) besproken, staat HTTP/1.1 slechts één verzoek per keer via een TCP-verbinding toe. De meeste browsers omzeilen dit door zes parallelle verbindingen per host toe te staan. De belangrijkste verbetering met HTTP/2 is dat meerdere verzoeken via een enkele TCP-verbinding kunnen worden _gemultiplexed_. Dit zou het totale aantal verbindingen - en de bijbehorende tijd en middelen - die nodig zijn om een pagina te laden, moeten verminderen.

{{ figure_markup(
  image="http2-total-number-of-connections-per-page.png",
  caption="Verdeling van het totale aantal verbindingen per pagina",
  description="Een percentielgrafiek van het totale aantal verbindingen, waarin 2016 wordt vergeleken met 2020 op desktop. Het mediane aantal aansluitingen in 2016 is 23, in 2020 13. Op het 10e percentiel, 6 aansluitingen in 2016, 5 in 2020. Op het 25e percentiel, 12 aansluitingen in 2016, 8 in 2020. Op 75e percentiel, 43 aansluitingen in 2016, 20 in 2020. Op 90e percentiel, 76 aansluitingen in 2016 en 33 in 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=17394219&format=interactive",
  sheets_gid="1432183252",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
)
}}

Figuur 22.15 laat zien hoe het aantal TCP-verbindingen per pagina in 2020 is afgenomen ten opzichte van 2016. De helft van alle websites gebruikt nu 13 of minder TCP-verbindingen in 2020 ten opzichte van 23 verbindingen in 2016; een afname van 44%. In dezelfde periode is het <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#reqTotal">mediaan aantal verzoeken</a> slechts gedaald van 74 naar 73. Het mediaan aantal verzoeken per TCP-verbinding is gestegen van 3,2 naar 5,6.

TCP is ontworpen om een gemiddelde gegevensstroom te behouden die zowel efficiënt als eerlijk is. Stelt u een stroomcontroleproces voor waarbij elke stroom zowel druk uitoefent op als reageert op alle andere stromen, om een eerlijk deel van het netwerk te leveren. In een eerlijk protocol verdringt elke TCP-sessie geen enkele andere sessie en zal na verloop van tijd 1/N van de padcapaciteit in beslag nemen.

De meeste websites openen nog steeds meer dan 15 TCP-verbindingen. In HTTP/1.1 kunnen de zes verbindingen die een browser met een domein zou kunnen openen, na verloop van tijd zes keer zoveel bandbreedte claimen als een enkele HTTP/2-verbinding. Bij netwerken met een lage capaciteit kan dit de levering van inhoud van de primaire activadomeinen vertragen naarmate het aantal concurrerende verbindingen toeneemt en bandbreedte wegneemt van de belangrijke verzoeken. Dit is in het voordeel van websites met een klein aantal domeinen van derden.

HTTP/2 staat <a hreflang="en" href="https://tools.ietf.org/html/rfc7540#section-9.1">hergebruik van verbindingen</a> toe voor verschillende, maar gerelateerde domeinen. Voor een TLS-bron is een certificaat vereist dat geldig is voor de host in de URI. Dit kan worden gebruikt om het aantal verbindingen te verminderen dat nodig is voor domeinen die onder controle staan van de site-auteur.

### Prioritering

Omdat HTTP/2-reacties kunnen worden opgesplitst in veel individuele frames en omdat frames uit meerdere streams kunnen worden _gemultiplexed_, wordt de volgorde waarin de frames worden _interleaved_ en geleverd door de server een kritieke prestatie-overweging. Een typische website bestaat uit veel verschillende soorten bronnen: de zichtbare inhoud (HTML, CSS, afbeeldingen), de applicatielogica (JavaScript), advertenties, analyses voor het volgen van sitegebruik en marketing-trackingbakens. Met kennis van hoe een browser werkt, kan een optimale ordening van de bronnen worden gedefinieerd die zal resulteren in de snelste gebruikerservaring. Het verschil tussen optimaal en niet-optimaal kan aanzienlijk zijn - wel 50% prestatieverbetering of meer!

HTTP/2 introduceerde het concept van prioritering om de cliënt te helpen communiceren met de server hoe hij denkt dat het multiplexen moet worden uitgevoerd. Aan elke stream wordt een gewicht toegekend (hoeveel van de beschikbare bandbreedte de stream zou moeten worden toegewezen) en mogelijk een ouder (een andere stream die als eerste zou moeten worden afgeleverd). Met de flexibiliteit van het prioriteitsmodel van HTTP/2 is het niet helemaal verrassend dat alle huidige browser-engines <a hreflang="en" href="https://calendar.perfplanet.com/2018/http2-prioritization/"> verschillende prioriteitsstrategieën</a> hebben geïmplementeerd, die geen van alle <a hreflang="en" href="https://www.youtube.com/watch?v=nH4iRpFnf1c">optimaal</a> zijn.

Er zijn ook problemen aan de serverzijde, wat ertoe leidt dat veel servers de prioriteitstelling slecht of helemaal niet implementeren. In het geval van HTTP/1.x heeft het afstemmen van de serverzijde verzendbuffers om zo groot mogelijk te zijn geen nadeel, behalve de toename van het geheugengebruik (inruilen van geheugen voor CPU), en is het een effectieve manier om de doorvoersnelheid van een webserver. Dit geldt niet voor HTTP/2, aangezien gegevens in de TCP-verzendbuffer niet opnieuw geprioriteerd kunnen worden als een verzoek om een nieuwe, belangrijkere bron binnenkomt. Voor een HTTP/2-server is de optimale grootte van de verzendbuffer dus het minimale hoeveelheid data die nodig is om de beschikbare bandbreedte volledig te benutten. Hierdoor kan de server onmiddellijk reageren als een verzoek met een hogere prioriteit wordt ontvangen.

Dit probleem van grote buffers die knoeien met (her)prioritering bestaat ook in het netwerk, waar het de naam "bufferbloat" draagt. Netwerkapparatuur buffert liever pakketten dan ze te laten vallen als er een korte burst is. Als de server echter meer gegevens verzendt dan het pad naar de cliënt kan verbruiken, worden deze buffers volledig gevuld. Deze bytes die al op het netwerk zijn "opgeslagen", beperken het vermogen van de server om eerder een antwoord met een hogere prioriteit te verzenden, net zoals een grote verzendbuffer dat doet. Om de hoeveelheid gegevens in buffers te minimaliseren, <a hreflang="en" href="https://blog.cloudflare.com/http-2-prioritization-with-nginx/">zou een recent algoritme voor congestiebeheer, zoals BBR gebruikt moeten worden gebruikt</a>.

Deze <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">testsuite</a> die wordt beheerd door Andy Davies, meet en rapporteert hoe verschillende CDN- en cloudhostingservices presteren. Het slechte nieuws is dat slechts 9 van de 36 services de juiste prioriteiten stellen. Figuur 22.16 laat zien dat voor sites die een CDN gebruiken, ongeveer 31,7% niet de juiste prioriteiten stelt. Dit is gestegen van 26,82% vorig jaar, voornamelijk als gevolg van de toename van het Google CDN-gebruik. In plaats van te vertrouwen op de door de browser verzonden prioriteiten, zijn er enkele servers die een <a hreflang="en" href="https://blog.cloudflare.com/better-http-2-prioritization-for-a-faster-web/">prioriteitsschema aan de serverzijde</a> implementeren, waarbij de hints van de browser worden verbeterd met extra logica.

<figure>
  <table>
    <thead>
      <tr>
        <th>CDN</th>
        <th>Prioriteer <br> correct</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Zonder CDN</td>
        <td>Onbekend</td>
        <td class="numeric">59,47%</td>
        <td class="numeric">60,85%</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>Pass</td>
        <td class="numeric">22,03%</td>
        <td class="numeric">21,32%</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>Fail</td>
        <td class="numeric">8,26%</td>
        <td class="numeric">8,94%</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>Fail</td>
        <td class="numeric">2,64%</td>
        <td class="numeric">2,27%</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>Pass</td>
        <td class="numeric">2,34%</td>
        <td class="numeric">1,78%</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>Pass</td>
        <td class="numeric">1,31%</td>
        <td class="numeric">1,19%</td>
      </tr>
      <tr>
        <td>Automattic</td>
        <td>Pass</td>
        <td class="numeric">0,93%</td>
        <td class="numeric">1,05%</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>Fail</td>
        <td class="numeric">0,77%</td>
        <td class="numeric">0,63%</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>Fail</td>
        <td class="numeric">0,42%</td>
        <td class="numeric">0,34%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>Fail</td>
        <td class="numeric">0,27%</td>
        <td class="numeric">0,20%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Ondersteuning voor HTTP/2-prioriteitstelling in veelgebruikte CDN's.", sheets_gid="1152953475", sql_file="percentage_of_h2_and_h3_sites_affected_by_cdn_prioritization.sql") }}</figcaption>
</figure>

Voor niet-CDN-gebruik verwachten we dat het aantal servers dat correct HTTP/2-prioriteitstelling toepast aanzienlijk kleiner zal zijn. De HTTP/2-implementatie van NodeJS [ondersteunt bijvoorbeeld geen prioritering](https://x.com/jasnell/status/1245410283582918657).

### Vaarwel server push?

Server push was een van de extra functies van HTTP/2 die voor enige verwarring en complexiteit zorgde om in de praktijk te implementeren. Push probeert te voorkomen dat een browser/cliënt moet wachten om een HTML-pagina te downloaden, die pagina te parsen en pas dan te ontdekken dat er extra bronnen nodig zijn (zoals een stylesheet), die op hun beurt moeten worden opgehaald en geparseerd om nog meer dependencies te ontdekken (zoals lettertypen). Al dat werk en rondreizen kost tijd. Met server push kan de server in theorie gewoon meerdere reacties tegelijk verzenden, waardoor extra roundtrips worden vermeden.

Helaas, met TCP-congestiecontrole in het spel, begint de gegevensoverdracht zo langzaam dat <a hreflang="en" href="https://calendar.perfplanet.com/2016/http2-push-the-details/">niet alle activa kan worden gepusht</a> totdat meerdere roundtrips de overdrachtssnelheid voldoende hebben verhoogd. Er zijn ook <a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">implementatieverschillen</a> tussen browsers als het cliëntverwerkingsmodel niet volledig was overeengekomen. Elke browser heeft bijvoorbeeld een andere implementatie van een _push cache_.

Een ander probleem is dat de server niet weet welke bronnen de browser al in de cache heeft opgeslagen. Wanneer een server iets probeert te pushen dat ongewenst is, kan de cliënt een `RST_STREAM` frame verzenden, maar tegen de tijd dat dit is gebeurd, heeft de server mogelijk al alle gegevens verzonden. Dit verspilt bandbreedte en de server heeft de mogelijkheid verloren om onmiddellijk iets te verzenden dat de browser echt nodig had. Er waren <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-httpbis-cache-digest-05">voorstellen</a> om klanten in staat te stellen de server te informeren over hun cachestatus, maar deze leden aan privacyproblemen.

Zoals te zien is in figuur 20.17 hieronder, gebruikt een zeer klein percentage van de sites server push.

<figure>
  <table>
    <thead>
      <tr>
        <th>Cliënt</th>
        <th>HTTP/2 pagina's</th>
        <th>HTTP/2 (%)</th>
        <th>gQUIC pagina's</th>
        <th>gQUIC (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">44.257</td>
        <td class="numeric">0,85%</td>
        <td class="numeric">204</td>
        <td class="numeric">0,04%</td>
      </tr>
      <tr>
        <td>Mobiel</td>
        <td class="numeric">62.849</td>
        <td class="numeric">1,06%</td>
        <td class="numeric">326</td>
        <td class="numeric">0,06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Pagina's die HTTP/2 of gQUIC server push gebruiken.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

Als we verder kijken naar de verdelingen voor gepushte activa in figuur 22.18 en 22.19, pusht de helft van de sites 4 of minder bronnen met een totale grootte van 140 KB op desktop en 3 of minder bronnen met een grootte van 184 KB op mobiel. Voor gQUIC is desktop 7 of minder en mobiel 2. De ergste beledigende pagina duwt _41 activa_ over gQUIC op desktop.

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentiel</th>
        <th>HTTP/2</th>
        <th>Grootte (KB)</th>
        <th>gQUIC</th>
        <th>Grootte (KB)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">1</td>
        <td class="numeric">3,95</td>
        <td class="numeric">1</td>
        <td class="numeric">15,83</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">2</td>
        <td class="numeric">36,32</td>
        <td class="numeric">3</td>
        <td class="numeric">35,93</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">4</td>
        <td class="numeric">139,58</td>
        <td class="numeric">7</td>
        <td class="numeric">111,96</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">8</td>
        <td class="numeric">346,70</td>
        <td class="numeric">21</td>
        <td class="numeric">203,59</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">17</td>
        <td class="numeric">440,08</td>
        <td class="numeric">41</td>
        <td class="numeric">390,91</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distributie van gepushte middelen op desktop.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentiel</th>
        <th>HTTP/2</th>
        <th>Grootte (KB)</th>
        <th>gQUIC</th>
        <th>Grootte (KB)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">1</td>
        <td class="numeric">15,48</td>
        <td class="numeric">1</td>
        <td class="numeric">0,06</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">1</td>
        <td class="numeric">36,34</td>
        <td class="numeric">1</td>
        <td class="numeric">0,06</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">3</td>
        <td class="numeric">183,83</td>
        <td class="numeric">2</td>
        <td class="numeric">24,06</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">10</td>
        <td class="numeric">225,41</td>
        <td class="numeric">5</td>
        <td class="numeric">204,65</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">12</td>
        <td class="numeric">351,05</td>
        <td class="numeric">18</td>
        <td class="numeric">453,57</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distributie van gepushte activa op mobiel.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

Als we kijken naar de frequentie van push per inhoudstype in figuur 22.20, zien we 90% van de pagina's scripts pushen en 56% CSS. Dit is logisch, aangezien dit kleine bestanden kunnen zijn die zich doorgaans op het kritieke pad bevinden om een pagina weer te geven.

{{ figure_markup(
  image="http2-pushed-content-types.png",
  caption="Percentage pagina's dat specifieke inhoudstypen pusht",
  description="Een staafdiagram voor pagina's die bronnen op desktop pushen; pusht 89,1% scripts, 67,9% css, 6,1% afbeeldingen, 1,3% lettertypen, 0,7% overige en 0,7% html. Op mobiel pusht 90,29% scripts, 56,08% css, 3,69% afbeeldingen, 0,97% lettertypen, 0,36% overige en 0,39% html.", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1708672642&format=interactive",
  sheets_gid="238923402",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_by_content_type.sql"
)
}}

Gezien de lage acceptatie en na te hebben gemeten hoe weinig van de gepushte bronnen daadwerkelijk nuttig zijn (dat wil zeggen, ze komen overeen met een verzoek dat nog niet in de cache is opgeslagen), heeft Google de <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ">intentie om push-ondersteuning van Chrome te verwijderen</a> voor zowel HTTP/2 als gQUIC. Chrome heeft ook geen push geïmplementeerd voor HTTP/3.

Ondanks al deze problemen zijn er omstandigheden waarin server push voor verbetering kan zorgen. De ideale use case is om een pushbelofte veel eerder te kunnen verzenden dan de HTML-respons zelf. Een scenario waarin dit kan profiteren is <a hreflang="en" href="https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317"> wanneer een CDN in gebruik is</a>. De "dode tijd" tussen het CDN dat het verzoek ontvangt en het ontvangen van een antwoord van de oorsprong kan intelligent worden gebruikt om de TCP-verbinding op te warmen en activa te pushen die al in de cache zijn opgeslagen op het CDN.

Er was echter geen gestandaardiseerde methode om aan een CDN-edge-server te signaleren dat een activa moest worden gepusht. Implementaties hebben in plaats daarvan de vooraf geladen HTTP-link-header hergebruikt om dit aan te geven. Deze eenvoudige benadering lijkt elegant, maar maakt geen gebruik van de dode tijd voordat de HTML wordt gegenereerd, tenzij de headers worden verzonden voordat de daadwerkelijke inhoud gereed is. Het triggert de edge om bronnen te pushen wanneer de HTML aan de rand wordt ontvangen, wat zal strijden met de levering van de HTML.

Een alternatief voorstel dat wordt getest, is <a hreflang="en" href="https://tools.ietf.org/html/rfc8297">RFC 8297</a>, dat een informatieve `103 (Early Hints)` reactie definieert . Hierdoor kunnen headers onmiddellijk worden verzonden, zonder dat u hoeft te wachten tot de server de volledige responsheaders heeft gegenereerd. Dit kan worden gebruikt door een oorsprong om gepushte bronnen naar een CDN voor te stellen, of door een CDN om de cliënt te waarschuwen voor bronnen die moeten worden opgehaald. Momenteel is de ondersteuning hiervoor vanuit zowel cliënt- als serverperspectief echter erg laag, <a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">maar blijft groeit</a>.

## Op weg naar een beter protocol

Laten we zeggen dat een cliënt en server zowel HTTP/1.1 als HTTP/2 ondersteunen. Hoe kiezen ze welke ze willen gebruiken? De meest gebruikelijke methode is TLS [Application Layer Protocol Negotiation](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) (ALPN), waarbij cliënten een lijst met protocollen die ze ondersteunen naar de server sturen, die kiest voor degene die het bij voorkeur gebruikt voor die verbinding. Omdat de browser moet onderhandelen over de TLS-parameters als onderdeel van het opzetten van een HTTPS-verbinding, kan hij tegelijkertijd ook onderhandelen over de HTTP-versie. Omdat zowel HTTP/2 als HTTP/1.1 kunnen worden bediend vanaf dezelfde TCP-poort (443), hoeven browsers deze selectie niet te maken voordat een verbinding wordt geopend.

Dit werkt niet als de protocollen zich niet op dezelfde poort bevinden, een ander transportprotocol gebruiken (TCP versus QUIC) of als u geen TLS gebruikt. Voor die scenario's begint u met alles wat beschikbaar is op de eerste poort waarmee u verbinding maakt en ontdekt u vervolgens andere opties. HTTP definieert twee mechanismen om protocollen voor een oorsprong te wijzigen na verbinding: `Upgrade` en `Alt-Svc`.

### `Upgrade`

De Upgrade-header maakt al lange tijd deel uit van HTTP. In HTTP/1.x staat `Upgrade` een cliënt toe om een verzoek in te dienen met behulp van één protocol, maar de ondersteuning voor een ander protocol aan te geven (zoals HTTP/2). Als de server ook het aangeboden protocol ondersteunt, reageert deze met status 101 (`Switching Protocols`) en gaat verder met het beantwoorden van het verzoek in het nieuwe protocol. Als dit niet het geval is, beantwoordt de server het verzoek in HTTP/1.x. Servers kunnen hun ondersteuning van een ander protocol adverteren met behulp van een `Upgrade`-header bij een antwoord.

De meest voorkomende toepassing van `Upgrade` is [WebSockets](https://developer.mozilla.org/docs/Web/API/WebSockets_API). HTTP/2 definieert ook een `Upgrade`-pad, voor gebruik met zijn niet-versleutelde cleartext-modus. Er is echter geen ondersteuning voor deze mogelijkheid in webbrowsers. Daarom is het niet verwonderlijk dat minder dan 3% van de cleartext HTTP/1.1-verzoeken in onze dataset een `Upgrade`-header in het antwoord ontving. Een zeer klein aantal verzoeken met behulp van TLS (0,0011% van HTTP/2, 0,064% van HTTP/1.1) ontving ook `Upgrade`-headers als reactie; dit zijn waarschijnlijk duidelijke HTTP/1.1-servers achter tussenpersonen die HTTP/2 spreken en/of TLS beëindigen, maar de `Upgrade`-headers niet correct verwijderen.

### Alternative Services

Alternative Services (`Alt-Svc`) stelt een HTTP-oorsprong in staat om andere eindpunten aan te duiden die dezelfde inhoud bedienen, mogelijk via verschillende protocollen. Hoewel ongebruikelijk, kan HTTP/2 zich op een andere poort of een andere host bevinden dan de HTTP/1.1-service van een site. Wat nog belangrijker is, aangezien HTTP/3 QUIC gebruikt (vandaar UDP) waar eerdere versies van HTTP TCP gebruiken, zal HTTP/3 zich altijd op een ander eindpunt bevinden dan de HTTP/1.x- en HTTP/2-service.

Bij gebruik van `Alt-Svc`, doet een cliënt zoals normaal verzoeken aan de oorsprong. Als de server echter een header bevat of een frame met een lijst met alternatieven verzendt, kan de cliënt een nieuwe verbinding maken met het andere eindpunt en deze gebruiken voor toekomstige verzoeken naar die oorsprong.

Het is niet verwonderlijk dat het gebruik van `Alt-Svc` bijna volledig wordt gevonden in services die geavanceerde HTTP-versies gebruiken: 12,0% van de HTTP/2-verzoeken en 60,1% van de gQUIC-verzoeken ontving een `Alt-Svc`-header als reactie, in vergelijking met 0,055% van HTTP/1.x-verzoeken. Merk op dat onze methodologie hier alleen `Alt-Svc`-headers vastlegt, niet `ALTSVC`-frames in HTTP/2, dus de realiteit kan enigszins onderschat zijn.

Hoewel `Alt-Svc` naar een geheel andere host kan verwijzen, verschilt de ondersteuning voor deze mogelijkheid per browser. Slechts 4,71% van de `Alt-Svc` headers adverteerde een eindpunt op een andere hostnaam; dit waren bijna universeel (99,5%) advertenties voor gQUIC- en HTTP/3-ondersteuning op Google Ads. Google Chrome negeert cross-host `Alt-Svc`-advertenties voor HTTP/2, dus veel van de andere instanties zouden zijn genegeerd.

Gezien de zeldzaamheid van ondersteuning voor cross-host HTTP/2, is het niet verwonderlijk dat er vrijwel geen (0,007%) advertenties waren voor HTTP/2-eindpunten met behulp van `Alt-Svc`. `Alt-Svc` werd typisch gebruikt om ondersteuning voor HTTP/3 (74,6% van `Alt-Svc` headers) of gQUIC (38,7% van `Alt-Svc` headers) aan te geven.

## Kijkend naar de toekomst: HTTP/3

HTTP/2 is een krachtig protocol dat in slechts een paar jaar tijd aanzienlijk is toegepast. HTTP/3 over QUIC gluurt echter al om de hoek! Na meer dan vier jaar in de maak is deze volgende versie van HTTP bijna gestandaardiseerd op de IETF (verwacht in de eerste helft van 2021). Op dit moment zijn er al <a hreflang="en" href="https://github.com/quicwg/base-drafts/wiki/Implementations">veel QUIC- en HTTP/3-implementaties beschikbaar</a>, beide voor servers en browsers. Hoewel deze relatief volwassen zijn, kan nog steeds worden gezegd dat ze zich in een experimentele staat bevinden.

Dit wordt weerspiegeld door de gebruiksnummers in de HTTP Archive-gegevens, waar helemaal geen HTTP/3-verzoeken werden geïdentificeerd. Dit lijkt misschien een beetje vreemd, aangezien <a hreflang="en" href="https://blog.cloudflare.com/experiment-with-http-3-using-nginx-and-quiche/">Cloudflare</a> al enige tijd experimentele HTTP/3-ondersteuning heeft, net als Google en Facebook. Dit komt voornamelijk omdat Chrome het protocol niet standaard had ingeschakeld toen de gegevens werden verzameld.

Maar zelfs de cijfers voor de oudere gQUIC zijn relatief bescheiden, goed voor minder dan 2% van de verzoeken in totaal. Dit wordt verwacht, aangezien gQUIC grotendeels werd ingezet door Google en Akamai; andere partijen wachtten op IETF QUIC. Als zodanig wordt verwacht dat gQUIC binnenkort volledig wordt vervangen door HTTP/3.

{{ figure_markup(
  caption="Het percentage verzoeken dat gQUIC gebruikt op desktop en mobiel",
  content="1,72%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

Het is belangrijk op te merken dat deze lage acceptatie alleen het gebruik van gQUIC en HTTP/3 voor het laden van webpagina's weerspiegelt. Facebook heeft al een aantal jaren een veel uitgebreider gebruik van IETF QUIC en HTTP/3 voor het laden van gegevens in zijn eigen applicaties. <a hreflang="en" href="https://engineering.fb.com/2020/10/21/networking-traffic/how-facebook-is-bringing-quic-to-billions/">QUIC en HTTP/3 maken al meer dan 75% van hun totale internetverkeer</a> uit. Het is duidelijk dat HTTP/3 nog maar net is begonnen!

Nu vraagt u u misschien af: als niet iedereen al HTTP/2 gebruikt, waarom zouden we dan zo snel HTTP/3 nodig hebben? Welke voordelen kunnen we in de praktijk verwachten? Laten we de interne mechanismen eens nader bekijken.

### QUIC en HTTP/3

Eerdere pogingen om nieuwe transportprotocollen op internet in te zetten zijn moeilijk gebleken, bijvoorbeeld [Stream Control Transmission Protocol](https://nl.wikipedia.org/wiki/Stream_Control_Transmission_Protocol) (SCTP). QUIC is een nieuw transportprotocol dat bovenop UDP draait. Het biedt vergelijkbare functies als TCP, zoals betrouwbare levering op volgorde en congestiecontrole om overstroming van het netwerk te voorkomen.

Zoals besproken in de sectie [HTTP/1.0 tot HTTP/2](#http10-naar-http2), HTTP/2 _multiplext_ meerdere verschillende streams bovenop één verbinding. TCP zelf is zich hier jammerlijk niet van bewust, wat leidt tot inefficiënties of invloed op de prestaties wanneer pakketverlies of vertragingen optreden. Meer informatie over dit probleem, bekend als _head-of-line blocking_ (HOL-blokkering), <a hreflang="en" href="https://github.com/rmarx/holblocking-blogpost">is hier te vinden</a>.

QUIC lost het HOL-blokkeerprobleem op door HTTP/2-streams naar de transportlaag te brengen en verliesdetectie en hertransmissie per stream uit te voeren. Dus dan zetten we HTTP/2 gewoon over QUIC, toch? Welnu, we hebben enkele van de moeilijkheden die ontstaan door het hebben van flow control in TCP en HTTP/2 [al genoemd](#verbindingen-verminderen). Het zou een bijkomend probleem zijn om twee afzonderlijke en concurrerende streaming-systemen op elkaar te laten draaien. Bovendien, omdat de QUIC-streams onafhankelijk zijn, zou het knoeien met de strikte bestelvereisten die HTTP/2 vereist voor verschillende van zijn systemen.

Uiteindelijk werd het gemakkelijker geacht om een nieuwe HTTP-versie te definiëren die QUIC direct gebruikt en zo werd HTTP/3 geboren. De functies op hoog niveau lijken erg op die we kennen van HTTP/2, maar de interne implementatiemechanismen zijn behoorlijk verschillend. HPACK-headercompressie is vervangen door <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-quic-qpack-19">QPACK</a>, waardoor <a hreflang="en" href="https://blog.litespeedtech.com/tag/quic-header-compression-design-team/">handmatige afstemming</a> van de afweging tussen compressie-efficiëntie en HOL-blokkeerrisico, en de prioriteitstelling systeem wordt <a hreflang="en" href="https://blog.cloudflare.com/adopting-a-new-approach-to-http-prioritization/">vervangen door een eenvoudigere</a>. Dit laatste kan ook worden teruggevoerd naar HTTP/2, wat mogelijk helpt bij het oplossen van de prioriteitsproblemen die eerder in dit artikel zijn besproken. HTTP/3 blijft een server-push-mechanisme bieden, maar Chrome implementeert het bijvoorbeeld niet.

Een ander voordeel van QUIC is dat het in staat is om verbindingen te migreren en ze in leven te houden, zelfs wanneer het onderliggende netwerk verandert. Een typisch voorbeeld is het zogenaamde "parkeerprobleem". Stelt u voor dat uw smartphone is verbonden met het wifi-netwerk op de werkplek en dat u net bent begonnen met het downloaden van een groot bestand. Als u het Wi-Fi-bereik verlaat, schakelt uw telefoon automatisch over naar het mooie nieuwe mobiele 5G-netwerk. Met gewoon oud TCP zou de verbinding verbreken en een onderbreking veroorzaken. Maar QUIC is slimmer; het gebruikt een _connection ID_, die robuuster is voor netwerkveranderingen, en biedt een actieve _connection migratie_ functie voor cliënten om zonder onderbreking te schakelen.

Ten slotte wordt TLS al gebruikt om HTTP/1.1 en HTTP/2 te beschermen. QUIC heeft echter een diepe integratie van TLS 1.3, waardoor zowel HTTP/3-gegevens als QUIC-pakketmetagegevens, zoals pakketnummers, worden beschermd. Door TLS op deze manier te gebruiken, wordt de privacy en beveiliging van de eindgebruiker verbeterd en wordt de voortdurende evolutie van het protocol eenvoudiger. De combinatie van transport en cryptografische handshakes betekent dat het opzetten van een verbinding slechts één RTT vereist, vergeleken met het minimum van twee van TCP en het slechtste geval van vier. In sommige gevallen kan QUIC zelfs nog een stap verder gaan en HTTP-gegevens verzenden samen met het allereerste bericht, genaamd _0-RTT_. Van deze snelle verbindingstijden wordt verwacht dat ze HTTP/3 echt helpen beter te presteren dan HTTP/2.

**Dus, zal HTTP/3 helpen?**

Op het eerste gezicht verschilt HTTP/3 niet zo heel veel van HTTP/2. Het voegt geen belangrijke functies toe, maar verandert voornamelijk hoe de bestaande onder de oppervlakte werken. De echte verbeteringen zijn afkomstig van QUIC, dat snellere verbindingsopstellingen, grotere robuustheid en veerkracht bij pakketverlies biedt. Als zodanig wordt verwacht dat HTTP/3 het beter doet dan HTTP/2 op slechtere netwerken, terwijl het vergelijkbare prestaties biedt op snellere systemen. Als de webgemeenschap echter HTTP/3 kan laten werken, kan dat in de praktijk een uitdaging zijn.

### HTTP/3 implementeren en ontdekken

Omdat QUIC en HTTP/3 over UDP draaien, is het niet zo eenvoudig als met HTTP/1.1 of HTTP/2. Meestal moet een HTTP/3-cliënt eerst ontdekken dat QUIC beschikbaar is op de server. De aanbevolen methode hiervoor is [HTTP Alternative Services](#alternative-services). Bij het eerste bezoek aan een website maakt een cliënt via TCP verbinding met een server. Het ontdekt dan via `Alt-Svc` dat HTTP/3 beschikbaar is, en kan een nieuwe QUIC-verbinding opzetten. De `Alt-Svc`-vermelding kan in de cache worden opgeslagen, waardoor volgende bezoeken de TCP-stap kunnen vermijden, maar de vermelding zal uiteindelijk verouderd worden en moet opnieuw worden gevalideerd. Dit zal waarschijnlijk voor elk domein afzonderlijk moeten worden gedaan, wat waarschijnlijk zal leiden tot het laden van de meeste pagina's met een combinatie van HTTP/1.1, HTTP/2 en HTTP/3.

Maar zelfs als bekend is dat een server QUIC en HTTP/3 ondersteunt, kan het netwerk ertussen het blokkeren. UDP-verkeer wordt veel gebruikt bij DDoS-aanvallen en wordt standaard geblokkeerd in bijvoorbeeld veel bedrijfsnetwerken. Hoewel er uitzonderingen kunnen worden gemaakt voor QUIC, maakt de versleuteling ervan het moeilijk voor firewalls om het verkeer te beoordelen. Er zijn mogelijke oplossingen voor deze problemen, maar in de tussentijd wordt verwacht dat QUIC het meest waarschijnlijk zal slagen op bekende poorten zoals 443. En het is heel goed mogelijk dat QUIC helemaal wordt geblokkeerd. In de praktijk zullen klanten waarschijnlijk geavanceerde mechanismen gebruiken om terug te vallen op TCP als QUIC faalt. Een optie is om zowel een TCP- als een QUIC-verbinding te "racen" en degene te gebruiken die het eerst voltooit.

Er wordt gewerkt aan het definiëren van manieren om HTTP/3 te ontdekken zonder dat de TCP-stap nodig is. Dit moet echter als een optimalisatie worden beschouwd, omdat de problemen met het blokkeren van UDP waarschijnlijk betekenen dat op TCP gebaseerde HTTP blijft hangen. De <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-dnsop-svcb-https">HTTPS DNS-record</a> is vergelijkbaar met HTTP Alternative Services en sommige CDN's zijn al <a hreflang="en" href="https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/">aan het experimenteren met deze records</a>. Op de lange termijn, wanneer de meeste servers HTTP/3 aanbieden, kunnen browsers overschakelen naar een standaard poging dat te doen; dat zal lang duren.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">HTTP/1.x</th>
        <th scope="colgroup" colspan="2">HTTP/2</th>
      </tr>
      <tr>
        <th scope="col">TLS versie</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobiel</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>onbekend</td>
        <td class="numeric">4,06%</td>
        <td class="numeric">4,03%</td>
        <td class="numeric">5,05%</td>
        <td class="numeric">7,28%</td>
      </tr>
      <tr>
        <td>TLS 1.2</td>
        <td class="numeric">26,56%</td>
        <td class="numeric">24,75%</td>
        <td class="numeric">23,12%</td>
        <td class="numeric">23,14%</td>
      </tr>
      <tr>
        <td>TLS 1.3</td>
        <td class="numeric">5,25%</td>
        <td class="numeric">5,11%</td>
        <td class="numeric">35,78%</td>
        <td class="numeric">35,54%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="TLS-acceptatie door HTTP-versie.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

QUIC is afhankelijk van TLS 1.3, dat wordt gebruikt voor ongeveer 41% van de verzoeken, zoals weergegeven in figuur 22.21. Dat laat 59% van de verzoeken over die hun TLS-stack moeten bijwerken om HTTP/3 te ondersteunen.

### Is HTTP/3 al klaar?

Dus, wanneer kunnen we HTTP/3 en QUIC echt gaan gebruiken? Nog niet helemaal, maar hopelijk binnenkort. Er is een <a hreflang="en" href="https://github.com/quicwg/base-drafts/wiki/Implementations">groot aantal volwassen open source-implementaties</a> en de belangrijkste browsers hebben experimentele ondersteuning. De meeste typische servers hebben echter wat vertraging opgelopen: nginx loopt een beetje achter op andere stacks, Apache heeft geen officiële ondersteuning aangekondigd en NodeJS vertrouwt op OpenSSL, dat <a hreflang="en" href="https://github.com/openssl/openssl/pull/8797">binnenkort geen QUIC-ondersteuning zal toevoegen</a>. Toch verwachten we dat het aantal HTTP/3- en QUIC-implementaties in 2021 zal toenemen.

HTTP/3 en QUIC zijn zeer geavanceerde protocollen met krachtige prestatie- en beveiligingsfuncties, zoals een nieuw HTTP-prioriteitssysteem, verwijdering van HOL-blokkering en het tot stand brengen van 0-RTT-verbindingen. Deze verfijning maakt het ook moeilijk om ze correct te implementeren en te gebruiken, zoals het geval is gebleken voor HTTP/2. We voorspellen dat vroege implementaties voornamelijk zullen plaatsvinden via de vroege acceptatie van CDN's zoals Cloudflare, Fastly en Akamai. Dit zal waarschijnlijk betekenen dat een groot deel van het HTTP/2-verkeer in 2021 automatisch kan en zal worden geüpgraded naar HTTP/3, waardoor het nieuwe protocol bijna uit de doos een groot verkeersaandeel krijgt. Wanneer en of kleinere implementaties zullen volgen, is moeilijker te beantwoorden. Hoogstwaarschijnlijk zullen we de komende jaren een gezonde mix van HTTP/3, HTTP/2 en zelfs HTTP/1.1 op internet blijven zien.

## Gevolgtrekking

Dit jaar is HTTP/2 het dominante protocol geworden, dat 64% van alle verzoeken bedient, en in de loop van het jaar met 10 procentpunten is gegroeid. Startpagina's hebben een toename van 13% in HTTP/2-acceptatie gezien, wat heeft geleid tot een gelijkmatige opsplitsing van pagina's die worden bediend via HTTP/1.1 en HTTP/2. Het gebruik van een CDN om uw startpagina te bedienen, verhoogt de acceptatie van HTTP/2 tot 80%, vergeleken met 30% voor niet-CDN-gebruik. Er zijn nog enkele oudere servers, Apache en IIS, die resistent blijken te zijn tegen upgraden naar HTTP/2 en TLS. Een groot succes is de afname van het gebruik van websiteverbindingen als gevolg van HTTP/2-verbindingsmultiplexing. Het mediane aantal aansluitingen in 2016 was 23 ten opzichte van 13 in 2020.

HTTP/2-prioriteitstelling en server push zijn veel complexer gebleken om in het algemeen te implementeren. Bij bepaalde implementaties laten ze duidelijke prestatievoordelen zien. Er is echter een aanzienlijke belemmering voor het inzetten en afstemmen van bestaande servers om deze functies effectief te gebruiken. Er is nog steeds een groot deel van de CDN's die het stellen van prioriteiten niet effectief ondersteunen. Er zijn ook problemen met consistente browserondersteuning.

HTTP/3 is net om de hoek. Het zal fascinerend zijn om de acceptatiegraad te volgen, te zien hoe ontdekkingsmechanismen evolueren en erachter te komen welke nieuwe functies met succes zullen worden geïmplementeerd. We verwachten dat de Web Almanac van volgend jaar interessante nieuwe gegevens zal bevatten.
