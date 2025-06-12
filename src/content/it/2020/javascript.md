---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: Capitolo JavaScript del Web Almanac 2020 che copre quanto JavaScript utilizziamo sul Web, compressione, librerie e framework, caricamento e mappe di origine.
hero_alt: Hero image of the Web Almanac characters cycling to power a website.
authors: [tkadlec]
reviewers: [ibnesayeed, denar90]
analysts: [rviscomi, paulcalvano]
editors: [rviscomi]
translators: [chefleo]
tkadlec_bio: Tim è un consulente e formatore di prestazioni web focalizzato sulla creazione di un web che tutti possano utilizzare. È autore di High Performance Images (O'Reilly, 2016) e Implementing Responsive Design (New Riders, 2012). Scrive di tutto ciò che riguarda il Web su <a hreflang="en" href="https://timkadlec.com/">timkadlec.com</a>. Puoi trovarlo mentre condivide i suoi pensieri in un formato più breve su Twitter <a href="https://x.com/tkadlec">@tkadlec</a>.
discuss: 2038
results: https://docs.google.com/spreadsheets/d/1cgXJrFH02SHPKDGD0AelaXAdB3UI7PIb5dlS0dxVtfY/
featured_quote: JavaScript ha fatto molta strada dalle sue umili origini come l'ultimo dei tre capisaldi del web, insieme a CSS e HTML. Oggi JavaScript ha iniziato a infiltrarsi in un ampio spettro dello stack tecnico. Non è più limitato al lato client ed è una scelta sempre più popolare per gli strumenti di compilazione e lo scripting lato server. JavaScript si sta facendo strada anche nel livello CDN grazie alle soluzioni di edge computing.
featured_stat_1: 1,897ms
featured_stat_label_1: Tempo mediano del thread principale JS su dispositivo mobile
featured_stat_2: 37.22%
featured_stat_label_2: Percentuale di JS inutilizzati su dispositivi mobili
featured_stat_3: 12.2%
featured_stat_label_3: Percentuale di script caricati in modo asincrono
---

## Introduzione

JavaScript ha fatto molta strada dalle sue umili origini come l'ultimo dei tre capisaldi del web, insieme a CSS e HTML. Oggi JavaScript ha iniziato a infiltrarsi in un ampio spettro dello stack tecnico. Non è più limitato al lato client ed è una scelta sempre più popolare per gli strumenti di compilazione e lo scripting lato server. JavaScript si sta facendo strada anche nel livello CDN grazie alle soluzioni di edge computing.

Gli sviluppatori adorano un po' di JavaScript. Secondo il capitolo Markup, l'elemento `script` è il [sesto elemento HTML più popolare](./markup) in uso (prima di elementi come `p` e `i`, tra innumerevoli altri). Spendiamo circa 14 volte più byte su HTML rispetto a HTML, l'elemento costitutivo del Web, e 6 volte più byte rispetto a CSS.

{{ figure_markup(
  image="../page-weight/bytes-distribution-content-type.png",
  caption="Peso medio della pagina per tipo di contenuto.",
  description="Grafico a barre che mostra il peso medio della pagina per le pagine desktop e per dispositivi mobili tra immagini, JS, CSS e HTML. Le quantità mediane di byte per ogni tipo di contenuto sulle pagine per dispositivi mobili sono: 916 KB di immagini, 411 KB di JS, 62 KB di CSS e 25 KB di HTML. Le pagine desktop tendono ad avere immagini molto più pesanti (circa 1000 KB) e quantità leggermente superiori di JS (circa 450 KB).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=1147150650&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1wG4u0LV5PT9aN-XB1hixSFtI8KIDARTOCX0sp7ZT3h0/#378779486",
  sql_file="../page-weight/bytes_per_type_2020.sql"
) }}

Ma niente è gratuito, e questo è particolarmente vero per JavaScript: tutto quel codice ha un costo. Approfondiamo e diamo un'occhiata più da vicino a quanto script usiamo, come lo usiamo e quali sono le conseguenze.

## Quanto JavaScript utilizziamo?

Abbiamo detto che il tag `script` è il sesto elemento HTML più utilizzato. Analizziamo un po' più a fondo per vedere quanto JavaScript effettivamente ammonta.

Il sito mediano (il 50° percentile) invia 444 KB di JavaScript quando viene caricato su un dispositivo desktop e leggermente meno (411 KB) a un dispositivo mobile.

{{ figure_markup(
  image="bytes-2020.png",
  caption="Distribuzione della quantità di kilobyte JavaScript caricati per pagina.",
  description="Grafico a barre che mostra la distribuzione dei byte JavaScript per pagina di circa il 10%. Le pagine desktop caricano costantemente più byte JavaScript rispetto alle pagine mobile. Il 10°, 25°, 50°, 75° e 90° percentile per desktop sono: 87 KB, 209 KB, 444 KB, 826 KB e 1.322 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=441749673&format=interactive",
  sheets_gid="2139688512",
  sql_file="bytes_2020.sql"
) }}

È un po' deludente che qui non ci sia un divario maggiore. Sebbene sia pericoloso fare troppe ipotesi sulla rete o sulla potenza di elaborazione in base al fatto che il dispositivo in uso sia un telefono o un desktop (o una via di mezzo), vale la pena notare che [Test mobile di HTTP Archive](./methodology#webpagetest) vengono eseguiti emulando un Moto G4 e una rete 3G. In altre parole, se ci fosse del lavoro da fare per adattarsi a circostanze tutt'altro che ideali passando meno codice, questi test dovrebbero mostrarlo.

La tendenza sembra anche essere a favore dell'utilizzo di più JavaScript, non di meno. Confrontando con [i risultati dell'anno scorso](../2019/javascript#how-much-javascript-do-we-use), alla mediana vediamo un aumento del 13.4% in JavaScript testato su un dispositivo desktop e un 14.4% aumento della quantità di JavaScript inviato a un dispositivo mobile.

<figure>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>2019</th>
        <th>2020</th>
        <th>Variazione</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">391</td>
        <td class="numeric">444</td>
        <td class="numeric">13.4%</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">359</td>
        <td class="numeric">411</td>
        <td class="numeric">14.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Variazione anno su anno del numero mediano di kilobyte JavaScript per pagina.",
      sheets_gid="86213362",
      sql_file="bytes_2020.sql"
    ) }}
  </figcaption>
</figure>

Almeno una parte di questo peso sembra non essere necessaria. Se esaminiamo una ripartizione di quanto di quel JavaScript è inutilizzato su un dato caricamento della pagina, vediamo che la pagina mediana sta inviando 152 KB di JavaScript inutilizzato. Quel numero salta a 334 KB al 75° percentile e 567 KB al 90° percentile.

{{ figure_markup(
  image="unused-js-bytes-distribution.png",
  caption="Distribuzione della quantità di byte JavaScript sprecati per pagina mobile.",
  description="Grafico a barre che mostra la distribuzione della quantità di byte JavaScript sprecati per pagina. Dal 10, 25, 50, 75 e 90° percentile, la distribuzione va: 0, 57, 153, 335 e 568 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=773002950&format=interactive",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

Come numeri grezzi, quelli possono o meno saltarti fuori a seconda di quanto sei un fanatico delle prestazioni, ma quando lo guardi come percentuale del totale JavaScript utilizzato su ciascuna pagina, diventa un po' più facile vedere quanto sprechiamo.

{{ figure_markup(
  caption="Percentuale di byte JavaScript della pagina per dispositivi mobile mediana non utilizzati.",
  content="37.22%",
  classes="big-number",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

Quei 153 KB equivalgono a circa il 37% della dimensione totale dello script che inviamo ai dispositivi mobile. C'è sicuramente un margine di miglioramento qui.

### `module` e `nomodule`
Un meccanismo che abbiamo per ridurre potenzialmente la quantità di codice che inviamo è quello di sfruttare il <a hreflang="en" href="https://web.dev/serve-modern-code-to-modern-browsers/">pattern `module`/`nomodule`</a>. Con questo pattern, creiamo due set di bundle: un bundle destinato ai browser moderni e uno destinato ai browser legacy. Il bundle destinato ai browser moderni ottiene un `type=module` e il bundle destinato ai browser legacy ottiene un `type=nomodule`.

Questo approccio ci consente di creare bundle più piccoli con una sintassi moderna ottimizzata per i browser che lo supportano, fornendo al contempo polyfill caricati in modo condizionale e sintassi diversa per i browser che non lo supportano.

Il supporto per `module` e `nomodule` si sta espandendo, ma ancora relativamente nuovo. Di conseguenza, l'adozione è ancora un po' bassa. Solo il 3.6% delle pagine mobile utilizza almeno uno script con `type=module` e solo lo 0.7% delle pagine mobile utilizza almeno uno script con `type=nomodule` per supportare i browser legacy.

### Conteggio richieste

Un altro modo per vedere quanto JavaScript utilizziamo è esplorare quante richieste JavaScript vengono effettuate su ogni pagina. Sebbene la riduzione del numero di richieste fosse fondamentale per mantenere buone prestazioni con HTTP/1.1, con HTTP/2 è il caso opposto: suddividere JavaScript in <a hreflang="en" href="https://web.dev/granular-chunking-nextjs/">file singoli più piccoli</a> è [in genere migliore per le prestazioni](../2019/http#impact-of-http2).

{{ figure_markup(
  image="requests-2020.png",
  caption="Distribuzione delle richieste JavaScript per pagina.",
  description="Grafico a barre che mostra la distribuzione delle richieste JavaScript per pagina nel 2020. I percentili 10, 25, 50, 75 e 90 per le pagine per dispositivi mobili sono: 4, 10, 19, 34 e 55. Le pagine desktop tendono ad avere solo 0 o 1 più richieste JavaScript per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=153746548&format=interactive",
  sheets_gid="1804671297",
  sql_file="requests_2020.sql"
) }}

Alla mediana, le pagine fanno 20 richieste JavaScript. Questo è solo un piccolo aumento rispetto allo scorso anno, quando la pagina mediana ha effettuato 19 richieste JavaScript.

{{ figure_markup(
  image="requests-2019.png",
  caption="Distribuzione delle richieste JavaScript per pagina nel 2019.",
  description="Grafico a barre che mostra la distribuzione delle richieste JavaScript per pagina nel 2019. I percentili 10, 25, 50, 75 e 90 per le pagine per dispositivi mobili sono: 4, 9, 18, 32 e 52. Simile ai risultati del 2020, solo per le pagine desktop tendono ad avere 0 o 1 richiesta in più per pagina. Questi risultati sono leggermente inferiori ai risultati del 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=528431485&format=interactive",
  sheets_gid="1983394384",
  sql_file="requests_2019.sql"
) }}

## Da dove viene?

Una tendenza che probabilmente contribuisce all'aumento di JavaScript utilizzato sulle nostre pagine è la quantità apparentemente crescente di script di terze parti che vengono aggiunti alle pagine per aiutare con tutto, dai test A/B lato client e analisi, alla pubblicazione di annunci e gestione della personalizzazione.

Analizziamolo un po' per vedere quanto script di terze parti stiamo servendo.

In media, i siti servono all'incirca lo stesso numero di script di prima parte di quelli di terze parti. Nella mediana, 9 script per pagina sono di prima parte, rispetto ai 10 per pagina di terze parti. Da lì, il divario si allarga un po': più script un sito serve in totale, più è probabile che la maggior parte di quegli script provenga da terze parti.

{{ figure_markup(
  image="requests-by-3p-desktop.png",
  caption="Distribuzione del numero di richieste JavaScript da host per desktop.",
  description="Grafico a barre che mostra la distribuzione delle richieste JavaScript per host per desktop. I 10, 25, 50, 75 e 90° percentile per le richieste di prima parte sono: 2, 4, 9, 17 e 30 richieste per pagina. Il numero di richieste di terze parti per pagina è leggermente superiore nei percentili superiori da 1 a 6 richieste.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1566679225&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

{{ figure_markup(
  image="requests-by-3p-mobile.png",
  caption="Distribuzione del numero di richieste JavaScript da parte dell'host per dispositivi mobile.",
  description="Grafico a barre che mostra la distribuzione delle richieste JavaScript per host per dispositivi mobile. I percentili 10, 25, 50, 75 e 90 per le richieste di prima parte sono: 2, 4, 9, 17 e 30 richieste per pagina. Questo è lo stesso del desktop. Il numero di richieste di terze parti per pagina è leggermente superiore nei percentili superiori da 1 a 5 richieste, simile al desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1465647946&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

Sebbene la quantità di richieste JavaScript sia simile alla mediana, la dimensione effettiva di quegli script è ponderata (gioco di parole) un po' più pesantemente verso fonti di terze parti. Il sito mediano invia 267 KB di JavaScript da terze parti ai dispositivi desktop, rispetto ai 147 KB delle prime parti. La situazione è molto simile sui dispositivi mobile, dove il sito mediano spedisce 255 KB di script di terze parti rispetto ai 134 KB di script di prima parte.

{{ figure_markup(
  image="bytes-by-3p-desktop.png",
  caption="Distribuzione del numero di byte JavaScript per host per desktop.",
  description="Grafico a barre che mostra la distribuzione dei byte JavaScript per host per desktop. I percentili 10, 25, 50, 75 e 90 per i byte di prima parte sono: 21, 67, 147, 296 e 599 KB per pagina. Il numero di richieste di terze parti per pagina aumenta notevolmente nei percentili superiori fino a 343 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1749995505&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

{{ figure_markup(
  image="bytes-by-3p-mobile.png",
  caption="Distribuzione del numero di byte JavaScript per host per dispositivi mobile.",
  description="Grafico a barre che mostra la distribuzione dei byte JavaScript per host per dispositivi mobili. I 10, 25, 50, 75 e 90° percentile per i byte di prima parte sono: 18, 60, 134, 275 e 560 KB. Questi valori sono costantemente inferiori ai valori del desktop, ma solo di 10-30 KB. Simile al desktop, i byte di terze parti sono superiori a quelli di prima parte, sui dispositivi mobili questa differenza non è così ampia, solo fino a 328 KB al 90° percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=231883913&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

## Come cariciamo il nostro JavaScript?

Il modo in cui cariciamo JavaScript ha un impatto significativo sull'esperienza complessiva.

Di default, JavaScript è _parser-blocking_. In altre parole, quando il browser scopre un elemento `script`, deve sospendere l'analisi dell'HTML finché lo script non è stato scaricato, analizzato ed eseguito. È un collo di bottiglia significativo e un contributo comune alle pagine che sono lente da visualizzare.

Possiamo iniziare a compensare parte del costo del caricamento di JavaScript caricando gli script in modo asincrono (con l'attributo `async`), che arresta il parser HTML solo durante le fasi di analisi ed esecuzione e non durante la fase di download, o differito (con il attributo `defer`), che non arresta affatto il parser HTML. Entrambi gli attributi sono disponibili solo su script esterni: gli script inline non possono essere applicati.

Sui dispositivi mobile, gli script esterni costituiscono il 59,0% di tutti gli elementi di script trovati.

<aside class="note">
  Per inciso, quando abbiamo parlato di quanto JavaScript è stato caricato in una pagina in precedenza, quel totale non ha tenuto conto della dimensione di questi script inline, poiché fanno parte del documento HTML, vengono conteggiati rispetto alla dimensione del markup . Ciò significa che carichiamo ancora più script che mostrano i numeri.
</aside>

{{ figure_markup(
  image="external-inline-mobile.png",
  caption="Distribuzione del numero di script esterni e inline per pagina mobile.",
  description="Grafico a torta che mostra il 41.0% degli script per dispositivi mobile sono inline e il 59.0% sono esterni.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1326937127&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

Di questi script esterni, solo il 12.2% viene caricato con l'attributo `async` e il 6.0% con l'attributo `defer`.

{{ figure_markup(
  image="async-defer-mobile.png",
  caption="Distribuzione del numero di script `async` e `defer` per pagina mobile.",
  description="Grafico a torta che mostra il 12.2% degli script per dispositivi mobile esterni che utilizza async, il 6.0% utilizza il defer e l'81.8% non utilizza nessuno dei due.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=662584253&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

Considerando che `defer` ci fornisce le migliori prestazioni di caricamento (assicurando che il download dello script avvenga in parallelo ad altri lavori, e l'esecuzione attende fino a quando la pagina può essere visualizzata), speriamo di vedere quella percentuale un po' più alta. Infatti, il 6.0% è leggermente gonfiato.

Quando il supporto di IE8 e IE9 era più comune, era relativamente comune usare _entrambi_ gli attributi `async` e `defer`. Con entrambi gli attributi posizionati, qualsiasi browser che li supporti entrambi utilizzerà `async`. IE8 e IE9, che non supportano `async`, torneranno a differire.

Al giorno d'oggi, il pattern non è necessario per la stragrande maggioranza dei siti e qualsiasi script caricato con il pattern in posizione interromperà il parser HTML quando deve essere eseguito, invece di rimandare fino al caricamento della pagina. Il pattern è ancora utilizzato sorprendentemente spesso, con l'11.4% delle pagine per dispositivi mobile che pubblica almeno uno script con quel pattern in atto. In altre parole, almeno una parte del 6% degli script che usa `defer` non sta ottenendo tutti i vantaggi dell'attributo `defer`.

C'è una storia incoraggiante qui, però.

Harry Roberts [ha twittato sull'antipattern su Twitter](https://x.com/csswizardry/status/1331721659498319873), che è ciò che ci ha spinto a controllare per vedere quanto spesso ciò si verificava in natura. [Rick Viscomi ha controllato per vedere chi erano i principali colpevoli](https://x.com/rick_viscomi/status/1331735748060524551), e si è scoperto che "stats.wp.com" era la fonte dei criminali più comuni. @Kraft di Automattic ha risposto e il pattern verrà ora [rimosso in futuro](https://x.com/Kraft/status/1336772912414601224).

Una delle grandi cose dell'apertura del web è come un'osservazione può portare a cambiamenti significativi ed è esattamente quello che è successo qui.

### Le Resource hints

Un altro strumento che abbiamo a nostra disposizione per compensare alcuni dei costi di rete per il caricamento di JavaScript sono le [resource hints](./resource-hints), in particolare `prefetch` e `preload`.

L'hint `prefetch` consente agli sviluppatori di indicare che una risorsa verrà utilizzata nella navigazione della pagina successiva, quindi il browser dovrebbe provare a scaricarla quando il browser è inattivo.

L'hint `preload` significa che una risorsa verrà utilizzata nella pagina corrente e che il browser dovrebbe scaricarla subito con una priorità più alta.

Nel complesso, vediamo che il 16,7% delle pagine per dispositivi mobile utilizza almeno uno delle due resource hints per caricare JavaScript in modo più proattivo.

Di questi, quasi tutto l'utilizzo proviene da `preload`. Mentre il 16.6% delle pagine mobile utilizza almeno un hint `preload` per caricare JavaScript, solo lo 0.4% delle pagine mobile usa almeno un hint `prefetch`.

C'è il rischio, in particolare con `preload`, di usare troppe hint e di ridurne l'efficacia, quindi vale la pena guardare le pagine che usano questi suggerimenti per vedere quanti ne stanno usando.

{{ figure_markup(
  image="prefetch-distribution.png",
  caption="Distribuzione del numero di hint `prefetch` per pagina con qualsiasi hint `prefetch`.",
  description="Grafico a barre che mostra la distribuzione dei prefetch hint per pagina con eventuali prefetch hint. Il 10, 25 e 50° percentile per le pagine desktop e mobile è 1, 2 e 3 prefetch hint per pagina. Al 75° percentile per le pagine desktop è 6 e 4 per i dispositivi mobile. Al 90° percentile, le pagine desktop utilizzano 14 prefetch hint per pagina e 12 per le pagine mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1874381460&format=interactive",
  sheets_gid="1910228743",
  sql_file="resource-hints-preload-prefetch-distribution.sql"
) }}

{{ figure_markup(
  image="preload-distribution.png",
  caption="Distribuzione del numero di hint `preload` per pagina con qualsiasi hint `preload`.",
  description="Grafico a barre che mostra la distribuzione dei preload hint per pagina con eventuali preload hint. Il 75% delle pagine desktop e mobile che utilizzano i preload hint lo utilizza esattamente una volta. Il 90° percentile è di 5 preload hint per pagina per desktop e 7 per dispositivi mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=320533828&format=interactive",
  sheets_gid="1910228743",
  sql_file="resource-hints-preload-prefetch-distribution.sql"
) }}

In media, le pagine che usano un hint `prefetch` per caricare JavaScript ne usano tre, mentre le pagine che usano un hint `preload` ne usano solo uno. La coda lunga diventa un po' più interessante, con 12 hint `prefetch` usati al 90° percentile e 7 hint `preload` usati anche loro al 90° percentile. Per maggiori dettagli sulle resource hint, consultare il capitolo [Resource Hints](./resource-hints) di quest'anno.

## Come serviamo JavaScript?

Come con qualsiasi risorsa di testo sul Web, possiamo salvare un numero significativo di byte tramite la minimizzazione e la compressione. Nessuna di queste sono nuove ottimizzazioni - sono in circolazione da un po' di tempo - quindi dovremmo aspettarci di vederle applicate nella maggior parte dei casi.

Uno degli audit in [Lighthouse](./methodology#lighthouse) controlla JavaScript non minimizzato e fornisce un punteggio (0.00 è il peggiore, 1.00 è il migliore) in base ai risultati.

{{ figure_markup(
  image="lighthouse-unminified-js.png",
  caption="Distribuzione dei punteggi di audit riguardante JavaScript non minimizzato per pagina mobile.",
  description="Grafico a barre che mostra lo 0% delle pagine mobile che ottengono dei punteggi di audit riguardante JavaScript non minimizzato inferiori allo 0.25, il 4% delle pagine che ottengono un punteggio compreso tra 0.25 e 0.5, il 10% delle pagine tra 0.5 e 0.75, l'8% delle pagine tra 0,75 e 0,9 e il 77% di pagine tra 0.9 e 1.0.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=158284816&format=interactive",
  sheets_gid="362705605",
  sql_file="lighthouse_unminified_js.sql"
) }}

Il grafico sopra mostra che la maggior parte delle pagine testate (77%) ottiene un punteggio di 0.90 o superiore, il che significa che vengono trovati pochi script non minimizzati.

Nel complesso, solo il 4,5% delle richieste JavaScript registrate non è minimizzato.

È interessante notare che, anche se abbiamo scelto un po' le richieste di terze parti, questa è un'area in cui gli script di terze parti stanno andando meglio degli script di prima parte. L'82% dei byte JavaScript non minimizzati di una pagina mobile media proviene da codice di prima parte.

{{ figure_markup(
  image="lighthouse-unminified-js-by-3p.png",
  caption="Distribuzione media dei byte JavaScript non minimizzati per host.",
  description="Grafico a torta che mostra che il 17.7% dei byte JS non minimizzati sono script di terze parti e l'82.3% sono script di prima parte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=2073491355&format=interactive",
  sheets_gid="1169731612",
  sql_file="lighthouse_unminified_js_by_3p.sql"
) }}

### Compressione

La minimizzazione è un ottimo modo per ridurre le dimensioni dei file, ma la compressione è ancora più efficace e, quindi, più importante: fornisce la maggior parte dei risparmi di rete il più delle volte.

{{ figure_markup(
  image="compression-method-request.png",
  caption="Distribuzione della percentuale di richieste JavaScript per metodo di compressione.",
  description="Grafico a barre che mostra la distribuzione della percentuale di richieste JavaScript per metodo di compressione. I valori desktop e mobile sono molto simili. Il 65% delle richieste JavaScript utilizza la compressione Gzip, il 20% utilizza br (Brotli), il 15% non utilizza alcuna compressione e deflate, UTF-8, identità e nessuna sembra avere lo 0%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=263239275&format=interactive",
  sheets_gid="1270710983",
  sql_file="compression_method.sql"
) }}

L'85% di tutte le richieste JavaScript ha un certo livello di compressione di rete applicato. Gzip costituisce la maggior parte di ciò, con il 65% degli script a cui è stata applicata la compressione Gzip rispetto al 20% per Brotli (br). Sebbene la percentuale di Brotli (che è più efficace di Gzip) sia bassa rispetto al supporto del browser, sta andando nella giusta direzione, aumentando di 5 punti percentuali nell'ultimo anno.

Ancora una volta, questa sembra essere un'area in cui gli script di terze parti stanno effettivamente facendo meglio degli script di prima parte. Se suddividiamo i metodi di compressione per prime e terze parti, vediamo che il 24% degli script di terze parti ha applicato Brotli, rispetto a solo il 15% degli script di terze parti.

{{ figure_markup(
  image="compression-method-3p.png",
  caption="Distribuzione della percentuale di richieste JavaScript mobile per metodo di compressione e host.",
  description="Grafico a barre che mostra la distribuzione della percentuale di richieste JavaScript mobile per metodo di compressione e host. Il 66% e il 64% delle richieste JavaScript di prima e terza parte utilizzano Gzip. Il 15% delle richieste di script di prima parte e il 24% di terze parti utilizzano Brotli. Inoltre, il 19% degli script di prima parte e il 12% degli script di terze parti non dispone di un metodo di compressione impostato.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1402692197&format=interactive",
  sheets_gid="564760060",
  sql_file="compression_method_by_3p.sql"
) }}

Anche gli script di terze parti hanno meno probabilità di essere serviti senza alcuna compressione: il 12% degli script di terze parti non ha né Gzip né Brotli applicati, rispetto al 19% degli script di prima parte.

Vale la pena dare un'occhiata più da vicino a quegli script a cui _non_ è stata applicata la compressione. La compressione più diventa efficiente in termini di risparmio, maggiore è il contenuto con cui si deve lavorare. In altre parole, se il file è piccolo, a volte il costo della compressione del file non supera la minima riduzione della dimensione del file.

{{ figure_markup(
  caption="Percentuale di richieste JavaScript di terze parti non compresse inferiori a 5 KB.",
  content="90.25%",
  classes="big-number",
  sheets_gid="347926930",
  sql_file="compression_none_by_bytes.sql"
) }}

Per fortuna, è esattamente quello che vediamo, in particolare negli script di terze parti in cui il 90% degli script non compressi ha una dimensione inferiore a 5 KB. D'altra parte, il 49% degli script di prima parte non compressi è inferiore a 5 KB e il 37% degli script di prima parte non compressi è superiore a 10 KB. Quindi, anche se vediamo molti piccoli script di prima parte non compressi, ce ne sono ancora alcuni che trarrebbero vantaggio da una certa compressione.

## Cosa usiamo?

Poiché abbiamo utilizzato sempre più JavaScript per potenziare i nostri siti e le nostre applicazioni, c'è stata anche una crescente domanda di librerie e framework open source per aiutare a migliorare la produttività degli sviluppatori e la manutenibilità complessiva del codice. I siti che _non_ utilizzano uno di questi strumenti sono sicuramente la minoranza sul web di oggi: jQuery da solo si trova su quasi l'85% delle pagine mobile monitorate da HTTP Archive.

È importante pensare in modo critico agli strumenti che utilizziamo per costruire il Web e quali sono i compromessi, quindi ha senso esaminare attentamente ciò che vediamo in uso oggi.

### Librerie

HTTP Archive utilizza [Wappalyzer](./methodology#wappalyzer) per rilevare le tecnologie in uso su una determinata pagina. Wappalazyer tiene traccia di entrambe le librerie JavaScript (pensate a queste come una raccolta di frammenti o funzioni di supporto per facilitare lo sviluppo, come jQuery) e framework JavaScript (queste sono più probabili impalcature e forniscono modelli e strutture, come React).

Le librerie popolari in uso sono sostanzialmente invariate rispetto allo scorso anno, con jQuery che continua a dominare l'utilizzo e solo una delle 21 migliori librerie è caduta (lazy.js, sostituita da DataTables). In effetti, anche le percentuali delle migliori librerie sono cambiate appena rispetto allo scorso anno.

{{ figure_markup(
  image="frameworks-libraries.png",
  caption="Adozione dei principali framework e librerie JavaScript come percentuale delle pagine.",
  description="Grafico a barre che mostra l'adozione dei principali framework e librerie come percentuale di pagine (non visualizzazioni di pagina o download npm). jQuery è il leader indiscusso, che si trova sull'83% delle pagine mobile. È seguito da jQuery migrate al 30%, jQuery UI al 21%, Modernizr al 15%, FancyBox al 7%, Slick e Lightbox al 6% e i restanti framework e librerie al 4% o 3%: Moment.js, Underscore.js, Lodash, React, GSAP, Select2, RequireJS e prettyPhoto.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=419887153&format=interactive",
  sheets_gid="1654577118",
  sql_file="frameworks_libraries.sql"
) }}

L'anno scorso, [Houssein ha ipotizzato alcuni motivi per cui il dominio di jQuery continua](../2019/javascript#open-source-libraries-and-frameworks):

> WordPress, che viene utilizzato in oltre il 30% dei siti, include jQuery di default.
> Il passaggio da jQuery a una nuova libreria lato client può richiedere tempo a seconda delle dimensioni di un'applicazione e molti siti possono essere costituiti da jQuery oltre alle nuove librerie lato client.

Entrambe sono ipotesi molto valide e sembra che la situazione non sia cambiata molto su entrambi i fronti.

In effetti, il predominio di jQuery è ulteriormente supportato se ci si ferma a considerare che, delle 10 migliori librerie, 6 di esse sono jQuery o richiedono jQuery per essere utilizzate: jQuery UI, jQuery Migrate, FancyBox, Lightbox e Slick.

### I Framework

Quando guardiamo i framework, non vediamo nemmeno un cambiamento radicale in termini di adozione nei framework principali che sono stati evidenziati lo scorso anno. Vue.js ha visto un aumento significativo e AMP è cresciuto un po', ma la maggior parte di loro sono più o meno dove erano un anno fa.

Vale la pena notare che il <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">problema di rilevamento rilevato lo scorso anno è ancora valido</a> e ha ancora un impatto sui risultati qui. È possibile che ci sia stato un cambiamento significativo nella popolarità di alcuni di questi strumenti, ma semplicemente non lo vediamo con il modo in cui i dati vengono attualmente raccolti.

### Cosa significa tutto

Più interessante per noi della popolarità degli strumenti stessi è l'impatto che hanno sulle cose che costruiamo.

Innanzitutto, vale la pena notare che mentre possiamo pensare all'uso di uno strumento rispetto a un altro, in realtà raramente usiamo solo una singola libreria o framework in produzione. Solo il 21% delle pagine analizzate riporta una sola libreria o framework. Due o tre framework sono abbastanza comuni e la coda lunga diventa molto lunga, molto rapidamente.

Quando guardiamo le combinazioni comuni che vediamo nella produzione, la maggior parte di esse è prevedibile. Conoscendo il predominio di jQuery, non sorprende che la maggior parte delle combinazioni popolari includa jQuery e un numero qualsiasi di plugin relativi a jQuery.

<figure>
  <table>
    <thead>
      <tr>
        <th>Combinazioni</th>
        <th>Pagine</th>
        <th>(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">1,312,601</td>
        <td class="numeric">20.7%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate</td>
        <td class="numeric">658,628</td>
        <td class="numeric">10.4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery UI</td>
        <td class="numeric">289,074</td>
        <td class="numeric">4.6%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery</td>
        <td class="numeric">155,082</td>
        <td class="numeric">2.4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">140,466</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery Migrate</td>
        <td class="numeric">85,296</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery</td>
        <td class="numeric">84,392</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>Slick, jQuery</td>
        <td class="numeric">72,591</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>GSAP, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">61,935</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery UI</td>
        <td class="numeric">61,152</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Lightbox, jQuery</td>
        <td class="numeric">60,395</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">53,924</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Slick, jQuery, jQuery Migrate</td>
        <td class="numeric">51,686</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Lightbox, jQuery, jQuery Migrate</td>
        <td class="numeric">50,557</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery, jQuery UI</td>
        <td class="numeric">44,193</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>Modernizr, YUI</td>
        <td class="numeric">42,489</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>React, jQuery</td>
        <td class="numeric">37,753</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Moment.js, jQuery</td>
        <td class="numeric">32,793</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery, jQuery Migrate</td>
        <td class="numeric">31,259</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>MooTools, jQuery, jQuery Migrate</td>
        <td class="numeric">28,795</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>
    {{ figure_link(
      caption="Le combinazioni più popolari di librerie e framework su pagine mobile.",
      sheets_gid="795160444",
      sql_file="frameworks_libraries_combos.sql"
    ) }}
  </figcaption>
</figure>

Vediamo anche una discreta quantità di framework più "moderni" come React, Vue e Angular abbinati a jQuery, ad esempio come risultato della migrazione o dell'inclusione da parte di terze parti.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Combinazione</th>
        <th scope="col">Senza jQuery</th>
        <th scope="col">Con jQuery</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>GSAP, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">1.0%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>React, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>React</td>
        <td class="numeric">0.4%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>React, jQuery, jQuery Migrate</td>
        <td>&nbsp;</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>Vue.js, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Vue.js</td>
        <td class="numeric">0.2%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>AngularJS, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>GSAP, Hammer.js, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">0.2%</td>
        <td>&nbsp;</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">Somma totale</th>
        <th scope="col" class="numeric">1.7%</th>
        <th scope="col" class="numeric">1.4%</th>
      </tr>
    </tfoot>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Le combinazioni più popolari di React, Angular e Vue con e senza jQuery.",
      sheets_gid="795160444",
      sql_file="frameworks_libraries_combos.sql"
    ) }}
  </figcaption>
</figure>

Ancora più importante, tutti questi strumenti in genere significano più codice e più tempo di elaborazione.

Osservando specificamente i framework in uso, vediamo che i byte JavaScript mediani per le pagine che li utilizzano variano notevolmente a seconda di _cosa_ viene utilizzato.

Il grafico seguente mostra i byte mediani per le pagine in cui è stato trovato uno dei primi 35 framework più comunemente rilevati, suddivisi per client.

{{ figure_markup(
  image="frameworks-bytes.png",
  caption="Il numero mediano di kilobyte JavaScript per pagina dal framework JavaScript.",
  description="Grafico a barre che mostra il numero medio di kilobyte JavaScript per pagina suddivisi e ordinati in base alla popolarità del framework JavaScript. Il framework più popolare, React, ha una quantità media di JS a 1.328 sulle pagine mobile. Altri framework come RequireJS e Angular hanno un numero elevato di byte JS mediani per pagina. Le pagine con MooTools, Prototype, AMP, RightJS, Alpine.js e Svelte hanno una media inferiore a 500 KB per pagina mobile. Ember.js ha un valore anomalo di circa 1.800 KB di JS mediano per pagina mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=955720480&format=interactive",
  sheets_gid="1206934500",
  width="600",
  height="835",
  sql_file="frameworks-bytes-by-framework.sql"
) }}

Su uno dello spettro ci sono framework come React o Angular o Ember, che tendono a fornire molto codice indipendentemente dal client. Dall'altro lato, vediamo framework minimalisti come Alpine.js e Svelte che mostrano risultati molto promettenti. I default sono molto importanti e sembra che, iniziando con default altamente performanti, Svelte e Alpine riescano entrambi (finora&hellip; la dimensione del campione è piuttosto piccola) nel creare un insieme di pagine più leggero.

Otteniamo un'immagine molto simile quando guardiamo il tempo del thread principale per le pagine in cui sono stati rilevati questi strumenti.

{{ figure_markup(
  image="frameworks-main-thread.png",
  caption="Il tempo mediano del thread principale per pagina dal framework JavaScript.",
  description="Grafico a barre che mostra il tempo mediano del thread principale per framework. È difficile notare qualcosa di diverso da Ember.js, il cui tempo mediano del thread principale mobile è di oltre 20.000 millisecondi (20 secondi). Il resto dei framework sono minuscoli in confronto.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=691531699&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Il tempo del thread principale mobile di Ember salta fuori e distorce il grafico con il tempo necessario. (Ho passato un po' più di tempo a esaminare questo aspetto e sembra essere fortemente influenzato <a hreflang="en" href="https://timkadlec.com/remembers/2021-01-26-what-about-ember/">da una particolare piattaforma che utilizza questo framework in modo inefficiente</a>, piuttosto che da un problema di fondo con Ember stesso.) Tirare fuori l'immagine dal grafico lo rende più facile da capire.

{{ figure_markup(
  image="frameworks-main-thread-no-ember.png",
  caption="Il tempo mediano del thread principale per pagina per framework JavaScript, escluso Ember.js.",
  description="Grafico a barre che mostra il tempo mediano del thread principale per framework, escluso Ember.js. I tempi del thread principale mobile sono tutti più alti a causa della metodologia di test che utilizza velocità della CPU più lente per i dispositivi mobile. I framework più popolari come React, GSAP e RequireJS hanno tempi di thread principali elevati di circa 2-3 secondi per desktop e 5-7 secondi per dispositivi mobile. Polymer spicca anche più in basso nell'elenco di popolarità. MooToos, Prototype, Alpine.js e Svelte tendono ad avere tempi del thread principale inferiori, inferiori a 2 secondi.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=77448759&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Strumenti come React, GSAP e RequireJS tendono a dedicare molto tempo al thread principale del browser, indipendentemente dal fatto che si tratti di una visualizzazione di pagina desktop o mobile. Gli stessi strumenti che tendono a portare a meno codice in generale, strumenti come Alpine e Svelte, tendono anche a portare a un impatto inferiore sul thread principale.

Vale anche la pena approfondire il divario tra l'esperienza che un framework fornisce per desktop e mobile. Il traffico mobile sta diventando sempre più dominante ed è fondamentale che i nostri strumenti funzionino nel miglior modo possibile per le visualizzazioni di pagina mobili. Maggiore è il divario che vediamo tra le prestazioni desktop e mobile per un framework, maggiore è la bandiera rossa.

{{ figure_markup(
  image="frameworks-main-thread-no-ember-diff.png",
  caption="Differenza tra il tempo mediano del thread principale desktop e mobile per pagina in base al framework JavaScript, escluso Ember.js.",
  description="Grafico a barre che mostra le differenze assolute e relative tra il tempo mediano del thread principale per pagina da desktop e da dispositivo mobile per framework JavaScript, escluso Ember.js. Polymer salta più avanti nell'elenco di popolarità come caratterizzato da un'elevata differenza: circa 5 secondi e il tempo medio del thread principale del 250% più lento sulle pagine mobili rispetto alle pagine desktop. Altri framework che si distinguono sono GSAP e RequireJS ha una differenza di 4 secondi o 150%. I framework con la differenza più bassa sono Moustache e RxJS, che sono solo il 20-30% più lenti sui dispositivi mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1758266664&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Come ci si aspetterebbe, c'è un divario tra tutti gli strumenti in uso a causa della minore potenza di elaborazione del [Moto G4 emulato](methodology#webpagetest). Ember e Polymer sembrano saltare fuori come esempi particolarmente eclatanti, mentre strumenti come RxJS e Moustache variano solo leggermente da desktop a mobile.

## Qual è l'impatto?

Ora abbiamo un quadro abbastanza buono di quanto JavaScript usiamo, da dove proviene e per cosa lo usiamo. Anche se questo è abbastanza interessante da solo, il vero kicker è il "e allora?" Che impatto ha effettivamente tutto questo script sull'esperienza delle nostre pagine?

La prima cosa che dovremmo considerare è cosa succede con tutto quel JavaScript una volta scaricato. Il download è solo la prima parte del viaggio in JavaScript. Il browser deve ancora analizzare tutto lo script, compilarlo e infine eseguirlo. Mentre i browser sono costantemente alla ricerca di modi per scaricare parte di quel costo su altri thread, gran parte di quel lavoro avviene ancora sul thread principale, impedendo al browser di essere in grado di eseguire lavori relativi al layout o al paint, oltre ad essere in grado di rispondere all'interazione dell'utente.

Se ricordi, c'era solo una differenza di 30 KB tra ciò che viene spedito su un dispositivo mobile e un dispositivo desktop. A seconda del tuo punto di vista, potresti essere perdonato per non esserti arrabbiato troppo per il piccolo divario nella quantità di codice inviato a un browser desktop rispetto a uno mobile, dopotutto, che cosa è un extra di 30 KB circa in media, giusto ?

Il problema più grande arriva quando tutto quel codice viene fornito a un dispositivo di fascia medio-bassa, dove è molto probabile che la maggior parte degli sviluppatori non ha quel tipo di dispositivi e un po' più verosimile al tipo di dispositivi che vedrai dalla maggior parte delle persone in tutto il mondo. Questo divario relativamente piccolo tra desktop e mobile è molto più drammatico se lo guardiamo in termini di tempo di elaborazione.

Il sito desktop mediano spende 891 ms sul thread principale di un browser che funziona con tutto quel JavaScript. Il sito per dispositivi mobile mediano, tuttavia, impiega 1.897 ms, più del doppio del tempo trascorso sul desktop. È anche peggio per la lunga coda di siti. Al 90° percentile, i siti per dispositivi mobili trascorrono l'incredibile quantità di 8.921 ms del thread principale che si occupa di JavaScript, rispetto ai 3.838 ms dei siti desktop.

{{ figure_markup(
  image="main-thread-time.png",
  caption="Distribuzione del tempo del thread principale.",
  description="Grafico a barre che mostra la distribuzione del tempo del thread principale per desktop e dispositivi mobile. I dispositivi mobile sono 2-3 volte più alti in tutta la distribuzione. I 10, 25, 50, 75 e 90° percentile per desktop sono: 137, 356, 891, 1.988 e 3.838 millisecondi.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=740020507&format=interactive",
  sheets_gid="2039579122",
  sql_file="main_thread_time.sql"
) }}

### Correlare l'uso di JavaScript al punteggio di Lighthouse

Un modo per vedere come questo si traduce in un impatto sull'esperienza utente è provare a correlare alcune delle metriche JavaScript che abbiamo identificato in precedenza con i punteggi di Lighthouse per metriche e categorie diverse.

{{ figure_markup(
  image="correlations.png",
  caption="Correlazioni di JavaScript su vari aspetti dell'esperienza utente.",
  description="Grafico a barre che mostra il coefficiente di correlazione di Pearson per vari aspetti dell'esperienza utente. La correlazione dei byte al punteggio delle prestazioni di Lighthouse ha un coefficiente di correlazione di -0,47. Byte e il punteggio Lighthouse accessibilità: 0,08. Byte e tempo di blocco totale (TBT): 0,55. Byte di terze parti e punteggio prestazioni Lighthouse: -0,37. Byte di terze parti e punteggio di accessibilità di Lighthouse: 0,00. Byte di terze parti e TBT: 0.48. Il numero di script asincroni per pagina e il punteggio delle prestazioni di Lighthouse: -0,19. Script asincroni e punteggio di accessibilità di Lighthouse: 0,08. Script asincroni e TBT: 0,36.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=649523941&format=interactive",
  sheets_gid="2035770638",
  sql_file="correlations.sql"
) }}

Il grafico sopra utilizza il [coefficiente di correlazione di Pearson](https://it.wikipedia.org/wiki/Indice_di_correlazione_di_Pearson). C'è una definizione lunga e un po' complessa di cosa significhi precisamente, ma il succo è che stiamo cercando la forza della correlazione tra due numeri diversi. Se troviamo un coefficiente di 1,00, avremmo una correlazione positiva diretta. Una correlazione di 0,00 non mostrerebbe alcuna connessione tra due numeri. Qualunque cosa al di sotto di 0,00 indica una correlazione negativa, in altre parole, quando un numero aumenta, l'altro diminuisce.

Innanzitutto, non sembra esserci molta correlazione misurabile tra le nostre metriche JavaScript e il punteggio di accessibilità Lighthouse ("LH A11y" nel grafico) qui. Ciò è in netto contrasto con ciò che è stato trovato altrove, in particolare tramite <a hreflang="en" href="https://webaim.org/projects/million/#frameworks">la ricerca annuale di WebAim</a>.

La spiegazione più probabile è che i test di accessibilità di Lighthouse non sono così completi (ancora!) come ciò che è disponibile attraverso altri strumenti, come WebAIM, che hanno l'accessibilità come obiettivo principale.

Dove vediamo una forte correlazione è tra la quantità di byte JavaScript ("byte") e sia il punteggio complessivo delle prestazioni di Lighthouse ("LH Perf") e il tempo di blocco totale ("TBT").

La correlazione tra i byte JavaScript e i punteggi delle prestazioni di Lighthouse è -0,47. In altre parole, all'aumentare dei byte JS, i punteggi delle prestazioni di Lighthouse diminuiscono. I byte complessivi hanno una correlazione più forte rispetto alla quantità di byte di terze parti ("3P byte"), suggerendo che sebbene abbiano certamente un ruolo, non possiamo attribuire tutta la colpa a terze parti.

La connessione tra il tempo di blocco totale e i byte JavaScript è ancora più significativa (0,55 per i byte complessivi, 0,48 per i byte di terze parti). Non è troppo sorprendente, dato quello che sappiamo su tutti i browser di lavoro che devono fare per far funzionare JavaScript in una pagina: più byte significa più tempo.

### Vulnerabilità di sicurezza

Un altro controllo utile eseguito da Lighthouse consiste nel verificare la presenza di vulnerabilità di sicurezza note nelle librerie di terze parti. Lo fa rilevando quali librerie e framework vengono utilizzati in una determinata pagina e quale versione viene utilizzata di ciascuno. Quindi controlla <a hreflang="en" href="https://snyk.io/vuln?type=npm">il database delle vulnerabilità open source di Snyk</a> per vedere quali vulnerabilità sono state scoperte negli strumenti identificati.

{{ figure_markup(
  caption="La percentuale di pagine per dispositivi mobili contiene almeno una libreria JavaScript vulnerabile.",
  content="83.50%",
  classes="big-number",
  sheets_gid="1326928130",
  sql_file="lighthouse_vulnerabilities.sql"
) }}

Secondo l'audit, l'83,5% delle pagine mobile utilizza una libreria o un framework JavaScript con almeno una vulnerabilità di sicurezza nota.

Questo è ciò che chiamiamo effetto jQuery. Ricordi come abbiamo visto che jQuery viene utilizzato su un enorme 83% delle pagine? Diverse versioni precedenti di jQuery contengono vulnerabilità note, che comprendono la stragrande maggioranza delle vulnerabilità controllate da questo audit.

Dei circa 5 milioni di pagine per dispositivi mobile su cui è stato eseguito il test, l'81% di esse contiene una versione vulnerabile di jQuery, un vantaggio considerevole rispetto alla seconda libreria vulnerabile più comunemente trovata, jQuery UI al 15,6%.

<figure>
  <table>
    <thead>
      <tr>
        <th>Librerie</th>
        <th>Pagine vulnerabili</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">80.86%</td>
      </tr>
      <tr>
        <td>jQuery UI</td>
        <td class="numeric">15.61%</td>
      </tr>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">13.19%</td>
      </tr>
      <tr>
        <td>Lodash</td>
        <td class="numeric">4.90%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">2.61%</td>
      </tr>
      <tr>
        <td>Handlebars</td>
        <td class="numeric">1.38%</td>
      </tr>
      <tr>
        <td>AngularJS</td>
        <td class="numeric">1.26%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0.77%</td>
      </tr>
      <tr>
        <td>Dojo</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>jQuery Mobile</td>
        <td class="numeric">0.53%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Le 10 migliori librerie che contribuiscono al maggior numero di pagine mobile vulnerabili secondo Lighthouse.",
      sheets_gid="1803013938",
      sql_file="lighthouse_vulnerable_libraries.sql"
    ) }}
  </figcaption>
</figure>

In altre parole, se riusciamo a convincere la gente a migrare da quelle versioni obsolete e vulnerabili di jQuery, vedremmo precipitare il numero di siti con vulnerabilità note (almeno, finché non inizieremo a trovarne alcuni nei framework più recenti).

La maggior parte delle vulnerabilità rilevate rientra nella categoria di gravità "media".

{{ figure_markup(
  image="vulnerabilities-by-severity.png",
  caption="Distribuzione della percentuale di pagine mobili con vulnerabilità JavaScript per gravità.",
  description="Grafico a torta che mostra il 13,7% delle pagine per dispositivi mobile prive di vulnerabilità JavaScript, lo 0,7% con vulnerabilità di bassa gravità, il 69,1% con gravità media e il 16,4% con gravità alta.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1932740277&format=interactive",
  sheets_gid="1409147642",
  sql_file="lighthouse_vulnerabilities_by_severity.sql"
) }}

## Conclusione

JavaScript è in costante aumento in popolarità e tutto questo è positivo. È incredibile considerare ciò che siamo in grado di realizzare sul web di oggi grazie a JavaScript che, anche pochi anni fa, sarebbe stato inimmaginabile.

Ma è chiaro che dobbiamo anche procedere con cautela. La quantità di JavaScript aumenta costantemente ogni anno (se il mercato azionario fosse così prevedibile, saremmo tutti incredibilmente ricchi) e ciò comporta dei compromessi. Più JavaScript è collegato a un aumento del tempo di elaborazione che influisce negativamente sulle metriche chiave come il tempo di blocco totale. E, se lasciamo che quelle librerie languiscano senza tenerle aggiornate, corrono il rischio di esporre gli utenti a vulnerabilità di sicurezza note.

Valutare attentamente il costo degli script che aggiungiamo alle nostre pagine ed essere disposti a porre un occhio critico sui nostri strumenti e chiedere di più sono le nostre migliori scommesse per assicurarci di costruire un Web accessibile, efficiente e sicuro.
