---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Paginagewicht
description: Het hoofdstuk Paginagewicht van de Web Almanac 2020 behandelt waarom paginagewicht belangrijk is, bandbreedte, complexe pagina's, paginadruk in de loop van de tijd, paginaverzoeken en bestandsindelingen.
hero_alt: Hero image of Web Almanac charactes using a set of scales to weigh a web page against variuos boxes labelled with various different kilobytes.
authors: [henrihelvetica]
reviewers: [paulcalvano]
analysts: [paulcalvano]
editors: [tunetheweb]
translators: [noah-vdv]
henrihelvetica_bio: Henri is een freelance ontwikkelaar die zijn interesses heeft omgezet in een potpourri van prestatie-engineering met een vleugje gebruikerservaring. Wanneer hij niet de stortvloed aan dagelijkse onderzoeksdocumenten en casestudy's leest, of lukraak sites controleert in dev-tools, kan Henri worden aangetroffen die bijdraagt aan de gemeenschap door meetups mee te programmeren, waaronder de <a href="https://x.com/towebperf">Toronto Web Performance Group</a> of vrijwilligerswerk doen voor de lunch en lessen bij verschillende bootcamps. Anders werkt hij met muziekproductiesoftware of met bijna zekerheidstraining en concentreert hij zich op het rennen van de snelst mogelijke 5k.
discuss: 2054
results: https://docs.google.com/spreadsheets/d/1wG4u0LV5PT9aN-XB1hixSFtI8KIDARTOCX0sp7ZT3h0/
featured_quote: De reis van het web van het eenvoudige, bijna pedagogische platform naar de innovatieve, ingewikkelde en zeer interactieve apps die het is geworden, de rudimentaire metriek van het paginagewicht verborg een groter verhaal&colon; een ratatouille van bronnen, die elk van invloed zijn op moderne statistieken, op hun beurt op de gebruikerservaring.
featured_stat_1: 1.915
featured_stat_label_1: Het gemiddelde aantal bytes van mobiele pagina's
featured_stat_2: 916
featured_stat_label_2: Het gemiddelde aantal afbeeldingsbytes voor mobiele pagina's
featured_stat_3: 70
featured_stat_label_3: Het gemiddelde aantal mobiele paginaverzoeken
---

## Inleiding

Paginagewicht is een van de eenvoudigere statistieken die beschikbaar zijn. Net zoals op menselijke schaal stappen om een idee te krijgen van uw persoonlijke gewicht (nou ja, massa echt, maar u begrijpt het), het laden van een pagina geeft een idee van het aantal en de grootte van de verzamelde en gevraagde bronnen. Maar naarmate het web en de webpagina's volwassener en groter zijn geworden, zijn ook de bijbehorende statistieken, zoals paginagewicht, toegenomen. Het kan de prestaties van een pagina beïnvloeden, net zoals persoonlijk gewicht (massa) hetzelfde kan doen. In dit hoofdstuk wordt dieper ingegaan op de lagen van webpagina's en wordt bekeken wat het gewicht van een pagina is, mogelijk ten nadele van de eindgebruiker: jij, ik, wij.

<!-- markdownlint-disable MD018 -->
## #PageWeightStillMatters

#PageWeightStillMatters zou bijna impliceren dat het er niet toe deed of er ooit toe deed. Het maakte misschien niet uit wanneer op tekst gebaseerde Craigslist werd gelanceerd. Maar 25 jaar geleden, toen het werd opgericht, werd Mosaic 1.0 in hetzelfde jaar ook gelanceerd, en Waterfalls van TLC was een tophit. Het web werd volwassen, net als de bronnen. Het was nog maar een paar jaar geleden dat de Twitterverse werd vastgehouden en besprak hoe de gemiddelde grootte van webpagina's nu gelijk was aan de grootte van de <a hreflang="en" href="https://www.wired.com/2016/04/average-webpage-now-size-original-doom/">oorspronkelijke ondergang</a>. Velen van ons peinsden over hoe groot de pagina in de loop van de tijd zou kunnen worden, inclusief <a hreflang="en" href="https://speedcurve.com/blog/web-performance-page-bloat/">onze eigen Tammy Everts</a>, maar de realiteit is verbluffend. Een pagina bevat respectievelijk ~4MB en 3,7MB, desktop/mobiel, op het 75e percentiel en een schokkende 7,4MB en 6,7MB op het 90e percentiel. Het hebben van zulke zware pagina's heeft talloze gevolgen, zoals de waarschijnlijkheid van een slechte gebruikerservaring door onbetrouwbare netwerken. Ondanks de lessen <a hreflang="en" href="https://blog.chriszacharias.com/page-weight-matters">die we tien jaar geleden hebben geleerd</a>, ondervinden we tegenwoordig variaties op dezelfde uitdagingen: ondanks dat we iets betere netwerken hebben, werken we met veel grotere middelen.
<!-- markdownlint-enable MD018 -->

### Bandbreedte

Toen hem in 2016 werd gevraagd om uit te leggen waarom een Australische toerist met wie ik had gesproken opgetogen was over het Britse internet, had Google's Ilya Grigorik <a hreflang="en" href="https://youtu.be/x4S38hpgxuM?t=89">twee woorden</a>: <span lang="en">physics damn it!</span> (natuurkunde verdomme!) (oeps, dat zijn er drie).

Het punt was simpel: hoewel u misschien profiteert van een grotere bandbreedte, gelden de wetten van de fysica nog steeds. Een Australiër kan niet ontsnappen aan de latentiewetten. In het beste geval, thuis in Sydney, ervoer deze Australiër genoeg latentie dat zijn internet soms als niet-reagerend werd ervaren.

Stelt u nu voor dat dezelfde Australiër, wetende dat zijn pagina op het 75e percentiel ongeveer 108 verzoeken doet (daarover later meer), en we hebben nog steeds geen idee van het netwerkprotocol, de bronnen die worden aangevraagd, het compressieniveau of optimalisatie. U kunt de hoofdstukken [HTTP/2](./http) en [Compressie](./compression) doornemen voor meer informatie over de levensduur van een modern verzoek.

### Activa

In 25 jaar modern browsen zijn de activa en bronnen meestal niet veranderd, behalve het bedrag. De HTTP Archive modus operandi is "hoe het web is gebouwd", en dat werd meestal gedaan met HTML, CSS, JavaScript en tenslotte afbeeldingen.

Vóór 1995 was het gewicht van de webpagina grotendeels voorspelbaar en beheersbaar. Maar met <a hreflang="en" href="https://tools.ietf.org/html/rfc1866">RFC 1866</a>, die HTML 2.0 introduceerde die inline afbeeldingen introduceerde via het `<img>`-element, zou het paginagewicht aanzienlijk toenemen - en dat alles voor de goed van webontwikkeling (het toevoegen van afbeeldingen werd gezien als een positief experiment).

De vuistregel was voor het grootste deel dat afbeeldingen het grootste deel van het paginagewicht zouden uitmaken. Het was zeker het geval en een punt van zorg toen in-line afbeeldingen toen aan het web werden toegevoegd en dat is nog steeds het geval. In een apart scenario, aangezien afbeeldingsgegevens de grootste bron van paginagewicht zullen zijn, zal het ook de grootste bron van paginagewichtsbesparing zijn (nogmaals, daarover later meer). Dit wordt bereikt door ervoor te zorgen dat de afbeeldingen het juiste formaat hebben, maar ook door ervoor te zorgen dat de afbeeldingen zich op de beste plek voor optimalisatie bevinden - het vinden van de beste balans tussen kwaliteit en bestandsgrootte.

Hoewel JavaScript gemiddeld de op een na meest voorkomende bron op een pagina is, hebben we doorgaans meer mogelijkheden om met dat bestandstype te werken: van bundeling, compressie en minificatie om er maar een paar te noemen.

### Ingewikkeld en interactief

De reis van het web van het eenvoudige, bijna pedagogische platform naar de innovatieve, ingewikkelde en zeer interactieve apps die het is geworden, de rudimentaire metriek van het paginagewicht verborg een groter verhaal&colon; een ratatouille van bronnen, die elk van invloed zijn op moderne statistieken, op hun beurt op de gebruikerservaring.

Wanneer we het hebben over interactiviteit, hebben we het bijna uitsluitend over JavaScript. Hoewel we hier niet zijn om interactiviteit diepgaand te bespreken, weten we dat er statistieken zijn die gericht zijn op en afhankelijk zijn van JavaScript-inhoud en uitvoering. Dus hoe zwaarder het JavaScript, hoe groter de kans dat het een grotere impact heeft op de interactiviteitsstatistieken (tijd tot interactief, totale blokkeringstijd). We hebben het [JavaScript-hoofdstuk](./javascript) dat nog een snufje verder duikt.

## Analyse

Terwijl we de statistische resultaten posten en ontleden, zijn de gegevens vaak gebaseerd op overdrachtsgroottes. We gebruiken echter waar mogelijk gedecomprimeerde formaten in deze analyse.

### Paginagewicht

Laten we eens kijken naar het klassieke paginagewicht, zowel op desktop als mobiel. De delta's zijn meestal te wijten aan een paar minder bronnen die op mobiel zijn overgedragen, een waarschijnlijke snuifje mediabeheer, maar u kunt hieronder zien dat bij de mediaan de verschillen niet zo significant zijn tussen de twee cliënten.

{{ figure_markup(
  image="bytes-distribution.png",
  caption="Verdeling van het totale aantal bytes per pagina.",
  description="Staafdiagram met de verdeling van het totale aantal bytes per pagina. Desktoppagina's hebben doorgaans meer bytes tijdens de distributie. De 10, 25, 50, 75 en 90e percentielen voor mobiele pagina's zijn: 369, 900, 1.915, 3.710 en 6.772KB per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=248363224&format=interactive",
  sheets_gid="378779486",
  sql_file="bytes_per_type_2020.sql"
) }}

We kunnen hieruit echter het volgende vermoeden: we naderen 7MB paginagewicht op mobiel en 7,5MB op desktop op het 90e percentiel. De gegevens volgen een eeuwenoude trend: de groei van het paginagewicht zit weer in de lift, vergeleken met het voorgaande jaar.

{{ figure_markup(
  image="bytes-distribution-content-type.png",
  caption="Mediane bytes per pagina op inhoudstype.",
  description="Staafdiagram met het gemiddelde aantal bytes per pagina voor afbeeldingen, JavaScript, CSS en HTML. De gemiddelde desktoppagina heeft meer bytes. De gemiddelde mobiele pagina heeft 916KB aan afbeeldingen, 411KB JS, 62KB CSS en 25KB HTML.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=1147150650&format=interactive",
  sheets_gid="378779486",
  sql_file="bytes_per_type_2020.sql"
) }}

Als we de motorkap openen, kunnen we zien hoe de dingen kijken naar de mediaan en het gemiddelde voor elke bron. Nog één ding blijft: afbeeldingen zijn de dominante bron en JavaScript is de tweede meest voorkomende, hoewel een verre tweede.

### Verzoeken

We hebben een oud gezegde: het snelste verzoek is het nooit gedaan. Durven we dan te zeggen: de kleinste bron is er een die nooit is aangevraagd. Op verzoekniveau is veel hetzelfde. De zwaarste bronnen maken de meeste verzoeken.

{{ figure_markup(
  image="requests-distribution.png",
  caption="Verdeling van verzoeken per pagina.",
  description="Staafdiagram met de verdeling van verzoeken per pagina. Desktoppagina's laden meer verzoeken. De 10, 25, 50, 75 en 90e percentielen voor mobiele pagina's zijn: 23, 42, 70, 114 en 174 verzoeken per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=971564375&format=interactive",
  sheets_gid="457486298",
  sql_file="request_type_distribution_2020.sql"
) }}

De verdeling van de verzoeken laat zien dat het verschil tussen desktop en mobiel niet zo groot is, met desktop voorop. Iets dat het vermelden waard is: het mediaan verzoek op desktop op dit moment is hetzelfde [als vorig jaar](../2019/page-weight#pagina-verzoeken) (74), maar het paginagewicht is aangevinkt (+122kb). Een simpele observatie, maar een die het traject bevestigt dat we door de jaren heen hebben gezien.

{{ figure_markup(
  image="requests-content-type.png",
  caption="Mediaan aantal verzoeken per mobiele pagina per inhoudstype.",
  description="Staafdiagram met het gemiddelde aantal verzoeken per mobiele pagina per inhoudstype. Het gemiddelde aantal afbeeldingsverzoeken per pagina is 27, 19 voor JS, 7 voor CSS en 3 voor HTML. Desktop en mobiel zijn doorgaans gelijk, behalve dat desktoppagina's iets meer afbeeldingen en JS-verzoeken laden.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=101271976&format=interactive",
  sheets_gid="457486298",
  sql_file="request_type_distribution_2020.sql"
) }}

Afbeeldingen vormen opnieuw het grootste aantal verzoeken, hoewel JavaScript dichterbij komt, aangezien de kloof het afgelopen jaar iets kleiner is geworden.

### Bestandsformaten

{{ figure_markup(
  image="response-distribution-format.png",
  caption="Verdeling van afbeeldingsformaten per formaat.",
  description="Boxplot van de verdeling van afbeeldingsformaten per indeling: gif, ico, jpg, png, svg en webp. Jpg springt eruit als de hoogste distributie met een 90e percentiel van meer dan 150KB per afbeelding. Png is de tweede hoogste met ongeveer 100KB op het 90e percentiel. Hoewel WebP een kleiner 90e percentiel heeft dan png, is het 75e percentiel hoger. gif, ico en svg hebben allemaal relatief kleine distributies van bijna 0KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=211653520&format=interactive",
  sheets_gid="142855724",
  sql_file="response_format_distribution.sql"
) }}

We weten dat afbeeldingen een grote bron van paginagewicht zijn. Deze afbeelding hierboven toont ons de belangrijkste bronnen van beeldgewicht en de gewichtsverdeling. Top 3: JPG, PNG en WebP. Dus niet alleen is de JPG het meest populaire afbeeldingsformaat, het heeft ook de neiging om ook het grootste formaat te hebben - zelfs groter dan een verliesvrij formaat zoals de PNG. Maar zoals we [vorig jaar opmerkten](../2019/page-weight#bestandsgrootte-op-afbeeldingsformaat-voor-afbeeldingen--1024-bytes), heeft dat te maken met de overheersende use case voor de PNG , die pictogrammen en logo's lijken te zijn.

### Afbeelding bytes

{{ figure_markup(
  image="response-distribution-images.png",
  caption="Verdeling van afbeeldingsresponsgroottes per pagina.",
  description="Staafdiagram met de verdeling van afbeeldingsbytes per pagina. Desktoppagina's hebben de neiging om meer afbeeldingsbytes per pagina te laden tijdens de distributie. De 10, 25, 50, 75 en 90e percentielen voor mobiele pagina's zijn: 67, 284, 928, 2.365 en 4.975kB aan afbeeldingen per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=2019686506&format=interactive",
  sheets_gid="730277265",
  sql_file="request_type_distribution_2020.sql"
) }}

Als we kijken naar het totale aantal bytes van afbeeldingen, zien we dezelfde trend naar boven, zoals eerder opgemerkt bij het totale paginagewicht.

## COVID-19

2020 was het meest veeleisende jaar in de internetgeschiedenis. Dit is gebaseerd op zelfrapportage door <a hreflang="en" href="https://www2.telegeography.com/network-impact">telecombedrijven</a> over de hele wereld. YouTube, Netflix, fabrikanten van spelconsoles en nog veel meer werd gevraagd om <a hreflang="en" href="https://www.bloomberg.com/news/articles/2020-03-19/netflix-to-cut-streaming-traffic-in-europe-to-relieve-networks">hun netwerken te vertragen</a> vanwege de verwachte bandbreedtevereisten van COVID-19 en de lockdown maatregelen. Er zijn nu nieuwe verdachten die eisen stellen aan de netwerken: we werken nu vanuit huis, teleconferenties vanuit huis en ook onderwijs vanuit huis. In het midden van deze crisis zijn sommige overheidsorganisaties vooruitgegaan om alle aspecten van de site te optimaliseren en opnieuw te ontwerpen of bij te werken. Twee van dergelijke voorbeelden van zijn <a hreflang="en" href="https://ca.gov">ca.gov</a> (<a hreflang="en" href="https://news.alpha.ca.gov/prioritizing-users-in-a-crisis-building-covid19-ca-gov/">link</a>) en <a hreflang="en" href="https://gov.uk">gov.uk</a>. In deze tijden heeft COVID-19 het internet gecertificeerd als een essentiële dienst en de toegang tot cruciale en levensreddende informatie moet zo wrijvingsvrij mogelijk zijn, inclusief een beheersbaar paginagewicht via gedisciplineerde levering van gegevens.

Als we met internet zijn getrouwd, heeft COVID-19 ons gedwongen onze geloften te hernieuwen. Om ervoor te zorgen dat de inhoud zo efficiënt mogelijk via internet wordt afgeleverd, moet het paginagewicht te allen tijde voorop blijven staan.

## Een niet zo verre toekomst

We hebben 25 jaar lang het paginagewicht zien groeien. Het zou een van de grootste aandeleninvesteringen kunnen zijn geweest - als het er een was geweest. Maar dit is het web en we proberen gegevens, verzoeken, bestandsgrootte en uiteindelijk paginagewicht te beheren.

We hebben zojuist de gegevens gekamd en gezien hoe afbeeldingen de grootste bron van gewicht zijn. Dit betekent dat het ook onze grootste bron van besparingen zal zijn. 2020 was een cruciaal jaar, een mogelijk omslagpunt voor het volgen van webgegevens via HTTP Archive. 2020 was het jaar waarin het moderne formaat WebP eindelijk door Safari werd overgenomen, waardoor dit formaat eindelijk door alle browsers over de hele linie werd ondersteund. Dit betekent dat het formaat comfortabel kan worden gebruikt met weinig tot geen terugval. Het belangrijkste punt? Het potentieel voor aanzienlijke besparingen op het paginagewicht is aanwezig - met een mogelijke 30%.

Nog interessanter is het idee van een moderner formaat: avif. Dit formaat is op de markt gekomen met voldoende ondersteuning vandaag voor ongeveer 70% van het browsermarktaandeel, waardoor een scenario ontstaat voor kleine afbeeldingsbestanden - zelfs kleiner dan WebP. En tot slot, en mogelijk de meest verre: mediaquery's niveau 5, `prefers-reduced-data`. Hoewel in een zeer vroege versie, zal deze mediafunctie worden gebruikt om te detecteren of een gebruiker een voorkeur heeft voor variantbronnen in gegevensgevoelige situaties en al <a hreflang="en" href="https://caniuse.com/mdn-css_at-rules_media_prefers-reduced-data">beschikbaar is geworden in browsers</a>.

Als we naar de kristallen bol kijken, zouden de derde aflevering van de Web Almanac en het hoofdstuk Paginagewicht er in 2021 heel anders uit kunnen zien. De grote technologische en technische investeringen in afbeeldingen zouden eindelijk het afnemende rendement kunnen opleveren waarnaar we op zoek waren.

## Gevolgtrekking

Het is geen verrassing dat webpagina's over het algemeen zijn blijven groeien. We hebben meer middelen ingevoerd om rijkere ervaringen, meer boeiende interactiviteit en mooiere beelden te creëren door krachtigere beelden. We hebben deze applicaties gemaakt ten koste van gegevensoverschrijding en gebruikerservaringen. Maar terwijl we vooruitgaan en het web blijven pushen naar plaatsen die we nooit hadden verwacht, boeken we ook extra vooruitgang op het gebied van engineering, zoals eerder vermeld. Mogelijk beginnen we al volgend jaar een daling van het paginagewicht te zien, aangezien moderne rasterafbeeldingsformaten meer worden toegepast, we beginnen JavaScript efficiënter te beheren en de gegevens langs de draad te leveren met de discipline die gebruikers eisen.
