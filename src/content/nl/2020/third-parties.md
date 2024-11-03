---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Derden
description: Hoofdstuk Derden van de Web Almanac 2020 met informatie over welke derden worden gebruikt, waarvoor ze worden gebruikt, impact op de prestaties en impact op de privacy.
authors: [simonhearne]
reviewers: [jzyang, exterkamp]
analysts: [max-ostapenko, paulcalvano]
editors: [tunetheweb]
translators: [noah-vdv]
simonhearne_bio: Simon is een webprestatie-architect. Hij heeft een passie voor het helpen leveren van een sneller en toegankelijker web. U kunt hem vinden op twitter<a href="https://x.com/simonhearne">@SimonHearne</a> en zijn blog <a hreflang="en" href="https://simonhearne.com">simonhearne.com</a>.
discuss: 2042
results: https://docs.google.com/spreadsheets/d/1uW4SMkC45b4EbC4JV1xKAUhwGN2K8j0qFy_jSIYnHhI/
featured_quote: Inhoud van derden komt vaker dan ooit voor, 94% van de pagina's heeft ten minste één bron van derden en de mediaanpagina heeft 24. In dit hoofdstuk bespreken we de prevalentie van inhoud van derden, de impact op het paginagewicht en de browser-CPU, en stellen vervolgens methoden voor om de impact van inhoud van derden op de paginaprestaties te verminderen.
featured_stat_1: 94,1%
featured_stat_label_1: Pagina's met inhoud van derden
featured_stat_2: 21,5%
featured_stat_label_2: Inhoud van derden geleverd als JavaScript
featured_stat_3: 24
featured_stat_label_3: Verzoeken van derden op de mediaanpagina
---

## Inleiding

Inhoud van derden is tegenwoordig een essentieel onderdeel van de meeste websites. Het ondersteunt alles: analyse, livechat, advertenties, video's delen en meer. Content van derden biedt waarde door het zware werk van site-eigenaren uit handen te nemen en stelt hen in staat zich te concentreren op hun kerncompetenties.

Velen beschouwen inhoud van derden als JavaScript-gebaseerd, maar de gegevens laten zien dat dit slechts geldt voor 22% van de verzoeken. Inhoud van derden is er in alle vormen, van afbeeldingen (37%) tot audio (0,1%).

In dit hoofdstuk bespreken we de prevalentie van inhoud van derden en hoe dit is veranderd sinds 2019. We zullen ook bekijken: de impact van inhoud van derden op het paginagewicht (een goede proxy voor de algehele impact op de prestaties), scripts die vroeg worden geladen in de paginalevenscyclus, de impact van inhoud van derden op de CPU-tijd van de browser en hoe open derden zijn met hun prestatiegegevens.

## Definities

Voordat we op de gegevens ingaan, moeten we de terminologie definiëren die in dit hoofdstuk wordt gebruikt.

### "Derde partij"

Een bron van derden is een entiteit buiten de primaire site-gebruikerrelatie. Het betreft de aspecten van de site die niet rechtstreeks onder de controle van de site-eigenaar vallen, maar aanwezig zijn, met hun goedkeuring. Het Google Analytics-script is bijvoorbeeld een veelgebruikte bron van derden.

We beschouwen bronnen van derden als:

* Gehost op een _gedeelde_ en _openbare_ oorsprong
* Op grote schaal gebruikt door verschillende sites
* Niet beïnvloed door een individuele site-eigenaar

Om deze doelen zo goed mogelijk aan te sluiten, is de formele definitie die in dit hoofdstuk wordt gebruikt voor bronnen van derden: een bron die afkomstig is van een domein waarvan de bronnen kunnen worden gevonden op ten minste 50 unieke pagina's in de HTTP Archive-dataset.

Houd er rekening mee dat als u deze definities gebruikt, inhoud van derden die wordt aangeboden vanuit een eerste-partij domein, wordt geteld als een eerste-partij inhoud. Bijvoorbeeld: self-hosting Google Fonts of bootstrap.css wordt geteld als _inhoud van eerste-partijen_.

Evenzo wordt inhoud van derden die wordt aangeboden vanaf een domein van derden, geteld als inhoud van derden. Een bijbehorend voorbeeld: Eerste-partij afbeeldingen die via een CDN op een domein van derden worden weergegeven, worden beschouwd als _inhoud van derden_.

### Provider categorieën

In dit hoofdstuk worden providers van derden in verschillende categorieën onderverdeeld. Bij elk van de categorieën is een korte beschrijving opgenomen. De toewijzing van domein aan categorie kan worden gevonden in de <a lang="en" hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5">third-party-web repository</a>.

* Advertentie - weergave en meting van advertenties
* Analytics - het volgen van het gedrag van sitebezoekers
* CDN - providers die openbare gedeelde hulpprogramma's of privé-inhoud van hun gebruikers hosten
* Inhoud - providers die uitgevers faciliteren en gesyndiceerde inhoud hosten
* Cliëntsucces - ondersteuning en functionaliteit voor cliëntrelatiebeheer
* Hosting - providers die de willekeurige inhoud van hun gebruikers hosten
* Marketing - verkoop, leadgeneratie en e-mailmarketingfunctionaliteit
* Sociaal - sociale netwerken en hun aangesloten integraties
* Tag Manager - provider wiens enige rol is om de opname van andere derde partijen te beheren
* Utility - code die de ontwikkelingsdoelen van de site-eigenaar ondersteunt
* Video - providers die de willekeurige video-inhoud van hun gebruikers hosten
* Overig - niet-gecategoriseerde of niet-conforme activiteit

_Opmerking over CDN's: de CDN-categorie hier omvat providers die bronnen leveren op openbare CDN-domeinen (bijv. Bootstrapcdn.com, cdnjs.cloudflare.com, enz.) En bevat geen bronnen die eenvoudig via een CDN worden aangeboden. d.w.z. als Cloudflare vóór een pagina wordt geplaatst, heeft dit volgens onze criteria geen invloed op de eerste-partij-aanduiding._

### Waarschuwingen

* Alle hier gepresenteerde gegevens zijn gebaseerd op een niet-interactieve, koude belasting. Deze waarden kunnen er na gebruikersinteractie behoorlijk anders uitzien.
* De pagina's worden getest vanaf servers in de VS zonder dat er cookies zijn ingesteld, dus derde partijen die worden aangevraagd na de opt-in zijn niet inbegrepen. Dit heeft met name gevolgen voor pagina's die worden gehost en voornamelijk worden aangeboden aan landen die onder de [Algemene Verordening Gegevensbescherming](https://nl.wikipedia.org/wiki/Algemene_verordening_gegevensbescherming) of andere soortgelijke wetgeving vallen.
* Alleen de startpagina's worden getest. Andere pagina's kunnen andere vereisten van derden hebben.
* Ongeveer 84% van alle domeinen van derden op verzoekvolume zijn geïdentificeerd en gecategoriseerd. De overige 16% valt in de categorie "Overig".

Lees meer over onze [methodologie](./methodology).

## Prevalentie

Een goed uitgangspunt voor deze analyse is om de stelling te bevestigen dat inhoud van derden tegenwoordig een cruciaal onderdeel van de meeste websites is. Hoeveel websites gebruiken inhoud van derden en hoeveel derden gebruiken ze?

{{ figure_markup(
  image="pages-with-thirdparties.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1149547895&format=interactive",
  caption="Pagina's met inhoud van derden",
  description="De prevalentie van inhoud van derden is licht gestegen sinds 2019. In 2019 had 93,6% van de mobiele pagina's inhoud van derden, in 2020 was dit 94,1%. In 2019 had 93,6% van de desktoppagina's inhoud van derden, in 2020 was dit 93,9%.",
  width=600,
  height=371,
  sheets_gid="1477664642",
  sql_file="percent_of_websites_with_third_party.sql"
  )
}}

Deze prevalentiecijfers laten een lichte stijging zien ten opzichte van [de resultaten van 2019](../2019/third-parties): 93,87% van de pagina's in de desktopcrawl had ten minste één verzoek van een derde partij, het aantal was iets hoger met 94,10% van pagina's in de mobiele crawl. Een korte blik op het kleine aantal pagina's zonder inhoud van derden onthulde dat veel sites voor volwassenen waren, sommige regeringsdomeinen en sommige eenvoudige bestemmings-/bewaarpagina's met weinig inhoud. Het is eerlijk om te zeggen dat de overgrote meerderheid van de pagina's ten minste één derde partij heeft.

De onderstaande grafiek toont de verdeling van pagina's op basis van het aantal derden. De 10e percentielpagina heeft twee verzoeken van derden, terwijl de mediaanpagina 24 heeft. Meer dan 10% van de pagina's heeft meer dan 100 verzoeken van derden.

{{ figure_markup(
  image="distribution-of-request-count.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1394563639&format=interactive",
  caption="Verspreiding van verzoeken van derden.",
  description="Percentieldiagram van pagina's op verzoek van derden. De gemiddelde mobiele website heeft 24 verzoeken van derden (23 op desktop) en stijgt exponentieel van 2 verzoeken voor beide op het 10e percentiel tot 104 verzoeken op mobiel en 106 verzoeken op desktop op het 90e percentiel.",
  width=600,
  height=371,
  sheets_gid="181718921",
  sql_file="distribution_of_third_parties_by_number_of_websites.sql"
  )
}}

### Inhoudstypen

We kunnen verzoeken van derden opsplitsen op basis van hun inhoudstype. Dit is het gerapporteerde [inhoudstype](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) van de bronnen die worden geleverd vanuit domeinen van derden.

{{ figure_markup(
  image="thirdparty-by-content-types.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=258155228&format=interactive",
  caption="Inhoud van derden op type",
  description="Afbeeldingen en JavaScript zijn goed voor de meerderheid (60%) van de inhoud van derden: 37,1% van de inhoud van derden zijn afbeeldingen, 21,9% is JavaScript, 16,1% is onbekend of anders, 15,4% is HTML",
  width=600,
  height=371,
  sheets_gid="53929561",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

De resultaten tonen aan dat de belangrijkste bijdragers aan inhoud van derden afbeeldingen (38%) en JavaScript (22%) zijn, waarbij de op een na grootste bijdrage onbekend is (16%). Onbekend is een subset van niet-gecategoriseerde groepen, zoals tekst/plain en reacties zonder een inhoudstype koptekst.

Dit toont een verschuiving wanneer [vergeleken met 2019](../2019/third-parties#resource-types): relatieve afbeeldingsinhoud is gestegen van 33% naar 38%, terwijl JavaScript-inhoud aanzienlijk afgenomen is van 32% naar 22%. Deze vermindering is waarschijnlijk het gevolg van een betere naleving van de cookie- en gegevensbeschermingsregels, waardoor de uitvoering door derden wordt verminderd tot na de expliciete aanmelding van de gebruiker, wat buiten het bereik valt van HTTP Archive-testruns.

### Domeinen van derden

Wanneer we dieper ingaan op domeinen die inhoud van derden aanbieden, zien we dat Google Fonts verreweg de meest voorkomende is. Het is aanwezig op meer dan 7,5% van de geteste mobiele pagina's. Hoewel lettertypen slechts ongeveer 3% van de inhoud van derden uitmaken, worden deze bijna allemaal geleverd door de Google Fonts-service. Als uw pagina Google Fonts gebruikt, volg dan de <a hreflang="en" href="https://csswizardry.com/2020/05/the-fastest-google-fonts/">beste praktijken</a> om de best mogelijke gebruikerservaring te garanderen.

{{ figure_markup(
  image="top-domains-by-prevalence.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=2082639138&format=interactive",
  caption="Topdomeinen op basis van prevalentie.",
  description="Staafdiagram met de topdomeinen op basis van prevalentie. De meest voorkomende domeinen zijn lettertypegieterijen, advertenties, sociale media en JavaScript-CDN's",
  width=600,
  height=371,
  sheets_gid="583962013",
  sql_file="top100_third_parties_by_number_of_websites.sql"
  )
}}

De volgende vier meest voorkomende domeinen zijn allemaal advertentieproviders. Ze worden mogelijk niet rechtstreeks door de pagina aangevraagd, maar via een complexe reeks omleidingen die worden geïnitieerd door een ander advertentienetwerk.

Het zesde meest voorkomende domein is `digicert.com`. Aanroepen naar `digicert.com` zijn over het algemeen OCSP-intrekkingscontroles omdat TLS-certificaten OCSP-nieten niet hebben ingeschakeld, of het gebruik van Extended Validation (EV)-certificaten die pinnen van tussenliggende certificaten voorkomen. Dit aantal is overdreven in HTTP Archive omdat alle paginaladingen in feite de eerste keer zijn - OCSP-reacties worden over het algemeen in de cache opgeslagen en zijn zeven dagen geldig tijdens het browsen in de echte wereld. Zie <a hreflang="en" href="https://simonhearne.com/2020/drop-ev-certs/">deze blogpost</a> voor meer informatie over dit probleem.

Verderop in de lijst met 2,43% staat `ajax.googleapis.com`, het <a hreflang="en" href="https://developers.google.com/speed/libraries">Hosted Libraries-project</a> van Google. Hoewel het laden van een bibliotheek zoals jQuery van een gehoste service eenvoudig is, kunnen de extra kosten van een verbinding met een domein van een derde partij een negatieve invloed hebben op de prestaties. Het is het beste om, indien mogelijk, alle kritieke JavaScript en CSS op het hoofddomein te hosten. Er is nu ook geen cachevoordeel bij het gebruik van een gedeelde CDN-bron, aangezien alle grote browsers <a hreflang="en" href="https://developers.google.com/web/updates/2020/10/http-cache-partitioning">caches per pagina partitioneren</a>. Harry Roberts heeft een gedetailleerde blogpost geschreven over <a hreflang="en" href="https://csswizardry.com/2019/05/self-host-your-static-assets/">hoe u uw eigen statische activa kunt hosten</a>.

## Impact van paginagewicht

Derden kunnen een aanzienlijke invloed hebben op het gewicht van een pagina, gemeten als het aantal bytes dat door de browser is gedownload. Het [Paginagewicht hoofdstuk](./page-weight) gaat hier meer in detail op in, hier richten we ons op de derde partijen die de grootste impact hebben op het paginagewicht.
### Zwaarste derde partijen

We kunnen de grootste derde partijen extraheren op basis van de gemiddelde impact op het paginagewicht, d.w.z. hoeveel bytes ze meenemen naar de pagina's waarop ze zich bevinden. De resultaten zijn interessant omdat hierbij geen rekening wordt gehouden met hoe populair de derde partijen zijn, maar alleen met hun impact in bytes.

{{ figure_markup(
  image="page-size-by-host.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=429818290&format=interactive",
  caption="Bijdrage van derden door host.",
  description="Grafiek van hosts van derden en impact op paginaformaat, variërend van trailercentral.com met 2,7MB tot contenservice.mc.reyrey.net met 510KB. Mediaproviders leveren de grootste bijdrage aan paginagrootte.",
  width=600,
  height=371,
  sheets_gid="1423970958",
  sql_file="top100_third_parties_by_median_body_size_and_time.sql"
  )
}}

De grootste bijdragers aan paginagewicht zijn over het algemeen aanbieders van media-inhoud, zoals het hosten van afbeeldingen en video's. Vidazoo resulteert bijvoorbeeld in een mediaan impact van ongeveer 2,5MB. Het domein `inventory.vidazoo.com` biedt videohosting, dus een mediaanpagina bij deze derde partij heeft _extra_ 2,5MB aan media-inhoud!

Een eenvoudige methode om deze impact te verminderen, is door het laden van video uit te stellen totdat een gebruiker interactie heeft met de pagina, zodat de impact wordt verminderd voor die bezoekers die de video nooit consumeren.

We kunnen deze analyse verder uitvoeren om een verdeling van de totale paginagrootte (in bytes gedownload voor alle bronnen) te produceren op basis van aanwezigheid in categorieën van derden. Deze grafiek laat zien dat de aanwezigheid van de meeste categorieën van derden geen merkbare impact heeft op de totale paginagrootte: dit zou zichtbaar zijn als een divergentie in de plots. Een opmerkelijke uitzondering hierop is Advertising (in het zwart), dat een zeer kleine relatie vertoont met de paginagrootte, wat aangeeft dat advertentieverzoeken geen significant gewicht aan pagina's toevoegen. Dit komt waarschijnlijk omdat veel van deze verzoeken kleine omleidingen zijn, de [mediaan is slechts 420 bytes](#grote-omleidingen). We zien een vergelijkbare lage impact voor tagmanagers en analyses.

Aan de andere kant van het spectrum vertegenwoordigen de categorieën CDN, Inhoud en Hosting allemaal een sterke relatie met het totale paginagewicht. Dit geeft aan dat sites die gehoste services gebruiken over het algemeen een groter paginagewicht hebben.

{{ figure_markup(
  image="page-size-by-category.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1508418357&format=interactive",
  caption="Verdelingen van paginaformaat per categorie van derden.",
  description="Verdeling van categorieën van derden en paginagrootte die de relaties laat zien tussen de aanwezigheid van derden en de waarschijnlijkheid dat pagina's groot zijn. CDN & Hosting vertonen een sterke correlatie, Analytics laat een zwakke correlatie zien.",
  width=600,
  height=371,
  sheets_gid="727028027",
  sql_file="distribution_of_size_and_time_by_third_parties.sql"
  )
}}

### <span lang="en">Cacheability</span> {cacheability}

Sommige reacties van derden moeten altijd in de cache worden opgeslagen. Media zoals afbeeldingen en video's die door een derde partij worden aangeboden, of JavaScript-bibliotheken zijn goede kandidaten. Aan de andere kant mogen trackingpixels en analysebakens nooit in de cache worden opgeslagen. De resultaten laten zien dat in totaal tweederde van de verzoeken van derden wordt bediend met een geldige caching-header, zoals `Cache-Control`.

{{ figure_markup(
  image="requests-cached-by-content-type.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=299325299&format=interactive",
  caption="Verzoeken van derden in het cachegeheugen op inhoudstype.",
  description="Kolomdiagram met het percentage cacheverzoeken per inhoudstype. Lettertypen zijn het hoogst met 96%, XML is het laagst met 18%",
  width=600,
  height=371,
  sheets_gid="1363055589",
  sql_file="percent_of_third_party_cache.sql"
  )
}}

Een opsplitsing naar reactietype bevestigt onze veronderstellingen: xml- en tekstreacties (zoals gewoonlijk geleverd door trackingpixels/analysebakens) zijn minder waarschijnlijk cachebaar. Verrassend genoeg is minder dan tweederde van de afbeeldingen die door derden worden aangeboden cachebaar is. Bij nadere inspectie is dit te wijten aan het gebruik van tracking 'pixels' die worden geretourneerd als niet-cachebare GIF-afbeeldingsreacties met nulgrootte.

### Grote omleidingen

Veel derde partijen resulteren in omleidingsreacties, d.w.z. HTTP-statuscodes 3XX. Deze treden op vanwege het gebruik van ijdel-domeinen of om informatie tussen domeinen te delen via aanvraagheaders. Dit geldt met name voor advertentienetwerken. Grote omleidingsreacties zijn een indicatie van een verkeerde configuratie, aangezien de respons rond de 340B zou moeten zijn voor een geldige `Location` antwoordheader plus overhead. De onderstaande grafiek toont de verdeling van de lichaamsgrootte voor alle omleidingen van derden in het HTTP Archive.

{{ figure_markup(
  image="redirects-body-size.png",
  caption="Verdeling van 3XX-lichaamsgrootte van derden",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1145900631&format=interactive",
  description="Verdeling van omleidingslichaamgroottes waaruit blijkt dat 90% kleiner is dan 420B, 1% groter is dan 30kB en 0,1% groter is dan 100kB.",
  width=600,
  height=371,
  sheets_gid="1056232541",
  sql_file="distribution_of_3XX_response_body_size.sql"
  )
}}

De resultaten laten zien dat de meerderheid van de 3XX-reacties klein is: het 90e percentiel is 420 bytes, d.w.z. 90% van de 3XX-reacties is 420 bytes of kleiner. Het 95e percentiel is 6,5kB, het 99e is 36kB en het 99.9e is meer dan 100kB! Hoewel omleidingen onschadelijk lijken, is 100kB een onredelijk aantal bytes over de draad voor een reactie die eenvoudigweg tot een andere reactie leidt.

## Vroege laders

Scripts die laat op de pagina worden geladen, hebben invloed op de totale laadduur van de pagina en het paginagewicht, maar hebben mogelijk geen invloed op de gebruikerservaring. Scripts die vroeg op de pagina worden geladen, zullen echter mogelijk bandbreedte kannibaliseren voor kritieke eerste-partij bronnen en zullen het laden van de pagina waarschijnlijk verstoren. Dit kan een nadelige invloed hebben op prestatiestatistieken en gebruikerservaring.

De onderstaande grafiek toont het percentage verzoeken dat vroeg wordt geladen, per apparaattype en categorie van derden. De drie opvallende categorieën zijn CDN, Hosting en Tag Managers: die allemaal de neiging hebben om JavaScript te leveren dat in de kop van een document wordt gevraagd. Advertentiebronnen worden het minst vroeg op de pagina geladen, omdat advertentienetwerkverzoeken over het algemeen asynchrone scripts zijn die worden uitgevoerd nadat de pagina is geladen.

{{ figure_markup(
  image="requests-before-dom-by-category.png",
  caption="Vroege verzoeken van derden per categorie.",
  description="Kolomdiagram met het percentage verzoeken dat is geladen voordat DOM-inhoud is geladen. Openbare CDN-bronnen zijn hoogstwaarschijnlijk 50% op desktop, terwijl advertentiebronnen het minst waarschijnlijk zijn 7%",
  width=600,
  height=371,
  sheets_gid="2118409936",
  sql_file="percent_of_third_party_loaded_before_DOMContentLoaded.sql"
  )
}}

## CPU-impact

Niet alle bytes op het web zijn gelijk: een afbeelding van 500KB is misschien veel gemakkelijker voor een browser om te verwerken dan een gecomprimeerde JavaScript-bundel van 500KB, die oploopt tot 1,8MB aan cliëntzijde code! De impact van scripts van derden op de CPU-tijd kan veel kritischer zijn dan de extra bytes of tijd die op het netwerk wordt doorgebracht.

We kunnen de aanwezigheid van categorieën van derden correleren met de totale CPU-tijd op de pagina, dit stelt ons in staat om de impact van elke categorie van derden op de CPU-tijd te schatten.

{{ figure_markup(
  image="cpu-time-by-category.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=225817673&format=interactive",
  caption="Verdeling van CPU-tijd per categorie.",
  description="Verdeling van de CPU-laadtijd door de aanwezigheid van categorieën van derden. De meeste categorieën volgen hetzelfde patroon, waarbij reclame voor de uitbijter een hogere CPU-laadtijd laat zien, vooral bij lagere percentielen.",
  width=600,
  height=371,
  sheets_gid="727028027",
  sql_file="distribution_of_size_and_time_by_third_parties.sql"
  )
}}

Deze grafiek toont de kansdichtheidsfunctie van de totale CPU-tijd van de pagina door de categorieën van derden die op elke pagina aanwezig zijn. De mediaanpagina staat op 50 op de percentielas. De gegevens laten zien dat alle categorieën van derden een vergelijkbaar patroon volgen, met een gemiddelde pagina tussen de 400 - 1.000 ms CPU-tijd. De uitbijter hier is adverteren (in het zwart): als een pagina reclametags heeft, is de kans veel groter dat het CPU-gebruik tijdens het laden van de pagina wordt verhoogd. De mediaanpagina met reclametags heeft een CPU-laadtijd van 1.500 ms, vergeleken met 500 ms voor pagina's zonder reclame. De hoge CPU-laadtijd bij de lagere percentielen geeft aan dat zelfs de snelste sites aanzienlijk worden beïnvloed door de aanwezigheid van derden die als advertenties worden gecategoriseerd.

## Prevalentie van `timing-allow-origin`

Met de [Resource Timing API](https://developer.mozilla.org/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API) kunnen website-eigenaren de prestaties van individuele bronnen meten via JavaScript. Deze gegevens zijn standaard extreem beperkt voor bronnen van verschillende oorsprong, zoals inhoud van derden. Er zijn legitieme redenen om deze timinginformatie niet te verstrekken, zoals reacties die verschillen per authenticatiestatus: bijv. een website-eigenaar kan mogelijk bepalen of een bezoeker is ingelogd op Facebook door de responsgrootte van een widgetverzoek te meten. Voor de meeste inhoud van derden is het instellen van de `timing-allow-origin`-header echter een daad van transparantie om de hostingwebsite in staat te stellen de prestaties en de grootte van hun inhoud van derden te volgen.

{{ figure_markup(
  image="requests-with-tao.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1886505312&format=interactive",
  caption="Verzoeken met de `timing-allow-origin` koptekst.",
  description="Minder dan 35% van de reacties van derden wordt weergegeven met een timing-allow-origin-header",
  width=600,
  height=371,
  sheets_gid="1947152286",
  sql_file="tao_by_third_party.sql"
  )
}}

De resultaten in HTTP Archive laten zien dat slechts een derde van de reacties van derden gedetailleerde informatie over grootte en timing aan de hostingwebsite blootlegt.

## Gevolgen

We weten dat het toevoegen van willekeurig JavaScript aan onze sites risico's met zich meebrengt voor zowel de sitesnelheid als de veiligheid. Site-eigenaren moeten ijverig zijn om de waarde van de scripts van derden die ze bevatten in evenwicht te brengen met de snelheidsbeperking die ze met zich meebrengen, en moderne functies gebruiken, zoals [integriteit van subbronnen](https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity) en [content security policy](https://developer.mozilla.org/docs/Web/HTTP/CSP) om een sterke beveiligingshouding te behouden. Zie het [hoofdstuk Beveiliging](./security) voor meer informatie over deze en andere browserbeveiligingsfuncties.

## Gevolgtrekking

Een van de verrassingen in de data uit 2020 is de daling van de relatieve JavaScript-verzoeken: van 32% van het totaal naar slechts 22%. Het is onwaarschijnlijk dat de werkelijke hoeveelheid JavaScript op internet dit aanzienlijk heeft afgenomen, het is waarschijnlijker dat websites toestemmingsbeheer implementeren, zodat de meeste dynamische inhoud van derden alleen wordt geladen wanneer de gebruiker zich aanmeldt. Dit aanmeldingsproces kan in sommige gevallen worden beheerd door een Platform voor Toestemmingsbeheer (CMP). De database van derden heeft nog geen categorie voor CMP's, maar dit zou een goede analyse zijn voor de 2021 Web Almanac en wordt behandeld via een andere methodologie in [het hoofdstuk Privacy](./privacy#platforms-voor-toestemmingsbeheer).

Advertentieverzoeken lijken een grotere impact te hebben op de CPU-tijd. De mediaanpagina met advertentiescripts verbruiken drie keer zoveel CPU als die zonder. Interessant is echter dat advertentiescripts niet gecorreleerd zijn met een verhoogd paginagewicht. Dit maakt het nog belangrijker om de totale impact van scripts van derden op de browser te evalueren, niet alleen het aantal aanvragen en de grootte.

Hoewel inhoud van derden van cruciaal belang is voor veel websites, is het van cruciaal belang om de impact van elke provider te controleren om ervoor te zorgen dat ze geen significante invloed hebben op de gebruikerservaring, het paginagewicht of het CPU-gebruik. Er zijn vaak self-hosting-opties voor de belangrijkste bijdragers aan het gewicht van derden, dit is vooral het overwegen waard omdat er nu geen cachevoordeel is bij het gebruik van gedeelde activa:

* Google Fonts staat <a hreflang="en" href="https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/">self-hosting</a> van de items toe
* JavaScript CDN's kunnen worden vervangen door zelfgehoste middelen
* Experimentatiescripts kunnen zelf worden gehost, bijv. <a hreflang="en" href="https://help.optimizely.com/Set_Up_Optimizely/Optimizely_self-hosting_for_Akamai_users">Optimizely</a>

In dit hoofdstuk hebben we de voordelen en kosten van inhoud van derden op internet besproken. We hebben gezien dat derde partijen een integraal onderdeel zijn van bijna alle websites en dat de impact verschilt per externe aanbieder. Voordat u een nieuwe derde partij aan uw pagina's toevoegt, moet u rekening houden met de impact die ze zullen hebben!
