---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Jamstack
description: Jamstack-hoofdstuk van de 2020 Web Almanac over het gebruik van Jamstack, de prestaties van populaire Jamstack-frameworks en een analyse van de echte gebruikerservaring met behulp van de Core Web Vitals-metadata.
hero_alt: Hero image of the Web Almanac chracters using a large gas cylinder with script markings on the front to inflate a web page.
authors: [ahmadawais]
reviewers: [MaedahBatool, phacks]
analysts: [denar90, remotesynth]
editors: [tunetheweb]
translators: [noah-vdv]
ahmadawais_bio: Ahmad Awais is een bekroonde open-source ingenieur, Google Developers Expert Dev Voorstander, Node.js Community Committee Outreach Leider, WordPress Core Dev en VP Engineering DevRel bij WGA. Hij heeft verschillende open-source softwaretools geschreven die door miljoenen ontwikkelaars over de hele wereld worden gebruikt. Zoals zijn <a hreflang="en" href="https://shadesofpurple.pro/more">Shades of Purple</a> codethema of projecten zoals de <a hreflang="en" href="https://github.com/AhmadAwais/corona-cli">corona-cli</a>. Awais houdt van lesgeven. Meer dan 20.000 ontwikkelaars leren van zijn <a hreflang="en" href="https://AhmadAwais.com/courses/">cursussen</a>, dwz <a hreflang="en" href="https://nodecli.com/">Node CLI</a>, <a hreflang="en" href="https://vscode.pro/">VSCode.pro</a>, en <a hreflang="en" href="https://nextjsbeginner.com/">Next.js Beginner</a>. Awais ontving de erkenning van FOSS-gemeenschapsleiderschap als een van de <a hreflang="en" href="https://ahmadawais.com/github-stars/">12 aanbevolen GitHub-sterren</a>. Hij is lid van het Smashing Magazine Experts Panel; aanbevolen &amp; gepubliceerde auteur bij CSS-Tricks, Tuts+, Scotch.io, SitePoint. U kunt hem meestal vinden op Twitter <a href="https://x.com/MrAhmadAwais/">@MrAhmadAwais</a> waar hij zijn <a hreflang="en" href="https://awais.dev/odmt">#OneDevMinute</a> ontwikkelaarstips deelt.
discuss: 2053
results: https://docs.google.com/spreadsheets/d/1BCC5Q4tePpTl8TiaGmSxBc9Lh2to7xBfVPMULFOBwvk/
featured_quote: Statistieken suggereren dat er nu meer dan twee keer zoveel Jamstack-sites zijn dan in 2019. Ontwikkelaars genieten van een betere ontwikkelervaring door de frontend van de backend te scheiden. Maar hoe zit het met de echte gebruikerservaring van het browsen op Jamstack-sites?
featured_stat_1: 147%
featured_stat_label_1: Toename van Jamstack-websites in 2020
featured_stat_2: 1 gram
featured_stat_label_2: CO2 uitgestoten voor mediane Jamstack bij het laden van de pagina
featured_stat_3: 58,59%
featured_stat_label_3: Jamstack-sites gebouwd met Next.js
---

## Inleiding

Jamstack is een relatief nieuw concept van een architectuur die is ontworpen om het web sneller, veiliger en gemakkelijker schaalbaar te maken. Het bouwt voort op veel van de tools en workflows waar ontwikkelaars van houden, en die de productiviteit maximaliseren.

De kernprincipes van Jamstack zijn het vooraf renderen van uw sitepagina's en het ontkoppelen van de frontend van de backend. Het is gebaseerd op het idee om de frontend-inhoud afzonderlijk te leveren op een CDN-provider die API's (bijvoorbeeld een headless CMS) gebruikt als eventuele backend.

Het <a hreflang="en" href="https://httparchive.org/">HTTP Archive</a> crawlt elke maand <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#numUrls">miljoenen pagina's</a> en voert ze door een privé instantie van <a hreflang="en" href="https://webpagetest.org/">WebPageTest</a> om belangrijke informatie over elke gecrawlde pagina op te slaan. U kunt hier meer over lezen op onze [methodologie](./methodology) pagina. In de context van Jamstack biedt HTTP Archive uitgebreide informatie over het gebruik van de frameworks en CDN's voor het hele web. In dit hoofdstuk worden veel van deze trends geconsolideerd en geanalyseerd.

De doelen van dit hoofdstuk zijn het schatten en analyseren van de groei van de Jamstack-sites, de prestaties van populaire Jamstack-frameworks, evenals een analyse van de echte gebruikerservaring met behulp van de Core Web Vitals-statistieken.

<p class="note">Opgemerkt moet worden dat onze analyse beperkt is tot die Jamstacks die zichzelf gemakkelijk identificeerbaar maken met behulp van <a href="./methodology#wappalyzer">Wappalyzer</a>. Dit betekent dat onze gegevens geen populaire Jamstacks bevatten, zoals <a hreflang="en" href="https://github.com/11ty/eleventy/">Eleventy</a> die <a href="https://x.com/eleven_ty/status/1334225624110608387?s=20">een bewuste keuze maken om zichzelf niet identificeerbaar te maken</a>. Hoewel we idealiter alle Jamstacks zouden opnemen, zijn we van mening dat het nog steeds waardevol is om de significante gegevens die we hebben te analyseren.</p>

## Adoptie van Jamstack

Onze analyse tijdens dit werk kijkt naar desktop- en mobiele websites. De overgrote meerderheid van de URL's die we hebben bekeken, bevindt zich in beide datasets, maar sommige URL's zijn alleen toegankelijk voor desktop- of mobiele apparaten. Hierdoor kunnen kleine verschillen in de data ontstaan en kijken we dus apart naar desktop- en mobiele resultaten.

{{ figure_markup(
  image="jamstack-adoption.png",
  caption="Acceptatietrend voor Jamstack.",
  description="Staafdiagram met de toename van het niveau van Jamstack-acceptatie in 2019 en 2020. Mobiel is gestegen van 0,50% naar 0,91%. Desktop is gestegen van 0,34% naar 0,84%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1650360073&format=interactive",
  sheets_gid="908645975",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

Ongeveer 0,9% van de webpagina's wordt mogelijk gemaakt door Jamstack en valt uiteen naar 0,91% op desktop, tegen 0,50% in 2019 en 0,84% op mobiel, tegen 0,34% in 2019.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Jaar</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>2019</td>
        <td class="numeric">0,50%</td>
        <td class="numeric">0,34%</td>
      </tr>
      <tr>
        <td>2020</td>
        <td class="numeric">0,91%</td>
        <td class="numeric">0,85%</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">% Verandering</td>
        <th scope="col" class="numeric">85%</td>
        <th scope="col" class="numeric">147%</td>
      </tr>
    </tfoot>
  </table>
  <figcaption>{{ figure_link(caption="Statistieken over de acceptatie van Jamstack.", sheets_gid="908645975", sql_file="ssg_compared_to_2019.sql") }}</figcaption>
</figure>

De toename van desktopwebpagina's die worden aangedreven door een Jamstack-framework is 85% ten opzichte van vorig jaar. Op mobiel is deze stijging bijna tweeënhalf keer zo groot, namelijk 147%. Dit is een forse groei ten opzichte van 2019, vooral voor mobiele pagina's. Wij geloven dat dit een teken is van de gestage groei van de Jamstack-community.

## Jamstack-frameworks

Onze analyse telde 14 afzonderlijke Jamstack-frameworks. Slechts zes frameworks hadden een aandeel van meer dan 1%: Next.js, Nuxt.js Gatsby, Hugo en Jekyll zijn de belangrijkste kanshebbers voor het Jamstack-marktaandeel.

In 2020 lijkt het grootste deel van het Jamstack-marktaandeel verdeeld over de top vijf frameworks. Interessant is dat Next.js een gebruiksaandeel heeft van 58,65%. Dit is meer dan drie keer het aandeel van het op een na populairste Jamstack-framework, Nuxt.js met 18,6%!

{{ figure_markup(
  image="jamstack-adoption-share-2020-pie.png",
  caption="Jamstack adoptie aandeel cirkeldiagram 2020.",
  description="Cirkeldiagram dat de acceptatie van Jamstack-frameworks laat zien, gedomineerd door Next.js, die bijna tweederde van het aandeel van 58,6% innam, en daarna de volgende meest populaire, Nuxt.js heeft 18,6% van het aandeel, gevolgd door Gatsby met 12,0%, Hugo bij 5,3%, Jekyll 3,4% en daarna kleinere wiggen zonder label.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=239192419&format=interactive",
  sheets_gid="1474840498",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

### Frameworkadoptie veranderingen

Als we naar de jaar-op-jaargroei kijken, zien we dat Next.js zijn voorsprong op zijn concurrenten het afgelopen jaar heeft vergroot:

<figure>
  <table>
    <thead>
      <tr>
        <th>Jamstack</th>
        <th>2019</th>
        <th>2020</th>
        <th>% Verandering</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Next.js</td>
        <td class="numeric">47,89%</td>
        <td class="numeric">58,59%</td>
        <td class="numeric">22%</td>
      </tr>
      <tr>
        <td>Nuxt.js</td>
        <td class="numeric">20,30%</td>
        <td class="numeric">18,59%</td>
        <td class="numeric">-8%</td>
      </tr>
      <tr>
        <td>Gatsby</td>
        <td class="numeric">12,45%</td>
        <td class="numeric">11,99%</td>
        <td class="numeric">-4%</td>
      </tr>
      <tr>
        <td>Hugo</td>
        <td class="numeric">9,50%</td>
        <td class="numeric">5,30%</td>
        <td class="numeric">-44%</td>
      </tr>
      <tr>
        <td>Jekyll</td>
        <td class="numeric">6,22%</td>
        <td class="numeric">3,43%</td>
        <td class="numeric">-45%</td>
      </tr>
      <tr>
        <td>Hexo</td>
        <td class="numeric">1,16%</td>
        <td class="numeric">0,64%</td>
        <td class="numeric">-45%</td>
      </tr>
      <tr>
        <td>Docusaurus</td>
        <td class="numeric">1,26%</td>
        <td class="numeric">0,60%</td>
        <td class="numeric">-52%</td>
      </tr>
      <tr>
        <td>Gridsome</td>
        <td class="numeric">0,19%</td>
        <td class="numeric">0,46%</td>
        <td class="numeric">140%</td>
      </tr>
      <tr>
        <td>Octopress</td>
        <td class="numeric">0,61%</td>
        <td class="numeric">0,20%</td>
        <td class="numeric">-68%</td>
      </tr>
      <tr>
        <td>Pelican</td>
        <td class="numeric">0,31%</td>
        <td class="numeric">0,11%</td>
        <td class="numeric">-64%</td>
      </tr>
      <tr>
        <td>VuePress</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0,05%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>Phenomic</td>
        <td class="numeric">0,10%</td>
        <td class="numeric">0,02%</td>
        <td class="numeric">-77%</td>
      </tr>
      <tr>
        <td>Saber</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">0,01%</td>
        <td class="numeric">&nbsp;</td>
      </tr>
      <tr>
        <td>Cecil</td>
        <td class="numeric">0,01%</td>
        <td class="numeric">&nbsp;</td>
        <td class="numeric">-100%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Relatief % adoptie van Jamstack-frameworks", sheets_gid="1474840498", sql_file="ssg_compared_to_2019.sql") }}</figcaption>
</figure>

En door zich te concentreren op de top 5 Jamstacks, wordt de voorsprong van Next.js verder getoond:

{{ figure_markup(
  image="jamstack-adoption-share-yoy.png",
  caption="Jaar na jaar adoptie-aandeel van Jamstack.",
  description="Het adoptieaandeel van de top vijf Jamstack-frameworks en hun wijziging van 2019 naar 2020. Next.js is gestegen van 47,89% naar 58,59%. De rest is veel kleiner, geleid door Nuxt.JS dat is gekrompen van 20,30% naar 18,59%, Gatsby dat licht is gekrompen van 12,45% naar 11,99%, gevolgd door Hugo die bijna is gehalveerd van 9,50% naar 5,30%, en tenslotte Jekyll die is gekrompen van 6,22% naar 3,43%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=750685917&format=interactive",
  sheets_gid="1474840498",
  sql_file="ssg_compared_to_2019.sql"
  )
}}

Het is vermeldenswaard dat de websites Next.js en Nuxt.js een mix bevatten van zowel Static Site Generated (SSG) -pagina's als Server-Side Rendered (SSR) -pagina's. Dit komt doordat we ze niet afzonderlijk kunnen meten. Dit betekent dat de analyse sites kan omvatten die grotendeels of gedeeltelijk door de server worden weergegeven, wat betekent dat ze niet onder de traditionele definitie van een Jamstack-site vallen. Desalniettemin lijkt het erop dat deze hybride aard van Next.js het een concurrentievoordeel geeft ten opzichte van andere frameworks, waardoor het populairder wordt.

## Milieu-impact

Dit jaar hebben we geprobeerd de impact van Jamstack-sites op het milieu beter te begrijpen. <a hreflang="en" href="https://www.nature.com/articles/d41586-018-06610-y">De informatie- en communicatietechnologie (ICT) -industrie is verantwoordelijk voor 2% van de wereldwijde koolstofemissies</a>, en datacentra zijn specifiek verantwoordelijk voor 0,3% van wereldwijde koolstofemissies. Hiermee komt de CO2-voetafdruk van de ICT-industrie overeen met de uitstoot van brandstof door de luchtvaart.

Jamstack wordt vaak gecrediteerd voor zijn aandacht voor prestaties. In de volgende sectie kijken we naar de CO2-uitstoot van Jamstack-websites.

### Paginagewicht

In ons onderzoek is gekeken naar het gemiddelde paginagewicht van Jamstack in KB en dit in kaart gebracht op de CO2-uitstoot met behulp van logica van de <a hreflang="en" href="https://gitlab.com/wholegrain/carbon-api-2-0/-/blob/master/includes/carbonapi.php#L342">Carbon API</a>. Dit leverde de volgende resultaten op, uitgesplitst naar desktop en mobiel:

{{ figure_markup(
  image="jamstack-carbon-emissions-per-jamstack-page-view.png",
  caption="Koolstofemissies per Jamstack-paginaweergave.",
  description="Staafdiagram met de grammen CO2-uitstoot voor Jamstack-pagina's per percentiel. Bij het 10e percentiel is dit 0,3 gram voor desktopcomputers en 0,4 voor mobiel, bij het 25e percentiel is het 0,6 gram voor beide, bij de 50% is dit 1,2 gram voor desktop en 1,0 gram voor mobiel, bij het 75e percentiel 2,3 gram voor desktop en 1.9 voor mobiel, en in het 90e percentiel is het 4,4 gram voor desktop en 3,6 voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1748236124&format=interactive",
  sheets_gid="881269360",
  sql_file="distribution_of_page_weight_requests_and_co2_grams_per_ssg_web_page.sql"
  )
}}

We ontdekten dat de mediane belasting van Jamstack-pagina's resulteerde in de overdracht van 1,82 MB aan verschillende activa op desktop en 1,54 MB op mobiel, en dus in de uitstoot van respectievelijk 1,2 gram en 1,0 gram CO2. Het meest efficiënte percentiel van Jamstack-webpagina's resulteert in het genereren van ten minste een derde minder CO2 dan de mediaan, terwijl het minst efficiënte percentiel van Jamstack-webpagina's de andere kant op gaat, ongeveer vier keer meer.

[Paginagewichten](./page-weight) zijn hier belangrijk. De gemiddelde Jamstack-webpagina op de desktop laadt 1,5 MB aan video-, afbeelding-, script-, lettertype-, CSS- en audiogegevens. 10% van de pagina's laadt echter meer dan 4 MB van deze gegevens. Op mobiele apparaten laadt de gemiddelde webpagina 0,28 MB minder dan op een desktop, een feit dat consistent is voor alle percentielen.

### Afbeeldingsformaten

Populaire afbeeldingsindelingen zijn PNG, JPG, GIF, SVG, WebP en ICO. Hiervan is <a hreflang="en" href="https://developers.google.com/speed/webp/">WebP het meest efficiënt in de meeste situaties</a>, met WebP lossless afbeeldingen <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_lossless_alpha_study#results">26% kleiner</a> dan vergelijkbare PNG's en <a hreflang="en" href="https://developers.google.com/speed/webp/docs/webp_study">25-34% kleiner</a> dan vergelijkbare JPG's. We zien echter dat WebP het op één na minst populaire afbeeldingsformaat is op alle Jamstack-pagina's, waar PNG het populairst is voor zowel mobiel als desktop. Alleen iets minder populair is JPG, terwijl GIF bijna 20% uitmaakt van alle afbeeldingen die op Jamstack-sites worden gebruikt. Een interessante ontdekking is SVG, dat op mobiele sites bijna twee keer zo populair is als op desktopsites.

{{ figure_markup(
  image="jamstack-popularity-of-image-formats.png",
  caption="Populariteit van afbeeldingsformaten.",
  description="Staafdiagram met het percentage afbeeldingen per type op Jamstack. PNG is 33% op desktop en 28% op mobiel, JPG is 30% op desktop en 26% op mobiel, GIF is 18% op desktop en 19% op mobiel, SVG is 14% op desktop en 22% op mobiel, WebP is 4% op desktop en 3% op mobiel, terwijl ICO 2% is op zowel desktop als mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1593285227&format=interactive",
  sheets_gid="1626843605",
  sql_file="adoption_of_image_formats_in_ssgs.sql"
  )
}}

### Bytes van derden

Jamstack-sites laden, net als de meeste websites, vaak bronnen van [derden](./third-party), zoals externe afbeeldingen, video's, scripts of stylesheets:

{{ figure_markup(
  image="jamstack-third-party-bytes.png",
  caption="Bytes van derden.",
  description="Staafdiagram met het aantal bytes van derden (in KB) voor elk percentiel voor Jamstack-pagina's. Op het 10e percentiel is dit 45 KB voor desktop en 60 KB voor mobiel, bij het 25e percentiel is het 149 KB voor mobiel en 212 KB voor mobiel, bij de 50% is het 470 KB voor desktop en 642 KB voor mobiel, op het 75e percentiel 1.219 KB voor desktop en 1.788 voor mobiel en bij het 90e percentiel is dit 2.878 KB voor desktop en 3.044 KB voor mobiel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1779247936&format=interactive",
  sheets_gid="1292933800",
  sql_file="third_party_bytes_and_requests_on_ssgs.sql"
  )
}}

We zien dat de gemiddelde Jamstack-pagina op de desktop 26 verzoeken van derden heeft met 470 KB inhoud, terwijl het mobiele equivalent 38 verzoeken genereert met 642 KB inhoud. Terwijl 10% van de desktopsites 114 verzoeken heeft met 2,88 MB aan inhoud, die alleen wordt vervangen door 148 verzoeken op mobiele apparaten met 3MB aan inhoud.

## Gebruikerservaring

Van Jamstack-websites wordt vaak gezegd dat ze een goede gebruikerservaring bieden. Het is waar het hele concept van het scheiden van de frontend van de backend en het hosten op de CDN-edge over gaat. We streven ernaar om licht te werpen op de echte gebruikerservaring bij het gebruik van Jamstack-websites met behulp van de onlangs gelanceerde <a hreflang="en" href="https://web.dev/learn-web-vitals/">Core Web Vitals</a>.

De Core Web Vitals zijn drie belangrijke factoren die licht kunnen werpen op ons begrip van hoe gebruikers Jamstack-pagina's in het wild ervaren:

- Largest Contentful Paint (LCP)
- First Input Delay (FID)
- Cumulative Layout Shift (CLS)

Deze statistieken zijn bedoeld om de kernelementen te dekken die indicatief zijn voor een geweldige webgebruikerservaring. Laten we eens kijken naar de real-world Core Web Vitals-statistieken van de top vijf Jamstack-frameworks.

### Largest Contentful Paint

Largest Contentful Paint (LCP) meet het punt waarop de belangrijkste inhoud van de pagina waarschijnlijk is geladen en dus is de pagina nuttig voor de gebruiker. Het doet dit door de rendertijd te meten van het grootste beeld of tekstblok dat zichtbaar is in de viewport.

Dit verschilt van First Contentful Paint (FCP), dat meet vanaf het laden van de pagina totdat inhoud zoals tekst of een afbeelding voor het eerst wordt weergegeven. LCP wordt beschouwd als een goede proxy om te meten wanneer de hoofdinhoud van een pagina wordt geladen.

{{ figure_markup(
  image="jamstack-real-user-largest-contentful-paint-experiences.png",
  caption="Real-user Largest Contentful Paint-ervaringen.",
  description='Staafdiagram met de top vijf van Jamstack-frameworks en of ze een "goede" Largest Contentful Paint-ervaring hebben. Gatsby heeft 52% op desktop maar slechts 36% op mobiel, Next.js is het laagste met 38% op desktop en 23% op mobiel, Nuxt.js is het laagst met 31% op desktop en 18% op mobiel, Hugo is de tweede beste met 85% op desktop en 69% op mobiel, en Jekyll is de beste met 91% op desktop en 74% op mobiel.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=125934259&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

Een "goed" LCP wordt beschouwd als minder dan 2,5 seconden. Jekyll en Hugo hebben indrukwekkende LCP-scores die allemaal boven de 50% liggen, met Jekyll en Hugo op desktop respectievelijk 91% en 85% op desktop. Gatsby-, Next.js- en Nuxt.js-sites bleven achter - respectievelijk 52%, 38% en 31% op desktop en 36%, 23% en 18% op mobiel.

Dit kan worden toegeschreven aan het feit dat de meeste sites die zijn gebouwd met Gatsby, Next.js en Nuxt.js een complexe lay-out en een hoog paginagewicht hebben, in vergelijking met Hugo en Jekyll die voornamelijk worden gebruikt om sites met statische inhoud te produceren met minder of geen dynamische onderdelen. Voor wat het waard is, hoeft u React, VueJS of enig ander JavaScript-framework niet te gebruiken met Hugo of Jekyll.

Zoals we in het bovenstaande gedeelte hebben onderzocht, kunnen hoge paginagewichten een mogelijke impact hebben op het milieu. Dit heeft echter ook invloed op de LCP-prestaties, die ofwel erg goed ofwel over het algemeen slecht zijn, afhankelijk van het Jamstack-framework. Dit kan ook een impact hebben op de echte gebruikerservaring.

### First Input Delay

First Input Delay (FID) meet de tijd vanaf het moment waarop een gebruiker voor het eerst interactie heeft met uw site (dwz wanneer ze op een link klikken, op een knop tikken of een aangepast, JavaScript-aangedreven besturingselement gebruiken) tot het moment waarop de browser daadwerkelijk in staat is om op die interactie te reageren.

Een "snelle" FID vanuit het perspectief van een gebruiker zou onmiddellijke feedback geven van hun acties op een site in plaats van een vastgelopen ervaring. Deze vertraging is een pijnpunt en kan correleren met interferentie door andere aspecten van het laden van de site wanneer de gebruiker probeert te communiceren met de site.

FID is extreem snel voor de gemiddelde Jamstack-website op desktop - de meeste populaire frameworks scoren 100% - en boven de 80% op mobiel.

{{ figure_markup(
  image="jamstack-real-user-first-input-delay-experiences.png",
  caption="Ervaringen voor First Input Delay door echte gebruikers.",
  description='Staafdiagram met de top vijf van Jamstack en of ze een "goede" First Input Delay-ervaring hebben. Ze hebben allemaal een ervaringsscore van 100% op desktop. Voor mobiele Gatsby 89% heeft Next.js 87%, Nuxt.js 86%, Hugo 84% en Jekyll 82%.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=736622498&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

Er is een kleine verschilmarge tussen de bronnen die naar desktopversies en mobiele versies van een website worden verzonden. De FID-scores zijn hier over het algemeen erg goed, maar het is interessant dat dit zich niet vertaalt naar vergelijkbare LCP-scores. Zoals gesuggereerd, zou het gewicht van individuele pagina's op Jamstack-sites naast de kwaliteit van de mobiele verbinding een rol kunnen spelen in de prestatieverschillen die we hier zien.

### Cumulative Layout Shift

Cumulative Layout Shift (CLS) meet de instabiliteit van inhoud op een webpagina binnen de eerste 500 ms van gebruikersinvoer. CLS meet alle lay-outwijzigingen die optreden na invoer van de gebruiker. Dit is met name belangrijk op mobiele apparaten, waar de gebruiker zal tikken waar hij een actie wil ondernemen, zoals een zoekbalk, alleen om de locatie te verplaatsen als aanvullende afbeeldingen, advertenties of soortgelijke ladingen.

Een score van 0,1 of lager is goed, meer dan 0,25 is slecht en alles daartussenin moet worden verbeterd.

{{ figure_markup(
  image="jamstack-real-user-cumulative-layout-shift-experiences.png",
  caption="Cumulative Layout Shift-ervaringen voor echte gebruikers.",
  description='Staafdiagram met de top-vijf Jamstack en of ze een "goede" ervaring hebben met Cumulative Layout Shift. Gatsby heeft een "goede ervaring" met 66% voor zowel desktop- als mobiele sites, Next.js is 48% desktop en 49% op mobiele sites, Nuxt.js is 45% desktop en 46% op mobiele sites, Hugo heeft 74% voor desktop en 78% op mobiele sites, en Jekyll 82% op zowel desktop- als mobiele sites.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ-zBygubF5NuAXOGScVLhnozB_6Pi_0z4B57cP_I6AfeBuZCGzs3aP_1nPjPp37aNRATRYC6EfOeYX/pubchart?oid=1984155453&format=interactive",
  sheets_gid="793304891",
  sql_file="core_web_vitals_distribution.sql"
  )
}}

De top-vijf Jamstack-frameworks doen het hier goed. Ongeveer 65% van de webpagina's die worden geladen door de vijf beste Jamstack-frameworks hebben een "goede" CLS-ervaring, en dit cijfer stijgt tot 82% op mobiele apparaten. Over het geheel genomen is de gemiddelde score voor desktop en mobiel 65%. Next.js en Nuxt.js zijn beide onder de 50% en hebben hier werk te doen. Ontwikkelaars opleiden en documenteren hoe ze slechte CLS-scores kunnen voorkomen, kan een lange weg gaan.

## Gevolgtrekking

Jamstack, zowel als concept en als stapel, heeft het afgelopen jaar aan belang gewonnen. Statistieken suggereren dat er nu bijna twee keer zoveel Jamstack-sites zijn dan in 2019. Ontwikkelaars genieten van een betere ontwikkelervaring door de frontend te scheiden van de backend (een headless CMS, serverloze functies of services van derden). Maar hoe zit het met de echte gebruikerservaring van het bladeren door Jamstack-sites?

We hebben de acceptatie van Jamstack, de gebruikerservaring van websites die met deze Jamstack-frameworks zijn gemaakt, bekeken en voor het eerst gekeken naar de impact van Jamstack op het milieu. We hebben hier veel vragen beantwoord, maar laten verdere vragen onbeantwoord.

Er zijn frameworks zoals Eleventy die we niet konden meten of analyseren, aangezien er geen patroon beschikbaar is om het gebruik van dergelijke frameworks te bepalen, wat een impact heeft op de hier gepresenteerde gegevens. Next.js domineert het gebruik en biedt zowel statische sitegeneratie als server-side rendering, het scheiden van de twee in deze gegevens is bijna onmogelijk omdat het ook incrementele statische generatie biedt. Verder onderzoek dat voortbouwt op dit hoofdstuk zal dankbaar worden ontvangen.

Bovendien hebben we enkele gebieden belicht die aandacht behoeven van de Jamstack-gemeenschap. We hopen dat er vooruitgang zal worden geboekt in het rapport voor 2021. Verschillende Jamstack-frameworks kunnen beginnen met het documenteren hoe de echte gebruikerservaring kan worden verbeterd door naar Core Web Vitals te kijken.

Vercel, een van de CDN's die bedoeld zijn om Jamstack-sites te hosten, heeft een analyse-aanbod gebouwd met de naam <a hreflang="en" href="https://vercel.com/docs/analytics#real-experience-score">Real User Experience Score</a>. Terwijl andere tools voor het meten van prestaties zoals <a hreflang="en" href="https://web.dev/measure/">Lighthouse</a> de gebruikerservaring schatten door een simulatie in een laboratorium uit te voeren, wordt de Real Experience Score van Vercel berekend met behulp van echte gegevenspunten die zijn verzameld van de apparaten van de daadwerkelijke gebruikers van uw applicatie.

Het is waarschijnlijk vermeldenswaard dat Vercel Next.js heeft gemaakt en onderhoudt, aangezien Next.js lage LCP-scores had. Dit nieuwe aanbod zou kunnen betekenen dat we kunnen hopen op een duidelijke verbetering van die scores volgend jaar. Dit zou zeer nuttige informatie zijn voor zowel gebruikers als ontwikkelaars.

Jamstack-frameworks verbeteren de ontwikkelaarservaring van het bouwen van sites. Laten we werken aan voortdurende vooruitgang om de echte gebruikerservaring van het browsen op Jamstack-sites te verbeteren.
