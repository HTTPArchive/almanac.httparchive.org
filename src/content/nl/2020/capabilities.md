---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Mogelijkheden
description: Het hoofdstuk Mogelijkheden van de Web Almanac 2020 met betrekking tot gloednieuwe, krachtige webplatform-API's.
hero_alt: Hero image of Web Almanac characters with superhero capes plugging various capabilities into a web page.
authors: [christianliebel]
reviewers: [tomayac]
analysts: [tomayac]
editors: [rviscomi]
translators: [noah-vdv]
discuss: 2049
results: https://docs.google.com/spreadsheets/d/1N6j1qKv7vc51p1W9z_RrbJX9Se3Pmb-Uersfz4gWqqs/
christianliebel_bio: Christian Liebel is consultant bij <a hreflang="en" href="https://thinktecture.com">Thinktecture</a> en ondersteunt cliënten uit verschillende bedrijfsgebieden bij het implementeren van eersteklas webapplicaties. Hij is een Microsoft MVP voor Developer Technologies, Google GDE voor Web/Capabilities en Angular, en neemt deel aan de W3C Web Applications Working Group.
featured_quote: De staat van de webmogelijkheden in 2020 is gezond, aangezien nieuwe krachtige API's regelmatig worden geleverd met nieuwe releases van op Chromium gebaseerde browsers. De eerste API's zijn ook al in andere browsers terechtgekomen.
featured_stat_1: 0,0006%
featured_stat_label_1: (Chrome) Pagina laden met de Async Clipboard API
featured_stat_2: 0,49%
featured_stat_label_2: Sites die Storage Manager API gebruiken
featured_stat_3: 363
featured_stat_label_3: Sites staan het installeren van gerelateerde apps toe
---

## Inleiding

[Progressive Web Apps](./pwa) (PWA) zijn een platformonafhankelijk applicatiemodel gebaseerd op webtechnologie. Met de hulp van Service Workers draaien deze apps zelfs als de gebruiker offline is. Met het [Web App Manifest](https://developer.mozilla.org/docs/Web/Manifest) kunnen gebruikers een PWA toevoegen aan hun startscherm of programmalijst. Van daaruit wordt een PWA geopend als een native app. PWA's kunnen echter alleen de functies en mogelijkheden gebruiken die beschikbaar zijn via webplatform-API's. Willekeurige native interfaces kunnen niet worden aangeroepen, waardoor er een gat ontstaat tussen native apps en webapps.

Het <a hreflang="en" href="https://www.chromium.org/teams/web-capabilities-fugu">Capabilities Project</a>, informeel ook bekend als Project Fugu, is een bedrijfoverschrijdende inspanning van Google, Microsoft en Intel om de kloof tussen web en native te overbruggen. Dit is belangrijk om het web als platform relevant te houden. Om dit te doen, implementeren de Chromium-bijdragers nieuwe API's die de mogelijkheden van het besturingssysteem blootstellen aan internet, terwijl de veiligheid, privacy en vertrouwen van de gebruiker behouden blijft. Deze mogelijkheden omvatten, maar zijn niet beperkt tot:

- <a hreflang="en" href="https://web.dev/file-system-access/">File System Access API</a> voor toegang tot bestanden op het lokale bestandssysteem
- <a hreflang="en" href="https://web.dev/file-handling/">File Handling API</a> voor het registreren als een handler voor bepaalde bestandsextensies
- <a hreflang="en" href="https://web.dev/async-clipboard/">Async Clipboard API</a> om toegang te krijgen tot het klembord van de gebruiker
- <a hreflang="en" href="https://web.dev/web-share/">Web Share API</a> voor het delen van bestanden met andere applicaties
- <a hreflang="en" href="https://web.dev/contact-picker/">Contact Picker API</a> om toegang te krijgen tot contacten uit het adresboek van de gebruiker
- <a hreflang="en" href="https://web.dev/shape-detection/">Shape Detection API</a> voor efficiënte detectie van gezichten of streepjescodes in afbeeldingen
- <a hreflang="en" href="https://web.dev/nfc/">Web NFC</a>, <a hreflang="en" href="https://web.dev/serial/">Web Serial</a>, <a hreflang="en" href="https://web.dev/usb/">Web USB</a>, <a hreflang="en" href="https://web.dev/bluetooth/">Web Bluetooth</a>, en andere API's (zie voor de volledige lijst de <a hreflang="en" href="https://goo.gle/fugu-api-tracker">Fugu API Tracker</a>)

Iedereen kan een nieuwe mogelijkheid voorstellen door <a hreflang="en" href="https://bit.ly/new-fugu-request">een ticket aan te maken in de Chromium-bugtracker</a>. De Chromium-bijdragers onderzoeken de voorstellen en bespreken alle API's met andere ontwikkelaars en browserleveranciers via de desbetreffende normalisatie-instellingen. Ondertussen implementeert het Fugu-team de API in Chromium, waar het in eerste instantie achter een vlag wordt geïmplementeerd. Later in het proces wordt de API via een <a hreflang="en" href="https://web.dev/origin-trials/">origin trial</a> beschikbaar gesteld aan een beperkt publiek. Tijdens deze fase kunnen ontwikkelaars zich aanmelden voor een token om de API op een specifieke oorsprong te testen. Als de API robuust genoeg blijkt te zijn, wordt de API verzonden in Chromium en, als de leveranciers dat beslissen, andere browsers. De site <a hreflang="en" href="https://web.dev/fugu-status/">Capability Status</a> laat zien waar de verschillende Capability API's zich in het proces bevinden.

Project Fugu, de codenaam van het Capabilities Project, is vernoemd naar een Japans gerecht: correct bereid, het vlees van de kogelvis is een bijzondere smaakbelevenis. Als het echter verkeerd wordt voorbereid, kan het fataal zijn. De krachtige API's van Project Fugu zijn buitengewoon opwindend voor ontwikkelaars. Ze kunnen echter de veiligheid en privacy van de gebruiker aantasten. Daarom besteedt het Fugu-team speciale aandacht aan deze kwesties. Nieuwe interfaces vereisen bijvoorbeeld dat de website wordt verzonden via een beveiligde verbinding (HTTPS). Sommige vereisen een gebruikersgebaar, zoals een klik of een toetsaanslag, om fraude te voorkomen. Andere mogelijkheden vereisen expliciete toestemming van de gebruiker. Ontwikkelaars kunnen alle API's gebruiken als een progressieve verbetering: door functie-detectie van de API's zullen apps niet breken in browsers die geen ondersteuning voor die mogelijkheden hebben. In browsers die deze ondersteunen, kunnen gebruikers een betere ervaring krijgen. Op deze manier worden web-apps <a hreflang="en" href="https://web.dev/progressively-enhance-your-pwa/">progressief verbeterd</a> volgens de specifieke browser van de gebruiker.

Dit hoofdstuk geeft een overzicht van verschillende moderne web-API's en de staat van webmogelijkheden in 2020 op basis van gebruiksgegevens door het HTTP Archive en <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity">Chrome Platform Status</a>. Aangezien sommige interfaces splinternieuw zijn, is hun (relatief) gebruik erg laag. Dus, in tegenstelling tot de meeste hoofdstukken, worden de gebruiksstatistieken van het HTTP Archive weergegeven als het absolute aantal pagina's in plaats van relatieve percentages. Vanwege [technische beperkingen](./methodology#metrics), heeft het HTTP Archive alleen gegevens beschikbaar voor API's die geen toestemming of gebruikersgebaar vereisen. Als er geen gegevens beschikbaar zijn, wordt in plaats daarvan het percentage pagina's weergegeven dat in Google Chrome wordt geladen op basis van de Chrome-platformstatus. Ook al zijn sommige cijfers zo klein dat de statistieken niet per se zinvol zijn, in veel gevallen zijn er nog steeds trends af te lezen uit de data. Deze statistieken kunnen ook worden gebruikt als basis voor toekomstige jaarlijkse edities van dit hoofdstuk, waarbij we terugkijken om te zien hoeveel de API's volwassen zijn geworden en hun acceptatie hebben verbeterd. Tenzij anders vermeld, zijn de API's alleen beschikbaar in op Chromium gebaseerde browsers en bevinden hun specificaties zich in de vroege stadia van standaardisatie.

## <span lang="en">Async Clipboard API</span> {async-clipboard-api}

Met behulp van de `document.execCommand()` methode konden websites al toegang krijgen tot het klembord van de gebruiker. Deze benadering is echter enigszins beperkt, aangezien de API synchroon is (waardoor het moeilijk wordt om klemborditems te verwerken), en deze alleen kan communiceren met geselecteerde tekst in de DOM. Dit is waar de <a hreflang="en" href="https://webkit.org/blog/10855/async-clipboard-api/">Async Clipboard API</a> (<a hreflang="en" href="https://www.w3.org/TR/clipboard-apis/#async-clipboard-api">W3C Working Draft</a>) binnenkomt. Deze nieuwe API is niet alleen asynchroon, wat betekent dat het de pagina niet blokkeert voor grote hoeveelheden gegevens of wacht op het verlenen van toestemming, maar het staat ook afbeeldingen toe om te worden gekopieerd naar of geplakt vanaf het klembord in ondersteunde browsers zoals Chrome, Edge en Safari.

### Leestoegang

De Async Clipboard API biedt twee methoden voor het lezen van inhoud van het klembord: een afgekorte methode voor platte tekst, genaamd `navigator.clipboard.readText()`, en een methode voor willekeurige gegevens, genaamd `navigator.clipboard.read()`. Momenteel ondersteunen de meeste browsers alleen HTML-inhoud en PNG-afbeeldingen als aanvullende gegevensindelingen. Omdat het klembord gevoelige gegevens kan bevatten, is toestemming van de gebruiker vereist om ervan te lezen.

{{ figure_markup(
  image="async_clipboard_api.png",
  caption='Percentage pagina’s dat wordt geladen in Chrome met behulp van de Async Clipboard API.<br>(Bronnen: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2369">Async Clipboard Read</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2370">Async Clipboard Write</a>)',
  description="Grafiek van het gebruik van de Async Clipboard API, gebaseerd op het percentage pagina's dat met deze functie in Chrome wordt geladen. Het vergelijkt het gebruik van de `read`- en `write`-methoden en laat een exponentiële groei zien voor `write` in de loop van 2020, terwijl `read` lineair groeit. In oktober 2020 werd `read` aangeroepen tijdens 0,0003% van alle paginaladingen in Chrome, `write` voor 0,0006%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1740212588&format=interactive",
  sheets_gid="2077755325"
  )
}}

De Async Clipboard API is relatief nieuw, dus het gebruik ervan is momenteel vrij laag. In maart 2020 heeft Safari ondersteuning toegevoegd voor de Async Clipboard API in Safari 13.1. In de loop van 2020 groeide het gebruik van de `read()` API. In oktober 2020 werd de API aangeroepen tijdens 0.0003% van alle pagina ladingen in Google Chrome.

### Schrijftoegang

Afgezien van leesbewerkingen biedt de Async Clipboard API ook twee methoden om inhoud naar het klembord te schrijven. Nogmaals, er is een verkorte methode voor platte tekst, genaamd `navigator.clipboard.writeText()`, en een voor willekeurige gegevens genaamd `navigator.clipboard.write()`. In op Chromium gebaseerde browsers is geen toestemming vereist om naar het klembord te schrijven terwijl het tabblad actief is. Proberen naar het klembord te schrijven wanneer de website op de achtergrond staat, is wel toestemming voor nodig. Aangezien deze methode eerst een gebruikersgebaar en toestemming vereist, valt deze niet onder de HTTP Archive-statistieken. In tegenstelling tot de `read()` - methode, laat de `write()` - methode een exponentiële groei in gebruik zien, die deel uitmaakt van 0,0006% van alle paginaladingen in oktober 2020.

De <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=897289">Raw Clipboard Access API</a>, een andere Fugu-mogelijkheid, zou de Async Clipboard API nog verder kunnen verbeteren door het mogelijk te maken dat willekeurige gegevens worden gekopieerd van of geplakt op het klembord.

## <span lang="en">StorageManager API</span> {storagemanager-api}

Webbrowsers stellen gebruikers in staat om gegevens op verschillende manieren op het systeem van de gebruiker op te slaan, zoals cookies, de Indexed Database (IndexedDB), de Service Worker's Cache Storage, of Web Storage (Local Storage, Session Storage). In moderne browsers kunnen ontwikkelaars gemakkelijk <a hreflang="en" href="https://web.dev/storage-for-the-web/">honderden megabytes en zelfs meer opslaan</a>, afhankelijk van de browser. Wanneer browsers onvoldoende ruimte hebben, kunnen ze gegevens wissen totdat het systeem niet langer de limiet overschrijdt, wat kan leiden tot gegevensverlies.

Dankzij de [StorageManager API](https://developer.mozilla.org/docs/Web/API/StorageManager), die deel uitmaakt van de <a hreflang="en" href="https://storage.spec.whatwg.org/#storagemanager">WHATWG Storage Living Standard</a>, gedragen browsers zich in dat opzicht niet langer als een zwarte doos. Met deze API kunnen ontwikkelaars de resterende beschikbare ruimte schatten en zich aanmelden voor <a hreflang="en" href="https://web.dev/persistent-storage/">permanente opslag</a>, wat betekent dat de browser de gegevens van een website niet wist wanneer er weinig schijfruimte is. Daarom introduceert de API een nieuwe `StorageManager`-interface op het `navigator`-object, momenteel beschikbaar in Chrome, Edge en Firefox.

### Schat de beschikbare opslagruimte in

Ontwikkelaars kunnen de beschikbare opslagruimte schatten door `navigator.storage.estimate()` aan te roepen. Deze methode retourneert een belofte die wordt opgelost naar een object met twee eigenschappen: `usage` toont het aantal bytes dat door de toepassing wordt gebruikt en `quota` bevat het maximale aantal beschikbare bytes.

{{ figure_markup(
  image="storage_manager_api_estimate.png",
  caption="Aantal pagina's dat de schattingsmethode van de StorageManager API gebruikt.",
  description="Grafiek van het gebruik van de schattingsmethode van de StorageManager API, gebaseerd op het aantal pagina's dat wordt gecontroleerd door HTTP Archive. Het vergelijkt het gebruik op mobiele en desktop-apparaten. Het vertoont een lineaire groei op de desktop, terwijl het een hockeystickgroei laat zien voor mobiele apparaten. In oktober maakten ongeveer 34.000 mobiele sites en 27.000 desktopsites hiervan gebruik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1853644024&format=interactive",
  sheets_gid="1811313356",
  sql_file="durable_storage_estimate_usage.sql"
  )
}}

De Storage Manager API wordt ondersteund in Chrome sinds 2016, Firefox sinds 2017 en de nieuwe Chromium-gebaseerde Edge. Uit HTTP Archive-gegevens blijkt dat de API wordt gebruikt op 27.056 desktoppagina's (0,49%) en 34.042 mobiele pagina's (0,48%). In de loop van 2020 bleef het gebruik van de Storage Manager API groeien. Dit maakt deze interface ook de meest gebruikte API in dit hoofdstuk.

### Aanmelden voor permanente opslag

Er zijn twee categorieën webopslag: "Beste Inspanning" en "Permanent", waarbij de eerste de standaard is. Als een apparaat weinig opslagruimte heeft, probeert de browser automatisch de beste opslagruimte vrij te maken. Bijvoorbeeld, Firefox en Chromium-gebaseerde browsers verwijderen opslag uit de minst recent gebruikte bronnen. Dit brengt echter het risico met zich mee dat kritieke gegevens verloren gaan. Om uitzetting te voorkomen, kunnen ontwikkelaars kiezen voor permanente opslag. In dat geval wist de browser de opslag niet, zelfs niet als er weinig ruimte is. Gebruikers kunnen er nog steeds voor kiezen om de opslag handmatig op te ruimen. Om te kiezen voor permanente opslag, moeten ontwikkelaars de `navigator.storage.persist()`-methode aanroepen. Afhankelijk van de browser en de site-betrokkenheid, kan een toestemmingsprompt worden weergegeven of wordt het verzoek automatisch geaccepteerd of geweigerd.

{{ figure_markup(
  image="storage_manager_api_persist.png",
  caption="Aantal pagina's dat de `persist`-methode van de StorageManager API gebruikt.",
  description="Grafiek van het gebruik van de `persist`-methode van StorageManager API, op basis van het aantal pagina's dat wordt gecontroleerd door HTTP Archive. Het vergelijkt het gebruik op mobiele en desktop-apparaten. Op desktoppagina's is het gebruik nagenoeg stabiel, terwijl er meer fluctuatie is op mobiele apparaten. In oktober 2020 maken 25 desktoppagina's en 176 mobiele pagina's gebruik van de API.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=644836316&format=interactive",
  sheets_gid="1095648844",
  sql_file="durable_storage_persist_usage.sql"
  )
}}

De `persist()` API wordt minder vaak aangeroepen dan de `estimate()` methode. Slechts 176 mobiele pagina's maken gebruik van deze API, vergeleken met 25 desktopwebsites. Hoewel het gebruik op de desktop op dit lage niveau lijkt te blijven, is er geen duidelijke trend op mobiele apparaten.

## Nieuwe Notificatie APIs

Met behulp van de Push- en Notifications-API's kunnen webapplicaties al lang pushberichten ontvangen en meldingsbanners weergeven. Er ontbraken echter enkele onderdelen. Tot nu toe moesten push-berichten via de server worden verzonden; ze konden niet offline worden gepland. Ook konden webtoepassingen die op het systeem waren geïnstalleerd, geen badges op hun pictogram weergeven. De API's voor badging en Notification Triggers maken beide scenario's mogelijk.

### <span lang="en">Badging API</span> {badging-api}

Op verschillende platforms is het gebruikelijk dat applicaties een badge presenteren op het pictogram van de applicatie die het aantal openstaande acties aangeeft. De badge kan bijvoorbeeld het aantal ongelezen e-mails, meldingen of taken weergeven dat moet worden voltooid. Met de <a hreflang="en" href="https://web.dev/badging-api/">Badging API</a> (<a hreflang="en" href="https://w3c.github.io/badging/">W3C Unofficial Draft</a>) kunnen geïnstalleerde webapplicaties een dergelijke badge weergeven op het icoon. Door `navigator.setAppBadge()` aan te roepen, kunnen ontwikkelaars de badge instellen. Voor deze methode is een nummer nodig om op de badge van de applicatie te worden weergegeven. De browser zorgt er vervolgens voor dat de weergave zo goed mogelijk wordt weergegeven op het apparaat van de gebruiker. Als er geen nummer is opgegeven, wordt een algemene badge weergegeven (bijvoorbeeld een witte stip op macOS). Door `navigator.clearAppBadge()` aan te roepen, wordt de badge weer verwijderd. De Badging-API is een uitstekende keuze voor e-mailcliënten, apps voor sociale media of messengers. De Twitter PWA maakt gebruik van de Badging API om het aantal ongelezen meldingen op de badge van de applicatie weer te geven.

{{ figure_markup(
  image="badging_api.png",
  caption='Percentage pagina’s dat wordt geladen in Chrome met behulp van de Badging-API.<br>(Bronnen: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2726">Badge Set</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2727">Badge Clear</a>)',
  description="Grafiek van Badging API-gebruik, gebaseerd op het percentage pagina's dat met deze functie in Chrome wordt geladen. Het vergelijkt de `set` en `clear` methoden. Het gebruik van beide methoden groeit in de loop van de tijd, waarbij de `set` methode over het algemeen vaker wordt aangeroepen. In oktober 2020 is er een plotselinge groei voor beide methoden, met een piek van 0,025% van het laden van pagina's voor de `set` methode en 0,016% voor `clear`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1145004925&format=interactive",
  sheets_gid="1154751352"
  )
}}

In april 2020 heeft Google Chrome 81 de nieuwe Badging API verzonden, gevolgd door Microsoft Edge 84 in juli. Nadat Chrome de API had verzonden, schoten de gebruikscijfers omhoog. In oktober 2020 wordt bij 0,025% van alle pagina's die in Google Chrome worden geladen, de `setAppBadge()` - methode aangeroepen. De `clearAppBadge()` - methode wordt minder vaak aangeroepen, wanneer ongeveer 0,016% van de pagina's wordt geladen.

### <span lang="en">Notification Triggers API</span> {notification-triggers-api}

De Push API vereist dat de gebruiker online is om een melding te ontvangen. Sommige applicaties, zoals games, herinnerings- of taakapps, agenda's of wekkers, kunnen ook de streefdatum voor een melding lokaal bepalen en deze plannen. Om deze functie te ondersteunen, experimenteert het Chrome-team met een nieuwe API genaamd <a hreflang="en" href="https://web.dev/notification-triggers/">Notification Triggers</a> (<a hreflang="en" href="https://github.com/beverloo/notification-triggers/blob/master/README.md">Uitleg</a>, nog niet op een standaardspoor). Deze API voegt een nieuwe eigenschap toe genaamd `showTrigger` aan de `options` map die kan worden doorgegeven aan de `showNotification()` methode bij de registratie van de Service Worker. De API is ontworpen om in de toekomst verschillende soorten triggers mogelijk te maken, hoewel voorlopig alleen op tijd gebaseerde triggers worden geïmplementeerd. Voor het plannen van een melding op basis van een bepaalde datum en tijd, kunnen ontwikkelaars een nieuwe instantie van een `TimestampTrigger` maken en het beoogde tijdstempel hieraan doorgeven:

```js
registration.showNotification('Title', {
  body: 'Message',
  showTrigger: new TimestampTrigger(timestamp),
});
```

{{ figure_markup(
  image="notification_triggers_api.png",
  caption='Percentage pagina’s dat wordt geladen in Chrome met behulp van de Notification Triggers API.<br>(Bron: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">Notification Triggers</a>)',
  description="Diagram met Notification Triggers API-gebruik, gebaseerd op het percentage pagina's dat in Chrome wordt geladen met deze functie. Het vertoont een piek in maart 2020 met ongeveer 0,00003% van de paginaladingen, en daalt tot nul in oktober 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1388597384&format=interactive",
  sheets_gid="1740370570"
  )
}}

Het Fugu-team experimenteerde eerst met Notification Triggers in een oorspronkelijke proef van Chrome 80 tot 83, waarbij de ontwikkeling later werd onderbroken vanwege het gebrek aan feedback van ontwikkelaars. Beginnend met Chrome 86 uitgebracht in oktober 2020, is de API weer in de oorspronkelijke proeffase terechtgekomen. Dit verklaart ook de gebruiksgegevens van de Notification Triggers API die piekten toen ze werden aangeroepen op 0,000032% van de pagina's die in Chrome werden geladen tijdens de eerste oorspronkelijke proef rond maart 2020.

## <span lang="en">Screen Wake Lock API</span> {screen-wake-lock-api}

Om energie te besparen, verdonkeren mobiele apparaten de achtergrondverlichting van het scherm en schakelen uiteindelijk het scherm van het apparaat uit, wat in de meeste gevallen logisch is. Er zijn echter scenario's waarin de gebruiker wil dat de app het display expliciet wakker houdt, bijvoorbeeld bij het lezen van een recept tijdens het koken of het bekijken van een presentatie. De [Screen Wake Lock API](https://developer.mozilla.org/docs/Web/API/Screen_Wake_Lock_API) (<a hreflang="en" href="https://www.w3.org/TR/screen-wake-lock/">W3C Working Draft</a>) lost dit probleem op door een mechanisme te bieden om het scherm ingeschakeld te houden.

De `navigator.wakeLock.request()` methode creëert een "wake lock". Deze methode heeft een parameter `WakeLockType` nodig. In de toekomst zou de Wake Lock API andere vergrendelingstypen kunnen bieden, zoals het scherm uitschakelen, maar de CPU ingeschakeld houden. Voorlopig ondersteunt de API alleen schermvergrendelingen, dus er is slechts één optioneel argument met de standaardwaarde `screen`. De methode retourneert een belofte die wordt omgezet in een `WakeLockSentinel`-object. Ontwikkelaars moeten deze referentie opslaan om de `release()`-methode aan te roepen en de wake lock van het scherm later weer op te heffen. De browser zal automatisch de vergrendeling opheffen wanneer het tabblad inactief is, of de gebruiker minimaliseert het venster. Ook kan de browser een verzoek afwijzen en de belofte afwijzen, bijvoorbeeld vanwege een bijna lege batterij.

{{ figure_markup(
  image="screen_wake_lock_api.png",
  caption="Aantallen pagina's met behulp van Screen Wake Lock API.",
  description="Grafiek van het gebruik van de Screen Wake Lock API, gebaseerd op het aantal pagina's dat wordt gecontroleerd door het HTTP Archive, waarbij desktop- en mobiele pagina's worden vergeleken. In oktober 2020 wordt de API gebruikt door 10 desktop- en 5 mobiele pagina's.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=718278185&format=interactive",
  sheets_gid="1008442251",
  sql_file="wake_lock_acquire_screen_lock_usage.sql"
  )
}}

BettyCrocker.com, een populaire kookwebsite in de VS, biedt hun gebruikers een optie om te voorkomen dat het scherm donker wordt tijdens het koken met behulp van de Screen Wake Lock API. In een <a hreflang="en" href="https://web.dev/betty-crocker/">casestudy</a> publiceerden ze dat de gemiddelde sessieduur 3,1 keer langer was dan normaal, het bouncepercentage met 50% afnam en de koopintentie-indicatoren met ongeveer 300%. De interface heeft dus een direct meetbaar effect op het succes van de website of applicatie. De Screen Wake Lock API werd in juli 2020 geleverd met Google Chrome 84. Het HTTP Archive bevat alleen gegevens voor april, mei, augustus, september en oktober. Na de release van Chrome 84 steeg het gebruik snel. In oktober 2020 werd de API aangenomen op 10 desktop- en 5 mobiele pagina's.

## <span lang="en">Idle Detection API</span> {idle-detection-api}

Sommige applicaties moeten bepalen of de gebruiker een apparaat actief gebruikt of niet actief is. Chat-applicaties kunnen bijvoorbeeld aangeven dat de gebruiker afwezig is. Er zijn verschillende factoren waarmee rekening kan worden gehouden, zoals een gebrek aan interactie met het scherm, de muis of het toetsenbord. De <a hreflang="en" href="https://web.dev/idle-detection/">Idle Detection API</a> (<a hreflang="en" href="https://wicg.github.io/idle-detection/">WICG Draft Community Group Report</a>) biedt een abstracte API die stelt ontwikkelaars in staat om te controleren of de gebruiker inactief is of dat het scherm is vergrendeld, gegeven een bepaalde drempel.

Om dit te doen, biedt de API een nieuwe `IdleDetector` interface op het globale `window` object. Voordat ontwikkelaars deze functionaliteit kunnen gebruiken, moeten ze toestemming vragen door eerst `IdleDetector.requestPermission()` aan te roepen. Als de gebruiker de toestemming verleent, kunnen ontwikkelaars een nieuwe instantie van `IdleDetector` maken. Dit object biedt twee eigenschappen: `userState` en `screenState`, die de respectievelijke statussen bevatten. Het zal een `change` -gebeurtenis oproepen wanneer de status van de gebruiker of het scherm verandert. Ten slotte moet de inactieve detector worden gestart door de `start()` - methode aan te roepen. De methode heeft een configuratie-object met twee parameters: een `threshold` die de tijd in milliseconden definieert dat de gebruiker inactief moet zijn (het minimum is een minuut), en ontwikkelaars kunnen optioneel een `AbortSignal` doorgeven aan de `abort`-eigenschap, die dient om de inactieve detectie later af te breken.

{{ figure_markup(
  image="idle_detection_api.png",
  caption='Percentage pagina’s dat wordt geladen in Chrome met behulp van Idle Detection API.<br>(Bron: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">Idle Detection</a>)',
  description="Grafiek van API-gebruik voor inactieve detectie, gebaseerd op het percentage pagina's dat met deze functie in Chrome wordt geladen. Er zijn alleen gegevens beschikbaar voor juli en oktober 2020, wat een zeer lage acceptatie van de API aantoont.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=963792757&format=interactive",
  sheets_gid="1324588405"
  )
}}

Op het moment van schrijven bevindt de Idle Detection API zich in een oorspronkelijke proef, dus de API-vorm kan in de toekomst veranderen. Om dezelfde reden is het gebruik ervan erg laag en nauwelijks meetbaar.

## <span lang="en">Periodic Background Sync API</span> {periodic-background-sync-api}

Wanneer de gebruiker een web-app sluit, kan deze niet meer communiceren met de backend-service. In sommige gevallen willen ontwikkelaars mogelijk nog steeds gegevens min of meer regelmatig synchroniseren, net zoals native applicaties dat kunnen. Nieuwsapplicaties willen bijvoorbeeld de laatste krantenkoppen downloaden voordat de gebruiker wakker wordt. De <a hreflang="en" href="https://web.dev/periodic-background-sync/">Periodic Background Sync API</a> (<a hreflang="en" href="https://wicg.github.io/periodic-background-sync/">WICG Draft Community Group Report</a>) streeft ernaar deze kloof tussen web en native te overbruggen.

### Registreer voor periodieke synchronisatie

De API voor periodieke achtergrondsynchronisatie is afhankelijk van Service Workers die kunnen worden uitgevoerd, zelfs als de app is gesloten. Net als bij andere mogelijkheden, vereist deze API eerst de toestemming van de gebruiker. De API implementeert een nieuwe interface genaamd `PeriodicSyncManager`. Indien aanwezig, hebben ontwikkelaars toegang tot een exemplaar van deze interface op de registratie van de Service Worker. Om gegevens op de achtergrond te synchroniseren, moet de toepassing zich eerst registreren door de registratie `periodicSync.register()` aan te roepen. Deze methode heeft twee parameters nodig: een `tag`, wat een willekeurige tekenreeks is om de registratie later opnieuw te herkennen, en een configuratieobject waaraan de eigenschap `minInterval` moet voldoen. Deze eigenschap definieert het gewenste minimuminterval in milliseconden door de ontwikkelaar. De browser beslist uiteindelijk echter hoe vaak hij de achtergrondsynchronisatie daadwerkelijk zal aanroepen:

```js
registration.periodicSync.register('articles', {
  minInterval: 24 * 60 * 60 * 1000 // one day
});
```

### Reageer op een periodiek synchronisatie-interval

Voor elke tick van het interval, en als het apparaat online is, activeert de browser de gebeurtenis `periodicsync` van de Service Worker. Vervolgens kan het Service Worker-script de nodige stappen uitvoeren om de gegevens te synchroniseren:

```js
self.addEventListener('periodicsync', (event) => {
  if (event.tag === 'articles') {
    event.waitUntil(syncStuff());
  }
});
```

Op het moment van schrijven implementeren alleen op Chromium gebaseerde browsers deze API. Op deze browsers moet de applicatie eerst worden geïnstalleerd (d.w.z. toegevoegd aan het start scherm) voordat de API kan worden gebruikt. De <a hreflang="en" href="https://www.chromium.org/developers/design-documents/site-engagement">site engagement score</a> van de website bepaalt of en hoe vaak periodieke synchronisatiegebeurtenissen kunnen worden aangeroepen. In de huidige conservatieve implementatie kunnen websites inhoud één keer per dag synchroniseren.

{{ figure_markup(
  image="periodic_background_sync_api.png",
  caption="Aantal pagina's dat API voor periodieke achtergrondsynchronisatie gebruikt.",
  description="Grafiek van API-gebruik voor periodieke achtergrondsynchronisatie, gebaseerd op het aantal pagina's dat wordt gecontroleerd door HTTP Archive. Het vergelijkt het gebruik op mobiele en desktop-apparaten. Sinds april 2020 wordt de API gebruikt door één tot twee desktop- en mobiele pagina's.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1444904371&format=interactive",
  sheets_gid="386193538",
  sql_file="periodic_background_sync_usage.sql"
  )
}}

Het gebruik van de interface is momenteel erg laag. In de loop van 2020 maakten slechts één of twee pagina's die door HTTP Archive werden gecontroleerd, gebruik van deze API.

## Integratie met native app-winkels

PWA's zijn een veelzijdig appmodel. In sommige gevallen kan het echter nog steeds zinvol zijn om een aparte native applicatie aan te bieden: bijvoorbeeld als de app functies moet gebruiken die niet beschikbaar zijn op internet, of op basis van de programmeerervaring van het app-ontwikkelteam. Als de gebruiker al een native app heeft geïnstalleerd, willen apps mogelijk geen twee keer meldingen verzenden of de installatie van een bijbehorende PWA promoten.

Om te detecteren of de gebruiker al een gerelateerde native applicatie of PWA op het systeem heeft, kunnen ontwikkelaars de <a hreflang="en" href="https://web.dev/get-installed-related-apps/">`getInstalledRelatedApps()` methode</a> (<a hreflang="en" href="https://wicg.github.io/get-installed-related-apps/spec/">WICG Draft Community Group Report</a>) gebruiken op het `navigator` -object. Deze methode wordt momenteel geleverd door op Chromium gebaseerde browsers en werkt voor zowel Android- als UWP-apps (Universal Windows Platform). Ontwikkelaars moeten de native app-bundels aanpassen om naar de website te verwijzen en informatie over de native app(s) toe te voegen aan het Web App Manifest van de PWA. Door de `getInstalledRelatedApps()` - methode aan te roepen, wordt de lijst met apps geretourneerd die op het apparaat van de gebruiker zijn geïnstalleerd:

```js
const relatedApps = await navigator.getInstalledRelatedApps();
relatedApps.forEach((app) => {
  console.log(app.id, app.platform, app.url);
});
```

{{ figure_markup(
  image="get_installed_related_apps.png",
  caption="Aantal pagina's dat `getInstalledRelatedApps()` gebruikt.",
  description="Grafiek van het gebruik van `getInstalledRelatedApps()`, op basis van het aantal pagina's dat wordt gecontroleerd door HTTP Archive. Het vergelijkt het gebruik op mobiele en desktop-apparaten. Het laat een gestage groei zien voor mobiele apparaten, met een piek van 363 pagina's in oktober 2020 vergeleken met 44 desktoppagina's.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1774881171&format=interactive",
  sheets_gid="860146688",
  sql_file="get_installed_related_apps_usage.sql"
  )
}}

In de loop van 2020 vertoont de `getInstalledRelatedApps()` API een gestage groei op mobiele websites. In oktober maakten 363 mobiele pagina's die werden gevolgd door het HTTP Archive gebruik van deze API. Op desktoppagina's groeit de API niet zo snel. Dit kan ook het gevolg zijn van het feit dat Android-winkels momenteel aanzienlijk meer apps aanbieden dan de Microsoft Store voor Windows.

## <span lang="en">Content Indexing API</span> {context-indexing-api}

Webapps kunnen inhoud offline opslaan op verschillende manieren, zoals Cache Storage of IndexedDB. Voor gebruikers is het echter moeilijk om te ontdekken welke inhoud offline beschikbaar is. Met de <a hreflang="en" href="https://web.dev/content-indexing-api/">Content Indexing API</a> (<a hreflang="en" href="https://wicg.github.io/content-index/spec/">WICG Editor's Draft</a>) kunnen ontwikkelaars inhoud prominenter weergeven. Momenteel is Chrome op Android de enige browser die deze API ondersteunt. Deze browser toont een lijst met "Artikelen voor jou" in het menu Downloads. Inhoud die is geïndexeerd via de Content Indexing API, wordt daar weergegeven.

De Content Indexing API breidt de Service Worker API uit met een nieuwe `ContentIndex` interface. Deze interface is beschikbaar via de eigenschap `index` van de registratie van de Service Worker. Met de `add()` methode kunnen ontwikkelaars inhoud aan de index toevoegen: elk stukje inhoud moet een ID, een URL, een start-URL, titel, beschrijving en een reeks pictogrammen hebben. Optioneel kan de inhoud worden gegroepeerd in verschillende categorieën, zoals artikelen, startpagina's of video's. De `delete()` methode maakt het mogelijk om weer inhoud uit de index te verwijderen, en de `getAll()` methode geeft een lijst met alle geïndexeerde items terug.

{{ figure_markup(
  image="content_indexing_api.png",
  caption='Percentage pagina’s dat wordt geladen in Chrome met behulp van Content Indexing API.<br>(Bron: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">Content Indexing</a>)',
  description="Grafiek van het gebruik van Content Indexing API, gebaseerd op het percentage pagina's dat met deze functie in Chrome wordt geladen. Het vertoont in eerste instantie een relatief laag gebruik, totdat het in oktober 2020 plotseling vertienvoudigt, en wordt gebruikt tijdens 0,0021% van de paginaladingen in Chrome.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=258329620&format=interactive",
  sheets_gid="626752011"
  )
}}

De Content Indexing API is gelanceerd met Chrome 84 in juli 2020. Direct na verzending werd de API gebruikt tijdens ongeveer 0,0002% van de paginaladingen in Chrome. In oktober 2020 is deze waarde bijna vertienvoudigd.

## Nieuwe transport-API's

Ten slotte zijn er twee nieuwe transportmethoden die momenteel worden getest op oorsprong. De eerste stelt ontwikkelaars in staat om hoogfrequente berichten te ontvangen met WebSockets, terwijl de tweede een geheel nieuw bidirectioneel communicatieprotocol introduceert, afgezien van HTTP en WebSockets.

### Tegendruk voor WebSockets

De WebSocket API is een uitstekende keuze voor bidirectionele communicatie tussen websites en servers. De WebSocket API staat echter geen tegendruk toe, dus applicaties die omgaan met hoogfrequente berichten kunnen vastlopen. De <a hreflang="en" href="https://web.dev/websocketstream/">WebSocketStream API</a> (<a hreflang="en" href="https://github.com/ricea/websocketstream-explainer/blob/master/README.md">Uitleg</a>, nog niet op het standaarden-spoor) wil gebruiksvriendelijke tegendrukondersteuning bieden aan de WebSocket API door deze uit te breiden met streams. In plaats van de gebruikelijke `WebSocket` constructor te gebruiken, moeten ontwikkelaars een nieuwe instantie van de `WebSocketStream` interface aanmaken. De eigenschap `connection` van de stream retourneert een belofte die wordt omgezet in een leesbare en beschrijfbare stream waarmee respectievelijk een streamlezer of een schrijver kan worden verkregen:

```js
const wss = new WebSocketStream(WSS_URL);
const {readable, writable} = await wss.connection;
const reader = readable.getReader();
const writer = writable.getWriter();
```

De WebSocketStream API lost op transparante wijze tegendruk op, aangezien de streamlezers en -schrijvers alleen doorgaan als het veilig is om dit te doen.

{{ figure_markup(
  image="websocketstreams.png",
  caption='Percentage pagina’s dat in Chrome wordt geladen met WebSocketStreams.<br>(Bron: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3018">WebSocketStream</a>)',
  description="Grafiek van het gebruik van WebSocketStreams, gebaseerd op het percentage pagina's dat met deze functie in Chrome wordt geladen. Het vertoont een piek in juni en juli 2020, waar de API werd gebruikt tijdens ongeveer 0,0008% van de paginaladingen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1714443590&format=interactive",
  sheets_gid="691106754"
  )
}}

De WebSocketStream API heeft zijn eerste oorspronkelijke proef voltooid en bevindt zich nu weer in de experimenteerfase. Dit verklaart ook waarom het gebruik van deze API momenteel zo laag is dat het nauwelijks meetbaar is.

### Maak het QUIC

<a hreflang="en" href="https://www.chromium.org/quic">QUIC</a> (<a hreflang="en" href="https://www.ietf.org/archive/id/draft-ietf-quic-transport-31.txt">IETF Internet-Draft</a>) is een multiplex, stream-gebaseerd, bidirectioneel transportprotocol geïmplementeerd op UDP. Het is een alternatief voor HTTP / WebSocket-API's die bovenop TCP worden geïmplementeerd. De <a hreflang="en" href="https://web.dev/webtransport/">QuicTransport API</a> is de cliënt-kant API voor het verzenden van berichten naar en het ontvangen van berichten van een QUIC-server. Ontwikkelaars kunnen ervoor kiezen om gegevens onbetrouwbaar via datagrammen te verzenden, of betrouwbaar door de streams-API te gebruiken:

```js
const transport = new QuicTransport(QUIC_URL);
await transport.ready;

const ws = transport.sendDatagrams();
const stream = await transport.createSendStream();
```

QuicTransport is een geldig alternatief voor WebSockets, omdat het de gebruiksscenario's van de WebSocket API ondersteunt en ondersteuning toevoegt voor scenario's waarin minimale latentie belangrijker is dan betrouwbaarheid en berichtvolgorde. Dit maakt het een goede keuze voor games en apps die te maken hebben met hoogfrequente gebeurtenissen.

{{ figure_markup(
  image="quic_transport.png",
  caption='Percentage pagina’s dat in Chrome wordt geladen met Quic Transport.<br>(Bron: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3184">QuicTransport</a>)',
  description="Grafiek van het gebruik van QuicTransport, gebaseerd op het percentage pagina's dat met deze functie in Chrome wordt geladen. Het vertoont een piek in oktober 2020, waar de API werd gebruikt tijdens ongeveer 0.00089% van de paginaladingen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1571330893&format=interactive",
  sheets_gid="708893754"
  )
}}

Het gebruik van de interface is momenteel nog zo laag dat het nauwelijks meetbaar is. In oktober 2020 is het sterk toegenomen en wordt het nu gebruikt tijdens 0.00089% van de paginaladingen in Chrome.

## Gevolgtrekking

De staat van de webmogelijkheden in 2020 is gezond, aangezien nieuwe, krachtige API's regelmatig worden geleverd met nieuwe releases van op Chromium gebaseerde browsers. Sommige interfaces, zoals de Content Indexing API of Idle Detection API, helpen om de laatste hand te leggen aan bepaalde webapplicaties. Andere API's, zoals File System Access en Async Clipboard API, zorgen ervoor dat een geheel nieuwe applicatiecategorie, namelijk productiviteitsapps, eindelijk de overstap naar het web maakt. Sommige API's, zoals Async Clipboard en Web Share API, zijn al in andere, niet-Chromium-browsers terechtgekomen. Safari was zelfs de eerste mobiele browser die de Web Share API implementeerde.

Door middel van zijn <a hreflang="en" href="https://developers.google.com/web/updates/capabilities#process">rigoureuze proces</a>, zorgt het Fugu-team ervoor dat toegang tot deze functies op een veilige en privacyvriendelijke manier plaatsvindt. Bovendien vraagt het Fugu-team actief de [feedback](mailto:fugu-dev@chromium.org) van andere browserleveranciers en webontwikkelaars. Hoewel het gebruik van de meeste van deze nieuwe API's relatief laag is, vertonen sommige API's die in dit hoofdstuk worden gepresenteerd een exponentiële of zelfs hockeystickachtige groei, zoals de Badging of Content Indexing API. De staat van de webmogelijkheden in 2021 hangt af van de webontwikkelaars zelf. De auteur moedigt de gemeenschap aan om geweldige webapplicaties te bouwen, gebruik te maken van de krachtige API's op een achterwaarts compatibele manier en om het web een meer capabel platform te maken.
