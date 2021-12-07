---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: PWA-hoofdstuk van de Web Almanac van 2020 met betrekking tot service workers (registraties, installeerbaarheid, gebeurtenissen en bestandsgroottes), eigenschappen van Web App Manifesten en Workbox.
authors: [hemanth]
reviewers: [thepassle, jadjoubran, pearlbea, gokulkrishh]
analysts: [tunetheweb]
editors: [tunetheweb]
translators: [noah-vdv]
hemanth_bio: <a hreflang="en" href="https://h3manth.com">Hemanth HM</a> is een computer-polyglot, FOSS-filosoof, GDE voor web- en betalingsdomein, DuckDuckGo-communitylid, TC39-afgevaardigde en Google Launchpad Accelerator-mentor. Houdt van de WEB && CLI. Host de podcast <a hreflang="en" href="https://TC39er.us">TC39er.us</a>.
discuss: 2050
results: https://docs.google.com/spreadsheets/d/1AOqCkb5EggnE8BngpxvxGj_fCfssT9sZ0ElCQKp4pOw/
featured_quote: Webapplicatie die evolueert naar een native-achtige applicatie kan worden beschouwd als een PWA.
featured_stat_1: 16,6%
featured_stat_label_1: Percentage pagina dat wordt geladen met behulp van een service worker
featured_stat_2: 27,97%
featured_stat_label_2: Webapps die snel genoeg laden voor een PWA
featured_stat_3: 25%
featured_stat_label_3: Percentage mobiele PWA-sites dat importScripts gebruikt
---

## Inleiding

In 1990 werd de allereerste browser met de naam "WorldWideWeb" gelanceerd en sindsdien hebben het web en de browser zich ontwikkeld. Dat het web zichzelf ontwikkelt tot native applicatiegedrag, is een grote overwinning, vooral in dit tijdperk van mobiele dominantie. URL's en webbrowsers hebben gezorgd voor een alomtegenwoordige manier om informatie te verspreiden en daarom is een technologie die native app-mogelijkheden voor de browser biedt een game-wisselaar. Progressieve Web Apps bieden zulke voordelen voor het web om te concurreren met andere applicaties.

Simpel gezegd, een webapplicatie die native-achtige applicatie-ervaring biedt, kan worden beschouwd als een PWA. Het is gebouwd met behulp van veelgebruikte webtechnologieën, waaronder HTML, CSS en JavaScript, en kan naadloos werken op verschillende apparaten en omgevingen in een browser die aan de standaarden voldoet.

De crux van een progressieve webapp is de _service worker_, die kan worden gezien als een proxy die zich tussen de browser en de gebruiker bevindt. Een service worker geeft de ontwikkelaar volledige controle over het netwerk, in plaats van dat het netwerk de applicatie bestuurt.

Zoals [het hoofdstuk van vorig jaar](../2019/pwa) al zei, begon het in december 2014 toen Chrome 40 voor het eerst het vlees implementeerde van wat nu bekend staat als Progressieve Web Apps (PWA). Dit was een gezamenlijke inspanning van de instantie voor webstandaarden en de term PWA werd bedacht door <a hreflang="en" href="https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/">Frances Berriman en Alex Russell</a> in 2015.

In dit hoofdstuk van Web Almanac zullen we elk van de componenten bekijken die PWA maken tot wat het is, vanuit een datagestuurd perspectief.

## Service workers

Service workers staan centraal in progressieve webapps. Ze helpen ontwikkelaars de netwerkverzoeken te beheren.

### Gebruik van service workers

Uit de gegevens die we hebben verzameld, kunnen we zien dat ongeveer 0,88% desktopsites en 0,87% mobiele sites een service worker gebruiken. Dit was voor de maand augustus 2020 en, om dat in perspectief te plaatsen, dat komt neer op 49.305 (van de 5.593.642) desktopsites en 55.019 (van de 6.347.919) mobiele sites.

{{ figure_markup(
  image="pwa-timeseries-of-service-worker-installations.png",
  caption="Tijdreeks van installatie van service workers.",
  description="Lijndiagram van de installatie van service workers beginnend bij 0,03% voor desktop, 0,04% voor mobiel in januari 2017 en groeit ruwweg lineair tot 0,88% voor desktop en 0,87% voor mobiel. Over het algemeen volgen desktop en mobiel elkaar op de voet met mobiel sneller dan desktop tot medio 2018, wat lijkt op een anomalie voor de tweede helft van 2018 en vervolgens desktop sneller dan mobiel vanaf begin 2019 tot nu.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1883263914&format=interactive",
  sheets_gid="1626594877",
  sql_file="sw_adoption_over_time.sql"
  )
}}

Hoewel dat gebruik misschien laag lijkt, is het belangrijk dat we ons realiseren dat andere metingen dat gelijkstellen aan 16,6% van het <a hreflang="en" href="https://www.chromestatus.com/metrics/feature/timeline/popularity/990">webverkeer</a> - dit verschil is te wijten aan websites met veel verkeer die vaker service workers gebruiken.

## Lighthouse inzichten

<a hreflang="en" href="https://github.com/GoogleChrome/lighthouse">Lighthouse</a> biedt geautomatiseerde audits, prestatiestatistieken en praktische tips voor het web en heeft een belangrijke rol gespeeld bij het vormgeven van de prestaties van het web. We hebben gekeken naar de PWA-categorie-audits die zijn verzameld voor meer dan 6.782.042 pagina's en dit heeft ons geweldige inzichten gegeven over een paar belangrijke touchpoints.

<figure>
  <table>
    <thead>
      <tr>
        <th>Lighthouse Audit</th>
        <th>Gewicht</th>
        <th>Percentage</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code lang="en">load-fast-enough-for-pwa</code></td>
        <td class="numeric">7</td>
        <td class="numeric">27,97%*</td>
      </tr>
      <tr>
        <td><code lang="en">works-offline</code></td>
        <td class="numeric">5</td>
        <td class="numeric">0,86%</td>
      </tr>
      <tr>
        <td><code lang="en">installable-manifest</code></td>
        <td class="numeric">2</td>
        <td class="numeric">2,21%</td>
      </tr>
      <tr>
        <td><code lang="en">is-on-https</code></td>
        <td class="numeric">2</td>
        <td class="numeric">66,67%</td>
      </tr>
      <tr>
        <td><code lang="en">redirects-http</code></td>
        <td class="numeric">2</td>
        <td class="numeric">70,33%</td>
      </tr>
      <tr>
        <td><code lang="en">viewport</code></td>
        <td class="numeric">2</td>
        <td class="numeric">88,43%</td>
      </tr>
      <tr>
        <td><code lang="en">apple-touch-icon</code></td>
        <td class="numeric">1</td>
        <td class="numeric">34,75%</td>
      </tr>
      <tr>
        <td><code lang="en">content-width</code></td>
        <td class="numeric">1</td>
        <td class="numeric">79,37%</td>
      </tr>
      <tr>
        <td><code lang="en">maskable-icon</code></td>
        <td class="numeric">1</td>
        <td class="numeric">0,11%</td>
      </tr>
      <tr>
        <td><code>offline-start-url</code></td>
        <td class="numeric">1</td>
        <td class="numeric">0,75%</td>
      </tr>
      <tr>
        <td><code lang="en">service-worker</code></td>
        <td class="numeric">1</td>
        <td class="numeric">1,03%</td>
      </tr>
      <tr>
        <td><code lang="en">splash-screen</code></td>
        <td class="numeric">1</td>
        <td class="numeric">1,90%</td>
      </tr>
      <tr>
        <td><code lang="en">themed-omnibox</code></td>
        <td class="numeric">1</td>
        <td class="numeric">4,00%</td>
      </tr>
      <tr>
        <td><code lang="en">without-javascript</code></td>
        <td class="numeric">1</td>
        <td class="numeric">97,57%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Lighthouse PWA-audits.", sheets_gid="814184412", sql_file="lighthouse_pwa_audits.sql") }}</figcaption>
</figure>

<p class="note">Merk op dat de prestatiestatistieken voor onze Lighthouse-tests onjuist waren voor onze crawl van augustus, dus het resultaat <code lang="en">load-fast-done-for-pwa</code> is vervangen door de resultaten van september.</p>

Een <a hreflang="en" href="https://web.dev/load-fast-enough-for-pwa/">snelle paginalading</a> zorgt voor een goede mobiele gebruikerservaring, vooral wanneer rekening wordt gehouden met langzamere mobiele netwerken. 27,56% van de pagina's werd snel genoeg geladen voor een PWA. Gezien de geografische spreiding van het web, is een snelle laadtijd met lichtere pagina's de meeste van de volgende miljard gebruikers van het web, van wie de meesten via een mobiel apparaat op internet zullen komen.

Als u een progressieve web-app bouwt, overweeg dan om een service worker te gebruiken zodat uw app <a hreflang="en" href="https://web.dev/works-offline/">offline kan werken</a>, 0,92% van de pagina's was offline gereed.

Browsers kunnen gebruikers proactief vragen om uw app aan hun startscherm toe te voegen, wat kan leiden tot een grotere betrokkenheid. 2,21% van de pagina's had een <a hreflang="en" href="https://web.dev/installable-manifest/">installeerbaar manifest</a>. Manifest speelt een belangrijke rol bij het starten van de applicatie, het uiterlijk en gevoel van het icoon op het startscherm en als direct impact op de betrokkenheidspercentage.

Alle sites moeten worden beschermd met HTTPS, zelfs sites die geen gevoelige gegevens verwerken. Dit omvat het vermijden van <a hreflang="en" href="https://developers.google.com/web/fundamentals/security/prevent-mixed-content/what-is-mixed-content">gemengde inhoud</a>, waar sommige bronnen via HTTP worden geladen ondanks dat het eerste verzoek via HTTPS wordt bediend. HTTPS voorkomt dat indringers knoeien met of passief luisteren naar de communicatie tussen uw app en uw gebruikers en is een vereiste voor service workers en veel nieuwe webplatformfuncties en API's zoals [HTTP/2](./http). De <a hreflang="en" href="https://web.dev/is-on-https/">is-on-https-check</a> laat zien dat 67,27% van de sites op HTTPS was zonder gemengde inhoud en het is verrassend dat we nog niet hoger zijn gekomen. Het hoofdstuk [Beveiliging](./security#transportbeveiliging) laat zien dat 86,91% van de sites HTTPS gebruikt, wat suggereert dat gemengde inhoud nu het grootste probleem kan zijn. Dit aantal wordt beter naarmate browsers de applicaties verplichten op HTTPS te staan ​​en die welke niet op HTTPS staan, meer nauwkeurig te bekijken.

Als u HTTPS al hebt ingesteld, zorg er dan voor dat u <a hreflang="en" href="https://web.dev/redirects-http/">al het HTTP-verkeer omleidt naar HTTPS</a> om een veilige verbinding met de gebruikers mogelijk te maken zonder de URL te wijzigen: alleen 69,92 % van de sites slaagt voor deze audit. Het omleiden van alle HTTP naar HTTPS in uw applicatie zou eenvoudige stappen moeten zijn in de richting van robuustheid, hoewel de HTTP-omleiding naar HTTPS een behoorlijk aantal passerende sites heeft, kan het beter presteren.

Door de tag `<meta name="viewport">` toe te voegen, optimaliseert u uw app voor mobiele schermen. 88,43% van de sites heeft de metatag <a hreflang="en" href="https://web.dev/viewport/">viewport</a>. Het is niet verwonderlijk dat het gebruik van viewport-metatag aan de hogere kant is, aangezien de meeste ontwikkelaars en hulpmiddelen op de hoogte zijn van viewport-optimalisatie.

Voor een ideaal uiterlijk op iOS moet uw progressieve web-app een metatag met `apple-touch-icon` definiëren. Het moet verwijzen naar een niet-transparante vierkante PNG van 192 px (of 180 px). 32,34% van de sites doorstaat de controle <a hreflang="en" href="https://web.dev/apple-touch-icon/">apple touch icon</a>.

If the width of your app's content doesn't match the width of the viewport, your app might not be optimized for mobile screens. 79.18% of the sites have the <a hreflang="en" href="https://web.dev/content-width/">content-width</a> set correctly.

Een <a hreflang="en" href="https://web.dev/maskable-icon-audit/">maskeerbaar pictogram</a> zorgt ervoor dat de afbeelding de hele vorm vult zonder dat er letterboxen ontstaan bij het toevoegen van de progressieve web-app aan het startscherm. Slechts 0,11% van de sites gebruikt dit, maar aangezien het een geheel nieuwe functie is, is het bemoedigend om hier gebruik van te maken. Omdat het net is geïntroduceerd, verwachtten we dat de cijfers erg laag zouden zijn en deze zouden de komende jaren moeten verbeteren.

Een service worker zorgt ervoor dat uw web-app betrouwbaar is in onvoorspelbare netwerkomstandigheden. 0,77% van de sites heeft een <a hreflang="en" href="https://web.dev/offline-start-url/">offline start-URL</a> zodat de app kan worden uitgevoerd, zelfs als deze niet met het netwerk is verbonden. Dit is een van de belangrijkste kenmerken van een PWA, aangezien slechte netwerken het meest voorkomende probleem zijn waarmee gebruikers van web-apps worden geconfronteerd.

De <a hreflang="en" href="https://web.dev/service-worker/">service worker</a> is de functie waarmee uw app veel Progressieve Web App-functies kan gebruiken, zoals offline gebruik en pushmeldingen. Op 1,05% van de pagina's zijn service wookers ingeschakeld. Gezien de krachtige functies die kunnen worden aangepakt met service workers, en dat deze al enige tijd wordt ondersteund, is het verrassend dat het aantal nog steeds zo laag is.

Een <a hreflang="en" href="https://web.dev/splash-screen/">opstartscherm</a> met een thema zorgt voor een native-achtige ervaring wanneer gebruikers uw app starten vanaf hun startscherm. 1,95% van de pagina's had opstartschermen.

De adresbalk van de browser kan een thema hebben dat bij uw site past. 4,00% van de pagina's had een <a hreflang="en" href="https://web.dev/themed-omnibox/">omnibox</a> thema.

Uw app zou wat inhoud moeten weergeven wanneer JavaScript is uitgeschakeld, ook al is het slechts een waarschuwing voor de gebruiker dat JavaScript vereist is om de app te gebruiken. 97,57% van de pagina's toont meer dan alleen een lege pagina met JavaScript <a hreflang="en" href="https://web.dev/without-javascript/">uitgeschakeld</a>. Aangezien we alleen de startpagina's onderzoeken, is het misschien meer verrassend dat 3,43% van de sites deze audit niet haalt!

## Gebeurtenissen voor service workers

Bij een service worker kan naar een aantal gebeurtenissen worden geluisterd:

1. `install`, wat gebeurt bij de installatie van een service worker.
2. `activate`, wat gebeurt bij activering van de service worker.
3. `fetch`, wat gebeurt wanneer een bron wordt opgehaald.
4. `push`, wat gebeurt wanneer een push-melding binnenkomt.
5. `notificationclick`, wat gebeurt wanneer er op een melding wordt geklikt.
6. `notificationclose`, wat gebeurt wanneer een melding wordt gesloten.
7. `message`, wat gebeurt wanneer een bericht verzonden via postMessage() binnenkomt.
8. `sync`, wat gebeurt wanneer een achtergrondsynchronisatiegebeurtenis plaatsvindt.

We hebben onderzocht naar welke van deze gebeurtenissen wordt geluisterd door service workers in onze dataset.

{{ figure_markup(
  image="pwa-most-used-service-worker-events.png",
  caption="Meest gebruikte gebeurtenissen voor service workers.",
  description="Staafdiagram met het percentage van de meest gebruikte service workersgebeurtenissen, met `install` gebruikt door 69% van de desktopsites met service workers en 73% van de mobiele sites, `fetch` gebruikt door 66% en 71% `activate` gebruikt door 55% en 59%, `notificationclick` met 24% en 20%, `push` met 23% en 20%, `message` met 8% en 6%, `notificationclose` met 3% voor zowel desktop als mobiel, en `sync` gebruikt door 1% van beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1964906335&format=interactive",
  sheets_gid="1698485238",
  sql_file="sw_events.sql"
  )
}}

 De resultaten voor mobiel en desktop lijken erg op elkaar, waarbij `install`, `fetch` en `activate` de drie meest populaire gebeurtenissen zijn, gevolgd door `message`, `notificationclick`, `push` en `sync`. Als we deze resultaten interpreteren, zijn offline use-cases die service workers inschakelen de meest aantrekkelijke functie voor app-ontwikkelaars, ver vooruit op pushmeldingen. Vanwege de beperkte beschikbaarheid en het minder vaak voorkomende gebruik, speelt synchronisatie op de achtergrond momenteel geen belangrijke rol.

## Manifesten voor web-apps

Het manifest van de web-app is een op JSON gebaseerd bestand dat ontwikkelaars een centrale plek biedt om metagegevens te plaatsen die zijn gekoppeld aan een web-app. Het bepaalt hoe de applicatie zich op desktop of mobiel moet gedragen in termen van pictogram, oriëntatie, themakleur en vind-ik-leuks.

Om een PWA vruchtbaar te maken, moet deze een manifest en een service worker hebben. Het is interessant om op te merken dat manifesten veel meer worden gebruikt dan service workers. Dit komt grotendeels door het feit dat CMS zoals WordPress, Drupal en Joomla standaard manifesten hebben.

{{ figure_markup(
  image="pwa-manifest-and-service-worker-usage.png",
  caption="Gebruik van manifesten en service workers.",
  description="Staafdiagram met het percentage pagina's met manifesten, service workers of beide met 6,04% van de desktoppagina's en 5,66% van de mobiele pagina's heeft een manifest, 0,76% van de desktop en 0,84% van de mobiel heeft een service worker en 0,59% van de desktoppagina's en 0,68 % van de mobiele pagina's heeft beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=257125618&format=interactive",
  sheets_gid="227354805",
  sql_file="manifests_and_service_workers.sql"
  )
}}

Het hebben van een web-app-manifest betekent niet noodzakelijk dat de site een progressieve web-app is, aangezien deze onafhankelijk van het gebruik van een service worker kan bestaan. Omdat we in dit hoofdstuk echter geïnteresseerd zijn in PWA's, hebben we alleen die manifesten onderzocht voor sites waar ook een service worker bestaat. Dit is anders dan de benadering die werd gevolgd in [het PWA-hoofdstuk van vorig jaar](../2019/pwa#web-app-manifests), waarin werd gekeken naar het algemene gebruik van manifesten, dus het kan zijn dat u dit jaar enkele verschillen in resultaten opmerkt.

### Manifesteigenschappen

Webmanifest dicteert de meta-eigenschappen van de applicatie. We hebben gekeken naar de verschillende eigenschappen die zijn gedefinieerd door de Web App Manifest-specificatie, en hebben ook gekeken naar niet-standaard eigendomsrechten.

{{ figure_markup(
  image="pwa-manifest-properties-on-service-worker-pages.png",
  caption="Manifesteigenschappen op pagina's van service workers.",
  description="Staafdiagram met het percentage van de verschillende manifesteigenschappen dat wordt gebruikt op pagina's van service workers op desktop en mobiel. De eerste zeven eigenschappen (`name`, `display`, `icons`, `short_name`, `start_url`, `theme_color` en `background_color`) worden gebruikt door 93 tot 98% van zowel desktop als mobiel. Hierna is er een scherpe daling voor de resterende eigendommen met `gcm_sender_id` gebruikt door 21,66% van de desktopsites en 28,98% van de mobiele sites, `scope` gebruikt door 29,32% van de desktops en 28,77% van de mobiele, `description` wordt gebruikt door 23,32% van de desktop en 18,84% van de mobiele apparaten, 19,45% van de desktopcomputers en 17,65% van de mobiele `orientation` en ten slotte `lang` voor 12,31% van de desktopcomputers en 11,01% van de mobiele apparaten.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=427650634&format=interactive",
  sheets_gid="887021927",
  sql_file="top_manifest_properties_sw.sql"
  )
}}

Volgens <a hreflang="en" href="https://w3c.github.io/manifest/#webappmanifest-dictionary">de specificatie zijn de volgende eigenschappen geldige eigenschappen</a>:

- `background_color`
- `categories`
- `description`
- `dir`
- `display`
- `iarc_rating_id`
- `icons`
- `lang`
- `name`
- `orientation`
- `prefer_related_applications`
- `related_applications`
- `scope`
- `screenshots`
- `short_name`
- `shortcuts`
- `start_url`
- `theme_color`

Er waren heel weinig verschillen tussen mobiele en desktopstatistieken.

De eigendomskenmerken die we vaak tegenkwamen, waren `gcm_sender_id` die werden gebruikt door de Google Cloud Messaging-service (GCM). We vonden ook andere interessante attributen zoals: `browser_action`, `DO_NOT_CHANGE_GCM_SENDER_ID` (wat in feite een opmerking was, gebruikt omdat JSON geen opmerkingen toestaat), `scope`, `public path`, `cacheDigest`.

Op beide platforms is er echter een lange reeks eigenschappen die niet door browsers worden geïnterpreteerd, maar die potentieel nuttige metadata bevatten.

We vonden ook een niet-triviaal aantal verkeerd getypte eigenschappen; onze favorieten zijn variaties van `theme-color`, `Theme_color`, `theme-color`, `Theme_color` en `orientation`.

### Top Manifest weergavewaarden

{{ figure_markup(
  image="pwa-most-used-display-values-for-service-worker-pages.png",
  caption="De meest gebruikte `display` waarden voor pagina's van service workers.",
  description="Staafdiagram dat het percentage pagina's weergeeft dat de 5 meest voorkomende `display`-waarden gebruikt, gedomineerd door `standalone` dat wordt gebruikt door 86,73% van de desktoppagina's en 89,28% van de mobiele pagina's, `minimal-ui` wordt gebruikt door 6,30% van de desktop- en 5,00% van mobiel, `fullscreen` met 4,80% van desktop en 4,11% van mobiel, 1,15% van desktoppagina's en 0,88% van mobiele pagina's stelt geen `display`-waarde in, en tenslotte 1,00% van desktop en 0,72% van mobiel zet dit op `browser`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=872942071&format=interactive",
  sheets_gid="1208193001",
  sql_file="top_manifest_display_values_sw.sql"
  )
}}

Van de vijf meest voorkomende `display`-waarden domineerde `standalone` de lijst met 86,73% van de desktoppagina's en 89,28% van de mobiele pagina's die hiervan gebruik maakten. Dit is helemaal niet verrassend, aangezien deze modus het native app-achtige gevoel geeft. De volgende in de lijst was `minimal-ui`, waarbij 6,30% van de desktops en 5,00% van de mobiele sites ervoor koos. Dit is vergelijkbaar met `standalone`, behalve dat bepaalde browser-UI behouden blijft.

### Top manifestcategorieën

{{ figure_markup(
  image="pwa-manifest-categories.png",
  caption="PWA-manifestcategorieën.",
  description="Staafdiagram met het percentage PWA-pagina's voor de top 10 van meest populaire categorieën met winkelen hebben 3,45% van de desktop, maar een enorme 13,46% van mobiele pagina's torenhoog boven de andere cijfers uit. Daarna heeft nieuws 4,60% van de desktop en 5,26% van de mobiele apparaten, entertainment 6,90% en 5,26%, nutsbedrijven 6,32% en 4,74%, bedrijven 6,90% en 4,74%, lifestyle 2,87% en 3,16, sociaal 2,87% en 2,63%, financiën met 2,87% en 2,63% en tenslotte web met 1,72% en 2,11%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=137093819&format=interactive",
  sheets_gid="423855457",
  sql_file="top_manifest_categories_sw.sql"
  )
}}

Van alle top `categorieën` stond `winkelen` bovenaan met 13,16% op het mobiele verkeer, wat niet onverwacht is aangezien PWA's e-commerce apps zijn. `nieuws` volgde met 5,26% op het mobiele verkeer.

### Manifesten die voorkeur geven aan native

{{ figure_markup(
  image="pwa-manifest-preferring-native.png",
  caption="Manifest die voorkeur geeft aan native.",
  description="Horizontaal gestapeld staafdiagram waaruit blijkt dat op desktops 98,24% van de desktopsites en 98,52% van de mobiele sites de voorkeur geeft aan native.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1370804413&format=interactive",
  sheets_gid="153006256",
  sql_file="manifests_preferring_native_apps_sw.sql"
  )
}}

98,24% van de desktop PWA-sites en 98,52% van de mobiele PWA-sites stellen de manifesteigenschap `preferred_related_applications` zo in dat ze geen voorkeur geven aan native apps, maar in plaats daarvan de webversie gebruiken waar ze bestaan. Voor het kleine percentage waar dit is ingesteld op `true` is dit een signaal dat er veel webapplicaties zijn die alleen een manifest hebben, maar nog niet echt volledige PWA's zijn.

### Top manifestpictogram formaten

{{ figure_markup(
  image="pwa-top-manifest-icon-sizes.png",
  caption="Top manifestpictogram formaten",
  description="Staafdiagram met de belangrijkste pictogramformaten met 192 bij 192 pixels die worden gebruikt door 19,10% van de desktopsites en 19,76% van de mobiele sites, vergelijkbare cijfers voor de volgende grootte van 512 bij 512 pixels met 18,21% en 18,85%. Dit wordt gevolgd door een scherpe daling voor 96 bij 96 pixels met 7,21% voor desktop en 7,11% voor mobiel, en dan blijft het ongeveer lineair dalen voor de resterende waarden van 72 bij 72 pixels, 48 bij 48 pixels, 128 bij 128 pixels, 152 bij 152 pixels, 384 bij 384 pixels, 256 bij 256 pixels, 36 bij 26 pixels, 196 bij 196 pixels, 120 bij 120 pixels, 168 bij 168 pixels, 32 bij 32 pixels totdat we 16 bij 16 pixels krijgen die worden gebruikt door 0,89% van de desktopsites en 0,81% van de mobiele sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=263579568&format=interactive",
  sheets_gid="806224609",
  sql_file="top_manifest_icon_sizes_sw.sql"
  )
}}

Lighthouse vereist ten minste een pictogram van 192x192 pixels, maar gewone hulpmiddelen voor het genereren van favicon creëren ook een overvloed aan andere formaten. Het is altijd beter om de aanbevolen pictogramformaten voor elk apparaat te gebruiken, dus het is bemoedigend om te zien dat er zo veel verschillende pictogramformaten worden gebruikt.

### Top manifest oriëntaties

{{ figure_markup(
  image="pwa-top-manifest-orientations.png",
  caption="Top manifest oriëntaties",
  description="Staafdiagram met de top 5 manifest oriëntaties met `portrait` gebruikt door 14,25% van de desktopsites en 14,47% van de mobiele sites, `any` gebruikt door 7,25% van de desktopcomputers en 6,45% van de mobiele apparaten, `portrait-primary` gebruikt door 1,56% van de desktop en 1,52% mobiel, `natural` gebruikt door 0,86% van de desktop en 0,79% van mobiel, en tenslotte wordt `landscape` gebruikt door 0,53% van de desktop en 0,39% van mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=1217279338&format=interactive",
  sheets_gid="2070230147",
  sql_file="top_manifest_orientations_sw.sql"
  )
}}

De geldige waarden voor de oriëntatie-eigenschap worden gedefinieerd in de Screen Orientation API <a hreflang="en" href="https://www.w3.org/TR/screen-orientation/">specificatie</a>. Momenteel zijn ze:

- `any`
- `natural`
- `landscape`
- `portrait`
- `portrait-primary`
- `portrait-secondary`
- `landscape-primary`
- `landscape-secondary`

Waarvan we hebben gemerkt dat de eigenschappen `portrait`, `any` en `portrait-primary` voorrang hadden.

## Bibliotheken voor service workers

Er zijn veel gevallen waarin de service workers bibliotheken als afhankelijkheden gebruiken, of het nu gaat om externe afhankelijkheden of de interne afhankelijkheden van de applicatie. Deze worden meestal opgehaald bij de service worker via de `importScripts()` API. In deze sectie zullen we statistieken over dergelijke bibliotheken bekijken.

### Populaire importscripts

De [importScripts() API](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/importScripts) van de [WorkerGlobalScope-interface](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope) importeert synchroon een of meer scripts in het bereik van de worker. Hetzelfde wordt gebruikt om externe afhankelijkheden naar de service worker te importeren.

<figure>
<table>
  <thead>
    <tr>
      <th>Script</th>
      <th>Desktop</th>
      <th>Mobiel</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Gebruikt <code>importScripts()</code></td>
      <td class="numeric">29,60%</td>
      <td class="numeric">23,76%</td>
    </tr>
    <tr>
      <td><code>Workbox<code></td>
      <td class="numeric">17,70%</td>
      <td class="numeric">15,25%</td>
    </tr>
    <tr>
      <td><code>sw_toolbox<code></td>
      <td class="numeric">13,92%</td>
      <td class="numeric">12,84%</td>
    </tr>
    <tr>
      <td><code>firebase<code></td>
      <td class="numeric">3,40%</td>
      <td class="numeric">3,09%</td>
    </tr>
    <tr>
      <td><code>OneSignalSDK<code></td>
      <td class="numeric">4,23%</td>
      <td class="numeric">2,76%</td>
    </tr>
    <tr>
      <td><code>najva<code></td>
      <td class="numeric">1,89%</td>
      <td class="numeric">1,52%</td>
    </tr>
    <tr>
      <td><code>upush<code></td>
      <td class="numeric">1,45%</td>
      <td class="numeric">1,23%</td>
    </tr>
    <tr>
      <td><code>cache_polyfill<code></td>
      <td class="numeric">0,70%</td>
      <td class="numeric">0,72%</td>
    </tr>
    <tr>
      <td><code>analytics_helper<code></td>
      <td class="numeric">0,34%</td>
      <td class="numeric">0,39%</td>
    </tr>
    <tr>
      <td>overige Bibliotheek</td>
      <td class="numeric">0,27%</td>
      <td class="numeric">0,15%</td>
    </tr>
    <tr>
      <td>Geen Bibliotheek</td>
      <td class="numeric">58,81%</td>
      <td class="numeric">64,44%</td>
    </tr>
  </tbody>
</table>
<figcaption>{{ figure_link(caption="PWA-bibliotheekgebruik.", sheets_gid="1399126426", sql_file="popular_pwa_libraries.sql") }}</figcaption>
</figure>

Ongeveer 30% van de desktop PWA-sites en 25% van de mobiele PWA-sites gebruikt `importScripts()`, waarvan `workbox`, `sw_toolbox` en `firebase` respectievelijk de eerste drie posities innemen.

### Workbox gebruik

Van de vele beschikbare bibliotheken werd Workbox het meest gebruikt met een acceptatiegraad van respectievelijk 12,86% en 15,29% van de PWA-sites op mobiel en desktop.

{{ figure_markup(
  image="pwa-most-used-workbox-packages.png",
  caption="Meest gebruikte Workbox-pakketten.",
  description="Staafdiagram met de meest gebruikte Workbox-pakketten in aflopende volgorde van gebruik: `strategies` wordt gebruikt door 29,53% van de desktopservice workerspagina's en 25,71% van de mobiele apparaten, `routing` met respectievelijk 18,91% en 15,61%, `precaching` met 16,54% % en 12,98%, `core` met 16,28% 12,44%, `expiration` met 7,49% 7,13%, `setConfig` met 6,54% 4,80%, en `skipWaiting` wordt gebruikt door 3,89% van de desktopservice workers en 3,03% van de mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRRpTSA4fsHwUap-ByQ08j95uo7Zm1kY6lTSvA-DZT54g2QZ0guV7db3QyQwQgMPzsKsJ43gbzqfJst/pubchart?oid=550366577&format=interactive",
  sheets_gid="1614661441",
  sql_file="workbox_package_methods.sql"
  )
}}

Van de vele methoden die Workbox biedt, hebben we gemerkt dat 29,53% van de desktopcomputers en 25,71% van de mobiele apparaten `strategies` gebruikte, gevolgd door `routing` met 18,91% en 15,61% adoptie en tenslotte werd `precaching` het meest gebruikt met 16.54. % en 12,98% op respectievelijk desktop en mobiel.

Dit gaf aan dat de strategies API, als een van de meest gecompliceerde vereisten voor de ontwikkelaars, een zeer belangrijke rol speelde toen ze besloten om zelf te coderen of te vertrouwen op bibliotheken zoals Workbox.

## Gevolgtrekking

De statistieken in dit hoofdstuk laten zien dat PWA's nog steeds groeien in adoptie, vanwege de voordelen die ze bieden voor [prestatie](./performance) en meer controle over [caching](./caching), met name voor [mobiel](./mobile-web). Met die voordelen en steeds groter wordende [mogelijkheden](./capabilities), betekent dat we nog steeds veel groeipotentieel hebben. We verwachten nog meer vooruitgang te zien in 2021!

Steeds meer browsers en platforms ondersteunen de technologieën die PWA's aandrijven. Dit jaar zagen we dat Edge ondersteuning kreeg voor het Web App Manifest. Afhankelijk van uw gebruiksscenario en doelmarkt, zult u merken dat de meerderheid van uw gebruikers (bijna 96%) PWA-ondersteuning heeft. Dat is een hele verbetering! In alle gevallen is het belangrijk om technologieën zoals service workers en Web App Manifest als progressieve verbeteringen te benaderen. U kunt deze technologieën gebruiken om een uitzonderlijke gebruikerservaring te bieden en met de bovenstaande statistieken zijn we verheugd over weer een jaar van PWA-groei!
