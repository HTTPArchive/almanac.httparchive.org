---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Privacy
description: Capitolo sulla privacy del Web Almanac 2020 che copre i cookie di tracciamento online, le tecnologie per il miglioramento della privacy (PET) e le politiche sulla privacy
authors: [ydimova]
reviewers: [ldevernay]
analysts: [ydimova, max-ostapenko]
editors: [tunetheweb]
translators: [chefleo]
ydimova_bio:  Yana Dimova è una studentessa di dottorato presso l'università KU Leuven in Belgio, che si occupa di privacy e sicurezza web.
discuss: 2046
results: https://docs.google.com/spreadsheets/d/16bE70rv4qbmKIqbZS1zUiTRpk5eOlgxBXEabL1qiduI/
featured_quote: La privacy è aumentata di recente in popolarità e ha aumentato la consapevolezza da parte degli utenti. La necessità di linee guida è stata soddisfatta con varie normative (come GDPR in Europa, LGPD in Brasile, CCPA in California per citarne solo alcune). Questi mirano ad aumentare la responsabilità dei responsabili del trattamento dei dati e la loro trasparenza nei confronti degli utenti. In questo capitolo si discute della prevalenza del tracciamento online con diverse tecniche e del tasso di adozione dei banner di consenso sui cookie e delle politiche sulla privacy da parte dei siti web.
featured_stat_1: 93%
featured_stat_label_1: Siti web che caricano almeno un tracker
featured_stat_2: Nove su dieci
featured_stat_label_2: Principali domini di impostazione dei cookie di proprietà di Google
featured_stat_3: 44.8%
featured_stat_label_3: Siti Web che dispongono di una politica sulla privacy
---

## Introduzione

Questo capitolo del Web Almanac offre una panoramica dello stato attuale della privacy sul web. Questo argomento è diventato di recente sempre più popolare e ha aumentato la consapevolezza da parte degli utenti. La necessità di linee guida è stata soddisfatta con varie normative (come <a hreflang="en" href="https://gdpr-info.eu/">GDPR</a> in Europa, <a hreflang="en" href="https://lgpd-brazil.info/">LGPD</a> in Brasile, <a hreflang="en" href="https://leginfo.legislature.ca.gov/faces/codes_displayText.xhtml?division=3.&part=4.&lawCode=CIV&title=1.81.5">CCPA</a> in California per citarne solo alcuni). Questi mirano ad aumentare la responsabilità dei responsabili del trattamento dei dati e la loro trasparenza nei confronti degli utenti. In questo capitolo si discute della prevalenza del tracciamento online con diverse tecniche e del tasso di adozione dei banner di consenso sui cookie e delle politiche sulla privacy da parte dei siti web.

## Online tracking

I tracker di terze parti raccolgono i dati degli utenti per creare profili del comportamento dell'utente da monetizzare a fini pubblicitari. Ciò solleva preoccupazioni per la privacy degli utenti sul Web, che ha portato all'emergere di varie protezioni di tracciamento. Tuttavia, come vedremo in questa sezione, il monitoraggio online è ancora ampiamente utilizzato. Non solo ha un impatto negativo sulla privacy, il monitoraggio online ha un <a hreflang="en" href="https://gerrymcgovern.com/calculating-the-pollution-cost-of-website-analytics-part-1/">enorme impatto sull'ambiente</a> ed evitarlo può portare a [prestazioni migliori](https://x.com/fr3ino/status/1000166112615714816).

Esaminiamo l'importanza delle tipologie più comuni di tracciamento [di terze parti](./third-party), ovvero mediante cookie di terze parti e l'utilizzo del fingerprinting. Il monitoraggio online non si limita solo a queste due tecniche, ne continuano a sorgere di nuove per aggirare le contromisure esistenti.

### Tracker di terze parti

Utilizziamo l'elenco dei tracker di <a hreflang="en" href="https://whotracks.me/">WhoTracksMe</a> per determinare la percentuale di siti web che inviano una richiesta a un potenziale tracker. Come mostrato nella figura seguente, abbiamo riscontrato che almeno un potenziale tracker è presente su circa il 93% dei siti web.

{{ figure_markup(
  image="privacy-websites-that-load-trackers.png",
  caption="Siti web che includono almeno un potenziale tracker",
  description="Grafico a barre che mostra che il 92.94% dei siti Web desktop e il 92.97% dei siti Web mobile caricano tracker.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1325818112&format=interactive",
  sheets_gid="1591448294"
  )
}}

Abbiamo esaminato i tracker più utilizzati e tracciato la prevalenza dei 10 più popolari.

{{ figure_markup(
  image="privacy-biggest-third-party-potential-trackers.png",
  caption="Top 10 potenziali tracker",
  description="Grafico a barre che mostra la prevalenza dei 10 potenziali tracker più popolari utilizzati su client mobile e desktop. C'è poca differenza tra desktop e mobile e su mobile ha il 65.5% per google_analytics, 65.9% per googleapis.com, 63.3% per gstatic, 58.3% per google_fonts, 50.0% per doubleclick, 47.6% per google, 42.4% per google_tag_manager, 30.9% per facebook, 19.2% per google_adservices e 12.7% per cloudflare.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=850649042&format=interactive",
  sheets_gid="1677398038"
  )
}}

Il più grande player nel mercato del tracking online è senza dubbio Google, con otto dei suoi domini presenti tra i primi 10 potenziali tracker e prevalenti su almeno il 70% dei siti web. Sono seguiti da Facebook e Cloudflare, anche se quest'ultimo probabilmente riflette maggiormente la loro popolarità come sito di hosting.

L'elenco dei tracker di WhoTracksMe definisce anche le categorie a cui appartengono i tracker. Se rimuoviamo CDN e siti di hosting dalle nostre statistiche, presumendo che non possano tenere traccia, o almeno che questa non sia la loro funzione principale, si ottiene una visione leggermente diversa dei primi 10.

{{ figure_markup(
  image="privacy-biggest-third-party-trackers.png",
  caption="I 10 migliori tracker",
  description="Grafico a barre che mostra la prevalenza dei 10 tracker più popolari utilizzati su client mobile e desktop. C'è poca differenza tra desktop e mobile e su mobile ha il 65.5% per google_analytics, 50.0% per doubleclick, 47.6% per google, 42.4% per google_tag_manager, 30.9% per facebook, 19.2% per google_adservices, 12.7% per youtube, 19.2% per google_syndication e il 6.5% sia per twitter che per wordpress_stats.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1831606887&format=interactive",
  sheets_gid="1677398038"
  )
}}

Qui Google costituisce ancora sette dei primi 10 domini. La figura seguente mostra la distribuzione delle diverse categorie per i 100 più grandi tracker potenziali per categoria.

{{ figure_markup(
  image="privacy-tracker-categories.png",
  caption="Categorie dei 100 potenziali tracker più popolari",
  description="Grafico a barre che mostra la distribuzione dei primi 100 potenziali tracker sul Web con 56 per la pubblicità, 11 per cdn, 9 per site_analytics, 6 per social media e misc, 3 per essential e customer_help, 2 per audio e video e 1 per commenti e indefiniti.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1117413918&format=interactive",
  sheets_gid="1431872451",
  )
}}

Quasi il 60% dei tracker più popolari sono legati alla pubblicità. Ciò potrebbe essere dovuto al fatto che la redditività del mercato della pubblicità online viene percepita come correlata alla quantità di tracciamento.

### Cookies

Abbiamo esaminato i cookie più popolari impostati sui siti Web nell'intestazione della risposta HTTP, in base al loro nome e dominio.

<figure>
  <table>
    <thead>
      <tr>
        <th>Dominio</th>
        <th>Nome del Cookie</th>
        <th>Siti web</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">24%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>sconosciuto</td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>sconosciuto</td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>sconosciuto</td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="I migliori cookie sui siti desktop", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Dominio</th>
        <th>Nome del Cookie</th>
        <th>Siti web</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">32%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">21%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>DSID</code></td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>yandexuid</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>i</code></td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Principali cookie sui siti mobile", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

Come puoi vedere, il dominio di monitoraggio di Google "doubleclick.net" imposta i cookie su circa un quarto dei siti web su un client mobile e un terzo di tutti i siti web su un client desktop. Ancora una volta, nove dei dieci cookie più popolari sul client desktop e sette su dieci sui dispositivi mobile sono impostati da un dominio Google. Si tratta di un limite inferiore per il numero di siti Web su cui è impostato il cookie, poiché contiamo solo i cookie impostati tramite un'intestazione HTTP: un gran numero di cookie di tracciamento viene impostato utilizzando script di terze parti.

### Fingerprinting

Un'altra tecnica di tracciamento ampiamente utilizzata è il fingerprinting. Consiste nel raccogliere diversi tipi di informazioni sull'utente con l'obiettivo di creare per loro una "impronta digitale" unica. Diversi tipi di impronte digitali vengono utilizzati sul Web dai tracker. Il fingerprinting del browser utilizza caratteristiche specifiche del browser dell'utente, basandosi sul fatto che la possibilità che un altro utente abbia la stessa identica configurazione del browser è abbastanza piccola se c'è un numero sufficiente di variabili da tracciare. Durante la nostra scansione, abbiamo esaminato la presenza della libreria <a hreflang="en" href="https://fingerprintjs.com/"> FingerprintJS </a>, che fornisce il fingerprinting del browser come servizio.

{{ figure_markup(
  image="privacy-websites-with-fingerprintjs-library.png",
  caption="Siti web che utilizzano FingerprintJS",
  description="Il grafico a barre che mostra lo 0.17% dei siti desktop e lo 0.18% dei siti mobile utilizza FingerprintJS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1556252953&format=interactive",
  sheets_gid="222110824",
  sql_file="percent_of_websites_with_fingerprinting.sql "
  )
}}

Sebbene la libreria sia presente solo su una piccola percentuale di siti Web, la natura persistente delle fingerprinting significa che anche un piccolo utilizzo può avere un grande impatto. Inoltre, FingerprintJS non è l'unico tentativo di rilevamento delle impronte digitali. Anche altre librerie, strumenti e codice nativo possono servire a questo scopo, quindi questo è solo un esempio.

## Piattaforme di gestione del consenso

I banner di consenso sui cookie sono diventati comuni ora. Aumentano la trasparenza nei confronti dei cookie e spesso consentono agli utenti di specificare le proprie scelte sui cookie. Sebbene molti siti web scelgano di utilizzare la propria implementazione di banner cookie, recentemente sono emerse soluzioni di terze parti chiamate <em>Piattaforme di gestione del consenso</em>. Le piattaforme forniscono ai siti Web un modo semplice per raccogliere il consenso dell'utente per diversi tipi di cookie. Vediamo che il 4.4% dei siti Web utilizza una piattaforma di gestione del consenso per gestire le scelte dei cookie sui client desktop e il 4.0% sui client mobile.

{{ figure_markup(
  image="privacy-websites-with-consent-management-platform.png",
  caption="Siti web che utilizzano una piattaforma di gestione del consenso",
  description="Grafico a barre che mostra il 4.4% dei siti desktop e il 4.0% dei siti mobile utilizza una piattaforma di gestione del consenso.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=2025542332&format=interactive",
  sheets_gid="1910033502",
  sql_file="percent_of_websites_with_cmp.sql"
  )
}}

{{ figure_markup(
  image="privacy-consent-management-platform-popularity.png",
  caption="Popolarità della piattaforma di gestione del consenso",
  description="Grafico a barre che mostra le popolari piattaforme di gestione del consenso di Osano all\'1.6%, Quantcast Choice all\'1.0%, Cookiebot e OneTrust allo 0.4%, Iubenda allo 0.3%, Crownpeak, Didomi e TrustArc allo 0.1%, CIVIC, Cookie Script, CookieHub, Termly , Uniconsent, CookieYes, eucookie.eu, Seers e Metomic tutti a circa lo 0.0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341496718&format=interactive",
  sheets_gid="1104760876",
  sql_file="percent_of_websites_using_each_cmp.sql"
  )
}}

Osservando la popolarità delle diverse soluzioni di gestione del consenso, possiamo vedere che Osano e Quantcast Choice sono le piattaforme leader.

### Il Transparency Consent Framework di IAB Europe

IAB Europe, l'Interactive Advertising Bureau, è un'associazione europea per il marketing e la pubblicità digitale. Hanno proposto un <a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency Consent Framework</a> (TCF) come soluzione conforme al GDPR per ottenere il consenso degli utenti sulle loro preferenze in materia di pubblicità digitale. L'implementazione fornisce uno standard di settore per la comunicazione tra editori e inserzionisti sul consenso dei consumatori.

{{ figure_markup(
  image="privacy-adoption-of-the-tcf-banner.png",
  caption="Tasso di adozione del banner TCF",
  description="Grafico a barre che mostra che l\'1.5% dei siti desktop e l\'1.4% dei siti mobile hanno implementato il banner TCF di IAB Europe.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341275612&format=interactive",
  sheets_gid="2077755325",
  sql_file="percent_of_websites_with_iab_tcf_banner.sql"
  )
}}

Anche se i nostri risultati mostrano che il banner TCF non è ancora lo "standard del settore", è un passo avanti. Considerando che il principale gruppo target di IAB Europe sono infatti gli editori europei, e la nostra scansione è globale, avere un tasso di adozione sull'1.5% dei siti web su client desktop e dell'1.4% su mobile non è poi così male.

## Norme sulla privacy

Le politiche sulla privacy sono ampiamente utilizzate dai siti Web per soddisfare gli obblighi legali e aumentare la trasparenza nei confronti degli utenti sulle pratiche di raccolta dei dati. Nella nostra ricerca per indicizzazione, abbiamo cercato parole chiave che indicano la presenza di un testo di informativa sulla privacy su ciascun sito Web visitato.

{{ figure_markup(
  image="privacy-websites-with-privacy-link.png",
  caption="Siti Web che dispongono di una politica sulla privacy",
  description="Grafico a barre che mostra che il 44.8% dei siti desktop e il 42.3% dei siti mobile hanno un link per la privacy.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=329249623&format=interactive",
  sheets_gid="495362514",
  sql_file="percent_of_websites_with_privacy_links.sql "
  )
}}

I risultati mostrano che quasi la metà dei siti Web nel set di dati ha incluso una politica sulla privacy, il che è positivo. Tuttavia, gli studi hanno dimostrato che la maggior parte degli utenti di Internet non si preoccupa di leggere le politiche sulla privacy e, quando lo fanno, mancano di comprensione a causa della lunghezza e della complessità della maggior parte dei testi delle politiche sulla privacy. Avere ancora una politica è un passo avanti!

## Conclusione

Questo capitolo ha mostrato che il monitoraggio di terze parti rimane prominente sia sui client desktop che su quelli mobile, con Google che traccia la percentuale più alta di siti web. Le piattaforme di gestione del consenso vengono utilizzate su una piccola percentuale di siti Web; tuttavia molti siti web implementano i propri banner di consenso ai cookie.

Infine, circa la metà dei siti Web include una politica sulla privacy, che beneficia notevolmente della trasparenza nei confronti degli utenti sulle pratiche di elaborazione dei dati. Questo è senza dubbio un passo avanti, ma resta ancora molto da fare. Al di fuori di questa analisi sappiamo che le politiche sulla privacy sono difficili da leggere e comprendere e che i banner di consenso sui cookie manipolano gli utenti nel consenso.

Affinché il Web rispetti veramente gli utenti, la privacy deve essere una parte del concetto, non un ripensamento. La regolamentazione è una buona cosa a questo riguardo ed è rassicurante vedere un aumento della regolamentazione della privacy in tutto il mondo. [Privacy by design](https://it.wikipedia.org/wiki/Privacy_by_design) dovrebbe essere la norma, piuttosto che implementare politiche e strumenti al fine di soddisfare i requisiti legali minimi ed evitare sanzioni finanziarie.
