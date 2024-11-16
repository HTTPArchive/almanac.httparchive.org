---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Compression
description: Capitolo sulla compressione del Web Almanac 2020 che copre la compressione HTTP, gli algoritmi, i tipi di contenuto, la compressione e le opportunità di prime e terze parti.
hero_alt: Hero image of Web Almanac characters using a ray gun to shrink an HTML page to make it much smaller.
authors: [mo271, veluca93, sboukortt, jyrkialakuijala]
reviewers: [paulcalvano]
analysts: [AbbyTsai]
editors: [exterkamp]
translators: [chefleo]
jyrkialakuijala_bio: Jyrki Alakuijala è un membro attivo della comunità del software open source e un ricercatore sulla compressione dei dati. Jyrki lavora per Google come Technical Lead/Manager e il suo lavoro pubblicato di recente è stato con Zopfli, Butteraugli, Guetzli, Gipfeli, WebP lossless, Brotli e formati di compressione e algoritmi di compressione JPEG XL e due algoritmi di hashing, CityHash e HighwayHash. Prima del suo impiego in Google ha sviluppato software per la pianificazione del trattamento di neurochirurgia e radioterapia.
sboukortt_bio: Sami è entrato a far parte di Google dopo aver completato i suoi studi in ingegneria matematica. Dopo alcuni anni di remoto interesse per la compressione, alla fine ne ha fatto il suo lavoro a tempo pieno nel 2018.
mo271_bio: Moritz Firsching è ingegnere del software presso Google Svizzera, dove lavora sui formati di immagine progressivi e sulla compressione dei caratteri. Prima di allora Moritz ha svolto ricerche come matematico studiando i politopi.
veluca93_bio: Luca Versari è un ingegnere del software di Google e lavora su <a hreflang="en" href="https://gitlab.com/wg1/jpeg-xl">JPEG XL</a>. Sta terminando un dottorato di ricerca sulla compressione dei grafici e ha una formazione in matematica.
discuss: 2055
results: https://docs.google.com/spreadsheets/d/1NKbP4AqMkgCNCsVD3yLhO2d0aqIsgZ7AGLEtUDHl9yY/
featured_quote: L'utilizzo della compressione HTTP velocizza il caricamento di un sito Web e garantisce quindi una migliore esperienza utente.
featured_stat_1: 23%
featured_stat_label_1: Risposte compresse che utilizzano Brotli
featured_stat_2: 77%
featured_stat_label_2: Risposte compresse che utilizzano Gzip
featured_stat_3: 74%
featured_stat_label_3: Siti web che superano l'audit Lighthouse con il punteggio massimo sulla compressione del testo
---

## Introduzione

L'utilizzo della compressione HTTP velocizza il caricamento di un sito Web e garantisce quindi una migliore esperienza utente. La mancata esecuzione della compressione su HTTP peggiora l'esperienza utente, può influire sul tasso di crescita del servizio Web correlato e influisce sulle classifiche di ricerca. Un uso efficace della compressione può ridurre il [peso della pagina](./page-weight), migliorare [le prestazioni web](./performance) e quindi è una parte importante dell'[ottimizzazione dei motori di ricerca](./seo).

Mentre la compressione lossy (con perdita) è spesso accettabile per le immagini e altri tipi di [media](./media), per il testo vogliamo usare la compressione senza perdita, cioè recuperare il testo esatto dopo la decompressione.

## Che tipo di contenuto dovremmo comprimere?

Per la maggior parte delle risorse di testo, come [HTML](./markup), [CSS](./css), [JavaScript](./javascript), JSON o SVG, nonché alcuni formati non di testo come woff, ttf, ico, si consiglia di utilizzare la compressione.

{{ figure_markup(
  image="compession-methods-by-content-type.png",
  caption="Metodi di compressione per diversi tipi di contenuto",
  description="Un grafico a barre in pila che mostra il tasso di utilizzo di diversi algoritmi di compressione suddivisi per tipo di contenuto. Le barre impilate dividono l'uso di Brotli, Gzip e nessuna compressione. `text/html` è l'unico tipo di contenuto compresso meno del 50% delle volte. `application/json` e `image/svg+xml` sono compressi per circa il 64% ciascuno. `text/css` e `application/javascript` sono compressi per circa l'85% ciascuno. `application/x-javascript` e `text/javascript` sono compressi più del 90%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1658254159&format=interactive",
  sheets_gid="107138856",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

La figura mostra la percentuale di risposte di un determinato tipo di contenuto utilizzando Brotli, Gzip o nessuna compressione del testo.
È sorprendente che mentre tutti quei tipi di contenuto trarrebbero vantaggio dalla compressione, l'intervallo di percentuali varia ampiamente tra i diversi tipi di contenuto: solo il 44% usa la compressione per `text/html` contro il 93% per `application/x-javascript`.

Per le risorse basate su immagini, la compressione basata su testo è meno utile e non ampiamente utilizzata. I dati mostrano che la percentuale di risposte alle immagini che impiegano Brotli o Gzip è molto bassa, inferiore al 4%. Per maggiori informazioni sulle risorse non di testo, consulta il capitolo [Media](./media).

{{ figure_markup(
  image="http-compression-methods-for-image-types.png",
  caption="Metodi di compressione per i tipi di immagine sul desktop.",
  description="Questo suddivide i metodi di compressione, se presenti, utilizzati per tutti i tipi di contenuto che sono immagini. Per tutti e tre i tipi di immagine, ovvero jpeg, png e gif, circa il 96.5% non utilizza alcuna compressione.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1287110333&format=interactive",
  sheets_gid="449339162",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

## Come utilizzare la compressione HTTP?

Per ridurre le dimensioni dei file che intendiamo servire, è possibile utilizzare prima alcuni minimizzatori, ad es. <a hreflang="en" href="https://github.com/kangax/html-minifier">HTMLMinifier</a>, <a hreflang="en" href="https://github.com/ben-eb/cssnano">CSSNano</a> o <a hreflang="en" href="https://github.com/mishoo/UglifyJS2">UglifyJS</a>. Tuttavia, ci si aspettano maggiori benefici dall'uso della compressione.

Esistono due modi per eseguire la compressione sul lato server:

  - Precompresso (comprimi e salva le risorse in anticipo)
  - Compresso dinamicamente (comprime le risorse al volo dopo che è stata effettuata una richiesta)

Poiché la precompressione viene eseguita in anticipo, possiamo dedicare più tempo alla compressione delle risorse. Per le risorse compresse dinamicamente, dobbiamo scegliere i livelli di compressione in modo tale che la compressione richieda meno tempo rispetto alla differenza di tempo tra l'invio di un file non compresso e un file compresso. Questa differenza è confermata quando si esaminano i consigli sui livelli di compressione per entrambi i metodi.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Brotli</th>
        <th scope="col">Gzip</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Precompresso</td>
        <td>11</td>
        <td>9 or Zopfli</td>
      </tr>
      <tr>
        <td>Compresso dinamicamente</td>
        <td>5</td>
        <td>6</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Livelli di compressione consigliati da utilizzare.") }}</figcaption>
</figure>

Attualmente, praticamente tutta la compressione del testo viene eseguita da una delle due content encoding HTTP: <a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a> e <a hreflang="en" href="https://github.com/google/brotli">Brotli</a>. Entrambi sono ampiamente supportati dai browser: <a hreflang="en" href="https://caniuse.com/?search=brotli">can I use Brotli</a> / <a hreflang="en" href="https://caniuse.com/?search=gzip">can I use Gzip</a>

Quando si desidera utilizzare Gzip, considerare l'utilizzo di [Zopfli](https://en.wikipedia.org/wiki/Zopfli), che genera file compatibili con Gzip più piccoli. Questo dovrebbe essere fatto soprattutto per le risorse precompresse, poiché qui si prevedono <a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">i maggiori benefici</a>. Guarda questo <a hreflang="en" href="https://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/">confronto tra Gzip e Zopfli</a> che tiene conto di diversi livelli di compressione per Gzip.

Molti [server popolari](https://en.wikipedia.org/wiki/HTTP_compression#Servers_that_support_HTTP_compression) supportano HTTP dinamico e/o HTTP precompresso e molti di loro supportano [Brotli](https://it.wikipedia.org/wiki/Brotli).

## Stato corrente della compressione HTTP

Circa il 60% delle risposte HTTP viene fornito senza compressione basata su testo. Questa può sembrare una statistica sorprendente, ma tieni presente che si basa su tutte le risposte HTTP nel set di dati. Alcuni contenuti, come le immagini, non trarranno vantaggio da questi algoritmi di compressione e pertanto non vengono utilizzati spesso, come mostrato nella figura 19.2.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Content Encoding</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">Combinate</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Nessuna compressione del testo</em></td>
        <td class="numeric">60.06%</td>
        <td class="numeric">59.31%</td>
        <td class="numeric">59.67%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">30.82%</td>
        <td class="numeric">31.56%</td>
        <td class="numeric">31.21%</td>
      </tr>
      <tr>
        <td>Brotli</td>
        <td class="numeric">9.10%</td>
        <td class="numeric">9.11%</td>
        <td class="numeric">9.11%</td>
      </tr>
      </tr>
      <tr>
        <td><em>Altro</em></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adozione di algoritmi di compressione.", sheets_gid="1365871671", sql_file="19_01.type_of_content_encoding.sql") }}</figcaption>
</figure>

Delle risorse servite compresse, la maggioranza utilizza Gzip (77%) o Brotli (23%). Gli altri algoritmi di compressione vengono utilizzati di rado.

{{ figure_markup(
  image="compression-algorithms-for-http-responses.png",
  caption="Algoritmo di compressione per le risposte HTTP.",
  description="Un grafico a barre che mostra i tassi di utilizzo di diversi algoritmi di compressione per le risposte HTTP. Il 77.39% delle risposte HTTP che utilizzano la compressione utilizza l'algoritmo Gzip, il 22.59% utilizza Brotli e lo 0.03% utilizza un altro metodo.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1523202090&format=interactive",
  sheets_gid="1365871671",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

Nel grafico sottostante, gli 11 tipi di contenuto principali vengono visualizzati con le dimensioni delle caselle che rappresentano il numero relativo di risposte. Il colore di ogni casella rappresenta quante di queste risorse sono state servite compresse, l'arancione indica una bassa percentuale di compressione mentre il blu indica un'alta percentuale di compressione. La maggior parte dei contenuti multimediali (media content) è ombreggiata in arancione, il che è previsto poiché Gzip e Brotli avrebbero poco o nessun vantaggio per loro. La maggior parte del contenuto del testo è ombreggiato in blu per indicare che è in fase di compressione. Tuttavia, l'ombreggiatura azzurra per alcuni tipi di contenuto indica che non sono compressi in modo coerente come gli altri.

{{ figure_markup(
  image="compression-algorithms-by-content-type-desktop.png",
  caption="Compressione per tipo sulle pagine desktop.",
  description="Grafico ad albero che mostra image/jpeg (91.926.198 risposte - 3.27% compresse), application/javascript (80.360.676 risposte - 84.88% compresse), image/png (66.351.767 risposte - 3.7% compresse), testo/css (54.104.482 risposte - 84.0% compresse) , text/html (48.670.006 risposte - 44.25% compresse), image/gif (39.390.408 risposte - 3.42% compresse), text/javascript (35.491.375 risposte - 90.74% compresse), application/x-javascript (22.714.896 risposte - 93.14% compresse) , application/jsen (13.453.942 risposte - 63.02% compresse), text/plain (4.629.644 risposte - 32.89% compresse).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=777357707&format=interactive",
  sheets_gid="449339162",
  sql_file="19_01.type_of_content_encoding.sql"
  )
}}

La figura 19.1 sopra mostra la percentuale di compressione utilizzata per tipo di contenuto, nella figura 19.6 questa percentuale è indicata come colore. Le due figure raccontano storie simili, le risorse non basate su testo sono raramente compresse, mentre le risorse basate su testo sono spesso compresse. Anche i tassi di compressione sono simili sia per i dispositivi mobile che per i desktop.

## Compressione di prime parti o di terze parti

Nel capitolo [Terze parti](./third-parties), apprendiamo le terze parti e il loro impatto sulle prestazioni. Anche l'utilizzo di terze parti può avere un impatto sulla compressione.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Desktop</th>
        <th scope="colgroup" colspan="2">Mobile</th>
      </tr>
      <tr>
        <th scope="col">Content Encoding</th>
        <th scope="col">Prime parti</th>
        <th scope="col">Terze parti</th>
        <th scope="col">Prime parti</th>
        <th scope="col">Terze parti</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Nessuna compressione del testo</em></td>
        <td class="numeric">61.93%</td>
        <td class="numeric">57.81%</td>
        <td class="numeric">60.36%</td>
        <td class="numeric">58.11%</td>
      </tr>
      <tr>
        <td>Gzip</td>
        <td class="numeric">30.95%</td>
        <td class="numeric">30.66%</td>
        <td class="numeric">32.36%</td>
        <td class="numeric">30.65%</td>
      </tr>
      <tr>
        <td>br</td>
        <td class="numeric">7.09%</td>
        <td class="numeric">11.51%</td>
        <td class="numeric">7.26%</td>
        <td class="numeric">11.22%</td>
      </tr>
      <tr>
        <td>deflate</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td><em>Altro / Non valido</em></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Compressione di prime parti rispetto a quella di terze parti in base al tipo di dispositivo.", sheets_gid="862864630", sql_file="19_03.party_of_content_encoding.sql") }}</figcaption>
</figure>

Quando confrontiamo le tecniche di compressione tra prime e terze parti, possiamo vedere che il contenuto di terze parti tende ad essere compresso più del contenuto di prime parti. Inoltre, la percentuale di compressione Brotli è maggiore per i contenuti di terze parti. Ciò è probabilmente dovuto al numero di risorse fornite dalle terze parti più grandi che in genere supportano Brotli, come Google e Facebook.

Rispetto ai [risultati dello scorso anno](../2019/compression#first-party-vs-third-party-compression), possiamo vedere che c'è stato un aumento significativo nell'uso della compressione, in particolare Brotli per le prime parti, quasi al punto che l'utilizzo della compressione si aggira intorno al 40% sia per prime e terze parti, sia per desktop che mobile. Tuttavia, all'interno delle risposte che utilizzano la compressione, per le prime parti, il rapporto di compressione Brotli è solo del 18%, mentre il rapporto per le terze parti è del 27%.

## Come analizzare la compressione sui tuoi siti

Puoi utilizzare [Firefox Developer Tools](https://developer.mozilla.org/docs/Tools) o <a hreflang="en" href="https://developers.google.com/web/tools/chrome-devtools">Chrome DevTools</a> per capire rapidamente quali contenuti sono già compressi da un sito web. Per fare ciò, vai su Network, fai clic con il pulsante destro del mouse e attiva "Content Encoding" in Response Headers. Passando il mouse sulla dimensione dei singoli file vedrai "transferred over network" e "resource size". Aggregati per l'intero sito si possono vedere le size/transferred size per Firefox e "transferred" e "resources" per Chrome sul lato inferiore sinistro della Network.

{{ figure_markup(
  image="content-encoding.png",
  caption='Utilizza DevTools per verificare se content encoding viene utilizzata sul tuo sito',
  description="Immagine che mostra come utilizzare DevTools per vedere se viene utilizzata content encoding.",
  width=591,
  height=939
  )
}}

Un altro strumento per comprendere meglio la compressione sul tuo sito è lo strumento <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> di Google, che ti consente di eseguire una serie di audit sulle pagine web. Il <a hreflang="en" href="https://web.dev/uses-text-compression/">controllo della compressione del testo</a> valuta se un sito può trarre vantaggio da un'ulteriore compressione basata sul testo. Lo fa tentando di comprimere le risorse e valutare se la dimensione di un oggetto può essere ridotta di almeno il 10% e 1.400 byte. A seconda del punteggio, potresti vedere una raccomandazione di compressione nei risultati, con un elenco di risorse specifiche che potrebbero essere compresse.

Poiché [HTTP Archive esegue gli audit Lighthouse](./methodology#lighthouse) per ogni pagina per dispositivi mobile, possiamo aggregare i punteggi di tutti i siti per scoprire quante opportunità ci sono per comprimere più contenuti. Complessivamente, il 74% dei siti Web ha superato questo audit, mentre quasi il 13% dei siti Web ha ottenuto un punteggio inferiore a 40. Si tratta di un miglioramento dell'11.5% rispetto al 62.5% [dello scorso anno](../2019/compression#identifying-compression-opportunities).

{{ figure_markup(
  image="text-compression-lighthouse-scores.png",
  caption="Compressione del testo punteggi Lighthouse.",
  description='Grafico a barre in pila che suddivide i punteggi ricevuti dalle pagine per l\'audit Lighthouse "enable text compression". Mostra che il 7% dei siti ha un punteggio inferiore al 10%, il 6% dei siti ha un punteggio compreso tra il 10 e il 39%, il 10% dei siti ha un punteggio compreso tra il 40 e il 79%, il 3% dei siti ha un punteggio compreso tra l\'80 e il 99% e il 74% dei siti è passato con oltre il 100% delle risorse di testo compresse.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTxUj8-0vKTqPAblIXqekSbiRh1D1lEuA3gVD9w23qwGPtJRE8FbgrURfPAgfFZX2l0t84Wy5ZAGqzR/pubchart?oid=1438276663&format=interactive",
  sheets_gid="1284073179",
  sql_file="19_04.distribution_of_text_compression_lighthouse.sql"
  )
}}

## Conclusione

Rispetto all'[Almanacco dell'anno scorso](../2019/compression), c'è una chiara tendenza verso l'utilizzo di una maggiore compressione del testo. Il numero di risposte che non utilizzano alcuna compressione del testo è sceso di poco più del 2%, mentre allo stesso tempo l'utilizzo di Brotli è aumentato di quasi il 2%. I punteggi di Lighthouse sono migliorati in modo significativo.

La compressione del testo è ampiamente utilizzata per i formati pertinenti, sebbene esista ancora una percentuale significativa di risposte HTTP che potrebbero trarre vantaggio da una compressione aggiuntiva. Puoi trarre vantaggio esaminando la configurazione del tuo server e regolando i metodi e i livelli di compressione a tuo piacimento. Un grande impatto per un'esperienza utente più positiva potrebbe essere ottenuto scegliendo attentamente le impostazioni predefinite per i server HTTP più popolari.
