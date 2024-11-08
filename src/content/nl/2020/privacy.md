---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Privacy
description: Privacyhoofdstuk van de Web Almanac 2020 over online trackingcookies, privacyverbeterende technologieën (PET) en privacybeleid
authors: [ydimova]
reviewers: [ldevernay]
analysts: [ydimova, max-ostapenko]
editors: [tunetheweb]
translators: [noah-vdv]
ydimova_bio:  Yana Dimova is een doctoraatsstudent aan de KU Leuven universiteit in België, waar ze zich bezighoudt met privacy en webbeveiliging.
discuss: 2046
results: https://docs.google.com/spreadsheets/d/16bE70rv4qbmKIqbZS1zUiTRpk5eOlgxBXEabL1qiduI/
featured_quote: Privacy is de laatste tijd steeds populairder geworden en heeft de bewustwording bij de gebruikers vergroot. Aan de behoefte aan richtlijnen is voldaan met verschillende regelgeving (zoals GDPR in Europa, LGPD in Brazilië, CCPA in Californië om er maar een paar te noemen). Deze zijn bedoeld om de verantwoordingsplicht van gegevensverwerkers en hun transparantie naar gebruikers te vergroten. In dit hoofdstuk bespreken we de prevalentie van online tracking met verschillende technieken en de acceptatiegraad van cookietoestemmingbanners en het privacybeleid door websites.
featured_stat_1: 93%
featured_stat_label_1: Websites die minstens één tracker laden
featured_stat_2: 9 van de 10
featured_stat_label_2: Top domeinen voor het instellen van cookies die eigendom zijn van Google
featured_stat_3: 44,8%
featured_stat_label_3: Websites met een privacybeleid
---

## Inleiding

Dit hoofdstuk van de Web Almanac geeft een overzicht van de huidige staat van privacy op het web. Dit onderwerp is de laatste tijd steeds populairder geworden en heeft de aandacht van de gebruikers vergroot. Aan de behoefte aan richtlijnen is voldaan met verschillende regelgeving (zoals <a hreflang="en" href="https://gdpr-info.eu/">GDPR</a> in Europa, <a hreflang="en" href="https://lgpd-brazil.info/">LGPD</a> in Brazilië, <a hreflang="en" href="https://leginfo.legislature.ca.gov/faces/codes_displayText.xhtml?division=3.&part=4.&lawCode=CIV&title=1.81.5">CCPA</a> in Californië om er maar een paar te noemen). Deze zijn bedoeld om de verantwoordingsplicht van gegevensverwerkers en hun transparantie naar gebruikers te vergroten. In dit hoofdstuk bespreken we de prevalentie van online tracking met verschillende technieken en de acceptatiegraad van cookietoestemmingbanners en het privacybeleid door websites.

## Online tracking

Trackers van derden verzamelen gebruikersgegevens om profielen van het gebruikersgedrag op te bouwen waarmee inkomsten kunnen worden gegenereerd voor advertentiedoeleinden. Dit roept privacyproblemen op bij gebruikers op internet, wat resulteerde in de opkomst van verschillende trackingbeveiligingen. Zoals we in deze sectie zullen zien, wordt online tracking echter nog steeds veel gebruikt. Het heeft niet alleen een negatieve impact op de privacy, online tracking heeft ook een <a hreflang="en" href="https://gerrymcgovern.com/calculating-the-pollution-cost-of-website-analytics-part-1/">enorme impact op het milieu</a> en het vermijden ervan kan leiden tot [betere prestaties](https://x.com/fr3ino/status/1000166112615714816).

We onderzoeken de bekendheid van de meest voorkomende vormen van tracking van [derden](./third-party), namelijk door middel van cookies van derden en het gebruik van fingerprinting. Online tracking is niet beperkt tot alleen deze twee technieken, er blijven nieuwe technieken opduiken om bestaande tegenmaatregelen te omzeilen.

### Trackers van derden

We gebruiken de trackerlijst van <a hreflang="en" href="https://whotracks.me/">WhoTracksMe</a> om het percentage websites te bepalen dat een verzoek doet aan een potentiële tracker. Zoals te zien is in de volgende afbeelding, hebben we geconstateerd dat op ongeveer 93% van de websites ten minste één potentiële tracker aanwezig is.

{{ figure_markup(
  image="privacy-websites-that-load-trackers.png",
  caption="Websites met ten minste één potentiële tracker",
  description="Staafdiagram waaruit blijkt dat 92,94% van de desktopwebsites en 92,97% van de mobiele websites trackers laadt.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1325818112&format=interactive",
  sheets_gid="1591448294"
  )
}}

We hebben de meest gebruikte trackers onderzocht en de prevalentie van de 10 meest populaire in kaart gebracht.

{{ figure_markup(
  image="privacy-biggest-third-party-potential-trackers.png",
  caption="Top 10 potentiële trackers",
  description="Staafdiagram met de prevalentie van de 10 meest populaire potentiële trackers die worden gebruikt op mobiele en desktopclients. Er is weinig verschil tussen desktop en mobiel en mobiel heeft 65,5% voor google_analytics, 65,9% voor googleapis.com, 63,3% voor gstatic, 58,3% voor google_fonts, 50,0% voor doubleclick, 47,6% voor google, 42,4% voor google_tag_manager, 30,9% voor Facebook, 19,2% voor google_adservices en 12,7% voor cloudflare.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=850649042&format=interactive",
  sheets_gid="1677398038"
  )
}}

De grootste speler op de markt voor online tracking is zonder twijfel Google, met acht van zijn domeinen in de top 10 van potentiële trackers en aanwezig op ten minste 70% van de websites. Ze worden gevolgd door Facebook en Cloudflare, hoewel de laatste waarschijnlijk meer een afspiegeling is van de populariteit van hen als hostingsite.

De trackerlijst van WhoTracksMe definieert ook de categorieën waartoe de trackers behoren. Als we CDN's en Hosting-sites uit onze statistieken verwijderen, in de veronderstelling dat ze misschien niet volgen - of tenminste dat dat niet hun primaire functie is - dan krijgt u een iets andere kijk op de top 10.

{{ figure_markup(
  image="privacy-biggest-third-party-trackers.png",
  caption="Top 10 Trackers",
  description="Staafdiagram met de prevalentie van de 10 meest populaire trackers die worden gebruikt op mobiele en desktopclients. Er is weinig verschil tussen desktop en mobiel en mobiel heeft 65,5% voor google_analytics, 50,0% voor doubleclick, 47,6% voor google, 42,4% voor google_tag_manager, 30,9% voor facebook, 19,2% voor google_adservices, 12,7% voor youtube, 19,2% voor google_syndication, en 6,5% voor zowel twitter als wordpress_stats.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1831606887&format=interactive",
  sheets_gid="1677398038"
  )
}}

Hier maakt Google nog steeds zeven van de top 10 domeinen uit. In onderstaande figuur is de verdeling van de verschillende categorieën voor de 100 grootste potentiële trackers per categorie weergegeven.

{{ figure_markup(
  image="privacy-tracker-categories.png",
  caption="Categorieën van de 100 meest populaire potentiële trackers",
  description="Staafdiagram met de verdeling van de top 100 potentiële trackers op internet met 56 voor advertenties, 11 voor cdn, 9 voor site_analytics, 6 voor zowel social media als misc, 3 voor zowel essential als customer_help, 2 voor zowel audio als video en 1 voor zowel comments als undefined.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1117413918&format=interactive",
  sheets_gid="1431872451",
  )
}}

Bijna 60% van de meest populaire trackers is gerelateerd aan advertenties. Dit kan te wijten zijn aan het feit dat de winstgevendheid van de online advertentiemarkt wordt beschouwd als gerelateerd aan de hoeveelheid tracking.

### Cookies

We hebben gekeken naar de meest populaire cookies die op websites worden ingesteld in de HTTP-responsheader, op basis van hun naam en domein.

<figure>
  <table>
    <thead>
      <tr>
        <th>Domein</th>
        <th>Cookie naam</th>
        <th>Websites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">24%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>onbekend</td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>onbekend</td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>onbekend</td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top cookies op desktopsites", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Domein</th>
        <th>Cookie Naam</th>
        <th>Websites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">32%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">21%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>DSID</code></td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>yandexuid</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>i</code></td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top cookies op mobiele sites", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

Zoals u kunt zien, plaatst het trackingdomein "doubleclick.net" van Google cookies op ongeveer een kwart van de websites op een mobiele client en op een derde van alle websites op een desktopclient. Nogmaals, negen van de tien meest populaire cookies op de desktopclient en zeven van de tien op mobiel worden ingesteld door een Google-domein. Dit is een ondergrens voor het aantal websites waarop de cookie is ingesteld, aangezien we alleen cookies tellen die zijn ingesteld via een HTTP-header - een groot aantal trackingcookies wordt ingesteld met behulp van scripts van derden.

### Vingerafdrukken (fingerprinting)

Een andere veelgebruikte volgtechniek is vingerafdrukken. Dit bestaat uit het verzamelen van verschillende soorten informatie over de gebruiker met als doel voor hen een unieke "vingerafdruk" op te bouwen. Trackers gebruiken verschillende soorten vingerafdrukken op internet. Browservingerafdrukken gebruiken kenmerken die specifiek zijn voor de browser van de gebruiker, waarbij wordt vertrouwd op het feit dat de kans dat een andere gebruiker exact dezelfde browserinstellingen heeft vrij klein is als er een voldoende groot aantal variabelen is om bij te houden. Tijdens onze crawl hebben we de aanwezigheid van de <a hreflang="en" href="https://fingerprintjs.com/">FingerprintJS</a>-bibliotheek onderzocht, die browservingerafdrukken als een service biedt.

{{ figure_markup(
  image="privacy-websites-with-fingerprintjs-library.png",
  caption="Websites die FingerprintJS gebruiken",
  description="Staafdiagram met 0,17% van de desktopsites en 0,18% van de mobiele sites gebruikt FingerprintJS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1556252953&format=interactive",
  sheets_gid="222110824",
  sql_file="percent_of_websites_with_fingerprinting.sql "
  )
}}

Hoewel de bibliotheek slechts op een klein percentage van de websites aanwezig is, kan door het aanhoudende karakter van vingerafdrukken zelfs een klein gebruik een grote impact hebben. Bovendien is FingerprintJS niet de enige poging om vingerafdrukken te nemen. Andere bibliotheken, tools en native code kunnen ook voor dit doel dienen, dus dit is slechts een voorbeeld.

## Platforms voor Toestemmingsbeheer

Banners voor het toestaan van cookies zijn inmiddels gemeengoed. Ze vergroten de transparantie ten aanzien van cookies en stellen gebruikers vaak in staat om hun cookiekeuzes te specificeren. Hoewel veel websites ervoor kiezen om hun eigen implementatie van cookiebanners te gebruiken, zijn er recentelijk oplossingen van derden genaamd <em>Platforms voor Toestemmingsbeheer</em> verschenen. De platforms bieden websites een gemakkelijke manier om de toestemming van de gebruiker te verkrijgen voor verschillende soorten cookies. We zien dat 4,4% van de websites een Platform voor Toestemmingsbeheer gebruikt om cookiekeuzes op desktopclients te beheren en 4,0% op mobiele clients.

{{ figure_markup(
  image="privacy-websites-with-consent-management-platform.png",
  caption="Websites die een Platform voor Toestemmingsbeheer gebruiken",
  description="Staafdiagram met 4,4% van de desktopsites en 4,0% van de mobiele sites gebruikt een Platform voor Toestemmingsbeheer.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=2025542332&format=interactive",
  sheets_gid="1910033502",
  sql_file="percent_of_websites_with_cmp.sql"
  )
}}

{{ figure_markup(
  image="privacy-consent-management-platform-popularity.png",
  caption="Populariteit van het Platform voor Toestemmingsbeheer",
  description="Staafdiagram met populaire Platforms voor Toestemmingsbeheer van Osano met 1,6%, Quantcast Choice met 1,0%, Cookiebot en OneTrust met 0,4%, Iubenda met 0,3%, Crownpeak, Didomi en TrustArc met 0,1%, CIVIC, Cookie Script, CookieHub, Termly, Uniconsent, CookieYes, eucookie.eu, Seers en Metomic allemaal op ongeveer 0,0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341496718&format=interactive",
  sheets_gid="1104760876",
  sql_file="percent_of_websites_using_each_cmp.sql"
  )
}}

Als we kijken naar de populariteit van de verschillende oplossingen voor Toestemmingsbeheer, kunnen we zien dat Osano en Quantcast Choice de leidende platforms zijn.

### Transparency Consent Framework van IAB Europe

IAB Europe, het Interactive Advertising Bureau, is een Europese vereniging voor digitale marketing en reclame. Ze stelden een <a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency Consent Framework</a> (TCF) voor als een AVG-compatibele oplossing om toestemming van gebruikers te verkrijgen over hun digitale advertentievoorkeuren. De implementatie biedt een industriestandaard voor communicatie tussen uitgevers en adverteerders over toestemming van de consument.

{{ figure_markup(
  image="privacy-adoption-of-the-tcf-banner.png",
  caption="Aannemingspercentage van TCF-banner",
  description="Staafdiagram waaruit blijkt dat 1,5% van de desktopsites en 1,4% van de mobiele sites de TCF-banner van IAB Europe heeft geïmplementeerd.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341275612&format=interactive",
  sheets_gid="2077755325",
  sql_file="percent_of_websites_with_iab_tcf_banner.sql"
  )
}}

Hoewel onze resultaten aantonen dat het TCF-uithangbord nog niet de "industriestandaard" is, is het een stap in de goede richting. Aangezien de belangrijkste doelgroep van IAB Europe in feite Europese uitgevers zijn, en onze crawl wereldwijd is, is een acceptatiegraad op 1,5% van de websites op desktopclient en 1,4% op mobiel niet zo slecht.

## Privacy beleid

Privacybeleid wordt veel gebruikt door websites om te voldoen aan wettelijke verplichtingen en om de transparantie naar gebruikers over gegevensverzamelingspraktijken te vergroten. Tijdens onze crawl hebben we gezocht naar trefwoorden die de aanwezigheid van een privacybeleidstekst op elke bezochte website aangeven.

{{ figure_markup(
  image="privacy-websites-with-privacy-link.png",
  caption="Websites met een privacybeleid",
  description="Staafdiagram waaruit blijkt dat 44,8% van de desktopsites en 42,3% van de mobiele sites een privacylink heeft.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=329249623&format=interactive",
  sheets_gid="495362514",
  sql_file="percent_of_websites_with_privacy_links.sql "
  )
}}

De resultaten laten zien dat bijna de helft van de websites in de dataset een privacybeleid heeft opgenomen, wat positief is. Studies hebben echter aangetoond dat de meerderheid van de internetgebruikers het privacybeleid niet leest en als ze dat wel doen, ze geen begrip hebben vanwege de lengte en complexiteit van de meeste teksten over het privacybeleid. Toch is het hebben van beleid een stap in de goede richting!

## Gevolgtrekking

Dit hoofdstuk heeft aangetoond dat tracking door derden prominent blijft op zowel desktop- als mobiele clients, waarbij Google het grootste percentage websites volgt. Platforms voor Toestemmingsbeheer worden gebruikt op een klein percentage websites; Veel websites implementeren echter hun eigen banners voor het toestaan van cookies.

Ten slotte bevat ongeveer de helft van de websites een privacybeleid, wat de transparantie naar gebruikers over gegevensverwerkingspraktijken enorm ten goede komt. Dit is ongetwijfeld een stap voorwaarts, maar er moet nog veel gebeuren. Buiten deze analyse weten we dat het privacybeleid moeilijk te lezen en te begrijpen is en dat cookietoestemmingsbanners gebruikers manipuleren om toestemming te geven.

Voor het web om gebruikers echt te respecteren, moet privacy een onderdeel zijn van de conceptie, niet een bijzaak. Regelgeving is in dit opzicht een goede zaak en het is geruststellend om te zien dat de privacyregelgeving wereldwijd toeneemt. [Privacy by design](https://en.wikipedia.org/wiki/Privacy_by_design) zou de norm moeten zijn, in plaats van beleid en hulpmiddelen in te zetten om aan minimale wettelijke vereisten te voldoen en financiële sancties te vermijden.
