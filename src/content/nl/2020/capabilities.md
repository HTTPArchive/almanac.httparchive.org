---
part_number: II
chapter_number: 13
title: Mogelijkheden
description: Het hoofdstuk Mogelijkheden van de Web Almanac 2020 met betrekking tot gloednieuwe, krachtige webplatform-API's.
authors: [christianliebel]
reviewers: [tomayac]
analysts: [tomayac]
translators: [noah-vdv]
discuss: 2049
results: https://docs.google.com/spreadsheets/d/1N6j1qKv7vc51p1W9z_RrbJX9Se3Pmb-Uersfz4gWqqs/
queries: 13_Capabilities
christianliebel_bio: Christian Liebel is consultant bij <a hreflang="en" href="https://thinktecture.com">Thinktecture</a> en ondersteunt klanten uit verschillende bedrijfsgebieden bij het implementeren van eersteklas webapplicaties. Hij is een Microsoft MVP voor Developer Technologies, Google GDE voor Web/Capabilities en Angular, en neemt deel aan de W3C Web Applications Working Group.
featured_quote: De staat van de webmogelijkheden in 2020 is gezond, aangezien nieuwe krachtige API's regelmatig worden geleverd met nieuwe releases van op Chromium gebaseerde browsers. De eerste API's zijn ook al in andere browsers terechtgekomen.
featured_stat_1: 0,0006%
featured_stat_label_1: (Chrome) Pagina laden met de Async Clipboard API
featured_stat_2: 0,49%
featured_stat_label_2: Sites die Storage Manager API gebruiken
featured_stat_3: 363
featured_stat_label_3: Sites staan het installeren van gerelateerde apps toe
---

## Introductie

[Progressive Web Apps](./pwa) (PWA) zijn een platformonafhankelijk applicatiemodel gebaseerd op webtechnologie. Met de hulp van Service Workers draaien deze apps zelfs als de gebruiker offline is. Met het [Web App Manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest) kunnen gebruikers een PWA toevoegen aan hun startscherm of programmalijst. Van daaruit wordt een PWA geopend als een native app. PWA's kunnen echter alleen de functies en mogelijkheden gebruiken die beschikbaar zijn via webplatform-API's. Willekeurige native interfaces kunnen niet worden aangeroepen, waardoor er een gat ontstaat tussen native apps en webapps.

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
  alt="Percentage pagina's dat wordt geladen in Chrome met behulp van de Async Clipboard API",
  caption='Percentage pagina\'s dat wordt geladen in Chrome met behulp van de Async Clipboard API.<br>(Bronnen: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2369">Async Clipboard Read</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2370">Async Clipboard Write</a>)',
  description="Grafiek van het gebruik van de Async Clipboard API, gebaseerd op het percentage pagina's dat met deze functie in Chrome wordt geladen. Het vergelijkt het gebruik van de `read`- en `write`-methoden en laat een exponentiële groei zien voor `write` in de loop van 2020, terwijl `read` lineair groeit. In oktober 2020 werd `read` aangeroepen tijdens 0,0003% van alle paginaladingen in Chrome, `write` voor 0,0006%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1740212588&format=interactive",
  sheets_gid="2077755325"
  )
}}

De Async Clipboard API is relatief nieuw, dus het gebruik ervan is momenteel vrij laag. In maart 2020 heeft Safari ondersteuning toegevoegd voor de Async Clipboard API in Safari 13.1. In de loop van 2020 groeide het gebruik van de `read()` API. In oktober 2020 werd de API aangeroepen tijdens 0.0003% van alle pagina ladingen in Google Chrome.

### Schrijftoegang

Afgezien van leesbewerkingen biedt de Async Clipboard API ook twee methoden om inhoud naar het klembord te schrijven. Nogmaals, er is een verkorte methode voor platte tekst, genaamd `navigator.clipboard.writeText()`, en een voor willekeurige gegevens genaamd `navigator.clipboard.write()`. In op Chromium gebaseerde browsers is geen toestemming vereist om naar het klembord te schrijven terwijl het tabblad actief is. Proberen naar het klembord te schrijven wanneer de website op de achtergrond staat, is wel toestemming voor nodig. Aangezien deze methode eerst een gebruikersgebaar en toestemming vereist, valt deze niet onder de HTTP Archive-statistieken. In tegenstelling tot de `read()` - methode, laat de `write()` - methode een exponentiële groei in gebruik zien, die deel uitmaakt van 0,0006% van alle paginaladingen in oktober 2020.

De <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=897289">Raw Clipboard Access API</a>, een andere Fugu-mogelijkheid, zou de Async Clipboard API nog verder kunnen verbeteren door het mogelijk te maken dat willekeurige gegevens worden gekopieerd van of geplakt op het klembord.

## StorageManager API

Webbrowsers stellen gebruikers in staat om gegevens op verschillende manieren op het systeem van de gebruiker op te slaan, zoals cookies, de Indexed Database (IndexedDB), de Service Worker's Cache Storage, of Web Storage (Local Storage, Session Storage). In moderne browsers kunnen ontwikkelaars gemakkelijk <a hreflang="en" href="https://web.dev/storage-for-the-web/">honderden megabytes en zelfs meer opslaan</a>, afhankelijk van de browser. Wanneer browsers onvoldoende ruimte hebben, kunnen ze gegevens wissen totdat het systeem niet langer de limiet overschrijdt, wat kan leiden tot gegevensverlies.

Dankzij de [StorageManager API](https://developer.mozilla.org/en-US/docs/Web/API/StorageManager), die deel uitmaakt van de <a hreflang="en" href="https://storage.spec.whatwg.org/#storagemanager">WHATWG Storage Living Standard</a>, gedragen browsers zich in dat opzicht niet langer als een zwarte doos. Met deze API kunnen ontwikkelaars de resterende beschikbare ruimte schatten en zich aanmelden voor <a hreflang="en" href="https://web.dev/persistent-storage/">permanente opslag</a>, wat betekent dat de browser de gegevens van een website niet wist wanneer er weinig schijfruimte is. Daarom introduceert de API een nieuwe `StorageManager`-interface op het `navigator`-object, momenteel beschikbaar in Chrome, Edge en Firefox.

### Schat de beschikbare opslagruimte in

Ontwikkelaars kunnen de beschikbare opslagruimte schatten door `navigator.storage.estimate()` aan te roepen. Deze methode retourneert een belofte die wordt opgelost naar een object met twee eigenschappen: `usage` toont het aantal bytes dat door de toepassing wordt gebruikt en `quota` bevat het maximale aantal beschikbare bytes.

{{ figure_markup(
  image="storage_manager_api_estimate.png",
  alt="Aantal pagina's dat de schattingsmethode van de StorageManager API gebruikt.",
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
  alt="Aantal pagina's dat de `persist`-methode van de StorageManager API gebruikt.",
  caption="Aantal pagina's dat de `persist`-methode van de StorageManager API gebruikt.",
  description="Grafiek van het gebruik van de `persist`-methode van StorageManager API, op basis van het aantal pagina's dat wordt gecontroleerd door HTTP Archive. Het vergelijkt het gebruik op mobiele en desktop-apparaten. Op desktoppagina's is het gebruik nagenoeg stabiel, terwijl er meer fluctuatie is op mobiele apparaten. In oktober 2020 maken 25 desktoppagina's en 176 mobiele pagina's gebruik van de API.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=644836316&format=interactive",
  sheets_gid="1095648844",
  sql_file="durable_storage_persist_usage.sql"
  )
}}

De `persist()` API wordt minder vaak aangeroepen dan de `estimate()` methode. Slechts 176 mobiele pagina's maken gebruik van deze API, vergeleken met 25 desktopwebsites. Hoewel het gebruik op de desktop op dit lage niveau lijkt te blijven, is er geen duidelijke trend op mobiele apparaten.

## New Notification APIs

Met behulp van de Push- en Notifications-API's kunnen webapplicaties al lang pushberichten ontvangen en meldingsbanners weergeven. Er ontbraken echter enkele onderdelen. Tot nu toe moesten push-berichten via de server worden verzonden; ze konden niet offline worden gepland. Ook konden webtoepassingen die op het systeem waren geïnstalleerd, geen badges op hun pictogram weergeven. De API's voor badging en Notification Triggers maken beide scenario's mogelijk.

### Badging API

Op verschillende platforms is het gebruikelijk dat applicaties een badge presenteren op het pictogram van de applicatie die het aantal openstaande acties aangeeft. De badge kan bijvoorbeeld het aantal ongelezen e-mails, meldingen of taken weergeven dat moet worden voltooid. Met de <a hreflang="en" href="https://web.dev/badging-api/">Badging API</a> (<a hreflang="en" href="https://w3c.github.io/badging/">W3C Unofficial Draft</a>) kunnen geïnstalleerde webapplicaties een dergelijke badge weergeven op het icoon. Door `navigator.setAppBadge()` aan te roepen, kunnen ontwikkelaars de badge instellen. Voor deze methode is een nummer nodig om op de badge van de applicatie te worden weergegeven. De browser zorgt er vervolgens voor dat de weergave zo goed mogelijk wordt weergegeven op het apparaat van de gebruiker. Als er geen nummer is opgegeven, wordt een algemene badge weergegeven (bijvoorbeeld een witte stip op macOS). Door `navigator.clearAppBadge()` aan te roepen, wordt de badge weer verwijderd. De Badging-API is een uitstekende keuze voor e-mailklanten, apps voor sociale media of messengers. De Twitter PWA maakt gebruik van de Badging API om het aantal ongelezen meldingen op de badge van de applicatie weer te geven.

{{ figure_markup(
  image="badging_api.png",
  alt="Percentage pagina's dat wordt geladen in Chrome met behulp van de Badging-API",
  caption='Percentage pagina\'s dat wordt geladen in Chrome met behulp van de Badging-API.<br>(Bronnen: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2726">Badge Set</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2727">Badge Clear</a>)',
  description="Grafiek van Badging API-gebruik, gebaseerd op het percentage pagina's dat met deze functie in Chrome wordt geladen. Het vergelijkt de `set` en `clear` methoden. Het gebruik van beide methoden groeit in de loop van de tijd, waarbij de `set` methode over het algemeen vaker wordt aangeroepen. In oktober 2020 is er een plotselinge groei voor beide methoden, met een piek van 0,025% van het laden van pagina's voor de `set` methode en 0,016% voor `clear`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1145004925&format=interactive",
  sheets_gid="1154751352"
  )
}}

In april 2020 heeft Google Chrome 81 de nieuwe Badging API verzonden, gevolgd door Microsoft Edge 84 in juli. Nadat Chrome de API had verzonden, schoten de gebruikscijfers omhoog. In oktober 2020 wordt bij 0,025% van alle pagina's die in Google Chrome worden geladen, de `setAppBadge()` - methode aangeroepen. De `clearAppBadge()` - methode wordt minder vaak aangeroepen, wanneer ongeveer 0,016% van de pagina's wordt geladen.

### Notification Triggers API

De Push API vereist dat de gebruiker online is om een melding te ontvangen. Sommige applicaties, zoals games, herinnerings- of taakapps, agenda's of wekkers, kunnen ook de streefdatum voor een melding lokaal bepalen en deze plannen. Om deze functie te ondersteunen, experimenteert het Chrome-team met een nieuwe API genaamd <a hreflang="en" href="https://web.dev/notification-triggers/">Notification Triggers</a> (<a hreflang="en" href="https://github.com/beverloo/notification-triggers/blob/master/README.md">Uitleg</a>, nog niet op een standaardspoor). Deze API voegt een nieuwe eigenschap toe genaamd `showTrigger` aan de `options` map die kan worden doorgegeven aan de `showNotification()` methode bij de registratie van de Service Worker. De API is ontworpen om in de toekomst verschillende soorten triggers mogelijk te maken, hoewel voorlopig alleen op tijd gebaseerde triggers worden geïmplementeerd. Voor het plannen van een melding op basis van een bepaalde datum en tijd, kunnen ontwikkelaars een nieuwe instantie van een `TimestampTrigger` maken en het beoogde tijdstempel hieraan doorgeven:

```js
registration.showNotification('Title', {
  body: 'Message',
  showTrigger: new TimestampTrigger(timestamp),
});
```

{{ figure_markup(
  image="notification_triggers_api.png",
  alt="Percentage pagina's dat wordt geladen in Chrome met behulp van de Notification Triggers API",
  caption='Percentage pagina's dat wordt geladen in Chrome met behulp van de Notification Triggers API.<br>(Bron: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">Notification Triggers</a>)',
  description="Diagram met Notification Triggers API-gebruik, gebaseerd op het percentage pagina's dat in Chrome wordt geladen met deze functie. Het vertoont een piek in maart 2020 met ongeveer 0,00003% van de paginaladingen, en daalt tot nul in oktober 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1388597384&format=interactive",
  sheets_gid="1740370570"
  )
}}

Het Fugu-team experimenteerde eerst met Notification Triggers in een oorspronkelijke proef van Chrome 80 tot 83, waarbij de ontwikkeling later werd onderbroken vanwege het gebrek aan feedback van ontwikkelaars. Beginnend met Chrome 86 uitgebracht in oktober 2020, is de API weer in de oorspronkelijke proeffase terechtgekomen. Dit verklaart ook de gebruiksgegevens van de Notification Triggers API die piekten toen ze werden aangeroepen op 0,000032% van de pagina's die in Chrome werden geladen tijdens de eerste oorspronkelijke proef rond maart 2020.

## Screen Wake Lock API

Om energie te besparen, verdonkeren mobiele apparaten de achtergrondverlichting van het scherm en schakelen uiteindelijk het scherm van het apparaat uit, wat in de meeste gevallen logisch is. Er zijn echter scenario's waarin de gebruiker wil dat de app het display expliciet wakker houdt, bijvoorbeeld bij het lezen van een recept tijdens het koken of het bekijken van een presentatie. De [Screen Wake Lock API](https://developer.mozilla.org/en-US/docs/Web/API/Screen_Wake_Lock_API) (<a hreflang="en" href="https://www.w3.org/TR/screen-wake-lock/">W3C Working Draft</a>) lost dit probleem op door een mechanisme te bieden om het scherm ingeschakeld te houden.

De `navigator.wakeLock.request()` methode creëert een "wake lock". Deze methode heeft een parameter `WakeLockType` nodig. In de toekomst zou de Wake Lock API andere vergrendelingstypen kunnen bieden, zoals het scherm uitschakelen, maar de CPU ingeschakeld houden. Voorlopig ondersteunt de API alleen schermvergrendelingen, dus er is slechts één optioneel argument met de standaardwaarde `'screen'`. De methode retourneert een belofte die wordt omgezet in een `WakeLockSentinel`-object. Ontwikkelaars moeten deze referentie opslaan om de `release()`-methode aan te roepen en de wake lock van het scherm later weer op te heffen. De browser zal automatisch de vergrendeling opheffen wanneer het tabblad inactief is, of de gebruiker minimaliseert het venster. Ook kan de browser een verzoek afwijzen en de belofte afwijzen, bijvoorbeeld vanwege een bijna lege batterij.

{{ figure_markup(
  image="screen_wake_lock_api.png",
  alt="Aantallen pagina's met behulp van Screen Wake Lock API.",
  caption="Aantallen pagina's met behulp van Screen Wake Lock API.",
  description="Grafiek van het gebruik van de Screen Wake Lock API, gebaseerd op het aantal pagina's dat wordt gecontroleerd door het HTTP Archive, waarbij desktop- en mobiele pagina's worden vergeleken. In oktober 2020 wordt de API gebruikt door 10 desktop- en 5 mobiele pagina's.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=718278185&format=interactive",
  sheets_gid="1008442251",
  sql_file="wake_lock_acquire_screen_lock_usage.sql"
  )
}}

BettyCrocker.com, een populaire kookwebsite in de VS, biedt hun gebruikers een optie om te voorkomen dat het scherm donker wordt tijdens het koken met behulp van de Screen Wake Lock API. In een <a hreflang="en" href="https://web.dev/betty-crocker/">casestudy</a> publiceerden ze dat de gemiddelde sessieduur 3,1 keer langer was dan normaal, het bouncepercentage met 50% afnam en de koopintentie-indicatoren met ongeveer 300%. De interface heeft dus een direct meetbaar effect op het succes van de website of applicatie. De Screen Wake Lock API werd in juli 2020 geleverd met Google Chrome 84. Het HTTP Archive bevat alleen gegevens voor april, mei, augustus, september en oktober. Na de release van Chrome 84 steeg het gebruik snel. In oktober 2020 werd de API aangenomen op 10 desktop- en 5 mobiele pagina's.

## Idle Detection API

Some applications need to determine if the user is actively using a device or if they are idle. For instance, chat applications may display that the user is absent. There are various factors that can be taken into account, such as a lack of interaction with the screen, mouse, or keyboard. The [Idle Detection API](https://web.dev/idle-detection/) ([WICG Draft Community Group Report](https://wicg.github.io/idle-detection/)) provides an abstract API that allows developers to check if either the user is idle or the screen locked, given a certain threshold.

To do so, the API provides a new `IdleDetector` interface on the global `window` object. Before developers can use this functionality, they have to request permission by calling `IdleDetector.requestPermission()` first. If the user grants the permission, developers can create a new instance of `IdleDetector`. This object provides two properties: `userState` and `screenState`, containing the respective states. It will raise a `change` event when either the user's or the screen's state change. Finally, the idle detector needs to be started by calling its `start()` method. The method takes a configuration object with two parameters: a `threshold` defining the time in milliseconds that the user has to be idle (the minimum is a minute), and developers can optionally pass an `AbortSignal` to the `abort` property, which serves to abort idle detection later on.

{{ figure_markup(
  image="idle_detection_api.png",
  alt="Percentage of page loads in Chrome using Idle Detection API",
  caption='Percentage of page loads in Chrome using Idle Detection API.<br>(Source: <a href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">Idle Detection</a>)',
  description="Chart of Idle Detection API usage, based on the percentage of page loads in Chrome using this feature. There's only data available for July and October 2020, showing a very low adoption of the API.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=963792757&format=interactive",
  sheets_gid="1324588405"
  )
}}

At the time of this writing, the Idle Detection API is in an origin trial, so its API shape may change in the future. For the same reason, its usage is very low and hardly measurable.

## Periodic Background Sync API

When the user closes a web application, it cannot communicate with its backend service anymore. In some cases, developers might still want to synchronize data on a more or less regular basis, just as native applications can. For instance, news applications might want to download the latest headlines before the user wakes up. The [Periodic Background Sync API](https://web.dev/periodic-background-sync/) ([WICG Draft Community Group Report](https://wicg.github.io/periodic-background-sync/)) strives to bridge this gap between web and native.

### Register for periodic sync

The Periodic Background Sync API relies on Service Workers that can run even when the app is closed. As with other capabilities, this API requires users' permission first. The API implements a new interface called `PeriodicSyncManager`. If present, developers can access an instance of this interface on the Service Worker's registration. To synchronize data in the background, the application has to register first, by calling `periodicSync.register()` on the registration. This method takes two parameters: a `tag`, which is an arbitrary string to recognize the registration again later on, and a configuration object that takes a `minInterval` property. This property defines the desired minimum interval in milliseconds by the developer. However, the browser ultimately decides how often it will actually invoke background synchronization:

```js
registration.periodicSync.register('articles', {
  minInterval: 24 * 60 * 60 * 1000 // one day
});
```

### Respond to a periodic sync interval

For each tick of the interval, and if the device is online, the browser triggers the Service Worker's `periodicsync` event. Then, the Service Worker script can perform the necessary steps to synchronize the data:

```js
self.addEventListener('periodicsync', (event) => {
  if (event.tag === 'articles') {
    event.waitUntil(syncStuff());
  }
});
```

At the time of this writing, only Chromium-based browsers implement this API. On these browsers, the application has to be installed first (i.e., added to the homescreen) before the API can be used. The [site engagement score](https://www.chromium.org/developers/design-documents/site-engagement) of the website defines if and how often periodic sync events can be invoked. In the current conservative implementation, websites can sync content once a day.

{{ figure_markup(
  image="periodic_background_sync_api.png",
  alt="Number of pages using Periodic Background Sync API.",
  caption="Number of pages using Periodic Background Sync API.",
  description="Chart of Periodic Background Sync API usage, based on the number of pages monitored by HTTP Archive. It compares the usage on mobile and desktop devices. Since April 2020, the API is used by one to two desktop and mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1444904371&format=interactive",
  sheets_gid="386193538",
  sql_file="periodic_background_sync_usage.sql"
  )
}}

The use of the interface is currently very low. Over 2020, only one or two pages monitored by HTTP Archive made use of this API.

## Integration with native app stores

PWAs are a versatile application model. However, in some cases, it may still make sense to offer a separate native application: for example, if the app needs to use features that are not available on the web, or based on the programming experience of the app developer team. When the user already has a native app installed, apps might not want to send notifications twice or promote the installation of a corresponding PWA.

To detect if the user already has a related native application or PWA on the system, developers can use the [getInstalledRelatedApps() method](https://web.dev/get-installed-related-apps/) ([WICG Draft Community Group Report](https://wicg.github.io/get-installed-related-apps/spec/)) on the `navigator` object. This method is currently provided by Chromium-based browsers and works for both Android and Universal Windows Platform (UWP) apps. Developers need to adjust the native app bundles to refer to the website and add information about the native app(s) to the Web App Manifest of the PWA. Calling the `getInstalledRelatedApps()` method will then return the list of apps installed on the user's device:

```js
const relatedApps = await navigator.getInstalledRelatedApps();
relatedApps.forEach((app) => {
  console.log(app.id, app.platform, app.url);
});
```

{{ figure_markup(
  image="get_installed_related_apps.png",
  caption="Number of pages using getInstalledRelatedApps().",
  description="Chart of getInstalledRelatedApps() usage, based on the number of pages monitored by HTTP Archive. It compares the usage on mobile and desktop devices. It shows a steady growth for mobile devices, peaking at 363 pages in October 2020 compared to 44 desktop pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1774881171&format=interactive",
  sheets_gid="860146688",
  sql_file="get_installed_related_apps_usage.sql"
  )
}}

Over the course of 2020, the `getInstalledRelatedApps()` API shows a steady growth on mobile websites. In October, 363 mobile pages tracked by the HTTP Archive made use of this API. On desktop pages, the API does not grow quite as fast. This could also be due to Android stores currently providing significantly more apps than the Microsoft Store does for Windows.

## Content Indexing API

Web apps can store content offline using various ways, such as Cache Storage, or IndexedDB. However, for users it's hard to discover which content is available offline. The [Content Indexing API](https://web.dev/content-indexing-api/) ([WICG Editor's Draft](https://wicg.github.io/content-index/spec/)) allows developers to expose content more prominently. Currently, Chrome on Android is the only browser to support this API. This browser shows a list of "Articles for you" in the Downloads menu. Content indexed via the Content Indexing API will appear there.

The Content Indexing API extends the Service Worker API by providing a new `ContentIndex` interface. This interface is available via the `index` property of the Service Worker's registration. The `add()` method allows developers to add content to the index: Each piece of content must have an ID, a URL, a launch URL, title, description, and a set of icons. Optionally, the content can be grouped into different categories such as articles, homepages, or videos. The `delete()` method allows for removing content from the index again, and the `getAll()` method returns a list of all indexed entries.

{{ figure_markup(
  image="content_indexing_api.png",
  alt="Percentage of page loads in Chrome using Content Indexing API",
  caption='Percentage of page loads in Chrome using Content Indexing API.<br>(Source: <a href="https://chromestatus.com/metrics/feature/timeline/popularity/3017">Content Indexing</a>)',
  description="Chart of Content Indexing API usage, based on the percentage of page loads in Chrome using this feature. It shows a relatively low usage at first, until it suddenly grows tenfold in October 2020, being used during 0.0021% of page loads in Chrome.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=258329620&format=interactive",
  sheets_gid="626752011"
  )
}}

The Content Indexing API launched with Chrome 84 in July 2020. Directly after shipping, the API was used during approximately 0.0002% of page loads in Chrome. In October 2020, this value has increased almost tenfold.

## New Transport APIs

Finally, there are two new transport methods that are currently in origin trial. The first one allows developers to receive high-frequency messages with WebSockets, while the second one introduces an entirely new bidirectional communication protocol apart from HTTP and WebSockets.

### Backpressure for WebSockets

The WebSocket API is a great choice for bidirectional communication between websites and servers. However, the WebSocket API does not allow for backpressure, so applications dealing with high-frequency messages may freeze. The [WebSocketStream API](https://web.dev/websocketstream/) ([Explainer](https://github.com/ricea/websocketstream-explainer/blob/master/README.md), not on the standards track yet) wants to bring easy-to-use backpressure support to the WebSocket API by extending it with streams. Instead of using the usual `WebSocket` constructor, developers need to create a new instance of the `WebSocketStream` interface. The `connection` property of the stream returns a promise that resolves to a readable and writable stream that allow to obtain a stream reader or writer, respectively:

```js
const wss = new WebSocketStream(WSS_URL);
const {readable, writable} = await wss.connection;
const reader = readable.getReader();
const writer = writable.getWriter();
```

The WebSocketStream API transparently solves backpressure, as the stream readers and writers will only proceed if it's safe to do so.

{{ figure_markup(
  image="websocketstreams.png",
  alt="Percentage of page loads in Chrome using WebSocketStreams",
  caption='Percentage of page loads in Chrome using WebSocketStreams.<br>(Source: <a href="https://chromestatus.com/metrics/feature/timeline/popularity/3018">WebSocketStream</a>)',
  description="Chart of WebSocketStreams usage, based on the percentage of page loads in Chrome using this feature. It shows a peak in June and July 2020, where the API was used during approximately 0.0008% of page loads.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1714443590&format=interactive",
  sheets_gid="691106754"
  )
}}

The WebSocketStream API has completed its first origin trial and is now back in the experimentation phase again. This also explains why the usage of this API currently is so low that it's hardly measurable.

### Make it QUIC

[QUIC](https://www.chromium.org/quic) ([IETF Internet-Draft](https://www.ietf.org/archive/id/draft-ietf-quic-transport-31.txt)) is a multiplexed, stream-based, bidirectional transport protocol implemented on UDP. It's an alternative to HTTP/WebSocket APIs that are implemented on top of TCP. The [QuicTransport API](https://web.dev/quictransport/) is the client-side API for sending messages to and receiving messages from a QUIC server. Developers can choose to send data unreliably via datagrams, or reliably by using its streams API:

```js
const transport = new QuicTransport(QUIC_URL);
await transport.ready;

const ws = transport.sendDatagrams();
const stream = await transport.createSendStream();
```

QuicTransport is a valid alternative to WebSockets, as it supports the use cases from the WebSocket API and adds support for scenarios where minimal latency is more important than reliability and message order. This makes it a good choice for games and applications dealing with high-frequency events.

{{ figure_markup(
  image="quic_transport.png",
  alt="Percentage of page loads in Chrome using QuicTransport",
  caption='Percentage of page loads in Chrome using QuicTransport.<br>(Source: <a href="https://chromestatus.com/metrics/feature/timeline/popularity/3184">QuicTransport</a>)',
  description="Chart of QuicTransport usage, based on the percentage of page loads in Chrome using this feature. It shows a peak in October 2020, where the API was used during approximately 0.00089% of page loads.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxqot9ALgxcgOVJntkzIKnkpo3idIPy-tL0t_nzC5BwFuq0ThgK5OXOYVVOpama4vB2EyggX813d33/pubchart?oid=1571330893&format=interactive",
  sheets_gid="708893754"
  )
}}

The use of the interface is currently still so low that it's hardly measurable. In October 2020, it has increased strongly and is now used during 0.00089% of page loads in Chrome.

## Conclusion

The state of web capabilities in 2020 is healthy, as new, powerful APIs regularly ship with new releases of Chromium-based browsers. Some interfaces like the Content Indexing API or Idle Detection API help to add finishing touches to certain web applications. Other APIs, such as the File System Access and Async Clipboard API, allow a whole new application category, namely productivity apps, to finally fully make the shift to the web. Some APIs such as Async Clipboard and Web Share API have already made their way into other, non-Chromium browsers. Safari even was the first mobile browser to implement the Web Share API.

Through its [rigorous process](https://developers.google.com/web/updates/capabilities#process), the Fugu team ensures that access to these features takes place in a secure and privacy-friendly manner. Additionally, the Fugu team actively solicits the [feedback](mailto:fugu-dev@chromium.org) from other browser vendors and web developers. While the usage of most of these new APIs is comparatively low, some APIs presented in this chapter show an exponential or even hockey stick-like growth, such as the Badging or Content Indexing API. The state of web capabilities in 2021 will depend on the web developers themselves. The author encourages the community to build great web applications, make use of the powerful APIs in a backwards-compatible manner, and help make the web a more capable platform.
