---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Capabilities
description: Kapitel über Capabilities im Web Almanac 2025, das brandneue, leistungsstarke Web-Platform-APIs behandelt, die Web-Apps Zugriff auf Hardware-Schnittstellen geben, webbasierte Produktivitäts-Apps verbessern, integrierte KI ermöglichen und mehr.
hero_alt: Heldenbild von Web-Almanac-Charakteren mit Superhelden-Capes, die verschiedene Capabilities in eine Webseite einstecken.
authors: [Dawntraoz]
reviewers: [webmaxru, tomayac]
analysts: [guaca, tomayac]
editors: [tunetheweb]
translators: [mika943]
Dawntraoz_bio: Alba Silvente ist Senior Frontend Engineer bei Funda. Sie schreibt gerne über Frontend-Entwicklung, Jamstack und Web-Performance auf <a hrefleng="en" href="https://www.dawntraoz.com/">ihrem Blog</a>, hält Konferenzvorträge, moderiert Tech-Podcasts und engagiert sich intensiv in der Open-Source-Community. Sie ist außerdem Google Developer Expert für Web-Technologien, Microsoft MVP und Ambassador bei Women Tech Makers.
results: https://docs.google.com/spreadsheets/d/1tBTCtkEw0QEOyebuHIettqGEKw1gtO2EB1jkwpRKb18
featured_quote: Capabilities im Web entwickeln sich weiterhin, wobei etablierte APIs eine stetige Verbreitung verzeichnen, während gleichzeitig eine neue Klasse browser-nativer KI-Funktionen entsteht.
featured_stat_1: ~13%
featured_stat_label_1: Websites, die die Compression Streams API nutzen.
featured_stat_2: ~5%
featured_stat_label_2: Websites, die die Media Capabilities API nutzen.
featured_stat_3: <1%
featured_stat_label_3: Websites, die browser-native KI-APIs nutzen.
doi: 10.5281/zenodo.18246600
---

## Einleitung

Heutige Webbrowser bieten ein reichhaltigeres Web-Erlebnis als je zuvor. Sie sind nicht auf die grundlegenden Fähigkeiten des Browsers selbst beschränkt; sie nutzen auch tiefer liegende Funktionen und das Betriebssystem, auf dem sie laufen.

Diese Capabilities werden über Web-Platform-APIs zugänglich gemacht, darunter etablierte wie [Clipboard](https://developer.mozilla.org/docs/Web/API/Clipboard_API), [File System](https://developer.mozilla.org/docs/Web/API/File_System_API) und [Service Worker](https://developer.mozilla.org/docs/Web/API/Service_Worker_API), sowie neue, sich noch in der experimentellen Phase befindliche APIs, die das Potenzial haben, die Erstellung von Web-Apps grundlegend zu verändern.

Im Zeitalter der KI können Browser es sich nicht leisten, zurückzubleiben – sie müssen nachhaltige, zugängliche KI-APIs für alle bereitstellen, um die Nutzung von KI zu demokratisieren. Daher werden wir in diesem Jahr im Capabilities-Kapitel die ersten Anwendungen dieser neuen, Chrome- und Edge-spezifischen APIs besprechen.

## Methodik

Dieses Kapitel nutzte, wie in den Vorjahren, den öffentlichen Datensatz des HTTP Archives mit Millionen von Seiten. Diese Seiten wurden sowohl für Desktop als auch für Mobilgeräte archiviert, da manche Websites je nach anfragendem Gerät unterschiedliche Inhalte ausliefern.

### Wie erkennt das HTTP Archive Capabilities?

Der HTTP-Archive-Crawler analysiert den Quellcode all dieser Seiten, um mittels regulärer Ausdrücke wie `/navigator\.share\s*\(/g` zu bestimmen, welche APIs auf den Seiten (möglicherweise) verwendet wurden.

Diese Vorgehensweise kann bei der Erkennung zu gewissen Problemen führen: Sie kann die Nutzung einiger APIs unterschätzen, da Code, der durch Minifizierung verändert wurde, nicht erkannt werden kann – zum Beispiel, wenn `navigator` zu `n` minifiziert wurde; oder sie kann das Vorkommen von APIs überschätzen, da kein Code ausgeführt wird, um zu prüfen, ob eine API tatsächlich verwendet wird.

Auch mit diesen Einschränkungen sollten wir, wie in anderen Ausgaben dieses Kapitels, dennoch einen recht guten Überblick darüber erhalten, welche Capabilities heutzutage im Web verwendet werden.

Insgesamt existieren 86 reguläre Ausdrücke für unterstützte Capabilities; in dieser <a hreflang="en" href="https://github.com/HTTPArchive/custom-metrics/blob/main/dist/fugu-apis.js">Quelldatei</a>, basierend auf dem Projekt <a href="https://github.com/tomayac/fugu-api-data">Fugu API Data</a>, lassen sich alle verwendeten Ausdrücke einsehen.

### Project Fugu

Bevor wir uns den Daten zuwenden, möchten wir unseren Dank an Project Fugu aussprechen, eine unternehmensübergreifende Initiative, die darauf abzielt, Funktionsgleichheit zwischen Web- und Mobil-/Desktop-Anwendungen zu erreichen.

Dank dieser Initiative können wir von vielen Funktionen profitieren, die zuvor nur Anwendungen vorbehalten waren, indem plattformspezifische Capabilities dem Web zugänglich gemacht werden.

Wenn du wissen möchtest, welche APIs in diesem Kontext zugänglich gemacht werden, besuche den Chrome-Developers-Blog, um mehr über das [Capabilities Project](https://developer.chrome.com/docs/capabilities) zu erfahren.

## Die 7 meistgenutzten Funktionen

Der folgende Abschnitt beleuchtet die sieben am weitesten verbreiteten Web-Platform-Capabilities, die im Datensatz von 2025 beobachtet wurden. Diese Funktionen stellen eine Mischung aus seit langem etablierten APIs und neueren Ergänzungen dar, die eine breite, praktische Verbreitung erreicht haben. Ihre Verbreitung sowohl auf mobilen als auch auf Desktop-Seiten spiegelt wider, worauf sich die Web-Plattform heute am häufigsten stützt, und liefert eine nützliche Grundlage, um zu verstehen, welche Capabilities zu grundlegenden Bausteinen moderner Webanwendungen geworden sind.

### Compression Streams API

Die [Compression Streams API](https://developer.mozilla.org/docs/Web/API/Compression_Streams_API) ermöglicht es Web-Apps, Daten mithilfe weit verbreiteter Formate wie GZIP und Deflate (seit Kurzem auch Brotli) direkt im Browser zu komprimieren und zu dekomprimieren. Dies ermöglicht eine effizientere Übertragung und Speicherung großer Datenmengen, ohne auf serverseitige Verarbeitung zurückgreifen zu müssen.

Die Datenverarbeitung erfolgt über die Objekte `CompressionStream` und `DecompressionStream`, die sich in die [Streaming-APIs](https://web.dev/streams) des Webs (`ReadableStream`, `WritableStream`) einfügen.

```js
const text = "Hello Web Almanac 2025!";
const stream = new Blob([text]).stream();
const compressed = stream.pipeThrough(new CompressionStream("gzip"));
const decompressed = compressed.pipeThrough(new DecompressionStream("gzip"));
const result = await new Response(decompressed).text();

console.log(result); // "Hello Web Almanac 2025!"
```

Seit Mai 2023 funktioniert diese Funktion auf den neuesten Geräten und Browserversionen. Sie ist in Chromium-basierten Browsern, Safari und Firefox verfügbar, funktioniert aber möglicherweise nicht auf älteren Geräten oder in anderen Browsern.

{{ figure_markup(
  image="compression-streams.png",
  caption="Nutzung der Compression Streams API 2024–2025.",
  description="Balkendiagramm, das einen sprunghaften Anstieg der Nutzung der Compression Streams API auf mobilen und Desktop-Plattformen zwischen 2024 und 2025 zeigt. Auf Mobilgeräten stieg die Nutzung von nur 2,3 % im Jahr 2024 auf 12,3 % im Jahr 2025, was mehr als einer Verfünffachung entspricht. Die Desktop-Verbreitung verlief noch steiler und stieg im selben Zeitraum von 2,7 % auf 14,0 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=951480556&format=interactive",
  sheets_gid="1897009688",
  sql_file="fugu.sql"
  )
}}

Die Verbreitung der Compression Streams API wuchs zwischen 2024 und 2025 stark an und wurde 2025 zur meistgenutzten API, womit sie Clipboard überholte, die drei Jahre lang an der Spitze gestanden hatte.

Auf Mobilgeräten stieg die Nutzung von 2,3 % auf 12,3 %, auf Desktop von 2,7 % auf 14,0 %. Dieser steile Anstieg fällt mit der [breiten Unterstützung der API über alle wichtigen Engines hinweg](https://web.dev/blog/compressionstreams) in den letzten zwei Jahren zusammen, wodurch ein technisches Hindernis entfernt wurde und Entwickler JavaScript-Polyfills durch native gzip/deflate-Kompression ersetzen können.

Die API ist besonders attraktiv für datenintensive Anwendungen, bei denen Streaming-Effizienz wichtig ist, was ihre starke Verbreitungskurve erklärt.

### Clipboard API

Die [Clipboard API](https://developer.mozilla.org/docs/Web/API/Clipboard_API) bietet asynchronen Lese- und Schreibzugriff auf die Systemzwischenablage. Sie unterstützt Klartext, HTML, Bilder und andere Formate, wobei die Unterstützung je nach Browser variieren kann.

[Sicherheitsbeschränkungen](https://developer.mozilla.org/docs/Web/API/Clipboard_API#security_considerations) erfordern, dass Zwischenablage-Operationen durch eine Nutzeraktion (z. B. einen Klick) ausgelöst werden.

```js
// Text schreiben
await navigator.clipboard.writeText("Hello from Web Almanac!");

// Text lesen
const text = await navigator.clipboard.readText();

console.log(text); // "Hello from Web Almanac!"
```

Die Async-Clipboard-API wird in Chromium-basierten Browsern, Safari und Firefox unterstützt. Nur Chromium-basierte Browser unterstützen umfangreichere Zwischenablage-Daten, wie benutzerdefinierte Web-Formate.

{{ figure_markup(
  image="clipboard.png",
  caption="Nutzung der Clipboard API 2024–2025.",
  description="Balkendiagramm, das das Wachstum der Nutzung der Clipboard API auf mobilen und Desktop-Plattformen zwischen 2024 und 2025 zeigt. Auf Mobilgeräten stieg der Anteil der Seiten, die die API nutzen, von 10,0 % auf 11,2 %, während die Desktop-Nutzung einen ähnlichen Anstieg von 10,4 % auf 11,8 % verzeichnete. Insgesamt zeigen die Daten einen konstanten Aufwärtstrend bei der Verbreitung auf beiden Plattformen, wobei Desktop in beiden Jahren eine etwas höhere Gesamtnutzungsrate als Mobilgeräte beibehält.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=714385047&format=interactive",
  sheets_gid="1966659557",
  sql_file="fugu.sql"
  )
}}

Die Clipboard API verzeichnet weiterhin ein stetiges Wachstum. Die mobile Verbreitung stieg von 10,0 % im Jahr 2024 auf 11,2 % im Jahr 2025, während Desktop von 10,4 % auf 11,8 % zulegte. Dies spiegelt wider, dass Entwickler zunehmend von veralteten `execCommand()`-Zwischenablage-Hacks abrücken und die asynchrone API für Kopier-Buttons und Einfüge-Workflows nutzen. Das Wachstum von Jahr zu Jahr ist moderat, was unterstreicht, dass die Clipboard API nun ein gut etabliertes Hilfsmittel ist und keine aufstrebende Capability mehr.

### Web Share API

Die [Web Share API](https://developer.mozilla.org/docs/Web/API/Web_Share_API) ermöglicht es Web-Apps, den nativen Freigabemechanismus des Geräts aufzurufen, sodass Nutzer Text, URLs und Dateien mit anderen installierten Apps teilen können (zum Beispiel Messaging-, E-Mail- oder Social-Apps).

Die Hauptmethode ist `navigator.share()`, die ein Objekt mit den zu teilenden Daten entgegennimmt. Die optionale Methode `navigator.canShare()` kann verwendet werden, um zu prüfen, ob die bereitgestellten Daten (insbesondere Dateien) überhaupt teilbar sind, bevor ein Versuch unternommen wird.

Die API erfordert eine Nutzeraktion (z. B. einen Klick) und löst das Freigabe-Menü der Plattform aus, über das der Nutzer die App auswählen kann, mit der geteilt werden soll.

```js
const data = {
  title: "Web Almanac 2025",
  text: "Check out the latest edition of the Web Almanac!",
  url: "https://almanac.httparchive.org/en/2025/",
};

if (navigator.canShare && navigator.canShare(data)) {
  try {
    await navigator.share(data);
    console.log("Data shared successfully!");
  } catch (err) {
    console.error("Share failed:", err);
  }
} else {
  console.warn("Sharing not supported on this device.");
}
```

Die Web Share API wird in modernen Versionen von Chrome, Edge und Safari unterstützt. Firefox implementiert sie nicht (obwohl sie hinter einem Flag existiert).

{{ figure_markup(
  image="web-share.png",
  caption="Nutzung der Web Share API 2024–2025.",
  description="Balkendiagramm, das einen moderaten Anstieg der Nutzung der Web Share API auf mobilen und Desktop-Plattformen von 2024 bis 2025 zeigt. Die mobile Nutzung stieg von 6,0 % auf 6,6 %, während die Desktop-Nutzung einen ähnlichen geringfügigen Anstieg von 6,2 % auf 6,7 % verzeichnete.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1903144577&format=interactive",
  sheets_gid="930326182",
  sql_file="fugu.sql"
  )
}}

Es gab geringfügige Anpassungen bei der Nutzung einer der am weitesten verbreiteten APIs, die derzeit den dritten Platz im Ranking der meistgenutzten APIs belegt.

Die Verbreitung der Web Share API blieb weitgehend stabil, wobei Mobilgeräte leicht von 6,0 % im Jahr 2024 auf 6,6 % im Jahr 2025 zulegten und Desktop von 6,2 % auf 6,7 % stieg. Die Verbreitung war größtenteils unverändert, mit einem leichten Anstieg. Diese API hat nun einen Zustand der Reife und Stabilität in den wichtigsten Browsern erreicht; diese geringfügigen Zugewinne deuten eher auf natürliche Schwankungen als auf signifikantes Wachstum hin.

### Device Memory API

Die [Device Memory API](https://developer.mozilla.org/docs/Web/API/Device_Memory_API) gibt über `navigator.deviceMemory` einen Näherungswert für den Arbeitsspeicher (RAM) des Geräts in Gigabyte an. Dies ermöglicht es Entwicklern, Erlebnisse anzupassen (zum Beispiel leichtere Seiten für Geräte mit wenig Speicher auszuliefern).

Der Wert ist aus Datenschutzgründen gerundet und grobkörnig.

```js
console.log(navigator.deviceMemory);
// Beispielausgabe: 8 (für ein Gerät mit 8 GB)
```

Verfügbar in Chromium-basierten Browsern; nicht unterstützt in Safari oder Firefox.

{{ figure_markup(
  image="device-memory.png",
  caption="Nutzung der Device Memory API 2024–2025.",
  description="Balkendiagramm, das ein Wachstum der Nutzung der Device Memory API für mobile und Desktop-Plattformen zeigt. Die mobile Nutzung stieg von 5,0 % im Jahr 2024 auf 6,3 % im Jahr 2025, während die Desktop-Nutzung von 4,9 % auf 6,2 % zulegte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=799153560&format=interactive",
  sheets_gid="1811570014",
  sql_file="fugu.sql"
  )
}}

Die Device Memory API verzeichnete einen deutlichen Anstieg, von 5,0 % auf 6,3 % auf Mobilgeräten und von 4,9 % auf 6,2 % auf Desktop. Dieser Anstieg spiegelt eine breitere Anerkennung des Nutzens der API für adaptive Performance-Strategien wider, bei denen Entwickler leichtere Assets an Geräte mit wenig Speicher ausliefern können. Eine weitere mögliche Erklärung könnte sein, dass Entwickler versuchen festzustellen, ob KI-Inferenz auf einem Gerät anhand des verfügbaren Speichers sinnvoll durchführbar ist, bevor ein KI-Modell herunterladen wird.

Immer mehr Entwickler nutzen `navigator.deviceMemory`, um leichtere Erlebnisse auf Geräten mit wenig Speicher bereitzustellen. Während die Verbreitung weiterhin durch die ausschließliche Verfügbarkeit in Chromium sowie die bewusst grobkörnigen Werte eingeschränkt ist, zeigt das Wachstum, dass performance-bewusste Websites beginnen, sie praktisch zu nutzen.

### Media Session API

Die [Media Session API](https://developer.mozilla.org/docs/Web/API/Media_Session_API) ermöglicht es Entwicklern, Medienbenachrichtigungen anzupassen und sich in plattformseitige Mediensteuerungen zu integrieren (zum Beispiel Sperrbildschirm, Headset-Tasten oder Smart Displays).

Mit `navigator.mediaSession` können Apps Metadaten und Aktionen für die Medienwiedergabe definieren.

```js
navigator.mediaSession.metadata = new MediaMetadata({
  title: "Web Almanac Podcast",
  artist: "HTTP Archive",
  album: "2025 Edition",
});

navigator.mediaSession.setActionHandler("play", () => {
  audio.play();
});
```

Weit verbreitet unterstützt in Chromium-basierten Browsern und Safari. Firefox unterstützt einige wichtige Funktionen nicht.

{{ figure_markup(
  image="media-session.png",
  caption="Nutzung der Media Session API 2024–2025.",
  description="Dieses Balkendiagramm zeigt die Nutzung der Media Session API, die als einzige einen leicht rückläufigen Trend auf beiden Plattformen aufweist. Die mobile Nutzung sank von 4,9 % im Jahr 2024 auf 4,7 % im Jahr 2025, während die Desktop-Verbreitung ebenfalls leicht von 5,5 % auf 5,3 % zurückging.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1577112625&format=interactive",
  sheets_gid="1863050303",
  sql_file="fugu.sql"
  )
}}

Die Media Session API erlebte einen kleinen Rückgang. Die mobile Verbreitung sank von 4,9 % im Jahr 2024 auf 4,7 % im Jahr 2025, während Desktop leicht von 5,5 % auf 5,3 % zurückging. Diese Unterschiede sind gering und spiegeln wahrscheinlich eher natürliche Schwankungen im Datensatz wider als bedeutsame Veränderungen. Insgesamt bleibt die Nutzung stabil und konzentriert sich auf Audio- und Video-Websites wie Musikplayer und Podcast-Apps, bei denen die Integration mit plattformseitigen Mediensteuerungen das Nutzererlebnis verbessert.

### Add to Home Screen

Diese Capability ermöglicht es Nutzern, [eine Progressive Web App (PWA) wie eine app-ähnliche Erfahrung auf ihrem Gerät zu installieren](https://developer.chrome.com/blog/how_chrome_helps_users_install_the_apps_they_value).

Wenn eine Website die Installierbarkeitskriterien erfüllt, können Chrome und andere Browser ein Installations-Badge anzeigen (zum Beispiel ein Symbol in der Adressleiste oder eine „Installieren"-Menüoption), über das Nutzer die App zum Startbildschirm hinzufügen oder als eigenständige App installieren können, während gleichzeitig manuelle Installationsabläufe für Websites unterstützt werden, die diese Kriterien nicht erfüllen. Chrome experimentiert zudem mit ML-gesteuerten Installationsaufforderungen auf Android, um Nutzern zu helfen, installierbare Erlebnisse zu entdecken.

{{ figure_markup(
  image="add-to-home-screen.png",
  caption="Nutzung von Add to Home Screen 2024–2025.",
  description="Balkendiagramm, das einen leichten Rückgang der Nutzung von Add to Home Screen auf mobilen und Desktop-Plattformen zeigt. Die mobile Nutzung sank von 4,8 % im Jahr 2024 auf 4,6 % im Jahr 2025, während die Desktop-Verbreitung ebenfalls einen geringfügigen Rückgang von 5,1 % auf 4,9 % verzeichnete.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=398812036&format=interactive",
  sheets_gid="1084353718",
  sql_file="fugu.sql"
  )
}}

Die Verbreitung von Add-to-Home-Screen-Capabilities blieb stabil, wobei die mobile Nutzung leicht von 4,8 % im Jahr 2024 auf 4,6 % im Jahr 2025 sank und Desktop von 5,1 % auf 4,9 % zurückging. Diese geringen Rückgänge spiegeln wahrscheinlich normale Schwankungen und keinen tatsächlichen Abwärtstrend wider. Das Wachstum wird durch die Plattformfragmentierung eingeschränkt: Android und Chromium-basierte Browser bieten Installationsaufforderungen, während iOS auf einen manuellen, von Safari gesteuerten Installationsablauf setzt. Dies begrenzt die breite Verbreitung trotz zunehmender PWA-Adoption.

### Media Capabilities API

Die [Media Capabilities API](https://developer.mozilla.org/docs/Web/API/Media_Capabilities_API) ermöglicht es Entwicklern abzufragen, ob der Browser eine bestimmte Audio- oder Videokonfiguration effizient decodieren und wiedergeben kann.

Sie liefert Einblicke in Flüssigkeit (Smoothness) und Energieeffizienz für adaptives Medien-Streaming.

```js
const config = {
  type: "file",
  audio: {
    contentType: "audio/mp3",
    channels: 2,
    bitrate: 132700,
    samplerate: 5200,
  },
};

const result = await navigator.mediaCapabilities.decodingInfo(config);

console.log(result.supported); // true oder false
console.log(result.powerEfficient); // true oder false
```

Sie ist weit verbreitet und funktioniert auf vielen Geräten und Browserversionen. Seit Januar 2020 ist sie browserübergreifend verfügbar. Allerdings können einige Teile dieser Funktion in Browsern wie Safari noch unterschiedlich stark unterstützt werden.

{{ figure_markup(
  image="media-capabilities.png",
  caption="Nutzung der Media Capabilities API 2024–2025.",
  description="Balkendiagramm, das einen sprunghaften Anstieg der Nutzung der Media Capabilities API zeigt. Die mobile Verbreitung schoss von vernachlässigbaren 0,6 % auf 4,4 % hoch, während die Desktop-Nutzung einen noch größeren Sprung von 0,8 % auf 5,0 % verzeichnete.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1359620848&format=interactive",
  sheets_gid="1154224831",
  sql_file="fugu.sql"
  )
}}

Die Media Capabilities API verzeichnete im vergangenen Jahr ein dramatisches Wachstum. Die mobile Verbreitung stieg von lediglich 0,61 % im Jahr 2024 auf 4,37 % im Jahr 2025, während die Desktop-Nutzung von 0,75 % auf 5,00 % sprang. Dieser sprunghafte Anstieg deutet auf eine schnelle Verbreitung bei Streaming-Plattformen hin, die `decodingInfo()` nutzen, um Codec-Unterstützung, Wiedergabeflüssigkeit und Energieeffizienz zu bestimmen, bevor der beste Stream für ein Gerät ausgewählt wird. Im Gegensatz zu vielen anderen APIs, die nur geringfügige Veränderungen verzeichneten, befindet sich Media Capabilities klar auf einer schnellen Wachstumskurve, getrieben von medienintensiven Websites.

## Neue Funktionen im vergangenen Jahr

Eine der bemerkenswertesten Veränderungen im Capabilities-Kapitel für 2025 ist das erste Auftreten von [browser-nativen KI- und Sprach-APIs](https://developer.chrome.com/docs/ai/built-in-apis). Während KI im Web seit Jahren weit verbreitet über externe Dienste und Bibliotheken genutzt wird, stellen diese APIs eine Verschiebung hin zu integrierten, standardisierten Sprachfähigkeiten dar, die direkt vom Browser bereitgestellt werden.

### Integrierte KI-APIs

Stand 2025 ist nur eine Teilmenge dieser APIs außerhalb experimenteller Kontexte verfügbar: _LanguageDetector_, _Translator_, _Summarizer_ und _Prompt_ (beschränkt auf Erweiterungen). Andere integrierte KI-Capabilities – wie die regulär verfügbare _Prompt_-API, _Writer_, _Rewriter_ und _Proofreader_ – bleiben experimentell, erfordern zusätzliche Einrichtung und unterliegen vorübergehenden oder begrenzten Token-basierten Beschränkungen. Diese Unterscheidung ist wichtig für die Interpretation der Nutzungsdaten, da experimentelle Funktionen seltener in produktiven Websites auftauchen.

<figure>
  <table>
    <thead>
      <tr>
        <th>Integrierte KI-API</th>
        <th>Desktop</th>
        <th>Mobil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>LanguageDetector</td>
        <td>0,28%</td>
        <td>0,26%</td>
      </tr>
      <tr>
        <td>Prompt</td>
        <td>0,08%</td>
        <td>0,09%</td>
      </tr>
      <tr>
        <td>Translator</td>
        <td>0,28%</td>
        <td>0,26%</td>
      </tr>
      <tr>
        <td>Summarizer</td>
        <td>0,13%</td>
        <td>0,14%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Nutzung integrierter KI-APIs", sheets_gid="843125108", sql_file="fugu.sql") }}</figcaption>
</figure>

Trotz ihrer Verfügbarkeit bleibt die Nutzung im Web sehr begrenzt. Wie in der Tabelle unten gezeigt, erscheint jede dieser APIs auf deutlich weniger als 1 % der Seiten in sowohl Desktop- als auch Mobile-Datensätzen; die tatsächliche Unterstützung ist derzeit jedoch hauptsächlich auf Desktop-Plattformen (Windows, macOS, Linux und ChromeOS auf Chromebook-Plus-Geräten) beschränkt. Language Detector und Translator werden am häufigsten beobachtet, jeweils genutzt auf etwa 0,28 % der Desktop-Seiten und 0,26 % der Mobile-Seiten, während Prompt und Summarizer einen noch geringeren Fußabdruck aufweisen.

Die niedrigen Verbreitungsraten sind zu erwarten. Diese APIs sind neu, befinden sich oft noch in der Entwicklung und werden derzeit nur von einer begrenzten Anzahl an Browsern unterstützt, nämlich Chrome und Edge. Ihre Aufnahme in den Datensatz von 2025 ist dennoch bedeutsam: Sie markiert die erste messbare Präsenz browser-nativer KI-Grundbausteine im HTTP Archive und etabliert eine Ausgangsbasis, um zu verfolgen, wie sich integrierte KI-Capabilities im Web in den kommenden Jahren entwickeln.

Siehe auch das Kapitel [Generative AI](./generative-ai) für eine ausführlichere Diskussion dieser APIs und von KI im Web.

## Fazit

Die Capabilities-Analyse 2025 zeigt eine Web-Plattform, die sich sowohl in Breite als auch in Tiefe weiterentwickelt. Etablierte APIs wie Compression Streams und Async Clipboard wuchsen deutlich oder stetig, was eine breitere Unterstützung über Engines hinweg sowie den Ersatz veralteter Muster durch Entwickler widerspiegelt. Funktionen wie Web Share, Media Session und Add to Home Screen blieben stabil, mit nur geringen Schwankungen von Jahr zu Jahr. Gleichzeitig verzeichneten spezialisierte APIs wie Media Capabilities eine bemerkenswerte Verbreitung bei medienintensiven Websites, was auf eine tiefere Verbreitung in vertikalen Anwendungsfällen hindeutet.

Am bemerkenswertesten ist, dass 2025 den ersten messbaren Fußabdruck browser-nativer KI- und Sprach-APIs markiert – darunter LanguageDetector, Translator, Prompt und Summarizer – selbst wenn jede von ihnen auf deutlich weniger als 1 % der Seiten erscheint. Ihre Präsenz schafft eine Ausgangsbasis für zukünftige Verbreitung und deutet auf eine Web-Plattform hin, die zunehmend bereit ist, höherstufige Capabilities zugänglich zu machen.

Mit Blick in die Zukunft wird das Wachstum wahrscheinlich durch fortschreitende Standardisierung und praktischen Nutzen geprägt sein: Während sich die Browser-Unterstützung festigt und sich das Entwickler-Tooling weiterentwickelt, könnten neue APIs den Weg von experimentellen Kuriositäten zu praktischen Bausteinen für reichhaltigere, intelligentere Webanwendungen finden.
