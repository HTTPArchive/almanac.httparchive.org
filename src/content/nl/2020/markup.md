---
part_number: I
chapter_number: 3
title: Opmaak
description: Opmaakhoofdstuk van de Web Almanac 2020 met algemene observaties, het gebruik van elementen en attributen, maar ook trivia en trends.
authors: [j9t, catalinred, iandevlin]
j9t_bio: Jens Oliver Meiert is een webontwikkelaar en auteur (<a href="https://leanpub.com/css-optimization-basics"><cite>CSS Optimization Basics</cite></a>, <a href="https://leanpub.com/web-development-glossary"><cite>The Web Development Glossary</cite></a>), die werkt als ingenieur manager bij <a href="https://www.jimdo.com/">Jimdo</a>. Hij is een expert op het gebied van webontwikkeling, waar hij gespecialiseerd is in HTML- en CSS-optimalisatie. Jens draagt bij aan technische standaarden en schrijft regelmatig over zijn werk en onderzoek, met name op zijn website, <a href="https://meiert.com/en/">meiert.com</a>.
catalinred_bio: Catalin Rosu is een front-end ontwikkelaar bij <a href="https://www.caphyon.com/">Caphyon</a> en werkt momenteel aan <a href="https://www.wattspeed.com/">Wattspeed</a>. Hij heeft een passie voor webstandaarden en een scherp oog voor geweldige Gebruikerservaring en gebruikersinterface (UX & UI), dingen die hij <a href="https://twitter.com/catalinred">tweet</a> en waarover hij schrijft op <a href="https://catalin.red/">zijn website</a>.
iandevlin_bio: Ian Devlin is een webontwikkelaar die pleit voor goede, semantische HTML en toegankelijkheid. Hij schreef ooit een boek over <a href="https://www.peachpit.com/store/html5-multimedia-develop-and-design-9780321793935">HTML5 Multimedia</a>, en schrijft sporadisch op <a href="https://iandevlin.com/">zijn website</a> over het web en andere dingen. Momenteel werkt hij als Senior Frontend Engineer bij <a href="https://www.real-digital.de/">real.digital</a> in Duitsland.
reviewers: [zcorpan, matuzo, bkardell]
analysts: [Tiggerito]
translators: [noah-vdv]
discuss: 2039
results: https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/
queries: 03_Markup
featured_quote: We benaderen een bijna volledige acceptatie van levende HTML, snoeien snel onze pagina's van rages, en we zijn snel in het adopteren en mijden van frameworks. En toch zijn er geen tekenen dat we de opties die HTML ons biedt hebben uitgeput.
featured_stat_1: 85,73%
featured_stat_label_1: Percentage pagina's dat het "levende" HTML-doctype gebruikt
featured_stat_2: 30.073
featured_stat_label_2: Aantal niet-standaard <code>h7</code>-elementen
featured_stat_3: 25,24 KB
featured_stat_label_3: Gewicht van het mediaan document
---

## Introductie

Het web is gebouwd op HTML. Zonder HTML zijn er geen webpagina's, geen websites, geen webapps. Niets. Er kunnen misschien platte-tekstdocumenten of XML-bomen in een parallel universum zijn die die specifieke uitdaging aangingen. In dit universum vormt HTML de basis van het gebruikersgerichte web. Er zijn veel standaarden waarop het web steunt, maar HTML is zeker een van de belangrijkste.

Hoe gebruiken we HTML dan, hoe groot is onze basis? In het inleidende gedeelte van het [2019 Opmaak-hoofdstuk](../2019/markup#introduction) suggereerde auteur [Brian Kardell](../2019/contributors#bkardell) dat we het lange tijd niet echt hebben geweten. Er waren enkele kleinere monsters. Er was bijvoorbeeld [het onderzoek van Ian Hickson](https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html) (een van de moderne HTML-ouders) onder een paar anderen, maar tot vorig jaar misten we veel inzicht in hoe wij als ontwikkelaars, als auteurs, HTML gebruiken. In 2019 hadden we zowel [het werk van Catalin Rosu](https://www.advancedwebranking.com/html/) (een van de co-auteurs van dit hoofdstuk) als de 2019-editie van de Web Almanac om ons weer een beter beeld te geven van HTML in de praktijk.

De analyse van vorig jaar was gebaseerd op 5,8 miljoen pagina's, waarvan 4,4 miljoen op desktop en 5,3 miljoen op mobiel. Dit jaar hebben we 7,5 miljoen pagina's geanalyseerd, waarvan 5,6 miljoen op desktopcomputers en 6,3 miljoen op mobiele apparaten, met behulp van de [laatste gegevens](./methodology#websites) op de websites die gebruikers in 2020 bezoeken. We maken enkele vergelijkingen met vorig jaar, maar net zoals we hebben geprobeerd om aanvullende statistieken te analyseren voor nieuwe inzichten, hebben we ook geprobeerd onze eigen persoonlijkheden en perspectieven door te geven in het hoofdstuk.

<p class="note">
  In dit Opmaak-hoofdstuk concentreren we ons bijna uitsluitend op HTML, in plaats van SVG of MathML, die ook als opmaaktalen worden beschouwd. Tenzij anders vermeld, verwijzen de statistieken in dit hoofdstuk naar de set mobiele pagina's. Bovendien zijn de gegevens voor alle Web Almanac-hoofdstukken open en beschikbaar. Bekijk <a href="https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/">de resultaten</a> en <a href="https://discuss.httparchive.org/t/2039">deel uw observaties</a> met de community!
</p>

## Algemeen

In dit gedeelte behandelen we de aspecten van een hoger niveau van HTML, zoals documenttypen, de grootte van documenten en het gebruik van opmerkingen en scripts. "Living HTML" is springlevend!

### Doctypes

{{ figure_markup(
  caption="Percentage pagina's met een doctype.",
  content="96,82%",
  classes="big-number",
  sheets_gid="1981441894",
  sql_file="summary_pages_by_device_and_doctype.sql"
) }}

96,82% van de pagina's geeft een [_doctype_](https://developer.mozilla.org/en-US/docs/Glossary/Doctype) aan. HTML-documenten waarin wordt verklaard dat een doctype om historische redenen nuttig is, "om te voorkomen dat de modus voor eigenaardigheden in browsers wordt geactiveerd", zoals [Ian Hickson schreef in 2009](https://lists.w3.org/Archives/Public/public-html-comments/2009Jul/0020.html). Wat zijn de meest populaire waarden?

<figure markdown>
| Doctype | Pagina's | Percentage |
|---|---|---|
| HTML ("HTML5") | 5.441.815 | 85,73% |
| XHTML 1.0 Transitioneel | 382.322 | 6,02% |
| XHTML 1.0 Strikt | 107.351 | 1,69% |
| HTML 4.01 Transitioneel | 54.379 | 0,86% |
| HTML 4.01 Transitioneel ([eigenzinnig](https://hsivonen.fi/doctype/#xml)) | 38.504 | 0,61% |

<figcaption>{{ figure_link(caption="De 5 meest populaire doctypes.", sheets_gid="1981441894", sql_file="summary_pages_by_device_and_doctype.sql") }}</figcaption>
</figure>

Je kunt al zien hoe de aantallen behoorlijk afnemen na XHTML 1.0, voordat je de lange staart ingaat met een paar standaard, sommige esoterische en ook nep-doctypes.

Twee dingen onderscheiden zich van deze resultaten:

1. Bijna 10 jaar na [de aankondiging van levende HTML](https://blog.whatwg.org/html-is-the-new-html5) (ook bekend als "HTML5"), is levende HTML duidelijk de norm geworden.
2. Het web vóór levende HTML is nog steeds te zien in de volgende meest populaire doctypes, zoals XHTML 1.0. XHTML. Hoewel hun documenten waarschijnlijk worden afgeleverd als HTML met een MIME-type `text/html`, zijn deze oudere doctypes nog niet dood.

### Document grootte

De documentgrootte van een pagina verwijst naar het aantal HTML-bytes dat via het netwerk wordt overgedragen, inclusief compressie indien ingeschakeld. Aan het einde van de reeks van 6,3 miljoen documenten:

{# TODO(authors, analysts): Revisit the "largest document" stat and interpretation. #}
* 1.110 documenten zijn leeg (0 bytes).
* De gemiddelde documentgrootte is 49,17 KB ([in de meeste gevallen gecomprimeerd](https://w3techs.com/technologies/details/ce-gzipcompression)).
* Het grootste document weegt verreweg 61,19 _MB_ en verdient bijna zijn eigen analyse en hoofdstuk in de Web Almanac.

Hoe is deze situatie in het algemeen dan? Het mediaan document weegt 24,65 KB, en komt [zonder verrassingen](https://httparchive.org/reports/page-weight):

{{ figure_markup(
  image="document-size.png",
  caption="Het aantal HTML-bytes dat via het netwerk wordt overgedragen, inclusief compressie indien ingeschakeld.",
  description="Documentgrootte in bytes per percentiel, met een mediaan document van 25,99 KB op desktop.",
  sheets_gid="2066175354",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=386686971&format=interactive",
  width=600,
  height=371,
  sql_file="summary_pages_by_device_and_percentile.sql"
  )
}}

### Document taal

{# TODO(editors): Link directly to the relevant Accessibility section. #}
We hebben 2.863 verschillende waarden geïdentificeerd voor het `lang`-attribuut op de `html`-starttag (vergelijk dat met de [7.117 gesproken talen](https://www.ethnologue.com/guides/how-many-languages) volgens Ethnologue). Ze lijken bijna allemaal geldig, volgens het hoofdstuk [Toegankelijkheid](./accessibility).

22,36% van alle documenten specificeren geen `lang`-attribuut. De algemeen aanvaarde opvatting is dat [ze zouden moeten](https://www.w3.org/TR/i18n-html-tech-lang/#overall), maar naast het idee dat software uiteindelijk [taal automatisch kan detecteren](https://meiert.com/en/blog/lang/), kan de documenttaal ook worden gespecificeerd [op protocolniveau](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Language). Dit hebben we niet gecontroleerd.

Hier zijn de 10 meest populaire (genormaliseerde) talen in ons voorbeeld. Het is belangrijk op te merken dat het HTTP Archive crawlt vanuit Amerikaanse datacentra met Engelse taalinstellingen, dus het bekijken van de taalpagina's waarin is geschreven, zal scheef naar het Engels gaan. Desalniettemin presenteren we de `lang`-attributen die gezien worden om enige context te geven aan de geanalyseerde sites.

{{ figure_markup(
  image="document-language.png",
  alt="De belangrijkste HTML-`lang` attributen.",
  caption="De top HTML `lang` attributen.",
  description="Staafdiagram met de top 10 `lang` attributen die in onze crawl worden gebruikt, waarbij 22,82% van de desktoppagina's en 22,36% van de mobiele pagina's dit niet instellen, `en` wordt gebruikt op respectievelijk 20,09% en 18,08%, `ja` op 15,17% en 13,27 %, `es` op 4,86% en 4,09%, `pt-br` op 2,65% en 2,84%, `ru` op 2,21% 2,53%, `en-gb` op 2,35% en 2,19%, `de` op 1,50 % en 1,92%, en tenslotte wordt `fr` gebruikt op respectievelijk 1,55% en 1,43%.",
  sheets_gid="2047285366",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1873310240&format=interactive",
  width=600,
  height=371,
  sql_file="pages_almanac_by_device_and_html_lang.sql"
  )
}}

### Opmerkingen

Opmerkingen toevoegen aan code is over het algemeen een goede gewoonte en HTML-opmerkingen zijn er om notities aan HTML-documenten toe te voegen, zonder dat ze door user agents worden weergegeven.

```html
<!-- Dit is een commentaar in HTML -->
```

Hoewel veel pagina's voor productie zijn ontdaan van opmerkingen, ontdekten we dat indexpagina's in het 90e percentiel ongeveer 73 reacties op mobiele apparaten gebruiken, respectievelijk 79 reacties op desktops, terwijl in het 10e percentiel het aantal reacties ongeveer 2 is. Mediaanpagina gebruikt 16 (mobiel) of 17 reacties (desktop).

Ongeveer 89% van de pagina's bevat minstens één HTML-opmerking, terwijl ongeveer 46% een voorwaardelijke opmerking bevat.

#### Voorwaardelijke opmerkingen

```html
<!--[if IE 8]>
  <p>Dit wordt alleen in Internet Explorer 8 weergegeven.</p>
<![endif]-->
```

Het bovenstaande is een niet-standaard voorwaardelijke HTML-opmerking. Hoewel deze in het verleden nuttig zijn gebleken om browserverschillen aan te pakken, zijn ze al enige tijd verleden tijd omdat Microsoft [voorwaardelijke opmerkingen heeft laten vallen](https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/compatibility/hh801214(v=vs.85)) in Internet Explorer 10.

Toch ontdekten we bij de bovenstaande percentielextremen dat webpagina's ongeveer 6 voorwaardelijke opmerkingen in het 90e percentiel gebruiken en 1 opmerking in het 10e percentiel. De meeste pagina's bevatten ze voor helpers zoals html5shiv, selectivizr en respond.js. Hoewel het fatsoenlijke en nog steeds actieve pagina's zijn, is onze conclusie dat veel van hen verouderde CMS-thema's gebruikten.

Voor productie worden HTML-opmerkingen meestal verwijderd door build-tools. Gezien alle bovenstaande tellingen en percentages, en verwijzend naar het gebruik van opmerkingen in het algemeen, veronderstellen we dat veel pagina's worden weergegeven zonder tussenkomst van een HTML-minifier.

### Script gebruik

Zoals getoond in de [Topelementen](#topelementen) sectie hieronder, is het `script` -element het 6e meest gebruikte HTML-element. Voor de doeleinden van dit hoofdstuk waren we geïnteresseerd in de manieren waarop het `script`-element wordt gebruikt op deze miljoenen pagina's uit de dataset.

In totaal bevat ongeveer 2% van de pagina's helemaal geen scripts, zelfs niet met gestructureerde gegevensscripts met het `type="application/ld+json"` attribuut. Gezien het feit dat het tegenwoordig vrij gebruikelijk is dat een pagina ten minste één script voor een analyseoplossing bevat, lijkt dit opmerkelijk.

Aan de andere kant van het spectrum laten de cijfers zien dat ongeveer 97% van de pagina's ten minste één script bevat, inline of extern.

{# TODO(analysts): We still have a problem here with the x-axis label (“Containing”). Can someone help out and look at this? #}
{{ figure_markup(
  image="script-use.png",
  caption="Gebruik van het <code>script</code> -element.",
  description="Percentages pagina's die (geen) scripts bevatten, en scripts zijn in bijna elke vorm op bijna elke pagina aanwezig.",
  sheets_gid="150962402",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1895084382&format=interactive",
  width=600,
  height=371,
  sql_file="pages_almanac_by_device.sql"
  )
}}

Wanneer scripting niet wordt ondersteund of is uitgeschakeld in de browser, helpt het `noscript`-element om een HTML-sectie binnen een pagina toe te voegen. Gezien de bovenstaande scriptnummers waren we ook benieuwd naar het `noscript`-element.

Na de analyse ontdekten we dat ongeveer 49% van de pagina's een `noscript`-element gebruikt. Tegelijkertijd bevatte ongeveer 16% van de `noscript`-elementen een `iframe` met een `src`-waarde die verwijst naar "googletagmanager.com".

Dit lijkt de theorie te bevestigen dat het totale aantal `noscript`-elementen in het wild kan worden beïnvloed door veelgebruikte scripts zoals Google Tag Manager die gebruikers dwingen om een `noscript`-fragment toe te voegen na de `body`-starttag op een pagina.

#### Scripttypen

Welke `type`-attribuutwaarden worden gebruikt met `script`-elementen?

- `text/javascript`: 60,03%
- `application/ld+json`: 1,68%
- `application/json`: 0,41%
- `text/template`: 0,41%
- `text/html` 0,27%

Als het gaat om het laden van [JavaScript-modulescripts](https://jakearchibald.com/2017/es-modules-in-browsers/) met behulp van `type="module"`, ontdekten we dat 0,13% van de `script`-elementen momenteel deze attribuut-waarde-combinatie specificeert. `nomodule` wordt gebruikt door 0,95% van alle geteste pagina's. (Merk op dat de ene statistiek betrekking heeft op elementen, de andere op pagina's.)

36,38% van alle scripts hebben helemaal geen waarden.

## Elementen

In deze sectie ligt de focus op elementen: welke elementen worden gebruikt, hoe vaak, welke elementen zullen waarschijnlijk op een bepaalde pagina verschijnen en hoe de situatie is met betrekking tot aangepaste, verouderde en eigendomsrechtelijke elementen. Is [_divitis_](https://en.wiktionary.org/wiki/divitis) nog steeds een ding? Ja.

### Element diversiteit

Laten we eens kijken hoe divers het gebruik van HTML eigenlijk is: gebruiken auteurs veel verschillende elementen, of kijken we naar een landschap dat relatief weinig elementen gebruikt?

De mediaanwebpagina, zo blijkt, gebruikt 30 verschillende elementen, 587 keer:

{{ figure_markup(
  image="element-diversity-element-types.png",
  caption="Verdeling van het aantal elementtypes per pagina.",
  description="Elementtypen per percentiel, waarbij 90% van de pagina's ten minste 20 verschillende elementen gebruikt.",
  sheets_gid="46490104",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=924238918&format=interactive",
  width=600,
  height=371,
  sql_file="pages_element_count_by_device_and_percentile.sql"
  )
}}

{# Editors note: The caption for the two figures below is intentionally identical. #}

{{ figure_markup(
  image="element-diversity.png",
  caption="Verdeling van het totale aantal elementen per pagina.",
  description="Elementen per percentiel, die laten zien hoe 10% van alle pagina's meer dan 1.665 elementen gebruikt.",
  sheets_gid="46490104",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=680594018&format=interactive",
  width=600,
  height=371,
  sql_file="pages_element_count_by_device_and_percentile.sql"
  )
}}

Gezien het feit dat [levende HTML](https://html.spec.whatwg.org/multipage/) momenteel 112 elementen bevat, kan het 90e percentiel dat niet meer dan 41 elementen gebruikt, erop wijzen dat HTML nog lang niet uitgeput raakt door de meeste documenten. Toch is het moeilijk te interpreteren wat dit werkelijk betekent voor HTML en ons gebruik ervan, aangezien de semantische rijkdom die HTML biedt niet betekent dat elk document alles nodig zou hebben: HTML-elementen zouden per doel (semantiek) moeten worden gebruikt, niet per beschikbaarheid.

Hoe worden deze elementen verdeeld?

{{ figure_markup(
  image="distribution-of-elements-per-page.png",
  caption="Verdeling van het totale aantal elementen per pagina.",
  description="Elementverdeling in een scatterplot, en zelfs voor een getrainde waarnemer is het moeilijk om het te analyseren; interessant is een grote groep van ongeveer 7.500 pagina's met elk ongeveer 250 elementen, waarna steeds minder pagina's op steeds meer elementen terugkomen.",
  sheets_gid="1361520223",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1468756779&format=interactive",
  width=600,
  height=371,
  sql_file="pages_element_count_by_device_and_element_count.sql"
  )
}}

Niet zo veel is veranderd [vergeleken met 2019](../2019/markup#fig-3)!

### Topelementen

In 2019 bevatte het hoofdstuk Opmaak van de Web Almanac de meest gebruikte elementen met betrekking tot [het werk van Ian Hickson in 2005](https://web.archive.org/web/20060203031713/http://code.google.com/webstats/2005-12/elements.html). We vonden dit nuttig en hebben die gegevens nog eens bekeken:

<figure markdown>
| 2005 | 2019 | 2020 |
|---|---|---|
| `title` | `div` | `div` |
| `a` | `a` | `a` |
| `img` | `span` | `span` |
| `meta` | `li` | `li` |
| `br` | `img` | `img` |
| `table` | `script` | `script` |
| `td` | `p` | `p` |
| `tr` | `option` | `link` |
| | | `i` |
| | | `option`|

<figcaption>{{ figure_link(caption="De meest populaire elementen in 2005, 2019 en 2020.", sheets_gid="781932961", sql_file="pages_element_count_by_device_and_element_type_frequency.sql") }}</figcaption>
</figure>

Er veranderde niets in de Top 7, maar het `optie`-element raakte een beetje uit de gratie en zakte van 8 naar 10, waardoor zowel het `link`- als het `i`-element populairder werden. Deze elementen zijn in gebruik toegenomen, mogelijk als gevolg van een toenemend gebruik van [Hints voor bronnen](./resource-hints) (zoals bij prerendering en prefetching), evenals pictogramoplossingen zoals [Font Awesome](https://fontawesome.com/), die de facto misbruik maakt van `i`-elementen om pictogrammen weer te geven.

#### `details` en `summary`

Iets anders waar we nieuwsgierig naar waren, was het gebruik van de [`details` en `summary` elementen](https://html.spec.whatwg.org/multipage/rendering.html#the-details-and-summary-elements) , vooral sinds 2020 [brede ondersteuning](https://caniuse.com/details) bracht. Worden ze gebruikt? Zijn ze aantrekkelijk voor - zelfs populair - onder auteurs? Het blijkt dat slechts 0,39% van alle geteste pagina's ze gebruikt, hoewel het moeilijk is in te schatten of ze allemaal op de juiste manier werden gebruikt in precies de situaties waarin je ze nodig hebt, "populair" is het verkeerde woord.

Hier is een eenvoudig voorbeeld dat het gebruik van een `summary` in een `details`-element laat zien:

```html
<details>
  <summary>Status: operationeel</summary>
  <p>Snelheid: 12m/s</p>
  <p>Richting: Noord</p>
</details>
```

Een tijdje geleden wees Steve Faulkner [erop](https://twitter.com/stevefaulkner/status/806474286592561152) hoe deze twee elementen in het wild onvoldoende werden gebruikt. Zoals je aan het bovenstaande voorbeeld kunt zien, heb je voor elk `details`-element een `summary`-element nodig dat alleen mag worden gebruikt als het [eerste kind](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/summary#Usage_notes) van `details`.

Dienovereenkomstig hebben we gekeken naar het aantal `details` en `summary` elementen en het lijkt erop dat ze nog steeds worden misbruikt. Het aantal `summary`-elementen is hoger op zowel mobiel als desktop, met een verhouding van respectievelijk 1,11 `samenvatting`-elementen voor elk `details`-element op mobiel en 1,19 op desktop:

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >Voorvallen</th>
      </tr>
      <tr>
        <th scope="col">Element</th>
        <th scope="col">Mobiel (0,9%)</th>
        <th scope="col">Desktop (0,22%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>summary</code></td>
        <td>62.992</td>
        <td>43.936</td>
      </tr>
      <tr>
        <td><code>details</code></td>
        <td>56.60</td>
        <td>36.743</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Overname van de <code>details</code>- en <code>summary</code>-elementen.", sheets_gid="1406534257", sql_file="pages_element_count_by_device.sql") }}</figcaption>
</figure>

### Waarschijnlijkheid van elementgebruik

Als we nog eens kijken naar de populariteit van elementen, hoe waarschijnlijk is het dat een bepaald element in de DOM van een pagina wordt gevonden? Zeker, `html`, `head`, `body` zijn op elke pagina aanwezig (ook al zijn [hun tags allemaal optioneel](https://meiert.com/en/blog/optional-html/)), waardoor ze gemeenschappelijke elementen worden, maar welke andere elementen zijn er te vinden?

<figure markdown>
| Element | Waarschijnlijkheid |
|---|---|
| `title` | 99,34% |
| `meta` | 99,00% |
| `div` | 98,42% |
| `a` | 98,32% |
| `link` | 97,79% |
| `script` | 97,73% |
| `img` | 95,83% |
| `span` | 93,98% |
| `p` | 88,71% |
| `ul` | 87,68% |

<figcaption>{{ figure_link(caption="Grote kans om een bepaald element te vinden op pagina's van het Web Almanac 2020-voorbeeld.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

Standaardelementen zijn elementen die deel uitmaken van de HTML-specificatie. Welke vind je echt zelden? In onze steekproef zou dat het volgende naar voren brengen:

<figure markdown>
| Element | Waarschijnlijkheid |
|---|---|
| `dir` | 0,0082% |
| `rp` | 0,0087% |
| `basefont` | 0,0092% |

<figcaption>{{ figure_link(caption="Lage kansen om een bepaald element op pagina's van de steekproef te vinden.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

We nemen deze elementen op om een idee te geven welke elementen mogelijk uit de gratie zijn geraakt. Maar hoewel `dir` en` basefont` voor het laatst werden gespecificeerd in XHTML 1.0 (2000), het zeldzame gebruik van `rp`, [dat al in 1998 werd genoemd](https://www.w3.org/TR/1998/WD-rubya2-4) maar dat ook [nog steeds deel uitmaakt van HTML](https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rp-element), suggereert misschien dat Ruby-opmaak niet erg populair is.

### Aangepaste elementen

De 2019-editie van de Web Almanac behandelde [aangepaste elementen](../2019/markup#custom-elements) door verschillende niet-standaard elementen te bespreken. Dit jaar vonden we het waardevol om aangepaste elementen van naderbij te bekijken. Hoe hebben we deze bepaald? Door te kijken naar [hun definitie](https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements-core-concepts), met name hun gebruik van een koppelteken. Laten we ons concentreren op de topelementen, in dit geval elementen die worden gebruikt op ≥1% van alle URL's in het voorbeeld:

{# TODO(authors, analysts): Clarify occurrences and percentages _of what_. Pages? Elements? #}

<figure markdown>
| Element | Voorvallen | Percentage |
|---|---|---|
| `ym-measure` | 141.156 | 2,22% |
| `wix-image` | 76.969 | 1,21% |
| `rs-module-wrap` | 71.272 | 1,12% |
| `rs-module` | 71.271 | 1,12% |
| `rs-slide` | 70.970 | 1,12% |
| `rs-slides` | 70.993 | 1,12% |
| `rs-sbg-px` | 70.414 | 1,11% |
| `rs-sbg-wrap` | 70.414 | 1,11% |
| `rs-sbg` | 70.413 | 1,11% |
| `rs-progress` | 70.651 | 1,11% |
| `rs-mask-wrap` | 63.871 | 1,01% |
| `rs-loop-wrap` | 63.870 | 1,01% |
| `rs-layer-wrap` | 63.849 | 1,01% |
| `wix-iframe` | 63.590 | 1% |

<figcaption>{{ figure_link(caption="De 14 meest populaire aangepaste elementen.", sheets_gid="770933671", sql_file="pages_element_count_by_device_and_custom_dash_elements.sql") }}</figcaption>
</figure>

Deze elementen zijn afkomstig uit drie bronnen: [Yandex Metrica](https://metrica.yandex.com/about) (`ym-`), een analyseoplossing die we vorig jaar ook hebben gezien; [Slider Revolution](https://www.sliderrevolution.com/) (`rs-`), een WordPress-slider, waarvoor er meer elementen te vinden zijn bovenaan de sample; en [Wix](https://www.wix.com/) (`wix-`), een websitebouwer.

{# TODO(authors, analysts): What do "cases" mean here: pages/elements? And for desktop or mobile? #}

Andere groepen die opvallen zijn onder meer [AMP markup](https://amp.dev/) met `amp-` -elementen zoals `amp-img` (11.700 gevallen), `amp-analytics` (10.256) en `amp-auto-ads` (7.621), evenals [Angular](https://angular.io/) `app`-elementen zoals `app-root` (16.314), `app-footer` (6.745) en `app-header` (5.274).

### Verouderde elementen

Er zijn meer vragen te stellen over het gebruik van HTML, en een daarvan kan betrekking hebben op verouderde elementen, zoals `applet`, `bgsound`, `blink`, `center`, `font`, `frame`, `isindex`, `marquee`, of `spacer`.

In onze mobiele dataset van 6,3 miljoen pagina's bevatten ongeveer 0,9 miljoen pagina's (14,01%) een of meer van deze elementen. Hier is de top 9, die meer dan 10.000 keer wordt gebruikt:

<figure markdown>
| Element | Voorvallen | Pagina's (%) |
|---|---|---|
| `center` | 458.402 | 7,22% |
| `font` | 430.987 | 6,79% |
| `marquee` | 67.781 | 1,07% |
| `nobr` | 31.138 | 0,49% |
| `big` | 27.578 | 0,43% |
| `frame` | 19.363 | 0,31% |
| `frameset` | 19.163 | 0,30% |
| `strike` | 17.438 | 0,27% |
| `noframes` | 15.016 | 0,24% |

<figcaption>{{ figure_link(caption="Verouderde elementen met meer dan 10.000 toepassingen.", sheets_gid="1972617631", sql_file="pages_element_count_by_device_and_obsolete_elements.sql") }}</figcaption>
</figure>

Zelfs `spacer` wordt nog 1.584 keer gebruikt en staat op elke 5.000ste pagina. We weten dat Google al [22 jaar](https://web.archive.org/web/19981202230410/https://www.google.com/) een `center`-element op [hun homepagina](https://www.google.com/) gebruikt, maar waarom zijn er zoveel navolgers?

#### `isindex`

Als u zich afvroeg: het totale aantal [`isindex`](https://www.w3.org/TR/html401/interact/forms.html#edef-ISINDEX) elementen in deze dataset is: één. Precies één pagina gebruikte een `isindex`-element. Het maakte deel uit van de specificaties tot [HTML 4.01 en XHTML 1.0](https://meiert.com/en/indices/html-elements/), maar alleen correct [gespecificeerd](https://lists.w3.org/Archives/Public/public-whatwg-archive/2006Feb/0111.html) in 2006 (in lijn met hoe het werd geïmplementeerd in browsers), en vervolgens [verwijderd](https://github.com/whatwg/html/pull/1095) in 2016.

### Eigen en verzonnen elementen

In onze verzameling elementen vonden we enkele die noch standaard HTML (noch SVG, noch MathML) -elementen waren, noch aangepaste, noch verouderde, maar enigszins gepatenteerde elementen. De top 10 die we hebben geïdentificeerd, zijn de volgende:

<figure markdown>
| Element | Pagina's (%) |
|---|---|
| `noindex` | 0,89% |
| `jdiv` | 0,85% |
| `mediaelementwrapper` | 0,49% |
| `ymaps` | 0,26% |
| `yatag` | 0,20% |
| `ss` | 0,11% |
| `include` | 0,08% |
| `olark` | 0,07% |
| `h7` | 0,06% |
| `limespot` | 0,05% |

<figcaption>{{ figure_link(caption="Elementen van twijfelachtig erfgoed.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

De bron van deze elementen lijkt te zijn gemengd, aangezien sommige onbekend zijn, terwijl andere kunnen worden getraceerd. De meest populaire, `noindex`, is waarschijnlijk te wijten aan [Yandex's aanbeveling](https://yandex.com/support/webmaster/adding-site/indexing-prohibition.html) ervan om pagina-indexering te verbieden. `jdiv` werd genoteerd in [de Web Almanac van vorig jaar](../2019/markup#products-and-libraries-and-their-custom-markup) en is van JivoChat. `mediaelementwrapper` komt van de MediaElement mediaspeler. Zowel `ymaps` als `yatag` zijn ook van Yandex. Het 'ss'-element kan afkomstig zijn van ProStores, een voormalig e-commerceproduct van eBay, en `olark` kan afkomstig zijn van de Olark-chatsoftware. `h7` lijkt een vergissing te zijn. `limespot` is waarschijnlijk gerelateerd aan het Limespot-personalisatieprogramma voor e-commerce. Geen van deze elementen maakt deel uit van een webstandaard.

### Koppen

[Koppen](https://html.spec.whatwg.org/multipage/dom.html#heading-content) vormen een speciale categorie elementen die een belangrijke rol spelen bij het [indelen](https://html.spec.whatwg.org/multipage/dom.html#sectioning-content-2) en voor [toegankelijkheid](https://www.w3.org/WAI/tutorials/page-structure/headings/).

<figure markdown>
| Kop | Voorvallen | Gemiddeld per pagina |
|---|---|---|
| `h1` | 10.524.810 | 1,66 |
| `h2` | 37.312.338 | 5,88 |
| `h3` | 44.135.313 | 6,96 |
| `h4` | 20.473.598 | 3,23 |
| `h5` | 8.594.500 | 1,36 |
| `h6` | 3.527.470 | 0,56 |

<figcaption>{{ figure_link(caption="Frequentie en gemiddeld gebruik van standaard kopelementen.", sheets_gid="277662548", sql_file="pages_wpt_bodies_by_device_and_percentile_and_heading_level.sql") }}</figcaption>
</figure>

Je had misschien verwacht dat je alleen de standaard `<h1>` tot `<h6>` elementen zou zien, maar sommige sites gebruiken eigenlijk meer niveaus:

<figure markdown>
| Kop | Voorvallen | Gemiddeld per pagina|
|---|---|---|
| `h7` | 30.073 | 0,005 |
| `h8` | 9.266 | 0,0015 |

<figcaption>{{ figure_link(caption="Frequentie en gemiddeld gebruik van niet-standaard kopelementen.", sheets_gid="277662548", sql_file="pages_wpt_bodies_by_device_and_percentile_and_heading_level.sql") }}</figcaption>
</figure>

De laatste twee hebben natuurlijk nooit deel uitgemaakt van HTML en mogen niet worden gebruikt.

## Attributen

Deze sectie gaat over hoe attributen worden gebruikt in documenten en onderzoekt patronen in `data-*` gebruik. Onze bevindingen laten zien dat `class` de koningin van alle attributen is.

### Topattributen

Vergelijkbaar met de sectie over de meest [populaire elementen](#topelementen), gaat deze sectie in op de meest populaire attributen op internet. Gezien hoe belangrijk het `href`-attribuut is voor het web zelf, of het `alt`-attribuut om informatie [toegankelijk](./accessibility) te maken, zouden dit dan de meest populaire attributen zijn?

<figure markdown>
| Attribuut | Voorvallen | Percentage |
|---|---|---|
| `class` | 2.998.695.114 | 34,23% |
| `href` | 928.704.735 | 10,60% |
| `style` | 523.148.251 | 5,97% |
| `id` | 452.110.137 | 5,16% |
| `src` | 341.604.471 | 3,90% |
| `type` | 282.298.754 | 3,22% |
| `title` | 231.960.356 | 2,65% |
| `alt` | 172.668.703 | 1,97% |
| `rel` | 171.802.460 | 1,96% |
| `value` | 140.666.779 | 1,61% |

<figcaption>{{ figure_link(caption="Top 10 attributen naar gebruiksfrequentie.", sheets_gid="1348855449", sql_file="pages_almanac_by_device_and_attribute_name_frequency.sql") }}</figcaption>
</figure>

Het meest populaire attribute is `class`, met bijna 3 miljard exemplaren in onze dataset en 34% van alle gebruikte attributen. `class` is verreweg het meest voorkomende attribute.

Het `value`-attribuut, dat de waarde van een `input`-element specificeert, maakt verrassend genoeg de top 10 compleet. Het is verrassend voor ons omdat we subjectief gezien niet de indruk kregen dat`value`-attributen zo vaak werden gebruikt.

### Attributen op pagina's

Zijn er attributen die we in elk document vinden? Niet helemaal, maar bijna:

<figure markdown>
Element | Pagina's (%)
-- | --
href | 99,21%
src | 99,18%
content | 98,88%
name | 98,61%
type | 98,55%
class | 98,24%
rel | 97,98%
id | 97,46%
style | 95,95%
alt | 90,75%

<figcaption>{{ figure_link(
  caption="Top 10 attributen per pagina.",
  sheets_gid="1185369559",
  sql_file="pages_almanac_by_device_and_attribute_name_present.sql"
)}}</figcaption>
</figure>

Deze resultaten roepen enkele vragen op die we niet kunnen beantwoorden. `type` wordt bijvoorbeeld ook op andere elementen gebruikt, maar waarom deze enorme populariteit? Zeker gezien het feit dat het meestal niet nodig is om opmaakmodellen of scripts op te geven, waarbij CSS en JavaScript als standaard worden aangenomen. Of, hoe vergaat het ons echt met `alt`? Bevatten die 9,25% van de pagina's geen afbeeldingen of zijn ze gewoon ontoegankelijk?

### `data-*` attributen

Volgens de HTML-specificatie, [`data-*` attributen](https://html.spec.whatwg.org/multipage/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributen) "zijn bedoeld om aangepaste gegevens, staat, annotaties en dergelijke op te slaan, privé voor de pagina of app, waarvoor er geen meer geschikte attributen of elementen zijn." Hoe worden ze gebruikt? Wat zijn de meest populaire? Is er hier iets interessants?

De twee meest populaire vallen op omdat ze bijna twee keer zo populair zijn dan elk van de volgende attributen (met > 1% gebruik):

<figure markdown>
| Attribuut | Voorvallen | Percentage |
|---|---|---|
| `data-src` | 26.734.560 | 3,30% |
| `data-id` | 26.596.769 | 3,28% |
| `data-toggle` | 12.198.883 | 1,50% |
| `data-slick-index` | 11.775.250 | 1,45% |
| `data-element_type` | 11.263.176 | 1,39% |
| `data-type` | 11.130.662 | 1,37% |
| `data-requiremodule` | 8.303.675 | 1,02% |
| `data-requirecontext` | 8.302.335 | 1,02% |

<figcaption>{{ figure_link(caption="De meest populaire <code>data-*</code> attributen.", sheets_gid="764700773", sql_file="pages_almanac_by_device_and_data_attribute_name_frequency.sql") }}</figcaption>
</figure>

Attributen zoals `data-type`, `data-id` en `data-src` kunnen meerdere generieke toepassingen hebben, hoewel `data-src` veel wordt gebruikt bij het lui laden van afbeeldingen via JavaScript (bijvoorbeeld Bootstrap 4). [Bootstrap](https://getbootstrap.com/) legt opnieuw de aanwezigheid uit van `data-toggle`, waar het wordt gebruikt als een staat styling haak op schakelknoppen. De [Slick carousel plugin](https://kenwheeler.github.io/slick/) is de bron van `data-slick-index`, terwijl `data-element_type` deel uitmaakt van [Elementor's WordPress-websitebouwer](https://elementor.com/). Zowel `data-requiremodule` als `data-requirecontext` maken dus deel uit van [RequireJS](https://requirejs.org/).

{# TODO(authors): Update this interpretation given that the lazy loading stat is in terms of pages, not img elements. #}
Interestingly, the use of native lazy loading on images is similar to that of `data-src`. 3.86% of pages use the `<img loading="lazy">` attribute. This appears to be growing very fast, as back in February, this number was about [0.8%](https://twitter.com/zcorpan/status/1237016679667970050). It's possible that these are being used together for a [cross-browser solution](https://addyosmani.com/blog/lazy-loading/).

## Diversen

We hebben het gebruik van HTML in het algemeen behandeld, evenals de acceptatie van topelementen en attributen. In deze sectie bespreken we enkele van de speciale gevallen van viewports, favicons, knoppen, invoer en links. Een ding dat we hier opmerken, is dat te veel links nog steeds naar "http" URL's verwijzen.

### `viewport` specificaties

Het meta-element [viewport](https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag) wordt gebruikt om de lay-out op mobiele browsers te beheren. Terwijl het motto jaren geleden een beetje was "vergeet het viewport-meta-element niet" bij het bouwen van een webpagina, werd dit uiteindelijk een gangbare praktijk en veranderde het motto in "zorg ervoor dat zoomen en schalen niet worden uitgeschakeld."

Gebruikers moeten de tekst kunnen zoomen en schalen [tot 500%](https://dequeuniversity.com/rules/axe/4.0/meta-viewport-large). Daarom mislukken audits in populaire hulpmiddelen zoals [Lighthouse](https://developers.google.com/web/tools/lighthouse) of [axe](https://www.deque.com/axe/) wanneer `user-scalable="no"` wordt gebruikt binnen het `meta name="viewport"` element, en wanneer de `maximum-scale` attribuutwaarde kleiner is dan `5`.

We hebben de gegevens bekeken en om de resultaten beter te begrijpen, hebben we deze genormaliseerd door spaties te verwijderen, alles naar kleine letters te converteren en te sorteren op kommawaarden van het `content`-attribuut.

<figure markdown>
| Inhoudsattribuutwaarde | Voorvallen | Pagina's (%) |
|---|---|---|
| `initial-scale=1,width=device-width` | 2.728.491 | 42,98% |
| blank | 688.293 | 10,84% |
| `initial-scale=1,maximum-scale=1,width=device-width` | 373.136 | 5,88% |
| `initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width` | 352.972 | 5,56% |
| `initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width` | 249.662 | 3,93% |
| `width=device-width` | 231.668 | 3,65% |

<figcaption>{{ figure_link(caption="<code>viewport</code>-specificaties, en het ontbreken daarvan.", sheets_gid="1414206386", sql_file="summary_pages_by_device_and_viewport.sql") }}</figcaption>
</figure>

De resultaten laten zien dat bijna de helft van de pagina's die we hebben geanalyseerd de typische viewport-`content`-waarde gebruikt. Toch mist ongeveer 10% van de mobiele pagina's volledig een juiste `content`-waarde voor het viewport-meta-element, terwijl de rest een onjuiste combinatie gebruikt van `maximum-scale`, `minimum-scale`, `user-scalable=no`, of `user-scalable=0`.

<p class="note">
  Met de mobiele Edge-browser kunnen gebruikers al een tijdje inzoomen op een webpagina naar <a href="https://blogs.windows.com/windows-insider/2017/01/12/announcing-windows-10-insider-preview-build-15007-pc-mobile/">ten minste 500%</a>, ongeacht de zoominstellingen die zijn gedefinieerd door een webpagina die het viewport-meta-element gebruikt.
</p>

### Favicons

De situatie rond favicons is fascinerend. Favicons werken met of zonder opmaak - sommige browsers vallen terug op [kijken naar de domeinhoofdmap](https://realfavicongenerator.net/faq#why_icons_in_root)—, accepteren verschillende afbeeldingsindelingen en promoten vervolgens ook enkele tientallen formaten (van sommige hulpmiddelen wordt gemeld dat ze er 45 genereren; [realfavicongenerator.net](https://realfavicongenerator.net/) zou _37_ retourneren als daarom wordt gevraagd om elk geval te behandelen). Op het moment van schrijven is er een [open `issue`](https://github.com/whatwg/html/issues/4758) voor de HTML-specificatie om de situatie te helpen verbeteren.

Bij het bouwen van onze tests hebben we niet gekeken naar de aanwezigheid van afbeeldingen, maar alleen naar de opmaak. Dat betekent dat wanneer u het volgende bekijkt, u er rekening mee houdt dat het meer gaat om _hoe_ er naar favicons wordt verwezen dan of en hoe vaak ze worden gebruikt.

<figure markdown>
| Favicon formaat | Voorvallen | Pagina's (%) |
|---|---|---|
| ICO | 2.245.646 | 35,38% |
| PNG | 1.966.530 | 30,98% |
| No favicon defined | 1.643.136 | 25,88% |
| JPG | 319.935 | 5,04% |
| No extension specified (no format identifiable) | 37.011 | 0,58% |
| GIF | 34.559 | 0,54% |
| WebP | 10.605 | 0,17% |
| … | | |
| SVG | 5.328 | 0,08% |

<figcaption>{{ figure_link(caption="Veel voorkomende favicon-indelingen.", sheets_gid="1930085905", sql_file="pages_almanac_by_device_and_favicon_image_type.sql") }}</figcaption>
</figure>

Er zijn hier een paar verrassingen:

* Ondersteuning voor andere formaten is er, maar ICO is nog steeds het go-to-formaat voor favicons op internet.
* JPG is een relatief populair faviconformaat, ook al levert het voor veel faviconformaten misschien niet de beste resultaten (of een relatief groot gewicht) op.
* WebP is twee keer zo populair als SVG! Dit kan echter veranderen naarmate [SVG favicon support](https://caniuse.com/link-icon-svg) verbetert.

### Knop- en invoertypen

Er is de laatste tijd veel [discussie](https://adrianroselli.com/2016/01/links-buttons-submits-and-divs-oh-hell.html) over knoppen en hoe vaak ze worden misbruikt. We hebben dit onderzocht om bevindingen over enkele van de native HTML-knoppen te presenteren.

{{ figure_markup(
  caption="Percentage pagina's met knopelementen.",
  content="60,56%",
  classes="big-number",
  sheets_gid="410549982",
  sql_file="pages_markup_by_device.sql"
) }}

{# TODO(analysts): Where do these "occurrences" come from? Ideally we have a single sheet to link to with the results used by this table. #}
<figure markdown>
| Knoptypes | Voorvallen | Percentage |
|---|---|---|
| `<button type="button">` | 15.926.061 | 36,41% |
| `<button>` zonder type | 11.838.110 | 32,43% |
| `<button type="submit">` | 4.842.946 | 28,55% |
| `<input type="submit" value="…">` | 4.000.844 | 31,82% |
| `<input type="button" value="…">` | 1.087.182 | 4,07% |
| `<input type="image" src="…">` | 322.855 | 2,69% |
| `<button type="reset">` | 41.735 | 0,49% |

<figcaption>{{ figure_link(caption="Overname van knoptypes.", sheets_gid="410549982", sql_file="pages_markup_by_device.sql") }}</figcaption>
</figure>

Uit onze analyse blijkt dat ongeveer 60% van de pagina's een knopelement bevat en meer dan de helft van de pagina's (32,43%) ten minste één knop heeft die geen `type`-attribuut specificeert. Merk op dat het knopelement een [standaardtype](https://dev.w3.org/html5/spec-LC/the-button-element.html) heeft van `submit`, dus het standaardgedrag van knoppen op deze 32% van de pagina's is om de huidige formuliergegevens in te dienen. Om mogelijk onverwacht gedrag als dit te voorkomen, is het het beste om het kenmerk `type` op te geven.

<figure markdown>
| Percentiel | Knoppen per pagina |
|---|---|
| 10 | 0 |
| 25 | 0 |
| 50 | 1 |
| 75 | 5 |
| 90 | 13 |

<figcaption>{{ figure_link(caption="Verdeling van het aantal knoppen per pagina.", sheets_gid="309769153", sql_file="pages_markup_by_device_and_percentile.sql") }}</figcaption>
</figure>

Pagina's in het 10e en 25e percentiel bevatten helemaal geen knoppen, terwijl een pagina in het 90e percentiel 13 native `button`-elementen bevat. Met andere woorden, 10% van de pagina's bevat 13 of meer knoppen.

### Link doelen

Het [`anchor`-element](https://developer.mozilla.org/nl/docs/Web/HTML/Element/a), of `a` element, verbindt webbronnen met elkaar. In deze sectie analyseren we de acceptatie van de protocollen die in deze linkdoelen zijn opgenomen.

<figure markdown>
| Protocol | Voorvallen | Pagina's (%) |
|---|---|---|
| https | 5.756.444 | 90,69% |
| http | 4.089.769 | 64,43% |
| mailto | 1.691.220 | 26,64% |
| javascript | 1.583.814 | 24,95% |
| tel | 1.335.919 | 21,05% |
| whatsapp | 34.643 | 0,55% |
| viber | 25.951 | 0,41% |
| skype | 22.378 | 0,35% |
| sms | 17.304 | 0,27% |
| intent | 12.807 | 0,20% |

<figcaption>{{ figure_link(caption="Adoptie van link doelen-protocollen.", sheets_gid="1963376224", sql_file="pages_wpt_bodies_by_device_and_protocol.sql") }}</figcaption>
</figure>

We kunnen zien hoe `https` en `http` het meest dominant zijn, gevolgd door 'goedaardige' links om het schrijven van e-mail, het voeren van telefoongesprekken en het verzenden van berichten gemakkelijker te maken. `javascript` onderscheidt zich als een linkdoel dat nog steeds erg populair is, ook al biedt JavaScript native en gracieus vernederende opties om mee te werken.

### Links in nieuwe vensters

{{ figure_markup(
  caption="Percentage pagina's met noch `noopener` noch `noreferrer` attributen op `target=\"_blank\"` links.",
  content="71,35%",
  classes="big-number",
  sheets_gid="1876528165",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

Het gebruik van `target="_blank"` staat al enige tijd bekend als een [beveiligingsprobleem](https://mathiasbynens.github.io/rel-noopener/). Toch bevat 71,35% van de pagina's links met `target="_blank"`, zonder `noopener` of `noreferrer`.

<figure markdown>
| Elementen | Pagina's |
|---|---|
| `<a target="_blank" rel="noopener noreferrer">` | 13,63% |
| `<a target="_blank" rel="noopener">` | 14,14% |
| `<a target="_blank" rel="noreferrer">` | 0,56% |

<figcaption>{{ figure_link(caption="Lege relaties.", sheets_gid="1876528165", sql_file="pages_wpt_bodies_by_device.sql") }}</figcaption>
</figure>

Als vuistregel en om [gebruiksredenen](https://www.nngroup.com/articles/new-browser-windows-and-tabs/), geeft u er de voorkeur aan om `target="_blank"` niet te gebruiken in de eerste plaats.

<p class="note">In de nieuwste Safari- en Firefox-versies biedt het instellen van <code>target="_blank"</code> op <code>a</code>-elementen impliciet hetzelfde <code>rel</code>-gedrag als het instellen van <code>rel="noopener"</code>. Dit is ook al <a href="https://chromium-review.googlesource.com/c/chromium/src/+/1630010">geïmplementeerd in Chromium</a> en komt ook in Chrome 88 terecht.</p>

## Conclusie

We hebben in het hele hoofdstuk enkele observaties aangeroerd, maar als reflectie op de staat van opmaak in 2020, zijn hier enkele dingen die ons opvielen:

{{ figure_markup(
  caption="Percentage pagina's met een eigenzinnig doctype.",
  content="3,97%",
  classes="big-number",
  sheets_gid="1981441894",
  sql_file="summary_pages_by_device_and_doctype.sql"
) }}

Minder pagina's komen terecht in de eigenaardighedenmodus. In 2016 bedroeg dat aantal [ongeveer 7,4%](https://discuss.httparchive.org/t/how-many-and-which-pages-are-in-quirks-mode/777). Eind 2019 hebben we [4.85%](https://twitter.com/zcorpan/status/1205242913908838400) waargenomen. En nu zitten we op ongeveer 3,97%. Deze trend, om [Simon Pieters](./contributors#zcorpan) te parafraseren in zijn bespreking van dit hoofdstuk, lijkt duidelijk en bemoedigend.

Hoewel we geen historische gegevens hebben om het volledige ontwikkelingsbeeld te schetsen, heeft "betekenisloze" `div`, `span` en `i` opmaak vrijwel de `table` opmaak die we hebben waargenomen in de jaren 1990 en vroege jaren 2000 [vervangen](#topelementen). Hoewel men zich kan afvragen of `div`- en `span`-elementen altijd worden gebruikt zonder dat er een semantisch geschikter alternatief is, verdienen deze elementen nog steeds de voorkeur boven `table`-markup, aangezien deze tijdens de hoogtijdagen van het oude web schijnbaar voor alles behalve tabelgegevens werden gebruikt.

Elementen per pagina en elementtypes per pagina bleven ongeveer hetzelfde en toonden [geen significante verandering](#element-diversity) in onze HTML-schrijfpraktijk in vergelijking met 2019. Dergelijke veranderingen kunnen meer tijd vergen om zich te manifesteren.

Gepatenteerde productspecifieke elementen zoals `g:plusone` (gebruikt op 17.607 pagina's in het mobiele voorbeeld) en `fb:like` (11.335) zijn bijna verdwenen nadat ze nog steeds [een van de meest populaire](../2019/markup#products-and-libraries-and-their-custom-markup) waren vorig jaar. We zien echter meer [aangepaste elementen](#custom-elements) voor zaken als Slider Revolution, AMP en Angular. Elementen als `ym-maatregel`, `jdiv` en `ymaps` komen ook nog steeds voor. Wat we ons voorstellen dat we hier zien, is dat, onder de zee van langzaam veranderende praktijken, HTML erg wordt ontwikkeld en onderhouden, terwijl auteurs verouderde markeringen weggooien en nieuwe oplossingen omarmen.

Nu had het [hoofdstuk Web Almanac Opmaak 2019](../2019/markup) 14 jaar inhaalslag te maken sinds de laatste grote studie over het onderwerp, dus je zou denken dat we niet veel te behandelen hebben in de jaar sinds. Maar wat we met de gegevens van dit jaar zien, is dat er veel beweging is op de bodem en nabij de kust van de genoemde zee van HTML. We benaderen een bijna volledige acceptatie van levende HTML. We snoeien onze pagina's snel van rages zoals Google- en Facebook-widgets. We zijn ook snel in het adopteren en mijden van frameworks, aangezien zowel Angular als AMP (hoewel een "component framework") aanzienlijk aan populariteit lijken te hebben verloren, waarschijnlijk voor oplossingen als React en Vue.

En toch zijn er geen tekenen dat we de opties die HTML ons biedt hebben uitgeput. De mediaan van 30 verschillende elementen die op een bepaalde pagina worden gebruikt, wat ongeveer een kwart is van de elementen die HTML ons biedt, suggereert een nogal eenzijdig gebruik van HTML. Dat wordt ondersteund door de immense populariteit van elementen als `div` en `span`, en er zijn geen aangepaste elementen om mogelijk te voldoen aan de eisen die deze twee elementen kunnen vertegenwoordigen. Helaas konden we niet elk document in het voorbeeld valideren; anekdotisch en om voorzichtig te zijn, hebben we echter geleerd dat [79%](https://github.com/HTTPArchive/almanac.httparchive.org/issues/899#issuecomment-717856201) van W3C-geteste documenten validatiefouten bevatten. Na alles wat we hebben gezien, lijkt het erop dat we het ambacht van HTML nog lang niet beheersen.

Dat dwingt ons om af te sluiten met een oproep: let op HTML. Focus op HTML. Het is belangrijk en de moeite waard om in HTML te investeren. HTML is een documenttaal die misschien niet de charme heeft van een programmeertaal, en toch is het web erop gebouwd. Gebruik minder HTML en leer wat echt nodig is. Gebruik meer geschikte HTML - ontdek wat er beschikbaar is en waarvoor het is bedoeld. En [valideer](https://validator.w3.org/docs/why.html) uw HTML. Iedereen kan ongeldige HTML schrijven (nodig gewoon de volgende persoon die u ontmoet uit om een HTML-document te schrijven en de uitvoer te valideren), maar van een professionele ontwikkelaar mag worden verwacht dat hij geldige HTML produceert. Het schrijven van correcte en geldige HTML is een vak om trots op te zijn.

Laten we ons voor de volgende editie van het hoofdstuk over de Web Almanac voorbereiden om nader te kijken naar het vak van het schrijven van HTML en, hopelijk, hoe we het hebben verbeterd.

We laten dit voor je open. Wat zijn uw opmerkingen? Wat viel u op? Wat is er volgens u verslechterd, en wat is er verbeterd? [Laat een reactie achter](https://discuss.httparchive.org/t/2039) om uw mening te delen!
