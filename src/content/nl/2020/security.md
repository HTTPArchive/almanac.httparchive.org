---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Beveiliging
description: Beveiligingshoofdstuk van de Web Almanac 2020 met informatie over transportlaagbeveiliging, inhoudsbeveiliging (CSP, functiebeleid, SRI), webbeschermingsmechanismen (aanpakken van XSS, XS-Leaks) en updatepraktijken van veelgebruikte technologieën.
hero_alt: Hero image of Web Almanac characters padlocking a web page, while other Web Almanac characters subdue a masked thief who has a set of bolt cutters.
authors: [tomvangoethem, nrllh, tunetheweb]
reviewers: [cqueern, edmondwwchan]
analysts: [tomvangoethem, nrllh]
editors: [tunetheweb]
translators: [noah-vdv]
tomvangoethem_bio: Tom Van Goethem is onderzoeker bij de <a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet groep</a> van de universiteit van Leuven, België. Zijn onderzoek is gericht op het ontdekken van nieuwe side-channel aanvallen op het web die tot beveiligings- of privacyproblemen leiden, en op het oplossen van de lekken die deze veroorzaken.
nrllh_bio: Nurullah Demir is een beveiligingsonderzoeker en PhD-student bij <a hreflang="en" href="https://www.internet-sicherheit.de/en/"><span>Institute for Internet Security</span></a>. Zijn onderzoek richt zich op robuuste webbeveiligingsmechanismen en vijandige machine learning.
tunetheweb_bio: Barry Pollard is een softwareontwikkelaar en auteur van het Manning-boek <a hreflang="en" href="https://www.manning.com/books/http2-in-action">HTTP/2 in Action</a>. Hij vindt het web geweldig, maar wil het nog beter maken. U kunt hem vinden op <a href="https://x.com/tunetheweb">@tunetheweb</a> en op zijn blog <a hreflang="en" href="https://www.tunetheweb.com">www.tunetheweb.com</a>.
discuss: 2047
results: https://docs.google.com/spreadsheets/d/1T7sxPP5BV3uwv-sXhBEZraVk-obd0tDfFrLiD49nZC0/
featured_quote: In dit hoofdstuk verkennen we de huidige stand van zaken voor beveiliging op het web. Door de acceptatie van verschillende beveiligingsfuncties diepgaand en op grote schaal te analyseren, verzamelen we inzichten over de verschillende manieren waarop website-eigenaren deze beveiligingsmechanismen toepassen, gedreven door de prikkel om hun gebruikers te beschermen.
featured_stat_1: 86,90%
featured_stat_label_1: Verzoeken die HTTPS gebruiken op mobiele apparaten
featured_stat_2: 22.333
featured_stat_label_2: Bytes in de langst waargenomen CSP
featured_stat_3: 9,03%
featured_stat_label_3: Gebruik van reCAPTCHA
---

## Inleiding

In veel opzichten was 2020 een buitengewoon jaar. Als gevolg van de wereldwijde pandemie is ons dagelijks leven drastisch veranderd. In plaats van elkaar persoonlijk te ontmoeten met vrienden en familie, moeten velen op sociale media vertrouwen om contact te houden. Dit heeft geleid tot een aanzienlijke <a hreflang="en" href="https://dl.acm.org/doi/pdf/10.1145/3419394.3423621">toename in verkeersvolumes</a> voor <a hreflang="en" href="https://arxiv.org/pdf/2008.10959.pdf">veel verschillende toepassingen</a>, als gevolg van de toegenomen hoeveelheid tijd die gebruikers online doorbrengen. Dit betekent ook dat beveiliging nog nooit zo belangrijk is geweest om ervoor te zorgen dat de informatie die we online delen op verschillende platforms veilig blijft.

Veel van de platforms en services die we dagelijks gebruiken, zijn sterk afhankelijk van webbronnen, variërend van cloudgebaseerde API's, microservices en vooral webapplicaties. Het beveiligen van deze systemen is een niet-triviale taak. Gelukkig is het afgelopen decennium het onderzoek naar webbeveiliging voortdurend vooruitgegaan. Enerzijds ontdekken onderzoekers nieuwe soorten aanvallen en delen de resultaten met de bredere gemeenschap om het bewustzijn te vergroten. Aan de andere kant hebben veel ingenieurs en ontwikkelaars onvermoeibaar gewerkt om websitebeheerders te voorzien van de juiste hulpmiddelen en mechanismen die kunnen worden gebruikt om de gevolgen van aanvallen te voorkomen of te minimaliseren.

In dit hoofdstuk verkennen we de huidige stand van zaken voor beveiliging op het web. Door de acceptatie van verschillende beveiligingsfuncties diepgaand en op grote schaal te analyseren, verzamelen we inzichten over de verschillende manieren waarop website-eigenaren deze beveiligingsmechanismen toepassen, gedreven door de prikkel om hun gebruikers te beschermen.

We kijken niet alleen naar de acceptatie van beveiligingsmechanismen op individuele websites. We analyseren hoe verschillende factoren, zoals de technologiestack die wordt gebruikt om een website te bouwen, de prevalentie van beveiligingsheaders beïnvloeden en zo de algehele beveiliging verbeteren. Bovendien is het veilig om te zeggen dat om ervoor te zorgen dat een website veilig is, een holistische benadering nodig is die veel verschillende facetten omvat. Daarom evalueren we ook andere aspecten, zoals de patchpraktijken voor verschillende veelgebruikte webtechnologieën.

### Methodologie

In dit hoofdstuk rapporteren we over de invoering van verschillende beveiligingsmechanismen op internet. Deze analyse is gebaseerd op gegevens die zijn verzameld voor de startpagina van 5,6 miljoen desktopdomeinen en 6,3 miljoen mobiele domeinen. Tenzij expliciet anders vermeld, zijn de gerapporteerde cijfers gebaseerd op de mobiele dataset, aangezien deze groter is. Omdat de meeste websites in beide datasets zijn opgenomen, zijn de resulterende metingen grotendeels vergelijkbaar. Elk significant verschil tussen de twee datasets wordt in de hele tekst vermeld of blijkt uit de figuren. Raadpleeg de [Methodologie](./methodology) voor meer informatie over hoe de gegevens zijn verzameld.

## Transportbeveiliging

Het afgelopen jaar is de groei van HTTPS op websites voortgezet. Het beveiligen van de transportlaag is een van de belangrijkste onderdelen van webbeveiliging - tenzij u er zeker van kunt zijn dat de bronnen die voor een website zijn gedownload tijdens het transport niet zijn gewijzigd en dat u gegevens van en naar de website vervoert, zekerheden over de beveiliging van de website worden feitelijk nietig verklaard.

Het verplaatsen van ons webverkeer naar HTTPS, en uiteindelijk <a hreflang="en" href="https://www.chromium.org/Home/chromium-security/marking-http-as-non-secure">HTTP markeren als niet-beveiligd</a> wordt aangestuurd door webbrowsers die [krachtige nieuwe functies beperken tot de beveiligde context](https://developer.mozilla.org/docs/Web/Security/Secure_Contexts/features_restricted_to_secure_contexts) (de wortel), terwijl er ook meer waarschuwingen worden getoond aan gebruikers wanneer niet-versleutelde verbindingen worden gebruikt (de stok).

{{ figure_markup(
  caption="Het percentage verzoeken dat HTTPS op mobiele apparaten gebruikt.",
  content="86,90%",
  classes="big-number",
  sheets_gid="1558058913"
)
}}

De inspanning werpt zijn vruchten af en we zien nu dat 87,70% van de verzoeken op desktops en 86,90% van de verzoeken op mobiele apparaten via HTTPS worden bediend.

{{ figure_markup(
  image="security-https-request-growth.png",
  caption='Percentage verzoeken dat HTTPS gebruikt.<br>(Bron: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">HTTP Archive</a>)',
  description="Tijdreeksdiagram van HTTPS-verzoeken van 1 januari 2017 tot 1 augustus 2020. Het gebruik van mobiele telefoons en desktopcomputers is bijna identiek en begint bij 35,70% van de verzoeken voor desktop en 35,20% voor mobiel en stijgt helemaal tot 87,70% voor desktop en 86,90% voor mobiel met een lichte afname aan het einde.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1353660053&format=interactive",
  sheets_gid="1558058913"
  )
}}

Een kleine zorg nu we het einde van dit doel bereiken, is een merkbare "afvlakking" van de indrukwekkende groei van de afgelopen jaren. Helaas betekent de lange staart van internet dat oudere legacy-sites niet worden onderhouden en mogelijk nooit via HTTPS worden beheerd, wat betekent dat ze uiteindelijk ontoegankelijk zullen worden voor de meeste gebruikers.

{{ figure_markup(
  image="security-https-usage-by-site.png",
  caption="HTTPS-gebruik voor sites",
  description="Een staafdiagram laat zien dat 77,44% van de desktopsites HTTPS gebruikt, terwijl de resterende 22,56% HTTP gebruikt, terwijl 73,22% van de mobiele sites HTTPS gebruikt en de resterende 26,78% HTTP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=103775737&format=interactive",
  sheets_gid="1558058913",
  sql_file="home_page_https_usage.sql"
  )
}}

Hoewel het grote aantal verzoeken bemoedigend is, worden deze vaak gedomineerd door verzoeken van [derde partijen](./third-parties) en diensten zoals Google Analytics, fonts of advertisements. Websites zelf kunnen achterblijven, maar opnieuw zien we bemoedigend gebruik: tussen de 73% en 77% van de sites wordt nu bediend via HTTPS.

### Protocolversies

Omdat HTTPS nu echt de norm is, verschuift de uitdaging van het hebben van elke vorm van HTTPS naar het waarborgen dat veilige versies van het onderliggende TLS-protocol (<span lang="en">Transport Layer Security</span>) worden gebruikt. TLS heeft onderhoud nodig naarmate versies ouder worden, kwetsbaarheden worden gevonden en de rekenkracht toeneemt, waardoor aanvallen beter haalbaar zijn.

{{ figure_markup(
  image="security-tls-version-by-site.png",
  caption="Gebruik van TLS-versies voor sites",
  description="Staafdiagram dat laat zien dat op desktop 55,98% van de sites TLSv1.2 gebruikt, terwijl 43,23% TLSv1.3 gebruikt. Op mobiel zijn de cijfers respectievelijk 53,82% en 45,37%. TLSv1.0, TLSv1.1 registreren nauwelijks, hoewel er een zeer kleine hoeveelheid QUIC-gebruik is (0,62% op desktop en 0,67% op mobiel).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=840326541&format=interactive",
  sheets_gid="1486844039",
  sql_file="tls_versions_pages.sql"
  )
}}

Het gebruik van TLSv1.0 is in principe al nul en hoewel het misschien bemoedigend lijkt dat het openbare web zo definitief veiligere protocollen heeft omarmd, moet worden opgemerkt dat alle reguliere browsers, inclusief Chrome waarop onze crawl is gebaseerd, dit standaard blokkeren, wat dit grotendeels verklaart.

Deze cijfers zijn een lichte verbetering ten opzichte van [de protocolanalyse van vorig jaar] (../2019/security#protocol-versions) met een stijging van ongeveer 5% in het gebruik van TLSv1.3 en de overeenkomstige daling in TLSv1.2. Dat lijkt een kleine toename en het lijkt erop dat het hoge gebruik van de relatief nieuwe TLSv1.3 die vorig jaar werd genoteerd waarschijnlijk te wijten was aan de aanvankelijke steun van grote CDN's. Daarom zal het waarschijnlijk lang duren om meer vooruitgang te boeken bij de acceptatie van TLSv1.3, aangezien degenen die nog steeds TLSv1.2 gebruiken dit mogelijk zelf beheren of bij een hostingprovider die dit nog niet ondersteunt.

### Cijferreeksen

Binnen TLS zijn er een aantal coderingssuites die kunnen worden gebruikt met verschillende beveiligingsniveaus. De beste cijfers ondersteunen [voorwaartse geheimhouding (forward secrecy)](https://nl.wikipedia.org/wiki/Perfect_forward_secrecy) sleuteluitwisseling, wat betekent dat zelfs als de serversleutels gecompromitteerd zijn, oud verkeer dat die sleutels gebruikte niet kan worden gedecodeerd.

In het verleden hebben nieuwere versies van TLS ondersteuning voor nieuwere coderingen toegevoegd, maar oudere versies zijn zelden verwijderd. Dit is een van de redenen waarom TLSv1.3 veiliger is omdat het momenteel een groot aantal oudere cijfers opruimt. De populaire OpenSSL-bibliotheek ondersteunt slechts vijf beveiligde coderingen in deze versie, die allemaal voorwaartse geheimhouding ondersteunen. Dit voorkomt downgrade-aanvallen waarbij een minder veilige code moet worden gebruikt.

{{ figure_markup(
  caption="Mobiele sites met voorwaartse geheimhouding.",
  content="98,03%",
  classes="big-number",
  sheets_gid="1643542759",
  sql_file="tls_forward_secrecy.sql"
)
}}

Alle sites zouden eigenlijk voorwaartse geheimhoudingscodes moeten gebruiken en het is goed om te zien dat 98,14% van de desktopsites en 98,03% van de mobiele sites cijfers met voorwaartse geheimhouding gebruiken.

Ervan uitgaande dat voorwaartse geheimhouding een gegeven is, is de belangrijkste keuze bij het selecteren van een cijfer tussen het versleutelingsniveau: het duurt langer voordat een hogere sleutel wordt verbroken, maar dit gaat ten koste van meer rekenintensief voor het versleutelen en ontsleutelen van de verbinding, vooral voor de eerste verbinding. Voor de [blokcoderingsmodus](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation) moet GCM worden gebruikt en <a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">CBC wordt als zwak beschouwd vanwege paddingaanvallen</a>.

Voor de veelgebruikte AES-coderingsstandaard (<span lang="en">Advanced Encryption Standard</span>) zijn sleutelgroottes van 128-bits en 256-bits codering gebruikelijk. 128-bits is nog steeds voldoende voor de meeste sites, hoewel 256-bits de voorkeur heeft.

{{ figure_markup(
  image="security-distribution-of-cipher-suites.png",
  caption="Verdeling van coderingssuites",
  description="Staafdiagram met de coderingssuites die door het apparaat worden gebruikt, waarbij AES_128_GCM de meest voorkomende is en wordt gebruikt door 78,4% van de desktop- en mobiele sites, AES_256_GCM wordt gebruikt door 19,1% van de desktop- en 18,5% van de mobiele sites, AES_256_CBC wordt gebruikt door 1,44% van de desktopsites en 1,86% van de mobiele sites, CHACHA20_POLY1305 wordt gebruikt door respectievelijk 0,66% en 0,72% van de sites, AES_128_CBC wordt gebruikt door respectievelijk 0,43% en 0,44% en 3DES_EDE_CBC wordt gebruikt door 0,01% van de desktop en ongeveer 0,0% van de mobiele apparaten.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1464905386&format=interactive",
  sheets_gid="1919501829",
  sql_file="tls_cipher_suite.sql"
  )
}}

We kunnen uit de bovenstaande grafiek zien dat AES_128_GCM de meest voorkomende is en wordt gebruikt door 78,4% van desktop- en mobiele sites. AES_256_GCM wordt gebruikt door 19,1% van de desktop- en 18,5% van de mobiele sites, terwijl de andere sites waarschijnlijk degenen zijn met oudere protocollen en coderingssuites.

Een belangrijk punt om op te merken is dat onze gegevens zijn gebaseerd op het uitvoeren van Chrome om verbinding te maken met een site, en dat het een enkel protocolcijfer zal gebruiken om verbinding te maken. Onze [methodologie](./methodology) staat ons niet toe om de volledige reeks ondersteunde protocollen en coderingssuites te zien, en alleen degene die daadwerkelijk voor die verbinding werd gebruikt. Voor die informatie zouden we naar andere bronnen moeten kijken, zoals <a hreflang="en" href="https://www.ssllabs.com/ssl-pulse/">SSL Pulse van SSL Labs</a>, maar aangezien de meeste moderne browsers nu vergelijkbare TLS-mogelijkheden ondersteunen, zijn de bovenstaande gegevens wat we van de overgrote meerderheid van de gebruikers zouden verwachten.

### Certificaatautoriteiten

Vervolgens zullen we kijken naar de certificaatautoriteiten (CA's) die de TLS-certificaten uitgeven die worden gebruikt door de sites die we hebben gecrawld. [Het hoofdstuk van vorig jaar](../2019/security#certificate-authorities) keek naar de verzoeken om deze gegevens, maar die zullen worden gedomineerd door populaire derde partijen zoals Google (die dit jaar ook weer domineren vanuit die statistiek), dus dit jaar gaan we de CA's presenteren die door de websites zelf worden gebruikt, in plaats van alle andere verzoeken die ze laden.

<figure>
  <table>
    <thead>
      <tr>
        <th>Uitgever</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><span lang="en">Let's Encrypt Authority X3</span></td>
        <td class="numeric">44,65%</td>
        <td class="numeric">46,42%</td>
      </tr>
      <tr>
        <td><span lang="en">Cloudflare Inc ECC CA-3</span></td>
        <td class="numeric">8,49%</td>
        <td class="numeric">8,69%</td>
      </tr>
      <tr>
        <td><span lang="en">Sectigo RSA Domain Validation Secure Server CA</span></td>
        <td class="numeric">8,27%</td>
        <td class="numeric">7,91%</td>
      </tr>
      <tr>
        <td><span lang="en">cPanel, Inc. Certification Authority</span></td>
        <td class="numeric">4,71%</td>
        <td class="numeric">5,06%</td>
      </tr>
      <tr>
        <td><span lang="en">Go Daddy Secure Certificate Authority - G2</span></td>
        <td class="numeric">4,30%</td>
        <td class="numeric">3,66%</td>
      </tr>
      <tr>
        <td>Amazon</td>
        <td class="numeric">3,12%</td>
        <td class="numeric">2,85%</td>
      </tr>
      <tr>
        <td><span lang="en">DigiCert SHA2 Secure Server CA</span></td>
        <td class="numeric">2,04%</td>
        <td class="numeric">1,78%</td>
      </tr>
      <tr>
        <td><span lang="en">RapidSSL RSA CA 2018</span></td>
        <td class="numeric">2,01%</td>
        <td class="numeric">1,96%</td>
      </tr>
      <tr>
        <td><span lang="en">Cloudflare Inc ECC CA-2</span></td>
        <td class="numeric">1,95%</td>
        <td class="numeric">1,70%</td>
      </tr>
      <tr>
        <td><span lang="en">AlphaSSL CA - SHA256 - G2</span></td>
        <td class="numeric">1,35%</td>
        <td class="numeric">1,30%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 10 uitgevers van certificaten voor websites.", sheets_gid="1486167130", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

Het is geen verrassing om te zien dat Let's Encrypt met een goede voorsprong gemakkelijk de eerste plaats inneemt; de combinatie van gratis en geautomatiseerde certificaten is een winnaar bij zowel individuele website-eigenaren als platforms. Cloudflare biedt op dezelfde manier gratis certificaten aan voor zijn cliënten die de nummer twee en nummer negen innemen. Wat daar interessanter is, is dat het de ECC Cloudflare-uitgever is die wordt gebruikt. ECC-certificaten zijn kleiner en dus efficiënter dan RSA-certificaten, maar kunnen gecompliceerd zijn om te implementeren omdat ondersteuning niet universeel is en het beheren van beide certificaten vaak extra inspanning vereist. Dit is het voordeel van een CDN of een gehoste provider als zij dit voor u kunnen beheren zoals Cloudflare hier doet. Browsers die ECC ondersteunen (zoals de Chrome-browser die we gebruiken in onze crawl) zullen dat gebruiken, en oudere browsers zullen RSA gebruiken.

### Browserhandhaving

Hoewel het hebben van een veilige TLS-configuratie van cruciaal belang is om u te beschermen tegen cryptografische aanvallen, zijn er nog steeds aanvullende beveiligingen nodig om internetgebruikers te beschermen tegen tegenstanders op het netwerk. Zodra de gebruiker bijvoorbeeld een website via HTTP laadt, kan een aanvaller schadelijke inhoud injecteren om bijvoorbeeld verzoeken aan andere sites te doen.

Zelfs wanneer sites de sterkste coderingen en nieuwste protocollen gebruiken, kan een tegenstander nog steeds SSL-strippingaanvallen gebruiken om de browser van het slachtoffer te laten geloven dat de verbinding via HTTP in plaats van HTTPS verloopt. Bovendien kunnen zonder voldoende bescherming de cookies van een gebruiker worden toegevoegd aan het initiële HTTP-verzoek in platte tekst, zodat de aanvaller ze op het netwerk kan onderscheppen.

Om deze problemen op te lossen, hebben browsers aanvullende functies geleverd die kunnen worden ingeschakeld om dit te voorkomen.

#### HTTP Strikte Transportbeveiliging (HTTP Strict Transport Security)

De eerste is HTTP Strict Transport Security (HSTS), die eenvoudig kan worden ingeschakeld door een antwoord header in te stellen die uit verschillende attributen bestaat. Voor deze header vinden we een acceptatiegraad van 16,88% binnen de mobiele startpagina's. Van de sites die HSTS inschakelen, doet 92,82% dit met succes. Dat wil zeggen, het kenmerk max-age (dat bepaalt hoeveel seconden de browser *alleen* de website via HTTPS mag bezoeken) heeft een waarde groter dan 0.

{{ figure_markup(
  image="security-hsts-max-age-values-in-days.png",
  caption="HSTS `max-age` waarden (in dagen).",
  description="Staafdiagram met percentielen van waarden in het kenmerk `max-age`, geconverteerd naar dagen. In het 10e percentiel is desktop 30 dagen en mobiel 91, in het 25e percentiel zijn beide 182 dagen, in het 50e percentiel zijn beide 365 dagen, het 75e percentiel is hetzelfde op 365 dagen voor beide en het 90e percentiel heeft 730 dagen voor beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1208109634&format=interactive",
  sheets_gid="236117763",
  sql_file="hsts_max_age_percentiles.sql"
) }}

Als we naar de verschillende waarden voor dit attribuut kijken, kunnen we duidelijk zien dat de meeste websites er zeker van zijn dat ze in de aanzienlijke toekomst over HTTPS zullen draaien: meer dan de helft vraagt de browser om HTTPS voor minstens 1 jaar te gebruiken.

{{ figure_markup(
  caption="De grootste bekende HSTS max-age.",
  content="1.000.000.000.000.000 jaar",
  classes="medium-number",
  sheets_gid="560555207",
  sql_file="hsts_attributes.sql"
)
}}

Eén website was misschien een beetje te enthousiast over hoe lang hun site beschikbaar zal zijn via HTTPS en stelt een 'max-age'-attribuutwaarde in die zich vertaalt naar 1.000.000.000.000.000 jaar. Ironisch genoeg kunnen sommige browsers zo'n grote waarde niet goed verwerken en schakelen ze HSTS voor die site zelfs uit!

<figure>
<table>
    <thead>
      <tr>
        <th>HSTS-Richtlijn</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Geldig <code>max-age</code></td>
        <td class="numeric">92,21%</td>
        <td class="numeric">92,82%</td>
      </tr>
      <tr>
        <td><code>includeSubdomains</code></td>
        <td class="numeric">32,97%</td>
        <td class="numeric">32,14%</td>
      </tr>
      <tr>
        <td><code>preload</code></td>
        <td class="numeric">16,02%</td>
        <td class="numeric">16,56%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Gebruik van HSTS-richtlijnen.", sheets_gid="560555207", sql_file="hsts_attributes.sql") }}</figcaption>
</figure>

Het is bemoedigend om te zien dat de acceptatie van de andere attributen toeneemt in vergelijking met [vorig jaar](../2019/security#http-strict-transport-security): `includeSubdomains` staat nu op 32,14% en `preload` op 16,56% van de HSTS-polissen.

## Cookies

Vanuit veiligheidsoogpunt kan het automatisch opnemen van cookies in cross-site verzoeken worden gezien als de belangrijkste boosdoener van verschillende soorten kwetsbaarheden. Als een website niet over de juiste bescherming beschikt (bijv. Als een uniek token vereist is voor verzoeken om statuswijziging), kunnen ze vatbaar zijn voor <a hreflang="en" href="https://owasp.org/www-community/attacks/csrf"><span lang="en">Cross-Site Request Forgery</span></a> (CSRF)-aanvallen. Een aanvaller kan bijvoorbeeld op de achtergrond een POST-verzoek doen, zonder dat de gebruiker zich ervan bewust is dat hij bijvoorbeeld het wachtwoord van een onwetende bezoeker moet wijzigen. Als de gebruiker is ingelogd, neemt de browser de cookies normaal gesproken automatisch op in een dergelijk verzoek.

Verschillende andere soorten aanvallen zijn afhankelijk van de opname van cookies in cross-site-verzoeken, zoals <a hreflang="en" href="https://www.usenix.org/system/files/conference/usenixsecurity15/sec15-paper-lekies.pdf"><span lang="en">Cross-Site Script Inclusion</span></a> (XSSI) en verschillende technieken in de kwetsbaarheidsklasse <a hreflang="en" href="https://xsleaks.dev/">XS-Leaks</a>. Bovendien, omdat de authenticatie van gebruikers vaak alleen via cookies gebeurt, kan een aanvaller zich voordoen als een gebruiker door zijn cookies te verkrijgen. Dit zou kunnen worden gedaan in een man-in-the-middle (MITM)-aanval, waarbij de gebruiker wordt misleid om zich te verifiëren via een onveilig kanaal. Als alternatief, door misbruik te maken van een cross-site scripting (XSS) kwetsbaarheid, kan de aanvaller de cookies lekken door toegang te krijgen tot `document.cookie` via de DOM.

Om zich te verdedigen tegen de bedreigingen van cookies, kunnen websiteontwikkelaars gebruik maken van drie attributen die kunnen worden ingesteld op [cookies](https://developer.mozilla.org/docs/Web/HTTP/Cookies): `HttpOnly`, `Secure` en <a hreflang="en" href="https://web.dev/samesite-cookies-explained/">`SameSite`</a>. De eerste voorkomt dat de cookie wordt geopend vanuit JavaScript, waardoor wordt voorkomen dat een tegenstander ze steelt tijdens een XSS-aanval. Cookies met het kenmerk `Secure` worden alleen verzonden via een beveiligde HTTPS-verbinding, waardoor ze niet kunnen worden gestolen bij een MITM-aanval.

Het meest recent geïntroduceerde attribuut, `SameSite`, kan worden gebruikt om te beperken hoe cookies worden verzonden in een cross-site context. Het attribuut heeft drie mogelijke waarden: `None`, `Lax` en `Strict`. Cookies met `SameSite=None` worden verzonden in alle cross-site-verzoeken, terwijl cookies met het attribuut ingesteld op `Lax` alleen worden verzonden in navigatieverzoeken, bijv. wanneer de gebruiker op een link klikt en naar een nieuwe pagina navigeert. Ten slotte worden cookies met het `SameSite=Strict`-attribuut alleen verzonden in een eerste partij context.

{{ figure_markup(
  image="security-httponly-secure-samesite-cookie-usage.png",
  caption="Cookie-attributen.",
  description="Staafdiagram met cookie-attributen gedeeld door eerste en derde partij. Voor eerste partij wordt `HttpOnly` gebruikt door 30,5%, `Secure` met 22,2% en `SameSite` met 13,7%, terwijl voor derden `HttpOnly` wordt gebruikt door 26,3%, `Secure` met 68,0% en `SameSite` met 53,2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1113791085&format=interactive",
  sheets_gid="253049761",
  sql_file="cookie_attributes.sql"
) }}

Onze resultaten, die zijn gebaseerd op 25 miljoen eerste-site cookies en 115 miljoen derden cookies, laten zien dat het gebruik van de cookie-attributen sterk afhankelijk is van de context waarin ze zijn ingesteld. We kunnen een soortgelijk gebruik van het attribuut `HttpOnly` zien bij cookies voor zowel eerste partij (30,5%) als derden (26,3%) cookies.

Voor de `Secure`- en `SameSite`-attributen zien we echter een significant verschil: het `Secure`-attribuut is aanwezig in 22,2% van alle cookies die zijn ingesteld in een eerste partij context, terwijl 68,0% van alle cookies die door derden zijn ingesteld verzoeken op mobiele startpagina's hebben dit cookie-attribuut. Interessant is dat voor desktoppagina's slechts 35,2% van de cookies van derden het kenmerk had.

Voor het `SameSite`-attribuut zien we een aanzienlijke toename in hun gebruik, vergeleken met [vorig jaar](../2019/security#samesite), toen slechts 0,1% van de cookies dit attribuut had. Vanaf augustus 2020 hebben we vastgesteld dat 13,7% van de eerste partij cookies en 53,2% van de cookies van derden het `SameSite`-attribuut hebben ingesteld.

Vermoedelijk houdt deze significante wijziging in acceptatie verband met de beslissing van Chrome om `SameSite=Lax` de standaardoptie te maken. Dit wordt bevestigd door nauwkeuriger te kijken naar de waarden die zijn ingesteld in het SameSite-attribuut: de meeste cookies van derden (76,5%) hebben de attribuutwaarde ingesteld op `none`. Voor eerste partij cookies is het aandeel lager, namelijk 48,0%, maar nog steeds significant. Het is belangrijk op te merken dat, omdat de crawler niet inlogt op websites, de cookies die worden gebruikt om gebruikers te verifiëren, kunnen verschillen.

{{ figure_markup(
  image="security-samesite-cookie-attributes.png",
  caption="SameSite cookie-attributen.",
  description="Staafdiagram met SameSite cookie-attributen gedeeld door eerste en derde partij. Voor eerste partij wordt `SameSite=lax` gebruikt door 50,06%, `SameSite=strict` met 2,03% en `SameSite=none` met 47,96%, terwijl voor derden `SameSite=lax` wordt gebruikt door 23,40%, `SameSite=strict` met 0,10% en `SameSite=none` met 76,50%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=24669187&format=interactive",
  sheets_gid="253049761",
  sql_file="cookie_attributes.sql"
) }}

Een bijkomend mechanisme dat kan worden gebruikt om cookies te beschermen, is om de naam van de cookie vooraf te laten gaan met `__Secure-` of `__Host-`. Cookies met een van deze twee voorvoegsels worden alleen in de browser opgeslagen als ze het kenmerk `Secure` hebben ingesteld. Dit laatste legt een extra beperking op, waardoor het kenmerk `Path` moet worden ingesteld op `/` en het gebruik van het kenmerk `Domain` wordt voorkomen. Dit voorkomt dat aanvallers de cookie overschrijven met andere waarden in een poging een sessie-fixatieaanval uit te voeren.

Het gebruik van deze voorvoegsels is relatief klein: in totaal vonden we 4.433 (0,02%) eerste partij cookies die waren ingesteld met het voorvoegsel `__Secure-` en 1502 (0,01%) met het voorvoegsel `__Host-`. Voor cookies die in een externe context zijn geplaatst, is het relatieve aantal vooraf ingestelde cookies vergelijkbaar.

## Inhoud inclusie

Moderne webapplicaties bevatten een grote verscheidenheid aan componenten van derden, variërend van [JavaScript](./javascript) bibliotheken tot videospelers en externe plug-ins. Vanuit een beveiligingsperspectief kan het opnemen van mogelijk niet-vertrouwde inhoud op uw webpagina verschillende bedreigingen opleveren, zoals cross-site scripting als kwaadaardig JavaScript wordt opgenomen. Om zich tegen deze bedreigingen te verdedigen, hebben browsers verschillende mechanismen die kunnen worden gebruikt om te beperken uit welke bronnen inhoud kan worden opgenomen, of om beperkingen op te leggen aan de opgenomen inhoud.

### Inhoudsbeveiligingsbeleid

Een van de belangrijkste mechanismen om aan de browser aan te geven welke bronnen inhoud mogen laden, is het [<span lang="en">`Content-Security-Policy`</span> (CSP)](https://developer.mozilla.org/docs/Web/HTTP/CSP) (Inhoudsbeveiligingsbeleid) antwoordheader. Door middel van tal van richtlijnen kan een websitebeheerder gedetailleerde controle hebben over hoe inhoud kan worden opgenomen. De `script-src` richtlijn geeft bijvoorbeeld aan van welke oorsprong scripts kunnen worden geladen. Over het algemeen ontdekten we dat een CSP-header aanwezig was op 7,23% van alle pagina's, wat, hoewel nog steeds klein, een opmerkelijke stijging is van 53% ten opzichte van vorig jaar, toen de CSP-acceptatie 4,73% bedroeg voor mobiele pagina's.

<figure>
  <table>
    <thead>
      <tr>
        <th>Richtlijn</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code lang="en">upgrade-insecure-requests</code></td>
        <td class="numeric">61,61%</td>
        <td class="numeric">61,00%</td>
      </tr>
      <tr>
        <td><code lang="en">frame-ancestors</code></td>
        <td class="numeric">55,64%</td>
        <td class="numeric">56,92%</td>
      </tr>
      <tr>
        <td><code lang="en">block-all-mixed-content</code></td>
        <td class="numeric">34,19%</td>
        <td class="numeric">35,61%</td>
      </tr>
      <tr>
        <td><code>default-src</code></td>
        <td class="numeric">18,51%</td>
        <td class="numeric">16,12%</td>
      </tr>
      <tr>
        <td><code>script-src</code></td>
        <td class="numeric">16,99%</td>
        <td class="numeric">16,63%</td>
      </tr>
      <tr>
        <td><code>style-src</code></td>
        <td class="numeric">14,17%</td>
        <td class="numeric">11,94%</td>
      </tr>
      <tr>
        <td><code>img-src</code></td>
        <td class="numeric">11,85%</td>
        <td class="numeric">10,33%</td>
      </tr>
      <tr>
        <td><code>font-src</code></td>
        <td class="numeric">9,75%</td>
        <td class="numeric">8,40%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="De meest voorkomende richtlijnen die worden gebruikt in CSP-beleid.", sheets_gid="491950531", sql_file="csp_directives_usage.sql") }}</figcaption>
</figure>

Interessant is dat als we kijken naar de meest gebruikte richtlijnen in CSP-beleid, de meest voorkomende richtlijn <a lang="en" hreflang="en" href="https://www.w3.org/TR/upgrade-insecure-requests/">`upgrade-insecure-requests`</a> is, die wordt gebruikt om aan de browser te signaleren dat alle inhoud die is opgenomen in een onveilig schema, in plaats daarvan moet worden geopend via een beveiligde HTTPS-verbinding met dezelfde host.

Bijvoorbeeld: bij `<img src="http://example.com/foo.png">` wordt de afbeelding normaal gesproken opgehaald via een onveilige verbinding, maar wanneer de instructie <span lang="en">`upgrade-insecure-requests`</span> aanwezig is, zal deze automatisch worden opgehaald via HTTPS (`https://example.com/foo.png`).

Dit is vooral handig omdat browsers gemengde inhoud blokkeren: voor pagina's die via HTTPS worden geladen, zou inhoud die is opgenomen van HTTP worden geblokkeerd zonder de instructie <span lang="en">`upgrade-insecure-requests`</span>. De goedkeuring van deze richtlijn is waarschijnlijk veel hoger in vergelijking met de andere, aangezien het een goed startpunt is voor een inhoudbeveiligingsbeleid (CSP), aangezien het onwaarschijnlijk is dat inhoud wordt verbroken en het gemakkelijk te implementeren is.

De CSP-richtlijnen die aangeven uit welke bronnen inhoud kan worden opgenomen (de `*-src`-richtlijnen), hebben een veel lagere acceptatie: slechts 18,51% van het CSP-beleid wordt op desktoppagina's en 16,12% op mobiele pagina's weergegeven. Een van de redenen hiervoor is dat webontwikkelaars worden geconfronteerd met <a hreflang="en" href="https://wkr.io/publication/raid-2014-content_security_policy.pdf">vele uitdagingen bij de adoptie van CSP</a>. Hoewel een strikt CSP-beleid aanzienlijke beveiligingsvoordelen kan bieden die veel verder gaan dan het dwarsbomen van XSS-aanvallen, kan een slecht gedefinieerd beleid voorkomen dat bepaalde geldige inhoud wordt geladen.

Om webontwikkelaars in staat te stellen de juistheid van hun CSP-beleid te evalueren, bestaat er ook een niet-afdwingbaar alternatief, dat kan worden ingeschakeld door het beleid te definiëren in de antwoordkop <span lang="en">`Content-Security-Policy-Report-Only`</span>. De prevalentie van deze kop is vrij klein: 0,85% van de desktop- en mobiele pagina's. Opgemerkt moet echter worden dat dit vaak een overgangskop is en dat het percentage dus waarschijnlijk de sites aangeeft die van plan zijn over te stappen op het gebruik van CSP en de Report-Only koptekst slechts een beperkte tijd gebruiken.

{{ figure_markup(
  image="security-csp-header-length.png",
  caption="CSP-kop lengte.",
  description="Staafdiagram met percentielen van de lengte van de CSP-kop in bytes. Op het 10e percentiel is desktop 23 bytes en mobiel is 24 bytes, op 25e percentiel zijn beide 25 bytes, op 50e percentiel zijn beide 75 bytes, op 75e percentiel is desktop 78 bytes en mobiel is 81 bytes en op 90e percentiel is desktop 365 bytes en mobiel is 316 bytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1825551550&format=interactive",
  sheets_gid="150007358",
  sql_file="csp_number_of_allowed_hosts.sql"
) }}

Over het algemeen is de lengte van de <span lang="en">`Content-Security-Policy`</span>-antwoordkop vrij beperkt: de mediaanlengte voor de waarde van de header is 75 bytes. Dit komt voornamelijk door het korte CSP-beleid voor één doel dat vaak wordt gebruikt. Bijvoorbeeld, 24,64% van de beleidsregels die op desktoppagina's zijn gedefinieerd, hebben alleen de richtlijn <span lang="en">`upgrade-insecure-requests`</span>.

De meest voorkomende kopwaarde, goed voor 29,44% van alle beleidsregels die zijn gedefinieerd op desktoppagina's, is <span lang="en">`block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;`</span>. Dit beleid voorkomt dat de pagina wordt ingekaderd, probeert verzoeken te upgraden naar het beveiligde protocol en blokkeert de inhoud als dat niet lukt.

{{ figure_markup(
  caption="Bytes in de langst waargenomen CSP.",
  content="22.333",
  classes="big-number",
  sheets_gid="150007358",
  sql_file="csp_number_of_allowed_hosts.sql"
)
}}

Aan de andere kant van het spectrum was het langste CSP-beleid dat we observeerden 22.333 bytes lang.

<figure>
  <table>
    <thead>
      <tr>
        <th>Oorsprong</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>https://www.google-analytics.com</td>
        <td class="numeric">1,50%</td>
        <td class="numeric">1,46%</td>
      </tr>
      <tr>
        <td>https://www.googletagmanager.com</td>
        <td class="numeric">1,04%</td>
        <td class="numeric">1,07%</td>
      </tr>
      <tr>
        <td>https://fonts.googleapis.com</td>
        <td class="numeric">0,99%</td>
        <td class="numeric">0,99%</td>
      </tr>
      <tr>
        <td>https://www.youtube.com</td>
        <td class="numeric">1,02%</td>
        <td class="numeric">0,91%</td>
      </tr>
      <tr>
        <td>https://fonts.gstatic.com</td>
        <td class="numeric">0,95%</td>
        <td class="numeric">0,95%</td>
      </tr>
      <tr>
        <td>https://www.google.com</td>
        <td class="numeric">0,95%</td>
        <td class="numeric">0,94%</td>
      </tr>
      <tr>
        <td>https://connect.facebook.net</td>
        <td class="numeric">0,89%</td>
        <td class="numeric">0,83%</td>
      </tr>
      <tr>
        <td>https://stats.g.doubleclick.net</td>
        <td class="numeric">0,72%</td>
        <td class="numeric">0,70%</td>
      </tr>
      <tr>
        <td>https://www.facebook.com</td>
        <td class="numeric">0,66%</td>
        <td class="numeric">0,65%</td>
      </tr>
      <tr>
        <td>https://www.gstatic.com</td>
        <td class="numeric">0,54%</td>
        <td class="numeric">0,57%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Hosts die het vaakst zijn toegestaan in CSP-beleid.", sheets_gid="1634036486", sql_file="csp_allowed_host_frequency.sql") }}</figcaption>
</figure>

De externe oorsprong van waaruit inhoud mag worden geladen, is, niet onverwacht, in lijn met de oorsprong waarvan [inhoud van derden](./third-parties#domeinen-van-derden) het vaakst wordt opgenomen. De 10 meest voorkomende bronnen die zijn gedefinieerd in de '*-src'-attributen in CSP-beleid, kunnen allemaal worden gekoppeld aan Google (analyse, lettertypen, advertenties) en Facebook.

{{ figure_markup(
  caption="Het grootste aantal toegestane hosts dat is waargenomen in een CSP.",
  content="403",
  classes="big-number",
  sheets_gid="1634036486",
  sql_file="csp_allowed_host_frequency.sql"
)
}}

Eén site deed zijn best om ervoor te zorgen dat al hun inbegrepen inhoud zou worden toegestaan door CSP en 403 verschillende hosts in hun beleid zou toestaan. Dit maakt het beveiligingsvoordeel natuurlijk op zijn best marginaal, aangezien bepaalde hosts <a hreflang="en" href="https://webappsec.dev/assets/pub/csp_acm16.pdf">CSP-bypasses</a> kunnen toestaan, zoals een JSONP-eindpunt waarmee willekeurige functies kunnen worden aangeroepen.

### Integriteit van subbronnen

Veel JavaScript-bibliotheken en stylesheets zijn opgenomen in CDN's. Als gevolg hiervan kan dit rampzalige gevolgen hebben als het CDN wordt gecompromitteerd of aanvallers een andere manier vinden om de vaak meegeleverde bibliotheken te vervangen.

Om de gevolgen van een gecompromitteerd CDN te beperken, kunnen webontwikkelaars het SRI-mechanisme (Subresource Integrity) gebruiken. Een `integrity`-attribuut, dat bestaat uit de hash van de verwachte inhoud, kan worden gedefinieerd op `<script>` en `<link>` elementen. De browser zal de hash van het opgehaalde script of stylesheet vergelijken met de hash die is gedefinieerd in het attribuut, en de inhoud ervan alleen laden als er een overeenkomst is.

De hash kan worden berekend met drie verschillende algoritmen: SHA256, SHA384 en SHA512. De eerste twee worden het meest gebruikt: respectievelijk 50,90% en 45,92% voor mobiele pagina's (gebruik is vergelijkbaar op desktoppagina's). Momenteel worden alle drie de hash-algoritmen als veilig te gebruiken beschouwd.

{{ figure_markup(
  image="security-subresource-integrity-coverage-per-page.png",
  caption="Subresource-integriteit: dekking per pagina.",
  description="Staafdiagram met percentielen van het percentage scripts op een pagina dat is beveiligd met SRI. Op het 10e percentiel is dit 2,0% voor zowel desktop als mobiel, bij het 25e percentiel is dit 2,9% voor beide, bij het 50e percentiel is dit 4,2% voor beide, bij het 75e percentiel is dit 7,1% voor desktop en 6,9% voor mobiel, en bij het 90e percentiel is het 15,8% voor beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1581504207&format=interactive",
  sheets_gid="599225326",
  sql_file="sri_coverage_per_page.sql"
) }}

Op 7,79% van de desktoppagina's bevat minimaal één element het integrity attribuut en voor mobiele pagina's 7,24%. Het attribuut wordt voornamelijk gebruikt op `<script>`-elementen: 72,77% van alle elementen met het integrity attribuut waren op scriptelementen.

Als we de pagina's die ten minste één script hebben dat is beveiligd met SRI nader bekijken, zien we dat de meeste scripts op deze pagina's het integrity attribuut niet hebben. Op de meeste sites was minder dan 1 op de 20 scripts beveiligd met SRI.

<figure>
  <table>
    <thead>
      <tr>
        <th>Host</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>cdn.shopify.com</td>
        <td class="numeric">44,95%</td>
        <td class="numeric">45,72%</td>
      </tr>
      <tr>
        <td>code.jquery.com</td>
        <td class="numeric">14,05%</td>
        <td class="numeric">13,38%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">11,45%</td>
        <td class="numeric">10,47%</td>
      </tr>
      <tr>
        <td>maxcdn.bootstrapcdn.com</td>
        <td class="numeric">5,03%</td>
        <td class="numeric">4,76%</td>
      </tr>
      <tr>
        <td>stackpath.bootstrapcdn.com</td>
        <td class="numeric">4,96%</td>
        <td class="numeric">4,74%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="De meest voorkomende hosts waarvan SRI-beveiligde scripts zijn opgenomen.", sheets_gid="2132259293", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

Als we kijken naar de meest populaire hosts waarvan SRI-beveiligde scripts zijn opgenomen, kunnen we enkele drijvende krachten zien die de acceptatie stimuleren. Bijna de helft van alle scripts die zijn beschermd met subresource-integrity, is bijvoorbeeld afkomstig van `cdn.shopify.com`, hoogstwaarschijnlijk omdat de Shopify SaaS dit standaard voor hun cliënten inschakelt.

De rest van de top 5 hosts waarvan SRI-beveiligde scripts zijn opgenomen, bestaat uit drie CDN's: <a hreflang="en" href="https://code.jquery.com/">jQuery</a>, <a hreflang="en" href="https://cdnjs.com/">cdnjs</a> en <a hreflang="en" href="https://www.bootstrapcdn.com/">Bootstrap</a>. Het is waarschijnlijk niet toevallig dat alle drie deze CDN's het integrity attribuut hebben in de HTML-voorbeeldcode.

### Functiebeleid (Feature Policy)

Browsers bieden een groot aantal API's en functionaliteiten, waarvan sommige schadelijk kunnen zijn voor de gebruikerservaring of privacy. Via de `Feature-Policy`-antwoordkop kunnen websites aangeven welke functies ze willen gebruiken, of misschien nog belangrijker, welke ze niet willen gebruiken.

Op een vergelijkbare manier, door het `allow`-attribuut op `<iframe>`-elementen te definiëren, is het ook mogelijk om te bepalen welke functies de embedded frames mogen gebruiken. Via de `autoplay`-instructie kunnen websites bijvoorbeeld aangeven of ze willen dat video's in frames automatisch worden afgespeeld wanneer de pagina wordt geladen.

<figure>
  <table>
    <thead>
      <tr>
        <th>Richtlijn</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>encrypted-media</code></td>
        <td class="numeric">78,83%</td>
        <td class="numeric">78,06%</td>
      </tr>
      <tr>
        <td><code>autoplay</code></td>
        <td class="numeric">47,14%</td>
        <td class="numeric">48,02%</td>
      </tr>
      <tr>
        <td><code lang="en">picture-in-picture</code></td>
        <td class="numeric">23,12%</td>
        <td class="numeric">23,28%</td>
      </tr>
      <tr>
        <td><code>accelerometer</code></td>
        <td class="numeric">23,10%</td>
        <td class="numeric">23,22%</td>
      </tr>
      <tr>
        <td><code>gyroscope</code></td>
        <td class="numeric">23,05%</td>
        <td class="numeric">23,20%</td>
      </tr>
      <tr>
        <td><code>microphone</code></td>
        <td class="numeric">8,57%</td>
        <td class="numeric">8,70%</td>
      </tr>
      <tr>
        <td><code>camera</code></td>
        <td class="numeric">8,48%</td>
        <td class="numeric">8,62%</td>
      </tr>
      <tr>
        <td><code lang="en">geolocation</code></td>
        <td class="numeric">8,09%</td>
        <td class="numeric">8,40%</td>
      </tr>
      <tr>
        <td><code>vr</code></td>
        <td class="numeric">7,74%</td>
        <td class="numeric">8,02%</td>
      </tr>
      <tr>
        <td><code lang="en">fullscreen</code></td>
        <td class="numeric">4,85%</td>
        <td class="numeric">4,82%</td>
      </tr>
      <tr>
        <td><code>sync-xhr</code></td>
        <td class="numeric">0,00%</td>
        <td class="numeric">0,21%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Prevalentie van functiebeleid-richtlijnen op frames.", sheets_gid="547110187", sql_file="iframe_allow_directives.sql") }}</figcaption>
</figure>

De antwoordkop van `Feature-Policy` heeft een vrij lage acceptatiegraad, met 0,60% van de desktoppagina's en 0,51% van de mobiele pagina's. Aan de andere kant was functiebeleid ingeschakeld voor 11,8% van de 13,2 miljoen frames die op de desktoppagina's werden gevonden. Op mobiele pagina's bevatte 10,8% van de 13,9 miljoen frames het attribuut `allow`.

<aside class="note">Een eerdere versie van dit hoofdstuk vermeldde onjuiste waarden voor het totale aantal frames en het percentage frames met het kenmerk `allow`. Meer informatie is te vinden in deze <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/3912">GitHub PR</a>.</aside>

Op basis van de meest gebruikte richtlijnen in het functiebeleid voor iframes, kunnen we zien dat deze voornamelijk worden gebruikt om te bepalen hoe de frames video's afspelen. De meest voorkomende richtlijn, `encrypted-media`, wordt bijvoorbeeld gebruikt om de toegang tot de Encrypted Media Extensions API te controleren, die nodig is om DRM-beveiligde video's af te spelen. De meest voorkomende iframe-herkomsten met een functiebeleid waren `https://www.facebook.com` en `https://www.youtube.com` (respectievelijk 49,87% en 26,18% van de frames met een functiebeleid op desktoppagina's ).

### Iframe sandbox

Door een niet-vertrouwde derde partij op te nemen in een iframe, kan die derde partij proberen een aantal aanvallen op de pagina uit te voeren. Het kan bijvoorbeeld de hoofdpagina naar een phishing-pagina navigeren, pop-ups met valse antivirusadvertenties openen, enz.

Het `sandbox`-attribuut op iframes kan worden gebruikt om de mogelijkheden, en dus ook de mogelijkheden om aanvallen uit te voeren, van de embedded webpagina te beperken. Aangezien het insluiten van inhoud van derden, zoals advertenties of video's, gebruikelijk is op internet, is het niet verrassend dat veel hiervan worden beperkt via het `sandbox`-attribuut: 18,3% van de iframes op desktoppagina's heeft een `sandbox`-attribuut terwijl op mobiele pagina's is dit 21,9%.

<aside class="note">Een eerdere versie van dit hoofdstuk vermeldde onjuiste waarden voor het percentage frames met het kenmerk `sandbox`. Meer informatie is te vinden in deze <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/3912">GitHub PR</a>.</aside>

<figure>
  <table>
    <thead>
      <tr>
        <th>Richtlijn</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code lang="en">allow-scripts</code></td>
        <td class="numeric">99,97%</td>
        <td class="numeric">99,98%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-same-origin</code></td>
        <td class="numeric">99,64%</td>
        <td class="numeric">99,70%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-popups</code></td>
        <td class="numeric">83,66%</td>
        <td class="numeric">89,41%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-forms</code></td>
        <td class="numeric">83,43%</td>
        <td class="numeric">89,22%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-popups-to-escape-sandbox</code></td>
        <td class="numeric">81,99%</td>
        <td class="numeric">87,22%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-top-navigation-by-user-activation</code></td>
        <td class="numeric">59,64%</td>
        <td class="numeric">69,45%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-pointer-lock</code></td>
        <td class="numeric">58,14%</td>
        <td class="numeric">67,65%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-top-navigation</code></td>
        <td class="numeric">21,38%</td>
        <td class="numeric">17,31%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-modals</code></td>
        <td class="numeric">20,95%</td>
        <td class="numeric">17,07%</td>
      </tr>
      <tr>
        <td><code lang="en">allow-presentation</code></td>
        <td class="numeric">0,33%</td>
        <td class="numeric">0,31%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Prevalentie van sandbox-richtlijnen op frames.", sheets_gid="402256187", sql_file="iframe_sandbox_directives.sql") }}</figcaption>
</figure>

Wanneer het `sandbox`-attribuut van een iframe een lege waarde heeft, resulteert dit in het meest beperkende beleid: de ingesloten pagina kan geen JavaScript-code uitvoeren, er kunnen geen formulieren worden ingediend en er kunnen geen pop-ups worden gemaakt, om een paar beperkingen te noemen.

Dit standaardbeleid kan op een verfijnde manier worden versoepeld door middel van verschillende richtlijnen. De meest gebruikte richtlijn, <span lang="en">`allow-scripts`</span>, die aanwezig is in 99,97% van alle sandbox-beleidsregels op desktoppagina's, staat de ingesloten pagina toe JavaScript-code uit te voeren. De andere richtlijn die aanwezig is op vrijwel alle sandbox-beleidsregels, <span lang="en">`allow-same-origin`</span>, staat toe dat de ingesloten pagina zijn oorsprong behoudt en bijvoorbeeld toegang krijgt tot cookies die op die oorsprong zijn ingesteld.

Interessant is dat hoewel functiebeleiden iframe-sandbox beide een vrij hoge acceptatiegraad hebben, ze zelden gelijktijdig voorkomen: slechts 0,04% van de iframes heeft zowel het `allow`- als het `sandbox`-attribuut. Dit komt waarschijnlijk doordat het iframe is gemaakt door een script van een derde partij. Een functiebeleid wordt voornamelijk toegevoegd aan iframes die video's van derden bevatten, terwijl het `sandbox`-attribuut voornamelijk wordt gebruikt om de mogelijkheden van advertenties te beperken: 56,40% van de iframes op desktoppagina's met een `sandbox`-attribuut is afkomstig van `https://googleads.g.doubleclick.net`.

## Aanvallen verijdelen

Moderne webapplicaties worden geconfronteerd met een grote verscheidenheid aan beveiligingsrisico's. Het onjuist coderen of opschonen van gebruikersinvoer kan bijvoorbeeld resulteren in een cross-site scripting (XSS) -kwetsbaarheid, een klasse van problemen die webontwikkelaars al meer dan een decennium lastig vallen. Naarmate webapplicaties steeds complexer worden en nieuwe soorten aanvallen worden ontdekt, doemen er nog meer bedreigingen op. <a hreflang="en" href="https://xsleaks.dev/">XS-Leaks</a>, bijvoorbeeld, is een nieuwe klasse van aanvallen die tot doel heeft gebruik te maken van de gebruikersspecifieke dynamische reacties die webapplicaties teruggeven.

Als een webmailcliënt bijvoorbeeld een zoekfunctionaliteit biedt, kan een aanvaller verzoeken voor verschillende trefwoorden activeren en vervolgens via verschillende zijkanalen proberen vast te stellen of een van deze trefwoorden resultaten heeft opgeleverd. Dit biedt de aanvaller in feite een zoekmogelijkheid in de mailbox van een onwetende bezoeker op de website van de aanvaller.

Gelukkig bieden webbrowsers ook een groot aantal beveiligingsmechanismen die zeer effectief zijn om de gevolgen van een mogelijke aanval te beperken, bijv. via de `script-src` richtlijn van CSP kan een XSS-kwetsbaarheid erg moeilijk of onmogelijk worden om te misbruiken.

Sommige andere beveiligingsmechanismen zijn zelfs nodig om bepaalde soorten aanvallen te voorkomen: om [clickjacking](https://en.wikipedia.org/wiki/Clickjacking) aanvallen te voorkomen, moet ofwel de `X-Frame-Options` header aanwezig zijn, of als alternatief kan de `frame-ancestors` richtlijn van CSP worden gebruikt om vertrouwde partijen aan te duiden die het huidige document kunnen insluiten.

{{ figure_markup(
  image="security-adoption-of-security-headers.png",
  caption="Goedkeuring van beveiligingskoppen",
  description="Staafdiagram met de prevalentie van verschillende beveiligingskoppen voor mobiele pagina's in 2019 en 2020. `Content-Security-Policy` is 5% op desktop en 11% op mobiel, `Expect-CT` is 8% op desktop en 11% op mobiel, `Feature-Policy` is 0% op desktop en 1% op mobiel, `Referrer-Policy` is 6% op desktop en 7% op mobiel, `Report-To` is 2% op desktop en 3% op mobiel, `Strict-Transport-Security` is 13% op desktop en 17% op mobiel, `X-Content-Type-Options` is 26% op desktop en 30% op mobiel, `X-Frame-Options` is 24% op desktop en 27% op mobiel, en `X-XSS-Protection` is 16% op desktop en 18% op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1262077475&format=interactive",
  sheets_gid="1613840789",
  sql_file="security_headers_prevalence.sql"
) }}

### Overname van beveiligingsmechanismen

De meest gebruikte kop voor beveiligingsreacties op het web is [<span lang="en">`X-Content-Type-Options`</span>](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-Content-Type-Options), die de browser instrueert om het geadverteerde inhoudstype te vertrouwen en er dus niet aan te ruiken op basis van de responsinhoud. Dit voorkomt effectief verwarringsaanvallen van het MIME-type, bijvoorbeeld door te voorkomen dat aanvallers een JSONP-eindpunt misbruiken om als HTML-code te worden geïnterpreteerd om een cross-site scripting-aanval uit te voeren.

De volgende op de lijst is de [`X-Frame-Options`](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-Frame-Options) (XFO) antwoordkop, die wordt mogelijk gemaakt door ongeveer 27% van de pagina's. Deze kop, samen met CSP's `frame-ancestors`-richtlijnen, zijn de enige effectieve mechanismen die kunnen worden gebruikt om clickjacking-aanvallen tegen te gaan. XFO is echter niet alleen nuttig tegen clickjacking, maar maakt exploitatie ook aanzienlijk moeilijker voor <a hreflang="en" href="https://cure53.de/xfo-clickjacking.pdf">verschillende andere soorten aanvallen</a>. Hoewel XFO momenteel nog steeds het enige mechanisme is om zich te verdedigen tegen clickjacking-aanvallen in oudere browsers zoals Internet Explorer, is het onderhevig aan <a hreflang="en" href="https://www.usenix.org/system/files/sec20fall_calzavara_prepub.pdf">double framing-aanvallen</a>. Dit probleem wordt verholpen met de CSP-richtlijn `frame-ancestors`. Als zodanig wordt het als 'best practice' beschouwd om beide koppen te gebruiken om gebruikers de best mogelijke bescherming te bieden.

De [`X-XSS-Protection`](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-XSS-Protection) kop, die momenteel wordt gebruikt door 18,39% van de websites, werd gebruikt om het ingebouwde detectiemechanisme van de browser voor gereflecteerde cross-site scripting te besturen. Vanaf Chrome-versie 78 is de ingebouwde XSS-detector echter <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=968591">verouderd en verwijderd</a> vanuit de browser. Dit kwam doordat er verschillende bypasses bestaan, en het mechanisme introduceerde ook nieuwe <a hreflang="en" href="https://frederik-braun.com/xssauditor-bad.html">kwetsbaarheden en informatielekken</a> die door aanvallers konden worden misbruikt. Aangezien de andere browserleveranciers nooit een soortgelijk mechanisme hebben geïmplementeerd, heeft de kop `X-XSS-Protection` in feite geen effect op moderne browsers en kan deze dus veilig worden verwijderd. Desalniettemin zien we een lichte stijging in de acceptatie van deze kop in vergelijking met vorig jaar, van 15,50% naar 18,39%.

De rest van de top vijf van meest gebruikte headers wordt aangevuld met twee headers die betrekking hebben op de TLS-implementatie van een website. De [<span lang="en">`Strict-Transport-Security`</span>](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security) header wordt gebruikt om de browser te instrueren dat de website alleen bezocht mag worden via een HTTPS-verbinding voor de duur die is gedefinieerd in het attribuut `max-age`. We hebben de configuratie van deze header in meer detail onderzocht [eerder in dit hoofdstuk](#transportbeveiliging). De header `Expect-CT` zal de browser instrueren om te verifiëren dat elk certificaat dat is uitgegeven voor de huidige website in het openbaar moet verschijnen [<span lang="en">Certificate Transparency</span>](https://developer.mozilla.org/docs/Web/HTTP/Headers/Expect-CT)-logboeken.

Over het algemeen kunnen we zien dat de acceptatie van beveiligingsheaders het afgelopen jaar is toegenomen: de meest gebruikte beveiligingsheaders laten een relatieve stijging zien van 15 tot 35 procent. De groei in het gebruik van de functies die recenter zijn geïntroduceerd, zoals de <span lang="en">`Report-To`</span>- en <span lang="en">`Feature-Policy`</span>-headers, is ook vermeldenswaard: de laatste is meer dan verdrievoudigd in vergelijking met vorig jaar. De sterkste absolute groei is te zien voor de CSP-header, met een acceptatiegraad die stijgt van 4,94% naar 10,93%.

### XSS-aanvallen voorkomen via CSP

<figure>
  <table>
    <thead>
      <tr>
        <th>Sleutelwoord</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>strict-dynamic</code></td>
        <td class="numeric">2,40%</td>
        <td class="numeric">14,68%</td>
      </tr>
      <tr>
        <td><code>nonce-</code></td>
        <td class="numeric">8,72%</td>
        <td class="numeric">17,40%</td>
      </tr>
      <tr>
        <td><code lang="en">unsafe-inline</code></td>
        <td class="numeric">89,83%</td>
        <td class="numeric">92,28%</td>
      </tr>
      <tr>
        <td><code lang="en">unsafe-eval</code></td>
        <td class="numeric">84,03%</td>
        <td class="numeric">77,48%</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Prevalentie van CSP-sleutelwoorden op basis van beleid dat een default-src- of script-src-richtlijn definieert.", sheets_gid="876947926", sql_file="csp_script_source_list_keywords.sql") }}</figcaption>
</figure>

Het implementeren van een strikte CSP die nuttig is om XSS-aanvallen te voorkomen, is niet triviaal: webontwikkelaars moeten zich bewust zijn van alle verschillende bronnen waaruit scripts worden geladen en alle inline scripts moeten worden verwijderd. Om acceptatie gemakkelijker te maken, biedt de laatste versie van CSP (versie 3) nieuwe sleutelwoorden die kunnen worden gebruikt in de `default-src` of `script-src` richtlijnen. Het sleutelwoord <a hreflang="en" href="https://content-security-policy.com/strict-dynamic/">`strict-dynamic`</a> staat bijvoorbeeld elk script toe dat dynamisch wordt toegevoegd door een reeds vertrouwd script, bijv. wanneer dat script een nieuw `<script>`- element maakt. Van de beleidsregels die ofwel een `default-src` of `script-src` richtlijn bevatten (21,17% van alle CSP's), zien we een acceptatie van 14,68% van dit relatief nieuwe sleutelwoord. Interessant is dat op desktoppagina's de acceptatie van dit mechanisme aanzienlijk lager is, namelijk 2,40%.

Een ander mechanisme om de adoptie van CSP gemakkelijker te maken, is het gebruik van nonces: in de `script-src` richtlijn van CSP kan een pagina het trefwoord `nonce-` invoeren, gevolgd door een willekeurige string. Elk script (inline of op afstand) met een `nonce`-attribuut dat is ingesteld op dezelfde willekeurige tekenreeks die in de koptekst is gedefinieerd, mag worden uitgevoerd. Als zodanig is het via dit mechanisme niet nodig om van tevoren alle verschillende bronnen te bepalen waaruit scripts kunnen worden opgenomen. We ontdekten dat het nonce-mechanisme werd gebruikt in 17,40% van de beleidsregels die een `script-src` of `default-src` instructie definieerden. Nogmaals, de acceptatie voor desktoppagina's was lager, namelijk 8,72%. We hebben dit grote verschil niet kunnen uitleggen, maar zouden graag <a hreflang="en" href="https://discuss.httparchive.org/t/2047">suggesties horen</a>!

De twee andere trefwoorden, `unsafe-inline` en `unsafe-eval`, zijn aanwezig in de meeste CSP's: respectievelijk 97,28% en 77,79%. Dit kan worden gezien als een herinnering aan de moeilijkheid om een beleid te implementeren dat XSS-aanvallen kan dwarsbomen. Als het trefwoord `strict-dynamic` echter aanwezig is, worden de trefwoorden `unsafe-inline` en `unsafe-eval` effectief genegeerd. Omdat het trefwoord `strict-dynamic` mogelijk niet wordt ondersteund door oudere browsers, wordt het als een best practice beschouwd om de twee andere onveilige trefwoorden op te nemen om de compatibiliteit voor alle browserversies te behouden.

Terwijl de trefwoorden `strict-dynamic` en `nonce-` kunnen worden gebruikt ter verdediging tegen gereflecteerde en aanhoudende XSS-aanvallen, kan een beschermde pagina nog steeds kwetsbaar zijn voor op DOM gebaseerde XSS-kwetsbaarheden. Om zich te verdedigen tegen deze klasse van aanvallen, kunnen website-ontwikkelaars gebruik maken van <a hreflang="en" href="https://web.dev/trusted-types/">Trusted Types</a>, een vrij nieuw mechanisme dat momenteel alleen wordt ondersteund door op Chromium gebaseerde browsers. Ondanks de mogelijke problemen bij het adopteren van vertrouwde typen (websites zouden een beleid moeten opstellen en mogelijk hun JavaScript-code moeten aanpassen om aan dit beleid te voldoen), en gezien het feit dat het een nieuw mechanisme is, is het bemoedigend dat 11 startpagina's al vertrouwde typen hebben aangenomen via de richtlijn `require-trusted-types-for` in CSP.

### Bescherming tegen XS-Leaks met Cross-Origin Policies

Ter verdediging tegen de nieuwe klasse van aanvallen, <a hreflang="en" href="https://xsleaks.dev/">XS-Leaks</a> genaamd, zijn zeer recent verschillende nieuwe beveiligingsmechanismen geïntroduceerd (sommige zijn nog in ontwikkeling). Over het algemeen geven deze beveiligingsmechanismen websitebeheerders meer controle over hoe andere sites kunnen communiceren met hun site. Bijvoorbeeld het [`Cross-Origin-Opener-Policy`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy) (COOP) antwoord header kan worden gebruikt om browsers te instrueren dat de pagina proces-geïsoleerd moet worden van andere, mogelijk schadelijke browsercontexten. Als zodanig zou een tegenstander geen verwijzing kunnen krijgen naar het globale object van de pagina. Als gevolg hiervan worden aanvallen zoals <a hreflang="en" href="https://xsleaks.dev/docs/attacks/frame-counting/">frame counting</a> met dit mechanisme voorkomen. We vonden 31 early-adopters van dit mechanisme, dat pas een paar dagen voordat de gegevensverzameling begon, werd ondersteund in Chrome, Edge en Firefox.

De [`Cross-Origin-Resource-Policy`](https://developer.mozilla.org/docs/Web/HTTP/Cross-Origin_Resource_Policy_(CORP)) (CORP) header, die werd ondersteund door Chrome, Firefox en Edge, slechts iets langer, is al aangenomen op 1.712 pagina's (merk op dat CORP kan/moet worden ingeschakeld op alle brontypen, niet alleen op documenten, vandaar dat dit aantal een onderschatting kan zijn). De header wordt gebruikt om de browser te instrueren hoe de webresource naar verwachting wordt opgenomen: same-origin, same-site of cross-origin (gaande van meer naar minder beperkend). De browser voorkomt dat bronnen worden geladen die zijn opgenomen op een manier die in strijd is met CORP. Als zodanig worden gevoelige bronnen die met deze responskop worden beschermd, beschermd tegen <a hreflang="en" href="https://spectreattack.com/spectre.pdf">Spectre-aanvallen</a> en verschillende <a hreflang="en" href="https://xsleaks.dev/docs/defenses/opt-in/corp/">XS-Leaks-aanvallen</a>. Het <a hreflang="en" href="https://fetch.spec.whatwg.org/#corb">Cross-Origin Read Blocking</a> (CORB)-mechanisme biedt een vergelijkbare bescherming, maar is standaard ingeschakeld in de browser (momenteel alleen in Chromium-gebaseerde browsers) voor "gevoelige" bronnen.

Gerelateerd aan CORP is het [`Cross-Origin-Embedder-Policy`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy) (COEP) respons-header, die door documenten kan worden gebruikt om de browser te instrueren dat elke bron die op de pagina wordt geladen, een CORP-header moet hebben. Bovendien zijn bronnen die worden geladen via het Cross-Origin Resource Sharing (CORS)-mechanisme (bijv. Via de `Access-Control-Allow-Origin`-header) ook toegestaan. Door deze header in te schakelen, samen met COOP, kan de pagina toegang krijgen tot API's die potentieel gevoelig zijn, zoals zeer nauwkeurige timers en `SharedArrayBuffer`, die ook kan worden gebruikt om een zeer nauwkeurige timer te construeren. We vonden 6 pagina's die COEP inschakelden, hoewel ondersteuning voor de header pas een paar dagen voor de gegevensverzameling aan browsers werd toegevoegd.

De meeste van de cross-origin-beleidsregels zijn bedoeld om de mogelijk schadelijke gevolgen van verschillende browserfuncties die slechts een beperkt gebruik op internet hebben (bijvoorbeeld een verwijzing naar nieuw geopende vensters) uit te schakelen of te verzachten. Als zodanig kunnen beveiligingsfuncties zoals COOP en CORP in de meeste gevallen worden uitgevoerd zonder enige functionaliteit te verbreken. Daarom kan worden verwacht dat de invoering van dit cross-origin beleid de komende maanden en jaren aanzienlijk zal toenemen.

### Web Cryptography API

De <a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">Web Cryptography API</a> biedt geweldige JavaScript-functies voor ontwikkelaars die kunnen worden gebruikt om veilig en met weinig moeite cryptografische bewerkingen aan de cliëntzijde uit te voeren, zonder dat hiervoor externe bibliotheken nodig zijn. Deze JavaScript-API biedt niet alleen eenvoudige cryptografische bewerkingen, maar kan ook worden gebruikt om cryptografisch sterke willekeurige waarden, hashing, genereren en verifiëren van handtekeningen, codering en decodering te genereren. Met behulp van deze API kunnen we ook algoritmen implementeren voor het authenticeren van gebruikers, het ondertekenen van documenten, en het veilig beschermen van de vertrouwelijkheid en integriteit van communicatie. Bijgevolg maakt deze API meer veilige en gegevensbeschermingsconforme use-cases mogelijk op het gebied van end-to-end encryptie. Op deze manier levert de Web Cryptography API zijn bijdrage aan end-to-end encryptie.

<figure>
  <table>
    <thead>
      <tr>
        <th>Cryptography API</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code lang="en">CryptoGetRandomValues</code></td>
        <td class="numeric">70,32%</td>
        <td class="numeric">67,94%</td>
      </tr>
      <tr>
        <td><code lang="en">SubtleCryptoGenerateKey</code></td>
        <td class="numeric">0,3%</td>
        <td class="numeric">0,2%</td>
      </tr>
      <tr>
        <td><code lang="en">SubtleCryptoEncrypt</code></td>
        <td class="numeric">0,3%</td>
        <td class="numeric">0,2%</td>
      </tr>
      <tr>
        <td><code lang="en">SubtleCryptoDigest</code></td>
        <td class="numeric">0,3%</td>
        <td class="numeric">0,3%</td>
      </tr>
      <tr>
        <td><code lang="en">CryptoAlgorithmSha256</code></td>
        <td class="numeric">0,2%</td>
        <td class="numeric">0,2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="De meest gebruikte Cryptography API's", sheets_gid="1256054098", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

Onze resultaten laten zien dat de functie `Cypto.getRandomValues`, die het mogelijk maakt om een willekeurig getal te genereren (op een veilige, cryptografische manier) verreweg de meest gebruikte is (desktop: 70% en mobiel: 68%). We denken dat het gebruik van deze functie door Google Analytic een groot effect heeft op het gemeten gebruik. Over het algemeen zien we dat mobiele websites iets minder cryptografische bewerkingen uitvoeren, hoewel mobiele browsers deze API [volledig ondersteunen](https://developer.mozilla.org/docs/Web/API/Web_Crypto_API#Browser_compatibility).

<aside class="note">Opgemerkt moet worden dat, aangezien we passief crawlen, onze resultaten in deze sectie hierdoor worden beperkt. We kunnen geen gevallen identificeren waarin enige interactie vereist is voordat de functies worden uitgevoerd.</aside>

### Gebruikmakend van botbeveiligingsservices

Volgens <a hreflang="en" href="http://www.imperva.com/blog/bad-bot-report-2020-bad-bots-strike-back">Imperva</a> behoort een serieus deel (37%) van het totale webverkeer tot geautomatiseerde programma's (zogenaamde "bots"), en de meeste zijn kwaadaardig (24%). Bots kunnen worden gebruikt voor phishing, het verzamelen van informatie, het misbruiken van kwetsbaarheden, DDoS en vele andere doeleinden. Het gebruik van bots is een zeer interessante techniek voor aanvallers en verhoogt vooral het slagingspercentage van massale aanvallen. Daarom kan bescherming tegen kwaadwillende bots nuttig zijn bij de verdediging tegen grootschalige geautomatiseerde aanvallen. De volgende afbeelding toont het gebruik van beveiligingsservices van derden tegen kwaadwillende bots.

<figure>
  <table>
    <thead>
      <tr>
        <th>Dienstverlener</th>
        <th>Desktop</th>
        <th>Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>reCAPTCHA</td>
        <td class="numeric">8,30%</td>
        <td class="numeric">9,03%</td>
      </tr>
      <tr>
        <td>Imperva</td>
        <td class="numeric">0,30%</td>
        <td class="numeric">0,36%</td>
      </tr>
      <tr>
        <td>hCaptcha</td>
        <td class="numeric">0,01%</td>
        <td class="numeric">0,01%</td>
      </tr>
      <tr>
        <td>Anderen</td>
        <td class="numeric">&lt;0,01%</td>
        <td class="numeric">&lt;0,01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Gebruik van botbeveiligingsservices door provider", sheets_gid="1787091453", sql_file="bot_detection.sql") }}</figcaption>
</figure>

Bovenstaande figuur toont het gebruik van botbescherming en ook het marktaandeel op basis van onze dataset. We zien dat bijna 10% van de desktoppagina's en 9% van de mobiele pagina's dergelijke services gebruiken.

## Verband tussen het aannemen van beveiligingskoppen en verschillende factoren

In de vorige secties hebben we de acceptatiegraad onderzocht van verschillende browserbeveiligingsmechanismen die moeten worden ingeschakeld door webpagina's via responsheaders. Vervolgens onderzoeken we wat websites ertoe aanzet om de beveiligingsfuncties over te nemen, of het nu verband houdt met beleid en regelgeving op landniveau, een algemeen belang om hun cliënten te beschermen, of dat het wordt aangedreven door de technologiestack die wordt gebruikt om de website te bouwen.

### Land van de bezoekers van een website

Er kunnen veel verschillende factoren zijn die van invloed zijn op de beveiliging op het niveau van een land: door de overheid gemotiveerde cyberbeveiligingsprogramma's kunnen het bewustzijn van goede beveiligingspraktijken vergroten, een focus op beveiliging in het hoger onderwijs kan leiden tot beter geïnformeerde ontwikkelaars of zelfs bepaalde regelgeving kunnen bedrijven en organisaties ertoe verplichten zich te houden aan de beste beveiligingspraktijken. Om de verschillen per land te evalueren, analyseren we de verschillende landen waarvoor er minimaal 100.000 startpagina's beschikbaar waren in onze dataset, die is gebaseerd op het <span lang="en">Chrome User Experience Report</span> (CrUX). Deze pagina's bestaan uit de pagina's die het meest werden bezocht door de gebruikers in dat land; als zodanig bevatten deze ook zeer populaire internationale websites.

{{ figure_markup(
  image="security-adoption-of-https-per-country.png",
  caption="Overname van HTTPS per land",
  description="Staafdiagram met het percentage sites waarop HTTPS is ingeschakeld, voor sites die aan verschillende landen zijn gerelateerd. Zwitserland, Nieuw-Zeeland, Ierland, Nigeria en Australië staan met 95% tot 94% in de top vijf. Aan de andere kant staan Thailand, Iran, Zuid-Korea, Taiwan en Japan op 76% tot 72%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=286219881&format=interactive",
  sheets_gid="446153579",
  sql_file="feature_adoption_by_country.sql"
) }}

Als we kijken naar het percentage startpagina's dat via HTTPS is bezocht, kunnen we al een significant verschil zien: voor de top 5 best presterende landen werd 93-95% van de startpagina's bediend via HTTPS. Voor de onderste 5 zien we een veel kleinere acceptatie in HTTPS, variërend van 71% tot 76%. Als we naar andere beveiligingsmechanismen kijken, zien we nog duidelijkere verschillen tussen de best presterende landen en landen met een lage acceptatiegraad. De top 5 landen op basis van de acceptatiegraad voor CSP scoren tussen 14% en 16%, terwijl de onderste 5 scoren tussen 2,5% en 5%. Interessant is dat de landen die goed/slecht presteren voor het ene beveiligingsmechanisme, dat ook doen voor andere mechanismen. Nieuw-Zeeland, Ierland en Australië behoren bijvoorbeeld consequent tot de top 5, terwijl Japan het slechtst scoort voor bijna elk beveiligingsmechanisme.

{{ figure_markup(
  image="security-adoption-of-csp-and-xfo-per-country.png",
  caption="Overname van CSP en XFO per land.",
  description="Staafdiagram dat laat zien dat Nieuw-Zeeland 16% van de sites heeft die CSP gebruiken en 37% dat XFO gebruikt, Australië heeft 16% voor CSP en 35% voor XFO, Ierland heeft 15% voor CSP en 38% voor XFO, Canada heeft 15% voor CSP en 30% voor XFO, en de VS heeft 14% voor CSP en 27% voor XFO. Aan de onderkant heeft Wit-Rusland 5% voor CSP en 21% voor XFO, Vietnam heeft 5% voor CSP en 21% voor XFO, Oekraïne heeft 4% voor CSP en 17% voor XFO, Rusland heeft 3% voor CSP en 18% voor XFO, en Japan heeft 3% voor CSP en 16% voor XFO.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=874462374&format=interactive",
  sheets_gid="446153579",
  sql_file="feature_adoption_by_country.sql"
) }}

### Technologie stack

Stimulansen op landniveau kunnen de acceptatie van beveiligingsmechanismen tot op zekere hoogte stimuleren, maar misschien nog wel belangrijker is de technologiestack die websiteontwikkelaars gebruiken bij het bouwen van websites. Lenen de frameworks zich gemakkelijk om een bepaalde functie mogelijk te maken, of is dit een moeizaam proces dat een volledige herziening van de applicatie vereist? Het zou nog beter zijn als ontwikkelaars beginnen met een reeds beveiligde omgeving met sterke standaardinstellingen. In deze sectie onderzoeken we verschillende programmeertalen, SaaS, CMS, e-commerce en CDN-technologieën die een aanzienlijk hogere acceptatiegraad hebben voor specifieke functies (en dus kunnen worden gezien als drijvende factoren voor brede acceptatie). Om het kort te houden, concentreren we ons op de meest gebruikte technologieën, maar het is belangrijk op te merken dat er veel kleinere technologieproducten bestaan die bedoeld zijn om hun gebruikers een betere beveiliging te bieden.

Voor beveiligingsfuncties die verband houden met de transportbeveiliging, zien we dat er 12 technologieproducten zijn (voornamelijk e-commerceplatforms en CMS'en) die de `Strict-Transport-Security`-header inschakelen op ten minste 90% van hun cliëntensites. Websites die worden aangedreven door de top 3 (volgens hun marktaandeel, namelijk Shopify, Squarespace en Automattic), maken 30,32% uit van alle startpagina's die Strict Transport Security hebben ingeschakeld. Interessant is dat de acceptatie van de `Expect-CT`-header voornamelijk wordt aangedreven door een enkele technologie, namelijk Cloudflare, die de header mogelijk maakt voor al hun cliënten die HTTPS hebben ingeschakeld. Als resultaat kan 99,06% van de `Expect-CT`-headeraanwezigheid gerelateerd zijn aan Cloudflare.

Met betrekking tot beveiligingsheaders die de opname van inhoud beveiligen of die bedoeld zijn om aanvallen te dwarsbomen, zien we een soortgelijk fenomeen waarbij een paar partijen een veiligheidheader voor al hun cliënten inschakelen en zo de acceptatie ervan stimuleren. Zes technologieproducten maken bijvoorbeeld de `Content-Security-Policy`-header voor meer dan 80% van hun cliënten mogelijk. Als zodanig vertegenwoordigt de top 3 (Shopify, Sucuri en Tumblr) 52,53% van de startpagina's met de koptekst. Evenzo zien we voor `X-Frame-Options` dat de top 3 (Shopify, Drupal en Magento) 34,96% bijdraagt aan de wereldwijde prevalentie van de XFO-header. Dit is vooral interessant voor Drupal, aangezien het een open-source CMS is dat vaak door website-eigenaren zelf wordt opgezet. Het is duidelijk dat hun <a hreflang="en" href="https://www.drupal.org/node/2735873">beslissing om standaard `X-Frame-Options: SAMEORIGIN` in te schakelen</a> veel van hun gebruikers beschermt tegen clickjacking-aanvallen: 81,81% van websites aangedreven door Drupal hebben het XFO-mechanisme ingeschakeld.

### Gelijktijdig voorkomen van andere beveiligingsheaders

{{ figure_markup(
  image="security-headers-as-drivers-of-adoption-of-other-headers.png",
  caption="Beveiligingsheader als driver voor de acceptatie van andere headers",
  description="Staafdiagram met de relatieve acceptatiegraad van beveiligingsmechanisme op basis van de aanwezigheid van verschillende beveiligingsheaders. `Content-Security-Policy` heeft 357% voor desktop en 368% voor mobiel, `Expect-CT` heeft respectievelijk 224% en 235%, `Referrer-Policy` heeft 265% en 265%, `Strict-Transport-Security` heeft 275% en 284%, `X-Content-Type-Options` heeft 309% en 305%, en `X-Frame-Options` heeft 286% voor desktop en 299% voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1444988925&format=interactive",
  sheets_gid="1707889711",
  sql_file="feature_adoption_by_other_features.sql"
) }}

Het beveiligings "spel" is zeer onevenwichtig, en veel meer in het voordeel van aanvallers: een tegenstander hoeft slechts één fout te vinden om misbruik van te maken, terwijl de verdediger alle mogelijke kwetsbaarheden moet voorkomen. Hoewel het toepassen van een enkel beveiligingsmechanisme erg handig kan zijn bij de verdediging tegen een bepaalde aanval, hebben websites meerdere beveiligingsfuncties nodig om zich tegen alle mogelijke aanvallen te verdedigen. Om te bepalen of beveiligingsheaders op een eenmalige manier worden toegepast, of liever op een rigoureuze manier om diepgaande verdediging tegen zoveel mogelijk aanvallen te bieden, kijken we naar het naast elkaar voorkomen van beveiligingsheaders. Om precies te zijn, we bekijken hoe de acceptatie van de ene beveiligingsheader de acceptatie van andere headers beïnvloedt. Interessant is dat dit aantoont dat websites die een enkele beveiligingsheader gebruiken, veel vaker ook andere beveiligingsheader zullen gebruiken. Bijvoorbeeld, voor mobiele startpagina's die een CSP-header bevatten, de acceptatie van de andere headers (`Expect-CT`, `Referrer-Policy`, `Strict-Transport-Security`, `X-Content-Type-Options` en `X-Frame-Options`) is gemiddeld 368% hoger in vergelijking met de algemene acceptatie van deze headers.

Over het algemeen hebben websites die een bepaalde beveiligingsheader gebruiken 2 tot 3 keer meer kans om ook andere beveiligingsheader te gebruiken. Dit is vooral het geval voor CSP, dat de acceptatie van andere beveiligingsheaders het meest bevordert. Dit is enerzijds te verklaren doordat CSP een van de uitgebreidere beveiligingsheaders is die veel inspanning vergt om te adopteren, waardoor websites die wel een beleid definiëren, eerder geïnvesteerd worden in de beveiliging van hun website. Aan de andere kant staat 44,31% van de CSP-headers op startpagina's die worden aangedreven door Shopify. Dit SaaS-product maakt ook een aantal andere beveiligingsheaders (`Strict-Transport-Security`, `X-Content-Type-Options` en `X-Frame-Options`) standaard mogelijk voor vrijwel al hun cliënten.

## Software-updatepraktijken

Een zeer groot deel van het web is gebouwd met componenten van derden, op verschillende lagen van de technologiestapel. Deze componenten bestaan ​​uit de JavaScript-bibliotheken die worden gebruikt om een ​​betere gebruikerservaring te bieden, de Content Management Systemen of webapplicatiekaders die de ruggengraat van een website vormen en de webservers die worden gebruikt om te reageren op verzoeken van de bezoekers. Af en toe wordt een kwetsbaarheid gedetecteerd in een van deze componenten. In het beste geval wordt het gedetecteerd door een beveiligingsonderzoeker die het op verantwoorde wijze bekendmaakt aan de betrokken leverancier, en hen vraagt ​​de kwetsbaarheid te patchen en een update van hun software vrij te geven. Op dit moment is het zeer waarschijnlijk dat de details van de kwetsbaarheid publiekelijk bekend zijn, en dat aanvallers er gretig aan werken om er een exploit voor te creëren. Als zodanig is het van cruciaal belang voor website-eigenaren om de getroffen software zo snel mogelijk bij te werken om hen te beschermen tegen deze <a hreflang="en" href="https://www.darkreading.com/vulnerabilities---threats/the-overlooked-problem-of-n-day-vulnerabilities/a/d-id/1331348">n-day exploits</a>. In deze sectie onderzoeken we hoe goed de meest gebruikte software up-to-date wordt gehouden.

### WordPress

{{ figure_markup(
  image="security-wordpress-version-evolution.png",
  caption="Evolutie van de WordPress-versie.",
  description="Gestapeld staafdiagram met de evolutie van de versies van WordPress-installaties van november 2019 tot augustus 2020 voor de actief onderhouden takken van WordPress (4.9, 5.1, 5.2, 5.3, 5.4 en 5.5). In het algemeen laat de grafiek zien dat de meeste installaties (ongeveer 75%) het hele jaar door worden bijgewerkt en nu op de nieuwste versies staan.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=2139119698&format=interactive",
  sheets_gid="640505800",
  sql_file="feature_adoption_by_technology.sql",
  width="600",
  height="575"
) }}

Als een van de meest populaire [Content Management Systemen](./cms) is WordPress een aantrekkelijk doelwit voor aanvallers. Daarom is het belangrijk voor websitebeheerders om hun installatie up-to-date te houden. Standaard worden <a hreflang="en" href="https://wordpress.org/support/article/configuring-automatic-background-updates/">updates automatisch uitgevoerd voor WordPress</a>, hoewel het mogelijk is om deze functie uit te schakelen. De evolutie van de geïmplementeerde WordPress-versies wordt weergegeven in de bovenstaande afbeelding, met de <a hreflang="en" href="https://wordpress.org/download/releases/">laatste belangrijke versies die nog steeds actief worden onderhouden</a> (5.5: paars, 5.4: blauw, 5.3 : rood, 5,2: groen, 4,9: oranje). Versies met een prevalentie van minder dan 4% worden bij elkaar gegroepeerd onder "Overig". Een eerste interessante observatie die gemaakt kan worden, is dat vanaf augustus 2020 74,89% van de WordPress-installaties op mobiele startpagina's de nieuwste versie binnen hun branche draaien. Het is ook te zien dat website-eigenaren geleidelijk upgraden naar de nieuwe hoofdversies. WordPress versie 5.5, die werd uitgebracht op 11 augustus 2020, omvatte bijvoorbeeld al 10,22% van de WordPress-installaties die werden waargenomen tijdens de crawl voor augustus.

{{ figure_markup(
  image="security-evolution-of-wordpress-5-3and5-4-after-update.png",
  caption="Evolutie van WordPress 5.3 en 5.4 na update",
  description="Gestapeld staafdiagram met de evolutie van WordPress-versies 5.3.2, 5.3.3, 5.4 en 5.4.1. We kunnen in de loop van de tijd vanaf maart 2020 zien dat 5.3.2 de enige van de versies is die wordt gebruikt en een acceptatie van 50,08% heeft, in april komt 5.4 binnen en neemt een drie derden van de acceptatie van deze versies in beslag, wat oploopt tot 54,23% in totaal, in mei komt 5.4.1 uit en is er gemengd gebruik van alle drie de versies met een totaal van 58,78%, in juni is het met bijna de helft teruggebracht tot 32,76% en het grootste deel van het resterende gebruik is 5.4.1, in juli worden deze versies op slechts 4,55% van de sites gebruikt en in augustus teruggebracht tot 3,59%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=503316556&format=interactive",
  sheets_gid="155582197",
  width="600",
  height="450",
  sql_file="feature_adoption_by_technology.sql"
) }}

Een ander interessant aspect dat uit de grafiek kan worden afgeleid, is dat binnen een maand de meeste WordPress-sites die eerder up-to-date waren, zijn bijgewerkt naar de nieuwe versie. Dit geldt vooral voor WordPress-installaties in de nieuwste branche. Op 29 april 2020, 2 dagen voor de start van de crawl, bracht WordPress updates uit voor al hun branches: 5.4 → 5.4.1, 5.3.2 → 5.3.3, etc. Op basis van de gegevens kunnen we zien dat het aandeel van de WordPress-installaties die versie 5.4 draaiden, daalde van 23,08% in de crawl van april 2020 tot 2,66% in mei 2020, verder naar beneden tot 1,12% in juni 2020 en daalde daarna onder de 1%. De nieuwe 5.4.1-versie draaide op 35,70% van de WordPress-installaties vanaf mei 2020, het resultaat van veel website-exploitanten die hun WordPress-installatie (vanaf 5.4 en andere branches) (automatisch) bijwerkten. Hoewel de meeste websitebeheerders hun WordPress ofwel automatisch updaten, ofwel heel snel nadat een nieuwe versie is uitgebracht, is er nog steeds een klein deel van de sites dat vasthoudt aan een oudere versie: vanaf augustus 2020 was 3,59% van alle WordPress-installaties met een verouderde 5.3- of 5.4-versie.

### jQuery

{{ figure_markup(
  image="security-jquery-version-evolution.png",
  caption="jQuery-versie evolutie.",
  description="Gestapeld staafdiagram dat de evolutie toont van de meegeleverde jQuery-versies van november 2019 tot augustus 2020. In tegenstelling tot de vorige WordPress-versie van dit diagram kunnen we zien dat het gebruik erg statisch is, terwijl Overig schommelt tussen 26,58% en 31,04%, 1.10,2 gemiddeld 4,01%, 1.11.0 gemiddeld 3,52%, 1.11.1 gemiddeld 4,58%, 1.11.3 gemiddeld 4,12%, 1.12.4 gemiddeld 35,19%, 1.7.2 gemiddeld 3,12%, 1.8.3 gemiddeld 3,24%, 1.9.1 gemiddeld 3,16%, 2.2.4 gemiddeld 3,23%, 3.2.1 gemiddeld 3,47%, 3.3.1 gemiddeld 4,62% en 3.4.1 gemiddeld 3,96%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=598537336&format=interactive",
  sheets_gid="1175693258",
  width="600",
  height="450",
  sql_file="feature_adoption_by_technology.sql"
) }}

Een van de meest gebruikte JavaScript-bibliotheken is jQuery, dat drie hoofdversies heeft: 1.x, 2.x en 3.x. Zoals duidelijk is uit de evolutie van jQuery-versies die worden gebruikt op mobiele startpagina's, is de algehele distributie in de loop van de tijd erg statisch. Verrassend genoeg draait een aanzienlijk deel van de websites (18,21% vanaf augustus 2020) nog steeds een oude 1.x-versie van jQuery. Deze fractie neemt consequent af (van 33,39% in november 2019), ten gunste van versie 1.12.4, <a hreflang="en" href="https://blog.jquery.com/2016/05/20/jquery-1-12-4-and-2-2-4-released/">vrijgegeven</a> in mei 2016 en helaas <a hreflang="en" href="https://snyk.io/test/npm/jquery/1.12.4">verschillende beveiligingsproblemen op middelhoog niveau</a> heeft.

### nginx

{{ figure_markup(
  image="security-nginx-version-evolution.png",
  caption="nginx-versie evolutie.",
  description="Evolutie van de versies van nginx-servers van november 2019 tot augustus 2020 die gedurende die tijd een redelijk statisch gebruik vertoonden.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=700290827&format=interactive",
  sheets_gid="1494766656",
  sql_file="feature_adoption_by_technology.sql"
) }}

Voor nginx, een van de meest gebruikte webservers, zien we een zeer statisch en divers landschap wat betreft de acceptatie van verschillende versies in de loop van de tijd. Het grootste aandeel dat enige nginx (secundaire) versie had onder alle nginx-servers in de loop van de tijd was ongeveer 20%. Verder kunnen we zien dat de distributie van versies in de tijd redelijk statisch blijft: het is relatief onwaarschijnlijk dat webservers worden bijgewerkt. Vermoedelijk heeft dit te maken met het feit dat er sinds 2014 <a hreflang="en" href="http://nginx.org/en/security_advisories.html">geen "grote" beveiligingslek</a> in nginx is aangetroffen (met betrekking tot versies tot 1.5.11). De laatste 3 kwetsbaarheden met een gemiddelde impact (<a hreflang="en" href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9511">CVE-2019-9511</a>, <a hreflang="en" href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9513">CVE-2019-9513</a>, <a hreflang="en" href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9516">CVE-2019-9516</a>) dateren van maart 2019 en kunnen buitensporig hoog CPU-gebruik veroorzaken in HTTP/2-compatibele nginx-servers tot versie 1.17.2. Volgens de gerapporteerde versienummers zou meer dan de helft van de servers vatbaar kunnen zijn voor deze kwetsbaarheid (als ze HTTP/2 hebben ingeschakeld). Aangezien de webserversoftware niet regelmatig wordt bijgewerkt, zal dit aantal de komende maanden waarschijnlijk vrij hoog blijven.

## Misstanden op internet

Tegenwoordig speelt de prestatie van de gebruikte technologieën een bijzonder relevante rol. Hiertoe worden technologieën voortdurend verder ontwikkeld, geoptimaliseerd en nieuwe technologieën gelanceerd. Een van deze nieuwe technologieën is WebAssembly, dat sinds eind 2019 een <a hreflang="en" href="https://www.w3.org/2019/12/pressrelease-wasm-rec.html.en">W3C-aanbeveling</a> is geworden. WebAssembly kan worden gebruikt om krachtige webapps te ontwikkelen en heeft het mogelijk gemaakt om bijna native hoge-performantie computergebruik in webbrowsers uit te voeren. Geen roos zonder een doorn echter, aangezien aanvallers hebben geprofiteerd van deze technologie, en zo is de nieuwe aanvalsvector <a hreflang="en" href="https://www.malwarebytes.com/cryptojacking/">cryptojacking</a> ontstaan. Aanvallers gebruikten deze technologie om cryptocurrencies in de webbrowser te minen door gebruik te maken van de kracht van de computers van bezoekers (kwaadaardige cryptomining). Dit is een zeer aantrekkelijke techniek voor aanvallers - injecteer een paar regels JavaScript-code in de webpagina en laat alle bezoekers voor u minen. Omdat sommige websites ook bonafide cryptomining op internet aanbieden, kunnen we niet generaliseren dat alle websites met cryptomining in feite cryptojacking zijn. Maar in de meeste gevallen bieden website-exploitanten geen opt-in-alternatief voor bezoekers, en de bezoekers weten nog steeds niet of hun bronnen worden gebruikt tijdens het browsen op de website.

{{ figure_markup(
  image="security-cryptominer-usage.png",
  caption="Cryptominer-gebruik.",
  description="Tijdreeksgrafiek die de evolutie van het aantal sites met cryptojackingscripts weergeeft van januari 2019 tot augustus 2020. Er is een neerwaartse trend van 1094 desktop-sites en 1221 mobiele sites aan het begin naar 475 sites op desktop en 659 sites op mobiel aan het einde.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=1746732299&format=interactive",
  sheets_gid="340445160",
  sql_file="cryptominer_usage.sql"
) }}

Bovenstaande figuur toont het aantal websites dat gebruikmaakt van cryptomining in de afgelopen twee jaar. We zien dat vanaf begin 2019 de interesse in cryptomining afneemt. Bij onze laatste meting hadden we in totaal 348 websites inclusief cryptomining-scripts.

In de volgende afbeelding laten we het marktaandeel van cryptominer op internet zien op basis van de dataset van augustus. Coinimp is de meest populaire provider met een marktaandeel van 45,2%. We ontdekten dat alle meest populaire cryptominers zijn gebaseerd op WebAssembly. Merk op dat er ook JavaScript-bibliotheken zijn om op internet te minen, maar deze zijn niet zo krachtig als oplossingen op basis van WebAssembly. Ons andere resultaat laat zien dat de helft van de websites, waaronder een cryptominer, gebruikmaakt van een cryptomining-component van stopgezette serviceproviders (<a hreflang="en" href="https://blog.avast.com/coinhive-shuts-down">zoals CoinHive</a> en [JSEcoin](https://x.com/jsecoin/status/1247436272869814272)), wat betekent dat hoewel de cryptomining-scripts op die webpagina's zijn opgenomen, deze niet meer actief zijn en dus in de praktijk geen cryptomining zal plaatsvinden.

{{ figure_markup(
  image="security-cryptominer-market-share.png",
  caption="Cryptominer-marktaandeel (mobiel).",
  description="Cirkeldiagram dat laat zien dat Coinimp een marktaandeel van 45,2,3% heeft, CoinHive 41,4%, JSEcoin 6,9%, Minero.cc 3,0% en anderen 3,55%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTb4PkXuhnxNc-X_Jovx0970pV22ucCnNloa2g8KPMLJmp39E62oSE4XvBlAVSGL0oEEHZa71_bgsV4/pubchart?oid=691707301&format=interactive",
  sheets_gid="445442267",
  sql_file="cryptominer_share.sql"
) }}

## Gevolgtrekking

Een van de meest prominente ontwikkelingen op het gebied van webbeveiliging van het afgelopen jaar is de toegenomen acceptatie van beveiligingsheaders op (de lange staart van) het web. Dit betekent niet alleen dat gebruikers over het algemeen beter worden beschermd, maar wat nog belangrijker is, het laat zien dat de beveiligingsprikkel van websitebeheerders is toegenomen. Deze toename in gebruik is te zien voor alle verschillende beveiligingsheaders, zelfs voor degenen die niet triviaal zijn om te implementeren, zoals CSP. Een andere interessante observatie die gemaakt kan worden, is dat we zagen dat websites die één beveiligingsheader gebruiken, ook vaker andere beveiligingsmechanismen zullen gebruiken. Dit toont aan dat webbeveiliging niet alleen als een bijzaak wordt beschouwd, maar eerder als een holistische benadering waarbij ontwikkelaars zich willen verdedigen tegen alle mogelijke bedreigingen.

Op wereldschaal is er nog een lange weg te gaan. Minder dan een derde van alle sites heeft bijvoorbeeld voldoende bescherming tegen clickjacking-aanvallen, en veel sites geven de bescherming (standaard ingeschakeld in bepaalde browsers) tegen verschillende cross-site-aanvallen af door het `SameSite`-attribuut op cookies in te stellen. naar `None`. Niettemin hebben we ook meer positieve evoluties gezien: verschillende software op de technologiestack maakt standaard beveiligingsfuncties mogelijk. Ontwikkelaars die een website bouwen met behulp van deze software, beginnen met een reeds beveiligde omgeving en moeten de beveiliging met geweld uitschakelen als ze dat willen. Dit is heel anders dan wat we zien in oudere applicaties, waar het verbeteren van de beveiliging moeilijker kan zijn omdat het de functionaliteit zou kunnen breken.

Vooruitkijkend, is een voorspelling waarvan we weten dat deze zal uitkomen, dat het veiligheidslandschap niet tot stilstand zal komen. Er zullen nieuwe aanvalstechnieken aan de oppervlakte komen, die mogelijk aanleiding kunnen geven tot de behoefte aan aanvullende beveiligingsmechanismen om zich ertegen te verdedigen. Zoals we hebben gezien met andere beveiligingsfuncties die pas onlangs zijn aangenomen, zal dit enige tijd duren, maar geleidelijk en stap voor stap convergeren we naar een veiliger web.
