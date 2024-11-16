---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Toegankelijkheid
description: Toegankelijkheidshoofdstuk van de Web Almanac 2019 over leesgemak, media, navigatiegemak en compatibiliteit met ondersteunende technologieën.
hero_alt: Hero image of a robot with a blue, human accessibility icon on its front scanning a web page, while Web Almanac characters check some labels.
authors: [nektarios-paisios, foxdavidj, kleinab]
reviewers: [ljme]
analysts: [dougsillars, rviscomi, foxdavidj]
editors: [foxdavidj]
translators: [noah-vdv]
discuss: 1764
results: https://docs.google.com/spreadsheets/d/16JGy-ehf4taU0w4ABiKjsHGEXNDXxOlb__idY8ifUtQ/
nektarios-paisios_bio: Nektarios Paisios is een software-engineer die de afgelopen 5 jaar aan de toegankelijkheid van Chrome heeft gewerkt. Hij richt zich voornamelijk op het compatibel maken van Chrome met ondersteunende software van derden, zoals schermlezers en schermvergroters. Voordat Nektarios aan de toegankelijkheid van Chrome werkte, werkte hij in verschillende andere rollen bij het bedrijf, zoals toegankelijkheid voor GSuite en display-advertenties. Nektarios heeft een Ph.D. in Computer Science van de New York University.
foxdavidj_bio: David Fox is de hoofdonderzoeker naar bruikbaarheid en oprichter van LookZook, een bedrijf dat geobsedeerd is door alles te weten te komen over het bouwen van webervaringen die voldoen aan de verwachtingen van gebruikers. Hij is een website-psycholoog die zich verdiept in sites om niet alleen te leren waarmee gebruikers worstelen, maar ook waarom en hoe ze hun ervaring het beste kunnen verbeteren. Hij is ook een Google Chromium-bijdrager, spreker en aanbieder van webinars en UX-trainingen.
kleinab_bio: Abigail Klein is een Google-software-engineer. Ze werkte aan de webtoegankelijkheid van Google Documenten, Spreadsheets en Presentaties, waar ze <a hreflang="en" href="https://www.blog.google/outreach-initiatives/accessibility/whats-you-say-present-captions-google-slides/">automatische ondertiteling voor Google Presentaties toevoegde</a>, evenals verbeterde ondersteuning voor schermlezer, braille, schermvergroting en hoog contrast. Ze werkt momenteel aan de toegankelijkheid van Google Chrome en ChromeOS. Ze heeft een bachelor en master in informatica van MIT, waar ze medeoprichter was van een ondersteunende technologie hackathon en labassistent en gastdocent was van de les ondersteunende technologie.
featured_quote: Toegankelijkheid op internet is essentieel voor een inclusieve en rechtvaardige samenleving. Naarmate meer van ons sociale en werkleven naar de online wereld verhuizen, wordt het voor mensen met een handicap nog belangrijker om zonder belemmeringen aan alle online interacties te kunnen deelnemen. Net zoals gebouwarchitecten toegankelijkheidsfuncties kunnen creëren of weglaten, zoals rolstoelhellingen, kunnen webontwikkelaars de ondersteunende technologie waar gebruikers op vertrouwen helpen of hinderen.
featured_stat_1: 22%
featured_stat_label_1: Sites met voldoende kleurcontrast
featured_stat_2: 50%
featured_stat_label_2: Sites met ontbrekende alt-attributen voor afbeeldingen
featured_stat_3: 14%
featured_stat_label_3: Sites die vermijdingslinks gebruiken
---

## Inleiding

Toegankelijkheid op internet is essentieel voor een inclusieve en rechtvaardige samenleving. Naarmate meer van ons sociale en werkleven naar de online wereld verhuizen, wordt het voor mensen met een handicap nog belangrijker om zonder belemmeringen aan alle online interacties te kunnen deelnemen. Net zoals gebouwarchitecten toegankelijkheidsfuncties kunnen creëren of weglaten, zoals rolstoelhellingen, kunnen webontwikkelaars de ondersteunende technologie waar gebruikers op vertrouwen helpen of hinderen.

Als we aan gebruikers met een handicap denken, moeten we niet vergeten dat hun gebruikersreizen vaak hetzelfde zijn - ze gebruiken alleen verschillende hulpmiddelen. Deze populaire hulpmiddelen omvatten, maar zijn niet beperkt tot: schermlezers, schermvergroters, zoomen in de browser of tekstgrootte en spraakbediening.

Vaak heeft het verbeteren van de toegankelijkheid van uw site voordelen voor iedereen. Hoewel we mensen met een handicap doorgaans zien als mensen met een blijvende handicap, kan iedereen een tijdelijke of situationele handicap hebben. Iemand kan bijvoorbeeld permanent blind zijn, een tijdelijke ooginfectie hebben of, in bepaalde situaties, buiten onder een felle zon staan. Dit kan allemaal verklaren waarom iemand zijn scherm niet kan zien. Iedereen heeft situationele handicaps, en dus het verbeteren van de toegankelijkheid van uw webpagina zal de ervaring van alle gebruikers in elke situatie verbeteren.

De <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/quickref/">Richtlijnen voor Toegankelijkheid van Webinhoud</a> (WCAG) adviseren hoe u een website toegankelijk kunt maken. Deze richtlijnen zijn gebruikt als basis voor onze analyse. In veel gevallen is het echter moeilijk om de toegankelijkheid van een website programmatisch te analyseren. Het webplatform biedt bijvoorbeeld verschillende manieren om vergelijkbare functionele resultaten te bereiken, maar de onderliggende code die ze aandrijft, kan compleet anders zijn. Daarom is onze analyse slechts een benadering van de algehele webtoegankelijkheid.

We hebben onze meest interessante inzichten opgedeeld in vier categorieën: leesgemak, media op internet, gemakkelijke paginanavigatie en compatibiliteit met ondersteunende technologieën.

Tijdens het testen werd geen significant verschil in toegankelijkheid gevonden tussen desktop en mobiel. Als gevolg hiervan zijn al onze gepresenteerde statistieken het resultaat van onze desktopanalyse, tenzij anders vermeld.

## Gemak van het lezen

Het primaire doel van een webpagina is om inhoud te leveren waarmee gebruikers willen communiceren. Deze inhoud kan een video of een assortiment afbeeldingen zijn, maar vaak is het gewoon de tekst op de pagina. Het is buitengewoon belangrijk dat onze tekstuele inhoud leesbaar is voor onze lezers. Als bezoekers een webpagina niet kunnen lezen, kunnen ze er niet mee omgaan, waardoor ze uiteindelijk vertrekken. In dit gedeelte zullen we drie gebieden bekijken waarop sites worstelden.

### Kleurcontrast

Er zijn veel gevallen waarin bezoekers van uw site deze mogelijk niet perfect kunnen zien. Bezoekers zijn mogelijk kleurenblind en kunnen geen onderscheid maken tussen het lettertype en de achtergrondkleur ([1 op de 12 mannen en 1 op de 200 vrouwen](http://www.cvrl.org/people/stockman/pubs/1999%20Genetics%20chapter%20SSJN.pdf) van Europese afkomst). Misschien lezen ze gewoon terwijl de zon schijnt en zorgen ze voor veel schittering op hun scherm, waardoor hun zicht aanzienlijk wordt aangetast. Of misschien zijn ze net ouder geworden en kunnen hun ogen kleuren niet zo goed onderscheiden als vroeger.

Om ervoor te zorgen dat uw website onder deze omstandigheden leesbaar is, is het van cruciaal belang dat uw tekst voldoende kleurcontrast heeft met de achtergrond. Het is ook belangrijk om te bedenken welke contrasten worden weergegeven wanneer de kleuren worden omgezet in grijstinten.

{{ figure_markup(
  image="example-of-good-and-bad-color-contrast-lookzook.svg",
  caption="Voorbeeld van hoe tekst met onvoldoende kleurcontrast eruitziet. Met dank aan LookZook",
  description="Vier gekleurde vakken met bruine en grijze tinten met witte tekst erin over elkaar, waardoor twee kolommen ontstaan. De linkerkolom zegt te licht gekleurd en heeft de bruine achtergrondkleur geschreven als <code>#FCA469</code>. In de rechterkolom staat Aanbevolen en de bruine achtergrondkleur wordt geschreven als <code>#BD5B0E</code>. Het bovenste vak in elke kolom heeft een bruine achtergrond met witte tekst <code>#FFFFFF</code> en het onderste vak heeft een grijze achtergrond met witte tekst <code>#FFFFFF</code>. De grijswaardenequivalenten zijn respectievelijk <code>#B8B8B8</code> en <code>#707070</code>. Met dank aan LookZook",
  width=568,
  height=300
  )
}}

Slechts 22,04% van de sites gaf al hun tekst voldoende kleurcontrast. Of met andere woorden: 4 op de 5 sites hebben tekst die gemakkelijk op de achtergrond overgaat, waardoor deze onleesbaar wordt.

<p class="note">Merk op dat we geen enkele tekst in afbeeldingen konden analyseren, dus onze gerapporteerde statistiek is een bovengrens van het totale aantal websites dat de kleurcontrasttest heeft doorstaan.</p>

### Pagina's zoomen en schalen

Het gebruik van een <a hreflang="en" href="https://accessibleweb.com/question-answer/minimum-font-size/">leesbare lettergrootte</a> en <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/quickref/#target-size">doelgrootte</a> helpt gebruikers uw website te lezen en ermee te communiceren. Maar zelfs websites die al deze richtlijnen perfect volgen, kunnen niet voldoen aan de specifieke behoeften van elke bezoeker. Dit is de reden waarom apparaatfuncties zoals knijpen om te zoomen en schalen zo belangrijk zijn: ze stellen gebruikers in staat uw pagina's aan te passen zodat aan hun behoeften wordt voldaan. Of in het geval van bijzonder ontoegankelijke sites die kleine lettertypen en knoppen gebruiken, geeft het gebruikers de kans om de site zelfs te gebruiken.

Er zijn zeldzame gevallen waarin het uitschakelen van schalen acceptabel is, zoals wanneer de betreffende pagina een webgebaseerd spel is met aanraakbediening. Indien ingeschakeld in dit geval, zullen de telefoons van spelers elke keer dat de speler tweemaal op het spel tikt in- en uitzoomen, waardoor het ironisch genoeg ontoegankelijk wordt.

Daarom krijgen ontwikkelaars de mogelijkheid om deze functie uit te schakelen door een van de volgende twee eigenschappen in de [meta viewport-tag](https://developer.mozilla.org/docs/Web/HTML/Viewport_meta_tag) in te stellen:

1. `user-scalable` ingesteld op `0` of `no`

2. `maximum-scale` ingesteld op `1`, `1.0`, enz.

Helaas hebben ontwikkelaars dit zo vaak misbruikt dat bijna één op de drie sites op mobiele apparaten (32,21%) deze functie uitschakelt, en Apple (vanaf iOS 10) webontwikkelaars niet langer toestaat zoomen uit te schakelen. Mobile Safari <a hreflang="en" href="https://archive.org/details/ios-10-beta-release-notes">negeert gewoon de tag</a>. Alle sites, wat er ook gebeurt, kunnen worden ingezoomd en geschaald op nieuwere iOS-apparaten.

{{ figure_markup(
  image="fig2.png",
  caption="Percentage sites dat zoomen en schalen uitschakelt versus apparaattype.",
  description="Verticale meetpercentagegegevens, variërend van 0 tot 80 in stappen van 20, versus het apparaattype, gegroepeerd in desktop en mobiel. Desktop ingeschakeld: 75,46%; Desktop uitgeschakeld 24,54%; Mobiel ingeschakeld: 67,79%; Mobiel uitgeschakeld: 32,21%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=2053904956&format=interactive"
  )
}}

### Taalidentificatie

Het web staat vol met wonderbaarlijke hoeveelheden inhoud. Er is echter een addertje onder het gras: er bestaan meer dan 1000 verschillende talen in de wereld en de inhoud die u zoekt, is mogelijk niet geschreven in een taal die u vloeiend beheerst. In de afgelopen jaren hebben we grote vooruitgang geboekt op het gebied van vertaaltechnologieën en u heeft er waarschijnlijk een op internet gebruikt (bijv. Google translate).

Om deze functie te vergemakkelijken, moeten de vertaalmachines weten in welke taal uw pagina's zijn geschreven. Dit wordt gedaan met behulp van het [`lang` attribuut](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/lang). Zonder dit moeten computers raden in welke taal uw pagina is geschreven. Zoals u zich wellicht kunt voorstellen, leidt dit tot veel fouten, vooral wanneer pagina's meerdere talen gebruiken (uw paginanavigatie is bijvoorbeeld in het Engels, maar de inhoud van het bericht is in het Japans).

Dit probleem is zelfs nog meer uitgesproken bij tekst-naar-spraak-ondersteunende technologieën zoals schermlezers, waar, als er geen taal is gespecificeerd, ze de neiging hebben om de tekst in de standaard gebruikerstaal te lezen.

Van de geanalyseerde pagina's specificeert 26,13% geen taal met het kenmerk `lang`. Hierdoor blijft meer dan een kwart van de pagina's vatbaar voor alle hierboven beschreven problemen. Het goede nieuws? Van de sites die het `lang`-attribuut gebruiken, specificeren ze 99,68% van de tijd een geldige taalcode correct.

### Afleidende inhoud

Sommige gebruikers, zoals mensen met cognitieve beperkingen, hebben moeite om zich gedurende lange tijd op dezelfde taak te concentreren. Deze gebruikers willen niet omgaan met pagina's met veel beweging en animaties, vooral als deze effecten puur cosmetisch zijn en geen verband houden met de taak die voorhanden is. Deze gebruikers hebben minimaal een manier nodig om alle afleidende animaties uit te schakelen.

Helaas geven onze bevindingen aan dat oneindig herhalende animaties vrij gebruikelijk zijn op internet, waarbij 21,04% van de pagina's ze gebruikt via oneindige CSS-animaties of [`<marquee>`](https://developer.mozilla.org/docs/Web/HTML/Element/marquee) en [`<blink>`](https://developer.mozilla.org/docs/Web/HTML/Element/blink) elementen.

Het is echter interessant om op te merken dat het grootste deel van dit probleem een paar populaire stylesheets van derden lijkt te zijn die standaard oneindig doorlopende CSS-animaties bevatten. We konden niet bepalen hoeveel pagina's deze animatiestijlen daadwerkelijk hebben gebruikt.

## Media op internet

### Alternatieve tekst op afbeeldingen

Afbeeldingen zijn een essentieel onderdeel van de webervaring. Ze kunnen krachtige verhalen vertellen, aandacht trekken en emoties opwekken. Maar niet iedereen kan deze afbeeldingen zien waarop we vertrouwen om delen van onze verhalen te vertellen. Gelukkig bood HTML 2.0 in 1995 een oplossing voor dit probleem: <a hreflang="en" href="https://webaim.org/techniques/alttext/">het `alt`-attribuut</a>. Het `alt`-attribuut biedt webontwikkelaars de mogelijkheid om een tekstuele beschrijving toe te voegen aan de afbeeldingen die we gebruiken, zodat wanneer iemand onze afbeeldingen niet kan zien (of de afbeeldingen niet kunnen laden) ze de `alt`-tekst kunnen lezen voor een beschrijving. De `alt`-tekst vult ze in van het deel van het verhaal dat ze anders zouden hebben gemist.

Hoewel alt-attributen al 25 jaar bestaan, levert 49,91% van de pagina's nog steeds geen alt-attributen voor sommige van hun afbeeldingen en 8,68% van de pagina's gebruikt ze helemaal nooit.

### Bijschriften voor audio en video

Net zoals afbeeldingen krachtige verhalenvertellers zijn, zo zijn ook audio en video die de aandacht trekken en ideeën tot uitdrukking brengen. Als audio- en video-inhoud niet is voorzien van ondertiteling, lopen gebruikers die deze inhoud niet kunnen horen grote delen van het internet mis. Een van de meest voorkomende dingen die we horen van gebruikers die doof of slechthorend zijn, is de noodzaak om bijschriften op te nemen voor alle audio- en video-inhoud.

Van sites die [`<audio>`](https://developer.mozilla.org/docs/Web/HTML/Element/audio) of [`<video>`](https://developer.mozilla.org/docs/Web/HTML/Element/video) -elementen gebruiken, levert slechts 0,54% ondertiteling (zoals gemeten door degenen die het [`<track>`](https://developer.mozilla.org/docs/Web/Guide/Audio_and_video_delivery/Adding_captions_and_subtitles_to_HTML5_video) element bevatten). Merk op dat sommige websites aangepaste oplossingen hebben voor het leveren van video- en audiobijschriften aan gebruikers. We hebben deze niet kunnen detecteren en daarom is het werkelijke percentage sites dat ondertiteling gebruikt iets hoger.

## Eenvoudige paginanavigatie

Wanneer u het menu in een restaurant opent, is het eerste dat u waarschijnlijk doet, alle sectiekoppen lezen: voorgerechten, salades, hoofdgerecht en dessert. Hiermee kunt u een menu scannen op alle opties en snel naar de gerechten springen die voor u het meest interessant zijn. Evenzo, wanneer een bezoeker een webpagina opent, is het hun doel om de informatie te vinden waarin ze het meest geïnteresseerd zijn - de reden waarom ze überhaupt naar de pagina zijn gekomen. Om gebruikers te helpen hun gewenste inhoud zo snel mogelijk te vinden (en te voorkomen dat ze op de terugknop drukken), proberen we de inhoud van onze pagina's te scheiden in verschillende visueel verschillende secties, bijvoorbeeld: een sitekop voor navigatie, verschillende koppen in onze artikelen zodat gebruikers deze snel kunnen scannen, een voettekst voor andere externe bronnen en meer.

Hoewel dit uitzonderlijk belangrijk is, moeten we ervoor zorgen dat onze pagina's worden gemarkeerd, zodat de computers van onze bezoekers deze verschillende secties ook kunnen zien. Waarom? Terwijl de meeste lezers een muis gebruiken om door pagina's te navigeren, vertrouwen vele anderen op toetsenborden en schermlezers. Deze technologieën zijn sterk afhankelijk van hoe goed hun computers uw pagina begrijpen.

### Koppen

Koppen zijn niet alleen visueel nuttig, maar ook voor schermlezers. Ze stellen schermlezers in staat snel van sectie naar sectie te springen en helpen aan te geven waar de ene sectie eindigt en de andere begint.

Om verwarring van gebruikers van schermlezers te voorkomen, moet u ervoor zorgen dat u nooit een kopniveau overslaat. Ga bijvoorbeeld niet rechtstreeks van een `H1` naar een `H3` en sla de `H2` over. Waarom is dit zo belangrijk? Omdat dit een onverwachte wijziging is, waardoor een gebruiker van een schermlezer denkt dat hij een stukje inhoud heeft gemist. Dit kan ertoe leiden dat ze helemaal opnieuw gaan zoeken naar wat ze hebben gemist, zelfs als er niets ontbreekt. Bovendien help u al uw lezers door een consistenter ontwerp te behouden.

Met dat gezegd zijnde, hier zijn onze resultaten:

1. 89,36% van de pagina's gebruikt op de een of andere manier koppen. Geweldig.
2. 38,6% van de pagina's slaat kopniveaus over.
3. Vreemd genoeg worden `H2`'s op meer sites gevonden dan `H1`'s.

{{ figure_markup(
  image="fig3.png",
  caption="Populariteit van kopniveaus.",
  description="Verticaal staafdiagram met percentagegegevens, variërend van 0 tot 80 in stappen van 20, versus balken die elk kopniveau h1 tot en met h6 vertegenwoordigen. `H1`: 63,25%; `H2`: 67,86%; `H3`: 58,63%; `H4`: 36,38%; `H5`: 14,64%; `H6`: 6,91%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1123601243&format=interactive"
  )
}}

### Hoofdinhoudsgebied

Een [Hoofdinhoudsgebied <i lang="en">`main`</i>](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Roles/Main_role) geeft aan schermlezers aan waar de hoofdinhoud van een webpagina begint, zodat gebruikers er direct naartoe kunnen springen. Zonder dit moeten gebruikers van schermlezers uw navigatie handmatig overslaan elke keer dat ze naar een nieuwe pagina op uw site gaan. Dit is natuurlijk nogal frustrerend.

We ontdekten dat slechts één op de vier pagina's (26,03%) een belangrijk Hoofdinhoudsgebied bevatte. En verrassend genoeg bevatte 8,06% van de pagina's ten onrechte meer dan één belangrijk Hoofdinhoudsgebied, waardoor deze gebruikers raden welk gebied de werkelijke hoofdinhoud bevat.

{{ figure_markup(
  image="fig4.png",
  caption="Percentage pagina's op basis van hun aantal `main` elementen.",
  description="Verticaal staafdiagram met percentagegegevens, variërend van 0 tot 80 in stappen van 20, versus balken die het aantal `main` inhoudsgebied per pagina van 0 tot 4 weergeven. Bron: HTTP Archive (juli 2019). Nul: 73,97%; Een: 17,97%; Twee: 7,41%; Drie: 0,15%; 4: 0,06%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1420590464&format=interactive"
  )
}}

### HTML-sectie-elementen

Sinds HTML5 in 2008 werd uitgebracht en in 2014 de officiële standaard werd, zijn er veel HTML-elementen die computers en schermlezers helpen om onze pagina-indeling en -structuur te begrijpen.

Elementen zoals [`<header>`](https://developer.mozilla.org/docs/Web/HTML/Element/header), [`<footer>`](https://developer.mozilla.org/docs/Web/HTML/Element/footer), [`<navigation>`](https://developer.mozilla.org/docs/Web/HTML/Element/nav) en [`<main>`](https://developer.mozilla.org/docs/Web/HTML/Element/main) geven aan waar specifieke soorten inhoud zich bevinden en stellen gebruikers in staat snel door uw pagina te bladeren. Deze worden op grote schaal gebruikt op internet, waarvan de meeste op meer dan 50% van de pagina's worden gebruikt (`<main>` is de uitbijter).

Anderen zoals [`<article>`](https://developer.mozilla.org/docs/Web/HTML/Element/article), [`<hr>`](https://developer.mozilla.org/docs/Web/HTML/Element/hr), en [`<aside>`](https://developer.mozilla.org/docs/Web/HTML/Element/aside) helpen lezers bij het begrijpen van de belangrijkste inhoud van een pagina. `<article>` zegt bijvoorbeeld waar het ene artikel eindigt en het andere begint. Deze elementen worden lang niet zo vaak gebruikt, met elk ongeveer 20% verbruik. Deze horen niet allemaal op elke webpagina, dus dit is niet per se een alarmerende statistiek.

Al deze elementen zijn primair ontworpen voor toegankelijkheidsondersteuning en hebben geen visueel effect, wat betekent dat u bestaande elementen er veilig door kunt vervangen en geen onbedoelde gevolgen ondervindt.

{{ figure_markup(
  image="fig5.png",
  caption="Gebruik van verschillende HTML-semantische elementen.",
  description="Verticaal staafdiagram met balken voor elk elementtype versus percentage pagina's variërend van 0 tot 60 in stappen van 20. `nav`: 53,94%; `header`: 54,82%; `footer`: 55,92%; `main`: 18,47%; `aside`: 16,99%; `article`: 22,59%; `hr`: 19,1%; `section`: 36,55%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=708035719&format=interactive"
  )
}}

### Andere HTML-elementen die worden gebruikt voor navigatie

Bij veel populaire schermlezers kunnen gebruikers ook navigeren door snel door koppelingen, lijsten, lijstitems, iframes en formuliervelden zoals bewerkingsvelden, knoppen en keuzelijsten te bladeren. Figuur 9.6 laat zien hoe vaak we pagina's zagen met deze elementen.

{{ figure_markup(
  image="fig6.png",
  caption="Andere HTML-elementen die worden gebruikt voor navigatie",
  description="Verticaal staafdiagram met staven voor elk elementtype versus percentage pagina's variërend van 0 tot 100 in stappen van 25. `a`: 98,22%; `ul`: 88,62%; `input`: 76,63%; `iframe`: 60,39%; `button`: 56,74%; `select`: 19,68%; `textarea`: 12,03%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=389034849&format=interactive"
  )
}}

### Vermijdingslinks

Een <a hreflang="en" href="https://webaim.org/techniques/skipnav/">vermijdingslink</a> is een link die bovenaan een pagina wordt geplaatst en waarmee schermlezers of gebruikers met alleen toetsenbord direct naar de hoofdinhoud kunnen gaan. Het "slaat" effectief alle navigatielinks en menu's boven aan de pagina over. Vermijdingslinks zijn vooral handig voor toetsenbordgebruikers die geen schermlezer gebruiken, aangezien deze gebruikers gewoonlijk geen toegang hebben tot andere modi voor snelle navigatie (zoals Hoofdinhoudsgebieden en koppen). 14,19% van de pagina's in onze steekproef bleken vermijdingslinks te hebben.

Als u zelf een vermijdingslink in actie wilt zien, dan kan dat! Voer gewoon een snelle Google-zoekopdracht uit en klik op <kbd>tab</kbd> zodra u op de pagina's met zoekresultaten terechtkomt. U wordt begroet met een eerder verborgen link, net als die in afbeelding 9.7.

{{ figure_markup(
  image="example-of-a-skip-link-on-google.com.png",
  caption="Hoe een vermijdingslink eruitziet op google.com.",
  description="Schermafbeelding van de zoekresultatenpagina van Google voor 'http Archive'. De zichtbare 'Ga naar hoofdinhoud'-link is omgeven door een blauwe focusmarkering en een geel overlay-vak met een rode pijl die naar de vermijdingslink wijst, luidt in het engels 'Een vermijdingslink op google.com'.",
  width=600,
  height=333
  )
}}

In feite hoeft u deze site niet eens te verlaten, aangezien we <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/645">ze hier ook gebruiken</a>!

Het is moeilijk om nauwkeurig te bepalen wat een vermijdingslink is bij het analyseren van sites. Als we voor deze analyse een ankerlink (`href=#heading1`) vonden binnen de eerste 3 links op de pagina, hebben we dit gedefinieerd als een pagina met een vermijdingslink. Dus 14,19% is een strikte bovengrens.

### Snelkoppelingen

Sneltoetsen ingesteld met de <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts">`aria-keyshortcuts`</a> of [`accesskey`](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/accesskey) -attributen kunnen op twee manieren worden gebruikt:

1. Een element op de pagina activeren, zoals een link of knop.

2. Een bepaald element op de paginafocus geven. Bijvoorbeeld het verschuiven van de focus naar een bepaalde invoer op de pagina, zodat een gebruiker er vervolgens in kan typen.

Adoptie van <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts">`aria-keyshortcuts`</a> was bijna afwezig in onze steekproef, en werd alleen gebruikt op 159 sites van meer dan 4 miljoen geanalyseerd. Het [`accesskey`](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/accesskey) attribuut werd vaker gebruikt en werd gevonden op 2,47% van de webpagina's (1,74% op mobiele). We zijn van mening dat het hogere gebruik van snelkoppelingen op desktops het gevolg is van het feit dat ontwikkelaars verwachten dat mobiele sites alleen toegankelijk zijn via een touchscreen en niet via een toetsenbord.

Wat hier vooral verrassend is, is dat 15,56% van de mobiele en 13,03% van de desktopsites die sneltoetsen gebruiken, dezelfde snelkoppeling toewijzen aan meerdere verschillende elementen. Dit betekent dat browsers moeten raden welk element deze sneltoets moet bezitten.

### Tabellen

Tabellen zijn een van de belangrijkste manieren waarop we grote hoeveelheden gegevens ordenen en uitdrukken. Veel ondersteunende technologieën zoals schermlezers en schakelaars (die kunnen worden gebruikt door gebruikers met motorische handicaps) hebben mogelijk speciale functies waarmee ze efficiënter door deze tabelgegevens kunnen navigeren.

#### Koppen

Afhankelijk van de manier waarop een bepaalde tabel is gestructureerd, maakt het gebruik van tabelkoppen het gemakkelijker om kolommen of rijen te lezen zonder de context te verliezen over naar welke gegevens die specifieke kolom of rij verwijst. Het moeten navigeren door een tabel zonder koptekstrijen of -kolommen is een ondermaatse ervaring voor een gebruiker van een schermlezer. Dit komt omdat het voor een gebruiker van een schermlezer moeilijk is om zijn plaats in een tabel zonder kopteksten bij te houden, vooral wanneer de tabel vrij groot is.

Om tabelkoppen te markeren, gebruikt u gewoon de tag [`<th>`](https://developer.mozilla.org/docs/Web/HTML/Element/th) (in plaats van [`<td>`](https://developer.mozilla.org/docs/Web/HTML/Element/td)), of een van de ARIA [`columnheader`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Roles/Table_Role) of [`rowheader`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Roles/Table_Role) rollen. Slechts 24,5% van de pagina's met tabellen bleken hun tabellen met een van deze methoden te markeren. De driekwart van de pagina's die ervoor kiezen om tabellen zonder kopteksten op te nemen, vormen dus serieuze uitdagingen voor gebruikers van schermlezers.

Het gebruik van `<th>` en `<td>` was verreweg de meest gebruikte methode voor het markeren van tabelkoppen. Het gebruik van de rollen `columnheader` en `rowheader` was bijna onbestaande met slechts 677 sites die ze gebruikten (0,058%).

#### Bijschriften

Tabelbijschriften via het element [`<caption>`](https://developer.mozilla.org/docs/Web/HTML/Element/caption) zijn nuttig om meer context te bieden aan alle soorten lezers. Een bijschrift kan een lezer voorbereiden om de informatie op te nemen die uw tabel deelt, en het kan vooral handig zijn voor mensen die snel afgeleid of onderbroken worden. Ze zijn ook handig voor mensen die hun plaats in een grote tabel kunnen verliezen, zoals een gebruiker van een schermlezer of iemand met een leer- of verstandelijke beperking. Hoe gemakkelijker u het voor lezers kunt maken om te begrijpen wat ze analyseren, hoe beter.

Desondanks bevat slechts 4,32% van de pagina's met tabellen bijschriften.

## Compatibiliteit met ondersteunende technologieën

### Het gebruik van ARIA

Een van de meest populaire en meest gebruikte specificaties voor toegankelijkheid op internet is de <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/aria/" lang="en">Accessible Rich Internet Applications</a> (ARIA) -standaard. Deze standaard biedt een groot aantal aanvullende HTML-attributen om het doel achter visuele elementen (d.w.z. hun semantische betekenis) over te brengen en tot wat voor soort acties ze in staat zijn.

Het correct en gepast gebruiken van ARIA kan een uitdaging zijn. Van pagina's die gebruik maken van ARIA-attributen, hebben we bijvoorbeeld vastgesteld dat 12,31% ongeldige waarden heeft toegewezen aan hun attributen. Dit is problematisch omdat elke fout bij het gebruik van een ARIA-attribuut geen visueel effect heeft op de pagina. Sommige van deze fouten kunnen worden opgespoord met behulp van een geautomatiseerde validatietool, maar over het algemeen vereisen ze hands-on gebruik van echte ondersteunende software (zoals een schermlezer). In dit gedeelte wordt onderzocht hoe ARIA op internet wordt gebruikt en welke delen van de standaard het meest voorkomen.

{{ figure_markup(
  image="fig8.png",
  caption="Percentage van het totale aantal pagina's versus ARIA-attribuut.",
  description="Verticaal staafdiagram met percentagegegevens, variërend van 0 tot 25 in stappen van 5, versus staven die elk kenmerk vertegenwoordigen. `aria-hidden`: 23,46%, `aria-label`: 17,67%, `aria-expanded`: 8,68%, `aria-current`: 7,76%, `aria-labelledby`: 6,85%, `aria-controls`: 3,56%, `aria-haspopup`: 2,62%, `aria-invalid`: 2,68%, `aria-describedby`: 1,69%, `aria-live`: 1,04%, `aria-required`: 1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=792161340&format=interactive"
  )
}}

#### Het attribuut `role`

Het `role` -attribuut is het belangrijkste attribuut in de volledige ARIA-specificatie. Het wordt gebruikt om de browser te informeren wat het doel van een bepaald HTML-element is (d.w.z. de semantische betekenis). Een `<div>` -element, visueel vormgegeven als een knop met behulp van CSS, zou bijvoorbeeld de ARIA-rol van `button` moeten krijgen.

Momenteel gebruikt 46,91% van de pagina's ten minste één ARIA-rolattribuut. In figuur 9.9 hieronder hebben we een lijst samengesteld met de tien meest gebruikte ARIA-rolwaarden.

{{ figure_markup(
  image="fig9.png",
  caption="Top 10 ARIA-rollen.",
  description="Verticaal staafdiagram met balken voor elk roltype versus percentage sites met een bereik van 0 tot 25 in stappen van 5. `navigation`: 20,4%; `search`: 15,49%; `main`: 14,39%; `banner`: 13,62%; `contentinfo`: 11,23%; `button`: 10,59%; `dialog`: 7,87%; `complementary`: 6,06%; `menu`: 4,71%; `form`: 3,75%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=176877741&format=interactive"
  )
}}

Kijkend naar de resultaten in figuur 9.9, vonden we twee interessante inzichten: het updaten van gebruikersomgeving-frameworks kan een grote impact hebben op de toegankelijkheid op internet, en het indrukwekkende aantal sites dat probeert dialogen toegankelijk te maken.

##### Het updaten van gebruikersomgeving-frameworks zou de weg vooruit kunnen zijn voor toegankelijkheid op internet

De top 5 rollen, die allemaal op 11% van de pagina's of meer voorkomen, zijn landmark rollen. Deze worden gebruikt om de navigatie te vergemakkelijken, niet om de functionaliteit van een widget, zoals een keuzelijst met invoervak, te beschrijven. Dit is een verrassend resultaat omdat de belangrijkste drijfveer achter de ontwikkeling van ARIA was om webontwikkelaars de mogelijkheid te geven om de functionaliteit van widgets die zijn gemaakt van generieke HTML-elementen (zoals een `<div>`) te beschrijven.

We vermoeden dat enkele van de meest populaire web-gebruikersomgeving-frameworks navigatierollen in hun sjablonen hebben. Dit zou de prevalentie van landmark attributen verklaren. Als deze theorie klopt, kan het updaten van populaire gebruikersomgeving-frameworks om meer toegankelijkheidsondersteuning te bieden een enorme impact hebben op de toegankelijkheid van internet.

Een ander resultaat dat naar deze conclusie wijst, is het feit dat meer "geavanceerde" maar even belangrijke ARIA-attributen helemaal niet worden gebruikt. Dergelijke attributen kunnen niet gemakkelijk worden geïmplementeerd via een UI-framework, omdat ze mogelijk moeten worden aangepast op basis van de structuur en het uiterlijk van elke site afzonderlijk. We ontdekten bijvoorbeeld dat de `posinset`- en`setsize`-attributen alleen op 0,01% van de pagina's werden gebruikt. Deze attributen geven de gebruiker van een schermlezer door hoeveel items er in een lijst of menu staan en welk item momenteel is geselecteerd. Dus als een visueel gehandicapte gebruiker door een menu probeert te navigeren, kan hij indexaankondigingen horen zoals: "Home, 1 van 5", "Producten, 2 van 5", "Downloads, 3 van 5", enz.

##### Veel sites proberen dialogen toegankelijk te maken

De relatieve populariteit van de [`dialog` rol](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Roles/dialog_role) valt op omdat het erg moeilijk is om dialogen toegankelijk te maken voor gebruikers van schermlezers. Het is daarom spannend om te zien dat ongeveer 8% van de geanalyseerde pagina's de uitdaging aangaat. Nogmaals, we vermoeden dat dit te wijten kan zijn aan het gebruik van sommige gebruikersomgeving-frameworks.

#### Labels op interactieve elementen

De meest gebruikelijke manier waarop een gebruiker met een website omgaat, is via de bedieningselementen, zoals links of knoppen om door de website te navigeren. Vaak kunnen gebruikers van schermlezers echter niet vertellen welke actie een besturingselement zal uitvoeren nadat het is geactiveerd. Vaak is de reden dat deze verwarring optreedt, te wijten aan het ontbreken van een tekstueel label. Bijvoorbeeld een knop met een naar links wijzend pijlpictogram om aan te geven dat het de "Terug" -knop is, maar zonder daadwerkelijke tekst.

Slechts ongeveer een kwart (24,39%) van de pagina's die knoppen of links gebruiken, bevat tekstlabels met deze bedieningselementen. Als een besturingselement geen label heeft, kan een gebruiker van een schermlezer iets generieks lezen, zoals het woord "knop" in plaats van een betekenisvol woord als "Zoeken".

Knoppen en links zijn bijna altijd in de tabvolgorde opgenomen en hebben dus een extreem hoge zichtbaarheid. Navigeren door een website met de Tab-toets is een van de belangrijkste manieren waarop gebruikers die alleen het toetsenbord gebruiken, uw website verkennen. Een gebruiker zal dus zeker uw niet-gelabelde knoppen en links tegenkomen als ze door uw website navigeren met de tab-toets.

### Toegankelijkheid van formulierbesturingselementen

Formulieren invullen is een taak die velen van ons elke dag doen. Of we nu winkelen, reizen boeken of solliciteren, formulieren zijn de belangrijkste manier waarop gebruikers informatie delen met webpagina's. Daarom is het ongelooflijk belangrijk dat uw formulieren toegankelijk zijn. De eenvoudigste manier om dit te bereiken is door labels te verstrekken (via het [`<label>` element](https://developer.mozilla.org/docs/Web/HTML/Element/label), [`aria -label`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-label_attribute) of [`aria-labelledby`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-labelledby_attribute)) voor elk van uw invoer. Helaas biedt slechts 22,33% van de pagina's labels voor al hun formulierinvoer, wat betekent dat 4 van de 5 pagina's formulieren bevatten die erg moeilijk in te vullen kunnen zijn.

#### Indicatoren van verplichte en ongeldige velden

Als we een veld tegenkomen met een grote rode asterisk ernaast, weten we dat dit een verplicht veld is. Of als we op verzenden klikken en te horen krijgen dat er ongeldige invoer was, moet alles wat in een andere kleur is gemarkeerd, worden gecorrigeerd en vervolgens opnieuw worden ingediend. Mensen met een laag of geen zicht kunnen echter niet vertrouwen op deze visuele aanwijzingen, daarom zijn de HTML-invoerattributen `required`, `aria-required` en `aria-invalid` zo belangrijk. Ze bieden schermlezers het equivalent van rode asterisken en rood gemarkeerde velden. Als een leuke bonus, wanneer u browsers informeert welke velden vereist zijn, zullen ze [delen van uw formulieren valideren](https://developer.mozilla.org/docs/Learn/HTML/Forms/Form_validation) voor u. Geen JavaScript nodig.

Van de pagina's die formulieren gebruiken, gebruikt 21,73% `required` of `aria-required` bij het markeren van verplichte velden. Slechts één op de vijf sites maakt hiervan gebruik. Dit is een eenvoudige stap om uw site toegankelijk te maken en biedt alle gebruikers handige browserfuncties.

We ontdekten ook dat 3,52% van de sites met formulieren gebruik maken van `aria-invalid`. Aangezien veel formulieren dit veld echter pas gebruiken als er onjuiste informatie is ingediend, konden we niet het werkelijke percentage sites vaststellen dat deze opmaak gebruikt.

#### Dubbele `id`'s

`id`'s kunnen in HTML worden gebruikt om twee elementen aan elkaar te koppelen. Het [`<label>` element](https://developer.mozilla.org/docs/Web/HTML/Element/label) werkt bijvoorbeeld op deze manier. U specificeert de `id` van het invoerveld dat dit label beschrijft en de browser koppelt ze aan elkaar. Het resultaat? Gebruikers kunnen nu op dit label klikken om zich op het invoerveld te concentreren, en schermlezers zullen dit label gebruiken als beschrijving.

Helaas heeft 34,62% van de sites dubbele `id`'s, wat betekent dat op veel sites de door de gebruiker gespecificeerde `id` naar meerdere verschillende ingangen kan verwijzen. Dus als een gebruiker op het label klikt om een veld te selecteren, kan het zijn dat hij <a hreflang="en" href="https://www.deque.com/blog/unique-id-attributes-matter/">iets anders selecteert</a> dan hij van plan was. Zoals u zich wellicht kunt voorstellen, kan dit negatieve gevolgen hebben in bijvoorbeeld een winkelwagentje.

Dit probleem is zelfs nog meer uitgesproken voor schermlezers, omdat hun gebruikers mogelijk niet visueel kunnen controleren wat er is geselecteerd. Plus, veel ARIA-attributen, zoals [`aria-describedby`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-describedby_attribute) en [`aria-labelledby`] (https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-labelledby_attribute), werken op dezelfde manier als het labelelement dat hierboven is beschreven. Dus om uw site toegankelijk te maken, is het verwijderen van alle dubbele `id`'s een goede eerste stap.

## Gevolgtrekking

Mensen met een handicap zijn niet de enigen met toegankelijkheidsbehoeften. Iedereen die een tijdelijke polsblessure heeft opgelopen, heeft bijvoorbeeld de moeilijkheid ervaren om op kleine tikdoelen te tikken. Het gezichtsvermogen neemt vaak af met de leeftijd, waardoor tekst in kleine lettertypen moeilijk leesbaar wordt. De behendigheid van de vingers is niet hetzelfde voor alle leeftijdsgroepen, waardoor het tikken op interactieve bedieningselementen of het vegen door inhoud op mobiele websites moeilijker wordt voor een aanzienlijk percentage van de gebruikers.

Evenzo is ondersteunende software niet alleen gericht op mensen met een handicap, maar ook om de dagelijkse ervaring van iedereen te verbeteren:
- De recente populariteit van spraakondersteuning, zowel op mobiele apparaten als thuis, heeft aangetoond dat het besturen van een computerapparaat met spraakopdrachten zowel wenselijk als essentieel is voor veel gebruikers. Spraakopdrachten zoals deze waren vroeger alleen een toegankelijkheidsfunctie, maar worden nu een algemeen product.
- Bestuurders zouden baat hebben bij een schermleesfunctie die, terwijl ze hun blik op de weg gericht houden, lange stukken tekst voorleest, zoals nieuwsverhalen.
- Bijschriften worden niet alleen gewaardeerd door mensen die een video niet kunnen horen, maar ook door mensen die een video willen bekijken in een luidruchtig restaurant of in een bibliotheek.

Als een website eenmaal is gebouwd, is het vaak moeilijk om toegankelijkheid achteraf aan te brengen op bestaande sitestructuren en widgets. Toegankelijkheid is niet iets dat achteraf gemakkelijk kan worden besprenkeld, maar moet deel uitmaken van het ontwerp- en implementatieproces. Helaas zijn veel ontwikkelaars, hetzij door een gebrek aan bewustzijn of door eenvoudig te gebruiken testtools, niet bekend met de behoeften van al hun gebruikers en de vereisten van de ondersteunende software die ze gebruiken.

Hoewel ze niet overtuigend zijn, geven onze resultaten aan dat het gebruik van toegankelijkheidsnormen zoals ARIA en beste praktijken voor toegankelijkheid (bijvoorbeeld het gebruik van alt-tekst) te vinden is op een *aanzienlijk, maar niet substantieel* deel van het internet. Op het eerste gezicht is dit bemoedigend, maar we vermoeden dat veel van deze positieve trends te wijten zijn aan de populariteit van bepaalde gebruikersomgeving-frameworks. Enerzijds is dit teleurstellend omdat webontwikkelaars niet simpelweg kunnen vertrouwen op gebruikersomgeving-frameworks om hun sites te voorzien van toegankelijkheidsondersteuning. Aan de andere kant is het bemoedigend om te zien hoe groot het effect van gebruikersomgeving-frameworks kan zijn op de toegankelijkheid van internet.

De volgende grens is naar onze mening het toegankelijker maken van widgets die beschikbaar zijn via UI-frameworks. Omdat veel complexe widgets die in het wild worden gebruikt (bijvoorbeeld agendakiezers) afkomstig zijn uit een gebruikersomgeving-bibliotheek, zou het geweldig zijn als deze widgets direct toegankelijk zouden zijn. We hopen dat wanneer we de volgende keer onze resultaten verzamelen, het gebruik van beter geïmplementeerde complexe ARIA-rollen toeneemt - wat betekent dat er ook complexere widgets toegankelijk zijn gemaakt. Bovendien hopen we meer toegankelijke media te zien, zoals afbeeldingen en video, zodat alle gebruikers kunnen genieten van de rijkdom van internet.
