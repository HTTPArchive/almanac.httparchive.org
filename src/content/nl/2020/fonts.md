---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Lettertypen
description: Hoofdstuk over lettertypen van de Web Almanac 2020 waarin wordt beschreven waar lettertypen worden geladen, lettertype-indelingen, laadprestaties voor lettertypen, variabele lettertypen en kleurlettertypen.
authors: [raphlinus, jpamental]
reviewers: [RoelN, svgeesus, davelab6, rsheeter, mandymichael]
analysts: [AbbyTsai]
editors: [tunetheweb]
translators: [noah-vdv]
jpamental_bio: Ontwerper, knutselaar, typograaf. Auteur van Responsive Typography, uitgenodigde expert voor het W3C en 10+ jaar ervaring gericht op betere typografie op internet.
raphlinus_bio: Raph Levien werkt al meer dan 35 jaar met lettertypen, waaronder een doctoraat aan UC Berkeley in hulpmidelen voor het ontwerpen van lettertypen. Hij voegt zich weer bij <a hreflang="en" href="https://fonts.google.com/">Google Fonts</a> als onderzoeker op het gebied van lettertypetechnologie, nadat hij het team in 2010 mede heeft opgericht.
discuss: 2040
results: https://docs.google.com/spreadsheets/d/1jjvZqYay5KmTle4atzFWqtbkz9ohw25KFmNtCS-7n3s/
featured_quote: De technologie voor weblettertypen is redelijk volwassen, met stapsgewijze verbeteringen in compressie en andere technische verbeteringen, maar er komen nieuwe functies aan. Browserondersteuning voor variabele lettertypen is redelijk goed geworden, en dit is de functie die het afgelopen jaar de meeste groei heeft gekend.
featured_stat_1: 70,3%
featured_stat_label_1: Populariteit van Google Fonts onder font-hostingservices
featured_stat_2: 10,3%
featured_stat_label_2: Gebruik van `font-display` swap
featured_stat_3: 11,0%
featured_stat_label_3: Gebruik van variabele lettertypen op mobiele sites
---
## Inleiding

Tekst vormt de kern van de meeste websites, en typografie is de kunst om die tekst op een visueel aantrekkelijke en effectieve manier te presenteren. Om een goede typografie te maken, moet u de juiste lettertypen kiezen en ontwerpers hebben een enorm scala aan weblettertypen om uit te kiezen. Zoals met alle bronnen, zijn er prestatie- en compatibiliteitsproblemen, maar als het goed wordt gedaan, is het voordeel de moeite waard. In dit hoofdstuk gaan we dieper in op gegevens om te laten zien hoe weblettertypen worden gebruikt, en in het bijzonder hoe ze zijn geoptimaliseerd.

## Waar worden weblettertypen gebruikt?

Het gebruik van weblettertypen is in de loop van de tijd gestaag gegroeid (het was zelfs in 2011 bijna nul), met 82% van de webpagina's voor desktops die weblettertypen gebruiken, en mobiel op 80%.

{{ figure_markup(
  image="fonts-web-fonts-usage.png",
  caption="Gebruik van weblettertypen in de loop van de tijd.",
  description="Spreidingsdiagram toont een fractie van mobiele en desktop-webpagina's met weblettertypen, als een functie van tijd. Het gebruik is ongeveer lineair gestegen van 0% rond 2010 tot 80% nu. Desktop- en mobiel gebruik lijken op elkaar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=666273773&format=interactive",
  sheets_gid="655527383",
  sql_file="04_01.web_fonts_usage.sql"
  )
}}

Het gebruik van weblettertypen is redelijk consistent over de hele wereld, met enkele uitschieters. De onderstaande grafieken zijn gebaseerd op het gemiddelde aantal kilobytes weblettertypen per webpagina, wat een indicatie kan zijn van veel lettertypen, grote lettertypen of beide.

{{ figure_markup(
  image="fonts-web-fonts-usage-by-country.png",
  caption="Gebruik van weblettertypen per land (desktop).",
  description='Een kaart van de wereld die de hoeveelheid gebruik van weblettertypen voor elk land toont, gemeten als mediane kilobytes aan weblettertypegegevens. Opvallende "hotspots" die worden gemarkeerd met een laag lettertype-gebruik zijn onder meer Afrika, Turkmenistan, Taiwan, Japan en een aantal andere landen in het Verre Oosten.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=961243485&format=interactive",
  sheets_gid="68624087",
  sql_file="04_02.web_fonts_usage_by_country.sql"
  )
}}

Het land dat de meeste lettertypebytes gebruikt, is Zuid-Korea, wat niet zo verwonderlijk is gezien hun constant hoge internetsnelheden en lage latentie en het feit dat Koreaanse (Hangul) lettertypen bijna een orde van grootte groter zijn dan het Latijn. Het gebruik van weblettertypen in Japan en Chineessprekende landen is aanzienlijk lager, waarschijnlijk omdat Chinese en Japanse lettertypen veel groter zijn (de mediane lettergrootte kan 1000 keer of groter zijn dan de gemiddelde Latijnse lettergrootte). Dit betekent dat het gebruik van weblettertypen in Japan erg laag is, en het gebruik in China feitelijk nul. Hoewel recente ontwikkelingen in <a hreflang="en" href="https://www.w3.org/TR/2020/NOTE-PFE-evaluation-20201015/">progressieve lettertypeverbetering</a> - die we hieronder meer zullen behandelen - weblettertypen bruikbaar kunnen maken in beide landen binnen een paar jaar. Er zijn berichten dat Google Fonts niet betrouwbaar toegankelijk zijn geweest in China en dat dit mogelijk ook een factor kan zijn geweest die acceptatie heeft belemmerd.

{{ figure_markup(
  image="fonts-web-fonts-usage-top-countries.png",
  caption="Gebruik van weblettertypen, toplanden (desktop).",
  description="Een grafiek met de toplanden op basis van het gebruik van weblettertypen, gemeten als mediane kilobytes aan weblettertypegegevens. Bovenaan staat de Republiek Korea met 155 kilobytes, gevolgd door Turkije (117), Iran (115), Slovenië (114), Griekenland (111), Saoedi-Arabië (109) en vervolgens drie landen (Australië, de Verenigde Staten en Polen) staan onderaan met elk 108 kilobytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=705183861&format=interactive",
  sheets_gid="68624087",
  sql_file="04_02.web_fonts_usage_by_country.sql"
  )
}}

Er is een interessante thread over <a hreflang="en" href="https://discuss.httparchive.org/t/how-does-web-font-usage-vary-by-country/1649">gebruik van weblettertypen per land</a> op het HTTP Archive-discussieforum dat zeker invloed heeft gehad op de zoekopdrachten die in dit hoofdstuk worden gebruikt. Gezien het grote aantal lettertypen dat voor Aziatische talen wordt geproduceerd, zal het gebruik in die regio waarschijnlijk toenemen naarmate technologie beschikbaar komt om die lettertypen efficiënter aan te bieden.

### Dienen met een dienst

{{ figure_markup(
  caption="Populariteit van Google Fonts onder font-hostingservices.",
  content="70,3%",
  classes="big-number",
  sheets_gid="1925210751",
  sql_file="04_05.web_font_usage_breakdown_with_fcp.sql"
) }}

Het is waarschijnlijk geen verrassing dat (<a hreflang="en" href="https://fonts.google.com/">Google Fonts</a> verreweg het populairste platform blijft, maar het percentage gebruik is in feite met bijna 5% gedaald van 2019 tot ongeveer 70%. <a hreflang="en" href="https://fonts.adobe.com/">Adobe Fonts</a> (voorheen Typekit) is ook met ongeveer 3% gedaald, maar <a hreflang="en" href="https://getbootstrap.com/">Bootstrap-gebruik</a> is gegroeid van ongeveer 3% tot meer dan 6% (in totaal van verschillende providers). Het is vermeldenswaard dat de grootste provider voor Bootstrap (<a hreflang="en" href="https://www.bootstrapcdn.com/">BootstrapCDN</a>) ook pictogramlettertypen biedt van <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>, dus het kan zijn dat het niet Bootstrap zelf is, maar eerder oudere versies die ook verwijzen naar pictogramlettertypebestanden die achter de toename van die brongegevens zitten.

Een andere verrassing in de gegevens is de toename van het aantal lettertypen dat wordt bediend door <a hreflang="en" href="https://www.shopify.com/">Shopify</a>. Met een groei van ongeveer 1,1% in 2019 tot ongeveer 4% in 2020, is er duidelijk een aanzienlijke stijging te zien in het gebruik van weblettertypen door sites die op dat platform worden gehost. Het is onduidelijk of dat komt doordat die service meer lettertypen aanbiedt die ze op hun CDN hosten, of het een groei in het gebruik van hun platform is, of beide. De toename van het gebruik van zowel Shopify als Bootstrap vertegenwoordigt echter de grootste hoeveelheid groei, behalve Google Fonts, waardoor het een zeer opvallend gegevenspunt is.

#### Niet alle services hebben dezelfde service

{{ figure_markup(
  image="fonts-median-fcp-of-sites-using-hosted-fonts.png",
  caption="Mediaan FCP van sites die gehoste lettertypen gebruiken.",
  description="Een staafdiagram met de gemiddelde FCP van desktop- en mobiele sites met verschillende fonthosts. `static.parastorage.com` is de snelste met 1.443 milliseconden voor desktop en 3.060 voor mobiel, `fonts.shopifycdn.com` staat op 1.407 voor desktop en 4.426 voor mobiel, `cdn.shopify.com` op respectievelijk 1.492 en 4.676, `cdnjs.cloudflare.com` op 2150 en 5167, `maxcdn.bootstrapcdn.com` op 2166 en 5224, `netdna.bootstrapcdn.com` op 2239 en 5.304, `use.fontawesome.com` op 2350 en 5.572, `fonts.gstatic.com` op 2.543 en 5.709, `cdn.jsdelivr.net` op 2.603 en 6.434, en `use.typekit.net` staat op 2.384 en 7.370.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=919344016&format=interactive",
  sheets_gid="1925210751",
  sql_file="04_05.web_font_usage_breakdown_with_fcp.sql"
  )
}}

Het was interessant om de verschillen in snelheid op te merken voor sites die de verschillende gratis / open source en commerciële services gebruiken. Als we kijken naar de tijden van First Content Paint (FCP) en Last Content Paint (LCP), bevinden sites die Google Fonts gebruiken ongeveer in het midden, maar over het algemeen iets langzamer dan de mediaan. De snelste sites in de dataset zijn Shopify en Wix (die middelen van `parastorage.com` bedienen), en er mag worden aangenomen dat ze zich richten op een klein aantal sterk geoptimaliseerde bestanden. Aan de andere kant levert Google ook weblettertypen wereldwijd van sterk variërende grootten (vanwege taal), wat waarschijnlijk resulteert in iets langzamere mediane tijden.

{{ figure_markup(
  image="fonts-median-lcp-of-sites-using-hosted-fonts.png",
  caption="Mediaan LCP van sites die gehoste lettertypen gebruiken.",
  description="Een staafdiagram met de gemiddelde FCP van desktop- en mobiele sites met verschillende fonthosts. `cdn.shopify.com` is het snelst met 3.335 op desktop en 8.401 op mobiel, `fonts.shopifycdn.com` staat respectievelijk op 3.224 en 8.531, `netdna.bootstrapcdn.com` op 3.910 en 8.183, `maxcdn.bootstrapcdn.com` op 4.240 en 8.530, `cdnjs.cloudflare.com` op 4.105 en 8.730, `use.fontawesome.com` op 4.519 en 9.166, `fonts.gstatic.com` op 4.878 en 9.558, `cdn.jsdelivr.net` op 5.368 en 10.646, `static.parastorage.com` staat op 4.322 en 11.813, `use.typekit.net` staat op 4.700 en 12.552.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2012634758&format=interactive",
  sql_file="04_05.web_font_usage_breakdown_with_fcp.sql"
  )
}}

Bij het bekijken van commerciële services zoals Adobe (`use.typekit.net`) of Monotype (`fast.fonts.com`) is het interessant om op te merken dat ze op desktop net zo snel of iets sneller zijn dan Google Fonts, maar merkbaar langzamer op mobiel. De conventionele wijsheid heeft over het algemeen aangenomen dat de trackingscripts die door die services worden gebruikt, ze aanzienlijk vertragen, maar dat is blijkbaar tegenwoordig minder een probleem dan in de afgelopen jaren. Hoewel het waar is dat we de prestaties van de site meten en niet noodzakelijk de prestaties van de font-host, hebben deze trackingscripts invloed op het laden van lettertypen op de cliënt, dus het lijkt relevant om deze observaties op te nemen.

#### Zelfhosting is niet altijd beter

Zelf-hostende lettertypen op hetzelfde domein als de website kunnen sneller zijn, zoals <a hreflang="en" href="https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/">we ontdekten voor deze website</a>, dit is echter niet altijd het geval, zoals blijkt uit de gegevens.

{{ figure_markup(
  image="fonts-web-hosting-performance-desktop.png",
  caption="Hosting van weblettertypen, desktop.",
  description="Een staafdiagram met de desktopmediaan First Contentful Paint en Last Contentful Paint (in milliseconden) voor drie verschillende hostingstrategieën voor weblettertypen: lokaal is 2.426 milliseconden voor mediaan FCP en 4.176 voor mediaan LCP, extern is respectievelijk 2.034 en 3.671, en beide is 2.663 en 5.044 milliseconden respectievelijk.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=506816237&format=interactive",
  sheets_gid="838326315",
  sql_file="04_04.self_hosted_vs_hosted_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-web-hosting-performance-mobile.png",
  caption="Prestatie van weblettertypen hosting, mobiel.",
  description="Een staafdiagram met de mobiele mediaan First Contentful Paint en Last Contentful Paint (in milliseconden) voor drie verschillende hostingstrategieën voor weblettertypen: lokaal is 5.326 milliseconden voor mediaan FCP en 8.521 voor mediaan LCP, extern is respectievelijk 5.056 en 8.229 en beide zijn 5.847 en 9.900 milliseconden respectievelijk.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1955186104&format=interactive",
  sheets_gid="838326315",
  sql_file="04_04.self_hosted_vs_hosted_with_fcp.sql"
  )
}}

Het zou niet logisch zijn om een causaliteit tussen de hostingstrategie af te leiden uit de bovenstaande gegevens, aangezien er andere variabelen zijn die de relatie kunnen verstoren. Maar afgezien daarvan merken we dat het toevoegen van zelfhosting-lettertypen niet altijd tot betere prestaties leidt. Oplossingen voor gehoste lettertypen voeren vaak een aantal optimalisaties uit (zoals subsetting, het verwijderen van OpenType-functies en het verzekeren van de kleinst mogelijke lettertypeformaat) die bij zelfhosting niet altijd worden gerepliceerd.

#### Lokaal is niet altijd beter

Een andere optie van self-hosting fonts op de server van de site, is om de door het systeem geïnstalleerde fonts op de cliënt te gebruiken waar ze bestaan door het gebruik van `local` in de `font-face` declaratie. Het gebruik van `local` is <a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html">controversieel</a>, omdat het bytes kan besparen, maar het kan ook slechte resultaten opleveren als de lokaal geïnstalleerde versie van het lettertype is verouderd. Vanaf [november 2020](https://x.com/googlefonts/status/1328761547041148929?s=19) is Google Fonts overgeschakeld op het gebruik van `local` alleen voor Roboto op mobiele platforms, anders wordt het lettertype altijd opgehaald via de netwerk.

## Racen naar eerste lak

Het grootste probleem met de prestaties van het integreren van weblettertypen is dat ze de tijd kunnen vertragen waarop de eerste leesbare tekst wordt weergegeven. Twee optimalisatietechnieken kunnen deze problemen helpen verminderen: `font-display` en bron hints.

De instelling [`font-display`](https://developer.mozilla.org/docs/Web/CSS/@font-face/font-display) bepaalt wat er gebeurt tijdens het wachten tot het weblettertype wordt geladen en is over het algemeen een afweging tussen prestatie en visuele rijkdom. De meest populaire is `swap`, gebruikt op ongeveer 10% van de webpagina's, die wordt weergegeven met behulp van het fallback-lettertype als het weblettertype niet snel laadt, en vervolgens het weblettertype verwisselt wanneer het wordt geladen. Andere instellingen zijn onder meer `block`, dat het weergeven van tekst helemaal vertraagt (waardoor het mogelijke knipperende effect wordt geminimaliseerd), en `fallback`, wat lijkt op `swap` maar het snel opgeeft en het fallback-lettertype gebruikt als het lettertype niet wordt geladen in een matige hoeveelheid tijd, en `optional`, die het onmiddellijk opgeeft en het fallback-lettertype gebruikt; dit wordt slechts door 1% van de webpagina's gebruikt, vermoedelijk degenen die zich het meest bezighouden met prestaties.

{{ figure_markup(
  image="fonts-usage-of-font-display.png",
  caption="Gebruik van font-display.",
  description="Een staafdiagram dat het gebruik van de verschillende instellingen voor lettertypeweergave op desktop en mobiel toont: `swap` wordt gebruikt door 10,9% van de desktopsites en 10,3% van de mobiele sites, `auto` wordt gebruikt door respectievelijk 5,2% en 5,6%, `block` met respectievelijk 4,1% en 4,2%, `fallback` met 0,9% voor beide, en tenslotte wordt `optional` gebruikt door 0,3% van de desktopsites en 0,1% van de mobiele sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=654093509&format=interactive",
  sheets_gid="1485693069",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

We kunnen het effect van deze instellingen op First Contentful Paint en Largest Contentful Paint analyseren. Het is niet verrassend dat de `optional` instelling een groot effect heeft op Grootste inhoudelijke verf. Er is ook een effect op First Contentful Paint, maar dat is misschien meer correlatie dan causaliteit, aangezien alle modi behalve `block` *wat* tekst weergeven na een "extreem kleine blokperiode".

{{ figure_markup(
  image="fonts-font-display-performance-desktop.png",
  caption="`font-display` prestatie op desktop.",
  description="Een staafdiagram met de desktop mediaan first content paint (FCP) en last content paint (LCP) in milliseconden voor verschillende lettertypeweergave-instellingen: `none` heeft een mediaan FCP van 2.286 ms en mediaan LCP van 4.028 ms, `optional` heeft Respectievelijk 1.766 ms en 3.055 ms, `swap` heeft 2.223 ms en 4.176 ms, `fallback` heeft 2.397 ms en 4.106 ms, `block` heeft 2.454 ms en 4.696 ms, en `auto` heeft 2.605 ms en 4.883 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1618299142&format=interactive",
  sheets_gid="1485693069",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-font-display-performance-mobile.png",
  caption="`font-display` prestatie op mobiel.",
  description="Een staafdiagram met de mobiele mediaan first content paint (FCP) en last content paint (LCP) in milliseconden voor verschillende font-weergave-instellingen: `none` heeft een mediaan FCP van 5.279 ms en een mediaan LCP van 8.381 ms, `optional` heeft Respectievelijk 4.733 ms en 6.598 ms, `swap` heeft 5.268 ms en 8.748 ms, `fallback` heeft 5.478 ms en 8.706 ms, `block` heeft 5.739 ms en 9.625 ms, en `auto` heeft 6.181 ms en 10.103 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2135700957&format=interactive",
  sheets_gid="1485693069",
  sql_file="04_06.font_display_with_fcp.sql"
  )
}}

Er zijn twee andere interessante gevolgtrekkingen uit deze gegevens. U zou kunnen verwachten dat de instelling `block` een aanzienlijke impact heeft op FCP, vooral op mobiel, maar in de praktijk is het effect niet zo groot. Dat suggereert dat het wachten op lettertypen zelden de beperkende factor is voor de prestaties van de webpagina als geheel, hoewel het zeker een belangrijke factor zou zijn op pagina's zonder veel bronnen, zoals afbeeldingen. De `auto` instelling (wat u ook krijgt als u het niet specificeert) is aan de browser. Het lijkt veel op `block` omdat <a hreflang="en" href="https://nooshu.github.io/blog/2020/02/23/improving-perceived-performance-with-the-css-font-display-property/">de standaard in de meeste gevallen blokkeren is</a>.

Ten slotte is een rechtvaardiging voor het gebruik van `fallback` het verbeteren van de Largest Content Paint-tijden in vergelijking met `swap` (wat waarschijnlijker de visuele bedoeling van de ontwerper respecteert), maar de gegevens ondersteunen dit geval niet; deze prestatiestatistiek is niet beter. Misschien is dit de reden waarom de instelling niet populair is, die door slechts ongeveer 1% van de pagina's wordt gebruikt.

Google Fonts raadt nu `swap` aan in de voorgestelde integratiecode. Als u het nu niet gebruikt, kan het toevoegen ervan een manier zijn om de prestaties te verbeteren, vooral voor gebruikers met langzame verbindingen.

### Bron hints

Hoewel `font-display` de presentatie van de pagina kan versnellen wanneer de lettertypen langzaam worden geladen, kunnen hints voor bronnen het laden van weblettertypen naar eerder in de cascade verplaatsen.

Gewoonlijk is het ophalen van weblettertypen een proces in twee fasen. De eerste fase is het laden van de CSS, die een verwijzing bevat (in `@font-face`-secties) naar de daadwerkelijke font-binaries.

Dit is vooral relevant voor gehoste lettertype-oplossingen. Pas nadat ontdekt is dat het lettertype nodig is, kan de verbinding met die server beginnen, die verder wordt afgebroken in de DNS-query voor de server, en daadwerkelijk een verbinding tot stand brengen (die tegenwoordig meestal een cryptografische HTTPS-handshake omvat).

{{ figure_markup(
  image="fonts-resource-hints-use.png",
  caption="Bron hints gebruik op lettertypen.",
  description="Een staafdiagram toont het gebruik van verschillende bron hints instellingen voor lettertypegegevens: `dns-prefetch` wordt gebruikt door 32% van zowel desktop- als mobiele sites, `preload` door 17% van desktop en 16% van mobiel, `preconnect` met 8% van beide, `prefetch` met 3% van beide en `prerender` met 0% voor beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1880156934&format=interactive",
  sheets_gid="2079638999",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

Het toevoegen van een <a hreflang="en" href="https://www.w3.org/TR/resource-hints/#resource-hints">bron hint element</a> in de HTML start die tweede verbinding eerder. De verschillende instellingen voor bron hints bepalen hoe ver dat komt voordat de URL voor de daadwerkelijke lettertypebron is. De meest voorkomende (bij ongeveer 32% van de webpagina's) is `dns-prefetch`, hoewel er in de meeste gevallen betere keuzes zijn.

Vervolgens zullen we kijken of deze bron hints een invloed hebben op de paginaprestaties.

{{ figure_markup(
  image="fonts-resource-hints-performance-desktop.png",
  caption="Bron hints prestatie, desktop.",
  description="Een staafdiagram met de mediaan van de first content paint en de last content paint van de desktop (in milliseconden) voor verschillende instellingen voor bron hints: `prerender` heeft een mediaan FCP van 1.658 ms en een mediaan LCP van 2.904 ms, `preload` heeft 2.045 ms en 3.865 ms respectievelijk `prefetch` heeft 1.909 ms en 3.702 ms, `preconnect` heeft 2.069 ms en 4.213 ms, `none` heeft 2.489 ms en 4.816 ms, en `dns-prefetch` heeft 2.630 ms en 5.061 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=355239876&format=interactive",
  sheets_gid="2079638999",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

{{ figure_markup(
  image="fonts-resource-hints-performance-mobile.png",
  caption="Bron hints prestatie, mobiel.",
  description="Een staafdiagram met de mobiele mediaan van de first content paint en de last content paint (in milliseconden) voor verschillende bron hints-instellingen: `prerender` heeft een mediaan FCP van 3.387 ms en mediaan LCP van 7.362 ms, `preload` heeft 4.900 ms en 8222 ms respectievelijk, `prefetch` heeft 4.942 ms en 8.191 ms, `preconnect` heeft 4.858 ms en 9.131 ms, `none` heeft 5.825 ms en 10.027 ms, en `dns-prefetch` heeft 5.908 ms en 9.962 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=640692889&format=interactive",
  sheets_gid="2079638999",
  sql_file="04_07.font_resource_hints_with_fcp.sql"
  )
}}

Analyse van deze gegevens suggereert dat de `dns-prefetch`-instelling, hoewel de meest populaire, de prestaties niet veel of helemaal niet verbetert. Vermoedelijk wordt de DNS voor populaire weblettertypeservers waarschijnlijk toch in de cache opgeslagen. De andere instellingen geven veel meer waar voor uw geld, waarbij `preconnect` een goede plek is voor gebruiksgemak, flexibiliteit en prestatieverbetering. Vanaf maart 2020 raadt Google Fonts aan om deze regel toe te voegen aan de HTML-bron, direct voor de CSS-link:

```html
<link rel="preconnect" href="https://fonts.gstatic.com">
```

Het gebruik van `preconnect` is aanzienlijk gegroeid sinds vorig jaar, nu 8% van 2%, maar er ligt nog veel meer potentiële prestatie op tafel. Het toevoegen van deze regel is misschien wel de beste optimalisatie voor webpagina's die Google Fonts gebruiken.

Het kan verleidelijk zijn om nog verder in de pijplijn te gaan en het lettertype-item vooraf te laden of vooraf te renderen, maar dat is mogelijk in strijd met andere optimalisaties, zoals het afstemmen van het lettertype voor de mogelijkheden van de weergave-motor of de optimalisatie van het `unicode-range` hieronder omschreven. Om een bron vooraf te laden, moet u *precies* weten welke bron u moet laden, en de beste bron voor de taak kan afhangen van informatie die niet direct beschikbaar is op het moment van HTML-schrijven.

## Home op het (Unicode) range

Lettertypen hebben in toenemende mate ondersteuning voor heel veel talen. Andere lettertypen kunnen een groot aantal glyphs hebben omdat het schrijfsysteem (vooral CJK) dit vereist. Beide redenen kunnen de bestandsgrootte vergroten. Dat is jammer als de webpagina in feite geen meertalig woordenboek is en slechts een fractie van de mogelijkheden van het lettertype gebruikt.

Een oudere benadering is dat de HTML-auteur expliciet een lettertypesubset aangeeft. Dat vereist echter een diepere kennis van de inhoud en riskeert een "losgeldbrief"-effect wanneer de inhoud tekens gebruikt die door het lettertype worden ondersteund, maar niet door de gekozen subset. Zie het uitstekende essay <a hreflang="en" href="https://www.figma.com/blog/when-fonts-fall/">When fonts fall</a> van Marcin Wichary voor veel meer details over hoe fallback werkt.

Statische subsets, aangegeven met `unicode-range`, zijn een betere benadering van dit probleem. Het lettertype wordt opgedeeld in subsets, elk met een aparte `@font-face`-regel die de Unicode-range voor dat segment aangeeft met een `unicode-range`-descriptor. De browser analyseert vervolgens de inhoud als onderdeel van zijn weergavepijplijn en downloadt *alleen* de plakjes die nodig zijn om die inhoud weer te geven.

Voor alfabetische talen werkt dit doorgaans goed, hoewel het kan resulteren in slechte tekenspatiëring tussen tekens in verschillende subsets. Voor talen die afhankelijk zijn van glyph-vormgeving, zoals Arabisch, Urdu en veel Indische talen, resulteren statische subsets vaak in een gebroken tekstweergave. En voor CJK bieden statische subsets op basis van aaneengesloten Unicode-range bijna geen voordeel omdat de tekens die op een bepaalde pagina worden gebruikt, bijna willekeurig over de verschillende subsets zijn verspreid. Vanwege deze problemen is een correct en performant gebruik van statische subsets lastig en vereist een zorgvuldige analyse en implementatie.

{{ figure_markup(
  image="fonts-usage-of-unicode-range.png",
  caption="gebruik van unicode-range.",
  description="Een staafdiagram dat de fractie van het gebruik van het Unicode-range toont op mobiele en desktopwebpagina's die weblettertypen gebruiken. Op desktop gebruikt 37,05% van de pagina's het unicode-range, terwijl 62,95% dat niet doet. Op mobiel gebruikt 38,27% van de pagina's het unicode-range, terwijl 61,73% dat niet doet.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=1739264728&format=interactive",
  sheets_gid="640499741",
  sql_file="04_08.font_unicode_range_with_fcp.sql"
  )
}}

Het correct toepassen van `unicode-range` is lastig, aangezien er veel complexiteit is in de manier waarop tekstlay-out Unicode in glyphs omzet, maar Google Fonts doet dit automatisch en transparant. Het is waarschijnlijk alleen een overwinning voor lettertypen met grote glyph-tellingen. In ieder geval is het huidige gebruik 37% op desktop en 38% op mobiel.

## Formaten en MIME-typen

WOFF2 is het beste compressieformaat en wordt nu <a hreflang="en" href="https://caniuse.com/woff2">ondersteund</a> door bijna alle browsers behalve versie 11 en eerder van Internet Explorer. Het is *bijna* mogelijk om weblettertypen aan te bieden met behulp van een `@font-face`-regel met alleen een WOFF2-bron. Dit formaat maakt ongeveer 75% uit van alle lettertypen die worden weergegeven.

{{ figure_markup(
  image="fonts-web-font-mime-types.png",
  caption="Populaire MIME-typen voor weblettertypen.",
  description="Een staafdiagram met de uitsplitsing van het percentage verschillende MIME-typen voor het weergeven van weblettertypen: WOFF2 wordt gebruikt door 75,83% van de pagina's die lettertypen gebruiken op desktop en 74,32% op mobiel, WOFF wordt gebruikt door respectievelijk 11,57% en 11,61%, octet-stream door 6,33% en 6,09%, ttf met 2,54% en 4,42%, en plain met respectievelijk 1,41% en 1,32%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=2028456617&format=interactive",
  sheets_gid="316058576",
  sql_file="04_10.font_formats.sql"
  )
}}

WOFF is een ouder, minder efficiënt compressiemechanisme, maar wordt bijna universeel ondersteund, goed voor 11,6% extra lettertypen. In bijna alle gevallen (Internet Explorer 9-11 is de belangrijkste uitzondering), laat het serveren van een lettertype als WOFF de prestaties op tafel liggen en is er een risico op zelfhosting; zelfs als de formaatkeuzes optimaal waren op het moment van integratie, vereist het extra inspanning om ze bij te werken naarmate de browsers verbeteren. Het gebruik van een gehoste service garandeert dat het beste formaat wordt gekozen, samen met alle relevante optimalisaties.

Oude versies van Internet Explorer (6-8), die nog steeds ongeveer 1,5% van het wereldwijde browseraandeel uitmaken, ondersteunen alleen het EOT-formaat. Deze verschijnen niet in de top 5 MIME-formaten, maar zijn nodig voor maximale compatibiliteit.

Ongecomprimeerde lettertypen, zoals OTF- en TTF-bestanden, zijn 2-3x groter dan gecomprimeerde lettertypen, maar vormen nog steeds bijna 5% van alle lettertypen die worden weergegeven, onevenredig veel op mobiele apparaten. Als u deze bedient, zou het een rode vlag moeten zijn dat optimalisatie mogelijk is.

## Populaire lettertypen

Pictogramlettertypen zijn de helft van de top 10 van meest populaire weblettertypen, de rest zijn strakke, robuuste schreefloze letterontwerpen (Roboto Slab staat op #19 en Playfair Display op #26 in deze ranglijst, voor debuten van andere stijlen, hoewel serif-ontwerpen goed vertegenwoordigd zijn in de staart van de distributie).

{{ figure_markup(
  image="fonts-popular-typefaces.png",
  caption="Populaire lettertypen.",
  description="Een staafdiagram met de 10 meest populaire weblettertypen, te beginnen met Font Awesome (35% van desktop en mobiel), Open Sans (23% desktop en 25% van mobiel), Roboto (17% desktop en 23% mobiel), Glyphicons Halflings (16% voor beide), Lato (11% voor beide), Montserrat (19% voor beide), Font Awesome 5 Brands (9% voor beide), Font Awesome 5 Free (9% desktop en 8% mobiel), Raleway (6% voor beide) en dashicons (6% voor beide).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=551344676&format=interactive",
  sheets_gid="179750099",
  sql_file="04_11a.popular_typeface.sql",
  width="600",
  height="520"
  )
}}

Let op: bij het bepalen van de meest populaire lettertypen kunt u verschillende resultaten krijgen, afhankelijk van de meetmethode. Het bovenstaande diagram is gebaseerd op het tellen van het aantal pagina's met een `@font-face`-regel die verwijst naar het genoemde lettertype. Dat telt slechts één keer meerdere stijlen, wat aantoonbaar weegt in het voordeel van lettertypen met één stijl.

## Kleur lettertypen

Kleurlettertypen, in een of andere vorm, worden ondersteund door de meeste moderne browsers, maar het gebruik is nog steeds bijna onbestaande (in totaal 755 pagina's in totaal, waarvan de meeste in SVG-indeling, die niet wordt ondersteund in Chrome). Een deel van het probleem is ongetwijfeld de diversiteit aan formaten, in feite vier die op grote schaal worden gebruikt. Deze zijn er in bitmap- en vector-smaken. De twee bitmapindelingen lijken technologisch erg op elkaar, maar SBIX (oorspronkelijk een eigen Apple-indeling) wordt niet ondersteund in Firefox, terwijl CBDT / CBLC niet wordt ondersteund in Safari.

Het COLR-vectorformaat wordt ondersteund door alle grote moderne browsers, maar pas vrij recent. Het vierde formaat is het insluiten van SVG in OpenType (niet te verwarren met SVG-lettertypen), maar wordt niet ondersteund in Chrome. Een nadeel van SVG in OpenType is het gebrek aan ondersteuning voor lettertypevariaties, een steeds belangrijker aspect van modern webdesign. Om deze reden zal het COLR-formaat waarschijnlijk de overhand krijgen, vooral omdat ondersteuning voor verlopen en knippen wordt ontwikkeld voor een toekomstige versie van COLR. Vectorformaten zijn meestal veel kleiner dan afbeeldingen en kunnen ook netjes worden geschaald naar grotere formaten, dus wanneer COLR arriveert met een rijker arceringmodel, kan het heel goed populair worden.

Een reden voor de slechte ondersteuning van kleurlettertypen op het web is dat de kleuren in de lettertypebestanden zelf moeten worden gebakken. Als u hetzelfde lettertype gebruikt met drie verschillende kleurencombinaties, moeten bijna identieke bestanden drie keer worden gedownload en het wijzigen van een kleur betekent dat u naar een font-editor moet zoeken.

Hoewel er een functie in CSS is om <a hreflang="en" href="https://drafts.csswg.org/css-fonts-4/#font-palette-values">de kleurenpaletten in lettertypen te overschrijven of te vervangen</a>, is dit nog niet geïmplementeerd in browsers, wat het gemak van het implementeren van weblettertypen in kleur zeker in de weg staat.

Waarschijnlijk wordt het meeste gebruik van kleurlettertypen voor emoji, maar de mogelijkheid is algemeen en kleurlettertypen bieden veel ontwerpmogelijkheden. Hoewel weblettertypen in kleur nog niet van de grond zijn gekomen, wordt de onderliggende technologie veel gebruikt om systeememoji te leveren, waarbij compatibiliteit van bestandsindelingen veel minder een probleem is.

Browserondersteuning is zo gefragmenteerd dat kleurlettertypen nog niet worden gevolgd door caniuse.com, hoewel er <a hreflang="en" href="https://github.com/Fyrd/caniuse/issues/1018)">een issue voor is</a>.

Veel meer informatie over kleurlettertypen, inclusief voorbeelden, is beschikbaar op <a hreflang="en" href="https://www.colorfonts.wtf/">colorfonts.wtf</a>.

## Variabele lettertypen

{{ figure_markup(
  caption="Gebruik van variabele lettertypen op mobiel.",
  content="11,00%",
  classes="big-number",
  sheets_gid="91894176",
  sql_file="04_14a.variable_font_comparison_fcp.sql"
) }}

Variabele lettertypen zijn zeker een van de grootste verhalen dit jaar. Ze worden gezien op 10,54% van de desktoppagina's en 11,00% van de mobiele apparaten. Dat is gestegen ten opzichte van gemiddeld 1,8% vorig jaar, een enorme groeifactor. Het is niet moeilijk in te zien waarom hun populariteit toeneemt - ze bieden meer ontwerpflexibiliteit en mogelijk ook kleinere binaire lettergroottes, vooral als er meerdere stijlen van hetzelfde lettertype op dezelfde pagina worden gebruikt.

Waarschijnlijk is de grootste oorzaak van deze toename te wijten aan het feit dat Google Fonts nu een aantal van hun meer populaire aanbiedingen aanbiedt als variabele lettertypen wanneer er voldoende gewichten op een pagina worden gebruikt en de browser deze ondersteunt. De mogelijkheid om variabele lettertypen 'in te wisselen' waar een prestatiewinst kan worden behaald zonder de gebruikte CSS of enige tussenkomst van de webauteur te wijzigen, is een opmerkelijk bewijs van de levensvatbaarheid van de technologie.

De eenvoudigste beschrijving van het variabele lettertypeformaat is een enkel lettertypebestand dat net zo veel werkt: in plaats van afzonderlijke lettertypebestanden voor elke dikte en breedte of zelfs cursief, kunnen ze allemaal in een enkel, zeer efficiënt bestand worden opgenomen. Dat resulterende bestand kan het lettertype weergeven op een bepaalde combinatie van aswaarden via CSS (of andere toepassingen die deze ondersteunen). Er zijn een aantal gestandaardiseerde of 'geregistreerde' assen plus de mogelijkheid voor lettertypeontwerpers om hun eigen assen te definiëren en deze aan de gebruiker bloot te stellen.

Gewicht (`wght`) komt overeen met de traditionele notie van normaal of bold of licht; width (`wdth`) wordt toegewezen aan stijlen zoals gecomprimeerd of uitgebreid; schuin (`slnt`) verwijst naar een schuine hoek van het lettertype; cursief (`ital`) laat het lettertype meestal schuin staan ​​en vervangt bepaalde glyphs door alternatieve stijlen; en optische grootte (`opsz`) verwijst naar iets relatief nieuws op het web, maar is in feite een heropleving van een techniek die veel voorkomt bij het maken van metaaltypen die honderden jaren teruggaat. Historisch gezien verwijst optische maatvoering naar de praktijk van het verminderen van lijncontrast (dikke en dunne lijnen) en het vergroten van de letterafstand wanneer een lettertype fysiek kleiner is gemaakt om de leesbaarheid te vergroten, en omgekeerd om dat contrast te vergroten en de afstand te verkleinen wanneer een lettertype wordt gemaakt met een fysiek kleiner formaat en als een lettertype op veel grotere formaten wordt weergegeven. Als u dit in digitale lettertypen inschakelt, kan een enkel lettertype er wezenlijk anders uitzien en zich aanzienlijk anders gedragen bij gebruik in zeer kleine of grote formaten. U kunt er meer over leren en veel voorbeelden bekijken op <a hreflang="en" href="https://variablefonts.io">variablefonts.io</a>.

{{ figure_markup(
  image="fonts-font-variation-settings-usage.png",
  caption="Gebruik van assen voor lettertype-variatie-instellingen.",
  description="Een staafdiagram toont het gebruik van de 6 meest populaire assen voor instellingen voor lettertypevariaties, gedomineerd door `wght` met 84,7% voor desktop en 90,4% voor mobiel, met een enorme daling naar de overige met `wdth` van 5,6% voor desktop en 4,3% voor mobiel, `opsz` respectievelijk 3,7% en 1,2%, `slnt` 1,8% en 1,4%, `fanu` 0,5% en 0,6%, en `ital` 0,5% voor desktop en 0,4% voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT2Q4hcDGGdclJH2ym0Pp_f8JWvYur_OQFQNkuScJyO7_ZCR1KPZsewL-mEZhxcuRFcde_Mxio8z_8P/pubchart?oid=635348995&format=interactive",
  sheets_gid="309969915",
  sql_file="04_17.VF_axis_value.sql"
  )
}}

Verreweg de meest gebruikte as is `wght` (die het gewicht regelt), met 84,7% desktop en 90,4% mobiel. Echter, `wdth` (breedte) is verantwoordelijk voor ongeveer 5% van het gebruik van variabele fonts. In 2020 begon Google Fonts met het aanbieden van 2-assige lettertypen met zowel breedte- als gewichtsassen.

Het is vermeldenswaard dat de voorkeursmethode het gebruik van `font-weight` en `font-stretch` is in plaats van de syntaxis van `font-variation-settings` op een lager niveau voor deze twee assen, aangezien ze volledig worden ondersteund door alle browsers die ondersteuning bieden voor variabele lettertypen. Door het gewicht in te stellen via `font-weight: [number]` en breedte via `font-stretch: [number]%`, geven auteurs meer geschikte stijlhints aan de browser, wat op zijn beurt een betere weergave mogelijk maakt voor de eindgebruiker als de variabele lettertype kan niet worden geladen. Dit voorkomt ook dat de normale overerving van stijlen via de cascade wordt gewijzigd.

De functie optische grootte (`opsz`) wordt gebruikt voor ongeveer 2% van het gebruik van variabele lettertypen. Dit is er een om naar te kijken, aangezien het afstemmen van het uiterlijk van een lettertype op de beoogde presentatiegrootte de visuele verfijning op misschien subtiele maar zeer reële manieren verbetert. Het gebruik zal waarschijnlijk ook toenemen zodra enkele huidige cross-browser en cross-platform onzekerheden over hoe de optische groottes worden gedefinieerd, worden opgehelderd. Een aantrekkelijk aspect van de functie voor optische grootte is dat met de `auto`-instelling de variatie automatisch plaatsvindt, zodat de ontwikkelaar het voordeel van die verfijning krijgt door gewoon een lettertype te gebruiken met de `opsz`-functie.

Het gebruik van variabele lettertypen heeft veel potentiële voordelen. Hoewel elke opgenomen as de bestandsgrootte vergroot, lijkt het omslagpunt in het algemeen te zijn als er meer dan twee of drie gewichten van een bepaald lettertype worden gebruikt, een variabele versie waarschijnlijk vergelijkbaar is in de totale bestandsgrootte of kleiner. Dit wordt ondersteund door de dramatische toename van <a hreflang="en" href="https://fonts.google.com/?vfonly=true">variabele lettertypen die worden bediend door Google Fonts</a>.

Variabele lettertypen gebruiken en implementeren voor een meer gevarieerd ontwerp (door meer van het beschikbare bereik aan gewichten en breedtes te gebruiken) is een andere. Het gebruik van een breedteas kan de lijnomloop op kleinere schermen verbeteren, vooral bij grotere koppen en langere talen. Met de toenemende acceptatie van alternatieve lichtmodi, kan het maken van kleine aanpassingen aan het lettertype-gewicht bij het wisselen van modus de leesbaarheid verbeteren (zie <a hreflang="en" href="https://variablefonts.io">variablefonts.io</a> voor meer over gebruik en implementatie).

## Gevolgtrekking

De technologie voor weblettertypen is redelijk volwassen, met stapsgewijze verbeteringen in compressie en andere technische verbeteringen, maar er komen nieuwe functies aan. Browserondersteuning voor variabele lettertypen is redelijk goed geworden, en dit is de functie die het afgelopen jaar de meeste groei heeft gekend.

Het prestatielandschap verandert enigszins, aangezien de komst van <a hreflang="en" href="https://developers.google.com/web/updates/2020/10/http-cache-partitioning">cachepartitionering</a> vermindert het prestatievoordeel van het delen van de cache van CDN lettertypebronnen op meerdere sites. De trend om meer lettertypen te hosten op hetzelfde domein als de site, in plaats van een CDN te gebruiken, zal waarschijnlijk doorzetten. Desalniettemin zijn services zoals Google Fonts in hoge mate geoptimaliseerd, en beste praktijken zoals het gebruik van `swap` en `preconnect` verzachten veel van de impact van de extra HTTP-verbinding.

Het gebruik van variabele lettertypen neemt enorm toe en die trend zal ongetwijfeld doorzetten, vooral nu de ondersteuning van de browser en ontwerptool verbetert. Het is ook mogelijk dat 2021 het jaar wordt van het kleurenweblettertype; ook al is de technologie aanwezig, dat is zeker nog niet gebeurd.

Ten slotte is het de moeite waard om een nieuw concept in de weblettertypetechnologie te vermelden dat momenteel wordt onderzocht door de W3C's Web Font Working Group: Progressive Font Enrichment. PFE is ontworpen als antwoord op veel van de uitdagingen die in dit hoofdstuk worden genoemd: het aanpakken van prestaties en gebruikerservaring bij het gebruik van lettertypebestanden met een groot aantal glyphs (zoals Arabische of CJK-lettertypen), grotere meerassige lettertypen of kleurlettertypen, of gewoon langzame netwerkverbinding omgevingen.

Het concept in zijn eenvoudigste bewoordingen is dat slechts een deel van een bepaald lettertypebestand hoeft te worden gedownload om de inhoud op een bepaalde pagina weer te geven. Als de pagina daarna wordt geladen, wordt er een 'patch' aan het lettertypebestand geleverd die alleen de glyphs bevat die nodig zijn om elke nieuwe pagina weer te geven. De gebruiker hoeft dus nooit het hele lettertypebestand in één keer te downloaden.

Er zijn verschillende details die moeten worden uitgewerkt, waaronder gegevens die de privacy en compatibiliteit met eerdere versies zullen helpen waarborgen - maar het eerste onderzoek was buitengewoon veelbelovend en het is te hopen dat deze technologie ergens in de komende jaren het grotere web zal bereiken. U kunt er meer over leren in <a hreflang="en" href="https://rwt.io/typography-tips/progressive-font-enrichment-reinventing-web-font-performance">deze inleiding door Jason Pamental</a>, en lees <a hreflang="en" href="https://www.w3.org/TR/2020/NOTE-PFE-evaluation-20201015/">de volledige <span lang="en">Working Group Evaluation Report</span></a> op de W3C-site.
