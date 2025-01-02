---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Media
description: Mediahoofdstuk van de Web Almanac 2020 met betrekking tot bestandsgroottes en -indelingen van afbeeldingen, responsieve afbeeldingen, cliënthints, lazy loading, toegankelijkheid en video.
hero_alt: Hero image of Web Almanac characters projecting an image onto a screen while other Web Almanac characters walk to cinema seats with popcorn to watch the projection.
authors: [tpiros, bseymour, eeeps]
reviewers: [nhoizey, colinbendell, dougsillars, Navaneeth-akam]
analysts: [smatei]
editors: [tunetheweb]
translators: [noah-vdv]
tpiros_bio: Tamas Piros is een Developer Experience Engineer bij <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>, Google Developer Expert en technisch instructeur met <a hreflang="en" href="https://fullstacktraining.com">Full Stack-training</a>.
bseymour_bio: Ben Seymour is een Dynamic Media & Content Specialist met <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>, auteur van <a hreflang="en" href="http://responsiveimag.es/">Practical Responsive Images</a> en mede-oprichter van <a hreflang="en" href="https://storyus.life/">Storyus</a> en <a hreflang="en" href="https://haktive.com/">Haktive</a>.
eeeps_bio: Eric Portis is een Web Platform Advocate bij <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a>.
discuss: 2041
results: https://docs.google.com/spreadsheets/d/1SZGpCsTT0u1MFBrxed7HA9FLAloL1dS8ZIng986LvS8/
featured_quote: Afbeeldingen en video's bieden ons het potentieel voor een zeer krachtige koppeling&colon; onmiddellijke communicatie, in staat om een aangeboren emotionele reactie teweeg te brengen. Ze vereisen echter weloverwogen implementatietechnieken om ook onze webpagina's niet te belasten.
featured_stat_1: 84,64%
featured_stat_label_1: Gebruik van WebP in het mobiele `<Picture>`-element
featured_stat_2: 40,26%
featured_stat_label_2: JPG-afbeeldingen als percentage van alle afbeeldingen
featured_stat_3: 57,22%
featured_stat_label_3: Video-elementen op desktop met het attribuut autoplay
---

## Inleiding

Tegenwoordig leven we in de wereld van het visuele web, waar media de ziel vormt voor websites. Websites gebruiken zowel afbeeldingen als video's om het publiek te betrekken door visuele verhalen te vertellen om te informeren en te entertainen. Dit hoofdstuk analyseert hoe we afbeeldingen en video's op internet gebruiken (of in sommige gevallen misbruiken).

## Afbeeldingen

"Een plaatje zegt meer dan duizend woorden", maar byte-gewijs kosten ze vaak een orde van grootte of twee extra.

Afbeeldingen bieden een zeer krachtige combinatie: onmiddellijke communicatie, in staat om een aangeboren emotionele reactie teweeg te brengen. Ze zijn echter ook veel zwaarder dan tekst en vereisen weloverwogen implementaties om te voorkomen dat gebruikerservaringen vastlopen. Laten we eens kijken hoe goed de mogelijkheden van moderne browsers worden benut.

### Responsieve HTML-opmaak voor afbeeldingen

Hoewel er talloze manieren zijn om media in te sluiten met JavaScript, waren we geïnteresseerd in de voortdurende opname van verschillende vormen van HTML-opmaak. Verschillende *responsieve afbeeldingen*-benaderingen, waaronder het `<picture>`-element, en `srcset` en `sizes`-attributen, hebben steeds meer ondersteuning gekregen sinds de introductie in 2014.

#### Srcset

Het `srcset`-attribuut stelt de user-agent in staat om het meest geschikte media-item uit een kandidatenlijst te bepalen om te laden.

Bijvoorbeeld:

```html
<img srcset="images/example_3x.jpg 3x, images/example_2x.jpg 2x"
      src="images/example.jpg" alt="...">
```

Ongeveer 26,5% van alle pagina's bevat nu `srcset`

Het aantal afbeeldingen dat aan de user agents wordt gepresenteerd om uit te kiezen, heeft directe gevolgen voor twee belangrijke prestatiefactoren:

1. <a hreflang="en" href="https://cloudfour.com/thinks/responsive-images-101-part-9-image-breakpoints/">Breekpunten van afbeeldingen</a> (om een prestatiebudget te halen)
2. Caching-efficiëntie

Hoe kleiner het aantal afbeeldingskandidaten, hoe groter de kans dat het item in de cache wordt opgeslagen, en als een CDN wordt gebruikt, hoe groter de kans dat het beschikbaar is op het dichtstbijzijnde edge-knooppunt van een cliënt. Hoe groter het verschil in media-afmetingen, hoe groter de kans dat we uiteindelijk media gaan aanbieden die minder geschikt zijn voor het apparaat en de context in kwestie.

##### Srcset: hoeveelheid beeldkandidaten

{{ figure_markup(
  image="srcset-number-of-candidates.png",
  caption="Srcset hoeveelheid kandidaten",
  description="Staafdiagram met het aantal kandidaten op desktop en mobiel. De meeste pagina's hebben 1-3 kandidaten (58,82% op desktop en 60,01% op mobiel), vooral als we uitbreiden naar 1-5 kandidaten (82,79% op desktop en 83,52% op mobiel). Daarna is de drop-off scherp met 5-10 kandidaten die slechts 13,12% op desktop hebben en 12,42% op mobiel. 10-15 kandidaten is gedaald tot 1,96% op desktop en 1,87% op mobiel en 15-20 kandidaten hebben 0,55% op desktop en 0,53% op mobiel",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=761924614&format=interactive",
  sheets_gid="1848992988",
  sql_file="image_srcset_candidates.sql"
  )
}}

Naast de reeds genoemde caching-inefficiënties, zal een groter aantal dimensionale varianten typisch zowel de complexiteit van de gebruikte mediapijplijn of dienst als de vereiste mediaopslag vergroten.

Houd er bij het bekijken van deze gegevens rekening mee dat een paar platforms (<a hreflang="en" href="https://make.wordpress.org/core/2015/11/10/responsive-images-in-wordpress-4-4/">zoals WordPress</a>) geautomatiseerde benaderingen gebruiken die van invloed zijn op een groot aantal sites.

##### Srcset: descriptoren

Bij het verstrekken van de kandidatenlijst aan de user-agent, hebben we twee mechanismen om de kandidaatafbeeldingen te annoteren: `x`-descriptoren en `w`-descriptoren.

`x`-descriptoren beschrijven de pixelverhouding van het apparaat van de specifieke bron. Een `2x`-descriptor zou bijvoorbeeld aangeven dat de specifieke afbeeldingsbron twee keer de dimensionale grootte heeft in elke as (met vier keer zoveel pixels) en geschikt is voor apparaten met een `window.devicePixelRatio` van `2`. Evenzo duidt een `3x`-descriptor negen keer het aantal pixels aan, wat natuurlijk aanzienlijke implicaties voor de payload kan hebben.

```html
<img srcset="images/example_3x.jpg 3x, images/example_2x.jpg 2x"
      src="images/example.jpg" alt="...">
```

`w`-descriptoren beschrijven de pixelbreedte van de kandidaat, samen met een `sizes`-attribuut dat wordt gebruikt om de juiste afbeelding te selecteren.

```html
<img srcset="images/example_small.jpg 600w, images/example_medium.jpg 1400w, images/example_large.jpg 2400w"
      sizes="100vw"
      src="images/example_fallback.jpg" alt="...">
```

Beide benaderingen stellen de user-agent in staat om wiskundig rekening te houden met de huidige pixelverhouding van het apparaat bij het beoordelen van de meest geschikte afbeeldingskandidaat.

{{ figure_markup(
  image="srcset-descriptor-usage.png",
  caption="Srcset descriptor gebruik.",
  description="Staafdiagram met het gebruik van de srcset-descriptor voor pagina's en afbeeldingen voor desktop en mobiel. 4,90% van de desktoppagina's en 5,15% van de mobiele pagina's gebruikt descriptor x, vergeleken met 21,37% van de desktoppagina's en 21,33% van de mobiele pagina's voor descriptor w. Als we echter naar alle afbeeldingen kijken, zien we dat 12,67% van de desktopafbeeldingen en 12,80% van de mobiele afbeeldingen descriptor x gebruiken, vergeleken met 21,37% van de desktop en 21,33% van de mobiele afbeeldingen voor descriptor w.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1336533401&format=interactive",
  sheets_gid="1370415291",
  sql_file="image_srcset_descriptor.sql"
  )
}}

In de begintijd van responsieve afbeeldingen ondersteunden sommige browsers alleen `x`-descriptoren, maar het is duidelijk dat `w`-descriptoren momenteel verreweg het meest populair zijn.

Hoewel het gebruikelijk kan zijn om afbeeldingskandidaten te kiezen die qua afmeting zijn verdeeld (waarbij elke afbeelding wordt weergegeven met een reeks vooraf gekozen breedten, bijv. 720px, 1200px en 1800px), zijn er ook benaderingen om meer lineaire payload-stappen te geven (bijv. Een reeks van bronnen die 50kb in verschil zijn). Hulpmiddelen zoals de <a hreflang="en" href="https://www.responsivebreakpoints.com/">Responsive Image Breakpoints Generator</a> kunnen handig zijn om dit te vergemakkelijken.

#### Sizes

Zonder het `sizes`-attribuut zal de user-agent zijn berekeningen maken op basis van een aanname in het slechtste geval dat de afbeelding de volledige breedte van de viewport beslaat. Hiermee hebben browsers meer informatie over de werkelijke lay-outgrootte van de afbeelding en kunnen ze betere keuzes maken.

Bijvoorbeeld:

```html
<img sizes="(min-width: 640px) 50vw, 100vw"
      srcset="images/example_small.jpg 600w, images/example_medium.jpg 1400w, images/example_large.jpg 2400w"
      src="images/example_fallback.jpg" alt="...">
```

{{ figure_markup(
  image="srcset-sizes-usage.png",
  caption="Gebruik van sizes in srcset.",
  description="Gestapeld staafdiagram dat laat zien dat 65,35% van de srcset-afbeeldingen sizes op desktop gebruikt, terwijl de resterende 34,65% het niet gebruikt. Op mobiel is 64,95% in gebruik en de resterende 35,05 niet in gebruik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=496958447&format=interactive",
  sheets_gid="768487310",
  sql_file="image_srcset_sizes.sql"
  )
}}

Voor de 2020-gegevens combineerde ongeveer 35% van de sites die `srcset` gebruikten, dit niet ook met `sizes`. Hoewel de browser graag terugvalt op een `size="100vw"` standaard, het attribuut uitgeschakeld laten is <a hreflang="en" href="https://alistapart.com/blog/post/article-update-dont-rely-on-default-sizes/">technisch incorrect</a>, en we komen regelmatig gevallen tegen waarin dit overzicht betekent dat de wiskunde om de meest geschikte afbeeldingskandidaat te bepalen gebrekkig is, wat vaak leidt tot het opvragen van onnodig grote afbeeldingen.

Veel mensen met wie we dit hebben besproken, geven aan dat `sizes` bijzonder lastig is om op een correcte, veerkrachtige manier te implementeren, vanwege de noodzaak om te zorgen voor cross-resource-uitlijning tussen lay-out (zoals beheerd en bepaald door CSS) en responsieve afbeeldingsopmaak (in HTML).

#### Afbeelding

Terwijl `srcset` en `sizes` ons hulpmiddelen bieden om browsers te helpen met afbeeldingen die qua afmetingen geschikter zijn voor een gegeven viewport, apparaat en lay-out, stelt het `<picture>` element ons in staat om meer geavanceerde mediastrategieën te bieden, inclusief effectievere beeldformaten gebruiken en ons in staat stellen om “art direction” te verkennen.

{{ figure_markup(
  image="use-of-picture.png",
  caption="Gebruik van `<picture>`.",
  description="Gestapeld staafdiagram dat laat zien dat 19,30% van de pagina's `<picture>` op desktop gebruikt en 80,70% niet. Op mobiel is het vergelijkbaar: 18,54% wel en 81,46% niet.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=416496535&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

De huidige opname laat zien dat ongeveer 19% van de pagina's wordt bediend met behulp van het element `<picture>` dat ten minste één afbeelding dient.

##### Picture: formaatwisseling

Hoewel er enkele services en afbeeldings-CDN's zijn die het automatisch overschakelen naar formaten van een enkele afbeeldings-URL kunnen bieden met behulp van logica op de backend, kunnen we ook soortgelijk gedrag bereiken door alleen opmaak te gebruiken, met het element `<picture>`.

```html
<picture>
    <source type="image/webp" srcset="images/example.webp">
    <img src="images/example.jpg" alt="...">
</picture>
```

Opsplitsend in het aantal aangeboden formaten:

{{ figure_markup(
  image="picture-number-of-formats.png",
  caption="`<picture>` aantal formaten.",
  description="Staafdiagram met het aantal formaten in beeldgebruik. 68,01% van de pagina's op desktop (68,03% op mobiel) gebruikt 1 formaat. 2 formaten is respectievelijk 23,78% en 23,78%, 3 formaten is 7,00% en 6,97% en 4+ formaten worden alleen gebruikt op respectievelijk 1,21% en 1,22% pagina's.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1963933588&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

Van de pagina's die `<picture>` gebruiken om van formaat te wisselen, biedt ongeveer 68% een enkele typevariant aan, naast de `<img src>` die als standaard fungeert.

{{ figure_markup(
  image="picture-format-usage-by-type.png",
  caption="Gebruik van beeldformaat op type.",
  description="Staafdiagram met het gebruik van het beeldformaat per afbeeldingstype. WebP domineert het gebruik dat door 83,29% van de beeldelementen op desktop wordt gebruikt (84,64% op mobiel). De volgende is PNG met 18,18% en 17,46%, gevolgd door JPG gebruikt door respectievelijk 4,84% en 4,83%, en dan Gif met 0,53% en 0,53% en AVIF registreert niet boven 0 voor beide cliënten.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=775091522&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

We zien dat WebP het dominante gebruik is van `<source>`-elementen, gevolgd door PNG, en dat en JPG slechts 4,83% van `<picture>`-gebruik is.

<aside class="note">Merk op dat onze crawler crawlt als Chrome die WebP ondersteunt, maar als u een andere browser gebruikt die dit niet ondersteunt, ziet u andere resultaten.</aside>

Hier is een voorbeeld van de markup-syntaxis die kan worden gebruikt om meerdere indelingsvarianten aan te bieden:

```html
<picture>
  <source type="image/avif" srcset="images/example.avif">
  <source type="image/webp" srcset="images/example.webp">
  <source type="image/jp2" srcset="images/example.jp2">
  <source type="image/vnd.ms-photo"  srcset="images/example.jxr">
  <img src="images/example.jpg" alt="Description">
</picture>
```

De user-agent zal effectief de eerste selecteren waarop hij een positieve match heeft, en daarom is de volgorde hier belangrijk.

Van de pagina's die `<picture>` gebruiken voor het wisselen van formaten, biedt 83% WebP aan als een van de formaatvarianten, wat gedeeltelijk te maken heeft met de groeiende browserondersteuning.

Formaatondersteuning in alle browsers is een verplaatsbaar feest: WebP heeft nu veel bredere ondersteuning gekregen.

- WebP: <a hreflang="en" href="https://caniuse.com/webp">90% Dekking</a> (Edge, Firefox, Chrome, Opera, Android)
- JPEG 2000: <a hreflang="en" href="https://caniuse.com/jpeg2000">18,5% Dekking</a> (Safari)
- JPEG XR: <a hreflang="en" href="https://caniuse.com/jpegxr">1,7% Dekking</a> (IE)
- AVIF: <a hreflang="en" href="https://caniuse.com/avif">25% Dekking</a> (Chrome, Opera)

Bij het samenstellen van een set reserveformaten moeten auteurs naast de compressieprestaties ook rekening houden met functies. Als een afbeelding bijvoorbeeld transparantie bevat, is PNG een goede "kleinste gemene deler" om in de `img src` op te geven. Vervolgens kunnen een of meer `<source>`-elementen die volgende-generatie formaten bevatten die *ook* transparantie ondersteunen - zoals WebP, JPEG 2000 en AVIF - daarbovenop worden gebruikt.

Overweeg op dezelfde manier om geanimeerde WebP's of gedempte, geloopte, autoplaying MP4's bovenop geanimeerde GIF's te stapelen (hoewel het mixen van video's en afbeeldingen gevolgen zal hebben voor de opmaakbenadering en de mediabewerkingsbehoeften).

Er zijn drie aspecten waarmee u rekening moet houden bij het implementeren van formaatwisseling:

- Het browserformaat ondersteunt landschap
- De mediapijplijn van een site: de processen die het gebruikt om de benodigde media in verschillende formaten te creëren
- Het implementeren van de opmaak om browsers te vertellen welke formaten worden aangeboden en wanneer ze elk moeten selecteren

Verschillende Dynamic Media Services en Image CDN's kunnen dit aanzienlijk vereenvoudigen door het te automatiseren en te trachten het steeds veranderende ondersteuningslandschap van browserformaten te volgen en er mee te synchroniseren.

<aside class="note">Let op: hoewel AVIF wordt ondersteund in Chrome sinds versie 85 (uitgebracht eind augustus 2020), zijn de gegevens voor deze Almanac voornamelijk van vóór deze tijd. Als u echter een ad-hoczoekopdracht uitvoert op recentere gegevens van begin november 2020, worden tienduizenden AVIF-verzoeken weergegeven.</aside>

##### Picture: media art direction

De media *art direction*-mogelijkheden die worden geboden door het `<picture>`-element stellen ons in staat om het soort geavanceerde viewport-afhankelijke mediamanipulatie te bieden waarvan we al een tijdje genoten bij het ontwerpen van lettertypen en lay-outs.

Bedenk hoe slecht landschapsgeoriënteerde media met zeer brede en korte beeldverhoudingen (zoals banners) werken wanneer ze in smalle, portretgeoriënteerde mobiele lay-outs worden geperst. Het aanpassen van de uitsnede of inhoud van afbeeldingen op basis van mediaquery's is naar onze mening een onderbenutte mogelijkheid.

In dit voorbeeld veranderen we de aspectverhouding van de aangeboden media, van vierkant (1:1) naar 4:3 en uiteindelijk 16:9, afhankelijk van de viewport-breedte, waarbij we proberen de beschikbare ruimte voor onze media zo goed mogelijk te gebruiken:

```html
<picture>
  <source media="(max-width: 780px)"
          srcset="image/example_square.jpg 1x, image/example_square_2x.jpg 2x">
  <source media="(max-width: 1400px)"
          srcset="image/example_4_3_aspect.jpg 1x, image/example_4_3_aspect_2x.jpg 2x">
  <source srcset="image/example_16_9_aspect.jpg 1x, image/example_16_9_aspect_2x.jpg 2x">
  <img src="image/example_fallback.jpg" alt="...">
</picture>
```

##### Picture: oriëntatie schakelen

Hoewel uit de gegevens blijkt dat slechts iets minder dan 1% van de pagina's die `<picture>` gebruiken, gebruik maakt van oriëntatie, voelt dit als een gebied dat verdere verkenning van website-ontwerpers en -ontwikkelaars rechtvaardigt.

{{ figure_markup(
  image="picture-usage-of-orientation.png",
  caption="`<picture>` gebruik van oriëntatie.",
  description="Staafdiagram dat laat zien dat 0,93% van de desktoppagina's en 0,91% van de mobiele pagina's `<picture>` met oriëntatie gebruikt. 0,59% van de gevallen van `<picture>` op desktop en 0,60% bij mobiel gebruik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=56906843&format=interactive",
  sheets_gid="283790776",
  sql_file="picture_orientation.sql"
  )
}}

Mobiele apparaten hebben kleine, vernauwde kijkvensters en kunnen gemakkelijk in de hand worden omgeschakeld van portret- naar landschapsmodus. Er is een interessant, onderbenut potentieel voor het gebruik van de oriëntatiemediaquery.

Voorbeeld syntaxis:

```html
<picture>
  <source srcset="images/example_wide.jpg"
          media="(min-width: 960px) and (orientation: landscape)">
  <source srcset="images/example_tall.jpg"
          media="(min-width: 960px) and (orientation: portrait)">
  <img src="..." alt="...">
</picture>
```

### Effectief gebruik van beeldformaten

Het gebruik van het juiste afbeeldingsformaat en de mogelijkheden die het formaat biedt, is van cruciaal belang om effectief gebruik te maken van media op webpagina's.

#### MIME-typen versus extensies

We hebben een hoge spreiding van extensies en verschillende spellingen van dezelfde extensie waargenomen (bijv. `Jpg` versus `JPG` versus `jpeg` versus `JPEG`). In sommige gevallen is het MIME-type ook verkeerd opgegeven. Bijvoorbeeld - `image/jpeg` is het juiste en herkende MIME-type voor JPEG-afbeeldingen. We kunnen echter zien dat 0,02% van alle pagina's die JPEG gebruiken het verkeerde MIME-type hebben gespecificeerd. Verder kunnen we zien dat de extensie `pnj` 28.420 keer werd gebruikt (waarschijnlijk een typfout) en dat de MIME-tijd was ingesteld op `image/jpeg`.

{{ figure_markup(
  image="image-usage-by-extension.png",
  caption="Afbeeldingsgebruik per extensie.",
  description="Staafdiagram met beeldgebruik per extensie. `jpg` is het meest gebruikte formaat met 40,26% van mobiel, `png` is de volgende met 26,90%, gevolgd door geen extensie met 17,44%, `gif` met 6,59%, `svg` met 3,13%, `ico` met 1,83 % en `jpeg` op 1,36%. Desktop is vergelijkbaar qua gebruik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1607248506&format=interactive",
  sheets_gid="402973893",
  sql_file="image_mimetype_ext.sql"
  )
}}

We hebben verdere inconsistenties gezien tussen extensies en MIME-typen - bijvoorbeeld `.jpg`s geleverd met een MIME-type van `image/webp`, maar het is waarschijnlijk dat sommige hiervan natuurlijke artefacten zijn die worden veroorzaakt door Image CDN-bezorgservices met snelle transformatie- en optimalisatiemogelijkheden.

#### Progressieve JPEG's

Hoe vaak komen progressieve <a hreflang="en" href="https://www.smashingmagazine.com/2018/02/progressive-image-loading-user-perceived-performance/#back-to-basis-progressive-jpegs">JPEG-bestanden</a> voor? WebPageTest geeft elke pagina een "score", die alle JPEG-bytes die zijn geladen uit progressief gecodeerde JPEG's bij elkaar optelt en deze deelt door het totale aantal JPEG-bytes dat progressief gecodeerd *had* kunnen worden. De meerderheid (57%) van de pagina's vertoonde progressief minder dan 25% van hun JPEG-bytes. Dit vertegenwoordigt een grote kans voor no-downsides compressiebesparingen, die nog moeten worden benut ondanks jarenlange progressieve JPEG's die een best practice zijn en moderne encoders zoals MozJPEG die standaard progressief coderen.

{{ figure_markup(
  image="progressive-jpeg-score.png",
  caption="Progressieve JPEG-score.",
  description="Staafdiagram met progressieve JPEG-score. Desktop- en mobiel gebruik is ongeveer hetzelfde. 13,72% van de mobiele pagina's heeft een score < 0, 57,77% heeft een score van 0-25, 7,53% heeft een score van 25-50, 5,79% heeft een score van 50-75 en 15,19% heeft een score van 75- 100.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1693689151&format=interactive",
  sheets_gid="1834242483",
  sql_file="score_progressive_jpeg.sql"
  )
}}

### Microbrowsers

Laten we nu eens kijken naar het onderwerp <a hreflang="en" href="https://24ways.org/2019/microbrowsers-are-everywhere/">microbrowsers</a>. Ook bekend als "linkontwikkelaars" en "linkuitbreiders", dit zijn de user agents die webpagina's opvragen en stukjes en beetjes van ze pakken om rijke previews samen te stellen wanneer links worden gedeeld in berichten of op sociale media. De *lingua franca* van microbrowsers is het <a hreflang="en" href="https://ogp.me">Open Graph-protocol</a> van Facebook, dus we hebben gekeken naar welk percentage webpagina's afbeeldingen en video bevat specifiek gericht op microbrowsers in Open Graph `<meta>`-tags.

{{ figure_markup(
  image="open-graph-image-and-video-usage.png",
  caption="Open Graph afbeelding en video gebruik.",
  description="Staafdiagram toont 33,78% van de desktoppagina's en 32,72% van de mobiele pagina's met Open Graph met afbeeldingen, 0,09% van de desktop en 0,10% van de mobiele pagina's gebruikt Open Graph met afbeeldingen, en het zijn exact dezelfde percentages voor beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=950603216&format=interactive",
  sheets_gid="625517121",
  sql_file="meta_open_graph.sql"
  )
}}

Een derde van de webpagina's bevat afbeeldingen, in Open Graph-tags, voor microbrowsers. Maar slechts ongeveer 0,1 procent van de pagina's bevat microbrowser-specifieke video's; zowat elke pagina die een video bevatte, bevatte ook een afbeelding.

Een derde van de onderzochte webpagina's lijkt erg gezond; De kracht van relationele mond-tot-mondreclame in combinatie met rijke previews op maat van een microbrowser is duidelijk de moeite waard om in te investeren.

Aangezien video-inhoud duur is om te produceren en veel minder vaak voorkomt op internet dan afbeeldingen, begrijpen we het relatief lage gebruik. Maar het feit dat video's vaak kunnen worden afgespeeld en zelfs automatisch kunnen worden afgespeeld vanuit de linkvoorbeelden zelf, zonder dat u naar een volledige browser hoeft te gaan, betekent dat dit een grote kans is om de betrokkenheid te vergroten.

{{ figure_markup(
  image="open-graph-image-type-usage.png",
  caption="Open Graph afbeeldingstype gebruik.",
  description="Staafdiagram met het volgende procentuele gebruik van verschillende afbeeldingsindelingen op mobiel: 50,51% voor jpg, 43,82% voor png, 1,60% voor gif, 1,78% voor jpeg, 0,66% voor svg, 0,31% voor pnj, 0,36% voor png:150, 0,28% voor ico en 0,23% voor webp. Desktop heeft zeer vergelijkbare nummers.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=475337707&format=interactive",
  sheets_gid="758253988",
  sql_file="meta_open_image_types.sql"
  )
}}

{{ figure_markup(
  image="open-graph-video-type-usage.png",
  caption="Open Graph videotype gebruik.",
  description="Staafdiagram met 68,55% van de desktoppagina's en 78,57% van de mobiele pagina's gebruikt het mp4-videoformaat, 19,75% van de desktoppagina's en 10,86% van de mobiele pagina's gebruikt het swf-formaat en 2,64% van de desktoppagina's en 2,83% van de mobiele pagina's gebruikt het webm-formaat.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=110839067&format=interactive",
  sheets_gid="353192921",
  sql_file="meta_open_video_types.sql"
  )
}}

Het Open Graph-protocol staat alleen toe dat *één* afbeelding of video-URL wordt opgenomen; er is niets van de context-adaptieve flexibiliteit die wordt geboden door `<picture>` en `srcset`. Auteurs zijn dus nogal conservatief bij het kiezen van formaten om naar microbrowsers te sturen. Volledig de helft van alle microbrowser-specifieke afbeeldingen zijn JPEG-bestanden; 45 procent zijn PNG's; net onder 2 procent zijn GIF's. WebP's zijn goed voor slechts 0,2% van de afbeeldingen voor microbrowsers.

Evenzo wordt op het gebied van video de overgrote meerderheid van de bronnen verzonden in het formaat met de kleinste gemene deler: MP4. We weten niet waarom het op één na populairste formaat de <a hreflang="en" href="https://blog.adobe.com/en/publish/2017/07/25/adobe-flash-update.html#gs.my93m2">nu afgeschreven</a> SWF is, en benieuwd of deze afspeelbaar zijn in een microbrowser.

### Gebruik van `rel=preconnect`

Media-items kunnen lokaal of op een Image CDN worden opgeslagen. De manier waarop activa worden geoptimaliseerd, getransformeerd en aan de eindgebruiker worden geleverd, hangt in hoge mate af van de gebruikte techniek. Bij het opnemen van afbeeldingen van een ander domein, kan het `rel=preconnect`-attribuut worden gebruikt op een `<link>`-element om browsers de mogelijkheid te geven DNS-verbindingen te initiëren voordat ze nodig zijn. Hoewel dit een relatief goedkope bewerking is, kunnen er situaties zijn waarin de extra CPU-tijd die wordt besteed aan het tot stand brengen van dergelijke verbindingen, ander werk vertraagt.

{{ figure_markup(
  caption="Mobiele pagina's die preconnect gebruiken.",
  content="8,19%",
  classes="big-number",
  sheets_gid="121764369",
  sql_file="big_non_custom_metrics.sql"
)
}}

Als we de opmaak analyseren, zien we op desktop 7,83% van de pagina's die dit gebruiken en op mobiel 8,19%. Het hoofdstuk [Bronhints](./resource-hints#hints-acceptatie) gebruikte een iets andere methodologie door de DOM te analyseren en kreeg vergelijkbare, maar iets grotere cijfers van respectievelijk 8,15% en 8,65%.

### Gebruik van `data:` URL's

Het gebruik van gegevens-URL's (voorheen bekend als gegevens-URI's) is een techniek waarmee ontwikkelaars een met base64 gecodeerde afbeelding rechtstreeks in HTML kunnen insluiten. Dit zorgt ervoor dat een afbeelding volledig wordt geladen tegen de tijd dat de HTML is geparseerd in een DOM-structuur, en garandeert virtueel dat de afbeelding beschikbaar zal zijn voor de eerste verflaag. Omdat ze echter niet zowel over de draad als binaire bestanden worden gecomprimeerd, wordt het laden van andere - mogelijk belangrijkere bronnen - geblokkeerd en wordt caching gecompliceerder, dus afbeeldingen met base-64 <a hreflang="en" href="https://calendar.perfplanet.com/2020/the-dangers-of-data-uris/">zijn een soort antipatroon</a>.

{{ figure_markup(
  caption="Mobiele pagina's die gegevens-URI's gebruiken.",
  content="9,10%",
  classes="big-number",
  sheets_gid="206827357",
  sql_file="big_non_custom_metrics.sql"
)
}}

Het gebruik hiervan lijkt niet zo wijdverbreid te zijn: 9% van de pagina's gebruikt gegevens-URL's voor het weergeven van afbeeldingen. Er moet echter worden opgemerkt dat we alleen HTML-ingebedde base64-gecodeerde afbeelding `src`'en hebben onderzocht en geen CSS-ingebedde base-64-gecodeerde afbeeldingen voor achtergrondafbeeldingen en dergelijke hebben opgenomen.

### SEO & Toegankelijkheid

Het associëren van beschrijvende tekst met afbeeldingen helpt niet alleen de toegankelijkheid voor degenen die de afbeeldingen niet kunnen bekijken en schermlezers gebruiken, maar het wordt ook gebruikt door verschillende computer vision-algoritmen om het onderwerp van een afbeelding te begrijpen. Beschrijvende tekst moet zinvol zijn in de context van de pagina en relevant zijn voor de afbeelding die wordt beschreven. Meer informatie over deze onderwerpen is te vinden in de hoofdstukken [SEO](./seo) en [Toegankelijkheid](./accessibility).

#### Gebruik van `alt`-tekst

Het `alt`-attribuut voor afbeeldingen wordt gebruikt om een beschrijving van de afbeelding te geven. Het wordt aangekondigd door schermlezers en wordt ook weergegeven in visuele browsers wanneer de afbeelding niet wordt geladen.

{{ figure_markup(
  image="image-alt-usage-by-page.png",
  caption="Afbeelding alt-gebruik per pagina.",
  description="In een staafdiagram staat 96,26% van de desktoppagina's en 96,04% van de mobiele pagina's met afbeeldingen. 52,5% van de desktoppagina's en 51,0% van de mobiele pagina's mist een alt-attribuut, 60,4% van de desktops en 60,6% van de mobiele pagina's heeft lege alt-attributen, en 83,6% van de desktops en 82,1% van de mobiele pagina's heeft een alt-attribuut.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=2144814052&format=interactive",
  sheets_gid="885941461",
  sql_file="image_alt.sql"
  )
}}

{{ figure_markup(
  image="image-alt-usage-by-image.png",
  caption="Afbeelding alt-gebruik per afbeelding.",
  description="Een staafdiagram toont dat 21,3% van de mobiele afbeeldingen en 21,5% van de desktopafbeeldingen alt-attributen missen, 26,2% van de mobiele en desktopafbeeldingen heeft lege alt-attributen en 52,5% van de mobiele en 52,3% van de desktopafbeeldingen heeft alt-attributen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=71848371&format=interactive",
  sheets_gid="885941461",
  sql_file="image_alt.sql"
  )
}}

Ongeveer 96% van alle verwerkte pagina's had een `<img>`-element - 21% van deze afbeeldingen miste een `alt`-attribuut. 52% van de afbeeldingen had een `alt`-attribuut, maar 26% hiervan werd blanco gelaten. Simpel gezegd: slechts ongeveer een kwart van de afbeeldingen op internet heeft een niet-blanco `alt`-attribuut; vermoedelijk zelfs minder dan die hebben een `alt`-tekst die nuttig beschrijvend is.

#### Figure & Figcaption

HTML5 heeft verschillende nieuwe semantische elementen aan de taal toegevoegd. Een voorbeeld van zo'n element is `<figure>`, dat optioneel een `<figcaption>`-element als kind kan bevatten. Tekstuele beschrijvingen in de `<figcaption>`s zijn semantisch gegroepeerd met de andere inhoud van de `<figure>`.

{{ figure_markup(
  image="figure-and-figcaption-usage-by-page.png",
  caption="Gebruik van Figure en Figcaption per pagina.",
  description="Staafdiagram toont 12,34% van de desktoppagina's en 12,16% van de mobiele pagina's gebruikt Figure, maar slechts 1,06% van de desktoppagina's en 1,13% van de mobiele pagina's gebruikt Figcaption.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=605432940&format=interactive",
  sheets_gid="2037389060",
  sql_file="big_non_custom_metrics.sql"
  )
}}

We kunnen zien dat ongeveer 12% van de pagina's op zowel desktop als mobiel het `<figure>`-element gebruikt, maar slechts ongeveer 1% gebruikt `<figcaption>` om een beschrijving toe te voegen.

## Videos

Als "een foto meer zegt dan duizend woorden", moet een minuut video met 30 fps 1,8 miljoen waard zijn!

Video is tegenwoordig een van de krachtigste manieren om met een publiek in contact te komen, maar het toevoegen van video aan een site is geen sinecure. Er is een wirwar van formaten en codecs om doorheen te navigeren, en talloze implementatiedetails om te overwegen. Maar de impact van video - zowel de visuele impact als de impact op de prestaties - kan niet genoeg worden benadrukt.

### Het `<video>`-element

Het `<video>`-element vormt de kern van videolevering op internet en wordt afzonderlijk of in combinatie met JavaScript-spelers gebruikt die het geleidelijk verbeteren om video te leveren.

### Bronnen (of niet) en totaal gebruik

Er zijn twee manieren om een videobron in te sluiten met behulp van het element `<video>`. U kunt ofwel een enkele bron-URL in het `src`-attribuut op het element zelf plakken, of het een willekeurig aantal onderliggende `<source>`-elementen geven, die de browser doorleest totdat het een bron vindt die het denkt te kunnen laden. Onze eerste vraag kijkt naar hoe vaak we elk van deze patronen op alle steekproefpagina's zien.

{{ figure_markup(
  image="video-usage-of-src-versus-source.png",
  caption="Videogebruik van Src versus Source.",
  description="Staafdiagram met 0,59% van de desktoppagina's en 0,49% van de mobiele pagina's dat Src gebruikt voor video, tegenover 1,14% van de desktoppagina's en 0,99% van de mobiele pagina's dat Source gebruikt.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=2100955508&format=interactive",
  sheets_gid="689453572",
  sql_file="big_non_custom_metrics.sql"
  )
}}

Twee keer zoveel `<video>`s hebben `<source>` kinderen, versus een `src`-attribuut. Dit geeft aan dat auteurs de mogelijkheid willen hebben om verschillende bronnen naar verschillende eindgebruikers te sturen, afhankelijk van hun context, in plaats van een enkele bron met de laagste gemene deler naar iedereen te sturen (of, als alternatief, een deel van hun publiek een slechtere, of gebroken, ervaring geven).

Interessant genoeg kunnen we ook zien dat op alle pagina's slechts een procent of twee überhaupt `<video>`-elementen bevatten. Het komt veel minder vaak voor dan `<img>`!

### JavaScript-spelers

We hebben gezocht naar de aanwezigheid van een paar veelvoorkomende spelers (hls.js, video.js, Shaka Player, JW Player, Brightcove Player en Flowplayer). Pagina's met deze specifieke spelers komen minder dan half zo vaak voor als pagina's die het native `<video>`-element gebruiken.

{{ figure_markup(
  image="video-element-versus-javascript-player.png",
  caption="Video-element versus JavaScript-speler.",
  description="Staafdiagram met 77,88% van de desktoppagina's en 74,77% van de mobiele pagina's met video gebruikt Video Element, 28,06% van de desktoppagina's en 30,57% van de mobiele pagina's met afbeeldingen gebruikt JavaScript Video Player en 5,94% van de desktoppagina's en 5,34% van de mobiele pagina's met afbeelding gebruikt beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=202644434&format=interactive",
  sheets_gid="1489710615",
  sql_file="video_tag_and_js_player.sql"
  )
}}

De analyse wordt een beetje gecompliceerd door het feit dat veel spelers - zoals video.js - in-source `<video>`-elementen verbeteren. Slechts 5-6% van de pagina's die de gezochte spelers gebruikten bevatte *ook* een `<video>`-element, maar het bewijs van dit patroon is eigenlijk beter zichtbaar als we kijken naar de waarden van `type`-attributen, binnen `<video>` en `<source>` elementen.

### Type-attributen

{{ figure_markup(
  image="video-source-types.png",
  caption="Videobrontypen.",
  description="Staafdiagram met het volgende gebruik van videoformaten op mobiel: 64,08% voor video/mp4, 19,68% voor video/mp4, 10,08% voor video/webm, 4,74% voor video/ogg, 0,51% voor video/vimeo, 0,37% voor video/ogv, 0,12% voor video/mpeg, 0,09% voor video/mov. Desktop lijkt hier erg op.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=203419864&format=interactive",
  sheets_gid="1459916814",
  sql_file="video_source_types.sql"
  )
}}

Het is niet verwonderlijk dat verreweg de meest voorkomende typewaarde `video/mp4` is. Maar de op een na meest voorkomende - die 15% van alle desktop `type`n uitmaakt en 20% van alle `type`n die naar de mobiele crawler worden gestuurd, is `video/youtube` - wat helemaal geen geregistreerd MIME-type is. Het is eerder een speciale waarde die verschillende spelers (waaronder WordPress) gebruiken bij het insluiten van YouTube-video's. Een paar inkepingen in de lijst zien we een soortgelijk patroon voor Vimeo-insluitingen.

Wat betreft de legitieme MIME-typen; ze vangen *container* formaten; MP4 en WebM zijn de enige twee in alles wat we algemeen gebruik zouden kunnen noemen. Het zou interessant zijn om te weten welke *codecs* in deze containers worden gebruikt, en hoeveel tractie volgende generatie codecs zoals VP8, HVEC en AV1 hebben gekregen. Maar een dergelijke analyse valt helaas buiten het omvang van dit artikel.

### Video preload

{{ figure_markup(
  image="video-preload-values.png",
  caption="Video preload waarden.",
  description="Staafdiagram dat laat zien dat 33% van de desktop- en mobiele pagina's met video heeft `none` als preload, 36% van de desktop- en 27% van de mobiele pagina's met video heeft `auto`, respectievelijk 24% en 33% heeft `metadata` en 4% en 5% hebben deze set niet.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=989934821&format=interactive",
  sheets_gid="1099175973",
  sql_file="video_preload_values.sql"
  )
}}

Het `preload`-attribuut geeft aan of een video moet worden gedownload en het kan drie waarden hebben: `none`, `metadata`, `auto` (merk op dat als het leeg wordt gelaten, de `auto`-waarde wordt aangenomen). We kunnen zien dat 4,81% van de pagina's `<video>`-elementen heeft, en 45,37% hiervan heeft het `preload`-attribuut. De cijfers op mobiel zijn iets anders, met slechts 3,59% van de pagina's met `<video>`-elementen en 43,38% van deze met het `preload`-attribuut.

### Autoplay en muted

{{ figure_markup(
  image="video-autoplay-and-muted-usage.png",
  caption="Video autoplay en muted gebruik.",
  description="Staafdiagram dat 57,22% van de desktoppagina's met video en 53,86% van de mobiele pagina's laat zien dat video's `autoplay` hebben, 56,36% en 53,41% is `muted` en 48,74% van de desktoppagina's en 45,99% van de mobiele pagina's met video zijn beide ingesteld.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1010709511&format=interactive",
  sheets_gid="1366238292",
  sql_file="video_autoplay_muted.sql"
  )
}}

Als we naar aanvullende informatie over video's kijken, kunnen we zien dat 57,22% van de `<video>` -elementen op desktop het `autoplay`-attribuut hebben, 56,36% van de pagina's met een `<video>`-element op desktop het `gedempt`-attribuut gebruiken en last but not least gebruikt 48,74% van de pagina's zowel `autoplay` als `muted` samen op de desktop. De cijfers zijn vergelijkbaar voor mobiel, waar 53,86% `autoplay` heeft, 53,41% `muted` en 45,99% beide attributen bevat.

## Gevolgtrekking

Het web is een geweldige plek om een visueel verhaal te vertellen. Tijdens ons onderzoek hebben we kunnen zien dat het web echt veel media-elementen gebruikt. Deze diversiteit komt ook tot uiting in het aantal manieren waarop media tegenwoordig op internet worden weergegeven. De meeste basisfuncties voor het weergeven van media worden actief gebruikt, maar met moderne browsers zouden we veel meer kunnen doen. Sommige van de geavanceerde mediafuncties die tegenwoordig worden gebruikt, zijn verbluffend, maar soms worden ze onjuist of in de verkeerde context gebruikt. We willen iedereen aanmoedigen om een niveau dieper te gaan: gebruik alle functies en mogelijkheden van het moderne web om gebruikers meer geweldige visuele ervaringen te bieden.
