---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Third Parties
description: Kapitel über Third Parties im Web Almanac 2025, das Daten dazu behandelt, welche Drittanbieter im Web genutzt werden, sowie eine Analyse der Einbindungsketten von Drittanbietern.
hero_alt: Heldenbild von Web-Almanac-Charakteren, die verschiedene Dinge in eine Webseite einstecken.
authors: [jazlan01, abubakaraziz]
reviewers: [tunetheweb]
analysts: [jazlan01]
editors: [tunetheweb]
translators: []
jazlan01_bio: Muhammad Jazlan ist Doktorand im zweiten Jahr der Informatik an der University of California, Davis. Sein Forschungsschwerpunkt liegt auf der Messung, Erkennung und Eindämmung von Tracking im Web.
abubakaraziz_bio: Muhammad Abu Bakar Aziz ist Doktorand der Informatik an der Northeastern University in Boston. Sein Forschungsschwerpunkt liegt auf Web-Datenschutz. Insbesondere untersucht er empirisch, wie Drittanbieter und Online-Werbetreibende Datenschutzgesetze wie CCPA und DSGVO einhalten.
results: https://docs.google.com/spreadsheets/d/1FPssodcLgX8iFWFXDrthWVkBCUTl5_IJon2cyaZVudU/edit
featured_quote: Die Top-10-Drittanbieter-Domains werden von Google dominiert.
featured_stat_1: 90%
featured_stat_label_1: Seiten mit mindestens einem Drittanbieter
featured_stat_2: 16
featured_stat_label_2: Median der Anzahl von Drittanbieter-Domains auf einer Seite
featured_stat_3: 18%
featured_stat_label_3: Prozentsatz der Websites, die TCF Standard verwenden
doi: 10.5281/zenodo.18246420
---

## Einleitung

Drittanbieter sind im Web allgegenwärtig. Website-Entwickler verlassen sich auf sie, um Schlüsselfunktionen wie Werbung, Analyse, Social-Media-Integration, Zahlungsabwicklung und Content-Delivery umzusetzen. Dieser modulare Ansatz ermöglicht eine effiziente und schnelle Bereitstellung umfangreicher Funktionalität. Allerdings bringt er auch potenzielle Datenschutz-, Sicherheits- und Performance-Bedenken mit sich. Neu in diesem Jahr analysieren wir, wie Einwilligungsentscheidungen der Nutzer unter Drittanbietern im Web weitergegeben werden, einschließlich der verwendeten Consent-Frameworks und der Drittanbieter, die diese Signale empfangen.

In diesem Kapitel führen wir eine empirische Analyse der Nutzungsmuster von Drittanbietern im Web durch. Wir untersuchen:

- **Verbreitung:** Wie viele Websites Drittanbieter nutzen und in welchem Umfang
- **Ressourcentypen:** Die Formen, die Drittanbieter annehmen (Bilder, JavaScript, Schriften usw.)
- **Funktionale Kategorien:** Werbenetzwerke, Analytics, CDNs, Videoanbieter, Tag-Manager und andere
- **Integrationsmethoden:** Wie Drittanbieter direkt oder indirekt auf Seiten geladen werden
- **Consent-Infrastruktur:** Welche Drittanbieter Consent-Signale übertragen und wie diese Übertragungen in der Praxis erfolgen

## Definitionen

Zunächst legen wir einige Definitionen und Begriffe fest, die in unserer gesamten Analyse verwendet werden.

### Sites und Seiten

In diesem Kapitel verwenden wir, wie in den Vorjahren, den Begriff Site, um den registrierbaren Teil einer bestimmten Domain zu bezeichnen, der häufig als *erweiterte Top-Level-Domain plus eins* (eTLD+1) bezeichnet wird. Für die URL `https://www.bar.com/` ist die eTLD+1 zum Beispiel `bar.com`, und für die URL `https://foo.co.uk` ist die eTLD+1 `foo.co.uk`. Mit Seite (oder Webseite) meinen wir eine eindeutige URL oder, genauer gesagt, das Dokument (zum Beispiel HTML oder JavaScript), das sich unter der jeweiligen URL befindet.

### Was ist ein Drittanbieter?

Wir halten uns an die Definition eines Drittanbieters, die in früheren Ausgaben des Web Almanacs verwendet wurde, um einen Vergleich mit früheren Versionen zu ermöglichen.

Ein _Drittanbieter_ ist eine Entität, die sich vom Website-Inhaber (auch bekannt als First Party) unterscheidet. Er betrifft die Aspekte der Website, die nicht direkt vom Website-Inhaber selbst implementiert und ausgeliefert werden. Genauer gesagt werden Drittanbieter-Inhalte von einer anderen Seite geladen als der, die der Nutzer ursprünglich besucht hat. Angenommen, der Nutzer besucht `example.com` (die First Party), und `example.com` bindet lustige Katzenbilder von `awesome-cats.edu` ein (zum Beispiel über ein `<img>`-Tag). In diesem Szenario ist `awesome-cats.edu` der Drittanbieter, da der Nutzer diese Seite nicht ursprünglich besucht hat. Besucht der Nutzer jedoch direkt `awesome-cats.edu`, ist `awesome-cats.edu` die First Party.

Für unsere Analyse wurden nur Drittanbieter berücksichtigt, deren Ressourcen auf mindestens fünf eindeutigen Seiten im HTTP-Archive-Datensatz zu finden sind.

Wenn Drittanbieter-Inhalte direkt von einer First-Party-Domain ausgeliefert werden, werden sie als First-Party-Inhalt gezählt. Zum Beispiel werden selbst gehostete Analytics-Skripte, CSS oder Schriften als First-Party-Inhalt gezählt. Ebenso wird First-Party-Inhalt, der von einer Drittanbieter-Domain ausgeliefert wird, als Drittanbieter-Inhalt gezählt. Manche Drittanbieter liefern Inhalte von verschiedenen Subdomains aus. Unabhängig von der Anzahl der Subdomains werden sie jedoch als ein einziger Drittanbieter gezählt.

Außerdem wird es zunehmend üblich, dass Drittanbieter als First Party getarnt werden. Zwei zentrale Techniken ermöglichen dies:

- **CNAME-Cloaking** beinhaltet die Verwendung eines CNAME-Eintrags, um den Inhalt eines Drittanbieters so erscheinen zu lassen, als käme er von der First-Party-Domain. In dieser Analyse betrachten wir CNAME-getarnte Dienste als First Parties.

- **Server-seitiges Tracking** ist ein aufkommender Trend, bei dem der Website-Inhaber den Tracker als First Party einbindet und alle Anfragen über die First-Party-Domain leitet, wodurch der Tracker als First Party erscheint. Zum Beispiel kann eine Website `www.example.com` server-seitiges Google Tag Manager mit Google Analytics einbinden und die Subdomain `sst.example.com` tarnen, um Anfragen an einen Google-Tag-Manager-Container zu senden. Auf diese Weise stammen Anfragen an Drittanbieter vom Server des Tag-Managers und nicht vom Browser des Nutzers.

In unserer Analyse behandeln wir solche Fälle als First-Party-Interaktionen, da die Kommunikation mit dem Drittanbieter Server-zu-Server erfolgt und in den client-seitigen HTTP-Archive-Daten nicht direkt beobachtbar ist. Daher stellen unsere Messungen eine Untergrenze der tatsächlichen Verbreitung von Drittanbietern im Web dar.

## Kategorien

Wie bereits erwähnt, können Drittanbieter für verschiedene Anwendungsfälle genutzt werden – zum Beispiel zum Einbinden von Videos, zum Ausliefern von Werbung oder zum Einbinden von Inhalten von Social-Media-Seiten. Wie im Vorjahr stützen wir uns zur Kategorisierung der in unserem Datensatz beobachteten Drittanbieter auf das Repository <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/#third-parties-by-category">Third-Party Web</a> von <a hreflang="en" href="https://x.com/patrickhulce">Patrick Hulce</a>. Das Repository unterteilt Drittanbieter in die folgenden Kategorien:

- **Ad (Werbung):** Diese Skripte sind Teil von Werbenetzwerken, entweder zur Auslieferung oder zur Messung.
- **Analytics:** Diese Skripte messen oder verfolgen Nutzer und deren Aktionen. Hier gibt es eine große Bandbreite an Auswirkungen, abhängig davon, was getrackt wird.
- **CDN:** Dies ist eine Mischung aus öffentlich gehosteten Open-Source-Bibliotheken (zum Beispiel jQuery), die über verschiedene öffentliche CDNs ausgeliefert werden, sowie privater CDN-Nutzung.
- **Content:** Diese Skripte stammen von Content-Anbietern oder publishing-spezifischem Affiliate-Tracking.
- **Customer Success:** Diese Skripte stammen von Kundensupport-/Marketing-Anbietern, die Chat- und Kontaktlösungen bereitstellen. Diese Skripte sind in der Regel umfangreicher.
- **Hosting:** Diese Skripte stammen von Webhosting-Plattformen (WordPress, Wix, Squarespace usw.).
- **Marketing:** Diese Skripte stammen von Marketing-Tools, die Pop-ups/Newsletter/Ähnliches hinzufügen.
- **Social:** Diese Skripte ermöglichen Social-Media-Funktionen.
- **Tag Manager:** Diese Skripte laden tendenziell viele andere Skripte und stoßen zahlreiche Aufgaben an.
- **Utility:** Diese Skripte sind Entwickler-Hilfsmittel (API-Clients, Site-Monitoring, Betrugserkennung usw.).
- **Video:** Diese Skripte ermöglichen Videoplayer- und Streaming-Funktionalität.
- **Consent provider:** Diese Skripte ermöglichen es Websites, die Nutzereinwilligung zu verwalten (z. B. zur Einhaltung der [Datenschutz-Grundverordnung](https://wikipedia.org/wiki/General_Data_Protection_Regulation)). Sie sind auch als _Cookie-Consent_-Pop-ups bekannt und werden in der Regel auf dem kritischen Pfad geladen.
- **Other (Sonstige):** Dies sind verschiedene Skripte, die über einen gemeinsamen Ursprung bereitgestellt werden, ohne eine präzise Kategorie oder Zuordnung.

### `Content-Type`

Wir verwenden den HTTP-Header [`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type), um Drittanbieter-Ressourcen in verschiedene Typen einzuteilen, wie Skripte, HTML-Inhalte, JSON-Daten, Klartext und Bilder. Dies ermöglicht uns, die Zusammensetzung der über Websites ausgelieferten Drittanbieter-Ressourcen zu analysieren.

## Verbreitung

{{ figure_markup(
  image="pages-using-at-least-one-3p.png",
  caption="Prozentsatz der Seiten, die einen oder mehrere Drittanbieter nutzen.",
  description="Balkendiagramm, das den Prozentsatz der Seiten über verschiedene Rang-Gruppen zeigt, die mindestens einen Drittanbieter nutzen. Etwa 90–92 % der Seiten nutzen Drittanbieter über alle Rang-Gruppen hinweg.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=249114645&format=interactive",
  sheets_gid="1741089577",
  sql_file="percent_of_websites_with_third_party_by_ranking.sql"
  )
}}

Im Vergleich zum [Vorjahr](../2024/third-parties#prevalence) beobachten wir einen leichten Rückgang des Prozentsatzes der Seiten, die einen oder mehrere Drittanbieter über Websites hinweg nutzen. Trotz dieses Rückgangs bleibt der Prozentsatz der Seiten mit einem oder mehreren Drittanbietern jedoch bei 90 % oder höher.

{{ figure_markup(
  image="num-3p-by-rank.png",
  caption="Verteilung der Anzahl der Drittanbieter nach Rang.",
  description="Balkendiagramm, das die Verteilung der Anzahl der Drittanbieter nach Rang-Gruppen zeigt. Die Anzahl der Drittanbieter sinkt mit steigenden Rang-Gruppen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=211745165&format=interactive",
  sheets_gid="199539546",
  sql_file="number_of_third_parties_by_rank.sql"
  )
}}

Im Vergleich zum Vorjahr beobachten wir einen deutlichen Rückgang des Medians der Anzahl von Drittanbieter-Domains über alle Website-Ränge hinweg, mit einem besonders großen Rückgang bei niedrig eingestuften Websites.

Dieser Rückgang könnte mehrere Gründe haben. Erstens werden Drittanbieter zunehmend durch `CNAME`-Cloaking und server-seitiges Tracking verschleiert, was ihre Sichtbarkeit in client-seitigen Messungen verringern kann. Zweitens interagieren HTTP-Archive-Crawler nicht mit Webseiten und scrollen die Seite nicht nach unten, was verhindern kann, dass manche Drittanbieter aufgrund von Lazy Loading korrekt geladen werden. Dadurch werden möglicherweise weniger Drittanbieter-Anfragen beobachtet.

Wir beobachten zudem, dass Desktop-Seiten im Allgemeinen mehr Drittanbieter enthalten als mobile Seiten.

{{ figure_markup(
  image="num-3p-req-per-page-by-rank.png",
  caption="Verteilung der Anzahl der Drittanbieter-Anfragen pro Seite nach Rang.",
  description="Balkendiagramm, das den Median der Anzahl von Drittanbieter-Anfragen pro Seite nach Rang zeigt. Die Anzahl der Drittanbieter-Anfragen pro Seite steigt von den Top-1K- zu den Top-10K-Rang-Gruppen und sinkt danach für höhere Rang-Gruppen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1763082827&format=interactive",
  sheets_gid="641162136",
  sql_file="number_of_third_party_requests_per_page_by_rank.sql"
  )
}}

Niedrig eingestufte Websites laden mehr Drittanbieter-Anfragen. Die Top 1.000 verzeichnen einen Median von 129 Anfragen auf Desktop und 106 auf Mobilgeräten, verglichen mit 83 auf Desktop und 79 auf Mobilgeräten über alle Websites hinweg.

Im Jahresvergleich sind Drittanbieter-Anfragen über alle Ränge hinweg gestiegen. Die Top-1.000-Websites zeigen einen Anstieg von 15 Anfragen auf Desktop und 15 auf Mobilgeräten [im Vergleich zu 2024](../2024/third-parties#fig-3), während der breitere Datensatz um fünf Anfragen auf Desktop und fünf auf Mobilgeräten zugenommen hat. Dieser Aufwärtstrend tritt trotz des zuvor beobachteten Rückgangs der Anzahl eindeutiger Drittanbieter-Domains auf, was darauf hindeutet, dass einzelne Drittanbieter mehr Anfragen pro Seite senden.

{{ figure_markup(
  image="3p-req-categories-by-rank.png",
  caption="Verteilung der Drittanbieter-Anfragekategorien nach Rang.",
  description="Balkendiagramm, das die Verteilung der Drittanbieter-Kategorien nach Rang-Gruppe zeigt. Die Top-Kategorien sind Ad, Analytics und CDN.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1133634663&format=interactive",
  sheets_gid="445864775",
  sql_file="number_of_third_party_providers_by_rank_and_category.sql"
  )
}}

Das Balkendiagramm zeigt den Median der Anzahl von Drittanbietern pro Seite nach Rang und Kategorie. In der vorherigen Ausgabe konzentrierte sich diese Analyse auf die Anzahl der Drittanbieter-Domains pro Seite nach Rang und Kategorie, während wir dieses Jahr die Anzahl eindeutiger Drittanbieter messen, was insgesamt zu niedrigeren Werten führt. Dieses Jahr sind die Top-Kategorien `ad`, `analytics` und `cdn`.

{{ figure_markup(
  image="3p-req-types-by-rank.png",
  caption="Verteilung der Drittanbieter-Anfragetypen nach Rang.",
  description="Kreisdiagramm, das die prozentuale Verteilung der Drittanbieter-Anfragen nach Content-Type zeigt. Die drei häufigsten Content-Types sind `script` (24,8 %), `image` (19,9 %) und sonstige (13,9 %).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1309978891&format=interactive",
  sheets_gid="418010554",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

Das Diagramm zeigt, dass Drittanbieter-Anfragen von `script`, `image` und der Kategorie `other` (sonstige) dominiert werden. Zusammen machen `script`, `image` und `other` mehr als die Hälfte aller Drittanbieter-Anfrage-Content-Types aus. Dieses Muster stimmt mit der [Ausgabe von 2024](../2024/third-parties#fig-5) überein, die ebenfalls `script`, `image` und `other` als häufigste Anfragetypen identifizierte, was auf wenig Veränderung seit letztem Jahr hindeutet.

{{ figure_markup(
  image="top-3p-by-num-pages.png",
  caption="Top-Drittanbieter nach Anzahl der Seiten.",
  description="Balkendiagramm, das die Top-Drittanbieter nach dem Prozentsatz der Seiten zeigt, auf denen sie vorkommen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=194077318&format=interactive",
  sheets_gid="803451847",
  sql_file="top100_third_parties_by_number_of_websites.sql",
  width=600,
  height=498
  )
}}

Die Top-10-Drittanbieter-Domains werden von Google-eigenen Diensten dominiert, darunter `fonts.googleapis.com`, `googletagmanager.com`, `google-analytics.com`, `accounts.google.com` und `adservice.google.com`. Metas `facebook.com` ist die einzige Nicht-Google-Domain in den Top 10 und belegt mit 21 % der Seiten Rang 7.

## Weitergabe von Einwilligung (Consent) unter Drittanbietern

In diesem Abschnitt untersuchen wir, wie verschiedene Drittanbieter die Nutzereinwilligung im Web übertragen. <a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0120.pdf">Frühere Forschung</a> hat gezeigt, dass Drittanbieter häufig auf branchenübliche Frameworks zurückgreifen, um Einwilligungsinformationen zu übermitteln. In unserer Analyse konzentrieren wir uns hauptsächlich auf die drei Consent-Standards des IAB: das <a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency and Consent Framework (TCF)</a>, das <a hreflang="en" href="https://iabtechlab.com/standards/ccpa/">CCPA Framework</a> und das <a hreflang="en" href="https://iabtechlab.com/gpp/">Global Privacy Protocol (GPP)</a>.

Diese Frameworks definieren, wie Einwilligungsinformationen codiert und zwischen Websites und Drittanbietern ausgetauscht werden. Zunächst ermitteln wir, welche Consent-Standards bei den in unserem Datensatz beobachteten Drittanbietern am weitesten verbreitet sind. Um zu bestimmen, welches Framework ein Drittanbieter verwendet, stützen wir uns auf das Vorhandensein bestimmter Parameter in den Anfrage-URLs. Details zu den verschiedenen Standards finden sich unten:

- **TCF-Standard**: Wir erkennen die Nutzung des TCF-Frameworks, indem wir prüfen, ob eine Drittanbieter-Anfrage die Parameter `gdpr` oder `gdpr_consent` enthält, wie vom IAB TCF spezifiziert.

- **GPP-Standard**: Wir erkennen die Nutzung des GPP-Frameworks, indem wir auf das Vorhandensein der Parameter `gpp` und `gpp_sid` prüfen.

- **USP-Standard und Nicht-USP-Standard**: Wir erkennen die Nutzung des USP-Standards, indem wir prüfen, ob eine Anfrage den Parameter `us_privacy` übermittelt, wie vom IAB-CCPA-Framework definiert. Zudem erkennen wir die Nutzung des nicht standardisierten USP-Standards, indem wir Consent-Strings identifizieren, die über nicht standardisierte Parameter übermittelt werden, die in der <a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0120.pdf">vorherigen Arbeit</a> identifiziert wurden.

Wir analysieren die Verbreitung von Consent-Signalen über Website-Ränge, Drittanbieter-Kategorien und die am häufigsten beobachteten Consent-empfangenden Drittanbieter.

### Verbreitung von Consent-Signalen über verschiedene Ränge

{{ figure_markup(
  image="consent-signal-prevalence-by-rank.png",
  caption="Verbreitung von Consent-Signalen nach Rang.",
  description="Balkendiagramm, das die Verbreitung verschiedener Consent-Standards in Drittanbieter-Anfragen über Website-Ränge zeigt.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=2066656520&format=interactive",
  sheets_gid="1614774531",
  sql_file="consent_signal_prevalence_by_third_party_category.sql"
  )
}}

Wir stellen fest, dass der TCF-Standard der dominierende Consent-Standard ist, insbesondere bei niedrig eingestuften Websites, wo er 36 % erreicht, verglichen mit 18 % über alle Websites. Diese höhere Verbreitung stimmt mit den strengeren Opt-in-Einwilligungsanforderungen unter der DSGVO überein. Der USP-Standard ist der zweithäufigste, mit einer Verbreitung von 9–17 % über die Ränge hinweg. Dies spiegelt die Nutzung des IAB-CCPA-Consent-Frameworks wider, das als Reaktion auf den CCPA eingeführt wurde. Die GPP-Verbreitung bleibt mit 3–6 % minimal, trotz ihres Ziels, Consent-Frameworks über Rechtsräume hinweg zu vereinheitlichen.

### Verteilung der Consent-Standards über verschiedene Kategorien

{{ figure_markup(
  image="consent-signal-prevalence-by-category.png",
  caption="Verbreitung von Consent-Signalen nach Kategorie.",
  description="Balkendiagramm, das die Verbreitung von Consent-Standards über verschiedene Drittanbieter-Kategorien zeigt.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=828032137&format=interactive",
  sheets_gid="1614774531",
  sql_file="consent_signal_prevalence_by_third_party_category.sql"
  )
}}

Wir beobachten unterschiedliche Präferenzen bei Consent-Standards je nach Drittanbieter-Kategorie. Zum Beispiel zeigen Social-Dienste die höchste TCF-Verbreitung, während Werbeanbieter eine ausgewogenere Mischung aus GPP, USP-Standard und kleineren TCF-Anteilen verwenden. Darüber hinaus setzen Analytics-Anbieter überwiegend auf GPP.

### Top-Drittanbieter, die Consent empfangen

{{ figure_markup(
  image="consent-signal-prevalence-by-domain.png",
  caption="Verbreitung von Consent-Signalen nach Domain.",
  description="Balkendiagramm, das die Drittanbieter zeigt, die das höchste Volumen an Consent-Signalen empfangen.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1262795614&format=interactive",
  sheets_gid="1788947788",
  sql_file="consent_signals_by_parameter_and_domain_optimized.sql"
  )
}}

Unter den am höchsten eingestuften Websites empfängt `pubmatic.com` das höchste Volumen an Consent-Signalen, gefolgt von `adservice.google.com` auf Platz zwei. Die Mehrheit der Domains, die das meiste Consent-Signal-Volumen empfangen, sind Werbe- und Ad-Tech-Anbieter – Ad-Exchanges, DSPs und Ad-Server. Das ergibt intuitiv Sinn, da in vielen Rechtsräumen Drittanbieter aus den Bereichen Werbung und Analytics die Einwilligung der Nutzer einholen müssen, bevor sie Nutzerdaten für Werbung und andere Zwecke verwenden.

## Einbindung

Erinnern wir uns an unser früheres Beispiel: `example.com` (eine First Party) kann ein Bild von `awesome-cats.edu` (ein Drittanbieter) über ein `<img>`-Tag einbinden. Diese Einbindung eines Bildes würde als direkte Einbindung betrachtet. Wenn das Bild jedoch von einem Drittanbieter-Skript auf der Website über `XMLHttpRequest` geladen würde, würde die Einbindung des Bildes als indirekte Einbindung betrachtet. Die indirekt eingebundenen Drittanbieter können weitere Drittanbieter einbinden. Zum Beispiel kann ein Drittanbieter-Skript, das direkt auf der Website eingebunden ist, ein weiteres Drittanbieter-Skript einbinden. In diesem Kapitel führen wir eine grundlegende Analyse der Tiefe der Einbindungsketten von Drittanbietern durch.

{{ figure_markup(
  image="median-depth-tp-inclusion-chains.png",
  caption="Median-Tiefe der Drittanbieter-Einbindungsketten.",
  description="Balkendiagramm, das die Median-Tiefe der Einbindungskette zeigt.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=692408075&format=interactive",
  sheets_gid="1518420053",
  sql_file="inclusion_chain.sql"
  )
}}

Die Median-Tiefe der Einbindungskette beträgt 3, was bedeutet, dass die Mehrheit der Drittanbieter mindestens einen weiteren Drittanbieter auf einer Webseite einbindet. Die maximale Tiefe der Einbindungskette beträgt 2.285.

## Fazit

Unsere Ergebnisse zeigen die allgegenwärtige und zunehmend konzentrierte Natur von Drittanbietern im Web. Mehr als neun von zehn Webseiten binden einen oder mehrere Drittanbieter ein. Während der Median der Anzahl eindeutiger Drittanbieter-Domains im Vergleich zum Vorjahr gesunken ist, beobachten wir einen deutlichen Anstieg der Gesamtzahl der Anfragen von Drittanbietern, was darauf hindeutet, dass einzelne Anbieter mehr Anfragen pro Seite senden.

Bei den Consent-Standards ist TCF der dominierende Standard über alle Website-Ränge hinweg. Unter den einzelnen Drittanbietern empfangen `pubmatic.com`, `adservice.google.com` und andere Ad-Tech-Domains das höchste Volumen an Consent-Signalen.

Schließlich verringert die zunehmende Nutzung von Verschleierungstechniken wie CNAME-Cloaking und server-seitigem Tracking die Sichtbarkeit von Drittanbietern in client-seitigen Messungen, was darauf hindeutet, dass unsere Ergebnisse eine Untergrenze der tatsächlichen Verbreitung darstellen.
