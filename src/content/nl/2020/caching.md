---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Caching
description: Caching-hoofdstuk van de 2020 Web Almanac over Cache-Control, expires, TTL's, validatie, variëren, set-cookies, AppCache, Service Workers en mogelijkheden.
hero_alt: Hero image of Web Almanac characters and resources in parking slots in a car park with parking meters in from of them. The middle spot is labelled 304.
authors: [roryhewitt, raghuramakrishnan71]
reviewers: [jzyang]
analysts: [raghuramakrishnan71]
editors: [tunetheweb]
translators: [noah-vdv]
roryhewitt_bio: Enterprise Architect bij <a hreflang="en" href="https://www.akamai.com/">Akamai</a>, met een passie voor prestaties. Hij is een Britse expat en woont al meer dan twintig jaar in San Francisco. In zijn vrije tijd is hij een avontuurlijke motorrijder, snowboarder en bokser/karateka. Hij staat graag bekend als een onruststoker. Het belangrijkste is dat hij een vader en echtgenoot is en de eigenaar van Luna de kat.
raghuramakrishnan71_bio: Enterprise-architect bij <a hreflang="en" href="https://www.tcs.com/">Tata Consultancy Services</a>, aan het werk voor grote digitale transformatieprogramma's in de publieke sector. Een technologieliefhebber met een bijzondere interesse in prestatie-engineering. Een fervent reiziger, geïntrigeerd door astronomie, geschiedenis, biologie en vooruitgang in de geneeskunde. Een sterke volgeling van vers 47, hoofdstuk 2 van de Bhagavad Gita "karmaṇy-evādhikāras te mā phaleṣhu kadāchana", wat betekent "U heeft het recht om uw voorgeschreven plicht te vervullen, maar u hebt geen recht op de vruchten van actie".
discuss: 2056
results: https://docs.google.com/spreadsheets/d/1fYmpSN3diOiFrscS75NsjfsrKXzxxhUMNcYSqXnQJQU/
featured_quote: Caching biedt een aanzienlijk prestatievoordeel door dure netwerkverzoeken te vermijden. Het helpt zowel eindgebruikers (ze krijgen hun webpagina's snel) als de bedrijven die webpagina's bedienen (de belasting van hun servers wordt verminderd). Caching is echt een win-win!
featured_stat_1: 25,6%
featured_stat_label_1: HTTP-reacties zonder cachegegevens
featured_stat_2: 21,4%
featured_stat_label_2: Reacties die niet opnieuw kunnen worden gevalideerd
featured_stat_3: 21,3%
featured_stat_label_3: Sites die met betere caching meer dan 2 MB kunnen besparen op herhaalde bezoeken
---

## Inleiding

Caching is een techniek die het hergebruiken van eerder gedownloade inhoud mogelijk maakt. Het omvat iets (een server die webpagina's bouwt, een proxy zoals een CDN of de browser zelf) dat 'inhoud' opslaat (webpagina's, CSS, JS, afbeeldingen, lettertypen, enz.) en het op de juiste manier tagt, zodat het kan worden hergebruikt.

Hier is een voorbeeld van zeer hoog niveau:

  *Jane bezoekt de startpagina van de website www.example.com. Jane woont in Los Angeles, CA, en de server van example.com bevindt zich in Boston, MA. Jane die www.example.com bezoekt, heeft betrekking op een netwerkverzoek dat door het land moet reizen.*

  *Op de server van example.com (ook bekend als Origin-server) wordt de startpagina opgehaald. De server weet dat Jane in LA is gevestigd en voegt dynamische inhoud toe aan de pagina—een lijst met aankomende evenementen bij haar in de buurt. Vervolgens wordt de pagina door het hele land naar Jane teruggestuurd en in haar browser weergegeven.*

  *Als er geen caching is en Carlos in LA ook www.example.com bezoekt na Jane, dan moet zijn verzoek door het hele land naar de example.com-server gaan. De server moet dezelfde pagina bouwen, inclusief de LA-evenementenlijst. Het zal de pagina terug moeten sturen naar Carlos.*

  *Erger nog, als Jane de startpagina van example.com opnieuw bezoekt, zullen haar volgende verzoeken zich gedragen als de eerste: het verzoek moet door het hele land gaan en de server van example.com moet de startpagina opnieuw opbouwen om deze naar haar terug te sturen.*

  *Dus zonder enige caching, bouwt de example.com-server elk verzoek helemaal opnieuw op. Dat is slecht voor de server, want het is meer werk. Bovendien vereist elke communicatie tussen Jane of Carlos en de server van example.com gegevens om door het land te reizen. Dit alles kan resulteren in een langzame ervaring die slecht is voor beiden.*

  *Echter, met server caching, wanneer Jane haar eerste verzoek doet, bouwt de server de LA-variant van de startpagina. Het slaat de gegevens op voor hergebruik door alle LA-bezoekers. Dus wanneer het verzoek van Carlos bij de server van example.com komt, controleert de server of de LA-variant van de startpagina in zijn cache staat. Aangezien die pagina in de cache is als resultaat van Jane's eerdere verzoek, bespaart de server tijd door de in de cache opgeslagen pagina te retourneren.*

  *Wat nog belangrijker is, met browsercaching, wanneer Jane's browser de pagina van de server voor het eerste verzoek ontvangt, wordt de pagina in het cachegeheugen opgeslagen. Al haar toekomstige verzoeken voor de startpagina van example.com zullen worden weergegeven vanuit de cache van haar browser, zonder een netwerkverzoek. De server van example.com profiteert ook van het niet hoeven verwerken of behandelen van Jane's verzoek.*

  *Jane is blij. Carlos is blij. De mensen van example.com zijn blij. Iedereen is blij.*

Het moge duidelijk zijn dat browsercaching een aanzienlijk prestatievoordeel oplevert door dure netwerkverzoeken te vermijden (hoewel <a hreflang="en" href="https://simonhearne.com/2020/network-faster-than-cache/">er altijd randgevallen zijn</a>). Het helpt ook bij het schalen van applicaties door het verkeer naar de oorspronkelijke infrastructuur van een website te verminderen. Servercaching vermindert ook aanzienlijk de belasting van de onderliggende applicatie.

Caching heeft voordelen voor zowel de eindgebruikers (ze krijgen hun webpagina's snel) als de bedrijven die de webpagina's bedienen (de belasting van hun servers wordt verminderd). Caching is echt een win-win!

Webarchitecturen omvatten doorgaans meerdere cachinglagen. Er zijn vier hoofdplaatsen of *caching-entiteiten* waar caching kan plaatsvinden:

1. De webbrowser van een eindgebruiker.
1. Een cache van een service worker die wordt uitgevoerd in de webbrowser van de eindgebruiker.
1. Een Content Delivery Network (CDN) of vergelijkbare proxy, die zich tussen de webbrowser van de eindgebruiker en de oorspronkelijke server bevindt.
1. De Origin-server zelf.

In dit hoofdstuk zullen we voornamelijk caching binnen webbrowsers (1-2) bespreken, in tegenstelling tot caching op de Oorsprong-server of in een CDN. Desalniettemin zijn veel van de specifieke cachingonderwerpen die in dit hoofdstuk worden besproken, afhankelijk van de relatie tussen de browser en de server (of CDN, als er een wordt gebruikt).

De sleutel om te begrijpen hoe caching, en het web in het algemeen, werkt, is te onthouden dat het allemaal bestaat uit transacties tussen een verzoekende entiteit (bijvoorbeeld een browser) en een reagerende entiteit (bijvoorbeeld een server). Elke transactie bestaat uit twee delen:

1. Het verzoek van de aanvragende entiteit: "*Ik wil object X*".
2. De reactie van de reagerende entiteit: "*Hier is object X*".

Als we het hebben over caching, verwijst het naar het object (HTML-pagina, afbeelding, enz.) Dat door de aanvragende entiteit in de cache is opgeslagen.

De onderstaande afbeelding laat zien hoe een typische aanvraag-/reactiestroom werkt voor een object (bijv. Een webpagina). Een CDN bevindt zich tussen de browser en de server. Merk op dat op elk punt in de browser → CDN → serverstroom, elk van de caching-entiteiten eerst controleert of het object in zijn cache zit. Het retourneert het gecachte object naar de aanvrager, indien gevonden, voordat het verzoek wordt doorgestuurd naar de volgende caching-entiteit in de keten:

{{ figure_markup(
  image="request-response-flow-with-caching.png",
  caption="Verzoek-/reactiestroom voor een object.",
  description="Sequentiediagram dat het gebruik van cache toont in een typische aanvraag-/reactiestroom voor een object."
  )
}}

<p class="note">Opmerking: tenzij anders aangegeven, zijn alle statistieken in dit hoofdstuk voor mobiel, met dien verstande dat desktopstatistieken vergelijkbaar zijn. Waar mobiele statistieken en desktopstatistieken aanzienlijk verschillen, wordt dat genoemd.

Veel van de reacties die in dit hoofdstuk worden gebruikt, zijn afkomstig van webservers die algemeen verkrijgbare serverpakketten gebruiken. Hoewel we beste praktijken kunnen aangeven, is het mogelijk dat de procedures niet mogelijk zijn als het gebruikte softwarepakket een beperkt aantal cache-opties heeft.</p>

## Caching leidende principes

Er zijn drie richtlijnen voor het cachen van webcontent:

* Cache zo veel mogelijk
* Cache zo lang als u kunt
* Cache zo dicht mogelijk bij de eindgebruikers

### Cache zo veel mogelijk

Wanneer u bedenkt wat u in het cachegeheugen wilt opslaan, is het belangrijk om te weten of de inhoud van de reactie *statisch* of *dynamisch* is.

#### Statische inhoud

Een voorbeeld van statische inhoud is een afbeelding. Een afbeelding van een kat in een cat.jpg-bestand is bijvoorbeeld meestal hetzelfde, ongeacht wie erom vraagt of waar de aanvrager zich bevindt (natuurlijk kunnen alternatieve formaten of maten worden geleverd, maar meestal met een andere bestandsnaam).

{{ figure_markup(
  image="luna-cat.jpg",
  caption="Ja, we hebben een foto van een kat.",
  description="Een foto van een kat genaamd Luna."
  )
}}

Statische inhoud kan doorgaans in het cachegeheugen worden opgeslagen en kan vaak gedurende lange tijd worden gebruikt. Het heeft een één-op-veel-relatie tussen de inhoud (één) en de verzoeken (veel).

#### Dynamische inhoud

Een voorbeeld van dynamische inhoud is een lijst met gebeurtenissen die specifiek zijn voor een geografische locatie. De lijst zal verschillen op basis van de locatie van de aanvrager.

Dynamisch gegenereerde inhoud kan meer genuanceerd zijn en vereist een zorgvuldige afweging. Sommige dynamische inhoud kan in de cache worden opgeslagen, maar vaak voor een kortere periode. Het voorbeeld van een lijst met aankomende evenementen zal veranderen, mogelijk van dag tot dag. Mogelijk moeten verschillende varianten van de lijst ook in de cache worden opgeslagen en wat in de browser van een gebruiker in de cache is opgeslagen, kan een subset zijn van wat op de server of het CDN in de cache is opgeslagen. Desalniettemin is het mogelijk om bepaalde dynamische inhoud in de cache op te slaan. Het is onjuist om aan te nemen dat "dynamisch" een ander woord is voor "niet-cachebaar".

### Cache zo lang als u kunt

De tijdsduur dat u een bron in het cachegeheugen plaatst, is sterk afhankelijk van de *vluchtigheid* van de inhoud, dat wil zeggen de waarschijnlijkheid en/of frequentie van verandering. Een afbeelding of een JavaScript-bestand met versiebeheer kan bijvoorbeeld gedurende een zeer lange tijd in de cache worden opgeslagen. Een API-reactie of een JavaScript-bestand zonder versiebeheer heeft mogelijk een kortere cacheduur nodig om ervoor te zorgen dat gebruikers het meest actuele reactie krijgen. Sommige inhoud wordt mogelijk maar een minuut of minder in de cache opgeslagen. En natuurlijk mag sommige inhoud helemaal niet in de cache worden opgeslagen. Dit wordt hieronder in [Mogelijkheden voor caching identificeren](#mogelijkheden-voor-caching-identificeren) in meer detail besproken.

Een ander punt om in gedachten te houden is dat het niet uitmaakt hoe lang u een browser *vertelt* om inhoud in de cache op te slaan, de browser kan die inhoud vóór dat tijdstip uit de cache verwijderen. Het kan dit doen om bijvoorbeeld ruimte te maken voor andere inhoud die vaker wordt geopend. Een browser zal de cache-inhoud echter niet langer gebruiken dan wordt verteld.

### Cache zo dicht mogelijk bij de eindgebruikers

Door inhoud dicht bij de eindgebruiker te cachen, worden de downloadtijden verkort door de latentie te verwijderen. Als een bron bijvoorbeeld in de cache van de browser van een gebruiker is opgeslagen, gaat het verzoek nooit naar het netwerk en is het lokaal beschikbaar elke keer dat de gebruiker het nodig heeft. Voor bezoekers die geen gegevens in de cache van hun browser hebben, is een CDN de volgende plaats waar een bron in de cache wordt geretourneerd. In de meeste gevallen zal het sneller zijn om een bron op te halen uit een lokale cache of een CDN in vergelijking met een Origin-server.

## Wat terminologie

*Caching-entiteit*: De hardware of software die de caching uitvoert. Vanwege de focus van dit hoofdstuk, gebruiken we "browser" als synoniem voor "caching-entiteit", tenzij anders aangegeven.

*Time-To-Live (TTL)*: De TTL van een in de cache opgeslagen object bepaalt hoe lang het in een cache kan worden opgeslagen, meestal gemeten in seconden. Nadat een in de cache opgeslagen object de TTL heeft bereikt, wordt het door de cache gemarkeerd als 'verouderd'. Afhankelijk van hoe het aan de cache is toegevoegd (zie de details van de caching-headers hieronder), kan het onmiddellijk uit de cache worden verwijderd, of het kan in de cache blijven maar gemarkeerd als een 'verouderd' object, en moet opnieuw worden gevalideerd voordat het opnieuw kan worden gebruikt.

*Uitzetting*: Het geautomatiseerde proces waarmee een object daadwerkelijk uit een cache wordt verwijderd wanneer/nadat het zijn TTL heeft bereikt of mogelijk wanneer de cache vol is.

*Herbevestiging*: een in de cache opgeslagen object dat als verouderd is gemarkeerd, moet mogelijk worden 'herbevestigd' bij de server voordat het aan de gebruiker kan worden weergegeven. De browser moet eerst bij de server controleren of het object dat de browser in zijn cache heeft nog _up-to-date_ en geldig is.

## Overzicht van browsercaching

Wanneer een browser een verzoek doet om een stuk inhoud (bijv. Een webpagina), ontvangt deze een reactie dat niet alleen de inhoud zelf (de HTML-opmaak) bevat, maar ook een aantal *HTTP-reactieheaders* die de inhoud beschrijven , inclusief informatie over de cachemogelijkheden.

De caching-gerelateerde headers, of de afwezigheid ervan, vertellen de browser drie belangrijke stukjes informatie:

1. **Cacheerbaar**: is deze inhoud cacheerbaar?
2. **Versheid**: als het cachebaar is, hoe lang kan het dan in het cachegeheugen worden bewaard?
3. **Validatie**: Als het cachebaar is, hoe zorg ik er dan voor dat mijn cacheversie nog vers is?

De twee HTTP-reactieheaders die doorgaans worden gebruikt voor het specificeren van versheid zijn `Cache-Control` en `Expires`:

* `Expires` specificeert een expliciete vervaldatum en -tijd (d.w.z. wanneer de inhoud precies verloopt)
* `Cache-Control` specificeert een cache-duur (d.w.z. hoe lang de inhoud in de browser kan worden gecachet ten opzichte van het moment waarop deze werd aangevraagd)

Vaak worden deze beide headers gespecificeerd; in dat geval heeft `Cache-Control` voorrang.

De volledige specificaties voor deze caching-headers zijn in <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-8">RFC 7234</a>, en besproken in secties <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.2">4.2 (Freshness)</a> en <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.3">4.3 (Validation)</a>, maar we zullen ze hieronder in meer detail bespreken.

## `Cache-Control` vs `Expires`

In de vroege HTTP/1.0-dagen van het web was de `Expires`-header de enige cache-gerelateerde reactie-header. Zoals hierboven vermeld, wordt het gebruikt om de exacte datum/tijd aan te geven waarna de reactie als verouderd wordt beschouwd. De waarde is een datum en tijd, zoals:

```
Expires: Thu, 01 Dec 1994 16:00:00 GMT
```

De `Expires`-header kan worden gezien als een bot instrument. Als een relatieve cache-TTL vereist is, moet de verwerking op de server worden uitgevoerd om een geschikte waarde te genereren op basis van de huidige datum/tijd.

HTTP/1.1 introduceerde de `Cache-Control`-header, die lange tijd door alle veelgebruikte browsers wordt ondersteund. De `Cache-Control`-header biedt veel meer uitbreidbaarheid en flexibiliteit dan `Expires` via *caching richtlijnen*, waarvan er verschillende samen gespecificeerd kunnen worden. Details over de verschillende richtlijnen staan hieronder.

```
> GET /static/js/main.js HTTP/2
> Host: www.example.org
> Accept: */*
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:04:17 GMT
< Expires: Thu, 23 Jul 2020 03:14:17 GMT
< Cache-Control: public, max-age=600
```

Het eenvoudige voorbeeld hierboven toont een verzoek en reactie voor een JavaScript-bestand, hoewel sommige kopteksten voor de duidelijkheid zijn verwijderd. De kop `Date` geeft de huidige datum aan (in het bijzonder de datum waarop de inhoud werd geserveerd). De `Expires`-header geeft aan dat het 10 minuten in de cache kan worden bewaard (het verschil tussen de `Expires`- en `Date`-headers). De `Cache-Control`-header specificeert de `max-age`-richtlijn, die aangeeft dat de bron 600 seconden (5 minuten) in de cache kan worden opgeslagen. Aangezien `Cache-Control` voorrang heeft op `Expires`, zal de browser de reactie gedurende 5 minuten in de cache opslaan, waarna het als verouderd wordt gemarkeerd.

RFC 7234 zegt dat als er geen caching-headers aanwezig zijn in een reactie, de browser de reactie *heuristisch* mag cachen—het suggereert een cacheduur van 10% van de tijd sinds de `Last-Modified`-header (indien geslaagd). In dergelijke gevallen implementeren de meeste browsers een variatie op deze suggestie, maar sommige kunnen de reactie voor onbepaalde tijd cachen en andere helemaal niet. Vanwege deze variatie tussen browsers is het belangrijk om expliciet specifieke cacheregels in te stellen om ervoor te zorgen dat u de controle heeft over de cachemogelijkheden van uw inhoud.

{{ figure_markup(
  image="cache-control-and-max-age-and-expires.png",
  caption="Gebruik van `Cache-Control` en `Expires` headers",
  description="Een staafdiagram dat het gebruik van `Cache-Control`- en `Expires`-headers laat zien. Op desktop wordt 73,6% van de reacties weergegeven met een `Cache-Control`-header. 55,5% wordt bediend met een `Expires`-header, 54,8% gebruikt zowel de `Cache-Control`- als de `Expires`-header en 25,6% heeft geen van beide headers opgenomen. Op mobiele apparaten wordt 73,5% van de reacties weergegeven met een `Cache-Control`-header, 56,2% wordt geserveerd met een `Expires`-header, 55,4% gebruikt zowel de `Cache-Control`- als de `Expires`-header en 25,6% bevat geen een van beide headers.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=188448640&format=interactive",
  sheets_gid="865734542",
  sql_file="cache_control_and_max_age_and_expires.sql"
  )
}}

Zoals we kunnen zien, wordt 73,5% van de mobiele reacties weergegeven met een `Cache-Control`-header, en 56,2% van de reacties met een `Expires`-header en bijna al deze (55,4%) zullen niet worden gebruikt omdat de reacties beide headers bevatten. 25,6% van de reacties bevatte geen header en is daarom onderhevig aan heuristische caching.

Deze statistieken zijn interessant in vergelijking met de gegevens van vorig jaar:

{{ figure_markup(
  image="cache-control-and-max-age-and-expires-2019.png",
  caption="Gebruik van `Cache-Control` en `Expires`-headers in 2019.",
  description="Een staafdiagram dat het gebruik van `Cache-Control`- en `Expires`-headers laat zien. Op desktop wordt 72,3% van de reacties weergegeven met een `Cache-Control`-header. 56,3% wordt bediend met een `Expires`-header, 55,2% gebruikt zowel de `Cache-Control`- als de `Expires`-header en 26,7% heeft geen van beide headers opgenomen. Op mobiele apparaten wordt 71,7% van de reacties weergegeven met een `Cache-Control`-header, 56,4% wordt geserveerd met een `Expires`-header, 55,5% gebruikt zowel de `Cache-Control`- als de `Expires`-header en 27,4% bevat geen een van beide headers.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=651240480&format=interactive",
  sheets_gid="664360335",
  sql_file="cache_control_and_max_age_and_expires_2019.sql"
  )
}}

Hoewel we een lichte toename zien in het gebruik van de `Cache-Control`-header (1.8%), zien we ook een minimale afname in het gebruik van de oudere `Expires`-header (0.2%). Op Desktop zien we eigenlijk een marginale toename van `Cache-Control` (1,3%), met een kleinere toename bij `Expires` (0,8%). In feite lijken meer desktop-sites de `Cache-Control`-header toe te voegen zonder de `Expires`-header.

Terwijl we verdiepen in de verschillende richtlijnen toegestaan in de `Cache-Control`-header, zullen we zien hoe de flexibiliteit en macht het in veel gevallen beter passen.

## `Cache-Control`-richtlijnen

Wanneer u de `Cache-Control`-header gebruikt, geeft u een of meer *richtlijnen*—geest gedefinieerde waarden op die specifieke cachingfunctionaliteit aangeven. Meerdere richtlijnen worden gescheiden door komma's en kunnen in elke volgorde worden gespecificeerd, hoewel sommige van hen 'botsen' met elkaar (bijvoorbeeld `public` en `private`). Sommige richtlijnen nemen een waarde, zoals `max-age`.

Hieronder staat een tabel met de meest voorkomende `Cache-Control`-richtlijnen:

<figure>
  <table>
    <tr>
      <th>Richtlijn</th>
      <th>Beschrijving</th>
    </tr>
    <tr>
      <td><code class="no-wrap">max-age</code></td>
      <td>Geeft het aantal seconden aan waarvoor een bron kan worden opgeslagen, ten opzichte van de huidige tijd. Bijvoorbeeld <code>max-age=86400</code>.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">public</code></td>
      <td>Elke cache kan de reactie opslaan, inclusief de browser en eventuele proxies tussen de server en de browser, zoals een CDN. Dit wordt standaard verondersteld.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">no-cache</code></td>
      <td>Een cache-invoer moet voorafgaand aan het gebruik worden herlandsideerd, via een voorwaardelijke aanvraag, zelfs als het niet als oud is gemarkeerd.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">must-revalidate</code></td>
      <td>Een verouderde vermelding in de cache moet opnieuw worden gevalideerd voordat deze wordt gebruikt, via een voorwaardelijke aanvraag.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">no-store</code></td>
      <td>Geeft aan dat de reactie niet in de cache mag worden opgeslagen.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">private</code></td>
      <td>De reactie is bedoeld voor een specifieke gebruiker en mag niet worden opgeslagen door gedeelde caches zoals proxy's en CDN's.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">proxy-revalidate</code></td>
      <td>Hetzelfde als <code>must-revalidate</code> maar is van toepassing op gedeelde caches.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">s-maxage</code></td>
      <td>Hetzelfde als <code>max-age</code> maar is alleen van toepassing op gedeelde caches (bijv. CDN's).</td>
    </tr>
    <tr>
      <td><code class="no-wrap">immutable</code></td>
      <td>Geeft aan dat de vermelding in de cache nooit zal veranderen tijdens de TTL en dat hernieuwde validatie niet nodig is.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">stale-while-revalidate</code></td>
      <td>Geeft aan dat de cliënt bereid is een verouderde reactie te accepteren terwijl hij op de achtergrond asynchroon controleert op een nieuwe reactie.</td>
    </tr>
    <tr>
      <td><code class="no-wrap">stale-if-error</code></td>
      <td>Geeft aan dat de cliënt bereid is een verouderde reactie te accepteren als de controle op een nieuwe mislukt.</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="<code>Cache-Control</code>-richtlijnen.", sheets_gid="1950040019", sql_file="cache_control_directives.sql") }}</figcaption>
</figure>

De `max-age`-richtlijn wordt het meest gevonden, omdat deze direct de TTL definieert, op dezelfde manier als de `Expires`-header dat doet.

Hier is een voorbeeld van een geldige Cache-Control-header met meerdere richtlijnen:

```
Cache-Control: public, max-age=86400, must-revalidate
```

Dit geeft aan dat het object 86.400 seconden (1 dag) in de cache kan worden opgeslagen en dat het kan worden opgeslagen door alle caches tussen de server en de browser, evenals in de browser zelf. Zodra het zijn TTL heeft bereikt en is gemarkeerd als verouderd, kan het in de cache blijven, maar moet het voorwaardelijk opnieuw worden gevalideerd voordat het opnieuw kan worden gebruikt.

{{ figure_markup(
  image="cache-control-directives.png",
  caption="Verdeling van `Cache-Control`-richtlijnen.",
  description="Een staafdiagram met de verspreiding van 11 `Cache-Control`-richtlijnen. Het gebruik voor desktop varieert van 60,2% voor `max-age`, 29,7% voor `public`, 14,3% voor `no-cache`, 12,1% voor `must-revalidate`, 9,2% voor `no-store`, 9.1 % voor `private`, 3,5% voor `immutable`, 2,3% voor `no-transform`, 2,1% voor `stale-while-revalidate`, 1,5% voor `s-maxage`, 1,0% voor `proxy-revalidate`, en 0,2% voor `stale-if-error`. Voor mobiel is het bereik, 59,7% voor `max-age`, 29,7% voor `public`, 15,1% voor `no-cache`, 12,5% voor `must-revalidate`, 9,6% voor `no-store`, 9,7% voor `private`, 3,5% voor `immutable`, 2,2% voor `no-transform`, 2,2% voor `stale-while-revalidate`, 1,2% voor `s-maxage`, 1,1% voor `proxy-revalidate`, en 0,2% voor `stale-if-error`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=388795105&format=interactive",
  sheets_gid="1950040019",
  sql_file="cache_control_directives.sql"
  )
}}

De bovenstaande afbeelding illustreert de 11 `Cache-Control`-richtlijnen die worden gebruikt op mobiele en desktopwebsites. Er zijn een paar interessante opmerkingen over de populariteit van deze cache-richtlijnen:
* `max-age` wordt gebruikt door ongeveer 59,66% van de mobiele `Cache-Control`-headers, en `no-store` wordt gebruikt door ongeveer 9,64% (zie hieronder voor discussie over de betekenis en het gebruik van de `no-store`-richtlijn).
* Het expliciet specificeren van `public` is nooit echt nodig, aangezien ingangen in de cache als `public` worden beschouwd, tenzij `private` is gespecificeerd. Desalniettemin bevat bijna een derde van de reacties `public`—een verspilling van een paar headerbytes per reactie :)
* De `immutable` richtlijn is relatief nieuw, geïntroduceerd in 2017 en wordt alleen ondersteund op Firefox en Safari—het gebruik ervan is nog steeds slechts ongeveer 3,47%, maar wordt algemeen gezien in reacties van Facebook, Google, Wix, Shopify en anderen. Het heeft het potentieel om de cachemogelijkheden voor bepaalde soorten verzoeken aanzienlijk te verbeteren.

Als we naar de lange staart gaan, is er een klein percentage ongeldige richtlijnen dat kan worden gevonden; deze worden genegeerd door browsers, en uiteindelijk verspillen ze alleen headerbytes. In grote lijnen vallen ze in twee categorieën:

* Verkeerd gespelde richtlijnen zoals `nocache` en `s-max-age` en ongeldige richtijnsyntaxis, zoals het gebruik van `:` in plaats van `=` of het gebruik van `_` in plaats van `-`.
* Niet-bestaande richtlijnen zoals `max-stale`, `proxy-public`, `surrogate-control`.

Het meest interessante hoogtepunt in de lijst met ongeldige richtlijnen is het gebruik van `no-cache="set-cookie"`—zelfs met slechts 0,2% van alle `Cache-Control`-headerwaarden, maakt het nog steeds meer uit dan alle andere ongeldige richtlijnen gecombineerd. In sommige vroege discussies over de `Cache-Control`-header, werd deze syntaxis verhoogd als een mogelijke manier om ervoor te zorgen dat `Set-Cookie`-reactieheaders (die gebruikersspecifiek kunnen zijn) niet met het object zelf in de cache zouden worden opgeslagen door tussenliggende proxy's zoals CDN's. Deze syntaxis was echter niet opgenomen in de uiteindelijke RFC. Bijna gelijkwaardige functionaliteit kan worden geïmplementeerd met behulp van de `private`-richtlijn, en de `no-cache`-richtlijn staat geen waarde toe.

## `Cache-Control`: `no-store`, `no-cache` en `max-age=0`

Als een reactie absoluut niet in de cache mag worden opgeslagen, moet de `Cache-Control no-store`-richtlijn worden gebruikt; als deze instructie niet is gespecificeerd, wordt de reactie *als cachebaar beschouwd en kan het in de cache worden opgeslagen*. Merk op dat als `no-store` is gespecificeerd, dit voorrang heeft op andere richtlijnen. Dit is logisch, aangezien ernstige privacy- en beveiligingsproblemen kunnen optreden als een bron in de cache wordt opgeslagen, wat niet zou moeten.

We kunnen een paar veelvoorkomende fouten zien die worden gemaakt bij het configureren van een reactie dat niet in het cachegeheugen kan worden opgeslagen:

* Het specificeren van `Cache-Control: no-cache` klinkt misschien als een richtlijn om de bron niet in de cache te plaatsen. Echter, zoals hierboven opgemerkt, staat de `no-cache`-richtlijn toe dat de bron in de cache wordt opgeslagen—het informeert de browser eenvoudigweg om de bron opnieuw te valideren voorafgaand aan gebruik en is niet hetzelfde als het helemaal stoppen van de bron in de cache.
* Het instellen van `Cache-Control: max-age=0` stelt de TTL in op 0 seconden, maar nogmaals, dat is niet hetzelfde als niet-cachebaar zijn. Wanneer `max-age=0` gespecificeerd is, wordt de bron in de cache opgeslagen, maar wordt deze gemarkeerd als verouderd, waardoor de browser de versheid onmiddellijk opnieuw moet valideren.

Functioneel gezien zijn `no-cache` en `max-age=0` vergelijkbaar, aangezien ze beide herbevestiging van een gecachte bron vereisen. De `no-cache`-richtlijn kan ook worden gebruikt naast een `max-age`-richtlijn die groter is dan 0—dit heeft tot gevolg dat het object in de cache wordt opgeslagen voor de opgegeven TTL, maar vóór elk gebruik opnieuw wordt gevalideerd.

Als we kijken naar de drie hierboven besproken richtlijnen, bevat 2,7% van de reacties de combinatie van alle drie de richtlijnen `no-store`, `no-cache` en `max-age=0`. 6,7% van de reacties bevat zowel `no-store` als `no-cache`, en een verwaarloosbaar aantal reacties (<0,15%) omvat alleen `no-store`.

Zoals hierboven opgemerkt, waar `no-store` is gespecificeerd met een/beide van `no-cache` en `max-age=0`, heeft de `no-store`-richtlijn voorrang en worden de andere richtlijnen genegeerd. Daarom, als u niet wilt dat de inhoud ergens in de cache wordt opgeslagen, is het voldoende om `Cache-Control: no-store` te specificeren en dit is ook eenvoudiger en gebruikt het minimum aantal headerbytes.

De `max-age=0`-richtlijn is aanwezig op minder dan 2% van de reacties waarbij `no-store` niet is gespecificeerd. In dergelijke gevallen wordt de bron in de cache opgeslagen in de browser, maar moet deze opnieuw worden gevalideerd omdat deze onmiddellijk als verouderd wordt gemarkeerd.

## Voorwaardelijke verzoeken en herbevestiging

Er zijn vaak gevallen waarin een browser eerder een object heeft aangevraagd en het al in de cache heeft, maar de cache-invoer de TTL al heeft overschreden (en daarom is gemarkeerd als verouderd) of waarin het object is gedefinieerd als een object dat opnieuw moet worden gevalideerd voorafgaand aan gebruik.

In deze gevallen kan de browser een voorwaardelijk verzoek aan de server doen—in feite zegt het "*Ik heb object X in mijn cache—kan ik het gebruiken of is er een recentere versie die ik in plaats daarvan moet gebruiken?*". De server kan op twee manieren reageren:

* "*Ja, de versie van object X die in de cache is, is prima om te gebruiken*": In dit geval bestaat de serverreactie uit een `304 Not Modified`-statuscode en reactieheaders, maar geen reactietekst
* "*Nee, hier is een recentere versie van object X—gebruik dit in plaats daarvan*": in dit geval bestaat het serverreactie uit een `200 OK`-statuscode, reactieheaders en een nieuwe reactietekst (de feitelijke nieuwe versie van object X)

In beide gevallen kan de server optioneel bijgewerkte caching-reactieheaders bevatten, waardoor mogelijk de TTL van het object wordt uitgebreid, zodat de browser het object voor een langere periode kan gebruiken zonder meer voorwaardelijke verzoeken te hoeven doen.

Het bovenstaande staat bekend als *herbevestiging* en kan, indien correct geïmplementeerd, de waargenomen prestatie aanzienlijk verbeteren, aangezien een `304 Not Modified`-reactie alleen uit headers bestaat, het veel kleiner is dan een `200 OK`-reactie, wat resulteert in een verminderde bandbreedte en een snellere reactie.

Dus hoe identificeert de server een voorwaardelijk verzoek van een regulier verzoek?

Het komt eigenlijk allemaal neer op de eerste aanvraag voor het object. Wanneer een browser een object opvraagt dat nog niet in de cache is opgeslagen, doet het gewoon een GET-verzoek, zoals dit (nogmaals, sommige headers zijn verwijderd voor de duidelijkheid):

```
> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*
```

Als de server wil dat de browser gebruik maakt van voorwaardelijke verzoeken (deze beslissing is geheel aan de server!), Kan het een of beide van twee reactieheaders bevatten die aangeven dat het object in aanmerking komt voor volgende voorwaardelijke verzoeken. De twee reactieheaders zijn:

* `Last-Modified`: Dit geeft aan wanneer het object voor het laatst is gewijzigd. De waarde ervan is een datum-tijdstempel.
* `ETag` (Entiteit-Tag): Dit biedt een unieke identificatie voor de inhoud als een tekenreeks tussen aanhalingstekens. Het kan elk formaat aannemen dat de server kiest; het is typisch een hash van de inhoud van het bestand, maar het zou een tijdstempel of een simpele tekenreeks kunnen zijn.

Als beide headers aanwezig zijn, heeft `ETag` voorrang.

### `Last-Modified`

Wanneer de server het verzoek voor het bestand ontvangt, kan het de datum/tijd waarop het bestand voor het laatst is gewijzigd als een reactieheader bevatten, zoals deze:

<pre><code>< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:04:17 GMT
< <span class="keyword">Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT</span>
< Cache-Control: max-age=600

...veel html hier...</code></pre>

De browser zal dit object 600 seconden cachen (zoals gedefinieerd in de `Cache-Control`-header), waarna het het object als oud markeert. Als de browser het bestand opnieuw moet gebruiken, vraagt hij het bestand op dezelfde manier aan bij de server als aanvankelijk, maar deze keer bevat het een extra verzoekheader, genaamd `If-Modified-Since`, die wordt ingesteld op de waarde die was doorgegeven in de `Last-Modified`-reactieheader in het eerste reactie:

<pre><code>> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*
> <span class="keyword">If-Modified-Since: Mon, 20 Jul 2020 11:43:22 GMT</span></code></pre>

Wanneer de server dit verzoek ontvangt, kan het controleren of het object is gewijzigd door de headerwaarde `If-Modified-Since` te vergelijken met de datum waarop het bestand voor het laatst is gewijzigd.

Als de twee waarden hetzelfde zijn, weet de server dat de browser de laatste versie van het bestand heeft en kan de server een `304 Not Modified`-reactie teruggeven met alleen headers (inclusief dezelfde `Last-Modified`-headerwaarde) en geen reactietekst:

```
< HTTP/2 304
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT
< Cache-Control: max-age=600
```

Als het bestand op de server echter is gewijzigd sinds het voor het laatst door de browser is aangevraagd, retourneert de server een `200 OK`-reactie bestaande uit headers (inclusief een bijgewerkte `Last-Modified`-header) en de nieuwe versie van het bestand in het lichaam:

```
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< Last-Modified: Thu, 23 Jul 2020 03:12:42 GMT
< Cache-Control: max-age=600

...lots of html here...
```

Zoals u kunt zien, werken de `Last-Modified`-reactieheader en de `If-Modified-Since`-verzoekheader als een paar.

### Entiteit-Tag (`ETag`)

De functionaliteit hier is bijna exact hetzelfde als de op datum gebaseerde `Last-Modified` / `If-Modified-Since` voorwaardelijke aanvraagverwerking zoals hierboven beschreven.

In dit geval stuurt de server echter een `ETag`-reactieheader—in plaats van een datum-tijdstempel. Een `ETag` is gewoon een tekenreeks en is vaak een hash van de bestandsinhoud of een versienummer berekend door de server. Het formaat van deze tekenreeks is geheel aan de server. Het enige belangrijke feit is dat de server de waarde van `ETag` wijzigt wanneer het bestand verandert.

In dit voorbeeld, wanneer de server het eerste verzoek voor het bestand ontvangt, kan het de bestandsversie retourneren in een `ETag`-reactieheader, zoals dit:

```
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:04:17 GMT
< ETag: "v123.4.01"
< Cache-Control: max-age=600

...lots of html here...
```

Net als bij het `If-Modified-Since`-voorbeeld hierboven, zal de browser dit object 600 seconden cachen, zoals gedefinieerd in de `Cache-Control`-header. Wanneer het object het object opnieuw van de server moet opvragen, bevat het een extra verzoekheader, genaamd `If-None-Match`, waarvan de waarde is doorgegeven in de `ETag`-reactieheader in het eerste reactie:

```
> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*
> If-None-Match: "v123.4.01"
```

Wanneer de server dit verzoek ontvangt, kan hij controleren of het object is gewijzigd door de headerwaarde `If-None-Match` te vergelijken met de huidige versie die het heeft van het bestand.

Als de twee waarden hetzelfde zijn, heeft de browser de laatste versie van het bestand en kan de server een `304 Not Modified`-reactie teruggeven met alleen headers:

```
< HTTP/2 304
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< ETag: "v123.4.01"
< Cache-Control: max-age=600
```

Als de waarden echter verschillen, is de versie van het bestand op de server recenter dan de versie die de browser heeft, dus retourneert de server een `200 OK`-reactie bestaande uit headers (inclusief een bijgewerkte `ETag`-header) en de nieuwe versie van het bestand:

```
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< ETag: "v123.5.06"
< Cache-Control: public, max-age=600

...lots of html here...
```

Opnieuw zien we dat er een paar headers wordt gebruikt voor deze voorwaardelijke aanvraagverwerking—de `ETag`-reactieheader en de `If-None-Match`-verzoekheader.

Op dezelfde manier dat de `Cache-Control`-header meer kracht en flexibiliteit heeft dan de `Expires` header, is de `ETag`-header in veel opzichten een verbetering ten opzichte van de `Last-Modified`-header. Hiervoor zijn twee redenen:

1. De server kan zijn eigen formaat definiëren voor de `ETag`-header. Het bovenstaande voorbeeld toont een versiereeks, maar het kan een hash of een willekeurige reeks zijn. Door dit toe te staan, worden versies van een object niet expliciet aan datums gekoppeld, en dit stelt een server in staat om een nieuwe versie van een bestand te maken en deze toch dezelfde ETag te geven als de vorige versie—misschien als de bestandswijziging onbelangrijk is.

2. `ETag`'s kunnen worden gedefinieerd als 'strong' (sterk) of 'weak' (zwak), waardoor browsers ze anders kunnen valideren. Een volledig begrip en bespreking van deze functionaliteit valt buiten het reikwijdte van dit hoofdstuk, maar is te vinden in <a hreflang="en" href="https://tools.ietf.org/html/rfc7232">RFC 7232</a>.

Echter, aangezien de `ETag` vaak gebaseerd is op de laatst gewijzigde tijd van de server, kan het in feite hetzelfde zijn in veel implementaties, en erger dan dat verschillende bugs in serverimplementaties (Apache in het bijzonder), <a hreflang="en" href="https://www.tunetheweb.com/performance/http-performance-headers/etag/#downsides">kan betekenen dat het minder effectief is om `ETag`'s te gebruiken</a>.

{{ figure_markup(
  image="last-modified-and-etag.png",
  caption="Overname van validatie van versheid via `Last-Modified`- en `ETag`-headers.",
  description="Een staafdiagram dat laat zien dat 73,5% van de desktopverzoeken een`Last-Modified` heeft, 47,9% heeft een `ETag`, 42,8% heeft beide en 21,4% heeft geen van beide. De statistieken voor mobiel zijn bijna identiek: 72,0% voor `Last-Modified`, 46,2% voor `ETag`, 41,0% voor beide en 22,9% voor geen van beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1171778982&format=interactive",
  sheets_gid="1084825476",
  sql_file="last_modified_and_etag.sql"
  )
}}

{{ figure_markup(
  image="last-modified-and-etag-2019.png",
  caption="Overname van validatie van versheid via `Last-Modified`- en `ETag`-headers in 2019.",
  description="Een staafdiagram dat aangeeft dat 72,7% van de desktopverzoeken een `Last-Modified` heeft, 48,0% heeft een `ETag`, 43,1% heeft beide en 22,4% heeft geen van beide. De statistieken voor mobiel zijn bijna identiek: 72,0% voor `Last-Modified`, 47,1% voor `ETag`, 42,1% voor beide en 23,1% voor geen van beide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1775409512&format=interactive",
  sheets_gid="1084825476",
  sql_file="last_modified_and_etag_2019.sql"
  )
}}

We kunnen zien dat 72,0% van de mobiele reacties wordt weergegeven met een `Last-Modified`-header. In vergelijking met 2019 is het gebruik op mobiele apparaten statisch gebleven, maar het is marginaal (met < 1%) op desktop gestegen.

Kijkend naar `ETag`-headers, 46,2% van de reacties op mobiele telefoons gebruikt dit. Van deze reacties is 34,38% *strong (sterk)*, 9,81% *weak (zwak)* en de overige 1,98% is ongeldig. In tegenstelling tot `Last-Modified` is het gebruik van `ETag`-headers marginaal afgenomen (met <1%) in vergelijking met 2019.

41,0% van de mobiele reacties wordt weergegeven met beide headers en, zoals hierboven vermeld, heeft de `ETag`-header voorrang in dit geval. 22,9% van de mobiele reacties bevat geen `Last-Modified`- of `ETag`-header.

Correct geïmplementeerde herbevestiging met behulp van voorwaardelijke verzoeken kan de bandbreedte (304 reacties zijn doorgaans veel kleiner dan 200 reacties), server belasting (slechts een kleine hoeveelheid verwerking is vereist om wijzigingsdatums of hashes te vergelijken) en de waargenomen verbeterde prestaties aanzienlijk verminderen (servers reageren sneller met een 304). Zoals we echter kunnen opmaken uit de bovenstaande statistieken, maakt meer dan een vijfde van alle verzoeken geen gebruik van enige vorm van voorwaardelijke verzoeken.

Slechts 0,1% van de reacties had de status `304 Not Modified` tijdens onze crawl, hoewel dit niet onverwacht is aangezien onze crawl een lege cache gebruikt en 304 reacties vooral nuttig zijn voor volgende bezoeken die onze [Methodologie](./methodology) niet voor test. Toch hebben we deze geanalyseerd om te zien hoe de 304 werd gebruikt.

{{ figure_markup(
  image="valid-if-none-match-returns-304.png",
  caption="Verdeling van de status `304 Not Modified`.",
  description="Staafdiagram met de verdeling van de status `304 Not Modified`. 20,5% van de desktop reacties had geen `ETag`-header en bevatte dezelfde `Last-Modified`-waarde, doorgegeven in de `If-Modified-Since`-header van het overeenkomstige verzoek. Hiervan had 86% de status `304 Not Modified`. 86,1% van de reacties bevatte dezelfde `ETag`-waarde, doorgegeven in de `If-None-Match`-header van het corresponderende verzoek. Hiervan had 88,9% de status `304 Not Modified`. 17,2% van de mobiele reacties had geen `ETag`-header en bevatte dezelfde `Last-Modified`-waarde, doorgegeven in de `If-Modified-Since`-header van het overeenkomstige verzoek. Hiervan had 78,3% de status `304 Not Modified`. 89,9% van de reacties bevatte dezelfde `ETag`-waarde, doorgegeven in de `If-None-Match`-header van het corresponderende verzoek. Hiervan had 90,2% de status `304 Not Modified`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1530788258&format=interactive",
  sheets_gid="1705717345",
  sql_file="valid_if_none_match_returns_304.sql"
  )
}}

We zien dat 17,2% van de mobiele reacties (20,5% op desktop) geen `ETag`-header had en dezelfde `Last-Modified`-waarde bevatte, doorgegeven in de `If-Modified-Since`-header van het overeenkomstige verzoek. Hiervan had 78,3% (86% op desktop) de status `304 Not Modified`.

89,9% van de mobiele reacties (86,1% op desktop) bevatte dezelfde `ETag`-waarde, doorgegeven in de `If-None-Match`-header van het overeenkomstige verzoek. Als de `If-Modified-Since`-header ook aanwezig is, heeft `ETag` voorrang. Hiervan had 90,2% (88,9% op desktop) de status `304 Not Modified`.

## Geldigheid van datumreeksen

In dit document hebben we verschillende caching-gerelateerde HTTP-headers besproken die worden gebruikt om tijdstempels over te brengen:

* De `Date`-reactieheader geeft aan wanneer de bron aan een cliënt is geleverd.
* De `Last-Modified`-reactieheader geeft aan wanneer een bron voor het laatst gewijzigd is op de server.
* De `Expires`-header wordt gebruikt om aan te geven hoe lang een bron in de cache kan worden opgeslagen.

Alle drie deze HTTP-headers gebruiken een tekenreeks met datumopmaak om tijdstempels weer te geven. De op datum opgemaakte tekenreeks is gedefinieerd in <a hreflang="en" href="https://tools.ietf.org/html/rfc2616#section-3.3.1">RFC 2616</a>, en moet een GMT-tijdstempelreeks.
Bijvoorbeeld:

```
> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*

< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< Cache-Control: max-age=600
< Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT
```

Ongeldige datumreeksen worden door de meeste browsers genegeerd, wat van invloed kan zijn op de cachemogelijkheden van het antwoord waarop ze worden aangeboden. Een ongeldige `Last-Modified`-header zal er bijvoorbeeld toe leiden dat de browser vervolgens geen voorwaardelijk verzoek voor het object kan uitvoeren, aangezien het in de cache wordt opgeslagen zonder dat ongeldige tijdstempel.

{{ figure_markup(
  image="invalid-last-modified-and-expires-and-date.png",
  caption="Ongeldige datumnotaties in antwoord-headers.",
  description="Staafdiagram met de distributie van ongeldige datum. 0,1% van de desktopreacties heeft een ongeldige datum in `Date`, 0,5% in `Last-Modified` en 2,5% in `Expires`. De statistieken voor mobiel lijken erg op elkaar: 0,1% van de reacties heeft een ongeldige datum in `Date`, 0,7% in `Last-Modified` en 2,9% in `Expires`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=827586570&format=interactive",
  sheets_gid="1338572274",
  sql_file="invalid_last_modified_and_expires_and_date.sql"
  )
}}

Omdat de `Date` HTTP-reactieheader bijna altijd automatisch wordt gegenereerd door de webserver, zijn ongeldige waarden uiterst zeldzaam. Evenzo hadden van `Last-Modified`-headers een zeer laag percentage (0,75% op mobiel en 0,5% op desktop) ongeldige waarden. Wat echter zeer verrassend was, was dat een relatief hoge 2,94% van de `Expires`-headers een ongeldige datumnotatie gebruikte (2,5% op desktop).

Voorbeelden van sommige van de ongeldige toepassingen van de `Expires`-header zijn:

* Geldige datumnotaties, maar met een andere tijdzone dan GMT
* Numerieke waarden zoals 0 of -1
* Waarden die geldig zouden zijn in een `Cache-Control`-header

Een grote bron van ongeldige '`Expires`-headers is afkomstig van items die worden aangeboden door een populaire derde partij, waarbij een datum/tijd de EST-tijdzone gebruikt, bijvoorbeeld `Expires: Tue, 27 Apr 1971 19:44:06 EST`. Merk op dat sommige browsers dit datumnotatie kunnen begrijpen en accepteren, op basis van het robuustheidsprincipe, maar er mag niet van worden uitgegaan dat dit het geval zal zijn.

## De `Vary`-header

We hebben besproken hoe een caching-entiteit kan bepalen of een reactieobject cacheerbaar is, en hoe lang het in de cache kan worden bewaard. Een van de belangrijkste stappen die de caching-entiteit moet nemen, is echter bepalen of de gevraagde bron zich al in de cache bevindt. Hoewel dit misschien eenvoudig lijkt, is de URL alleen vaak niet voldoende om dit te bepalen. Verzoeken met dezelfde URL kunnen bijvoorbeeld variëren in welke compressie ze gebruiken (Gzip, Brotli, enz.) of kunnen worden geretourneerd in verschillende coderingen (XML, JSON enz.).

Om dit probleem op te lossen, geeft een caching-entiteit een object in de cache een unieke identificatie (een cachesleutel). Wanneer het moet bepalen of het object zich in de cache bevindt, controleert het of het object bestaat met behulp van de cachesleutel als zoekactie. Standaard is deze cachesleutel gewoon de URL die wordt gebruikt om het object op te halen, maar servers kunnen de caching-entiteit vertellen om andere attributen van het antwoord (zoals de compressiemethode) op te nemen in de cachesleutel, door de `Vary`-antwoordheader op te nemen. De `Vary`-header identificeert varianten van het object, gebaseerd op andere factoren dan de URL.

De `Vary`-antwoordheader instrueert de browser om de waarde van een of meer verzoekheaderwaarden toe te voegen aan de cachesleutel. Het meest voorkomende voorbeeld hiervan is `Vary: Accept-Encoding`, wat ertoe zal leiden dat de browser hetzelfde object in verschillende formaten cachet, gebaseerd op de verschillende `Accept-Encoding` verzoekheader-waarden (bijv. `Gzip`, `br` , `deflate`).

Een caching-entiteit verzendt een verzoek voor een HTML-bestand, waarmee wordt aangegeven dat het een gzip-antwoord accepteert:

```
> GET /index.html HTTP/2
> Host: www.example.org
> Accept-Encoding: gzip
```

De server reageert met het object en geeft aan dat de versie die het verzendt de waarde van de `Accept-Encoding` verzoekheader moet bevatten.

```
< HTTP/2 200 OK
< Content-Type: text/html
< Vary: Accept-Encoding
```

In dit vereenvoudigde voorbeeld zou de caching-entiteit het object cachen met behulp van een combinatie van de URL en de `Vary`-header.

Een andere veel voorkomende waarde is `Vary: Accept-Encoding, User-Agent`, die de cliënt instrueert om zowel de waarden `Accept-Encoding` als `User-Agent` in de cachesleutel op te nemen. Bij het bespreken van gedeelde proxy's en CDN's kan het gebruik van andere waarden dan `Accept-Encoding` echter problematisch zijn omdat het de cache verdunt of fragmenteert en de hoeveelheid verkeer die vanuit de cache wordt bediend, kan verminderen. Er zijn bijvoorbeeld duizenden verschillende varianten van `User-Agent`, dus als een CDN probeert om veel verschillende varianten van een object te cachen, kan het uiteindelijk de cache vullen met veel bijna identieke (of zelfs identieke) gecachte objecten. Dit is erg inefficiënt en kan leiden tot een zeer suboptimale caching binnen het CDN, wat resulteert in minder cache-hits en een grotere latentie.

Over het algemeen moet u de cache alleen variëren als u alternatieve inhoud aan cliënten aanbiedt op basis van die header.

De `Vary`-header wordt gebruikt voor 43,4% van de HTTP-reacties, en 84,2% van deze reacties bevat een `Cache-Control`-header.

In de onderstaande grafiek wordt de populariteit van de top 10 Vary-headerwaarden weergegeven. `Accept-Encoding` is goed voor bijna 92% van het gebruik van `Vary`, met `User-Agent` voor 10,7%, `Origin` (gebruikt voor CORS-verwerking) voor 8% en `Accept` voor 4,1% voor een groot deel van de rest.

{{ figure_markup(
  image="vary-headers.png",
  caption="Gebruik van `Vary`-header",
  description="Staafdiagram met de verdeling van de `Vary`-header. 91,8% van de desktopreacties gebruikt `Accept-Encoding`, veel kleinere waarden voor de rest met 10,7% voor `User-Agent`, ongeveer 8,0% voor `Origin` en 0,5%-4,1% voor `Accept`, `Access-Control-Request-Headers`, `Access-Control-Request-Method`, `Cookie`, `X-Forwarded-Proto`, `Accept-Language`, en `Range`. 91,3% van de mobiele reacties gebruikt `Accept-Encoding`, veel kleinere waarden voor de rest met 11,0% voor `User-Agent`, ongeveer 9,1% voor `Origin` en 0,6%-3,9% voor `Accept`, `Access-Control-Request-Headers`, `Access-Control-Request-Method`, `Cookie`, `X-Forwarded-Proto`, `Accept-Language`, en `Range`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=317375276&format=interactive",
  sheets_gid="1115686547",
  sql_file="vary_headers.sql"
  )
}}

## Cookies instellen voor cachebare reacties

Wanneer een reactie in de cache wordt opgeslagen, wordt de volledige set reactie-headers ook bij het in de cache opgeslagen object opgenomen. Dit is de reden waarom u de reactie-headers kunt zien wanneer u een reactie in de cache in Chrome inspecteert via DevTools:

{{ figure_markup(
  image="chrome-dev-tools.png",
  caption="Chrome Dev Tools voor een bron in het cachegeheugen.",
  description="Chrome Dev Tools die laten zien dat wanneer een antwoord in de cache wordt opgeslagen, de volledige set reactie-headers ook bij het in de cache opgeslagen object wordt meegeleverd."
  )
}}

Maar wat gebeurt er als u een `Set-Cookie` op een reactie krijgt? Volgens <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-8">RFC 7234 Sectie 8</a>, remt de aanwezigheid van een `Set-Cookie`-reactie-header de caching niet. Dit betekent dat een item in de cache een `Set-Cookie`-reactie-header kan bevatten. De RFC raadt u verder aan om de juiste `Cache-Control`-headers te configureren om te bepalen hoe reacties in het cachegeheugen worden opgeslagen.

Aangezien we het voornamelijk hebben gehad over browsercaching, denkt u misschien dat dit geen groot probleem is—de `Set-Cookie`-reactie-headers die door de server naar mij zijn gestuurd in reacties op mijn verzoeken bevatten duidelijk mijn cookies, dus er is geen probleem als mijn browser ze in de cache opslaat. Als er echter een CDN is tussen mij en de server, moet de server aan het CDN aangeven dat het antwoord niet in de cache in het CDN zelf moet worden bewaard, zodat het voor mij bedoelde antwoord niet in de cache wordt opgeslagen en vervolgens wordt geserveerd (inclusief mijn `Set-Cookie`-headers!) aan andere gebruikers.

Als er bijvoorbeeld een inlogcookie of een sessiecookie aanwezig is in het gecachte object van een CDN, kan die cookie mogelijk worden hergebruikt door een andere cliënt. De belangrijkste manier om dit te vermijden is dat de server de `Cache-Control: private`-richtlijn verzendt, die het CDN vertelt het antwoord niet in de cache te plaatsen, omdat het alleen door de cliëntbrowser in het cachegeheugen kan worden opgeslagen.

{{ figure_markup(
  image="set-cookie-usage-on-cacheable-responses.png",
  caption="`Set-Cookie` in cachebare reacties.",
  description="Een staafdiagram dat het gebruik van `Set-Cookie` op cachebare reacties laat zien. 41,4% van de cachebare desktopreacties en 40,4% van de cachebare mobiele reacties bevatten een `Set-Cookie`-header.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1106475158&format=interactive",
  sheets_gid="1263250537",
  sql_file="set_cookie.sql"
  )
}}

40,4% van de cachebare mobiele reacties bevat een `Set-Cookie`-header. Van die reacties gebruikt slechts 4,9% de `private`-richtlijn. De overige 95,1% (198,6 miljoen HTTP-reacties) bevat ten minste één `Set-Cookie`-reactie-header en kan worden gecached door beide openbare cacheservers, zoals CDN's. Dit is zorgwekkend en kan duiden op een aanhoudend gebrek aan begrip over hoe cachemogelijkheden en cookies naast elkaar bestaan.

{{ figure_markup(
  image="set-cookie-usage-on-private-and-non-private-cacheable-responses.png",
  caption="`Set-Cookie` in `private` en niet-_private_ cachebare reacties.",
  description="Een staafdiagram dat het gebruik van `Set-Cookie` in `privé` en niet-_private_ cachebare reacties weergeeft. Van de desktopreacties die een `Set-Cookie`-header bevatten, gebruikt 4,6% de `private`-richtlijn. 95,4% van de reacties kan in de cache worden opgeslagen door zowel privé- als openbare cacheservers. Van de mobiele reacties die een `Set-Cookie`-header bevatten, gebruikt 4,9% de `private`-richtlijn. 95,1% van de reacties kan in de cache worden opgeslagen door zowel privé- als openbare cacheservers.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=97044455&format=interactive",
  sheets_gid="1263250537",
  sql_file="set_cookie.sql"
  )
}}

## Service workers

Service workers zijn een functie van HTML5 waarmee front-endontwikkelaars scripts kunnen specificeren die buiten de normale aanvraag- /reactiestroom van webpagina's moeten worden uitgevoerd en die via berichten met de webpagina moeten communiceren. Veelgebruikte toepassingen van service workers zijn voor synchronisatie op de achtergrond en pushmeldingen en, uiteraard, voor caching—en browserondersteuning is voor hen snel gegroeid.

{{ figure_markup(
  image="service-workers-controlled-pages-2019-2020.png",
  caption="Groei in door service workers gecontroleerde pagina's vanaf 2019.",
  description="Een staafdiagram met de groei van pagina's die door service workers worden beheerd. De adoptie is gegroeid van 0,6% in 2019 naar 1,0% in 2020",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=893877591&format=interactive",
  sheets_gid="2082343974",
  sql_file="appcache_and_serviceworkers_2019.sql"
  )
}}

Adoptie is slechts bij 1% van de websites, maar het neemt gestaag toe sinds juli 2019. Het hoofdstuk [Progressieve Web App](./pwa) bespreekt dit meer, inclusief het feit dat het veel meer wordt gebruikt dan deze grafiek doet vermoeden. aan het gebruik ervan op populaire sites, die in de bovenstaande grafiek maar één keer worden meegeteld.

<figure>
  <table>
    <tr>
      <th>Sites die geen service workers gebruiken</th>
      <th>Sites die service workers gebruiken</th>
      <th>Totaal aantal sites</th>
    </tr>
    <tr>
      <td class="numeric">6.225.774</td>
      <td class="numeric">64.373</td>
      <td class="numeric">6.290.147</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Aantal websites dat service workers gebruikt.", sheets_gid="2106765718", sql_file="appcache_and_serviceworkers.sql") }}</figcaption>
</figure>

In de bovenstaande tabel kunt u zien dat 64.373 van de in totaal 6.290.147 websites een service worker hebben geïmplementeerd.

<figure>
  <table>
    <tr>
      <th>HTTP-Sites</th>
      <th>HTTPS-Sites</th>
      <th>Totaal aantal sites</th>
    </tr>
    <tr>
      <td class="numeric">1.469</td>
      <td class="numeric">62.904</td>
      <td class="numeric">64.373</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Aantal websites dat gebruikmaakt van service workers via HTTP/HTTPS.", sheets_gid="2106765718", sql_file="appcache_and_serviceworkers.sql") }}</figcaption>
</figure>

Als we dit doorbreken via HTTP versus HTTPS, wordt dit nog interessanter. Hoewel HTTPS een vereiste is voor het gebruik van service workers, laat de volgende tabel zien dat 1469 van de sites die deze gebruiken, bediend worden via HTTP.

## Welk type inhoud plaatsen we in het cachegeheugen?

Zoals we hebben gezien, wordt een cachebare bron gedurende een bepaalde tijd door de browser opgeslagen en is deze beschikbaar voor hergebruik bij volgende verzoeken.

{{ figure_markup(
  image="cacheable-and-non-cacheable.png",
  caption="Verdeling van cachebare en niet-cachebare responsen.",
  description="Een staafdiagram met het aandeel van de cachebare reacties. 9,2% van de desktop- en 9,6% van de mobiele reacties kan in het cachegeheugen worden opgeslagen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=430652203&format=interactive",
  sheets_gid="391853872",
  sql_file="ttl.sql"
  )
}}

Bij alle HTTP(S) verzoeken wordt 90,4% van de reacties als cachebaar beschouwd, wat betekent dat een cache ze mag opslaan. De resterende 9,6% van de reacties mag niet worden opgeslagen in browsercaches—meestal vanwege `Cache-Control: no-store`.

{{ figure_markup(
  image="ttl-cachable-responses.png",
  caption="Verdeling van TTL in cachebare reacties.",
  description="Een staafdiagram met de verdeling van TTL in cachebare reacties. 4,2% van de desktopreacties heeft een TTL-nul, 59,4% heeft een TTL-waarde die groter is dan nul en 28,2% gebruikt een heuristische TTL. 4,2% van de mobiele reacties heeft een TTL-nul, 58,8% heeft een TTL-waarde die groter is dan nul en 28,4% gebruikt een heuristische TTL.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1365998611&format=interactive",
  sheets_gid="391853872",
  sql_file="ttl.sql"
  )
}}

Als we wat dieper graven, zien we dat 4,1% van de verzoeken een TTL van 0 seconden heeft, waardoor het object wordt toegevoegd aan de cache, maar onmiddellijk wordt gemarkeerd als verouderd en opnieuw moet worden gevalideerd. 28,4% wordt heuristisch gecached vanwege een gebrek aan een `Cache-Control` of `Expires`-header en 58,8% wordt langer dan 0 seconden in de cache geplaatst.

In de onderstaande tabel worden de cache-TTL-waarden voor mobiele verzoeken per type beschreven:

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Type</th>
        <th scope="col">10</th>
        <th scope="col">25</th>
        <th scope="col">50</th>
        <th scope="col">75</th>
        <th scope="col">90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Audio</td>
        <td class="numeric">6</td>
        <td class="numeric">6</td>
        <td class="numeric">240</td>
        <td class="numeric">744</td>
        <td class="numeric">8.760</td>
      </tr>
      <tr>
        <td>CSS</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">720</td>
        <td class="numeric">8.760</td>
        <td class="numeric">8.760</td>
      </tr>
      <tr>
        <td>Lettertype</td>
        <td class="numeric">720</td>
        <td class="numeric">8.760</td>
        <td class="numeric">8.760</td>
        <td class="numeric">8.760</td>
        <td class="numeric">8.760</td>
      </tr>
      <tr>
        <td>HTML</td>
        <td class="numeric">0</td>
        <td class="numeric">3</td>
        <td class="numeric">336</td>
        <td class="numeric">8.760</td>
        <td class="numeric">8.600</td>
      </tr>
      <tr>
        <td>Afbeelding</td>
        <td class="numeric">6</td>
        <td class="numeric">168</td>
        <td class="numeric">720</td>
        <td class="numeric">8.760</td>
        <td class="numeric">8.766</td>
      </tr>
      <tr>
        <td>Overig</td>
        <td class="numeric">0</td>
        <td class="numeric">3</td>
        <td class="numeric">31</td>
        <td class="numeric">336</td>
        <td class="numeric">23.557</td>
      </tr>
      <tr>
        <td>Script</td>
        <td class="numeric">0</td>
        <td class="numeric">4</td>
        <td class="numeric">720</td>
        <td class="numeric">8.760</td>
        <td class="numeric">8.760</td>
      </tr>
      <tr>
        <td>Tekst</td>
        <td class="numeric">0</td>
        <td class="numeric">1</td>
        <td class="numeric">6</td>
        <td class="numeric">24</td>
        <td class="numeric">8.760</td>
      </tr>
      <tr>
        <td>Video</td>
        <td class="numeric">6</td>
        <td class="numeric">336</td>
        <td class="numeric">336</td>
        <td class="numeric">336</td>
        <td class="numeric">8.674</td>
      </tr>
      <tr>
        <td>XML</td>
        <td class="numeric">1</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">720</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="TTL in uren voor mobiele cache per percentielen en brontype.", sheets_gid="676954337", sql_file="ttl_by_resource.sql") }}</figcaption>
</figure>

Hoewel de meeste mediane TTL's hoog zijn, benadrukken de lagere percentielen enkele van de gemiste cachemogelijkheden. De mediane TTL voor afbeeldingen is bijvoorbeeld 720 uur (1 maand); het 25<sup>e</sup> percentiel is echter slechts 168 uur (1 week) en het 10<sup>de</sup> percentiel is gedaald tot slechts een paar uur. Vergelijk dit met lettertypen, die een zeer hoge TTL hebben van 8.760 uur (1 jaar) helemaal tot aan het 25<sup>e</sup> percentiel, waarbij zelfs het 10<sup>de</sup> percentiel een TTL van 1 maand laat zien.

Door de cachemogelijkheden per inhoudstype in de onderstaande afbeelding gedetailleerder te onderzoeken, kunnen we zien dat hoewel lettertypen, video en audio en CSS-bestanden bijna 100% in de browsercache worden opgeslagen (wat logisch is, aangezien deze bestanden doorgaans erg statisch zijn), ongeveer een derde van alle HTML-reacties wordt als niet-cachebaar beschouwd.

{{ figure_markup(
  image="cacheable-by-resource-type.png",
  caption="Verdeling van cachemogelijkheden per inhoudstype.",
  description="Een staafdiagram met de verdeling van cachebare brontypen. In desktopreacties, 99,3% van audio, 99,3% van CSS, 99,8% van lettertype, 67,9% van HTML, 91,2% van afbeeldingen, 66,3% van andere typen, 95,2% van scripts, 78,6% van tekst, 99,6% van video, en 81,4% van xml is cacheerbaar. In mobiele reacties, 99,0% van audio, 99,0% van CSS, 99,8% van lettertype, 71,5% van HTML, 89,9% van afbeeldingen, 67,9% van andere typen, 95,1% van scripts, 78,4% van tekst, 99,7% van video, en 80,6% van xml is cacheerbaar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1283939423&format=interactive",
  sheets_gid="220584548",
  sql_file="non_cacheable_by_resource_type.sql"
  )
}}

Bovendien zijn 10,1% van de afbeeldingen en 4,9% van de scripts op desktop niet cacheerbaar. Er is hier waarschijnlijk enige ruimte voor verbetering, aangezien sommige van deze objecten ongetwijfeld ook statisch zijn en met een hogere snelheid in de cache kunnen worden opgeslagen—onthoud: *cache zo veel als u kunt zo lang als u kunt!*

## Hoe verhouden cache-TTL's zich tot de leeftijd van bronnen?

Tot nu toe hebben we gesproken over hoe servers een cliënt vertellen wat cacheerbaar is en hoe lang het in de cache is opgeslagen. Bij het ontwerpen van cacheregels is het ook belangrijk om te begrijpen hoe oud de inhoud die u aanbiedt is.

Wanneer u een cache-TTL selecteert om in reactie-headers te specificeren om terug te sturen naar de cliënt, vraag uzelf dan af: "hoe vaak werk ik deze middelen bij?" en "wat is hun inhoudsgevoeligheid?". Als een hero-afbeelding bijvoorbeeld niet vaak wordt gewijzigd, kan deze in de cache worden opgeslagen met een zeer lange TTL. Als een JavaScript-bestand daarentegen vaak verandert, moet het ofwel worden voorzien van een versie, bijvoorbeeld met een unieke queryreeks, en in de cache worden opgeslagen met een lange TTL, of moet het worden gecached met een veel kortere TTL.

De onderstaande grafieken illustreren de relatieve ouderdom van bronnen per inhoudstype.

{{ figure_markup(
  image="resource-age-party-and-type-wise-groups-1st-party.png",
  caption="Bron leeftijd per inhoudstype (1e Partij).",
  description="Een gestapeld staafdiagram met de leeftijd van de inhoud, opgesplitst in weken 0-52, > een jaar en > twee jaar met ook nul- en negatieve cijfers. De statistieken zijn opgesplitst in eerste-partij en derde-partij. De waarde 0 wordt vooral gebruikt voor eerste-partij HTML, tekst en xml, en voor maximaal 50% van de verzoeken van derden voor alle activatypen. Er is een mix met tussenjaren en daarna een aanzienlijk gebruik voor één jaar en twee jaar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=2056330432&format=interactive",
  sheets_gid="1889235328",
  sql_file="resource_age_party_and_type_wise_groups.sql"
  )
}}

{{ figure_markup(
  image="resource-age-party-and-type-wise-groups-3rd-party.png",
  caption="Bron leeftijd per inhoudstype (derde Partij).",
  description="Een gestapeld staafdiagram met de leeftijd van de inhoud, opgesplitst in weken 0-52, > een jaar en > twee jaar met ook nul- en negatieve cijfers. De statistieken zijn opgesplitst in eerste-partij en derde-partij. De waarde 0 wordt vooral gebruikt voor eerste-partij HTML, tekst en xml, en voor maximaal 50% van de verzoeken van derden voor alle activatypen. Er is een mix met tussenjaren en daarna een aanzienlijk gebruik voor één jaar en twee jaar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=859132635&format=interactive",
  sheets_gid="1889235328",
  sql_file="resource_age_party_and_type_wise_groups.sql"
  )
}}

Enkele van de interessante observaties in deze gegevens zijn:

* Eerste-partij HTML is het inhoudstype met de kortste leeftijd: 41,1% van de verzoeken heeft een leeftijd van minder dan een week. In de meeste andere inhoudstypen heeft inhoud van derden een kleinere bron-leeftijd dan inhoud van de eerste partij.
* Enkele van de oudste eerste-partij inhoud op internet, met een leeftijd van acht weken of ouder, zijn de traditioneel cachebare objecten zoals afbeeldingen (78,9%), scripts (68,7%), CSS (74,9%), weblettertypen (80,4%) , audio (78,2%) en video (79,3%).
* Er is een aanzienlijke kloof tussen sommige bronnen van eerste en derde partijen met een leeftijd van meer dan een week. 93,4% van de eerste-partij CSS is ouder dan een week, vergeleken met 48,0% van de derde-partij CSS, die ouder is dan een week.

Door de cachemogelijkheden van een bron te vergelijken met de leeftijd, kunnen we bepalen of de TTL geschikt of te laag is.

De bron die hieronder op 18 oktober 2020 wordt weergegeven, is bijvoorbeeld voor het laatst gewijzigd op 30 augustus 2020, wat betekent dat het op het moment van levering ruim een maand oud was—dit geeft aan dat het een object is dat niet vaak verandert. De `Cache-Control`-header zegt echter dat de browser het slechts 86.400 seconden (één dag) kan cachen. Dit is een geval waarin een langere TTL geschikt kan zijn om te voorkomen dat de browser dit opnieuw moet aanvragen, zelfs onder voorwaarden, vooral als de website een website is die een gebruiker in de loop van meerdere dagen meerdere keren zou kunnen bezoeken.

```
> HTTP/1.1 200
> Date: Sun, 18 Oct 2020 19:36:57 GMT
> Content-Type: text/html; charset=utf-8
> Content-Length: 3052
> Vary: Accept-Encoding
> Last-Modified: Sun, 30 Aug 2020 16:00:30 GMT
> Cache-Control: public, max-age=86400
```

In totaal heeft 60,2% van de mobiele bronnen die op internet worden aangeboden, een cache-TTL die als te kort kan worden beschouwd in vergelijking met de leeftijd van de inhoud. Bovendien is de mediane delta tussen de TTL en de leeftijd 25 dagen—wederom een indicatie van significante ondercaching.

<figure>
  <table>
    <tr>
      <th>Cliënt</th>
      <th>1e partij</th>
      <th>3e partij</th>
      <th>Globaal</th>
    </tr>
    <tr>
      <td>desktop</td>
      <td class="numeric">61,6%</td>
      <td class="numeric">59,3%</td>
      <td class="numeric">60,7%</td>
    </tr>
    <tr>
      <td>mobiel</td>
      <td class="numeric">61,8%</td>
      <td class="numeric">57,9%</td>
      <td class="numeric">60,2%</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Percentage verzoeken met korte TTL's.", sheets_gid="1706274506", sql_file="content_age_older_than_ttl_by_party.sql") }}</figcaption>
</figure>

Wanneer we dit uitsplitsen naar eerste-partij versus derde-partij in de bovenstaande tabel, kunnen we zien dat bijna tweederde (61,8%) van de eerste-partij bronnen kan profiteren van een langere TTL. Dit benadrukt duidelijk de noodzaak om extra aandacht te besteden aan wat cachebaar is, en er vervolgens voor te zorgen dat caching correct is geconfigureerd.

## Mogelijkheden voor caching identificeren

Met de <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>-hulpmiddel van Google kunnen gebruikers een reeks audits uitvoeren op webpagina's, en de <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/cache-policy">cachebeleidscontrole</a> evalueert of een site kan profiteren van extra caching. Het doet dit door de inhoudsleeftijd (via de `Last-Modified`-header) te vergelijken met de cache-TTL en door de waarschijnlijkheid te schatten dat de bron vanuit de cache wordt bediend. Afhankelijk van de score ziet u mogelijk een aanbeveling voor caching in de resultaten, met een lijst met specifieke bronnen die in de cache kunnen worden opgeslagen.

{{ figure_markup(
  image="lighthouse-caching-audit.png",
  caption="Lighthouse-rapport met mogelijke verbeteringen van het cachebeleid.",
  description="Uittreksel uit het Lighthouse-rapport met mogelijke verbeteringen in het cachebeleid. De eerste en derde partij-URL's, hun cache-TTL en grootte worden weergegeven."
  )
}}

Lighthouse berekent voor elke audit een score, variërend van 0% tot 100%, en die scores worden vervolgens meegenomen in de totaalscores. De cachingscore is gebaseerd op mogelijke bytebesparingen. Als we de resultaten van Lighthouse bekijken, kunnen we een idee krijgen van hoeveel sites het goed doen met hun cachebeleid.

{{ figure_markup(
  image="cache-ttl-lighthouse-score.png",
  caption="Verdeling van de TTL-score van Lighthouse caching.",
  description="Een staafdiagram dat de verdeling van de Lighthouse-auditscores toont voor de `uses-long-cache-ttl` voor mobiele webpagina's. 37,5% van de reacties heeft een score lager dan 0,10, 28,8% heeft een score tussen 0,10-0,39, 17,7% heeft een score tussen 0,40-0,79 en 12,1% heeft een score tussen 0,80-0,99. 3,3% heeft een score van 1 en 0,6% heeft geen score.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=637059966&format=interactive",
  sheets_gid="1554485361",
  sql_file="cache_ttl_lighthouse_score.sql"
  )
}}

Slechts 3,3% van de sites scoorde 100%, wat betekent dat de overgrote meerderheid van de sites waarschijnlijk kan profiteren van enkele cache-optimalisaties. Ongeveer tweederde van de sites scoort onder de 40%, terwijl bijna een derde van de sites minder dan 10% scoort. Op basis hiervan is er een aanzienlijke hoeveelheid ondercaching, wat resulteert in overmatige verzoeken en bytes die via het netwerk worden geserveerd.

Lighthouse geeft ook aan hoeveel bytes kunnen worden opgeslagen bij herhaalde weergaven door een langer cachebeleid in te schakelen:

{{ figure_markup(
  image="cache-wasted-bytes-lighthouse.png",
  caption="Verdeling van potentiële byte-besparingen van de Lighthouse caching-audit.",
  description="Een staafdiagram met de verdeling van mogelijke bytebesparingen van de Lighthouse caching-audit voor mobiele webpagina's. 57,2% van de antwoorden heeft een besparing van minder dan 1 MB, 21,58% heeft een besparing tussen 1-2 MB, 7,8% heeft een besparing tussen 2-3 MB en 4,3% heeft een besparing tussen 3-4 MB. 9,2% heeft een besparing van 4 MB of meer.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=534991851&format=interactive",
  sheets_gid="2140407198",
  sql_file="cache_wastedbytes_lighthouse.sql"
  )
}}

Van de sites die kunnen profiteren van extra caching, kan meer dan een vijfde hun paginagewicht met meer dan 2 MB verminderen!

## Gevolgtrekking

Caching is een ongelooflijk krachtige functie waarmee browsers, proxy's en andere tussenpersonen, zoals CDN's, webinhoud kunnen opslaan en aan eindgebruikers kunnen aanbieden. De prestatievoordelen hiervan zijn aanzienlijk, aangezien het de heen-en-terug-tijden verkort en kostbare netwerkverzoeken tot een minimum beperkt.

Caching is ook een zeer complex onderwerp, en een onderwerp dat vaak tot laat in de ontwikkelingscyclus blijft staan (vanwege vereisten van siteontwikkelaars om de allernieuwste versie van een site te zien terwijl deze nog wordt ontworpen), en vervolgens wordt toegevoegd op het laatste minuut. Bovendien worden cacheregels vaak een keer gedefinieerd en daarna nooit gewijzigd, zelfs niet als de onderliggende inhoud op een site verandert. Vaak wordt een standaardwaarde gekozen zonder zorgvuldige afweging.

Om objecten correct in de cache te plaatsen, zijn er talloze HTTP-reactie-headers die zowel versheid kunnen overbrengen als ingevoerde gegevens in het cachegeheugen kunnen valideren, en `Cache-Control`-richtlijnen bieden een enorme hoeveelheid flexibiliteit en controle.

Veel objecttypen en inhoud die doorgaans als niet-cacheerbaar worden beschouwd, kunnen feitelijk in de cache worden opgeslagen (onthoud: *cacheer zoveel mogelijk!*) en veel objecten worden te kort in de cache opgeslagen, waardoor herhaalde verzoeken en opnieuw valideren nodig zijn (onthoud: *cache zo lang als u kunt!*). Website-ontwikkelaars moeten echter voorzichtig zijn met de extra mogelijkheden voor fouten die gepaard gaan met te veel caching van inhoud.

Als de site bedoeld is om te worden bediend via een CDN, moet rekening worden gehouden met extra mogelijkheden voor caching bij het CDN om de serverbelasting te verminderen en een snellere reactie aan eindgebruikers te bieden, samen met de gerelateerde risico's van het per ongeluk in de cache opslaan van privé-informatie, zoals cookies.

Krachtig en complex hoeft echter niet per se moeilijk te zijn. Zoals bijna al het andere, wordt caching gecontroleerd door regels die vrij eenvoudig kunnen worden gedefinieerd om de beste combinatie van cachemogelijkheden en privacy te bieden. Het wordt aanbevolen uw site regelmatig te controleren om ervoor te zorgen dat cachebare bronnen op de juiste manier in het cachegeheugen worden opgeslagen, en hulpmiddelen zoals Lighthouse doen uitstekend werk om een dergelijke analyse te vereenvoudigen.
