---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP/2
description: Capitolo HTTP/2 del 2020 Web Almanac che copre l'adozione e l'impatto di HTTP/2, HTTP/2 Push, problemi HTTP/2 e HTTP/3.
hero_alt: Hero image of Web Almanac characters driving vehicles in various lanes carrying script and images resources.
authors: [dotjs, rmarx, MikeBishop]
reviewers: [LPardue, tunetheweb, ibnesayeed]
analysts: [gregorywolf]
editors: [rviscomi]
translators: [chefleo]
dotjs_bio: Andrew lavora presso <a hreflang="en" href="https://www.cloudflare.com/">Cloudflare</a>, contribuendo a rendere il Web più veloce e più sicuro. Dedica il suo tempo alla distribuzione, alla misurazione e al miglioramento di nuovi protocolli e alla fornitura di risorse per migliorare le prestazioni del sito Web per l'utente finale.
rmarx_bio: Robin è un ricercatore di prestazioni e protocolli web presso la <a hreflang="en" href="https://www.uhasselt.be/edm">Hasselt University, Belgio</a>. Ha lavorato per rendere QUIC e HTTP/3 pronti per l'uso creando strumenti come <a hreflang="en" href="https://github.com/quiclog">qlog e qvis</a>.
MikeBishop_bio: Editor di HTTP/3 con il <a hreflang="en" href="https://quicwg.org/">QUIC Working Group</a>. Architetto nel gruppo Foundry di <a hreflang="en" href="https://www.akamai.com/">Akamai</a>.
discuss: 2058
results: https://docs.google.com/spreadsheets/d/1M1tijxf04wSN3KU0ZUunjPYCrVsaJfxzuRCXUeRQ-YU/
featured_quote: Questo capitolo esamina lo stato corrente della distribuzione di HTTP/2 e gQUIC, per stabilire quanto siano state adottate alcune delle nuove funzionalità del protocollo, come l'assegnazione delle priorità e il push del server. Quindi esaminiamo le motivazioni per HTTP/3, descriviamo le principali differenze tra le versioni del protocollo e discutiamo le potenziali sfide nell'aggiornamento a un protocollo di trasporto basato su UDP con QUIC.
featured_stat_1: 64%
featured_stat_label_1: Richieste servite su HTTP/2
featured_stat_2: 31.7%
featured_stat_label_2: Richieste CDN con priorità HTTP/2 errata
featured_stat_3: 80%
featured_stat_label_3: Pagine servite su HTTP/2 se viene utilizzata una CDN, 30% se non viene utilizzata una CDN
---

## Introduzione

HTTP è un protocollo a livello di applicazione progettato per trasferire informazioni tra dispositivi in rete e viene eseguito su altri livelli dello stack del protocollo di rete. Dopo il rilascio di HTTP/1.x, ci sono voluti oltre 20 anni prima che il primo aggiornamento importante, HTTP/2, diventasse uno standard nel 2015.

Non si è fermato qui: negli ultimi quattro anni, HTTP/3 e QUIC (un nuovo protocollo di trasporto sicuro, affidabile e che riduce la latenza) sono stati oggetto di sviluppo di standard nel gruppo di lavoro IETF QUIC. In realtà ci sono due protocolli che condividono lo stesso nome: "Google QUIC" ("gQUIC" in breve), il protocollo originale progettato e utilizzato da Google e la versione più recente standardizzata IETF (IETF QUIC/QUIC). IETF QUIC era basato su gQUIC, ma è cresciuto fino a essere molto diverso nella progettazione e nell'implementazione. Il 21 ottobre 2020, la bozza 32 di IETF QUIC ha raggiunto un traguardo significativo quando è passata al <a hreflang="en" href="https://mailarchive.ietf.org/arch/msg/quic/ye1LeRl7oEz898RxjE6D3koWhn0/">Last Call</a>. Questa è la parte del processo di standardizzazione quando il gruppo di lavoro ritiene che il loro lavoro sia finito e richiede una revisione finale dalla più ampia comunità IETF.

Questo capitolo esamina lo stato corrente della distribuzione HTTP/2 e gQUIC. Esplora il modo in cui sono state adottate alcune delle nuove funzionalità del protocollo, come l'assegnazione delle priorità e il push del server. Quindi esaminiamo le motivazioni per HTTP/3, descriviamo le principali differenze tra le versioni del protocollo e discutiamo le potenziali sfide nell'aggiornamento a un protocollo di trasporto basato su UDP con QUIC.

### Da HTTP/1.0 a HTTP/2

Con l'evoluzione del protocollo HTTP, la semantica di HTTP è rimasta la stessa; non sono state apportate modifiche ai metodi HTTP (come GET o POST), ai codici di stato (200 o al temuto 404), agli URI o ai campi di intestazione. Dove il protocollo HTTP è cambiato, le differenze sono state la codifica cablata e l'uso delle funzionalità del trasporto sottostante.

HTTP/1.0, pubblicato nel 1996, ha definito il protocollo applicativo basato su testo, consentendo a client e server di scambiarsi messaggi per richiedere risorse. Per ogni richiesta/risposta era necessaria una nuova connessione TCP, il che introduceva un sovraccarico. Le connessioni TCP utilizzano un algoritmo di controllo della congestione per massimizzare la quantità di dati che possono essere trasferite. Questo processo richiede tempo per ogni nuova connessione. Questo "avvio lento" significa che non tutta la larghezza di banda disponibile viene utilizzata immediatamente.

Nel 1997, è stato introdotto HTTP/1.1 per consentire il riutilizzo della connessione TCP aggiungendo "keep-alive", finalizzato a ridurre il costo totale dell'avvio della connessione. Nel tempo, l'aumento delle aspettative sulle prestazioni del sito Web ha portato alla necessità di concorrenza delle richieste. HTTP/1.1 poteva richiedere un'altra risorsa solo dopo che la risposta precedente era stata completata. Pertanto, è stato necessario stabilire ulteriori connessioni TCP, riducendo l'impatto delle connessioni keep-alive e aumentando ulteriormente il sovraccarico.

HTTP/2, pubblicato nel 2015, è un protocollo basato su binari che ha introdotto il concetto di flussi bidirezionali tra client e server. Utilizzando questi flussi, un browser può fare un uso ottimale di una singola connessione TCP a _multiplex_ più richieste/risposte HTTP contemporaneamente. HTTP/2 ha anche introdotto uno schema di prioritizzazione per gestire questo multiplexing; i client possono segnalare una request priority che consente di inviare risorse più importanti prima di altre.

## Adozione HTTP/2

I dati utilizzati in questo capitolo provengono dal HTTP Archive e testano oltre sette milioni di siti Web con un browser Chrome. Come con altri capitoli, l'analisi è suddivisa in siti Web mobili e desktop. Quando i risultati tra desktop e mobile sono simili, le statistiche vengono presentate dal set di dati mobile. Puoi trovare maggiori dettagli nella pagina [Metodologia](./methodology). Quando esamini questi dati, tieni presente che ogni sito web riceverà lo stesso peso indipendentemente dal numero di richieste. Ti suggeriamo di considerarlo più come un'indagine sulle tendenze in un'ampia gamma di siti web attivi.

{{ figure_markup(
  image="http2-h2-usage.png",
  link="https://httparchive.org/reports/state-of-the-web#h2",
  caption='Utilizzo di HTTP/2 su richiesta. (Fonte: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#h2">HTTP Archive</a>)',
  description="Grafico della serie temporale dell'utilizzo di HTTP/2 che mostra l'adozione al 64% sia per desktop che per dispositivi mobile a luglio 2019. La tendenza è in costante crescita a circa 15 punti all'anno.",
  width=600,
  height=321
  )
}}

L'analisi dello scorso anno dei dati del HTTP Archive ha mostrato che HTTP/2 è stato utilizzato per oltre il 50% delle richieste e, come si può vedere, la crescita lineare è continuata nel 2020; ora oltre il 60% delle richieste viene servito tramite HTTP/2.

{{ figure_markup(
  caption="La percentuale di richieste che utilizzano HTTP/2.",
  content="64%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

Confrontando la Figura 22.3 con i risultati dello scorso anno, c'è stato un **aumento del 10% nelle richieste HTTP/2** e una corrispondente diminuzione del 10% nelle richieste HTTP/1.x. Questo è il primo anno in cui gQUIC può essere visto nel set di dati.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocollo</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">**34.47%</td>
        <td class="numeric">34.11%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">63.70%</td>
        <td class="numeric">63.80%</td>
      </tr>
      <tr>
        <td>gQUIC</td>
        <td class="numeric">1.72%</td>
        <td class="numeric">1.71%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="Utilizzo della versione HTTP su richiesta.", sheets_gid="2122693316", sql_file="adoption_of_http_2_by_site_and_requests.sql") }}</figcaption>
</figure>

<p class="note">
  ** Come per la scansione dello scorso anno, circa il 4% delle richieste desktop non riportava una versione del protocollo. L'analisi mostra che si tratta principalmente di HTTP/1.1 e abbiamo lavorato per correggere questa lacuna nelle nostre statistiche per future scansioni e analisi. Sebbene basiamo i dati sulla scansione di agosto 2020, abbiamo confermato la correzione nel set di dati di ottobre 2020 prima della pubblicazione che mostrava effettivamente che si trattava di richieste HTTP/1.1 e quindi le abbiamo aggiunte a quella statistica nella tabella sopra.
</note>

Quando si esamina il numero totale di richieste di siti web, ci sarà una preferenza per i comuni domini di terze parti. Per avere una migliore comprensione dell'adozione di HTTP/2 da parte dell'installazione del server, esamineremo invece il protocollo utilizzato per servire l'HTML dalla home page di un sito.

L'anno scorso circa il 37% delle home page è stato servito su HTTP/2 e il 63% su HTTP/1. Quest'anno, combinando dispositivi mobile e desktop, si tratta di una divisione più o meno uguale, con un numero leggermente maggiore di siti desktop serviti su HTTP/2 per la prima volta, come mostrato nella Figura 22.4.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocollo</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.05%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">49.22%</td>
        <td class="numeric">50.05%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">49.97%</td>
        <td class="numeric">49.28%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="Utilizzo della versione HTTP per le home page.", sheets_gid="1447413141", sql_file="measure_of_all_http_versions_for_main_page_of_all_sites.sql") }}</figcaption>
</figure>

gQUIC non viene visualizzato nei dati della home page per due motivi. Per misurare un sito Web su gQUIC, la scansione dell'archivio HTTP dovrebbe eseguire la negoziazione del protocollo tramite l'intestazione [alternative services](#alternative-services) e quindi utilizzare questo endpoint per caricare il sito su gQUIC. Quest'anno non è stato supportato, ma ci aspettiamo che sia disponibile nel Web Almanac del prossimo anno. Inoltre, gQUIC viene utilizzato prevalentemente per strumenti Google di terze parti piuttosto che per la pubblicazione di home page.

La spinta ad aumentare [security](./security) e [privacy](./privacy) sul Web ha visto aumentare le richieste su TLS di <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">oltre il 150% negli ultimi 4 anni</a>. Oggi, oltre l'86% di tutte le richieste su dispositivi mobile e desktop sono crittografate. Guardando solo alle home page, i numeri sono ancora un impressionante 78.1% dei desktop e 74.7% dei dispositivi mobile. Questo è importante perché HTTP/2 è supportato solo dai browser su TLS. Anche la proporzione servita su HTTP/2, come mostrato nella Figura 22.5, è aumentata di 10 punti percentuali rispetto a [l'anno scorso](../2019/http#fig-5), dal 55% al 65%.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocollo</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">36.05%</td>
        <td class="numeric">34.04%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">63.95%</td>
        <td class="numeric">65.96%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="Utilizzo della versione HTTP per le home page HTTPS.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

Con oltre il 60% dei siti Web serviti tramite HTTP/2 o gQUIC, esaminiamo un po' più a fondo il modello di distribuzione del protocollo per tutte le richieste effettuate sui singoli siti.

{{ figure_markup(
  image="http2-h2-or-gquic-requests-per-page.png",
  caption="Confronta la distribuzione della frazione di richieste HTTP/2 per pagina nel 2020 con il 2019.",
  description="Un grafico a barre della frazione di richieste HTTP/2 per percentile di pagina. La percentuale mediana di richieste HTTP/2 o gQUIC per pagina è aumentata al 76% nel 2020 dal 46% nel 2019. Al 10, 25, 75 e 90° percentile, la frazione di richieste HTTP/2 o gQUIC per pagina nel 2020 è del 5%, 24%, 98% e 100% rispetto al 3%, 15%, 93% e 100% nel 2019.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1328744214&format=interactive",
  sheets_gid="152400778",
  sql_file="percentiles_of_resources_loaded_over_HTTP2_or_better_per_site.sql"
  )
}}

La Figura 22.6 confronta la quantità di HTTP/2 o gQUIC utilizzata su un sito Web tra quest'anno e l'anno scorso. Il cambiamento più evidente è che oltre la metà dei siti ora ha il 75% o più delle proprie richieste servite tramite HTTP/2 o gQUIC rispetto al 46% dello scorso anno. Meno del 7% dei siti non effettua richieste HTTP/2 o gQUIC, mentre (solo) il 10% dei siti sono interamente richieste HTTP/2 o gQUIC.

E la ripartizione della pagina stessa? In genere parliamo della differenza tra contenuti di prima parte (o proprietari) e di terze parti. Terza parte è definita come contenuto non sotto il controllo diretto del proprietario del sito, che fornisce funzionalità come pubblicità, marketing o analisi. La definizione di terze parti nota è tratta dal repository <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5">web di terze parti</a>.

La Figura 22.7 ordina ogni sito Web per la frazione di richieste HTTP/2 per terze parti note o richieste di prima parte rispetto ad altre richieste. C'è una differenza notevole in quanto oltre il 40% di tutti i siti non ha richieste HTTP/2 o gQUIC di prima parte. Al contrario, anche il 5% più basso delle pagine ha il 30% di contenuti di terze parti serviti su HTTP/2. Ciò indica che gran parte dell'ampia adozione di HTTP/2 è guidata da terze parti.

{{ figure_markup(
  image="http2-first-and-third-party-http2-usage.png",
  caption="La distribuzione della frazione di richieste HTTP/2 di terze parti e di prima parte per pagina.",
  description="Un grafico a linee che confronta la frazione di richieste HTTP/2 di prima parte con le richieste HTTP/2 o gQUIC di terze parti. Il grafico ordina i siti Web in base alla frazione delle richieste HTTP/2. Il 45% dei siti Web non ha richieste di prima parte HTTP/2. Oltre la metà dei siti web serve richieste di terze parti solo su HTTP/2 o gQUIC. L'80% dei siti Web ha il 76% o più richieste HTTP/2 o gQUIC di terze parti.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1409316276&format=interactive",
  sql_file="http2_1st_party_vs_3rd_party.sql",
  sheets_gid="733872185"
)
}}

C'è qualche differenza nei tipi di contenuto serviti su HTTP/2 o gQUIC? La Figura 22.8 mostra, ad esempio, che il 90% dei siti Web serve il 100% di font e audio di terze parti su HTTP/2 o gQUIC, solo il 5% su HTTP/1.1 e il 5% sono un mix. La maggior parte delle risorse di terze parti sono script o immagini e vengono pubblicate esclusivamente su HTTP/2 o gQUIC rispettivamente sul 60% e 70% dei siti web.

{{ figure_markup(
  image="http2-third-party-http2-usage-by-content-type.png",
  caption="La frazione di richieste HTTP/2 o gQUIC di terze parti note per tipo di contenuto per sito web.",
  description="Un grafico a barre che confronta la frazione di richieste HTTP/2 di terze parti in base al tipo di contenuto. Tutte le richieste di terze parti vengono servite su HTTP/2 o gQUIC per il 90% di audio e font, l'80% di css e video, il 70% di html, immagini e testo e il 60% di script.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1264128523&format=interactive",
  sheets_gid="419557288",
  sql_file="http2_1st_party_vs_3rd_party_by_type.sql"
)
}}

Annunci, analisi, risorse della rete di distribuzione dei contenuti (CDN) e <i lang="en">tag-manager</i> vengono serviti prevalentemente su HTTP/2 o gQUIC, come mostrato nella Figura 22.9. È più probabile che i contenuti di marketing e <i lang="en">customer-success</i> vengano pubblicati tramite HTTP/1.

{{ figure_markup(
  image="http2-third-party-http2-usage-by-category.png",
  caption="La frazione di richieste HTTP/2 o gQUIC di terze parti note per categoria e per sito web.",
  description='Un grafico a barre che confronta la frazione di richieste HTTP/2 o gQUIC di terze parti per categoria. Tutte le richieste di terze parti per tutti i siti Web vengono servite tramite HTTP/2 o gQUIC per il 95% dei <i lang="en">tag-manager</i>, il 90% di analisi e CDN, l\'80% di annunci, social, hosting e utilità, il 40% del marketing e il 30% dei <i lang="en">customer-success</i>.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1419102835&format=interactive",
  sheets_gid="1059610651",
  sql_file="http2_3rd_party_by_types.sql"
)
}}

### Supporto server

I meccanismi di aggiornamento automatico del browser sono un fattore trainante per l'adozione lato client di nuovi standard web. È <a hreflang="en" href="https://caniuse.com/http2">stimato</a> che oltre il 97% degli utenti globali supporta HTTP/2, in lieve aumento rispetto al 95% misurato lo scorso anno.

Sfortunatamente, il percorso di aggiornamento per i server è più difficile, soprattutto con la necessità di supportare TLS. Per dispositivi mobile e desktop, possiamo vedere dalla Figura 22.10, che la maggior parte dei siti HTTP/2 sono serviti da nginx, Cloudflare e Apache. Quasi la metà dei siti HTTP/1.1 sono serviti da Apache.

{{ figure_markup(
  image="http2-server-protocol-usage.png",
  caption="Utilizzo del server tramite protocollo HTTP su dispositivo mobile",
  description="Un grafico a barre che mostra il numero di siti Web serviti da HTTP/1.x o HTTP/2 per i server più popolari per i client mobili. Nginx serve 727.181 siti HTTP/1.1 e 1.023.575 HTTP/2. Cloudflare 59.981 HTTP/1.1 e 679.616 HTTP/2. Apache 1.521.753 HTTP/1.1 e 585.096 HTTP/2. Litespeed 50.502 HTTP/1.1 e 166.721 HTTP/2. Microsoft-IIS 284.047 HTTP/1.1 e 81.490 HTTP/2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=718663369&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
)
}}

Come è cambiata l'adozione di HTTP/2 nell'ultimo anno per ogni server? La Figura 22.11 mostra un aumento generale dell'adozione di HTTP/2 di circa il 10% su tutti i server dallo scorso anno. Apache e IIS sono ancora sotto il 25% di HTTP/2. Ciò suggerisce che i nuovi server tendono ad essere nginx o è considerato troppo difficile o non utile aggiornare Apache o IIS a HTTP/2 e/o TLS.

{{ figure_markup(
  image="http2-h2-usage-by-server.png",
  caption="Percentuale di pagine servite su HTTP/2 dal server",
  description="Un grafico a barre che confronta la percentuale di siti Web serviti tramite HTTP/2 tra il 2019 e il 2020. Cloudflare è aumentato al 93.08% dall'85.40%. Litespeed è aumentato all'81.91% dal 70.80%. Openresty è aumentato al 66.24% dal 51.40%. Nginx è aumentato al 60.84% dal 49.20%. Apache è aumentato al 27.19% dal 18.10% e MIcorsoft-IIS è aumentato al 22.82% dal 14.10%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=936321266&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

Una raccomandazione a lungo termine per migliorare le prestazioni del sito Web è stata quella di utilizzare un CDN. Il vantaggio è una riduzione della latenza sia servendo il contenuto che terminando le connessioni più vicino all'utente finale. Ciò aiuta a mitigare la rapida evoluzione nella distribuzione dei protocolli e le ulteriori complessità nell'ottimizzazione di server e sistemi operativi (vedere la sezione [Prioritizzazione](#prioritizzazione) per maggiori dettagli). Per utilizzare i nuovi protocolli in modo efficace, l'utilizzo di un CDN può essere considerato l'approccio consigliato.

I CDN possono essere classificati in due ampie categorie: quelli che servono la home page e/o i asset subdomain e quelli che vengono utilizzati principalmente per fornire contenuti di terze parti. Esempi della prima categoria sono i CDN generici più grandi (come Cloudflare, Akamai o Fastly) e quelli più specifici (come WordPress o Netlify). Osservando la differenza nei tassi di adozione di HTTP/2 per le home page servite con o senza CDN, vediamo:

- **80%** delle home page per dispositivi mobile vengono servite su HTTP/2 se viene utilizzata una CDN
- **30%** delle home page per dispositivi mobile viene servite su HTTP/2 se non viene utilizzata una CDN

La Figura 22.12 mostra i CDN più specifici e moderni che servono una percentuale maggiore di traffico su HTTP/2.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="colgroup" class="no-wrap">HTTP/2 (%)</th>
        <th scope="colgroup">CDN</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>100%</td>
        <td>Bison Grid, CDNsun, LeaseWeb CDN, NYI FTW, QUIC.cloud, Roast.io, Sirv CDN, Twitter, Zycada Networks</td>
      </tr>
      <tr>
        <td>90 - 99%</td>
        <td>Automattic, Azion, BitGravity, Facebook, KeyCDN, Microsoft Azure, NGENIX, Netlify, Yahoo, section.io, Airee, BunnyCDN, Cloudflare, GoCache, NetDNA, SFR, Sucuri Firewall</td>
      </tr>
      <tr>
        <td>70 - 89%</td>
        <td>Amazon CloudFront, BelugaCDN, CDN, CDN77, Erstream, Fastly, Highwinds, OVH CDN, Yottaa, Edgecast, Myra Security CDN, StackPath, XLabs Security</td>
      </tr>
      <tr>
        <td>20 - 69%</td>
        <td>Akamai, Aryaka, Google, Limelight, Rackspace, Incapsula, Level 3, Medianova, OnApp, Singular CDN, Vercel, Cachefly, Cedexis, Reflected Networks, Universal CDN, Yunjiasu, CDNetworks</td>
      </tr>
      <tr>
        <td> < 20%</td>
        <td>Rocket CDN, BO.LT, ChinaCache, KINX CDN, Zenedge, ChinaNetCenter </td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentuale di richieste HTTP/2 servite dai CDN proprietari su dispositivi mobile.", sheets_gid="781660433", sql_file="cdn_detail_by_cdn.sql") }}</figcaption>
</figure>

I tipi di contenuto nella seconda categoria sono in genere risorse condivise (JavaScript o CDN di font), pubblicità o analisi. In tutti questi casi, l'utilizzo di una CDN migliorerà le prestazioni e l'offload per le varie soluzioni SaaS.

{{ figure_markup(
  image="http2-cdn-http2-usage.png",
  caption="Confronto dell'utilizzo di HTTP/2 e gQUIC per i siti Web che utilizzano un CDN.",
  description="Un grafico a linee che confronta la frazione di richieste servite utilizzando HTTP/2 o gQUIC per i siti web che utilizzano un CDN rispetto ai siti che non lo fanno. L'asse x mostra i percentili della pagina web ordinati per percentuale di richieste. Il 23% dei siti Web che non utilizzano un CDN non ha alcun utilizzo HTTP/2 o gQUIC. In confronto, il 60% dei siti Web che utilizzano un CDN ha tutto l'utilizzo di HTTP/2 o gQUIC. Il 93% dei siti Web che utilizzano una CDN e il 47% dei siti che non utilizzano CDN hanno il 50% o più di utilizzo HTTP/2 o gQUIC.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1779365083&format=interactive",
  sheets_gid="1457263817",
  sql_file="cdn_summary.sql"
)
}}

Nella Figura 22.13 possiamo vedere la netta differenza nell'adozione di HTTP/2 e gQUIC quando un sito web utilizza un CDN. Il 70% delle pagine utilizza HTTP/2 per tutte le richieste di terze parti quando viene utilizzata una CDN. Senza un CDN, solo il 25% delle pagine utilizza HTTP/2 per tutte le richieste di terze parti.

## Impatto HTTP/2

Misurare l'impatto delle prestazioni di un protocollo è difficile con l'attuale [approccio](./methodology) di HTTP Archive. Sarebbe davvero affascinante poter quantificare l'impatto delle connessioni simultanee, l'effetto della perdita di pacchetti e diversi meccanismi di controllo della congestione. Per confrontare realmente le prestazioni, ogni sito web dovrebbe essere sottoposto a scansione su ciascun protocollo in diverse condizioni di rete. Quello che possiamo fare invece è esaminare l'impatto sul numero di connessioni utilizzate da un sito web.

### Ridurre le connessioni

Come discusso [in precedenza](#da-http10-a-http2), HTTP/1.1 consente solo una singola richiesta alla volta su una connessione TCP. La maggior parte dei browser aggira questo problema consentendo sei connessioni parallele per host. Il principale miglioramento con HTTP/2 è che più richieste possono essere multiplexate su una singola connessione TCP. Ciò dovrebbe ridurre il numero totale di connessioni e il tempo e le risorse associate necessarie per caricare una pagina.

{{ figure_markup(
  image="http2-total-number-of-connections-per-page.png",
  caption="Distribuzione del numero totale di connessioni per pagina",
  description="Un grafico percentile delle connessioni totali, confrontando il 2016 con il 2020 su desktop. Il numero medio di connessioni nel 2016 è 23, nel 2020 è 13. Al 10° percentile, 6 connessioni nel 2016, 5 nel 2020. Al 25° percentile, 12 connessioni nel 2016, 8 nel 2020. Al 75° percentile - 43 connessioni nel 2016, 20 nel 2020. Al 90° percentile 76 connessioni nel 2016 e 33 nel 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=17394219&format=interactive",
  sheets_gid="1432183252",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
)
}}

La Figura 22.15 mostra come il numero di connessioni TCP per pagina si è ridotto nel 2020 rispetto al 2016. La metà di tutti i siti web ora utilizza 13 o meno connessioni TCP nel 2020 rispetto alle 23 connessioni nel 2016; una diminuzione del 44%. Nello stesso periodo di tempo il <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#reqTotal">numero mediano di richieste</a> è sceso solo da 74 a 73. Il numero medio di richieste per connessione TCP è aumentato da 3.2 a 5.6.

TCP è stato progettato per mantenere un flusso di dati medio che sia efficiente ed equo. Immagina un processo di controllo del flusso in cui ogni flusso esercita pressione e risponde a tutti gli altri flussi, per fornire una quota equa della rete. In un protocollo equo, ogni sessione TCP non esclude nessun'altra sessione e nel tempo richiederà 1/N della capacità del percorso.

La maggior parte dei siti Web apre ancora oltre 15 connessioni TCP. In HTTP/1.1, le sei connessioni che un browser potrebbe aprire a un dominio possono nel tempo richiedere una larghezza di banda sei volte maggiore rispetto a una singola connessione HTTP/2. Su reti a bassa capacità, ciò può rallentare la consegna del contenuto dai domini delle risorse primarie all'aumentare del numero di connessioni concorrenti e togliere la larghezza di banda dalle richieste importanti. Ciò favorisce i siti Web con un numero limitato di domini di terze parti.

HTTP/2 consente il <a hreflang="en" href="https://tools.ietf.org/html/rfc7540#section-9.1">riutilizzo della connessione</a> su domini diversi ma correlati. Per una risorsa TLS, richiede un certificato valido per l'host nell'URI. Questo può essere utilizzato per ridurre il numero di connessioni richieste per i domini sotto il controllo dell'autore del sito.

### Prioritizzazione

Poiché le risposte HTTP/2 possono essere suddivise in molti frame individuali e poiché i frame di più stream possono essere multiplexati, l'ordine in cui i frame vengono intercalati e consegnati dal server diventa una considerazione critica delle prestazioni. Un tipico sito Web è costituito da molti diversi tipi di risorse: il contenuto visibile (HTML, CSS, immagini), la logica dell'applicazione (JavaScript), annunci, analisi per il monitoraggio dell'utilizzo del sito e beacon di monitoraggio del marketing. Con la conoscenza di come funziona un browser, è possibile definire un ordinamento ottimale delle risorse che si tradurrà in un'esperienza utente più veloce. La differenza tra ottimale e non ottimale può essere significativa, fino a un miglioramento delle prestazioni del 50% o più!

HTTP/2 ha introdotto il concetto di prioritizzazione per aiutare il client a comunicare al server come ritiene debba essere eseguito il multiplexing. A ogni flusso viene assegnato un peso (la quantità di larghezza di banda disponibile che il flusso deve essere allocato) e possibilmente un genitore (un altro flusso che dovrebbe essere consegnato per primo). Con la flessibilità del modello di prioritizzazione di HTTP/2, non sorprende del tutto che tutti gli attuali motori di browser abbiano implementato <a hreflang="en" href="https://calendar.perfplanet.com/2018/http2-prioritization/">diverse strategie di assegnazione delle priorità</a>, nessuna delle quali <a hreflang="en" href="https://www.youtube.com/watch?v=nH4iRpFnf1c">ottimale</a>.

Ci sono anche problemi sul lato server, che portano a molti server che implementano la prioritizzazione in modo inadeguato o per niente. Nel caso di HTTP/1.x, l'ottimizzazione dei buffer di invio lato server in modo che siano il più grandi possibile non ha svantaggi, oltre all'aumento dell'uso della memoria (scambio di memoria per la CPU), ed è un modo efficace per aumentare il velocità effettiva di un server web. Questo non è vero per HTTP/2, poiché i dati nel buffer di invio TCP non possono essere ridefiniti se arriva una richiesta per una nuova risorsa più importante. Per un server HTTP/2, la dimensione ottimale del buffer di invio è quindi la minima quantità di dati necessari per utilizzare appieno la larghezza di banda disponibile. Ciò consente al server di rispondere immediatamente se viene ricevuta una richiesta con priorità più alta.

Questo problema di buffer di grandi dimensioni che interferiscono con la (ri)prioritizzazione esiste anche nella rete, dove viene chiamato "bufferbloat". Le apparecchiature di rete preferiscono bufferizzare i pacchetti piuttosto che rilasciarli quando si verifica un breve burst. Tuttavia, se il server invia più dati di quelli che il percorso al client può consumare, questi buffer si riempiono fino alla capacità. Questi byte già "memorizzati" sulla rete limitano la capacità del server di inviare prima una risposta con priorità più alta, proprio come fa un buffer di invio di grandi dimensioni. Per ridurre al minimo la quantità di dati contenuti nei buffer, <a hreflang="en" href="https://blog.cloudflare.com/http-2-prioritization-with-nginx/">un recente algoritmo di controllo della congestione come BBR dovrebbe essere utilizzato</a>.

Questa <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">test suite</a> gestita da Andy Davies misura e riporta le prestazioni di vari servizi di hosting CDN e cloud. La cattiva notizia è che solo 9 dei 36 servizi danno la priorità correttamente. La Figura 22.16 mostra che per i siti che utilizzano un CDN, circa il 31.7% non assegna correttamente le priorità. Questo è in aumento dal 26.82% dello scorso anno, principalmente a causa dell'aumento dell'utilizzo di Google CDN. Invece di dipendere sulle priorità inviate dal browser, ci sono alcuni server che implementano uno <a hreflang="en" href="https://blog.cloudflare.com/better-http-2-prioritization-for-a-faster-web/">schema di prioritizzazione lato server</a>, migliorando i suggerimenti del browser con logica aggiuntiva.

<figure>
  <table>
    <thead>
      <tr>
        <th>CDN</th>
        <th>Assegna la priorità <br>correttamente</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Non utilizzando CDN</td>
        <td>Unknown</td>
        <td class="numeric">59.47%</td>
        <td class="numeric">60.85%</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>Pass</td>
        <td class="numeric">22.03%</td>
        <td class="numeric">21.32%</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>Fail</td>
        <td class="numeric">8.26%</td>
        <td class="numeric">8.94%</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>Fail</td>
        <td class="numeric">2.64%</td>
        <td class="numeric">2.27%</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>Pass</td>
        <td class="numeric">2.34%</td>
        <td class="numeric">1.78%</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>Pass</td>
        <td class="numeric">1.31%</td>
        <td class="numeric">1.19%</td>
      </tr>
      <tr>
        <td>Automattic</td>
        <td>Pass</td>
        <td class="numeric">0.93%</td>
        <td class="numeric">1.05%</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>Fail</td>
        <td class="numeric">0.77%</td>
        <td class="numeric">0.63%</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>Fail</td>
        <td class="numeric">0.42%</td>
        <td class="numeric">0.34%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>Fail</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.20%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Supporto per prioritizzazione HTTP/2 nei CDN comuni.", sheets_gid="1152953475", sql_file="percentage_of_h2_and_h3_sites_affected_by_cdn_prioritization.sql") }}</figcaption>
</figure>

Per chi non utilizza CDN, ci aspettiamo che il numero di server che applicano correttamente la priorità HTTP/2 sia notevolmente inferiore. Ad esempio, l'implementazione HTTP/2 di NodeJS [non supporta l'assegnazione di priorità](https://x.com/jasnell/status/1245410283582918657).

### Addio server push?

Il server push era una delle funzionalità aggiuntive di HTTP/2 che causava confusione e complessità da implementare nella pratica. Il server push cerca di evitare di aspettare che un browser/client scarichi una pagina HTML, analizzi quella pagina e solo allora scopra che richiede risorse aggiuntive (come un foglio di stile), che a loro volta devono essere recuperate e analizzate per scoprire ancora più dipendenze (come i caratteri). Tutto quel lavoro e tutti quei viaggi richiedono tempo. Con il server push, in teoria, il server può semplicemente inviare più risposte contemporaneamente, evitando i round trip aggiuntivi.

Sfortunatamente, con il controllo della congestione TCP in gioco, il trasferimento dei dati inizia così lentamente che <a hreflang="en" href="https://calendar.perfplanet.com/2016/http2-push-the-details/">non tutte le risorse possono essere trasferite</a> fino a quando più round trip non hanno aumentato sufficientemente la velocità di trasferimento. Esistono anche <a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">differenze di implementazione</a> tra i browser poichè modello di elaborazione client non era stato completamente concordato. Ad esempio, ogni browser ha un'implementazione diversa di una _push cache_.

Un altro problema è che il server non è a conoscenza delle risorse che il browser ha già memorizzato nella cache. Quando un server tenta di eseguire il push di qualcosa che è indesiderato, il client può inviare un frame `RST_STREAM`, ma nel momento in cui ciò è accaduto, il server potrebbe aver già inviato tutti i dati. Ciò spreca larghezza di banda e il server perde l'opportunità di inviare immediatamente qualcosa che il browser effettivamente richiedeva. È stato <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-httpbis-cache-digest-05">proposto</a> di consentire ai client di informare il server del loro stato della cache, ma questi soffrivano di problemi di privacy.

Come si può vedere dalla Figura 20.17 di seguito, una percentuale molto piccola di siti utilizza il server push.

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>Pagine HTTP/2</th>
        <th>HTTP/2 (%)</th>
        <th>Pagine gQUIC</th>
        <th>gQUIC (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">44,257</td>
        <td class="numeric">0.85%</td>
        <td class="numeric">204</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">62,849</td>
        <td class="numeric">1.06%</td>
        <td class="numeric">326</td>
        <td class="numeric">0.06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Pagine che utilizzano il server push HTTP/2 o gQUIC.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

Analizzando ulteriormente le distribuzioni per le risorse trasferite nelle Figure 22.18 e 22.19, metà dei siti invia 4 o meno risorse con una dimensione totale di 140 KB su desktop e 3 o meno risorse con una dimensione di 184 KB su dispositivi mobili. Per gQUIC, il desktop è 7 o meno e il dispositivo mobile 2. La pagina più offensiva invia _41 asset_ su gQUIC sul desktop.

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>HTTP/2</th>
        <th>Dimensione (KB)</th>
        <th>gQUIC</th>
        <th>Dimensione (KB)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">1</td>
        <td class="numeric">3.95</td>
        <td class="numeric">1</td>
        <td class="numeric">15.83</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">2</td>
        <td class="numeric">36.32</td>
        <td class="numeric">3</td>
        <td class="numeric">35.93</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">4</td>
        <td class="numeric">139.58</td>
        <td class="numeric">7</td>
        <td class="numeric">111.96</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">8</td>
        <td class="numeric">346.70</td>
        <td class="numeric">21</td>
        <td class="numeric">203.59</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">17</td>
        <td class="numeric">440.08</td>
        <td class="numeric">41</td>
        <td class="numeric">390.91</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribuzione di asset inviati su desktop.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>HTTP/2</th>
        <th>Dimensione (KB)</th>
        <th>gQUIC</th>
        <th>Dimensione (KB)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">1</td>
        <td class="numeric">15.48</td>
        <td class="numeric">1</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">1</td>
        <td class="numeric">36.34</td>
        <td class="numeric">1</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">3</td>
        <td class="numeric">183.83</td>
        <td class="numeric">2</td>
        <td class="numeric">24.06</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">10</td>
        <td class="numeric">225.41</td>
        <td class="numeric">5</td>
        <td class="numeric">204.65</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">12</td>
        <td class="numeric">351.05</td>
        <td class="numeric">18</td>
        <td class="numeric">453.57</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribuzione di asset inviati su dispositivi mobile.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

Guardando la frequenza del push per tipo di contenuto nella Figura 22.20, vediamo che il 90% delle pagine invia script e il 56% invia CSS. Questo ha senso, poiché questi possono essere piccoli file in genere sul percorso critico per il rendering di una pagina.

{{ figure_markup(
  image="http2-pushed-content-types.png",
  caption="Percentuale di pagine che inviano tipi di contenuto specifici",
  description="Un grafico a barre che mostra le pagine che inviano le risorse sul desktop; 89.1% invia script, 67.9% CSS, 6.1% immagini, 1.3% caratteri, 0.7% altro e 0.7% HTML. Sui dispositivi mobile il 90.29% invia script, 56.08% CSS, 3.69% immagini, 0.97% caratteri, 0.36% altro e 0.39% HTML.", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1708672642&format=interactive",
  sheets_gid="238923402",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_by_content_type.sql"
)
}}

Data la bassa adozione e dopo aver misurato quante poche delle risorse trasferite sono effettivamente utili (ovvero corrispondono a una richiesta che non è già memorizzata nella cache), Google ha annunciato <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ">l'intento di rimuovere il supporto push da Chrome</a> sia per HTTP/2 che per gQUIC. Chrome non ha inoltre implementato il push per HTTP/3.

Nonostante tutti questi problemi, ci sono circostanze in cui il server push può fornire un miglioramento. Il caso d'uso ideale è essere in grado di inviare una promessa push molto prima della risposta HTML stessa. Uno scenario in cui questo può trarre vantaggio è <a hreflang="en" href="https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317" >quando una CDN è in uso</a>. Il "tempo morto" tra il CDN che riceve la richiesta e la ricezione di una risposta dall'origine può essere utilizzato in modo intelligente per riscaldare la connessione TCP e inviare gli asset già memorizzati nella cache del CDN.

Tuttavia, non esisteva un metodo standardizzato per segnalare a un CDN edge server che un asset doveva essere inviato. Le implementazioni invece hanno riutilizzato l'intestazione del link HTTP precaricato per indicarlo. Questo semplice approccio sembra elegante, ma non utilizza il tempo morto prima che l'HTML venga generato a meno che le intestazioni non vengano inviate prima che il contenuto effettivo sia pronto.

Una proposta alternativa in fase di test è la <a hreflang="en" href="https://tools.ietf.org/html/rfc8297">RFC 8297</a>, che definisce una risposta informativa `103 (Early Hints)`. Ciò consente l'invio immediato delle intestazioni, senza dover attendere che il server generi le intestazioni di risposta complete. Questo può essere utilizzato da un'origine per suggerire risorse inviate a un CDN o da un CDN per avvisare il client delle risorse che devono essere recuperate. Tuttavia, al momento, il supporto per questo sia dal punto di vista del client che del server è molto basso, <a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">ma in crescita</a>.

## Raggiungere un protocollo migliore

Supponiamo che un client e un server supportino sia HTTP/1.1 che HTTP/2. Come scelgono quale usare? Il metodo più comune è TLS [Application Layer Protocol Negotiation](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) (ALPN), in cui i client inviano un elenco di protocolli che supportano al server, che sceglie quello che preferisce utilizzare per quella connessione. Poiché il browser deve negoziare i parametri TLS come parte della configurazione di una connessione HTTPS, può allo stesso tempo anche negoziare la versione HTTP. Poiché sia HTTP/2 che HTTP/1.1 possono essere serviti dalla stessa porta TCP (443), i browser non devono effettuare questa selezione prima di aprire una connessione.

Questo non funziona se i protocolli non sono sulla stessa porta, utilizza un protocollo di trasporto diverso (TCP rispetto a QUIC) o se non stai utilizzando TLS. Per questi scenari, inizi con tutto ciò che è disponibile sulla prima porta a cui ti connetti, quindi scopri altre opzioni. HTTP definisce due meccanismi per cambiare i protocolli per un'origine dopo la connessione: `Upgrade` e `Alt-Svc`.

### `Upgrade`

L'intestazione Upgrade fa parte di HTTP da molto tempo. In HTTP/1.x, `Upgrade` consente a un client di effettuare una richiesta utilizzando un protocollo, ma indica il suo supporto per un altro protocollo (come HTTP/2). Se il server supporta anche il protocollo offerto, risponde con uno stato 101 (`Switching Protocols`) e procede a rispondere alla richiesta nel nuovo protocollo. In caso contrario, il server risponde alla richiesta in HTTP/1.x. I server possono pubblicizzare il loro supporto di un protocollo diverso usando un'intestazione `Upgrade` su una risposta.

L'applicazione più comune di `Upgrade` è [WebSockets](https://developer.mozilla.org/docs/Web/API/WebSockets_API). HTTP/2 definisce anche un percorso `Upgrade`, da usare con la sua modalità di testo non crittografato. Tuttavia, non è disponibile alcun supporto per questa funzionalità nei browser web. Pertanto, non sorprende che meno del 3% delle richieste HTTP/1.1 in chiaro nel nostro set di dati abbia ricevuto un'intestazione `Upgrade` nella risposta. Un numero molto piccolo di richieste che utilizzano TLS (0.0011% di HTTP/2, 0.064% di HTTP/1.1) ha ricevuto anche le intestazioni `Upgrade` in risposta; questi sono probabilmente server HTTP/1.1 in chiaro dietro intermediari che parlano HTTP/2 e/o terminano TLS, ma non rimuovono correttamente le intestazioni `Upgrade`.

### Alternative Services

Alternative Services (`Alt-Svc`) abilita un'origine HTTP per indicare altri endpoint che servono lo stesso contenuto, possibilmente su protocolli diversi. Anche se è raro, HTTP/2 potrebbe trovarsi su una porta diversa o su un host diverso dal servizio HTTP/1.1 di un sito. Ancora più importante, poiché HTTP/3 utilizza QUIC (quindi UDP) dove le versioni precedenti di HTTP utilizzano TCP, HTTP/3 si troverà sempre su un endpoint diverso dal servizio HTTP/1.x e HTTP/2.

Quando si usa `Alt-Svc`, un client effettua le richieste all'origine come di consueto. Tuttavia, se il server include un'intestazione o invia un frame contenente un elenco di alternative, il client può stabilire una nuova connessione all'altro endpoint e utilizzarlo per richieste future a tale origine.

Non sorprende che l'utilizzo di `Alt-Svc` venga rilevato quasi interamente da servizi che utilizzano versioni HTTP avanzate: Il 12.0% delle richieste HTTP/2 e il 60.1% delle richieste gQUIC hanno ricevuto un'intestazione `Alt-Svc` in risposta, rispetto allo 0.055% delle richieste HTTP/1.x. Nota che la nostra metodologia qui cattura solo le intestazioni `Alt-Svc`, non i frame `ALTSVC` in HTTP/2, quindi la realtà potrebbe essere leggermente sottovalutata.

Sebbene `Alt-Svc` possa puntare a un host completamente diverso, il supporto per questa funzionalità varia a seconda dei browser. Solo il 4.71% delle intestazioni `Alt-Svc` pubblicizzava un endpoint su un nome host diverso; Si trattava di pubblicità (99.5%) quasi universalmente supportata da gQUIC e HTTP/3 su Google Ads. Google Chrome ignora gli annunci `Alt-Svc` cross-host per HTTP/2, quindi molte delle altre istanze sarebbero state ignorate.

Data la rarità del supporto per HTTP/2 cross-host, non sorprende che non ci fossero praticamente (0.007%) annunci per endpoint HTTP/2 che utilizzavano `Alt-Svc`. `Alt-Svc` veniva usato tipicamente per indicare il supporto per HTTP/3 (74.6% delle intestazioni `Alt-Svc`) o gQUIC (38.7% delle intestazioni `Alt-Svc`).

## Guardando al futuro: HTTP/3

HTTP/2 è un protocollo potente, che ha trovato una notevole adozione in pochi anni. Tuttavia, HTTP/3 su QUIC è già dietro l'angolo! In quattro anni di lavoro, questa prossima versione di HTTP è quasi standardizzata all'IETF (prevista nella prima metà del 2021). Al momento, sono già disponibili <a hreflang="en" href="https://github.com/quicwg/base-drafts/wiki/Implementations">molte implementazioni QUIC e HTTP/3</a>, entrambe per server e browser. Sebbene siano relativamente maturi, si può ancora dire che siano in uno stato sperimentale.

Ciò si riflette nei numeri di utilizzo nei dati del HTTP Archive, dove non sono state identificate richieste HTTP/3. Potrebbe sembrare un po' strano, dal momento che <a hreflang="en" href="https://blog.cloudflare.com/experiment-with-http-3-using-nginx-and-quiche/">Cloudflare</a> ha avuto per un po' di tempo il supporto HTTP/3 sperimentale, così come Google e Facebook. Ciò è dovuto principalmente al fatto che Chrome non aveva abilitato il protocollo per impostazione predefinita quando sono stati raccolti i dati.

Tuttavia, anche i numeri per il vecchio gQUIC sono relativamente modesti, rappresentando meno del 2% delle richieste complessive. Questo è previsto, poiché gQUIC è stato distribuito principalmente da Google e Akamai; altre parti stavano aspettando IETF QUIC. In quanto tale, si prevede che gQUIC sarà presto sostituito interamente da HTTP/3.

{{ figure_markup(
  caption="La percentuale di richieste che utilizzano gQUIC su desktop e dispositivi mobile",
  content="1.72%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

È importante notare che questa bassa adozione riflette solo l'utilizzo di gQUIC e HTTP/3 per il caricamento delle pagine Web. Già da diversi anni, Facebook ha implementato una distribuzione molto più ampia di IETF QUIC e HTTP/3 per il caricamento dei dati all'interno delle sue applicazioni native. <a hreflang="en" href="https://engineering.fb.com/2020/10/21/networking-traffic/how-facebook-is-bringing-quic-to-billions/">QUIC e HTTP/3 rappresentano già oltre il 75% del loro traffico Internet totale</a>. È chiaro che HTTP/3 è solo all'inizio!

Ora potresti chiederti: se non tutti usano già HTTP/2, perché avremmo bisogno di HTTP/3 così presto? Quali benefici possiamo aspettarci nella pratica? Diamo uno sguardo più da vicino ai suoi meccanismi interni.

### QUIC e HTTP/3

I tentativi passati di implementare nuovi protocolli di trasporto su Internet si sono rivelati difficili, ad esempio [Stream Control Transmission Protocol](https://it.wikipedia.org/wiki/Stream_Control_Transmission_Protocol) (SCTP). QUIC è un nuovo protocollo di trasporto che viene eseguito su UDP. Fornisce funzionalità simili a TCP, come la consegna in ordine affidabile e il controllo della congestione per prevenire l'inondazione della rete.

Come discusso nella sezione [Da HTTP/1.0 a HTTP/2](#da-http10-a-http2), HTTP/2 _multiplex_ più flussi diversi su una connessione. Il TCP stesso è tristemente inconsapevole di questo fatto, portando a inefficienze o un impatto sulle prestazioni quando si verificano perdite di pacchetti o ritardi. Maggiori dettagli su questo problema, noto come _head-of-line blocking_ (blocco HOL), <a hreflang="en" href="https://github.com/rmarx/holblocking-blogpost">possono essere trovati qui</a>.

QUIC risolve il problema del blocco HOL portando i flussi HTTP/2 nel livello di trasporto ed eseguendo il rilevamento e la ritrasmissione della perdita per flusso. Quindi abbiamo semplicemente messo HTTP/2 su QUIC, giusto? Bene, abbiamo [già menzionato](#ridurre-le-connessioni) alcune delle difficoltà derivanti dal controllo del flusso in TCP e HTTP/2. L'esecuzione di due sistemi di streaming separati e concorrenti l'uno sull'altro sarebbe un problema aggiuntivo. Inoltre, poiché i flussi QUIC sono indipendenti, interferirebbe con i severi requisiti di ordinazione richiesti da HTTP/2 per molti dei suoi sistemi.

Alla fine, è stato ritenuto più facile definire una nuova versione HTTP che utilizzi direttamente QUIC e quindi è nato HTTP/3. Le sue funzionalità di alto livello sono molto simili a quelle che conosciamo da HTTP/2, ma i meccanismi di implementazione interna sono abbastanza diversi. La compressione dell'intestazione HPACK viene sostituita con <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-quic-qpack-19">QPACK</a>, che consente <a hreflang="en" href="https://blog.litespeedtech.com/tag/quic-header-compression-design-team/">la regolazione manuale</a> dell'efficienza di compressione rispetto al compromesso del rischio del blocco HOL e il sistema di prioritizzazione viene <a hreflang="en" href="https://blog.cloudflare.com/adopting-a-new-approach-to-http-prioritization/">sostituito da uno più semplice</a>. Quest'ultimo potrebbe anche essere trasferito su HTTP/2, forse aiutando a risolvere i problemi di prioritizzazione discussi in precedenza in questo articolo. HTTP/3 continua a fornire un meccanismo push del server, ma Chrome, ad esempio, non lo implementa.

Un altro vantaggio di QUIC è che è in grado di migrare le connessioni e mantenerle attive anche quando la rete sottostante cambia. Un tipico esempio è il cosiddetto "problema del parcheggio". Immagina che il tuo smartphone sia connesso alla rete Wi-Fi del luogo di lavoro e che tu abbia appena iniziato a scaricare un file di grandi dimensioni. Quando esci dal raggio di copertura del Wi-Fi, il tuo telefono passa automaticamente alla nuova fantastica rete cellulare 5G. Con il semplice vecchio TCP, la connessione si interromperà e causerebbe un'interruzione. Ma QUIC è più intelligente; utilizza un _connection ID_, che è più robusto per le modifiche alla rete, e fornisce una funzione attiva di _connection migration_ per consentire ai client di passare senza interruzioni.

Infine, TLS è già utilizzato per proteggere HTTP/1.1 e HTTP/2. QUIC, tuttavia, ha una profonda integrazione di TLS 1.3, proteggendo sia i dati HTTP/3 che i metadati dei pacchetti QUIC, come i numeri dei pacchetti. L'utilizzo di TLS in questo modo migliora la privacy e la sicurezza degli utenti finali e semplifica l'evoluzione continua del protocollo. La combinazione del trasporto e dell'handshake crittografico significa che la configurazione della connessione richiede solo un singolo RTT, rispetto al minimo di due e al caso peggiore di quattro di TCP. In alcuni casi, QUIC può anche fare un ulteriore passo avanti e inviare dati HTTP insieme al suo primo messaggio, che si chiama _0-RTT_. Si prevede che questi tempi di configurazione delle connessioni rapidi aiuteranno davvero HTTP/3 a superare HTTP/2.

**Quindi, HTTP/3 aiuterà?**

In breve, HTTP/3 non è poi così diverso da HTTP/2. Non aggiunge funzionalità importanti, ma cambia principalmente il modo in cui quelle esistenti funzionano sotto la superficie. I veri miglioramenti provengono da QUIC, che offre configurazioni di connessione più veloci, maggiore robustezza e resilienza alla perdita di pacchetti. In quanto tale, HTTP/3 dovrebbe funzionare meglio di HTTP/2 su reti peggiori, offrendo prestazioni molto simili su sistemi più veloci. Tuttavia, questo è se la comunità web può far funzionare HTTP/3, il che può essere impegnativo nella pratica.

### Distribuzione e rilevamento di HTTP/3

Poiché QUIC e HTTP/3 vengono eseguiti su UDP, le cose non sono così semplici come con HTTP/1.1 o HTTP/2. In genere, un client HTTP/3 deve prima scoprire che QUIC è disponibile sul server. Il metodo consigliato per questo è [HTTP Alternative Services](#alternative-services). Alla sua prima visita a un sito Web, un client si connette a un server utilizzando TCP. Quindi scopre tramite `Alt-Svc` che HTTP/3 è disponibile e può impostare una nuova connessione QUIC. La voce `Alt-Svc` può essere messa in cache, consentendo alle visite successive di evitare il passaggio TCP, ma alla fine la voce diventerà obsoleta e dovrà essere riconvalidata. Questo probabilmente dovrà essere fatto per ogni dominio separatamente, il che probabilmente porterà alla maggior parte dei caricamenti di pagina utilizzando una combinazione di HTTP/1.1, HTTP/2 e HTTP/3.

Tuttavia, anche se è noto che un server supporta QUIC e HTTP/3, la rete in mezzo potrebbe bloccarlo. Il traffico UDP è comunemente utilizzato negli attacchi DDoS e bloccato per impostazione predefinita, ad esempio, in molte reti aziendali. Sebbene si possano fare eccezioni per QUIC, la sua crittografia rende difficile per i firewall valutare il traffico. Ci sono potenziali soluzioni a questi problemi, ma nel frattempo ci si aspetta che QUIC abbia maggiori probabilità di avere successo su porte ben note come 443. Ed è possibile che si sia bloccato QUIC del tutto. In pratica, i client useranno probabilmente meccanismi sofisticati per ripiegare su TCP se QUIC fallisce. Un'opzione è "gareggiare" sia con una connessione TCP che QUIC e utilizzare quella che viene completata per prima.

È in corso un lavoro per definire i modi per scoprire HTTP/3 senza la necessità del passaggio TCP. Questa dovrebbe essere considerata un'ottimizzazione, tuttavia, poiché è probabile che i problemi di blocco UDP significhino che l'HTTP basato su TCP si attacca. Il <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-dnsop-svcb-https">record DNS HTTPS</a> è simile ai Alternative Services HTTP e ad alcuni CDN stanno già <a hreflang="en" href="https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/">sperimentando questi record</a>. Nel lungo termine, quando la maggior parte dei server offre HTTP/3, i browser potrebbero passare a tentarlo per impostazione predefinita; ci vorrà molto tempo.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">HTTP/1.x</th>
        <th scope="colgroup" colspan="2">HTTP/2</th>
      </tr>
      <tr>
        <th scope="col">Versione TLS</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>unknown</td>
        <td class="numeric">4.06%</td>
        <td class="numeric">4.03%</td>
        <td class="numeric">5.05%</td>
        <td class="numeric">7.28%</td>
      </tr>
      <tr>
        <td>TLS 1.2</td>
        <td class="numeric">26.56%</td>
        <td class="numeric">24.75%</td>
        <td class="numeric">23.12%</td>
        <td class="numeric">23.14%</td>
      </tr>
      <tr>
        <td>TLS 1.3</td>
        <td class="numeric">5.25%</td>
        <td class="numeric">5.11%</td>
        <td class="numeric">35.78%</td>
        <td class="numeric">35.54%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adozione di TLS dalla versione HTTP.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

QUIC dipende da TLS 1.3, utilizzato per circa il 41% delle richieste, come mostrato nella Figura 22.21. Ciò lascia il 59% delle richieste che dovranno aggiornare il proprio stack TLS per supportare HTTP/3.

### HTTP/3 è già pronto?

Quindi, quando possiamo iniziare a utilizzare HTTP/3 e QUIC per davvero? Non ancora, ma si spera presto. Esiste un <a hreflang="en" href="https://github.com/quicwg/base-drafts/wiki/Implementations">gran numero di implementazioni open source mature</a> e i principali browser hanno un supporto sperimentale. Tuttavia, la maggior parte dei server tipici ha subito alcuni ritardi: nginx è un po' indietro rispetto agli altri stack, Apache non ha annunciato il supporto ufficiale e NodeJS si affida a OpenSSL, che <a hreflang="en" href="https://github.com/openssl/openssl/pull/8797">non aggiungerà presto il supporto QUIC</a>. Anche così, prevediamo un aumento delle distribuzioni HTTP/3 e QUIC per tutto il 2021.

HTTP/3 e QUIC sono protocolli altamente avanzati con potenti funzionalità di sicurezza e prestazioni, come un nuovo sistema di prioritizzazione HTTP, rimozione del blocco HOL e creazione di connessioni 0-RTT. Questa raffinatezza li rende anche difficili da distribuire e utilizzare correttamente, come è risultato essere il caso di HTTP/2. Prevediamo che le prime distribuzioni avverranno principalmente tramite l'adozione anticipata di CDN come Cloudflare, Fastly e Akamai. Ciò probabilmente significherà che gran parte del traffico HTTP/2 può e sarà aggiornato automaticamente a HTTP/3 nel 2021, dando al nuovo protocollo una grande quota di traffico quasi fuori dagli schemi. Quando e se le distribuzioni più piccole seguiranno l'esempio è più difficile rispondere. Molto probabilmente, continueremo a vedere un sano mix di HTTP/3, HTTP/2 e persino HTTP/1.1 sul Web negli anni a venire.

## Conclusione

Quest'anno HTTP/2 è diventato il protocollo dominante, servendo il 64% di tutte le richieste, essendo cresciuto di 10 punti percentuali durante l'anno. Le home page hanno registrato un aumento del 13% nell'adozione di HTTP/2, portando a una divisione uniforme delle pagine servite su HTTP/1.1 e HTTP/2. L'utilizzo di una CDN per servire la tua home page spinge l'adozione di HTTP/2 fino all'80%, rispetto al 30% per chi non utilizza CDN. Rimangono alcuni server meno recenti, Apache e IIS, che si stanno dimostrando resistenti all'aggiornamento a HTTP/2 e TLS. Un grande successo è stata la diminuzione dell'utilizzo della connessione al sito Web a causa del multiplexing della connessione HTTP/2. Il numero mediano di connessioni nel 2016 è stato di 23 rispetto ai 13 nel 2020.

La prioritizzazione HTTP/2 e il server push si sono rivelati molto più complessi da distribuire in generale. In determinate implementazioni mostrano chiari vantaggi in termini di prestazioni. Esiste, tuttavia, un ostacolo significativo alla distribuzione e all'ottimizzazione dei server esistenti per utilizzare queste funzionalità in modo efficace. Esiste ancora un'ampia percentuale di CDN che non supporta efficacemente la definizione delle priorità. Ci sono stati anche problemi con il supporto coerente del browser.

HTTP/3 è proprio dietro l'angolo. Sarà affascinante seguire il tasso di adozione, vedere come si evolvono i meccanismi e scoprire quali nuove funzionalità verranno implementate con successo. Ci aspettiamo che il Web Almanac del prossimo anno veda alcuni nuovi dati interessanti.
