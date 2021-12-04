---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Toegankelijkheid
description: Toegankelijkheidshoofdstuk van de Web Almanac 2020 over leesgemak, media, navigatiegemak en compatibiliteit met ondersteunende technologieën.
authors: [oluoluoxenfree, alextait1]
reviewers: [aardrian, ericwbailey, obto]
analysts: [obto]
editors: [tunetheweb]
translators: [noah-vdv]
oluoluoxenfree_bio: Olu Niyi-Awosusi is een software engineer bij de FT die houdt van lijsten, nieuwe dingen leren, Bee en Puppycat, <a hreflang="en" href="https://alistapart.com/article/building-the-woke-web/">sociale rechtvaardigheid, toegankelijkheid</a> en elke dag harder proberen.
alextait1_bio: Alex Tait is een ontwikkelaar, consultant en docent wiens passie ligt op het snijvlak van toegankelijkheid en modern JavaScript binnen interfacearchitectuur en ontwerpsystemen. Als ontwikkelaar is ze van mening dat op inclusie gebaseerde ontwikkelingspraktijken met toegankelijkheid voorop leiden tot betere producten voor iedereen. Als consultant en strateeg is ze van mening dat minder meer is, en dat nieuwe functieomvang niet kan worden geprioriteerd boven pariteit van kernfuncties voor gehandicapte gebruikers. Als onderwijzer gelooft ze in het wegnemen van belemmeringen voor informatie, zodat technologie een meer diverse, rechtvaardige en inclusieve industrie kan worden.
discuss: 2044
results: https://docs.google.com/spreadsheets/d/1UjEBhq0TfYxUpdpq5IuxjeHB4yqhJq4NOKEd6Dwwrdk/
featured_quote: Als industrie wordt het tijd dat we het verhaal erkennen dat wordt verteld door de cijfers in dit hoofdstuk; we zijn gehandicapten in de steek aan het laten.
featured_stat_1: 15,357,625
featured_stat_label_1: Langst bekende `alt` tekstlengte
featured_stat_2: 3,200
featured_stat_label_2: Sites die `aria-labelledby` verkeerd spellen als `aria-labeledby`
featured_stat_3: 0.79%
featured_stat_label_3: Video's met ondertiteling

---

## Inleiding

In 2020 wordt het, meer dan ooit tevoren, steeds urgenter dat digitale ruimtes inclusief en voor iedereen toegankelijk zijn. Nu de aanhoudende pandemie het voor mensen nog moeilijker maakt om persoonlijk toegang te krijgen tot diensten en voor hele industrieën die online gaan, worden gehandicapten onevenredig zwaar getroffen. Bovendien stijgt het aantal mensen met een handicap als gevolg van de <a hreflang="en" href="https://www.cdc.gov/coronavirus/2019-ncov/long-term-effects.html">langetermijneffecten</a> van de pandemie.

Bij webtoegankelijkheid gaat het om het bereiken van pariteit van functies en informatie en om mensen met een handicap volledige toegang te geven tot alle aspecten van een interface. Een digitaal product of website is simpelweg niet compleet als het niet voor iedereen bruikbaar is. Als het bepaalde gehandicapte bevolkingsgroepen uitsluit, is dit discriminatie en mogelijk reden voor boetes en/of rechtszaken.

De <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/">Web Content Accessibility Guidelines</a>, of WCAG, is een internationaal erkende reeks standaarden waaraan moet worden voldaan in alle websites en applicaties die gebruikmaken van het internet. Het zijn geen wetten, maar <a hreflang="en" href="https://www.w3.org/WAI/policies/">veel wetten verwijzen naar WCAG als hun basis</a>.

Deze richtlijnen hebben in de loop der jaren meerdere releases gehad en de huidige standaard is WCAG 2.1, waarbij WCAG 2.2 momenteel wordt doorgelicht als een <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/">werkversie</a>. Sommige regionale wetten verwijzen naar WCAG 2.0 als vereiste, maar zoals [Adrian Roselli](https://twitter.com/aardrian) in zijn artikel beschrijft <a hreflang="en" href="https://adrianroselli.com/2020/09/wcag-2-1-is-the-current-standard-not-wcag-2-0-and-wcag-2-2-is-coming.html">WCAG 2.1 is de huidige standaard, niet WCAG 2.0 - en WCAG 2.2 komt eraan</a> we moeten voldoen aan de WCAG 2.1-normen en ook rekening houden met de nieuwe criteria die in WCAG 2.2 komen.

Een gevaarlijke trend die in 2020 meer dan ooit is blootgesteld, is het gebruik van "toegankelijkheidsoverlays". Deze widgets beloven een stapsgewijze naleving van toegankelijkheid en introduceren vaker wel dan niet nieuwe barrières en maken de ervaring voor een gehandicapte gebruiker behoorlijk uitdagend. Het is belangrijk dat digitale beoefenaars de verantwoordelijkheid nemen over het ontwerpen en implementeren van bruikbare interfaces en niet proberen dit proces te ondermijnen met een snelle oplossing. Zie voor meer informatie het artikel van Lainey Feingold, <a hreflang="en" href="https://www.lflegal.com/2020/08/quick-fix/">Honor the ADA: Avoid Web Accessibility Quick Fix Overlays</a>.

Helaas vinden wij en andere teams die analyses uitvoeren, zoals de <a hreflang="en" href="https://webaim.org/projects/million/">WebAIM Million</a> jaar na jaar, weinig en in sommige gevallen geen verbetering in deze statistieken. De mediane algemene sitescore voor alle auditgegevens van <a hreflang="en" href="https://web.dev/lighthouse-accessibility/">Lighthouse Accessibility</a> steeg van 73% in 2019 naar 80% in 2020. We hopen dat deze stijging van 7% een verschuiving in de goede richting. Dit zijn echter geautomatiseerde controles en kunnen betekenen dat ontwikkelaars de regel engine beter ondermijnen, dus we zijn voorzichtig optimistisch.

Onze analyse is alleen gebaseerd op geautomatiseerde statistieken. Het is belangrijk om te onthouden dat geautomatiseerd testen slechts een fractie van de toegankelijkheidsbarrières vastlegt die in een interface aanwezig kunnen zijn. Kwalitatieve analyse, inclusief handmatige tests en bruikbaarheidstests met mensen met een handicap, zijn nodig om tot een toegankelijke site of applicatie te komen.

We hebben onze meest interessante inzichten opgesplitst in vijf categorieën:

1. Leesgemak,
2. Media op internet,
3. Navigatiegemak,
4. Ondersteunende technologieën op internet,
5. Toegankelijkheid van formulierbesturingselementen.

We hopen dat dit hoofdstuk vol ontnuchterende statistieken en aantoonbare nalatigheid op het gebied van toegankelijkheid op het web lezers zal inspireren om prioriteit te geven aan dit werk en hun praktijken te veranderen, en over te schakelen naar een meer inclusief en eerlijk internet.

## Leesgemak

Inhoud zo eenvoudig en duidelijk mogelijk leesbaar maken, is een belangrijk aspect van webtoegankelijkheid. Door de inhoud van een pagina niet te kunnen lezen, kan een gebruiker taken op websites niet uitvoeren. Er zijn veel aspecten van een webpagina die het lezen gemakkelijker of moeilijker maken, waaronder kleurcontrast, zoomen en schalen van pagina's en taalidentificatie.

### Kleurcontrast

Hoe hoger het pagina-contrast, hoe gemakkelijker het voor mensen is om op tekst gebaseerde inhoud te bekijken. Mensen die mogelijk moeite hebben met het bekijken van inhoud met een laag contrast, zijn onder meer mensen met een verminderd gezichtsvermogen, mensen met licht tot matig verlies van het gezichtsvermogen en mensen met contextuele problemen met het bekijken van de inhoud, zoals verblinding op schermen bij fel licht.

{{ figure_markup(
  image="sites-with-sufficient-color-contrast-2019-2020.png",
  caption="Sites met voldoende kleurcontrast.",
  description="Staafdiagram met het percentage sites met voldoende kleurcontrast in 2019 en 2020. 22,04% van de sites had voldoende kleurcontrast in 2019, afnemend tot 21,06% in 2020, wat betekent dat 77,96% onvoldoende kleurcontrast had in 2019 oplopend tot 78,94% in 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSjkB_XAYiwkYrMuoXp44mdqMGJVDUkTr_48ELozY72Mdv3OlxeWV9ysbDY9bs6hA7LnJTrHar9aZlM/pubchart?oid=1827221015&format=interactive",
  sheets_gid="1115686547",
  sql_file="color_contrast.sql"
  )
}}

Helaas bleek slechts 21,06% van de sites voldoende kleurcontrast te hebben. Dat is een daling ten opzichte van de al hopeloze 22% van vorig jaar.

### Zoomen en schalen

Het is essentieel dat we gebruikers toestaan te zoomen op de pagina of inhoud. Er zijn technieken die kunnen worden gebruikt om te proberen de mogelijkheid om de browser te schalen of in te zoomen uit te schakelen. Sommige besturingssystemen ondermijnen dit schadelijke patroon, maar veel niet, en het is een antipatroon dat moet worden vermeden.

Zoomen is vooral handig voor gebruikers met slechtziendheid. Volgens de <a hreflang="en" href="https://www.who.int/news-room/fact-sheets/detail/blindness-and-visual-impairment">Wereldgezondheidsorganisatie</a> "hebben wereldwijd 1 miljard mensen een visuele beperking".

{{ figure_markup(
  image="sites-with-zooming-and-scaling-disabled.png",
  caption="Sites waarop zoomen en schalen is uitgeschakeld.",
  description="Staafdiagram die toont dat 16,0% van de desktopsites en 19,7% van de mobiele sites schalen uitzetten, 21,1% van desktopsites en 27,1% van de mobiele sites stoppen zoomen op 1, en 24,4% van desktopsites en 30,7% van de mobiele sites heeft een van beide ingesteld.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSjkB_XAYiwkYrMuoXp44mdqMGJVDUkTr_48ELozY72Mdv3OlxeWV9ysbDY9bs6hA7LnJTrHar9aZlM/pubchart?oid=1053957382&format=interactive",
  sheets_gid="1095274901",
  sql_file="viewport_zoom_scale.sql"
  )
}}

We ontdekten dat 29,34% van de desktoppagina's en 30,66% van de mobiele pagina's schalen probeert uit te schakelen door ofwel `maximum-scale` in te stellen op een waarde kleiner dan 1, of `user-scalable` `0` of `none`. Sommige besturingssystemen voldoen niet langer aan de uitgeschakelde zoom- en schaalinstelling in HTML. Voor systemen die het wel respecteren, kan dit de pagina voor sommigen effectief onbruikbaar maken. Zie het artikel van Adrian Roselli, <a hreflang="en" href="https://adrianroselli.com/2015/10/dont-disable-zoom.html"><span lang="en">Don't Disable Zoom</span></a> voor meer informatie over het vermijden van het uitschakelen van browserzoom.

### Taalidentificatie

{{ figure_markup(
  caption="Desktopsites hebben een geldig kenmerk `lang`.",
  content="77,67%",
  classes="big-number",
  sheets_gid="812908021",
  sql_file="02_05.sql"
)
}}

Door een HTML-attribuut `lang` in te stellen, kan een pagina gemakkelijk worden vertaald en is er betere ondersteuning voor schermlezers. Het percentage sites met een geldig HTML lang-attribuut op desktop dit jaar was 77,67%, met slechts 77,7% überhaupt een `lang`-attribuut.

## Media op internet

Media is een essentieel onderdeel van de webervaring. Het kan een verrijkte context toevoegen aan de omringende tekstuele informatie, en niet alleen voor ziende gebruikers.

### Afbeeldingen en hun tekstalternatieven

In 1995 introduceerde <a hreflang="en" href="https://www.w3.org/MarkUp/html-spec/html-spec_5.html#SEC5.10">HTML 2.0</a> het `alt`-attribuut, waardoor webauteurs een tekstalternatief konden bieden voor de visuele informatie die in een afbeelding wordt gecommuniceerd. Een schermlezer kan zijn visuele betekenis auditief overbrengen door de alternatieve tekst van de afbeelding aan te kondigen. Als afbeeldingen niet kunnen worden geladen, wordt de alternatieve tekst voor een beschrijving weergegeven.

{{ figure_markup(
  caption='Mobiele sites passeren de "afbeeldingen met `alt` tekst" Lighthouse audit.',
  content="54%",
  classes="big-number",
  sheets_gid="580400436",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

Uit de 2020-auditgegevens van Lighthouse blijkt dat slechts 54% van de sites de <a hreflang="en" href="https://dequeuniversity.com/rules/axe/3.5/image-alt">test voor afbeeldingen met `alt`-tekst</a> doorstaat. Deze test zoekt naar de aanwezigheid van ten minste één van de attributen `alt`, `aria-label` en `aria-labelledby` op `img` elementen. In de meeste gevallen is het gebruik van het `alt`-attribuut de beste keuze.

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="Alt attribuut lengtes.",
  description="Staafdiagram met `alt`-attribuutlengtes, gegroepeerd op percentage pagina's. 21,25% van de desktopafbeeldingen en 21,38% van de mobiele afbeeldingen hebben geen `alt`-attribuut, terwijl 26,20% van de desktop en 26,24% van de mobiele afbeeldingen een lengte nul hebben, 15,76% van de desktop en 15,07% van de mobiele afbeeldingen een lengte van 10 of minder, 13,56% van de desktop en 13,49% van de mobiele apparaten hebben een lengte van 20 of minder, 22,23% van de desktop en 22,81% van de mobiele apparaten hebben een lengte van 100 of minder, en 1,00% van de desktop en 1,01% van de mobiele apparaten hebben een lengte van meer dan 100.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSjkB_XAYiwkYrMuoXp44mdqMGJVDUkTr_48ELozY72Mdv3OlxeWV9ysbDY9bs6hA7LnJTrHar9aZlM/pubchart?oid=829889381&format=interactive",
  sheets_gid="152817998",
  sql_file="common_alt_text_length.sql"
  )
}}

Hoewel de `alt`-attributen al 25 jaar bestaan, ontdekten we ook dat in 21,24% van de desktopafbeeldingen en 21,38% van de mobiele afbeeldingen geen alternatieve tekst is. Dit is een van de gemakkelijkste geautomatiseerde controles om te testen op het gebruik van uw favoriete toegankelijkheidstool en zou laaghangend fruit moeten zijn en een relatief eenvoudig probleem om op te lossen.

Gebruikers van schermlezers luisteren naar de <a hreflang="en" href="https://developer.paciellogroup.com/blog/2015/10/thus-spoke-html/">"auditieve gebruikersinterface" zoals beschreven door Steve Faulker</a>, een auditieve of sonische ervaring van de interface waarin de structuur, semantiek en relaties van de inhoud worden aangekondigd. Dit betekent dat gebruikers van schermlezers veel tekstuele informatie consumeren. Om deze reden is het belangrijk om te beoordelen of een afbeelding niet hoeft te worden beschreven. Dit is een nuttige <a hreflang="en" href="https://www.w3.org/WAI/tutorials/images/decision-tree/">beslissingsboom van het W3C</a> om te beslissen hoe en of een afbeelding moet worden beschreven. Als een afbeelding echt decoratief is en niets zinvols toevoegt aan de omringende context, kunt u het kenmerk `alt` een null-waarde toekennen, `alt=""`. Het is belangrijk om dit expliciet te doen in plaats van het `alt`-attribuut helemaal weg te laten, omdat het weglaten ervan kan leiden tot ondersteunende technologie die het afbeeldingspad aankondigt, wat een zeer verwarrende gebruikerservaring is.

We ontdekten dat 26,20% van de desktoppagina's en 26,23% van de mobiele pagina's `alt`-attributen bevatten met een null/lege waarde. We hopen dat dit erop wijst dat meer dan een kwart van de websites wordt ontwikkeld met aandacht waarvoor afbeeldingen echt zinvol zijn en niet als een manier om geautomatiseerde controles te omzeilen.

Bij het beschrijven van een afbeelding is het absoluut noodzakelijk om te overwegen welke informatie de gebruiker nodig heeft en om aanvullende informatie weg te laten om de breedsprakigheid te verminderen. Een pictogramknop met een rode pijl die de actie heeft om naar een nieuwe stap in de interface te gaan, kan bijvoorbeeld worden omschreven als "ga verder met stap 3 van 5" in plaats van "rode pijl png". De eerste beschrijving vertelt de gebruiker wat hij kan verwachten als hij het besturingselement activeert, terwijl de tweede alleen het uiterlijk beschrijft en een onnodige bestandsextensie heeft, die beide niet relevant zijn voor de betekenis van de afbeelding.

Geautomatiseerde controles op de aanwezigheid van alternatieve tekst beoordelen de kwaliteit van deze tekst niet. Zoals beschreven in het vorige gedeelte, moet bij het schrijven van deze tekst rekening worden gehouden met de betekenis van een afbeelding. Een veelvoorkomend onbehulpzaam patroon is het beschrijven van de afbeelding met de bestandsextensie. Voor het vorige voorbeeld met "rode pijl png" krijgt een gebruiker van een schermlezer waarschijnlijk geen nuttige informatie uit het afbeeldingsformaat. We ontdekten dat 6,8% van de desktopsites (met ten minste één instantie van het `alt`-attribuut) een bestandsextensie in zijn waarde had.

De top 5 bestandsextensies die expliciet zijn opgenomen in de `alt`-tekstwaarde (voor sites met afbeeldingen die niet-lege alt-waarden hebben) zijn `jpg`, `png`, `ico`, `gif`, en `jpeg`. Dit komt waarschijnlijk van een CMS of een ander automatisch gegenereerd alternatief tekstmechanisme. Het is absoluut noodzakelijk dat deze alt-attribuutwaarden zinvol zijn, ongeacht hoe ze zijn geïmplementeerd.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Bestandsextensie</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>jpg</code></td>
        <td class="numeric">4,08%</td>
        <td class="numeric">3,83%</td>
      </tr>
      <tr>
        <td><code>png</code></td>
        <td class="numeric">2,99%</td>
        <td class="numeric">2,82%</td>
      </tr>
      <tr>
        <td><code>ico</code></td>
        <td class="numeric">1,35%</td>
        <td class="numeric">1,26%</td>
      </tr>
      <tr>
        <td><code>gif</code></td>
        <td class="numeric">0,34%</td>
        <td class="numeric">0,33%</td>
      </tr>
      <tr>
        <td><code>jpeg</code></td>
        <td class="numeric">0,35%</td>
        <td class="numeric">0,31%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Alt-attributen die eindigen op een bestandsextensie.",
      sheets_gid="704032354",
      sql_file="alt_ending_in_image_extension.sql"
    ) }}
  </figcaption>
</figure>

#### Afbeeldingen met titelattributen

Het kenmerk `titel` dat een tooltip genereert die tekst weergeeft, wordt vaak aangezien als een andere betrouwbare manier om afbeeldingen te beschrijven voor ondersteunende technologie. Maar volgens de HTML-standaard:

> "Het vertrouwen op het kenmerk ``titel` wordt momenteel afgeraden, aangezien veel user agents het kenmerk niet op een toegankelijke manier blootleggen, zoals vereist door deze specificatie"

Tooltips introduceren ook een groot aantal andere toegankelijkheidsbelemmeringen, zoals informatie die alleen wordt onthuld bij hover/mouse-over, informatie die niet correct wordt gecommuniceerd naar ondersteunende technologie, gebrek aan toetsenbordondersteuning en algemene slechte bruikbaarheid. De geschiedenis van tooltips en hun barrières wordt goed beschreven door [Sarah Higley](https://twitter.com/codingchaos) in haar blogpost <a hreflang="en" href="https://sarahmhigley.com/writing/tooltips-in-wcag-21/">Tooltips in de tijd van WCAG 2.1</a>.

We ontdekten dat 16,95% van alle `alt`-attributen ook een `title`-attribuut bevatten. Van deze gevallen had 73,56% van de desktopsites en 72,80% van de mobiele sites overeenkomende waarden voor zowel de `alt`- als de `title`-attributen.

#### Andere feiten over `alt`-tekst

{{ figure_markup(
  caption="De langst bekende `alt`-tekstlengte.",
  content="15.357.625",
  classes="big-number",
  sheets_gid="1881074528",
  sql_file="alt_text_length.sql"
) }}

De gemiddelde lengte voor zowel desktop- als mobiele `alt`-tekst is 18 tekens. Aangezien de gemiddelde Engelse woordlengte 4,7 tekens is, betekent dit dat de gemiddelde waarde van het alt-attribuut 3-4 woorden lang is. Afhankelijk van de afbeelding kan het nuttig zijn om kort te zijn. Het is echter moeilijk voor te stellen dat 4 woorden voldoende zijn voor een nauwkeurige beschrijving van een afbeelding met enige complexiteit.

De langste `alt`-tekstlengte gevonden voor desktopsites was 15.357.625 tekens. Dat is genoeg om 5 en een halve "War and Peace"-formaat boeken te vullen (ervan uitgaande dat "War and Peace" een gemiddelde woordlengte heeft van 4,7 karakters).

### Video op internet

Video en andere multimedia-inhoud kunnen een webervaring verrijken, maar worden vaak niet krachtig ondersteund voor alle gebruikers en kunnen grote toegankelijkheidsbelemmeringen opleveren als het niet met ondersteuning wordt geïmplementeerd. Zie voor meer informatie de <a hreflang="en" href="https://www.w3.org/WAI/media/av/">W3C's Making Audio and Video Accessible</a>.

#### Bijschriften

Bijschriften of transcripties zijn nodig om auditieve informatie over te brengen aan mensen die doof of slechthorend zijn en zijn ook zeer nuttig voor gebruikers met cognitieve beperkingen, zoals problemen met het verwerken van audio. Transcripties helpen ook slechtziende en blinde gebruikers door beelden te beschrijven. Videocontent op internet is niet toegankelijk als deze geen begeleidende ondertiteling heeft. Net als het belang van zinvolle alternatieve tekst voor afbeeldingen, is de kwaliteit van bijschriften ook erg belangrijk.

> "Bijschriften bevatten niet alleen dialogen, maar identificeren ook wie er spreekt en bevatten niet-spraakinformatie die via geluid wordt overgebracht, inclusief betekenisvolle geluidseffecten"
> -<span lang="en">WCAG, Understanding Success Criterion 1.2.2: Captions</span>

{{ figure_markup(
  caption="Video's met ondertiteling.",
  content="0,79%",
  classes="big-number",
  sheets_gid="1002881600",
  sql_file="video_track_usage.sql"
) }}

Van de sites die `<video>`-elementen gebruiken, biedt slechts 0,79% ondertitels, die we aannemen op basis van de aanwezigheid van het `<track>`-element (en die verschillen van open/ingebrande bijschriften). Houd er rekening mee dat sommige websites aangepaste oplossingen hebben voor het leveren van video- en audiobijschriften aan gebruikers, en we konden deze aangepaste oplossingen niet detecteren, dus het percentage sites dat ondertiteling gebruikt, kan hoger zijn, maar dit cijfer is een indicatie van hoe onderondersteunde ondertiteling is ingeschakeld in webvideo-inhoud. We kunnen ook de kwaliteit van de gedetecteerde ondertitels niet beoordelen en of ze de volledige betekenis van de video die ze beschrijven, al dan niet nauwkeurig weergeven.

#### Video automatisch afspelen

Het is aantoonbaar een ontwrichtende en ongewenste gebruikerservaring om video voor alle gebruikers automatisch af te spelen en te herhalen op een website. Video kan een bron van hulpbronnen zijn voor zowel apparaatbatterijen als gegevens. In sommige gevallen kan video inhoud bevatten die verontrustend is voor gebruikers, hetzij door storende beelden weer te geven, hetzij door te worden gebruikt als aanvalsvector tegen mensen die vatbaar zijn voor aanvallen.

Voor gehandicapte gebruikers zijn er aanzienlijke belemmeringen die worden veroorzaakt door automatisch afspelen en herhalen van video. Voor gebruikers van schermlezers zal een video met audio waarschijnlijk de aankondigingen verstoren en tot verwarring leiden. Voor mensen met cognitieve handicaps zoals ADHD kan video erg afleidend zijn en het vermogen van de gebruiker om de interface te gebruiken en te begrijpen onderbreken. Mensen met vestibulaire aandoeningen kunnen ook gevaarlijk worden getriggerd door video.

De <span lang="en">Web Content Accessibility Guidelines</span> hebben een criterium <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/pause-stop-hide.html">2.2.2 Pauze, Stop, Verbergen</a> die vereisen dat elke bewegende, knipperende of scrollende inhoud (inclusief video) die langer dan 5 seconden wordt afgespeeld, een mechanisme heeft om deze te pauzeren, te stoppen of te verbergen.

{{ figure_markup(
  image="common-video-attributes.png",
  caption="De meest voorkomende `<video>`-attributen.",
  description="Staafdiagram met de top 5 attributen op het `<video>` element op desktop met `loop` op 58,43% van de video's, `autoplay` op 56,98%, `muted` op 56,13%, `class` op 51,79% en `preload` op 45,21% van de video's.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSjkB_XAYiwkYrMuoXp44mdqMGJVDUkTr_48ELozY72Mdv3OlxeWV9ysbDY9bs6hA7LnJTrHar9aZlM/pubchart?oid=1226671706&format=interactive",
  sheets_gid="713294916",
  sql_file="common_video_attributes.sql"
  )
}}

Van de pagina's met video aanwezig, ontdekten we dat 56,98% van de desktoppagina's en 53,64% van de mobiele pagina's het kenmerk `autoplay` hebben, wat betekent dat video's standaard worden afgespeeld. We ontdekten ook dat 58,42% van de desktoppagina's en 52,86% van de mobiele pagina's het kenmerk `loop` hebben, wat zeer waarschijnlijk betekent dat de video voor onbepaalde tijd wordt afgespeeld. Hoewel er mechanismen kunnen zijn om deze video's te pauzeren, te stoppen of te verbergen, zou het standaard moeten zijn om ervoor te kiezen video af te spelen in plaats van het automatisch afspelen te stoppen en/of de video te herhalen. Deze statistieken suggereren dat meer dan de helft van de websites met video aanzienlijke toegankelijkheidsbelemmeringen zou kunnen hebben.

## Eenvoudige paginanavigatie

Pagina's moeten gemakkelijk te navigeren zijn, zodat gebruikers zich niet verloren voelen, of niet in staat zijn de inhoud te vinden die ze nodig hebben om te doen wat hen in de eerste plaats naar onze sites heeft gebracht. Schermlezertechnologie moet ook onderscheid kunnen maken tussen verschillende secties, zodat gebruikers van deze software niet met een onleesbare muur van tekst blijven zitten.

### Koppen

Koppen maken het voor schermlezers gemakkelijker om op de juiste manier door een pagina te navigeren door een hiërarchie op te geven waar doorheen kan worden gesprongen als een inhoudsopgave.

{{ figure_markup(
  caption="Mobiele sites die de Lighthouse-audit doorstaan voor correct geordende koppen.",
  content="58,72%",
  classes="big-number",
  sheets_gid="580400436",
  sql_file="lighthouse_a11y_audits.sql"
) }}

Uit onze audits bleek dat 58,72% van de gecontroleerde sites de <a hreflang="en" href="https://web.dev/heading-order/">test voor correct geordende koppen</a> doorstaat die geen niveaus overslaan. Deze koppen geven de semantische structuur van de pagina weer. Veel gebruikers van schermlezers navigeren op een pagina door de koppen, dus als ze in de juiste volgorde staan (oplopend zonder sprongen), zullen gebruikers van ondersteunende technologie de beste ervaring hebben. Het is vermeldenswaard dat we alleen pagina's controleren waar de kans groter is dat deze regels worden gevolgd; startpagina's volgen deze regel vaker dan interne pagina's.

### Skip-links

Met Skip-links kan een gebruiker door interactieve inhoud zoals een navigatiesysteem gaan en naar een andere bestemming gaan, meestal de hoofdinhoud van de pagina. Ze zijn doorgaans de eerste link op een pagina en kunnen persistent zijn in de gebruikersinterface of zichtbaar verborgen zijn totdat ze toetsenbordfocus hebben. Dit voorkomt dat toetsenbordgebruikers mogelijk door een vreemd aantal elementen moeten bladeren om bij de inhoud te komen die ze proberen te openen.

Skip-links worden beschouwd als een bypass voor een blok. Uit de 2020-auditgegevens van Lighthouse bleek dat 93,90% van de sites de test <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/bypass-blocks.html">bypass block</a> doorstaat, wat betekent dat ze een `<header>`, skip-link of mijlpaalregio overslaan zodat gebruikers repetitieve inhoud kunnen overslaan.

### Tabellen

Tabellen zijn een efficiënte manier om gegevens weer te geven met twee assen van relaties, waardoor ze bruikbaar zijn voor vergelijkingen. Gebruikers van ondersteunende technologie vertrouwen op specifieke toegankelijkheidsfuncties die zijn ontworpen om door correct gestructureerde tabellen te navigeren om de beste ervaring te hebben met navigeren en ermee omgaan. Zonder geldige semantische tabelopmaak kunnen deze functies niet worden gebruikt.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Meting</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobiel</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Tabellen met bijschriften</td>
        <td class="numeric">4,98%</td>
        <td class="numeric">4,20%</td>
      </tr>
      <tr>
        <td>Presentatietabellen</td>
        <td class="numeric">0,64%</td>
        <td class="numeric">0,49%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Toegankelijkheidsgegevens voor tabellen.",
      sheets_gid="378681963",
      sql_file="table_stats.sql"
    ) }}
  </figcaption>
</figure>

#### Tabelbijschriften

Tabelbijschriften fungeren als een label voor de tabel die context levert voor de tabelgegevens. Slechts 4,98% van de desktopsites en 4,20% van de mobiele sites met een tabel gebruikte een tabelbijschrift.

#### Presentatietabellen

We hebben het geluk dat we in 2020 zoveel flexibele CSS-methodologieën hebben die vloeiende responsieve lay-outs mogelijk maken. Echter, vele jaren geleden, voor Flexbox en CSS Grid, gebruikten ontwikkelaars vaak tabellen voor lay-out. Helaas zijn er door een combinatie van legacy-websites en legacy-ontwikkelingstechnieken nog steeds sites waar tabellen worden gebruikt voor de lay-out.

Als er een absolute behoefte is om naar deze techniek te reiken, moet de rol van presentatie op de tabel worden toegepast, zodat ondersteunende technologie de tabelsemantiek negeert. We ontdekten dat 0,63% van de desktoppagina's en 0,49% van de mobiele pagina's een tabel had met een presentatierol. Het is moeilijk om te weten of dit goed of slecht is. Het zou erop kunnen wijzen dat er niet veel tabellen worden gebruikt voor presentatiedoeleinden, maar het is zeer waarschijnlijk dat tabellen die voor lay-out worden gebruikt, gewoon deze noodzakelijke rol missen.

### Documenttitels

Beschrijvende paginatitels zijn handig voor de context wanneer u met ondersteunende technologie tussen pagina's, tabbladen en vensters wisselt, omdat de wijziging in de context zal worden aangekondigd. Uit onze gegevens blijkt dat 98,98% van de sites een titel heeft, wat een hoopvolle statistiek is. Het spreekt echter vanzelf dat startpagina's een hoger aantal paginatitels kunnen hebben dan minder belangrijke routes.

### Tabindex

Tabindex bepaalt de volgorde waarin de focus over de pagina wordt verplaatst. Interactieve inhoud zoals knoppen, links en formulierelementen hebben een natuurlijke `tabindex`-waarde van `0`. Evenzo hebben aangepaste elementen en widgets die bedoeld zijn om interactief te zijn en in de toetsenbordfocusvolgorde een expliciet toegewezen `tabindex="0"` nodig hebben. Als een niet-interactief element focusbaar zou moeten zijn, maar niet in de tabvolgorde van het toetsenbord, kan een `tabindex` waarde van `-1` worden gebruikt, waardoor de focus programmatisch kan worden ingesteld met JavaScript.

De focusvolgorde van de pagina moet altijd worden bepaald door de documentstroom. Het instellen van de `tabindex` op een positief geheel getal overschrijft de natuurlijke volgorde van de pagina en wordt als een slechte gewoonte beschouwd. Het respecteren van de natuurlijke volgorde van de pagina leidt over het algemeen tot een meer toegankelijke ervaring. We ontdekten dat 5% van de desktopsites en 4,34% van de mobiele sites positieve gehele getallen gebruikte als indexwaarden voor tabbladen.

## Ondersteunende technologieën op internet

Mensen met verschillende handicaps gebruiken verschillende ondersteunende technologieën om hen te helpen internet te ervaren. Het artikel <a hreflang="en" href="https://www.w3.org/WAI/people-use-web/tools-techniques/">Tools and Techniques</a> artikel van het Web Accessibility Initiative (WAI) van het W3C behandelt hoe gebruikers kunnen zien, begrijpen en interactie hebben met het web met behulp van verschillende ondersteunende technologieën.

Enkele ondersteunende technologieën voor internet zijn:

- Schermlezers
- Spraakbesturing
- Schermvergroters
- Invoerapparaten (zoals aanwijzers en schakelapparaten)

Schermlezers presenteren inhoud hoorbaar, meestal doordat de computer de inhoud in de interface uitspreekt of aankondigt terwijl de gebruiker navigeert en interactie heeft. Hierdoor kunnen blinde, slechtziende en andere gehandicapte en niet-gehandicapte gebruikers de inhoud consumeren zonder afhankelijk te zijn van de visuele aanwijzingen die op het scherm worden weergegeven.

### Inleiding tot ARIA

In 2014 publiceerde de WAI de <span lang="en">Accessible Rich Internet Applications</span>, of ARIA. Ze <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/aria/">beschrijven ARIA als</a>:

> "WAI-ARIA, de <span lang="en">Accessible Rich Internet Applications Suite</span>, definieert een manier om webinhoud en webapps toegankelijker te maken voor mensen met een handicap. Het helpt vooral bij dynamische inhoud en geavanceerde bedieningselementen voor de gebruikersinterface die zijn ontwikkeld met Ajax, HTML, JavaScript en aanverwante technologieën."

De meeste ontwikkelaars beschouwen ARIA als attributen die we aan HTML kunnen toevoegen om het bruikbaarder te maken voor gebruikers van schermlezers, maar het was nooit bedoeld om onjuiste opmaak en native HTML-oplossingen goed te maken. ARIA heeft veel nuances die, wanneer ze verkeerd worden begrepen, nieuwe toegankelijkheidsbarrières kunnen introduceren. Bovendien hebben verschillende schermlezers verschillende beperkingen met betrekking tot ARIA-ondersteuning.

### De vijf regels van ARIA

Er zijn <a hreflang="en" href="https://www.w3.org/TR/using-aria/">vijf regels van ARIA</a> die we moeten begrijpen voordat we gebruik kunnen maken van deze krachtige hulpmiddelen-set. Dit is geen officiële specificatie met vereiste conformiteit, maar een gids voor het begrijpen en correct implementeren van ARIA.

1. Als u een native HTML-element <a hreflang="en" href="https://www.w3.org/TR/html51/">HTML 5.1</a> of attribuut kunt gebruiken met de semantiek en het gedrag dat u al heeft ingebouwd, in plaats van een element opnieuw te gebruiken en een ARIA toe te voegen rol, staat of eigendom om het toegankelijk te maken, doe dat dan.
2. Verander de native semantiek niet, tenzij het echt moet.
3. Alle interactieve ARIA-bedieningselementen moeten met het toetsenbord kunnen worden gebruikt.
4. Gebruik `role="presentatie"` of `aria-hidden="true"`niet op een focusseerbaar element.
5. Alle interactieve elementen moeten een toegankelijke naam hebben.

### ARIA-rollen

Een van de meest gebruikelijke manieren waarop ARIA wordt gebruikt, is door de rol van een element expliciet te definiëren, waardoor het doel ervan wordt doorgegeven aan ondersteunende technologie.

HTML5 introduceerde veel nieuwe native elementen, die allemaal <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#implicit_semantics">impliciete semantiek</a> hebben, inclusief rollen. Het element `<nav>` heeft bijvoorbeeld een impliciete `role="navigation"` en deze rol hoeft niet expliciet te worden toegevoegd om informatie over het doel over te brengen aan ondersteunende technologie. Momenteel heeft 64,54% van de desktoppagina's ten minste één instantie van een ARIA-`role`-attribuut. De mediaan-site heeft 2 instanties van het kenmerk `role`.

{{ figure_markup(
  image="common-aria-roles.png",
  caption="Top tien meest voorkomende ARIA-rollen.",
  description="Staafdiagram met de 10 meest voorkomende ARIA-rollen op desktop en mobiel met `button` op 25,2% voor desktop en 24,5% voor mobiel, `navigation` op respectievelijk 22,1% en 21,8, `dialog` op 19,0% en 18,2%, `search` op 17,9% en 17,6%, `presentation` op 17,8% en 16,3%, `main` op 16,0% voor beide, `banner` op 14,8% voor beide, `contentinfo` op 12,1% en 11,9%, `img` op 8,5% en 8,0%, en `tablist` op 7,0% en 6,6%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSjkB_XAYiwkYrMuoXp44mdqMGJVDUkTr_48ELozY72Mdv3OlxeWV9ysbDY9bs6hA7LnJTrHar9aZlM/pubchart?oid=2002759694&format=interactive",
  sheets_gid="39937976",
  sql_file="common_aria_role.sql"
  )
}}

#### Gebruik gewoon een knop!

We ontdekten dat 25,20% van de desktopsites en 24,50% van de mobiele sites startpagina's had met ten minste één element met een expliciet toegewezen `role="button"`. Dit suggereert dat ongeveer een kwart van de websites de functie `button` op elementen gebruikt om hun semantiek te wijzigen, met uitzondering van knoppen waaraan expliciet de `button`-rol is toegewezen, die overbodig maar ongevaarlijk is.

Als niet-interactieve elementen zoals `<div>`s en `<span>`s deze rol hebben gekregen, is de kans groot dat een of meer van de 5 regels van ARIA zijn overtreden.

Het is vrij waarschijnlijk dat een native `<button>`-element een betere keuze zou zijn, volgens de eerste regel van ARIA. Het is ook mogelijk dat de rol is toegevoegd, maar de verwachte toetsenbordondersteuning is niet geleverd, wat de derde regel van ARIA zou overtreden en in strijd zou zijn met <a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/keyboard-operation-keyboard-operable.html">WCAG 2.1.1, Keyboard</a>.

{{ figure_markup(
  caption='Mobiele sites die `role="button"` toewijzen aan `<div>` of een `<span>`',
  content="8,28%",
  classes="big-number",
  sheets_gid="1693851651",
  sql_file="div_span_with_button_or_link_role.sql"
) }}

We ontdekten dat 8,27% van de desktoppagina's en 8,28% van de mobiele pagina's ten minste één keer een `<div>` of een `<span>` element met `role="button"` expliciet had gedefinieerd. Deze handeling van het toevoegen van ARIA-rollen, of een <a hreflang="en" href="https://adrianroselli.com/2020/02/role-up.html">role-up</a>", is minder ideaal dan het gebruik van het juiste native HTML-element.

We ontdekten dat 15,50% van de desktoppagina's en 14,62% van de mobiele pagina's ten minste één ankerelement bevatten met `role="button"`. Als een rol is toegepast op een element waarvan de impliciete rol moet worden gerespecteerd, zoals het geven van een `role="button"` aan een link (die een impliciete `role="link"` heeft), zou dit de tweede regel van ARIA breken. Het zou ook in strijd zijn met <a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/keyboard-operation-keyboard-operable.html">WCAG 2.1.1, Keyboard</a> als het juiste toetsenbordgedrag niet is geïmplementeerd (links worden niet geactiveerd met de spatiebalk, terwijl knoppen dat wel zijn).

Nogmaals, in de overgrote meerderheid van deze gevallen zou een beter patroon dan het expliciet definiëren van `role="button"` voor het element in kwestie zijn om gebruik te maken van het native HTML `<button>`-element, aangezien dit wordt geleverd met de verwachte semantiek en gedrag.

#### Navigatie

We ontdekten dat 22,06% van de desktoppagina's en 21,76% van de mobiele pagina's ten minste één element heeft met `role="navigation"`, wat een belangrijke rol is. Volgens de eerste regel van ARIA zouden ontwikkelaars, in plaats van deze rol aan een element toe te voegen, het HTML5 `<nav>`-element moeten gebruiken dat impliciet met de juiste semantiek wordt geleverd. Het is mogelijk dat deze rol expliciet is toegevoegd aan het `<nav>`-element, wat geen toegankelijkheidsprobleem zou zijn, hoewel het overtollig is.

#### Dialoogmodalen

Er zijn veel potentiële toegankelijkheidsbelemmeringen verbonden aan dialoogmodalen. We raden aan om het artikel van [Scott O'Hara](https://twitter.com/scottohara) <a hreflang="en" href="https://www.scottohara.me/blog/2019/03/05/open-dialog.html">Having an Open Dialog</a>te lezen voor meer context.

We zijn verheugd te kunnen melden dat 19,01% van de desktoppagina's en 18,21% van de mobiele pagina's minstens één keer `role="dialog"` heeft, wat een stijging is van ongeveer 8% in 2019. Het is vermeldenswaard dat een deel van de toename waarschijnlijk te wijten is aan veranderingen in de manier waarop deze statistiek werd gemeten. Dit zou ook kunnen suggereren dat meer ontwikkelaars toegankelijkheid overwegen bij het bouwen van dialogen en mogelijk dat frameworks en bijbehorende pakketten mogelijk ook meer toegankelijke dialoogpatronen implementeren. Het toegankelijk maken van een dialoogmodaal vereist echter veel meer dan het gebruik van de `dialog` rol. Focusbeheer, goede toetsenbordondersteuning en belichting van de schermlezer moeten allemaal worden aangepakt.

#### Tabbladen

Tabbladen zijn een veelgebruikte interface-widget, maar vormen voor veel ontwikkelaars een uitdaging om toegankelijk te maken. Een algemeen patroon voor toegankelijke implementatie komt van de <a hreflang="en" href="https://www.w3.org/TR/wai-aria-practices-1.1/#tabpanel"><span lang="en">WAI-ARIA Authoring Practices Design Patterns</span></a>. Houd er rekening mee dat het ARIA Authoring Practices-document geen specificatie is en bedoeld is om geïdealiseerde ARIA-constructies te tonen. Ze mogen niet in productie worden gebruikt zonder testen met uw gebruikers.

In dit patroon heeft een bovenliggende container een `role="tablist"` met onderliggende elementen die een `role="tab"` hebben. Deze tabbladen zijn gekoppeld aan elementen die een `role="tabpanel"` hebben, en bevatten de inhoud voor dat tabblad.

{{ figure_markup(
  image="role-tab-list.png",
  caption='Element met de rol `tablist` (<a hreflang="en" href="https://www.w3.org/TR/wai-aria-practices-1.1/examples/tabs/tabs-1/tabs.html">Bron: W3C</a>)',
  description='Schermafbeelding met een voorbeeld van een tablijst (`role="tablist"`) die drie tabbladen bevat. Alle drie de tabbladen zijn gemarkeerd.',
  width=348,
  height=337
) }}

{{ figure_markup(
  image="role-tab.png",
  caption='Element met de rol `tab`. (<a hreflang="en" href="https://www.w3.org/TR/wai-aria-practices-1.1/examples/tabs/tabs-1/tabs.html">Bron: W3C</a>)',
  description='Schermafbeelding met een voorbeeldtabblad (`role="tab"`) waar slechts één tabblad is gemarkeerd.',
  width=346,
  height=335
) }}

{{ figure_markup(
  image="role-tab-panel.png",
  caption='Element met de rol `tabpanel`. (<a hreflang="en" href="https://www.w3.org/TR/wai-aria-practices-1.1/examples/tabs/tabs-1/tabs.html">Bron: W3C</a>)',
  description='Schermafbeelding met een voorbeeld van een tabpanel (`role=" tabpanel"`) waar de inhoud van één tabblad is gemarkeerd.',
  width=346,
  height=335
) }}

Voor desktoppagina's heeft 7,00% ten minste één element met een `role="tablist"`, terwijl er slechts 5,79% van de pagina's elementen heeft met een `role="tab"` en 5,46% van de pagina's elementen met een `role="tabpanel"`. Dit suggereert dat het patroon mogelijk slechts gedeeltelijk wordt geïmplementeerd. Zelfs als er een dynamische weergave in het spel is voor sommige van de tab/tabpanel-elementen, zou het momenteel zichtbare of eerste tab/tabpanel theoretisch in de DOM staan bij het laden van de pagina.

#### Presentatie

Wanneer een element een `role="presentation"` heeft gekregen, wordt de semantiek verwijderd, zowel voor het element waaraan het is toegewezen als voor de vereiste onderliggende elementen. Tabellen en lijsten hebben bijvoorbeeld beide vereiste kinderen, dus als de ouder een `role="presentation"` heeft, loopt dit in wezen over naar de onderliggende elementen, waarvan ook de semantiek wordt verwijderd. Het verwijderen van de semantiek van een element betekent dat het niet langer dat element is, in welke hoedanigheid dan ook, behalve zijn visuele uiterlijk. Een lijst met een `role="presentation"` zal bijvoorbeeld geen informatie meer verstrekken aan een schermlezer over de lijststructuur.

Dit kenmerk wordt vaak gebruikt voor `<table>`-elementen die zijn gebruikt voor lay-out in plaats van voor tabelgegevens. We raden af om tabellen op deze manier te gebruiken. Voor de lay-out hebben we tegenwoordig krachtige CSS-hulpmiddelen, zoals Flexbox en CSS Grid. Over het algemeen zijn er maar weinig gevallen waarin `role="presentation"` met name nuttig is voor gebruikers van ondersteunende technologie, gebruik deze rol spaarzaam en bedachtzaam.

### ARIA-attributen

ARIA-attributen kunnen aan HTML-elementen worden toegewezen om de toegankelijkheid van de interface te verbeteren. Met respect voor de eerste regel van ARIA, mogen ze niet worden gebruikt om iets te bereiken dat kan worden gedaan met native HTML.

{{ figure_markup(
  image="most-used-aria-attributes.png",
  caption="Top 10 meest gebruikte `aria` attributen.",
  description="Staafdiagram met de top 10 van `aria`-attributen die worden gebruikt op desktop en mobiel, me `aria-hidden` gebruikt door 48,1% desktopsites en 48,2% mobiele sites, `aria-label` wordt gebruikt door respectievelijk 40,4% en 38,7%, `aria-expanded` met 21,0% en 21,0%, `aria-controls` met 17,4% en 16,9%, `aria-labelledby` met 17,7% en 16,2%, `aria-live` met 16,8% en 15,7%, `aria-haspopup` met 15,9% en 14,0%, `aria-current` met 12,4% en 12,7%, en `aria-describedby` met 11,3% en 10,6%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSjkB_XAYiwkYrMuoXp44mdqMGJVDUkTr_48ELozY72Mdv3OlxeWV9ysbDY9bs6hA7LnJTrHar9aZlM/pubchart?oid=332801232&format=interactive",
  sheets_gid="1154654622",
  sql_file="common_element_attributes.sql"
  )
}}

#### Elementen labelen en beschrijven met ARIA

De toegankelijkheidsboom van de browser heeft een berekeningssysteem dat de toegankelijke naam (als die er is) toewijst aan een besturingselement, widget, groep of herkenningspunt, zodat deze kan worden aangekondigd door ondersteunende technologie. Er is een specificiteitsclassificatie die bepaalt welke waarde wordt toegewezen aan de toegankelijke naam.

De toegankelijke naam kan worden afgeleid van de inhoud van een element (zoals knoptekst), een attribuut (zoals een afbeelding `alt`-tekstwaarde) of een bijbehorend element (zoals een programmatisch gekoppeld label voor een formulierbesturingselement). Voor meer informatie over toegankelijke namen, zie het artikel van Léonie Watson, <a hreflang="en" href="https://developer.paciellogroup.com/blog/2017/04/what-is-an-accessible-name/">Wat is een toegankelijke naam?</a>

We kunnen ARIA ook gebruiken om toegankelijke namen voor elementen op te geven. Er zijn twee ARIA-attributen die dit bewerkstelligen, <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Techniques/aria/ARIA14.html">`aria-label`</a>, <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Techniques/aria/ARIA16.html">`aria-labelledby`</a>. Elk van deze kenmerken zal de berekening van de toegankelijke naam "winnen" en de native afgeleide toegankelijke naam overschrijven, dus gebruik ze met de nodige voorzichtigheid en zorg ervoor dat u test met een schermlezer of bekijk de toegankelijkheidsboom om te bevestigen dat de toegankelijke naam is wat werd verwacht. Wanneer u ARIA gebruikt om een element een naam te geven, is het belangrijk om ervoor te zorgen dat de <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/label-in-name.html">WCAG 2.5.3, <span lang="en">Label in Name</span></a> criterium niet geschonden is, dat verwacht dat zichtbare labels ten minste een deel van de toegankelijke naam zijn.

Met het `aria-label`-element kan een ontwikkelaar een tekenreekswaarde opgeven en deze wordt gebruikt voor de toegankelijke naam voor het element. We ontdekten dat 40,44% van de desktoppagina's en 38,72% van de mobiele startpagina's ten minste één element had met het kenmerk `aria-label`, waardoor dit het meest populaire ARIA-kenmerk is voor het verstrekken van toegankelijke namen.

Het `aria-labelledby` attribuut accepteert een `id` referentie als zijn waarde, die het associeert met een ander element in de interface om zijn toegankelijke naam te geven. Het element wordt "gelabeld door" dit andere element dat zijn toegankelijke naam geeft. We ontdekten dat 17,73% van de desktoppagina's en 16,21% van de mobiele pagina's ten minste één element had met het kenmerk `aria-labelledby`.

Nogmaals, de eerste regel van ARIA moet worden gerespecteerd. Als het element zijn toegankelijke naam kan ontlenen zonder ARIA nodig te hebben, verdient dit de voorkeur. Een `<button>`, dat geen grafisch element is, zou bijvoorbeeld zijn toegankelijke naam uit zijn tekst inhoud moeten halen in plaats van een ARIA-attribuut. Formulierelementen moeten waar mogelijk hun toegankelijke namen ontlenen aan correct geassocieerde `<label>`-elementen.

Het <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Techniques/aria/ARIA1.html">`aria-describedby`</a> attribuut kan gebruikt worden in gevallen waar een meer robuuste beschrijving nodig is voor een element. Het accepteert ook een `id`-referentie als zijn waarde om verbinding te maken met beschrijvende tekst die elders in de interface voorkomt. Het bevat niet de toegankelijke naam, het moet worden gebruikt in combinatie met een toegankelijke naam als aanvulling, niet als vervanging. We ontdekten dat 11,31% van de desktoppagina's en 10,56% van de mobiele pagina's ten minste één element had met het kenmerk `aria-describedby`.

**Leuk feit!** We hebben 3.200 websites gevonden met het attribuut **`aria-labeledby`**, wat een verkeerde spelling is van het attribuut `aria-labelledby`! Zorg ervoor dat u die geautomatiseerde controles uitvoert om deze gemakkelijk te vermijden fouten op te sporen.

#### Inhoud verbergen

Er zijn verschillende manieren om ervoor te zorgen dat ondersteunende technologie geen inhoud ontdekt. We kunnen gebruik maken van CSS `display:none` of `visibility:hidden` om de elementen uit de toegankelijkheidsstructuur weg te laten. Als een auteur inhoud specifiek voor schermlezers wil verbergen, kunnen ze `aria-hidden="true"` gebruiken. We ontdekten dat 48,09% van de desktoppagina's en 48,23% van de mobiele pagina's ten minste één instantie van een element met het attribuut `aria-hidden` had.

Deze technieken zijn vooral nuttig wanneer iets in de visuele interface overbodig of niet nuttig is voor gebruikers van ondersteunende technologie. Het moet zorgvuldig worden gebruikt, omdat het essentieel is om alle gebruikers pariteit te bieden. Gebruik het niet om inhoud over te slaan die moeilijk toegankelijk is.

Het verbergen en weergeven van inhoud is een veel voorkomend patroon in moderne interfaces en het kan nuttig zijn om de gebruikersinterface voor iedereen overzichtelijk te houden. Er zijn twee ARIA-attributen die nuttige toevoegingen zijn aan dit openbaarmakingspatroon. Het attribuut `aria-expanded` moet een `true`/`false` waarde hebben die wisselt afhankelijk van of de onthulde inhoud wordt weergegeven of niet. Bovendien kan het attribuut `aria-controls` worden geassocieerd met een `id` op de onthulde inhoud, waardoor een programmatische relatie ontstaat tussen de activerende controle (die een knop zou moeten zijn) en de inhoud die wordt weergegeven.

We ontdekten dat 20,98% van de desktoppagina's en 21,00% van de mobiele pagina's ten minste één element had met het kenmerk `aria-expanded` en 17,38% van de desktoppagina's en 16,94% van de mobiele pagina's ten minste één element met de `aria-controls` attribuut. Dit suggereert dat ongeveer een vijfde van de websites mogelijk ten minste gedeeltelijk toegankelijke widgets voor openbaarmaking implementeert. Merk op dat het attribuut `aria-controls` eerder als beste praktijk dan als essentieel wordt beschouwd voor het openbaarmakingspatroon, omdat ondersteuning voor schermlezers nog niet ideaal is.

#### Alleen tekst voor schermlezer

Een veelgebruikte techniek die ontwikkelaars vaak gebruiken om aanvullende informatie voor gebruikers van schermlezers te leveren, is door CSS te gebruiken om een tekstpassage visueel te verbergen, zodat deze wordt aangekondigd door een schermlezer, maar niet visueel in de interface. Aangezien `display: none` en `visibility: hidden` beide voorkomen dat inhoud aanwezig is in de toegankelijkheidsboom, is er een algemene "hack" met een stuk CSS-code die dit zal bewerkstelligen. De meest voorkomende CSS-klassenamen voor dit codefragment (zowel volgens afspraak als in alle bibliotheken zoals bootstrap) zijn `sr-only` en `visually-hidden`. We ontdekten dat 13,31% van de desktoppagina's en 12,37% van de mobiele pagina's een of beide CSS-klassenamen had.

#### Dynamisch weergegeven inhoud aankondigen

Een van de grootste uitdagingen op het gebied van toegankelijkheid in moderne webontwikkeling is het omgaan met dynamisch weergegeven inhoud die overal in interfaces aanwezig is. De aanwezigheid van nieuwe of bijgewerkte zaken in de DOM moet vaak worden gecommuniceerd naar schermlezers. Er moet worden nagedacht over welke updates moeten worden overgebracht. Formuliervalidatiefouten moeten bijvoorbeeld worden overgebracht, terwijl een lui geladen afbeelding dat misschien niet is. Er moet ook iets worden gedaan op een manier die niet storend is voor een lopende taak.

Een hulpmidel die we hierbij moeten helpen, zijn ARIA live-regio's. Live-regio's stellen ons in staat te luisteren naar wijzigingen in de DOM, zodat de bijgewerkte inhoud kan worden aangekondigd door een schermlezer. Typisch wordt het attribuut `aria-live` op zijn eigen containerelement geplaatst dat al in de DOM aanwezig is, in plaats van een element dat dynamisch wordt weergegeven. Het is belangrijk om een speciaal knooppunt in de DOM te bepalen dat geen kans heeft om dynamisch te worden gemanipuleerd door andere factoren voor de live-regio, zodat de aankondigingen betrouwbaar zijn. Wanneer elementen in deze container dynamisch worden weergegeven of bijgewerkt (bijvoorbeeld statusupdates of melding dat een formulier niet succesvol is ingediend), worden de wijzigingen aangekondigd.

We ontdekten dat 16,84% van de desktoppagina's en 15,67% van de mobiele pagina's live-regio's heeft. Dit attribuut heeft drie mogelijke waarden: `polite`, `assertive`, en `off`. Meestal wordt de `polite` waarde gebruikt, deels omdat dit de standaardwaarde is, maar ook omdat de aankondiging van de dynamische inhoud pas zal plaatsvinden als de gebruiker stopt met communiceren met de pagina. In veel gevallen is dit de gewenste gebruikerservaring, in plaats van hun invoer te onderbreken. Als een statusupdate kritisch genoeg is, gebruik dan `assertive` en het verstoort de huidige spraakwachtrij van de schermlezer. Als het is ingesteld op `off`, zal de aankondiging niet plaatsvinden. Het is belangrijk dat de natuurlijke ervaring en flow van de schermlezer worden gerespecteerd en dat de `assertive` aankondigingen worden gereserveerd voor extreme gevallen en niet worden gebruikt voor zaken als marketingaankondigingen.

## Toegankelijkheid van formulierbesturingselementen

Formulieren zijn een van de belangrijkste dingen om goed te doen in termen van toegankelijkheid. Succesvolle indiening van formulierinvoer betekent dat gebruikers de kernactiviteiten van websites en applicaties kunnen uitvoeren. Als een registratiestroom bijvoorbeeld niet toegankelijk is, kan een gehandicapte gebruiker helemaal nooit toegang krijgen tot de site.

Het is belangrijk om te onthouden dat digitale toegankelijkheid een burgerrecht is en dat alle mensen hetzelfde recht hebben op toegang tot informatie en op dezelfde functies op internet. Als een gehandicapte gebruiker wordt belet kerntaken op het web uit te voeren of toegang te krijgen tot informatie, met name voor taken als het indienen van formulieren voor overheidsdiensten en andere essentiële activiteiten, is er een duidelijk argument voor discriminatie in zowel de private als de publieke sector.

### Formulier validatie

Het is erg belangrijk dat elke afhandeling van formulierfouten wordt doorgegeven aan ondersteunende technologie. Afhankelijk van de validatie-implementatie zijn er verschillende technieken om hiermee om te gaan. Het artikel van Web AIM <a hreflang="en" href="https://webaim.org/techniques/formvalidation/"><span lang="en">Usable and Accessible Form Validation and Error Recovery</span></a> is een geweldige bron voor meer informatie over verschillende strategieën voor toegankelijke formuliervalidatie.

Als een formulierelement vereist is, moet dit ook worden gecommuniceerd naar ondersteunende technologie. Voor native HTML-formulierelementen kan het [`required` attribuut](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/required) worden gebruikt en voor aangepaste elementen kan het [`aria-required`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-required_attribute) attribuut nodig zijn. Als er een probleem is met het indienen van een formulier, moet dit worden doorgegeven aan ondersteunende technologie.

### Formulierlabels

Formulierlabels moeten zichtbaar en persistent zijn in de gebruikersinterface en een beschrijving geven van de invoer waar ze om vragen. Het is een goed idee om unieke vereisten, zoals opmaak of speciale tekens, in het zichtbare label te plaatsen, zodat fouten zoveel mogelijk kunnen worden voorkomen.

{{ figure_markup(
  caption='Sites waarop al hun labels correct zijn gekoppeld',
  content="26,51%",
  classes="big-number",
  sheets_gid="1067352317",
  sql_file="form_labels.sql"
) }}

Het is belangrijk ervoor te zorgen dat formulierlabels een programmatische koppeling hebben met hun respectievelijke invoer. Het is niet voldoende om het label alleen visueel weer te geven. We ontdekten dat slechts 26,51% van de sites al hun labels correct heeft gekoppeld aan hun respectievelijke invoer (bereikt met een `for`/`id` relatie of invoer genest in labels).

Groepen formulierbesturingen zoals een set van radio-inputs of selectievakjes moeten worden genest in een `<fieldset>`-element en een groepslabel krijgen via het `<legend>`-element binnen het `<fieldset>`. De afzonderlijke besturingselementen moeten nog steeds programmatisch worden gekoppeld aan hun respectieve zichtbare labels.

### plaatsaanduidingstekst

Vertrouw niet op plaatsaanduidingstekst om als label voor een invoer te dienen. Hoewel sommige schermlezers nu de mogelijkheid hebben om de toegankelijke naam te bepalen uit plaatsaanduidingstekst, kunnen gebruikers met cognitieve handicaps negatief worden beïnvloed door te vertrouwen op plaatsaanduidingstekst, omdat zodra een gebruiker de invoer begint te typen, de plaatsaanduiding verdwijnt en de context weg is. Gebruikers van spraakbesturing hebben meer dan een tijdelijke aanduiding nodig om op betrouwbare wijze een element in de DOM te targeten. Bovendien voldoet plaatsaanduidingstekst vaak niet aan de vereisten voor kleurcontrast, wat een negatief effect heeft op gebruikers met slechtziendheid.

Van de sites die formulierbesturingselementen met plaatsaanduidingstekst hebben, heeft 73,89% ten minste één instantie waarbij er geen `<label>`-element programmatisch is gekoppeld aan het besturingselement voor desktop en 74,52% voor mobiel.

## Gevolgtrekking

Dit hoofdstuk is passend opgenomen in het gedeelte Gebruikerservaring van deze Almanak. Zoals voorstander van toegankelijkheid [Billy Gregory ooit zei](https://twitter.com/thebillygregory/status/552466012713783297?s=20), "als UX niet naar ALLE gebruikers kijkt, zou het dan niet bekend moeten staan als SOMMIGE gebruikerservaring, of SUX ". Te vaak wordt toegankelijkheidswerk gezien als een toevoeging, een edge case, of zelfs vergelijkbaar met technische schuld en niet de kern van het succes van een website of product zoals het hoort.

Toegankelijkheid is niet de exclusieve verantwoordelijkheid van ontwikkelaars om te implementeren. Het hele productteam en de hele organisatie moeten het als onderdeel van hun verantwoordelijkheid hebben om te slagen. Toegankelijkheidswerk moet naar links in de productcyclus verschuiven, wat betekent dat het moet worden ingebakken in de onderzoeks-, ideevormings- en ontwerpfasen voordat het wordt ontwikkeld.

### Mogelijke toegankelijkheidsverantwoordelijkheden per rol

Deze lijst is niet uitputtend en is bedoeld om aan te moedigen na te denken over hoe alle rollen kunnen samenwerken om toegankelijke websites en applicaties te realiseren, zoals een estafette van verantwoording.

**Human Resources/People Operations**
  - Werven en aannemen van mensen met toegankelijkheidsvaardigheden, waaronder mensen met een handicap.
  - Een inclusieve werkomgeving creëren waarin rekening wordt gehouden met de handicaps van mensen.

**UX /Productontwerpers**
  - Overwegen van en praten met mensen met een scala aan handicaps in de onderzoeks- en ideevormingsfase.
  - Annoteren van wireframes met toegankelijkheidsinformatie, zoals de beoogde hiërarchie van koppen, skip-links, alternatieve tekstsuggesties (die ook van copywriters/inhoudsmensen kunnen komen) en alleen tekst voor schermlezers.

**UI ontwerpers**
  - Keuzes voor kleurcontrast, lettertypeselecties, overwegingen tussen spatiëring en regelhoogte.
  - Overwegingen bij animaties (bepalen of ze nodig zijn, statische items aanleveren voor [`prefers-reduced-motion`](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion) scenario's, het ontwerpen van pauze/stop-mechanismen).

**Productmanagers**
  - Prioriteer toegankelijkheidswerk in de roadmap, zodat het geen technische schuld wordt aan het einde van een achterstand.
  - Processen creëren voor teams om hun werk te valideren, zoals toegankelijkheid opnemen in de definitie van gedaan en acceptatiecriteria.

**Ontwikkelaars**
  - Waar mogelijk de voorkeur geven aan native HTML-oplossingen, ARIA begrijpen en wanneer u het moet gebruiken.
  - Al het werk valideren met geautomatiseerde en handmatige tests, waarbij de pull requests van collega's met dezelfde criteria worden beoordeeld.

**Kwaliteitsverzekering**
  - Toegankelijkheidstesten opnemen in hun workflow.
  - Pleiten voor toegankelijkheidsoverwegingen bij het bijdragen aan de kwaliteitsstrategie en acceptatiecriteria van het team.

**Leiderschap/C-Suite**
  - Werknemers bandbreedte geven om te leren en hun vaardigheden op het gebied van toegankelijkheid te vergroten en vakmensen aan te nemen met expertise en geleefde ervaringen.
  - Toegankelijkheid als kern beschouwen voor de productresultaten en excellentie op het gebied van toegankelijkheid beschouwen als werk dat gepromoot kan worden.

De technische industrie moet evolueren naar inclusiegedreven ontwikkeling. Hoewel dit enige investering vooraf vereist, is het in de loop van de tijd veel gemakkelijker en waarschijnlijk goedkoper om toegankelijkheid in de hele cyclus in te bouwen, zodat het in het product kan worden ingebakken, in plaats van sites en apps die zonder het in gedachten zijn gemaakt, achteraf aan te passen.

De grootste investering zou moeten komen in de vorm van onderwijs en procesverbeteringen. Zodra een UI-ontwerper de nuances van kleurcontrastvereisten begrijpt, zou het selecteren van een toegankelijk kleurenpalet dezelfde inspanning moeten zijn als een ontoegankelijk palet. Zodra een ontwikkelaar native HTML en ARIA goed begrijpt en wanneer hij bepaalde technieken en hulpmiddelen moet gebruiken, moet de hoeveelheid code die hij schrijft vergelijkbaar zijn.

Als branche wordt het tijd dat we het verhaal erkennen dat wordt verteld door de cijfers in dit hoofdstuk; we zijn falende gehandicapten. We moeten het beter doen, en dit moet komen van een combinatie van top-down leiderschap en investeringen en bottom-up inspanningen om onze praktijken vooruit te helpen en te pleiten voor de behoeften, veiligheid en inclusie van mensen met een handicap die het internet gebruiken.
