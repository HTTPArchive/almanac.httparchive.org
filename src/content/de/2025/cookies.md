---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Cookies
description: Kapitel über Cookies im Web Almanac 2025, das die Verbreitung und Struktur von Cookies im Web behandelt.
hero_alt: Heldenbild von Web-Almanac-Charakteren, die einen großen Cookie tragen, während Krümel von einer anderen Figur herumgeworfen werden. Eine weitere Web-Almanac-Figur folgt der Cookie-Spur mit Detektivhut und Lupe.
authors: [yohhaan]
reviewers: [JannisBush, martinakraus]
analysts: [ChrisBeeti]
editors: [bsmth, tunetheweb]
translators: [mika943]
results: https://docs.google.com/spreadsheets/d/1ZirsnaXgbOMzBmt0X2eMMu3rVJvWCtQgE7pNG7fKcvc/edit
yohhaan_bio: Yohan Beugin ist Doktorand am Department of Computer Sciences der University of Wisconsin–Madison, wo er Mitglied der Security and Privacy Research Group ist und von Prof. Patrick McDaniel betreut wird. Er interessiert sich für den Aufbau sichererer, datenschutzfreundlicherer und vertrauenswürdigerer Systeme. Sein aktueller Forschungsschwerpunkt liegt bisher auf Tracking und Datenschutz in der Online-Werbung sowie der Sicherheit von Open-Source-Software.
featured_quote: Insgesamt bleiben Cookies eine grundlegende Komponente des Webs, die weiterhin Datenschutz- und Sicherheitsrisiken für Nutzer darstellt. Sowohl First- als auch Third-Party-Cookies werden zum Tracking verwendet, und während mehrere Webbrowser (Brave, Safari, Firefox usw.) Third-Party-Cookies eingestellt oder eingeschränkt haben, hat Google 2025 entschieden, diese in Chrome weiterhin zu unterstützen und die meisten seiner Privacy-Sandbox-Vorschläge einzustellen.
featured_stat_1: 60%
featured_stat_label_1: Cookies, die Third-Party sind
featured_stat_2: 11%
featured_stat_label_2: First-Party-Desktop-Cookies mit `SameSite=None`
featured_stat_3: 10%
featured_stat_label_3: Third-Party-Cookies, die partitioniert sind (CHIPS)
doi: 10.5281/zenodo.18246755
---

## Einleitung

[Cookies](https://developer.mozilla.org/docs/Web/HTTP/Cookies) ermöglichen Websites, Daten zu speichern und Statusinformationen über HTTP-Anfragen hinweg aufrechtzuerhalten – ein an sich zustandsloses Protokoll. Webanwendungen nutzen Cookies für verschiedene Zwecke, wie Authentifizierung, Betrugsprävention und Sicherheit oder das Merken von Einstellungen und Nutzerauswahlen. Allerdings spielen Cookies seit ihrer Einführung Mitte der 1990er-Jahre auch eine dominante Rolle beim Online-Tracking von Webnutzern.

Im Laufe der Jahre haben Browser-Hersteller wie Brave, Firefox und Safari [Einschränkungen eingeführt, Cookies partitioniert und Third-Party-Cookies entfernt](https://developer.mozilla.org/docs/Web/Privacy/Guides/Third-party_cookies#how_do_browsers_handle_third-party_cookies). Während Chrome zunächst denselben Weg einzuschlagen schien, indem es <a hreflang="en" href="https://blog.chromium.org/2020/01/building-more-private-web-path-towards.html">Pläne zur Blockierung aller Third-Party-Cookies ankündigte</a>, entschied sich Google nach mehreren Verzögerungen und Verschiebungen schließlich, <a hreflang="en" href="https://privacysandbox.com/news/update-on-plans-for-privacy-sandbox-technologies/">Third-Party-Cookies weiterhin uneingeschränkt zuzulassen und es den Nutzern selbst zu überlassen, diese in Chrome zu deaktivieren</a>.

In diesem Kapitel messen und berichten wir über die Verbreitung und Struktur von Web-Cookies, die beim HTTP-Archive-Crawl im Juli 2025 auf besuchten Webseiten festgestellt wurden. Die meisten dieser Ergebnisse, sofern nicht anders angegeben, betreffen die Top-1-Million (Top Million) der beliebtesten Websites gemäß ihrem Rang im Chrome User Experience Report (CrUX), wie er im HTTP-Archive-Datensatz zum Zeitpunkt des Crawls erfasst wurde. Ergebnisse werden sowohl für Desktop- als auch für Mobilgeräte gezeigt, obwohl wir in der Praxis für dieses Kapitel selten einen signifikanten Unterschied zwischen den beiden Gerätetypen beobachten.

## Hintergrund

Zunächst wollen wir ein gemeinsames Verständnis einiger in diesem Kapitel verwendeter Begriffe schaffen.

### HTTP-Cookie

Wenn ein Nutzer eine Website besucht, interagiert er mit einem Webserver, der den Webbrowser des Nutzers anweisen kann, ein [HTTP-Cookie](https://developer.mozilla.org/docs/Web/HTTP/Cookies) zu setzen und zu speichern. Dieses Cookie entspricht Daten, die als Textstring auf dem Gerät des Nutzers gespeichert werden, und wird mit nachfolgenden HTTP-Anfragen an den Webserver gesendet. Cookies werden verwendet, um zustandsbehaftete Informationen über Nutzer über mehrere HTTP-Anfragen hinweg zu speichern – was Authentifizierung, Sitzungsverwaltung und Tracking ermöglicht. Cookies sind außerdem mit Datenschutz- und Sicherheitsrisiken verbunden.

### First- und Third-Party-Cookies

Cookies werden von einem Webserver gesetzt und können von zwei Arten sein: _First-Party_- und _Third-Party_-Cookies. First-Party-Cookies werden von derselben Domain gesetzt wie die Website, die der Nutzer besucht, während Third-Party-Cookies von einer anderen Domain gesetzt werden.

Third-Party-Cookies können von einem Drittanbieter stammen oder von einer anderen Website oder einem anderen Dienst, der zur selben „First Party" wie die übergeordnete Website gehört. _Third-Party-Cookies_ sind eigentlich _Cross-Site-Cookies_.

Stellen wir uns zum Beispiel vor, dass der Inhaber der Domain `example.com` auch `example.net` besitzt und dass folgende Cookies für einen Nutzer gesetzt werden, der `https://www.example.com` besucht:

<figure>
  <table>
    <thead>
      <tr>
        <th>Cookie-Name</th>
        <th>Gesetzt von</th>
        <th>Cookie-Typ</th>
        <th>Grund</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`cookie_a`</td>
        <td>`www.example.com`</td>
        <td>First-Party</td>
        <td>Gleiche Domain wie die besuchte Website</td>
      </tr>
      <tr>
        <td>`cookie_b`</td>
        <td>`cart.example.com`</td>
        <td>First-Party</td>
        <td>Gleiche Domain wie die besuchte Website: Subdomains spielen keine Rolle</td>
      </tr>
      <tr>
        <td>`cookie_c`</td>
        <td>`www.example.edu`</td>
        <td>Third-Party</td>
        <td>Andere Domain als die besuchte Website</td>
      </tr>
      <tr>
        <td>`cookie_d`</td>
        <td>`tracking.example.org`</td>
        <td>Third-Party</td>
        <td>Andere Domain als die besuchte Website</td>
      </tr>
      <tr>
        <td>`cookie_e`</td>
        <td>`login.example.net`</td>
        <td>Third-Party</td>
        <td>Andere Domain als die besuchte Website, auch wenn sie in diesem Beispiel demselben Inhaber gehört (Cross-Site-Cookie derselben „First Party" wie die übergeordnete Website)</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Cookie-Kontext.") }}</figcaption>
</figure>

### Datenschutz- & Sicherheitsrisiken

Cookies sind zwar grundlegend für das Funktionieren des Webs, bergen jedoch Datenschutz- und Sicherheitsrisiken:

- **Web-Tracking.** Cookies werden von Drittanbietern verwendet, um Nutzer über Websites hinweg zu verfolgen und ihr Surfverhalten sowie ihre Interessen zu erfassen. Bei zielgerichteter Werbung werden diese Daten genutzt, um Nutzern Werbung anzuzeigen, die ihren Interessen entspricht.

  Dieses Tracking findet üblicherweise folgendermaßen statt: In eine Website eingebetteter Drittanbieter-Code kann ein Cookie setzen, das einen Nutzer identifiziert. Derselbe Drittanbieter kann dann die Nutzeraktivität erfassen, indem er dieses Cookie zurückerhält, wenn der Nutzer andere Websites besucht, auf denen er ebenfalls eingebettet ist (siehe auch das Kapitel [Privacy](./privacy)).

  Wir weisen darauf hin, dass auch First-Party-Cookies für Online-Tracking verwendet werden können: Methoden wie Cookie-Syncing ermöglichen es, die Einschränkung von Third-Party-Cookies zu umgehen und Nutzer <a hreflang="en" href="https://dl.acm.org/doi/abs/10.1145/3442381.3449837">über verschiedene Websites hinweg</a> zu verfolgen.

- **Cookie-Diebstahl und Session Hijacking.** Cookies werden verwendet, um Sitzungsinformationen wie Anmeldedaten (zum Beispiel ein Sitzungstoken) für Authentifizierungszwecke über mehrere HTTP-Anfragen hinweg zu speichern. Sollten diese Cookies jedoch von einem böswilligen Akteur erlangt werden, könnte dieser sie nutzen, um sich bei den entsprechenden Webservern zu authentifizieren.

  Wenn Cookies von Webservern nicht ordnungsgemäß gesetzt werden, können sie anfällig für Cross-Site-Schwachstellen sein, wie [Session Hijacking](https://developer.mozilla.org/docs/Glossary/Session_Hijacking), [Cross-Site Request Forgery (CSRF)](https://developer.mozilla.org/docs/Web/Security/Practical_implementation_guides/CSRF_prevention), [Cross-Site Script Inclusion (XSS)](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting) und andere (siehe auch das Kapitel [Security](./security)).

## Verbreitung von First- und Third-Party-Cookies

{{ figure_markup(
  image="first-and-third-party-prevalence.png",
  caption="Verbreitung von First- und Third-Party-Cookies.",
  description="Balkendiagramm, das die Verbreitung von First- und Third-Party-Cookies auf Desktop- und Mobilgeräten zeigt. Desktop: 41 % First-Party und 59 % Third-Party Cookies. Mobil: 40 % First-Party und 60 % Third-Party.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=133146154&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

Die allgemeine Verbreitung von First- und Third-Party-Cookies auf den Top-1-Million der beliebtesten Websites aus dem HTTP-Archive-Crawl vom Juli 2025 entspricht weitgehend der [Verteilung des Vorjahres](../2024/cookies#first-and-third-party-prevalence).

Sowohl auf Desktop- als auch auf Mobilgeräten sind etwa 40 % der Cookies First-Party und etwa 60 % Third-Party.

### Verbreitung von First- und Third-Party-Cookies nach Rang

{{ figure_markup(
  image="first-and-third-party-prevalence-by-rank-desktop.png",
  caption="Verbreitung von First- und Third-Party-Cookies nach Rang auf Desktop-Geräten.",
  description="Balkendiagramm, das die Verbreitung von First- und Third-Party-Cookies auf Desktop-Geräten in Abhängigkeit von der Beliebtheit der Website zeigt. Wir sehen, dass beliebtere Websites deutlich mehr Third-Party-Cookies setzen. Bei den Top-1.000 beliebtesten Websites auf Desktop-Geräten sind 78 % der gesetzten Cookies Third-Party, während es bei den Top-1M-Websites 59 % sind.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1437171045&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

{{ figure_markup(
  image="first-and-third-party-prevalence.png-by-rank-mobile.png",
  caption="Verbreitung von First- und Third-Party-Cookies nach Rang auf Mobilgeräten.",
  description="Balkendiagramm, das die Verbreitung von First- und Third-Party-Cookies auf Mobilgeräten in Abhängigkeit von der Beliebtheit der Website zeigt. Wir sehen, dass beliebtere Websites deutlich mehr Third-Party-Cookies setzen. Bei den Top-1.000 beliebtesten Websites auf Desktop-Geräten sind 78 % der gesetzten Cookies Third-Party, während es bei den Top-1M-Websites 60 % sind.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=76250674&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

Wir beobachten, dass die beliebtesten Websites anteilig mehr Third-Party- als First-Party-Cookies setzen: 78 % der Cookies sind Third-Party bei den Top-1.000-meistbesuchten Websites, während es bei den Top-10-Millionen knapp unter 50 % sind. Dies lässt sich vermutlich dadurch erklären, dass beliebtere Websites auch mehr Drittanbieter-Inhalte und -Skripte enthalten, die wiederum Third-Party-Cookies setzen, um verschiedene Funktionen zu ermöglichen.

## Cookie-Attribute

{{ figure_markup(
  image="cookies-attributes-overview-desktop.png",
  caption="Überblick über Cookie-Attribute für Desktop-Geräte.",
  description="Diese Abbildung gibt einen Überblick darüber, wie Cookie-Attribute auf Desktop-Geräten sowohl für First- als auch Third-Party-Cookies verwendet werden. Nur 1 % der First-Party- und 10 % der Third-Party-Cookies verwenden `Partitioned`. 19 % der First-Party-Cookies setzen ihr `Session`-Attribut, während dies nur bei 7 % der Third-Party-Cookies der Fall ist. Schließlich verwenden 12 % der First-Party- und 28 % der Third-Party-Cookies das `HttpOnly`-Attribut.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1053912620&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookies-attributes-overview-mobile.png",
  caption="Überblick über Cookie-Attribute für Mobilgeräte.",
  description="Diese Abbildung gibt einen Überblick darüber, wie Cookie-Attribute auf Mobilgeräten sowohl für First- als auch Third-Party-Cookies verwendet werden. Wir beobachten genau dieselben Ergebnisse wie bei Desktop-Geräten. Nur 1 % der First-Party- und 9 % der Third-Party-Cookies verwenden `Partitioned`. 19 % der First-Party-Cookies setzen ihr `Session`-Attribut, während dies nur bei 5 % der Third-Party-Cookies der Fall ist. Schließlich verwenden 12 % der First-Party- und 26 % der Third-Party-Cookies das `HttpOnly`-Attribut.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=435743769&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

Die Daten zeigen die unterschiedlichen [Cookie-Attribute](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie) für jeden beobachteten Cookie-Typ. Schauen wir uns jedes davon genauer an.

### `Partitioned` (CHIPS-Vorschlag)

Auf [kompatiblen Browsern](https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies#browser_compatibility) verhindern partitionierte Cookies, dass Third-Party-Cookies für Cross-Site-Tracking verwendet werden, indem sie in einem nach übergeordneter Website partitionierten Speicher abgelegt werden.

{{ figure_markup(
  caption="Prozentsatz der `Partition`-Cookies auf mobilen Seiten.",
  content="8.6%",
  classes="big-number",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
)
}}

Im Juli 2025 sind fast 9 % der Third-Party-Cookies bei den Top-Million partitioniert. Wir beobachten hier einen leichten Anstieg bei der Verbreitung dieses relativ neuen Attributs im Vergleich zu den [6 % im Vorjahr](../2024/cookies#partitioned).

{{ figure_markup(
  image="top-third-party-CHIPS.png",
  caption="Top partitionierte Cookies (CHIPS) im Third-Party-Kontext.",
  description="Ein Diagramm, das die Top-Drittanbieter-Domains zeigt, die partitionierte Cookies setzen. Das am häufigsten partitionierte Cookie im Third-Party-Kontext ist `cf_clearance`, gesetzt von Cloudflare, das für Anti-Bot-Challenges verwendet wird.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1834436287&format=interactive",
  sheets_gid="581303793",
  sql_file ="CHIPS_top_20_third_party_cookies.sql"
  )
}}

Das vorherige Diagramm zeigt die 10 häufigsten partitionierten Cookies (Name und Domain), die im Third-Party-Kontext auf Webseiten im Juli 2025 gefunden wurden. Hier beobachten wir eine deutliche Veränderung gegenüber der Analyse des Vorjahres: Tatsächlich scheint die Gesamtnutzung von Third-Party-partitionierten Cookies im Jahr 2025 auf ein sehr niedriges Niveau gefallen zu sein.

Interessanterweise sind die Cookies, die 2024 noch recht verbreitet waren (auf etwa 9 % der Websites mit partitionierten Cookies), nicht mehr vorhanden; zwei dieser Cookies wurden von YouTube gesetzt, und ein weiteres war das Cookie `receive-cookie-deprecation`, das von Domains gesetzt wurde, die an der [Testphase](https://developers.google.com/privacy-sandbox/private-advertising/setup/web/chrome-facilitated-testing) der Privacy Sandbox von Chrome teilnahmen. Stattdessen macht Cloudflares Cookie `cf_clearance` die gesamten Top 10 der häufigsten partitionierten Third-Party-Cookies im Jahr 2025 aus.

Es scheint also, dass YouTube im vergangenen Jahr verändert hat, wie diese Cookies auf `youtube.com` und auf in andere Websites eingebetteten Video-iFrames gesetzt werden. Mögliche Gründe, die diese Änderungen erklären könnten, sind: fehlerhafte Konfiguration, A/B-Tests und wahrscheinlicher Infrastruktur- oder Richtlinienänderungen infolge von Googles Ankündigungen zur Pausierung und anschließenden Einstellung der Privacy-Sandbox-APIs, obwohl die Unterstützung für partitionierte Cookies (CHIPS-Vorschlag) weiterhin fortbesteht.

{{ figure_markup(
  image="top-first-party-CHIPS.png",
  caption="Top partitionierte Cookies (CHIPS) im First-Party-Kontext.",
  description="Ein Diagramm, das die Top-First-Party-partitionierten-Cookies zeigt. Das häufigste Cookie `cf_clearance` wird von Cloudflare auf etwa 92 % der Seiten mit partitionierten Cookies gesetzt und steht im Zusammenhang mit Bot-Erkennung.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1232746047&format=interactive",
  sheets_gid="581303793",
  sql_file="CHIPS_top_20_first_party_cookies.sql"
  )
}}

Im Jahr 2025 beobachten wir weiterhin, dass 1 % der First-Party-Cookies als partitioniert gesetzt werden; das mag etwas überraschend sein, da sich der CHIPS-Vorschlag hauptsächlich auf die Partitionierung von Third-Party-Cookies bezieht, und selbst wenn er einen <a hreflang="en" href="https://github.com/privacycg/CHIPS?tab=readme-ov-file#first-party-chips">speziellen, ungewöhnlichen Fall</a> für partitionierte First-Party-Cookies erwähnt, erscheint die <a hreflang="en" href="https://github.com/privacycg/CHIPS/issues/51">Verhaltensanforderung</a> im First-Party-Kontext unklar. Ein Grund könnte sein, dass manche Cookies immer auf dieselbe Weise gesetzt werden – das heißt, der Webserver, der sie setzt, unterscheidet nicht, ob es sich aktuell um First-Party oder Third-Party handelt.

Im Jahr 2025 sind mehr als 90 % dieser First-Party-partitionierten Cookies das Cookie `cf_clearance` von Cloudflare, das mit Bot-Erkennung in Zusammenhang steht. Im Vergleich zur [Analyse von 2024](/2024/cookies#fig-8) stellen wir fest, dass das First-Party-partitionierte Cookie `receive-cookie-deprecation`, gesetzt von Domains, die an Tests der Privacy-Sandbox-APIs teilnahmen, nicht mehr so verbreitet ist. Möglicherweise lässt sich diese Beobachtung durch eine Pause oder eine verringerte Verbreitung dieser APIs erklären, bedingt durch Googles entsprechende Ankündigungen im vergangenen Jahr.

### Session

19 % der First-Party- und 7 % der Third-Party-Cookies sind Session-Cookies; temporäre Cookies, die nur für eine einzelne Nutzersitzung gültig sind und ablaufen, sobald der Nutzer die entsprechende Website verlässt, auf der sie gesetzt wurden, oder seinen Webbrowser schließt – je nachdem, was zuerst eintritt.

### `HttpOnly`

[`HttpOnly`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#httponly)-Cookies bieten einen gewissen Schutz gegen [Cross-Site-Scripting (XSS)](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting), da auf sie nicht per JavaScript-Code zugegriffen werden kann (sie werden aber weiterhin bei `XMLHttpRequest`- oder `fetch`-Anfragen mitgesendet, die von JavaScript initiiert werden).

12 % bzw. etwas mehr als 26 % der First- und Third-Party-Cookies haben dieses Attribut gesetzt.

### `Secure`

[`Secure`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#secure)-Cookies werden nur bei über HTTPS gestellten Anfragen gesendet – derselbe Trend wie [letztes Jahr](../2024/cookies#secure); während nur 24 % der First-Party-Cookies dieses Attribut setzen, müssen es alle Third-Party-Cookies setzen, wenn sie `SameSite=None` verwenden wollen (was sie alle tun, siehe unten).

### `SameSite`

Das Attribut [`SameSite`](https://developer.mozilla.org/docs/Web/HTTP/Cookies#controlling_third-party_cookies_with_samesite) ermöglicht es Websites festzulegen, wann Cookies bei Cross-Site-Anfragen mitgesendet werden:

- `SameSite=Strict`: Ein Cookie wird nur als Antwort auf eine Anfrage von derselben Website wie der Ursprung des Cookies gesendet.
- `SameSite=Lax`: Wie `SameSite=Strict`, außer dass der Browser das Cookie auch bei Navigation zur Ursprungswebsite des Cookies sendet. In Chrome ist dies der Standardwert von `SameSite`, falls kein Wert gesetzt ist.
- `SameSite=None`: Cookies werden bei Same-Site- oder Cross-Site-Anfragen gesendet.
  Das bedeutet, dass Tracking-Cookies ihr `SameSite`-Attribut auf `None` setzen müssen, um Third-Party-Tracking mit Cookies überhaupt zu ermöglichen.

Um mehr über das `SameSite`-Attribut zu erfahren, siehe folgende Referenzen:

- [`SameSite`-Cookies erklärt](https://web.dev/articles/samesite-cookies-explained)
- ["Same-Site" und "Same-Origin"](https://web.dev/articles/same-site-same-origin)
- [Was sind die Bestandteile einer URL?](https://web.dev/articles/url-parts)

{{ figure_markup(
  image="same-site-desktop.png",
  caption="`SameSite`-Attribut für Cookies auf Desktop-Geräten.",
  description="Zeigt die Verbreitung des `SameSite`-Attributs und seines Wertes sowohl für First-Party- als auch Third-Party-Cookies auf Desktop-Geräten. 3 % der First-Party-Cookies setzen das `SameSite`-Attribut auf `Strict`, 19 % verwenden `SameSite=Lax` (der Standard in Chrome), 11 % setzen den Wert auf `None`, und 66 % geben keinen Wert für `SameSite` an. Fast 100 % der Third-Party-Cookies setzen das `SameSite`-Attribut auf `None`, damit diese Cookies in einem Cross-Site-Kontext gesendet werden können.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=42361140&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="same-site-mobile.png",
  caption="`SameSite`-Attribut für Cookies auf Mobilgeräten.",
  description="Zeigt die Verbreitung des `SameSite`-Attributs und seines Wertes sowohl für First-Party- als auch Third-Party-Cookies auf Mobilgeräten. Wir sehen sehr ähnliche Ergebnisse wie bei Desktop-Geräten. 3 % der First-Party-Cookies setzen das `SameSite`-Attribut auf `Strict`, 19 % verwenden `SameSite=Lax` (der Standard in Chrome), 11 % setzen den Wert auf None, und 63 % geben keinen Wert für `SameSite` an. Fast 100 % der Third-Party-Cookies setzen das `SameSite`-Attribut auf `None`, damit diese Cookies in einem Cross-Site-Kontext gesendet werden können.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=413420306&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

Die allgemeine Verteilung dieses Attributs für First- und Third-Party-Cookies über die Geräte hinweg entspricht weitgehend dem [Vorjahr](../2024/cookies#samesite): Fast 100 % der Third-Party-Cookies werden bei Cross-Site-Anfragen gesendet (`SameSite=None`), was Cross-Site-Tracking ermöglichen kann.

Eine Mehrheit der First-Party-Cookies (66 % auf Desktop, 62 % auf Mobilgeräten) setzt dieses Attribut nicht und erhält daher von Chrome das standardmäßige `Lax`-Verhalten, das 19 % der anderen First-Party-Cookies explizit wählen, während nur 3 % es auf `Strict` setzen und die verbleibenden 11 % bei Same-Site- und Cross-Site-Anfragen gesendet werden (`SameSite=None`).

## Cookie-Präfixe

{{ figure_markup(
  image="cookie-prefixes-desktop.png",
  caption="Auf Desktop-Seiten beobachtete Cookie-Präfixe.",
  description="Zeigt die beobachteten Cookie-Präfixe auf Desktop-Seiten. Sehr wenige First- und Third-Party-Cookies enthalten das Präfix `__Host-` oder `__Secure-`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=908965565&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookie-prefixes-mobile.png",
  caption="Auf mobilen Seiten beobachtete Cookie-Präfixe.",
  description="Zeigt die beobachteten Cookie-Präfixe auf mobilen Seiten. Sehr wenige First- und Third-Party-Cookies enthalten das Präfix `__Host-` oder `__Secure-`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1209286948&format=interactive",
  sheets_gid="1982273020",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

[Cookie-Präfixe](https://developer.mozilla.org/docs/Web/HTTP/Cookies#cookie_prefixes) `__Host-` und `__Secure-` können im Cookie-Namen verwendet werden, um anzuzeigen, dass sie nur von einem sicheren HTTPS-Ursprung gesetzt oder verändert werden können. Dies dient der Abwehr von [Session-Fixation](https://developer.mozilla.org/docs/Web/Security/Types_of_attacks#session_fixation)-Angriffen.

Cookies mit beiden Präfixen müssen von einem sicheren HTTPS-Ursprung gesetzt werden und das Attribut `Secure` gesetzt haben. Zusätzlich dürfen `__Host-`-Cookies kein `Domain`-Attribut enthalten und müssen ihr `Path`-Attribut auf `/` gesetzt haben, sodass `__Host-`-Cookies nur an genau den Host zurückgesendet werden, auf dem sie gesetzt wurden, und nicht an eine übergeordnete Domain.

Hier ziehen wir den gleichen Schluss wie [letztes Jahr](../2024/cookies#cookie-prefixes): Diese Präfixe haben seit ihrer Einführung vor 10 Jahren eine sehr geringe Verbreitung im Web erfahren, sodass die von ihnen bereitgestellte zusätzliche Sicherheitsebene (Defense-in-Depth) in der Praxis weiterhin ungenutzt bleibt.

## Häufigste Cookies und Domains, die sie setzen

{{ figure_markup(
  image="top-first-party-cookies-set.png",
  caption="Häufigste gesetzte First-Party-Cookies.",
  description="Das Diagramm zeigt die am weitesten verbreiteten First-Party-Cookies. Google Analytics setzt die Cookies `_ga` und `_gcl_au`, die für Website-Statistiken, Analyseberichte und zielgerichtete Werbung verwendet werden, auf etwa 60 % bzw. 25 % der Websites, sowohl für mobile als auch für Desktop-Geräte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=219782191&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_first_party_cookies.sql"
  )
}}

Das vorherige Diagramm zeigt die 10 häufigsten First-Party-Cookie-Namen, die gesetzt werden.
Google Analytics setzt die Cookies `_ga` und `_gcl_au`, die für Website-Statistiken, Analyseberichte und zielgerichtete Werbung verwendet werden, auf etwa 60 % bzw. 25 % der Websites.
Andere Cookies in diesen Top 10 stehen im Zusammenhang mit Online-Tracking, Session-Cookies zur Identifizierung von Nutzersitzungen oder Performance.

{{ figure_markup(
  image="top-third-party-cookies-set.png",
  caption="Häufigste Third-Party-Cookies und die Domains, die sie setzen.",
  description="Das Diagramm zeigt die am weitesten verbreiteten Third-Party-Cookies. DoubleClick setzt Third-Party-Werbe-Cookies auf etwas mehr als 35 % der Seiten. Microsoft setzt ebenfalls Werbe-Cookies auf 23 % der Seiten. Die Top-Domains, die Third-Party-Cookies setzen, stehen im Zusammenhang mit Tracking und Werbung.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=232078905&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_third_party_cookies.sql"
  )
}}

Dieses Diagramm zeigt entsprechend die 10 häufigsten Third-Party-Cookies, die auf den Top-Million-Websites erstellt werden.

Die Cookies `IDE` und `test_cookie` werden von `doubleclick.net` (im Besitz von Google) gesetzt und sind auf mehr als 35 % bzw. 25 % der Websites vorhanden. DoubleClick prüft, ob der Webbrowser eines Nutzers Third-Party-Cookies unterstützt, indem versucht wird, `test_cookie` zu setzen.

Als Nächstes folgt `MUID` von Microsoft, vorhanden auf mehr als 23 % der Websites, das ebenfalls für zielgerichtete Werbung und Cross-Site-Tracking verwendet wird.

Wie bereits im Abschnitt [`Partitioned`-Cookies](#partitioned-chips-vorschlag) erwähnt, beobachten wir dieses Jahr die Cookies `YSC` und `VISITOR_INFO1_LIVE` von YouTube nicht mehr unter den häufigsten Third-Party-Cookies. Dies liegt wahrscheinlich an Änderungen seitens YouTube (möglicherweise im Zusammenhang mit Googles Ankündigungen, wie [dieser](https://privacysandbox.google.com/blog/privacy-sandbox-next-steps) zu den Privacy-Sandbox-Vorschlägen) seit der Analyse von 2024. Es scheint, dass diese Cookies nicht mehr gesetzt werden, wenn die einbettende Seite nur geladen, das Video aber noch nicht abgespielt wurde. Zusätzlich dokumentiert [Googles Datenschutz & Nutzungsbedingungen](https://policies.google.com/technologies/cookies?hl=en-US), dass `VISITOR_INFO1_LIVE` durch ein Cookie namens `__Secure-YNID` ersetzt wird.

{{ figure_markup(
  image="top-cookie-domains.png",
  caption="Häufigste registrierbare Domains, die Cookies setzen.",
  description="Das Diagramm zeigt die häufigsten Domains, die Cookies im Web setzen. Googles eigene Werbeplattform DoubleClick setzt Cookies auf mehr als 33 % der Top-1M-Websites, während andere in diesen Top-10-Domains bei etwa 5 % bis 15 % liegen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=483296297&format=interactive",
  sheets_gid="503090386",
  sql_file="top_20_domains_setting_cookies.sql"
  )
}}

Wenig überraschend angesichts früherer Ergebnisse sind die 10 häufigsten Domains, die Cookies im Web setzen, alle mit Such-, Targeting- und Werbediensten verbunden.

Googles Reichweite (`doubleclick.net`, `google.com` und `youtube.com`) erreicht mindestens 33 % der Websites, und Microsofts (`bing.com`, `clarity.ms`, `linkedin.com`) mindestens 14 %.

## Anzahl der von Websites gesetzten Cookies

<figure>
  <table>
    <thead>
      <tr>
        <th>Perzentil</th>
        <th>First-Party</th>
        <th>Third-Party</th>
        <th>Alle</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>Median</td>
        <td class="numeric">7</td>
        <td class="numeric">7</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">13</td>
        <td class="numeric">16</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">22</td>
        <td class="numeric">40</td>
        <td class="numeric">44</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">45</td>
        <td class="numeric">399</td>
        <td class="numeric">395</td>
      </tr>
      <tr>
        <td>Max</td>
        <td class="numeric">178</td>
        <td class="numeric">885</td>
        <td class="numeric">915</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiken zur Anzahl der gesetzten Cookies auf den Top-1-Million-Desktop-Seiten.", sheets_gid="1535389309", sql_file="nb_cookies_quantiles.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Perzentil</th>
        <th>First-Party</th>
        <th>Third-Party</th>
        <th>Alle</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>Median</td>
        <td class="numeric">6</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">12</td>
        <td class="numeric">15</td>
        <td class="numeric">22</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">21</td>
        <td class="numeric">39</td>
        <td class="numeric">43</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">45</td>
        <td class="numeric">400</td>
        <td class="numeric">396</td>
      </tr>
      <tr>
        <td>Max</td>
        <td class="numeric">178</td>
        <td class="numeric">801</td>
        <td class="numeric">831</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiken zur Anzahl der gesetzten Cookies auf den Top-1-Million-Mobile-Seiten.", sheets_gid="1535389309", sql_file="nb_cookies_quantiles.sql") }}</figcaption>
</figure>

Websites setzen insgesamt im Median 9 Cookies, mit 7 First-Party- und 7 Third-Party-Cookies auf Desktop sowie 6 First-Party- und 4 Third-Party-Cookies auf Mobilgeräten.

Die Tabellen zeigen weitere Statistiken zur Anzahl der pro Website beobachteten Cookies, und die Abbildungen unten zeigen ihre kumulativen Verteilungsfunktionen (CDF). Zum Beispiel werden auf Desktop maximal 178 First-Party- und 885 Third-Party-Cookies pro Website gesetzt:

{{ figure_markup(
  image="number-cookies-cdf-desktop.png",
  caption="Anzahl der Cookies pro Website (CDF) für Desktop-Seiten.",
  description="Die Grafik zeigt die kumulative Verteilungsfunktion für die Anzahl der auf Desktop-Seiten gesetzten Cookies. Wir sehen, dass mehr Websites eine Anzahl von First-Party-Cookies haben, die näher am Maximum der beobachteten First-Party-Cookies liegt, als das bei Third-Party-Cookies der Fall ist.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=160162622&format=interactive",
  sheets_gid="1535389309",
  sql_file="nb_cookies_cdf.sql"
  )
}}

{{ figure_markup(
  image="number-cookies-cdf-mobile.png",
  caption="Anzahl der Cookies pro Website (CDF) für mobile Seiten.",
  description="Die Grafik zeigt die kumulative Verteilungsfunktion für die Anzahl der auf mobilen Seiten gesetzten Cookies. Wir sehen, dass mehr Websites eine Anzahl von First-Party-Cookies haben, die näher am Maximum der beobachteten First-Party-Cookies liegt, als das bei Third-Party-Cookies der Fall ist. Zusätzlich beobachten wir sehr ähnliche Ergebnisse für Desktop- und mobile Websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=569578852&format=interactive",
  sheets_gid="1448286433",
  sql_file="nb_cookies_cdf.sql"
  )
}}

## Größe der Cookies

<figure>
  <table>
    <thead>
      <tr>
        <th>Perzentil</th>
        <th>First-Party</th>
        <th>Third-Party</th>
        <th>Alle</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">29</td>
        <td class="numeric">22</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>Median</td>
        <td class="numeric">41</td>
        <td class="numeric">39</td>
        <td class="numeric">40</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">67</td>
        <td class="numeric">59</td>
        <td class="numeric">64</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">157</td>
        <td class="numeric">145</td>
        <td class="numeric">149</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">414</td>
        <td class="numeric">321</td>
        <td class="numeric">338</td>
      </tr>
      <tr>
        <td>Max</td>
        <td class="numeric">4090</td>
        <td class="numeric">4096</td>
        <td class="numeric">4096</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiken zur Größe der gesetzten Cookies auf den Top-1-Million-Desktop-Seiten.", sheets_gid="1499552173", sql_file="size_cookies_quantiles.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Perzentil</th>
        <th>First-Party</th>
        <th>Third-Party</th>
        <th>Alle</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">22</td>
        <td class="numeric">29</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>Median</td>
        <td class="numeric">39</td>
        <td class="numeric">41</td>
        <td class="numeric">40</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">62</td>
        <td class="numeric">67</td>
        <td class="numeric">65</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">145</td>
        <td class="numeric">162</td>
        <td class="numeric">150</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">326</td>
        <td class="numeric">414</td>
        <td class="numeric">388</td>
      </tr>
      <tr>
        <td>Max</td>
        <td class="numeric">4096</td>
        <td class="numeric">4081</td>
        <td class="numeric">4096</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiken zur Größe der gesetzten Cookies auf den Top-1-Million-Mobile-Seiten.", sheets_gid="1499552173", sql_file="size_cookies_quantiles.sql") }}</figcaption>
</figure>

Wir stellen fest, dass die mittlere Größe aller beobachteten Cookies 40 Byte beträgt, mit einem Maximum von 4 KB, was den in <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc6265#section-6.1">RFC 6265</a> definierten Grenzwerten entspricht.

Ähnlich wie im [Vorjahr](../2024/cookies#size-of-cookies) beobachten wir einige Cookies mit einer Größe von nur einem Byte; diese werden wahrscheinlich versehentlich durch leere `Set-Cookie`-Header gesetzt.

Wir können die kumulative Verteilungsfunktion (CDF) der Größe aller auf den Top-1M-Websites beobachteten Cookies für jedes Gerät darstellen:

{{ figure_markup(
  image="size-cookies-cdf-desktop-mobile.png",
  caption="Größe der Cookies pro Website (CDF) für Desktop- und mobile Seiten.",
  description="Die Grafik zeigt die kumulative Verteilungsfunktion für die Anzahl der auf Desktop- und mobilen Seiten gesetzten Cookies. Wir sehen eine sehr ähnliche Verteilung der Cookie-Größen sowohl für Desktop- als auch für Mobilgeräte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSzdHAn-vwJ-Z05NYWZrImgKaX0q5D-jgWay8FD9lMDj2jr3cEjozE083JOSi6cZZX37vVD2TjEKw28/pubchart?oid=1496593333&format=interactive",
  sheets_gid="1499552173",
  sql_file = 'size_cookies_cdf.sql'
  )
}}

## Persistenz (Ablaufzeit)

<figure>
  <table>
    <thead>
      <tr>
        <th>Perzentil</th>
        <th>First-Party</th>
        <th>Third-Party</th>
        <th>Alle</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Min</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">1</td>
        <td class="numeric">30</td>
        <td class="numeric">21</td>
      </tr>
      <tr>
        <td>Median</td>
        <td class="numeric">365</td>
        <td class="numeric">360</td>
        <td class="numeric">364</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">395</td>
        <td class="numeric">365</td>
        <td class="numeric">390</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>Max</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiken zum Alter der gesetzten Cookies auf den Top-1-Million-Desktop-Seiten.", sheets_gid="718820729", sql_file="age_expire_cookies_quantiles.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Perzentil</th>
        <th>First-Party</th>
        <th>Third-Party</th>
        <th>Alle</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Min</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">1</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>Median</td>
        <td class="numeric">365</td>
        <td class="numeric">270</td>
        <td class="numeric">360</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">395</td>
        <td class="numeric">365</td>
        <td class="numeric">390</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p99</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>Max</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiken zum Alter der gesetzten Cookies auf den Top-1-Million-Mobile-Seiten.", sheets_gid="718820729", sql_file="age_expire_cookies_quantiles.sql") }}</figcaption>
</figure>

Cookies erhalten bei ihrer Erstellung ein Ablaufdatum. Während Session-Cookies sofort nach Ende der Sitzung ablaufen ([siehe vorheriger Abschnitt](#session)), tun die meisten First- und Third-Party-Cookies dies nicht und haben ein mittleres Alter von einem vollen Jahr.

Je länger Cookies bestehen bleiben, desto länger können sie zur Wiederidentifizierung oder zum Cross-Site-Tracking genutzt werden, weshalb die meisten Tracking-Cookies typischerweise so eingestellt werden, dass sie für längere Zeit im Browser gespeichert bleiben.

Das maximale Alter unter den Cookies, das wir mit der Instrumentierung und Erfassung der HTTP-Archive-Tools für dieses Kapitel beobachten können, beträgt 400 Tage – aufgrund der [Obergrenzen](https://developer.chrome.com/blog/cookie-max-age-expires), die Chrome für die Attribute `Expires` und `Max-Age` von Cookies vorschreibt.

## Fazit

Die Beobachtungen aus diesem Kapitel bestätigen [die Schlussfolgerungen aus der Analyse des Vorjahres](../2024/cookies#conclusion):

- Eine Mehrheit (60 %) der im Web angetroffenen Cookies sind Third-Party-Cookies, und beliebte Websites haben deutlich mehr Third-Party-Cookies als weniger beliebte Seiten.
- Die häufigsten Cookies lassen sich mit Werbung, Tracking und Analyse-Anwendungsfällen verknüpfen.
- Cookies sind tendenziell langlebig, mit einer mittleren durchschnittlichen Lebensdauer von 12 Monaten.
  Kurzlebige Session-Cookies machen nur 19 % der First-Party- und 7 % der Third-Party-Cookies aus.
- Andere Einschränkungen der Cookie-Funktionen werden sehr wenig bis gar nicht genutzt: Während 10 % der Third-Party-Cookies partitioniert sind (ein leichter Anstieg gegenüber den 6 % im Vorjahr), haben 100 % der Third-Party-Cookies `SameSite=None` gesetzt, was es ihnen ermöglicht, bei Cross-Site-Anfragen gesendet zu werden. Zudem ist die Verbreitung von Cookie-Präfixen praktisch nicht vorhanden.

Schließlich: Während mehrere Webbrowser Third-Party-Cookies aus Datenschutzgründen [eingestellt oder eingeschränkt](https://developer.mozilla.org/docs/Web/Privacy/Guides/Third-party_cookies#how_do_browsers_handle_third-party_cookies) haben, hat Google entschieden, <a hreflang="en" href="https://privacysandbox.com/news/update-on-plans-for-privacy-sandbox-technologies/">diese in Chrome weiterhin zu unterstützen</a>. Google stellt zudem die meisten Technologien aus seiner Privacy-Sandbox-Initiative ein, die ursprünglich darauf ausgelegt war, _„ein florierendes Web-Ökosystem zu schaffen, das die Nutzer respektiert und standardmäßig privatsphärenfreundlich ist"_. Folglich bleiben Cookies – unabhängig davon, ob Tracker Third-Party-Cookies verwenden oder andere Techniken (First-Party-Syncing, Fingerprinting usw.) entwickeln, um Nutzer online zu verfolgen – eine grundlegende Komponente des Webs, die weiterhin Datenschutz- und Sicherheitsrisiken für Nutzer darstellt.
