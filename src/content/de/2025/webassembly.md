---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: WebAssembly-Kapitel des Web Almanac 2025 über Nutzung, Sprachen und Post-MVP-Funktionen.
hero_alt: Hauptbild mit Web Almanac-Charakteren, die wissenschaftliche Experimente mit verschiedenen Code-Symbolen durchführen, was am Ende zu Nullen und Einsen führt.
authors: [nimeshgit]
reviewers: [nrllh, tunetheweb]
analysts: [nimeshgit]
editors: [tunetheweb]
translators: [mika943]
nimeshgit_bio: Nimesh bereitete digitale Transformations- und Automatisierungslösungen vor, mit einem Fokus auf KI- und ML-Analysen, Betriebsabläufe und Geschäftsprozesse.
results: https://docs.google.com/spreadsheets/d/16z2MNwq8FFbuNYcJJZceML6rB5VAmBXNNHZy5FZuf8g/edit
featured_quote: WebAssembly ist längst keine reine „Web“-Technologie mehr; es hat sich zu einem universellen High-Performance-Bytecode-Format entwickelt.
featured_stat_1: 0.35%
featured_stat_label_1: Desktop-Websites, die WebAssembly nutzen.
featured_stat_2: 228 MB
featured_stat_label_2: Größte gefundene WebAssembly-Datei.
featured_stat_3: 2.05%
featured_stat_label_3: Desktop-Websites in den Top 1.000, die WebAssembly nutzen.
doi: 10.5281/zenodo.18258991
---

## Einführung

WebAssembly (Wasm) hat sich von einem webzentrierten Optimierungswerkzeug zu einem universellen High-Performance-Bytecode-Format entwickelt. Seit 2019 offiziell <a hreflang="en" href="https://www.w3.org/TR/2019/REC-wasm-core-1-20191205/">als W3C-Standard anerkannt</a>, erreichte das Ökosystem mit der Veröffentlichung von <a hreflang="en" href="https://webassembly.github.io/spec/core/">Wasm Version 3.0 im Dezember 2025</a> einen technischen Wendepunkt. Diese Version standardisiert mehrere <a hreflang="en" href="https://webassembly.github.io/spec/core/">fortgeschrittene Funktionen</a>—wie Garbage Collection, einen 64-Bit-Adressraum und Multiple Memories. Dadurch können höhere Programmiersprachen wie Java, Kotlin und Dart nativ und effizient sowohl im Browser als auch in eigenständigen Umgebungen ausgeführt werden.

## Methodik

Wir folgen derselben Methodik wie im [Web Almanac 2021](../2021/webassembly#methodology), in dem WebAssembly zum ersten Mal vorgestellt wurde.

**Datenerhebung:** Dieses Kapitel stützt sich auf den Datensatz der HTTP-Archive-Crawl-Daten vom Juli 2025, der auf Google BigQuery gehostet wird. WebAssembly-Module werden identifiziert, indem nach dem `Content-Type` (`application/wasm`) und der Dateiendung `.wasm` gefiltert wird. Mit dieser Methode haben wir mindestens ein WebAssembly-Modul auf 43.000 Websites gefunden, was 0,35 % aller analysierten Seiten entspricht.

**Analyse:** Zusätzlich zum HTTP-Archive-Datensatz verwenden wir das Werkzeug <a hreflang="en" href="https://github.com/nimeshgit/almanac-wasm-stats">`almanac-wasm-stats`</a>, um die im HTTP Archive identifizierten WebAssembly-Module für eine lokale Analyse herunterzuladen und zu validieren. Dieses Tool extrahiert Metadaten aus den heruntergeladenen Dateien, wodurch wir Programmiersprachen, Bibliotheken und spezifische Funktionen innerhalb der Wasm-Module identifizieren können.

**Einschränkungen:** Unser Werkzeug `almanac-wasm-stats` konzentriert sich auf die statische Analyse von Wasm-Modulen und führt diese nicht aus. Daher können wir keine dynamischen Verhaltensweisen oder Laufzeitfunktionen erfassen, die während der tatsächlichen Ausführung in einem Browser oder einer eigenständigen Umgebung auftreten. Zudem können einige Wasm-Module obfuskieriert oder minifiziert sein, was unsere Fähigkeit einschränkt, ihre Eigenschaften genau zu bestimmen.
Wir haben ([wasm-stats](https://github.com/HTTPArchive/wasm-stats)) erweitert und die folgenden Funktionen in `almanac-wasm-stats` implementiert, um die Analyse der Sprachnutzung zu verbessern:

 1. Es kann Eingaben in URLs und entsprechenden User-Agent-Strings verarbeiten, was den Download-Prozess optimiert.
 2. Es akzeptiert eine riesige Anzahl von Eingaben im JSONL-Ergebnisformat von BigQuery.
 3. Es validiert Wasm und liefert Erkenntnisse mit dem Binary Toolkit, was zur Verbesserung der Statistiken beiträgt (vgl. wasm2wat).
 4. Es führt Aufgaben parallel aus und verfolgt diese (z. B. das Herunterladen von Wasm-Dateien, Validieren und Befüllen von Statistiken).
 5. Es verbessert die Spracherkennung für ältere Rust-Implementierungen ([`wasm-stats`](https://github.com/HTTPArchive/wasm-stats)) und fügt neue Sprachen hinzu: Scala, Dotnet/Mono, Go & TinyGo, TeaVM-basierte Sprachen sowie Kotlin. Dies reduziert den Anteil „Unbekannter“ Sprachen und verfeinert die Sprachstatistiken.
 6. Es erstellt vollständige Statistiken zur Wasm-Sprachnutzung mitsamt Validierungs- und Downloadfehlern.
 7. Die Plug-and-Play-Architektur des Tools ermöglicht es, zukünftige Erweiterungen mit dem WebAssembly Toolkit / SDK im bestehenden JSON-Statistikformat zu integrieren.

## WebAssembly-Nutzung

In diesem Abschnitt präsentieren wir unsere Ergebnisse zur Nutzung von WebAssembly im Web.

### Jahrestrend

{{ figure_markup(
 image="usage-trends.png",
 caption="Trend der WebAssembly-Nutzung",
 description="Ein Balkendiagramm, das die WebAssembly-Nutzung nach mehreren Jahren rasanten Wachstums zeigt. Zwischen 2024 und 2025 sank der Prozentsatz der Desktop-Websites, die WebAssembly nutzen, leicht von 0,36 % auf 0,35 %, während die mobile Nutzung unverändert bei 0,28 % blieb.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=729417371&format=interactive",
 sql_file="counts.sql",
 sheets_gid="540023407"
 )
}}

Wir stellen fest, dass die Akzeptanz von WebAssembly seit 2021 (0,04 %) stark gestiegen ist, obwohl die Raten in den letzten zwei Jahren stabil geblieben sind. Im Jahr 2025 fanden wir WebAssembly-Module auf 0,35 % der Desktop-Websites und auf 0,28 % der mobilen Websites, was etwa 43.000 Seiten entspricht. Darüber hinaus war die mobile Nutzung in allen beobachteten Jahren niedriger als die Desktop-Nutzung, mit einem durchschnittlichen Unterschied von 30 %.

### WebAssembly nach Website-Rang

{{ figure_markup(
 image="webassembly-by-rank.png",
 caption="WebAssembly-Nutzung nach Website-Rang",
 description="Ein Balkendiagramm, das die Verteilung der Seiten-Rankings in Gruppen von 1.000, 10.000, 100.000, 1.000.000, 10.000.000 und allen Client-Anfragen für Desktop und Mobile zeigt.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1476075550&format=interactive",
 sql_file="ranking.sql",
 sheets_gid="1733811663"
 )
}}

Wir sehen eine starke Korrelation zwischen der Popularität einer Website und der Nutzung von WebAssembly. Die Nutzung konzentriert sich am stärksten auf die Top 1.000 Websites und erreicht 2 % auf Desktop- und 1,27 % auf mobilen Geräten. Diese hochrangigen Websites hosten häufig komplexe Anwendungen — wie Design-Tools oder anspruchsvolle Medieneditoren —, die die hohe Performance erfordern, die Wasm bietet.

Die Nutzungsraten sinken mit abnehmendem Website-Rang und folgen einem gleichmäßigen Verteilungsmuster. Bei Websites außerhalb der Top 10 Millionen liegt die Nutzung bei etwa 0,33 % für Desktop und 0,28 % für Mobile.

Während die Desktop-Nutzung in den oberen Ranking-Gruppen höher bleibt, schrumpft die Lücke im Long-Tail-Bereich erheblich. Dies deutet darauf hin, dass WebAssembly für die Mehrheit des Webs eher als plattformübergreifende Ressource eingesetzt wird, anstatt auf bestimmte Umgebungen beschränkt zu sein.

## WebAssembly-Anfragen

{{ figure_markup(
 image="number-of-wasm-requests.png",
 caption="Anzahl der Wasm-Anfragen",
 description="Ein Balkendiagramm, das die gesamten Wasm-Anfragen, eindeutige Wasm-Dateien und eindeutige Antworten nach Modulen für beide Clients zeigt.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=74534440&format=interactive",
 sql_file="counts.sql",
 sheets_gid="540023407"
 )
}}

Insgesamt verzeichneten wir 303.496 WebAssembly-Anfragen auf Desktop-Geräten und 308.971 auf mobilen Endgeräten. Obwohl mehr Desktop-Websites WebAssembly nutzen, ist das Gesamtvolumen der Anfragen auf mobilen Geräten etwas höher.

Darüber hinaus haben wir 157.967 eindeutige URLs auf Desktop und 165.870 auf Mobile identifiziert. Um die Anzahl der eindeutigen Binärdateien zu schätzen, haben wir Module mit identischem Dateinamen und identischer Antwortgröße gruppiert. Mit dieser Methode fanden wir 87.596 eindeutige Wasm-Module auf Desktop und 84.851 auf Mobile. Diese Ergebnisse zeigen, dass bezogen auf den Namen etwa 72 % der WebAssembly-Anfragen identische Module ausliefern, was eine erhebliche Wiederverwendung von Bibliotheken im gesamten Web unterstreicht.

### MIME-Type

{{ figure_markup(
 image="top-mime-types.png",
 caption="Top MIME-Typen",
 description="Ein Balkendiagramm, das die MIME-Typen und den Prozentsatz der Wasm-Anfragen für beide Clients zeigt.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1325615855&format=interactive",
 sql_file="mime_types.sql",
 sheets_gid="1706394885",
 width="600",
 height="430"
 )
}}

Der MIME-Type `application/wasm` wurde bei 293.470 Desktop- und 301.127 Mobil-Anfragen identifiziert. Fälle von fehlenden oder falschen MIME-Typen (wie `text/html` oder `text/plain`) waren selten und betrafen lediglich 3,2 % der Desktop- und 2,4 % der Mobil-Anfragen. Dies bedeutet einen deutlichen Rückgang im Vergleich zu 2021 und deutet auf ein besseres Bewusstsein sowie eine korrekte Serverkonfiguration hin.

### Modulgröße

Die Größen von WebAssembly-Modulen variieren je nach Verwendungszweck drastisch. Wir haben beobachtet, dass die unteren 50 % der Module mit einer Größe zwischen 2 KB und 14 KB recht klein sind. Dabei handelt es sich meist um „Mikro-Utilities“ wie Base64-Encoder oder Prüfsummenrechner, die oft in AssemblyScript oder Rust geschrieben sind, um leistungsrelevante Aufgaben zu übernehmen, bei denen es JavaScript an Präzision mangelt.

Im Gegensatz dazu steigen die Größen im 90. Perzentil deutlich an – auf 381 KB bei Desktop und 316 KB bei Mobile. Diese größeren Binärdateien stehen in der Regel für vollständige Desktop-Anwendungen, die für das Web portiert wurden — wie Adobe Photoshop oder Google Earth. Sie wurden aus anspruchsvolleren Sprachen wie C++ oder C# kompiliert, um komplexe 3D-Renderings und Logiken zu verarbeiten.

{{ figure_markup(
 image="raw-response-sizes.png",
 caption="Rohdaten-Antwortgrößen.",
 description="Ein Balkendiagramm, das die Verteilung der Rohdaten-Antwortgrößen von WebAssembly (Wasm) auf Desktop- und mobilen Plattformen zeigt, gemessen in Kilobyte über verschiedene Perzentile hinweg. In den unteren und mittleren Perzentilen sind die Dateigrößen identisch und extrem klein: Sie beginnen bei nur 2 KB im 10. Perzentil und erreichen 14 KB im 50. Perzentil auf beiden Plattformen. Eine deutliche Abweichung zeigt sich jedoch im 90. Perzentil, wo die Desktop-Größen 381 KB erreichen, verglichen mit 316 KB auf mobilen Geräten.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=658325543&format=interactive",
 sql_file="module_sizes.sql",
 sheets_gid="241152503"
 )
}}

Das obige Diagramm zeigt die Größe des Antwort-Bodys, oft als „Rohdaten-Antwortgröße“ (raw response size) bezeichnet. Diese misst nur die unkomprimierten, oft decodierten Datenpakete, die der Client empfangen hat. Sie repräsentiert die Größe der Ressource an sich. Gemäß der Forschung und gängigen Praxis für Wasm-Auslieferungen werden Wasm-Module jedoch mit verschiedenen Tools wie [Brotli](https://github.com/google/brotli) komprimiert und optimiert sowie mittels Kompressionsverfahren wie gzip, br oder zstd zusammen mit Content-Encoding-Headern über das Netzwerk an den Client übertragen.

{{ figure_markup(
 image="compression-methods-desktop-client.png",
 caption="Kompressionsmethoden für Desktop-Clients",
 description="Ein Kreisdiagramm zeigt die Kompressionsmethoden br, gzip und zstd sowie einige Einträge für aws_chunked. Es verdeutlicht, dass Wasm-Dateien für Desktop-Clients größtenteils mit der 'br'-Methode (Brotli) übertragen werden (78,1 %), gefolgt von gzip (17,9 %) und zstd (3,9 %).",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1275607668&format=interactive",
 sql_file="compression_methods.sql",
 sheets_gid="241152503"
 )
}}

{{ figure_markup(
 image="compression-methods-mobile-client.png",
 caption="Kompressionsmethoden für mobile Clients",
 description="Ein Kreisdiagramm zeigt die Kompressionsmethoden br, gzip und zstd sowie einige Einträge für aws_chunked. Es verdeutlicht, dass Wasm-Dateien für mobile Clients größtenteils mit der 'br'-Methode (Brotli) übertragen werden (80,1 %), gefolgt von gzip (17,9 %) und zstd (3,9 %).",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1994486126&format=interactive",
 sql_file="compression_methods.sql",
 sheets_gid="241152503"
 )
}}

Interessanterweise zeigen die [Performance-Benchmarks](https://facebook.github.io/zstd/#benchmarks) verschiedener Communities aus den letzten Jahren, dass das Bewusstsein und die Nutzung der Kompressionsmethoden 'br' und 'zstd' stetig zunehmen. Dies belegt eine kontinuierliche Weiterentwicklung und Akzeptanz durch Entwickler und CDN-Anbieter.

{{ figure_markup(
 caption="Größte gefundene WebAssembly-Datei (Desktop).",
 content="234 MB",
 classes="big-number",
 sheets_gid="241152503",
 sql_file="module_sizes.sql"
 )
}}

{{ figure_markup(
 caption="Größte gefundene WebAssembly-Datei (Mobile).",
 content="170 MB",
 classes="big-number",
 sheets_gid="241152503",
 sql_file="module_sizes.sql"
 )
}}

Abseits dieser Standardverteilungen enthält der Datensatz signifikante Ausreißer. Das größte einzelne identifizierte WebAssembly-Modul war auf dem Desktop 234 MB und auf Mobilgeräten 170 MB groß, was auf den Einsatz weitreichender, clientseitiger Anwendungen hindeutet.

Es ist spannend zu sehen, dass JavaScript-Dateien oft mehrere Megabyte groß sind, während Wasm-Dateien meist deutlich kleiner ausfallen. Das liegt daran, dass JS menschenlesbarer, höherer Quellcode ist, während Bytecode eine maschinenunabhängige, maschinennahe Zwischenkopie des Codes darstellt.

Wir wissen, dass moderne JS-Engines wie Googles V8 den JS-Quellcode intern im Zuge der Ausführung in Bytecode umwandeln; dies unterstreicht die Effizienz von Bytecode im Vergleich zu JavaScript in Bezug auf eine geringe Dateigröße.

## WebAssembly-Bibliotheken

Als Nächstes analysieren wir die Import-Namen innerhalb der WebAssembly-Binärdateien, um die beliebtesten zugrundeliegenden Bibliotheken und Frameworks im Ökosystem zu verstehen.

{{ figure_markup(
 image="popular-webAssembly-libraries.png",
 caption="Beliebte WebAssembly-Bibliotheken.",
 description="Ein Balkendiagramm, das die beliebtesten Bibliotheken in Desktop- und Mobil-Datensätzen in einer Grafik zusammenfasst. Jede Bibliothek wird zusammen mit dem Prozentsatz der Wasm-Anfragen dargestellt, die ihr zugeordnet werden konnten.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1063093178&format=interactive",
 sql_file="popular_library_by_name.sql",
 sheets_gid="1181339291",
 width="600",
 height="596"
 )
}}

Wir stellen fest, dass System (43 %), <a hreflang="en" href="https://learn.microsoft.com/en-us/aspnet/core/blazor/webassembly-build-tools-and-aot?view=aspnetcore-10.0">Microsoft</a> (23 %), RXEngine (6 %) und <a hreflang="en" href="https://devblogs.microsoft.com/dotnet/extending-web-assembly-to-the-cloud/">Dotnet</a> (6 %) die beliebtesten Bibliotheken oder Frameworks in WebAssembly-Modulen sind. Dies deutet auf eine Dominanz von Microsoft in diesem Ökosystem hin, die vor allem durch die Frameworks Dotnet und <a hreflang="en" href="https://learn.microsoft.com/en-us/aspnet/core/blazor/hosting-models?view=aspnetcore-10.0#blazor-webassembly">Blazor</a> vorangetrieben wird.

Microsoft verfügt über diverse WebAssembly-Bibliotheken und Frameworks für System-Utilities, Identität, Netzwerk, Speicher, JSON und viele weitere wiederverwendbare Komponenten. Kombiniert man diese Bibliotheken und Frameworks, deckt das Microsoft-Ökosystem für WebAssembly 78,8 % bei Desktop- bzw. 79,3 % bei mobilen Clients ab.

## WebAssembly-Sprachen

WebAssembly kann in einer Vielzahl von Sprachen entwickelt werden, darunter C++, C# und Ruby. Mit der Einführung von Wasm 3.0 hat sich das Spektrum der unterstützten Sprachen erweitert und umfasst nun beispielsweise auch Java, Scala, Kotlin und Dart. In diesem Abschnitt geben wir einen Überblick über die Sprachen, die zur Entwicklung von WebAssembly-Modulen verwendet werden.

{{ figure_markup(
 image="language-usage.png",
 caption="Nutzung von WebAssembly-Sprachen.",
 description="Unbekannt (40,5 % auf Desktop und 45,5 % auf Mobile), .NET/Mono-basierte Sprachen (36,8 % und 35,2 %), WahrscheinlichEmscripten (8,8 % und 6,7 %), Scala (3,6 % und 3.4 %), Blazor (4,9 % und 3,5 %), Rust (1,5 % und 2,2 %), AssemblyScript (2,4 % und 2,3 %), Emscripten (1,3 % und 1,1 %), Go/TinyGo (~0,1 % und ~0,1 %) und TeaVM-basierte Sprachen (~0,1 % und ~0,1 %)",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1492105065&format=interactive",
 sql_file="language_usage.sql",
 sheets_gid="101432539",
 width="600",
 height="422"
 )
}}

Unser Tool konnte die Quellcode-Sprachen für 64,3 % der WebAssembly-Module auf dem Desktop und für 72,8 % auf Mobilgeräten erfolgreich identifizieren. Der Rest (35,7 % und 27,2 %) konnte nicht zugeordnet werden, was primär an Minifizierung (dem Entfernen von Metadaten), WebAssembly-Validierungsfehlern oder Downloadfehlschlägen lag.

Unter den identifizierten Sprachen ist .NET/Mono + Blazor am weitesten verbreitet und hält einen Anteil von 41,7 % auf dem Desktop und 38,7 % auf Mobilgeräten. Obwohl minifizierte Export-/Importnamen die Quellcode-Sprache oft verschleiern, nutzt die Emscripten-Toolchain (C++) eine sehr markante Namenskonvention. Dies erlaubt es uns, diese Module sicher zuzuordnen: Emscripten macht demnach 10,1 % der Nutzung auf dem Desktop und 7,8 % auf Mobilgeräten aus, gefolgt von Scala mit 3,6 % (Desktop) und 3,4 % (Mobile).

Zusammen mit unseren Erkenntnissen zur Bibliotheksnutzung unterstreichen diese Ergebnisse die erhebliche Dominanz des Microsoft-Ökosystems innerhalb der WebAssembly-Landschaft.

## WebAssembly-Funktionen

In diesem Abschnitt analysieren wir die Nutzung von Post-MVP-Erweiterungen (Minimum Viable Product) in WebAssembly. Obwohl wir uns bewusst sind, dass die hier besprochenen Funktionen limitiert sind und nicht alle Erweiterungen abdecken, die WebAssembly <a hreflang="en" href="https://webassembly.org/features/">unterstützt</a>, halten wir es für wichtig, die Akzeptanz dieser Funktionen zu beleuchten. Wir ermutigen die Leser, an dem in diesem Kapitel verwendeten Analysewerkzeug mitzuwirken, um zukünftig weitere Funktionen tracken zu können.

{{ figure_markup(
 image="extensions-usage.png",
 caption="Nutzung von Post-MVP-Erweiterungen.",
 description="Ein Balkendiagramm, das die Gesamtzahl der Module sowie die Anzahl der Module zeigt, die verschiedene Post-MVP-Erweiterungen nutzen. Die Gesamtzahlen liegen, wie eingangs erwähnt, bei 233.857 (Desktop) bzw. 255.060 (Mobile). Sign-Extension-Operatoren stechen hervor und wurden in einer großen Anzahl gefunden — 45.969 bei Desktop-Clients und 50.394 bei mobilen Clients. Bulk Memory kommt auf 187.674 bei Desktop und 204.103 bei Mobile. Die restlichen Werte sind so gering, dass sie im Diagramm kaum auffallen.",
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSXX1UpspK3gNeMVyApXrSYk42_Wmeh9RVpGarOFbs9EVbuU8wDyQh72Mu9PckmNat2wRqfP4kVAOki/pubchart?oid=1868040845&format=interactive",
 sql_file="proposals.sql",
 sheets_gid="111956915"
 )
}}

Wir stellen fest, dass *Bulk Memory* die am weitesten verbreitete Funktion ist, die in 187.674 Desktop- und 204.103 Mobil-Modulen zum Einsatz kommt. Diese Funktion verbessert die Performance, indem sie das effiziente Kopieren und Initialisieren großer Speicherblöcke ermöglicht, was der Effizienz der nativen `memcpy`-Funktion in C ähnelt. Darüber hinaus ist *Sign Extension* — welche Operatoren zur Erweiterung von Integer-Werten bereitstellt (wie das Erweitern eines 8-Bit-Integers auf 32-Bit) — die zweitbeliebteste Funktion, zu finden in 45.969 Desktop- und 50.394 Mobil-Modulen.

## Fazit

Die Nutzung von WebAssembly ist in den letzten vier Jahren erheblich gestiegen – von 0,04 % im Jahr 2021 auf 0,35 % im Jahr 2025, wenngleich sich das Wachstum in den letzten zwei Jahren stabilisiert hat. Der Einsatz ist auf hochrangigen Websites am stärksten ausgeprägt und nimmt bei weniger populären Seiten deutlich ab. Wir stellen fest, dass WebAssembly derzeit für zwei unterschiedliche Zwecke eingesetzt wird: zur Handhabung spezifischer Hilfsfunktionen (wie Verschlüsselung oder Prüfsummen) und zum Betreiben vollständiger, eigenständiger Anwendungen. Zudem verdeutlichen unsere Ergebnisse die weite Verbreitung von Microsoft-Frameworks, was deren bedeutende Rolle beim Vorantreiben des aktuellen WebAssembly-Ökosystems unterstreicht.

In Anbetracht der signifikanten Entwicklungen bei den Wasm-Spezifikationen und des wachsenden Interesses der Community sind wir zuversichtlich, dass die Akzeptanz von WebAssembly in Zukunft weiter zunehmen wird.
