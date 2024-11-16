---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Bronhints
description: Het hoofdstuk Bronhints van de Web Almanac 2020 behandelt het gebruik van dns-prefetch, preconnect, preload, prefetch, Priority Hints en native lazy loading.
hero_alt: Hero image of Web Almanac charactes lining up to HTML, JavaScript, and image resources in a line on the way to a web page.
authors: [Zizzamia]
reviewers: [jessnicolet, pmeenan, giopunt, mgechev, notwillk]
analysts: [khempenius]
editors: [exterkamp]
translators: [noah-vdv]
Zizzamia_bio: Leonardo is een Software Engineer Staff bij <a hreflang="en" href="https://www.coinbase.com/">Coinbase</a> en leidt initiatieven op het gebied van webprestaties en groei. Hij beheert de <a hreflang="en" href="https://ngrome.io">NGRome-conferentie</a>. Leo onderhoudt ook de <a hreflang="en" href="https://github.com/Zizzamia/perfume.js">Perfume.js</a>-bibliotheek, die bedrijven helpt bij het prioriteren van routekaarten en het nemen van betere zakelijke beslissingen door middel van prestaties analyse.
discuss: 2057
results: https://docs.google.com/spreadsheets/d/1lXjd8ogB7kYfG09eUdGYXUlrMjs4mq1Z7nNldQnvkVA/
featured_quote: In het afgelopen jaar zijn bronhints toegenomen in acceptatie, en het zijn essentiële API's geworden voor ontwikkelaars om meer gedetailleerde controle te hebben over veel aspecten van bronprioritering en uiteindelijk de gebruikerservaring.
featured_stat_1: 33%
featured_stat_label_1: Sites die `dns-prefetch` gebruiken
featured_stat_2: 9%
featured_stat_label_2: Sites die `preload` gebruiken
featured_stat_3: 4,02%
featured_stat_label_3: Sites die native lazy loading gebruiken
---

## Inleiding

In het afgelopen decennium zijn <a hreflang="en" href="https://www.w3.org/TR/resource-hints/">bronhints</a> essentiële primitieven geworden waarmee ontwikkelaars paginaprestaties en dus de gebruikerservaring verbeteren.

Het vooraf laden van bronnen en het laten toepassen van intelligente prioriteiten door browsers is iets dat eigenlijk al in 2009 begon door IE8 met iets genaamd de <a hreflang="en" href="https://speedcurve.com/blog/load-scripts-async/">preloader</a>. Naast de HTML-parser had IE8 een lichtgewicht vooruitkijk-preloader die scande op tags die netwerkverzoeken konden initiëren (`<script>`, `<link>`, en `<img>`).

In de daaropvolgende jaren deden browserverkopers steeds meer van het zware werk, waarbij ze elk hun eigen speciale saus toevoegden voor het prioriteren van bronnen. Maar het is belangrijk om te begrijpen dat de browser alleen enkele beperkingen heeft. Als ontwikkelaars kunnen we deze limieten echter overwinnen door goed gebruik te maken van bronhints en te helpen beslissen hoe bronnen prioriteit moeten krijgen, door te bepalen welke moeten worden opgehaald of voorverwerkt om de paginaprestaties verder te verbeteren.

In het bijzonder kunnen we enkele van de overwinningen noemen die het afgelopen jaar zijn behaald/gemaakt met bronhints:
- <a hreflang="en" href="https://www.zachleat.com/web/css-tricks-web-fonts/">CSS-Tricks</a> weblettertypen worden sneller weergegeven bij een eerste 3G-weergave.
- <a hreflang="en" href="https://www.youtube.com/watch?v=4QqlGgF8Y2I&t=1469">Wix.com</a> met behulp van bronhints kreeg 10% verbetering voor FCP.
- <a hreflang="en" href="https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/">Ironmongerydirect.co.uk</a> gebruikte preconnect om het laden van productafbeeldingen te verbeteren met 400 ms bij de mediaan en meer dan 1 seconde bij het 95e percentiel.
- <a hreflang="en" href="https://engineering.fb.com/2020/05/08/web/facebook-redesign/">Facebook.com</a> gebruikte preload voor snellere navigatie.

Laten we eens kijken naar de meest voorkomende bronhints die tegenwoordig door de meeste browsers worden ondersteund: `dns-prefetch`, `preconnect`, `preload`, `prefetch`, en native lazy loading.

Bij het werken met elke individuele hint adviseren we om altijd de impact voor en na in het veld te meten, door bibliotheken zoals <a hreflang="en" href="https://github.com/GoogleChrome/web-vitals">WebVitals te gebruiken</a>, <a hreflang="en" href="https://github.com/zizzamia/perfume.js">Perfume.js</a>, of een ander hulpprogramma dat de Web Vitals-statistieken ondersteunt.

### `dns-prefetch`

<a hreflang="en" href="https://web.dev/preconnect-and-dns-prefetch/">`dns-prefetch`</a> helpt het IP-adres voor een bepaald domein van tevoren op te lossen. Als de <a hreflang="en" href="https://caniuse.com/link-rel-dns-prefetch">oudste</a> beschikbare bronhint, gebruikt het minimale CPU- en netwerkbronnen in vergelijking met `preconnect`, en helpt de browser om de "worst-case" vertraging voor DNS-resolutie te vermijden, die<a hreflang="en" href="https://www.chromium.org/developers/design-documents/dns-prefetching">meer dan 1 seconde</a> kan zijn.

```html
<link rel="dns-prefetch" href="https://www.googletagmanager.com/">
```

Wees voorzichtig met het gebruik van `dns-prefetch`, want zelfs als ze licht van gewicht zijn, is het gemakkelijk om de browserlimieten uit te putten voor het aantal gelijktijdige in-flight DNS-verzoeken dat is toegestaan (Chrome heeft nog steeds een <a hreflang="en" href="https://source.chromium.org/chromium/chromium/src/+/master:net/dns/host_resolver_manager.cc;l=353">limit van 6</a>).

### `preconnect`

<a hreflang="en" href="https://web.dev/uses-rel-preconnect/">`preconnect`</a> helpt het IP-adres op te lossen en van tevoren een TCP/TLS-verbinding voor een bepaald domein te openen. Vergelijkbaar met `dns-prefetch` wordt het gebruikt voor elk cross-origin-domein en helpt het de browser om alle bronnen op te warmen die worden gebruikt tijdens het laden van de eerste pagina.

```html
<link rel="preconnect" href="https://www.googletagmanager.com/">
```

Let op wanneer u `preconnect` gebruikt:

- Warm alleen de meest voorkomende en significante bronnen op.
- Voorkom het opwarmen van origins die te laat in de eerste lading zijn gebruikt.
- Gebruik het voor niet meer dan drie bronnen, omdat het CPU- en batterijkosten kan hebben.

Ten slotte is `preconnect` niet beschikbaar voor <a hreflang="en" href="https://caniuse.com/?search=preconnect">Internet Explorer of Firefox</a>, en <a hreflang="en" href="https://web.dev/preconnect-and-dns-prefetch/#resolve-domain-name-early-with-reldns-prefetch">het gebruik van `dns-prefetch` als een terugval</a> is sterk geadviseerd.

### `preload`

De <a hreflang="en" href="https://web.dev/uses-rel-preload/">`preload`</a> hint initieert een vroeg verzoek. Dit is handig voor het laden van belangrijke bronnen die anders laat door de parser zouden worden ontdekt.

```html
<link rel="preload" href="style.css" as="style">
<link rel="preload" href="main.js" as="script">
```

Houd rekening met wat u gaat `preloaden`, omdat het het downloaden van andere bronnen kan vertragen, dus gebruik het alleen voor wat het meest kritisch is om u te helpen de Largest Contentful Paint te verbeteren (<a hreflang="en" href="https://web.dev/articles/lcp">LCP</a>). Wanneer het in Chrome wordt gebruikt, heeft het ook de neiging om te hoge prioriteit te geven aan `preload`-bronnen en mogelijk preloads eerder te verzenden dan andere kritieke bronnen.

Ten slotte, indien gebruikt in een HTTP-antwoordheader, zullen sommige CDN's ook automatisch een `preload` omzetten in een [HTTP/2-push](#http2-push) die in het cachegeheugen opgeslagen bronnen te veel kan pushen.

### `prefetch`

De <a hreflang="en" href="https://web.dev/link-prefetch/">`prefetch`</a> hint stelt ons in staat om verzoeken met lage prioriteit te initiëren waarvan we verwachten dat ze gebruikt zullen worden bij de volgende navigatie. De hint downloadt de bronnen en zet deze in de HTTP-cache voor later gebruik. Belangrijk om op te merken, `prefetch` zal de bron niet uitvoeren of anderszins verwerken, en om het uit te voeren, zal de pagina de bron nog steeds moeten aanroepen met de `<script>` tag.

```html
<link rel="prefetch" as="script" href="next-page.bundle.js">
```

Er zijn verschillende manieren om de voorspellingslogica van een bron te implementeren, deze kan zijn gebaseerd op signalen zoals muisbewegingen van de gebruiker, algemene gebruikersstromen/reizen, of zelfs op een combinatie van beide, bovenop machine learning.

Let op, afhankelijk van de <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues#current-status">kwaliteit</a> van HTTP/2-prioriteitstelling van het gebruikte CDN, kan `prefetch` prioritering ofwel de prestaties verbeteren ofwel het langzamer maken, door meer prioriteit te geven aan `prefetch` verzoeken en belangrijke bandbreedte weg te nemen voor de initiële belasting. Zorg ervoor dat u het CDN dat u gebruikt dubbel controleert en pas het aan om rekening te houden met een paar van de best praktijken die worden gedeeld in het artikel van <a hreflang="en" href="https://andydavies.me/blog/2020/07/08/rel-equals-prefetch-and-the-importance-of-effective-http-slash-2-prioritisation/">Andy Davies</a>.

### Native lazy loading

De <a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/">native lazy loading</a> hint is een native browser-API voor het uitstellen van het laden van offscreen afbeeldingen en iframes. Door het te gebruiken, zullen middelen die niet nodig zijn tijdens het laden van de eerste pagina geen netwerkverzoek initiëren, dit zal het gegevensverbruik verminderen en de paginaprestaties verbeteren.

```html
<img src="image.png" loading="lazy" alt="…" width="200" height="200">
```

Houd er rekening mee dat Chromium's implementatie van logica voor lazy-loading drempels historisch gezien nogal <a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/#distance-from-viewport-thresholds">conservatief</a> was, waarbij de offscreen-limiet op 3000px wordt gehouden. Het afgelopen jaar is de limiet actief getest en verbeterd om de verwachtingen van ontwikkelaars beter op elkaar af te stemmen en uiteindelijk de drempels te verschuiven naar 1250px. Er is ook <a hreflang="en" href="https://github.com/whatwg/html/issues/5408">geen standaard voor alle browsers</a> en webontwikkelaars kunnen de standaard drempels die door de browsers worden geboden niet overschrijven.

## Bronhints

Laten we op basis van het HTTP Archive de trends voor 2020 analyseren en de gegevens vergelijken met de eerdere gegevensset van 2019.

### Hints acceptatie

Steeds meer webpagina's gebruiken de belangrijkste bronhints en in 2020 zien we dat de acceptatie consistent blijft tussen desktop en mobiel.

{{ figure_markup(
  image="adoption-of-resource-hints.png",
  caption="Overname van bronhints.",
  description="Een staafdiagram van de snelheid waarmee bronhint wordt aangenomen, uitgesplitst naar type hint en vormfactor. Voor desktop gebruikt 33% van de pagina's de `dns-prefetch` bronhint, 18% gebruikt `preload`, 8% gebruikt `preconnect`, 3% gebruikt `prefetch` en minder dan 1% gebruikt `prerender`. Mobiel is vergelijkbaar, behalve dat `dns-prefetch` 34% gebruik heeft (1% hoger) en `preconnect` 9% (1% hoger).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1550112064&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

De relatieve populariteit van `dns-prefetch` met een acceptatie van 33% vergeleken met andere bronhints is niet verrassend aangezien het voor het eerst verscheen in 2009, en heeft de breedste ondersteuning van alle belangrijke bronhints.

Vergeleken met [2019](../2019/resource-hints#resource-hints) had de `dns-prefetch` een toename van 4% in Desktop-acceptatie. We zagen ook een vergelijkbare toename voor `preconnect`. Een belangrijke reden waarom dit de grootste groei was tussen alle hints, is het duidelijke en nuttige advies dat de <a hreflang="en" href="https://web.dev/uses-rel-preconnect/">Lighthouse-audit</a> geeft over deze kwestie. Vanaf het rapport van dit jaar introduceren we ook hoe de nieuwste dataset presteert ten opzichte van de aanbevelingen van Lighthouse.

{{ figure_markup(
  image="resource-hint-adoption-2019-vs-2020.png",
  caption="Overname van hulpmiddelhints 2019 versus 2020.",
  description="Een staafdiagram waarin de mate van acceptatie van bronhints op mobiele apparaten tussen 2019 en 2020 wordt vergeleken, uitgesplitst naar type hint. Het toont een toename in gebruik in bijna elk type bronhint. `dns-prefetch` is met 5% gestegen, van 29% naar 34%. `preload` is met 2% gestegen, van 16% naar 18%. `preconnect` is met 5% gestegen, van 4% naar 9%. `prefetch` bleef vlak bij 3% gebruik. `prerender` bleef ook vlak bij minder dan 1% gebruik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1494186122&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

Het gebruik van `preload` heeft een langzamere groei doorgemaakt met slechts een stijging van 2% ten opzichte van 2019. Dit zou gedeeltelijk kunnen zijn omdat het wat meer specificatie vereist. Hoewel u alleen het domein nodig hebt om `dns-prefetch` en `preconnect` te gebruiken, moet u de bron specificeren om `preload` te gebruiken. Hoewel `dns-prefetch` en `preconnect` een redelijk laag risico vormen, maar nog steeds kunnen worden misbruikt, heeft `preload` een veel groter potentieel om de prestaties daadwerkelijk te schaden als het onjuist wordt gebruikt.

`prefetch` wordt gebruikt door 3% van de sites op Desktop, waardoor het de minst gebruikte bronhint is. Dit lage gebruik kan worden verklaard door het feit dat `prefetch` nuttig is om volgende, in plaats van huidige, paginaladingen te verbeteren. Het wordt dus over het hoofd gezien als een site alleen is gericht op het verbeteren van de bestemmingspagina of de prestaties van de eerste pagina die wordt bekeken. In de komende jaren met een duidelijkere definitie van wat moet worden gemeten om de volgende pagina-ervaring te verbeteren, kan het teams helpen prioriteit te geven aan `prefetch`-acceptatie met duidelijke prestatiekwaliteitsdoelen om te bereiken.

### Hints per pagina

Over de hele linie leren ontwikkelaars hoe ze resource-hints beter kunnen gebruiken, en vergeleken met [2019](../2019/resource-hints#resource-hints) hebben we een verbeterd gebruik van `preload`, `prefetch` en `preconnect`. Voor dure bewerkingen zoals preload en pre-connect daalde het mediaan gebruik op desktop van 2 naar 1. We hebben het tegenovergestelde gezien bij het laden van toekomstige bronnen met een lagere prioriteit met `prefetch`, met een toename van 1 naar 2 in mediaan per pagina.

{{ figure_markup(
  image="median-number-of-hints-per-page.png",
  caption="Mediaan aantal hints per pagina.",
  description="Een staafdiagram dat het mediaan aantal beschikbare bronhints per pagina weergeeft, uitgesplitst naar type bronhint en vormfactor. `preload` en `prerender` hebben beide (mediaan) één hint per pagina op zowel mobiel als desktop. `prefetch` en `dns-prefetch` hebben beide (mediaan) twee hints per pagina op zowel mobiel als desktop. `preconnect` heeft (mediaan) één hint per pagina op desktop en (mediaan) twee hints per pagina op mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=320451644&format=interactive",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

bronhints zijn het meest effectief wanneer ze selectief worden gebruikt ("als alles belangrijk is, is niets"). Het hebben van een duidelijkere definitie van welke bronnen helpen bij het verbeteren van kritische weergave, versus toekomstige navigatie-optimalisaties, kan de focus verleggen van het gebruik van `preconnect` en meer naar `prefetch` door een deel van de bronnenprioritering te verschuiven en bandbreedte vrij te maken voor wat de gebruiker in eerste instantie het meest helpt.

Dit heeft echter niet het misbruik van de `preload`-hint gestopt, aangezien we in één geval een pagina ontdekten die dynamisch de hint toevoegde en een oneindige lus veroorzaakte die meer dan 20k nieuwe preloads creëerde.

{{ figure_markup(
  caption="De meest vooraf geladen hints op één pagina.",
  content="20.931",
  classes="big-number",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

Aangezien we steeds meer automatisering creëren met bronhints, moet u voorzichtig zijn bij het dynamisch injecteren van preload hints - of welke elementen dan ook!

### Het `as`-attribuut

Met `preload` en `prefetch` is het cruciaal om het `as`-attribuut te gebruiken om de browser te helpen de bron nauwkeuriger te prioriteren. Hierdoor is de juiste opslag in de cache mogelijk voor toekomstige verzoeken, wordt het juiste Inhoudsbeveiligingsbeleid ([CSP](https://developer.mozilla.org/docs/Web/HTTP/CSP)) en de juiste `Accept`-verzoekheaders toegepast.

Met `preload` kunnen veel verschillende content-types worden voorgeladen en de [complete lijst](https://developer.mozilla.org/docs/Web/HTML/Element/link#Attributes) volgt de aanbevelingen die in de Fetch <a hreflang="en" href="https://fetch.spec.whatwg.org/#concept-request-destination">spec</a> staan. De meest populaire is het `script`-type met 64% gebruik. Dit heeft waarschijnlijk te maken met een grote groep sites die zijn gebouwd als Enkele Pagina Apps die de hoofdbundel zo snel mogelijk nodig hebben om de rest van hun JS-afhankelijkheden te downloaden. Daaropvolgend gebruik komt van lettertype op 8%, stijl op 5%, afbeelding op 1% en ophalen op 1%.

{{ figure_markup(
  image="mobile-as-attribute-values-by-year.png",
  caption="Attribuutwaarden voor mobiel `as` per jaar.",
  description="Een staafdiagram waarin de snelheid van de `as`-attribuutwaarden op mobiele pagina's van 2019 en 2020 wordt vergeleken, uitgesplitst naar `as`-attribuutwaarde. Het merendeel van de `as`-waarden is `script` met 81% gebruik in 2019 en 64% gebruik in 2020. `script`-gebruik daalde met 17% jaar op jaar, terwijl alle andere waarden toenamen in gebruik. `not set` verhoogd met 8%, `lettertype` verhoogd met 5%, `style` verhoogd met 2%, de rest van de opmerkelijke waarden zijn 1% of minder voor beide jaren.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=903180926&format=interactive",
  sheets_gid="1829901599",
  sql_file="as_attribute_by_year.sql"
) }}

Vergeleken met de trend in [2019](../2019/resource-hints#the-as-attribute), hebben we een snelle groei gezien in het gebruik van lettertypen en stijlen met het kenmerk `as`. Dit heeft waarschijnlijk te maken met het feit dat ontwikkelaars de prioriteit van kritieke CSS verhogen en ook `preload`-lettertypen combineren met `display:optional` om de Cumulative Layout Shift (<a hreflang="en" href="https://web.dev/articles/cls">CLS</a>) te <a hreflang="en" href="https://web.dev/articles/optimize-cls#web-fonts-causing-foutfoit">verbeteren</a>.

Houd er rekening mee dat het weglaten van het `as`-attribuut of het hebben van een ongeldige waarde het voor de browser moeilijker zal maken om de juiste prioriteit te bepalen en in sommige gevallen, zoals scripts, er zelfs voor kan zorgen dat de bron tweemaal wordt opgehaald.

### Het `crossorigin` attribuut

Met `preload` en `preconnect` bronnen die CORS hebben ingeschakeld, zoals fonts, is het belangrijk om het `crossorigin` attribuut op te nemen, zodat de bron correct kan worden gebruikt. Als het attribuut `crossorigin` ontbreekt, volgt het verzoek het single-origin-beleid, waardoor het gebruik van preload nutteloos is.

{{ figure_markup(
  caption="Het percentage elementen met `preload` dat `crossorigin` gebruikt.",
  content="16,96%",
  classes="big-number",
  sheets_gid="1185042785",
  sql_file="attribute_usage.sql"
) }}

De laatste trends laten zien dat 16,96% van de elementen die vooraf laden, ook `crossorigin` instellen en laden in anonieme (of gelijkwaardige) modi, en slechts 0,02% gebruikt het geval van `use-credentials`. Deze snelheid is toegenomen in combinatie met de toename van het vooraf laden van lettertypen, zoals eerder vermeld.

```html
<link rel="preload" href="ComicSans.woff2" as="font" type="font/woff2" crossorigin>
```

Houd er rekening mee dat lettertypen die vooraf zijn geladen zonder het attribuut `crossorigin`<a hreflang="en" href="https://web.dev/preload-critical-assets/#how-to-implement-relpreload">twee keer</a> zullen worden opgehaald!

### Het `media` attribuut

Wanneer het tijd is om een bron te kiezen voor gebruik met verschillende schermformaten, grijp dan naar het `media`-attribuut met `preload` om uw mediaquery's te optimaliseren.

```html
<link rel="preload" href="a.css" as="style" media="only screen and (min-width: 768px)">
<link rel="preload" href="b.css" as="style" media="screen and (max-width: 430px)">
```

Het zien van meer dan 2100 verschillende combinaties van mediaquery's in de 2020-dataset moedigt ons aan om te overwegen hoe groot de variantie is tussen concept en implementatie van responsive design van site tot site. De immer populaire `767px/768px` breekpunten (zoals gepopulariseerd door onder andere Bootstrap) zijn te zien in de data.

### Beste praktijken

Het gebruik van bronhints kan soms verwarrend zijn, dus laten we enkele snelle beste praktijken bekijken die we kunnen volgen op basis van de geautomatiseerde audit van Lighthouse.

Om `dns-prefetch` en `preconnect` veilig te implementeren, moet u ervoor zorgen dat ze in aparte link-tags staan.

```html
<link rel="preconnect" href="http://example.com">
<link rel="dns-prefetch" href="http://example.com">
```

Het implementeren van een `dns-prefetch` fallback in dezelfde `<link>`-tag veroorzaakt een <a hreflang="en" href="https://bugs.webkit.org/show_bug.cgi?id=197010">bug</a> in Safari die het `preconnect`-verzoek annuleert. Bijna 2% van de pagina's (~ 40k) meldde het probleem van zowel `preconnect` als `dns-prefetch` in een enkele bron.

In het geval van de "<a hreflang="en" href="https://web.dev/uses-rel-preconnect/">Preconnect to required origins</a>" audit, zagen we slechts 19,67% van de pagina's die de test passeren, waardoor duizenden websites een grote kans krijgen om `preconnect` of `dns-prefetch` te gaan gebruiken om vroege verbindingen tot stand te brengen met belangrijke bronnen van derden.

{{ figure_markup(
  caption="Het percentage pagina's dat de `preconnect` Lighthouse-audit heeft doorstaan.",
  content="19,67%",
  classes="big-number",
  sheets_gid="152449420",
  sql_file="lighthouse_preconnect.sql"
) }}

Ten slotte resulteerde het uitvoeren van de "<a hreflang="en" href="https://web.dev/uses-rel-preload/">Preload key requests</a>" audit van Lighthouse in dat 84,6% van de pagina's voor de test slaagde. Als u `preload` voor de eerste keer wilt gebruiken, onthoud dan dat lettertypen en kritieke scripts een goede plek zijn om te beginnen.

### Native Lazy Loading

Laten we nu het eerste jaar vieren van de <a hreflang="en" href="https://addyosmani.com/blog/lazy-loading/">Native Lazy Loading</a> API, die op het moment van publicatie al meer dan <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">72%</a> browserondersteuning heeft. Deze nieuwe API kan worden gebruikt om het laden van onder de vouw iframes en afbeeldingen op de pagina uit te stellen totdat de gebruiker er dichtbij komt. Dit kan het datagebruik en het geheugengebruik verminderen en helpt content boven de vouw te versnellen. Aanmelden voor lazy load is net zo eenvoudig als het toevoegen van `loading=lazy` aan `<iframe>` of `<img>` elementen.

{{ figure_markup(
  caption="Het percentage pagina's dat native lazy loading gebruikt.",
  content="4,02%",
  classes="big-number",
  sheets_gid="2039808014",
  sql_file="native_lazy_loading_attrs.sql"
) }}

De adoptie staat nog in de kinderschoenen, vooral nu de officiële drempels eerder dit jaar te conservatief waren en pas  <a hreflang="en" href="https://addyosmani.com/blog/better-image-lazy-loading-in-chrome/">onlangs</a> in overeenstemming waren met de verwachtingen van ontwikkelaars. Met bijna 72% van de browsers die native afbeelding/source lazy loading ondersteunen, is dit een ander gebied met mogelijkheden, vooral voor pagina's die het datagebruik en de prestaties op low-end apparaten willen verbeteren.

Het uitvoeren van de audit "<a hreflang="en" href="https://web.dev/offscreen-images/">Defer offscreen images</a>" van Lighthouse resulteerde in 68,65% van de pagina's die de test doorstaan. Voor die pagina's is er een mogelijkheid om afbeeldingen te lazy-laden nadat alle kritieke bronnen zijn geladen.

Denk eraan om de audit op zowel desktop als mobiel uit te voeren, aangezien afbeeldingen van het scherm kunnen afwijken wanneer de viewport verandert.

## Voorspellend prefetchen

Door `prefetch` te combineren met machine learning, kunnen de prestaties van volgende pagina('s) worden verbeterd. Een van de oplossingen is <a hreflang="en" href="https://github.com/guess-js/guess">Guess.js</a> die de eerste doorbraak heeft gemaakt in voorspellend-prefetchen, met meer dan een dozijn websites die het al in de productie gebruikt.

<a hreflang="en" href="https://web.dev/predictive-prefetching/">Voorspellend prefetchen</a> is een techniek die gebruikmaakt van methoden uit gegevensanalyse en machine learning om een gegevensgestuurde benadering te bieden om te prefetchen. Guess.js is een bibliotheek met voorspellende prefetching-ondersteuning voor populaire frameworks (Angular, Nuxt.js, Gatsby en Next.js) en u kunt er vandaag de dag uw voordeel mee doen. Het rangschikt de mogelijke navigaties vanaf een pagina en haalt alleen het JavaScript op dat waarschijnlijk daarna nodig is.

Afhankelijk van de trainingsset, wordt het prefetchen van Guess.js geleverd met meer dan 90% nauwkeurigheid.

Over het algemeen is voorspellend prefetchen nog onbekend terrein, maar in combinatie met prefetchen bij mouse-over en prefetchen van service workers heeft het een groot potentieel om alle gebruikers van de website onmiddellijke ervaringen te bieden, terwijl hun gegevens worden opgeslagen.

## HTTP/2 Push

[HTTP/2](./http) heeft een functie genaamd "server push" die de paginaprestaties mogelijk kan verbeteren wanneer uw product lange Round Trip Times ([RTTs](https://developer.mozilla.org/docs/Glossary/Round_Trip_Time_(RTT))) of serververwerking ervaart. Kort gezegd, in plaats van te wachten tot de cliënt een verzoek verzendt, pusht de server preventief een bron waarvan hij voorspelt dat de cliënt deze spoedig daarna zal opvragen.

{{ figure_markup(
  caption="Het percentage HTTP / 2-push-pagina's dat gebruikmaakt van `preload`/`nopush`.",
  content="75,36%",
  classes="big-number",
  sheets_gid="308166349",
  sql_file="h2_preload_nopush.sql"
) }}

HTTP/2-push wordt vaak geïnitieerd via de `preload`-linkheader. In de 2020-dataset hebben we 1% van de mobiele pagina's gezien die HTTP/2 Push gebruiken, en van die 75% van de vooraf geladen headerlinks gebruikt de optie `nopush` in het paginaverzoek. Dit betekent dat, hoewel een website de bronhint `preload` gebruikt, de meerderheid er de voorkeur aan geeft om alleen dit te gebruiken en HTTP/2-pushing van die bron uit te schakelen.

Het is belangrijk om te vermelden dat HTTP/2 Push ook de prestaties kan schaden als het niet correct wordt gebruikt, wat waarschijnlijk verklaart waarom het vaak wordt uitgeschakeld.

Een oplossing hiervoor is om het <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL-patroon</a> te gebruiken dat staat voor **Push** (of preload) de kritieke bronnen, **Render** de initiële route zo snel mogelijk, **Pre-cache** resterende activa, en **Lazy-load** andere routes en niet-kritieke activa. Dit is alleen mogelijk als uw website een Progressive Web App is en een Service Worker gebruikt om de caching-strategie te verbeteren. Door dit te doen, gaan alle volgende verzoeken niet eens naar het netwerk en is het dus niet nodig om de hele tijd te pushen en krijgen we nog steeds het beste van twee werelden.

## Service Workers

Voor zowel `preload` als `prefetch` is de acceptatie toegenomen wanneer de pagina wordt beheerd door een <a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers">Service Worker</a>. Dit komt door het potentieel om zowel de bronnenprioritering te verbeteren door vooraf te laden wanneer de service worker nog niet actief is, als op intelligente wijze toekomstige bronnen vooraf op te halen, terwijl de service worker ze in het cachegeheugen laat opslaan voordat ze door de gebruiker nodig zijn.

{{ figure_markup(
  image="resource-hint-adoption-onservice-worker-pages.png",
  caption="Overname van hulpbronnen op pagina's van service workers.",
  description="Een staafdiagram van de mate van acceptatie van bronhints op pagina's van service workers, uitgesplitst naar type hint en vormfactor. Voor desktop gebruikt 29% van de pagina's de `dns-prefetch` bronhint, 47% gebruikt `preload`, 34% gebruikt `preconnect`, 10% gebruikt `prefetch` en minder dan 1% gebruikt `prerender`. Mobiel is vergelijkbaar, behalve dat `dns-prefetch` 30% gebruik heeft (1% hoger) en `preconnect` 34% (13% lager).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=252958553&format=interactive",
  sheets_gid="691299508",
  sql_file="adoption_service_workers.sql"
) }}

Voor `preload` op desktop hebben we een uitstekende acceptatiegraad van 47% en `prefetch` een acceptatiegraad van 10%. In beide gevallen zijn de gegevens veel hoger in vergelijking met de gemiddelde acceptatie zonder service worker.

Zoals eerder vermeld, zal het <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL-patroon</a> de komende jaren een belangrijke rol spelen in hoe we bronhints combineren met de cachingstrategie van Service Worker.

## Toekomst

Laten we een paar experimentele hints bekijken. Zeer dicht bij de release hebben we Priority Hints, waarmee actief wordt geëxperimenteerd in de webgemeenschap. We hebben ook de 103 Early hints in HTTP/2, die nog in het vroege begin is en er zijn een paar spelers zoals <a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">Chrome en Fastly die voor aanstaande testproeven samenwerken</a>.

### Priority hints

<a hreflang="en" href="https://developers.google.com/web/updates/2019/02/priority-hints">Priority hints</a> zijn een API voor het aangeven van de fetch-prioriteit van een bron: hoog, laag of automatisch. Ze kunnen worden gebruikt om afbeeldingen te deprioriteren (bijv. In een carrousel), scripts opnieuw te prioriteren en zelfs te helpen bij het de-prioriteren van fetches.

Deze nieuwe hint kan worden gebruikt als een HTML-tag of door de prioriteit van fetch-verzoeken te wijzigen via de `importance` optie, die dezelfde waarden aanneemt als het HTML-attribuut.

```html
<!-- We want to initiate an early fetch for a resource, but also deprioritize it -->
<link rel="preload" href="/js/script.js" as="script" importance="low">

<!-- An image the browser assigns "High" priority, but we don't actually want that. -->
<img src="/img/in_view_but_not_important.svg" importance="low" alt="I'm not important!">
```

Met `preload` en `prefetch` wordt de prioriteit bepaald door de browser, afhankelijk van het brontype. Door Priority Hints te gebruiken kunnen we de browser dwingen de standaardoptie te wijzigen.

{{ figure_markup(
  caption="Het percentage adoptie van Priority Hints op mobiele apparaten.",
  content="0,77%",
  classes="big-number",
  sheets_gid="1596669035",
  sql_file="priority_hints.sql"
) }}

Tot dusver heeft slechts 0,77% van de websites deze nieuwe hint overgenomen, aangezien Chrome nog steeds <a hreflang="en" href="https://www.chromestatus.com/features/5273474901737472">actief</a> experimenteert, en op het moment van de uitgave van dit artikel is de functie in de wacht gezet.

Het grootste gebruik is met scriptelementen, wat niet verwonderlijk is aangezien het aantal primaire JS-bestanden en bestanden van derden blijft groeien.

{{ figure_markup(
  caption="Het percentage mobiele bronnen met een hint dat de `low` prioriteit gebruikt.",
  content="16%",
  classes="big-number",
  sheets_gid="1098063134",
  sql_file="priority_hints_by_importance.sql"
) }}

Uit de gegevens blijkt dat 83% van de bronnen die Priority Hints gebruiken een "hoge" prioriteit gebruiken op mobiel, maar iets waar we nog meer aandacht aan moeten besteden is de 16% van de bronnen met een "lage" prioriteit.

Priority hints hebben een duidelijk voordeel als hulpmiddel om verspillend laden te voorkomen via de "lage" prioriteit door de browser te helpen beslissen wat de prioriteit moet worden toegekend en door een aanzienlijke CPU en bandbreedte terug te geven om eerst kritieke verzoeken te voltooien, in plaats van als een tactiek om bronnen sneller proberen te laden met de "hoge" prioriteit.

### 103 Early Hints in HTTP/2
Eerder vermeldden we dat HTTP/2-push daadwerkelijk regressie kan veroorzaken in gevallen waarin activa die worden gepusht zich al in de browsercache bevinden. Het <a hreflang="en" href="https://tools.ietf.org/html/rfc8297">103 Early Hints</a> voorstel beoogt vergelijkbare voordelen te bieden die worden beloofd door HTTP/2-push. Met een architectuur die in potentie 10x eenvoudiger is, pakt het de lange RTT's of serververwerking aan zonder te lijden aan het bekende worst-case-probleem van onnodige rondtrips met server-push.

Vanaf nu kunt u het gesprek op Chromium volgen met issues <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=671310">671310</a>, <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=1093693">1093693</a>, en <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=1096414">1096414</a>.

## Gevolgtrekking

In het afgelopen jaar zijn bronhints toegenomen in acceptatie, en het zijn essentiële API's geworden voor ontwikkelaars om meer gedetailleerde controle te hebben over veel aspecten van bronnenprioritering en uiteindelijk de gebruikerservaring. Maar laten we niet vergeten dat dit hints zijn, geen instructies en helaas zullen de browser en het netwerk altijd het laatste woord hebben.

Natuurlijk kunt u ze op een heleboel elementen plaatsen, en de browser kan doen wat u van hem vraagt. Of het negeert enkele hints en besluit dat de standaardprioriteit de beste keuze is voor de gegeven situatie. Zorg er in ieder geval voor dat u een playbook hebt voor het beste gebruik van deze hints:

- Identificeer de belangrijkste pagina's voor de gebruikerservaring.
- Analyseer de belangrijkste middelen om te optimaliseren.
- Pas indien mogelijk het <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL-patroon</a> toe.
- Meet de prestatie-ervaring voor en na elke implementatie.

Laten we tot slot niet vergeten dat internet voor iedereen is. We moeten het blijven beschermen en gefocust blijven op het bouwen van ervaringen die gemakkelijk en wrijvingsloos zijn.

We zijn verheugd om te zien dat we jaar na jaar stapsgewijs dichter bij het aanbieden van alle API's komen die nodig zijn om het bouwen van een geweldige webervaring voor iedereen te vereenvoudigen, en we kunnen niet wachten om te zien wat er daarna komt.
