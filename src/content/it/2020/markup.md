---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Markup
description: Capitolo Markup del Web Almanac 2020 che copre le osservazioni generali, l'uso di elementi e attributi, nonché curiosità e tendenze.
hero_alt: Hero image of Web Almanac characters as dressed as constructor workers putting together a web page from HTML element blocks.
authors: [j9t, catalinred, iandevlin]
j9t_bio: Jens Oliver Meiert è uno sviluppatore web e autore (<a hreflang="en" href="https://leanpub.com/css-optimization-basics"><cite>CSS Optimization Basics</cite></a>, <a hreflang="en" href="https://leanpub.com/web-development-glossary"><cite>The Web Development Glossary</cite></a>), che lavora come responsabile tecnico presso <a hreflang="en" href="https://www.jimdo.com/">Jimdo</a>. È un esperto di sviluppo web dove è specializzato in ottimizzazione HTML e CSS. Jens contribuisce agli standard tecnici e scrive regolarmente del suo lavoro e della sua ricerca, in particolare sul suo sito web, <a hreflang="en" href="https://meiert.com/en/">meiert.com</a>.
catalinred_bio: Catalin Rosu è uno sviluppatore front-end di <a hreflang="en" href="https://www.caphyon.com/">Caphyon</a> e attualmente lavora su <a hreflang="en" href="https://www.wattspeed.com/">Wattspeed</a>. Ha una passione per gli standard web e un occhio attento per la grande UX e UI, cose di cui <a href="https://x.com/catalinred">twitta</a> e scrive sul suo <a hreflang="en" href="https://catalin.red/">sito web</a>.
iandevlin_bio: Ian Devlin è uno sviluppatore web che sostiene il buon HTML semantico e l'accessibilità. Una volta ha scritto un libro su <a hreflang="en" href="https://www.peachpit.com/store/html5-multimedia-develop-and-design-9780321793935">HTML5 Multimedia</a>, e scrive sporadicamente sul suo <a hreflang="en" href="https://iandevlin.com/">sito web</a> sul Web e altre cose. Attualmente lavora come Senior Frontend Engineer presso <a hreflang="de" href="https://www.real-digital.de/">real.digital</a> in Germania.
reviewers: [zcorpan, matuzo, bkardell]
analysts: [Tiggerito]
editors: [rviscomi]
translators: [chefleo]
discuss: 2039
results: https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/
featured_quote: Ci avviciniamo all'adozione quasi completa dell'HTML vivente, siamo rapidi a sfoltire le nostre pagine dalle mode e siamo veloci nell'adottare ed evitare i framework. E ancora, non ci sono segni che abbiamo esaurito le opzioni che l'HTML ci offre.
featured_stat_1: 85.73%
featured_stat_label_1: Percentuale di pagine che utilizzano il doctype HTML "vivente"
featured_stat_2: 30,073
featured_stat_label_2: Numero di elementi `h7` non standard
featured_stat_3: 25.24 KB
featured_stat_label_3: Peso del documento mediano
---

## Introduzione

Il Web è basato su HTML. Senza HTML non ci sono pagine web, né siti web, né app web. Niente. Potrebbero esserci documenti di testo semplice, forse, o alberi XML, in qualche universo parallelo che ha apprezzato quel particolare tipo di sfida. In questo universo, l'HTML è il fondamento del Web rivolto agli utenti. Ci sono molti standard su cui poggia il web, ma l'HTML è sicuramente uno dei più importanti.

Come utilizziamo l'HTML, quindi, qual è la grande base che abbiamo? Nella sezione introduttiva del [capitolo Markup 2019](../2019/markup#introduction), l'autore [Brian Kardell](../2019/contributors#bkardell) ha suggerito che per molto tempo non lo sapevamo veramente. C'erano alcuni campioni più piccoli. Ad esempio, c'era la <a hreflang="en" href="https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html">ricerca di Ian Hickson</a> (uno dei genitori dell'HTML moderno) tra gli altri, ma fino allo scorso anno ci mancava una visione approfondita di come noi sviluppatori, come autori, utilizziamo l'HTML. Nel 2019 abbiamo avuto sia il <a hreflang="en" href="https://www.advancedwebranking.com/html/">lavoro di Catalin Rosu</a> (uno dei coautori di questo capitolo) che l'edizione 2019 del Web Almanac per darci di nuovo una visione migliore dell'HTML nella pratica.

L'analisi dello scorso anno si è basata su 5.8 milioni di pagine, di cui 4.4 milioni testate su desktop e 5.3 milioni su dispositivi mobile. Quest'anno abbiamo analizzato 7.5 milioni di pagine, di cui 5.6 milioni testate su desktop e 6.3 milioni su mobile, utilizzando i [dati più recenti](./methodology#websites) sui siti web che gli utenti visiteranno nel 2020. Facciamo alcuni confronti con lo scorso anno, ma proprio come abbiamo cercato di analizzare ulteriori metriche per nuovi approfondimenti, abbiamo anche cercato di trasmettere le nostre personalità e prospettive durante il capitolo.

<p class="note">
  In questo capitolo Markup, ci stiamo concentrando quasi esclusivamente su HTML, piuttosto che su SVG o MathML, che sono anche considerati linguaggi di markup. Se non diversamente specificato, le statistiche presentate in questo capitolo si riferiscono al set di pagine mobile. Inoltre, i dati per tutti i capitoli di Web Almanac sono liberi e disponibili. Dai un'occhiata ai <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1Ta7amoUeaL4pILhWzH-SCzMX9PsZeb1x_mwrX2C4eY8/">risultati</a> e <a hreflang="en" href="https://discuss.httparchive.org/t/2039">condividi le tue osservazioni</a> con la community!
</p>

## Generale

In questa sezione, tratteremo gli aspetti di livello superiore dell'HTML come i tipi di documenti, la dimensione dei documenti, nonché l'uso di commenti e script. "HTML Vivente" è molto vivo!

### Doctypes

{{ figure_markup(
  caption="Percentuale di pagine con un doctype.",
  content="96.82%",
  classes="big-number",
  sheets_gid="1981441894",
  sql_file="summary_pages_by_device_and_doctype.sql"
) }}

Il 96.82% delle pagine dichiara un [_doctype_](https://developer.mozilla.org/docs/Glossary/Doctype). I documenti HTML che dichiarano un doctype sono utili per ragioni storiche, "per evitare di attivare la modalità quirks nei browser", come <a hreflang="en" href="https://lists.w3.org/Archives/Public/public-html-comments/2009Jul/0020.html">ha spiegato Ian Hickson nel 2009</a>. Quali sono i valori più popolari?

<figure>
  <table>
    <thead>
      <tr>
        <th>Doctype</th>
        <th>Pagine</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTML ("HTML5")</td>
        <td class="numeric">5,441,815</td>
        <td class="numeric">85.73%</td>
      </tr>
      <tr>
        <td>XHTML 1.0 Transitional</td>
        <td class="numeric">382,322</td>
        <td class="numeric">6.02%</td>
      </tr>
      <tr>
        <td>XHTML 1.0 Strict</td>
        <td class="numeric">107,351</td>
        <td class="numeric">1.69%</td>
      </tr>
      <tr>
        <td>HTML 4.01 Transitional</td>
        <td class="numeric">54,379</td>
        <td class="numeric">0.86%</td>
      </tr>
      <tr>
        <td>HTML 4.01 Transitional (<a hreflang="en" href="https://hsivonen.fi/doctype/#xml">quirky</a>)</td>
        <td class="numeric">38,504</td>
        <td class="numeric">0.61%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="I 5 doctype più popolari.", sheets_gid="1981441894", sql_file="summary_pages_by_device_and_doctype.sql") }}</figcaption>
</figure>

Puoi già dire come i numeri diminuiscano un po' dopo XHTML 1.0, prima di entrare nella coda lunga con alcuni doctype standard, alcuni esoterici e anche fasulli.

Due cose si distinguono da questi risultati:

1. Quasi 10 anni dopo <a hreflang="en" href="https://blog.whatwg.org/html-is-the-new-html5">l'annuncio dell'HTML vivente</a> (noto anche come "HTML5"), l'HTML vivente è chiaramente diventato la norma.
2. Il web prima del HTML vivente può ancora essere visto nei prossimi doctype più popolari, come XHTML 1.0. XHTML. Sebbene i loro documenti siano probabilmente forniti come HTML con un tipo MIME di `text/html`, questi vecchi doctype non sono ancora morti.

### Dimensioni del documento

La dimensione del documento di una pagina si riferisce alla quantità di byte HTML trasferiti sulla rete, inclusa la compressione se abilitata. Agli estremi del set di 6.3 milioni di documenti:

* 1.110 documenti sono vuoti (0 bytes).
* La dimensione media del documento è 49.17 KB (<a hreflang="en" href="https://w3techs.com/technologies/details/ce-gzipcompression">nella maggior parte dei casi compressi</a>).
* Il documento più grande pesa di gran lunga 61.19 _MB_, quasi meritando una propria analisi e capitolo nel Web Almanac.

Come è questa situazione in generale, allora? Il documento mediano pesa 24.65 KB, che arriva <a hreflang="en" href="https://httparchive.org/reports/page-weight">senza sorprese</a>:

{{ figure_markup(
  image="document-size.png",
  caption="La quantità di byte HTML trasferiti sulla rete, inclusa la compressione se abilitata.",
  description="Dimensioni del documento in byte per percentile, con il documento mediano che pesa 25,99 KB sul desktop.",
  sheets_gid="2066175354",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=386686971&format=interactive",
  sql_file="summary_pages_by_device_and_percentile.sql"
  )
}}

### Lingua del documento

Abbiamo identificato 2.863 valori diversi per l'attributo `lang` nel tag di inizio `html` (confrontandole con le <a hreflang="en" href="https://www.ethnologue.com/guides/how-many-languages">7.117 lingue parlate</a> secondo l'Etnologo). Quasi tutti sembrano validi, secondo il capitolo [Accessibilità](./accessibility#language-identification).

Il 22,36% di tutti i documenti non specifica alcun attributo `lang`. L'opinione comunemente accettata è che <a hreflang="en" href="https://www.w3.org/TR/i18n-html-tech-lang/#overall">dovrebbero</a>, ma ignorano il fatto che il software potrebbe eventualmente <a hreflang="en" href="https://meiert.com/en/blog/lang/">rilevare automaticamente la lingua</a>, la lingua del documento può anche essere specificata [a livello di protocollo](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Language), cosa che non abbiamo controllato.

Ecco le 10 lingue più popolari (normalizzate) nel nostro campione. È importante notare che l'HTTP Archive esegue la scansione dai data center degli Stati Uniti con le impostazioni della lingua inglese, quindi guardando le pagine della lingua in cui sono scritte, sarà orientato verso l'inglese. Tuttavia presentiamo gli attributi `lang` visti per dare un contesto ai siti analizzati.

{{ figure_markup(
  image="document-language.png",
  caption="I principali attributi HTML `lang`.",
  description="Grafico a barre che mostra i primi 10 attributi `lang` utilizzati nella nostra scansione con il 22.82% delle pagine desktop e il 22.36% delle pagine mobile che non lo impostano, `en` utilizzato rispettivamente al 20.09% e 18.08%, `ja` al 15.17% e 13.27%, `es` su 4.86% e 4.09%, `pt-br` su 2.65% e 2.84%, `ru` su 2.21% 2.53%, `en-gb` su 2.35% e 2.19%, `de` su 1.50 % e 1.92%, e infine `fr` utilizzato rispettivamente su 1.55% e 1.43%.",
  sheets_gid="2047285366",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1873310240&format=interactive",
  sql_file="pages_almanac_by_device_and_html_lang.sql"
  )
}}

### Commenti

L'aggiunta di commenti al codice è generalmente una buona pratica e i commenti HTML sono lì per aggiungere note ai documenti HTML, senza che siano visualizzati dai programmi utente.

```html
<!-- Questo è un commento in HTML -->
```

Sebbene molte pagine siano state private dei commenti per la produzione, abbiamo riscontrato che le home page nel 90° percentile utilizzano circa 73 commenti su dispositivo mobile, rispettivamente 79 commenti su desktop, mentre nel 10° percentile il numero di commenti è di circa 2. La pagina mediana utilizza 16 commenti (mobile) o 17 commenti (desktop).

Circa l'89% delle pagine contiene almeno un commento HTML, mentre circa il 46% di esse contiene un commento condizionale.

#### Commenti condizionali

```html
<!--[if IE 8]>
  <p>Viene eseguito solo in Internet Explorer 8.</p>
<![endif]-->
```

Quanto sopra è un commento condizionale HTML non standard. Sebbene questi si siano dimostrati utili in passato per affrontare le differenze del browser, sono stati consegnati alla cronologia per un po' di tempo poiché Microsoft <a hreflang="en" href="https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/compatibility/hh801214(v=vs.85)">ha rilasciato commenti condizionali</a>) in Internet Explorer 10.

Tuttavia, agli estremi percentili sopra, abbiamo scoperto che le pagine web utilizzano circa 6 commenti condizionali nel 90° percentile e 1 commento condizionale nel 10° percentile.  La maggior parte delle pagine li include come aiutanti quali <a hreflang="en" href="https://github.com/aFarkas/html5shiv">html5shiv</a>, [selectivizr](http://selectivizr.com/), and <a hreflang="en" href="https://github.com/scottjehl/Respond">respond.js</a>. Pur essendo pagine decenti e ancora attive, la nostra conclusione è che molte di esse utilizzavano temi CMS obsoleti.

Per la produzione, i commenti HTML vengono solitamente rimossi dagli strumenti di compilazione. Considerando tutti i conteggi e le percentuali di cui sopra e facendo riferimento all'uso dei commenti in generale, supponiamo che molte pagine vengano servite senza coinvolgere un minificatore HTML.

### Utilizzo dello script

Come mostrato nella sezione [Elementi principali](#gli-elementi-principali) di seguito, l'elemento `script` è il sesto elemento HTML utilizzato più di frequente. Per gli scopi di questo capitolo, eravamo interessati al modo in cui l'elemento `script` viene utilizzato in questi milioni di pagine dal set di dati.

Complessivamente, circa il 2% delle pagine non contiene affatto script, nemmeno script di dati strutturati con l'attributo `type="application/ld+json"`. Considerando che al giorno d'oggi è abbastanza comune per una pagina includere almeno uno script per una soluzione di analisi, questo sembra degno di nota.

All'estremità opposta dello spettro, i numeri mostrano che circa il 97% delle pagine contiene almeno uno script, inline o esterno.

{{ figure_markup(
  image="script-use.png",
  caption="Utilizzo dell'elemento <code> script </code>.",
  description="Le percentuali di pagine (non) contenenti script e gli script sono presenti in quasi tutte le forme su quasi tutte le pagine.",
  sheets_gid="150962402",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1895084382&format=interactive",
  sql_file="pages_almanac_by_device.sql"
  )
}}

Quando lo scripting non è supportato o è disattivato nel browser, l'elemento `noscript` aiuta ad aggiungere una sezione HTML all'interno di una pagina. Considerando i numeri di script sopra, eravamo curiosi anche dell'elemento `noscript`.

A seguito dell'analisi, abbiamo scoperto che circa il 49% delle pagine utilizza un elemento `noscript`. Allo stesso tempo, circa il 16% degli elementi `noscript` contengono un `iframe` con un valore `src` che fa riferimento a "googletagmanager.com".

Questo sembra confermare la teoria secondo cui il numero totale di elementi `noscript` in natura potrebbe essere influenzato da script comuni come Google Tag Manager che impongono agli utenti di aggiungere uno snippet `noscript` dopo il tag di inizio `body` su una pagina.

#### Tipi di script

Quali valori di attributo `type` sono usati con gli elementi `script`?

- `text/javascript`: 60.03%
- `application/ld+json`: 1.68%
- `application/json`: 0.41%
- `text/template`: 0.41%
- `text/html`: 0.27%

Quando si tratta di caricare <a hreflang="en" href="https://jakearchibald.com/2017/es-modules-in-browsers/">gli script del modulo JavaScript</a> usando `type ="module"`, abbiamo scoperto che lo 0,13% degli elementi `script` attualmente specifica questa combinazione di attributo-valore. `nomodule` è utilizzato dallo 0,95% di tutte le pagine testate. (Nota che una metrica si riferisce agli elementi, l'altra alle pagine.)

Il 36.38% di tutti gli script non ha alcun valore di `type` impostato.

## Elementi

In questa sezione, ci concentriamo sugli elementi: quali elementi vengono utilizzati, con quale frequenza, quali elementi probabilmente appariranno in una determinata pagina e com'è viene utilizzato in rispetto ad altri elementi personalizzati, obsoleti e proprietari. Ed è la pratica di <a hreflang="en" href="https://en.wiktionary.org/wiki/divitis">_divitis_</a> ancora in uso? Sì.

### Diversità degli elementi

Diamo un'occhiata a quanto sia diversificato l'uso dell'HTML: gli autori usano molti elementi diversi o stiamo guardando un panorama che fa uso di relativamente pochi elementi?

La pagina web mediana, risulta, utilizza 30 elementi diversi, 587 volte:

{{ figure_markup(
  image="element-diversity-element-types.png",
  caption="Distribuzione del numero di tipi di elementi per pagina.",
  description="Tipi di elementi per percentile, con il 90% delle pagine che utilizza almeno 20 elementi diversi.",
  sheets_gid="46490104",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=924238918&format=interactive",
  sql_file="pages_element_count_by_device_and_percentile.sql"
  )
}}

{{ figure_markup(
  image="element-diversity.png",
  caption="Distribuzione del numero totale di elementi per pagina per percentile.",
  description="Elementi per percentile, che mostra come il 10% di tutte le pagine utilizzi più di 1.665 elementi.",
  sheets_gid="46490104",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=680594018&format=interactive",
  sql_file="pages_element_count_by_device_and_percentile.sql"
  )
}}

Dato che <a hreflang="en" href="https://html.spec.whatwg.org/multipage/">HTML vivente</a> ha attualmente 112 elementi, il 90° percentile che non utilizza più di 41 elementi può suggerire che l'HTML non è quasi esaurito dalla maggior parte dei documenti. Tuttavia è difficile interpretare cosa questo significhi veramente per HTML e il nostro uso di esso, poiché la ricchezza semantica che l'HTML offre non significa che ogni documento avrebbe bisogno di tutto: gli elementi HTML dovrebbero essere usati per scopo (semantica), non per disponibilità.

Come vengono distribuiti questi elementi?

{{ figure_markup(
  image="distribution-of-elements-per-page.png",
  caption="Distribuzione del numero totale di elementi per pagina.",
  description="Distribuzione degli elementi in un grafico a dispersione e anche per un osservatore esperto è difficile analizzarlo; interessante è un grande gruppo di circa 7.500 pagine ciascuna che utilizza circa 250 elementi, dopodiché sempre meno pagine tornano a un numero sempre maggiore di elementi.",
  sheets_gid="1361520223",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQPKzFb574UnGTcfw5mcD1qR7RYHyGjQTc2hiMuYix0QoTH1DPe54Q2JucXL8bfZ6kjRoAfhk3ckudc/pubchart?oid=1468756779&format=interactive",
  sql_file="pages_element_count_by_device_and_element_count.sql"
  )
}}

Non è cambiato molto [rispetto al 2019](../2019/markup#fig-3)!

### Gli elementi principali

Nel 2019, il capitolo Markup del Web Almanac presentava gli elementi più frequentemente utilizzati in riferimento <a hreflang="en" href="https://web.archive.org/web/20060203031713/http://code.google.com/webstats/2005-12/elements.html">al lavoro di Ian Hickson nel 2005</a>. Lo abbiamo trovato utile e abbiamo dato di nuovo un'occhiata a quei dati:

<figure>
  <table>
    <thead>
      <tr>
        <th>2005</th>
        <th>2019</th>
        <th>2020</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>title</code></td>
        <td><code>div</code></td>
        <td><code>div</code></td>
      </tr>
      <tr>
        <td><code>a</code></td>
        <td><code>a</code></td>
        <td><code>a</code></td>
      </tr>
      <tr>
        <td><code>img</code></td>
        <td><code>span</code></td>
        <td><code>span</code></td>
      </tr>
      <tr>
        <td><code>meta</code></td>
        <td><code>li</code></td>
        <td><code>li</code></td>
      </tr>
      <tr>
        <td><code>br</code></td>
        <td><code>img</code></td>
        <td><code>img</code></td>
      </tr>
      <tr>
        <td><code>table</code></td>
        <td><code>script</code></td>
        <td><code>script</code></td>
      </tr>
      <tr>
        <td><code>td</code></td>
        <td><code>p</code></td>
        <td><code>p</code></td>
      </tr>
      <tr>
        <td><code>tr</code></td>
        <td><code>option</code></td>
        <td><code>link</code></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td><code>i</code></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td><code>option</code></td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Gli elementi più popolari nel 2005, 2019 e 2020.", sheets_gid="781932961", sql_file="pages_element_count_by_device_and_element_type_frequency.sql") }}</figcaption>
</figure>

Non è cambiato nulla nella Top 7, ma l'elemento `option` sta perdendo popolarità ed è sceso da 8 a 10, lasciando che sia l'elemento `link` che l'elemento `i` passassero in popolarità. Questi elementi sono aumentati in uso, probabilmente a causa di un aumento nell'uso di [resource hints](./resource-hints) (come con il prerendering e il prefetching), così come le soluzioni di icone come <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>, che _de facto_ abusa degli elementi `i` allo scopo di visualizzare icone.

#### `details` e `summary`

Un'altra cosa che ci incuriosiva era l'uso degli <a hreflang="en" href="https://html.spec.whatwg.org/multipage/rendering.html#the-details-and-summary-elements">elementi `details` e `summary`</a>, soprattutto dal 2020 ha portato <a hreflang="en" href="https://caniuse.com/details">ampio sostegno</a>. Vengono utilizzati? Sono attraenti - anche popolari - tra gli autori? A quanto pare, solo lo 0,39% di tutte le pagine testate le utilizza - anche se è difficile valutare se sono state utilizzate tutte nel modo corretto esattamente nelle situazioni in cui ne hai bisogno - "popolare" è la parola sbagliata.

Ecco un semplice esempio che mostra l'uso di un `summary` in un elemento `details`:

```html
<details>
  <summary>Status: Operativo</summary>
  <p>Velocità: 12m/s</p>
  <p>Direzione: Nord</p>
</details>
```

Tempo fa, Steve Faulkner [ha sottolineato](https://x.com/stevefaulkner/status/806474286592561152) come questi due elementi fossero usati in modo inadeguato in natura. Come puoi vedere dall'esempio sopra, per ogni elemento `details` avresti bisogno di un elemento `summary` che può essere usato solo come [primo figlio](https://developer.mozilla.org/docs/Web/HTML/Element/summary#Usage_notes) di `details`.

Di conseguenza, abbiamo esaminato il numero di elementi `details` e `summary` e sembra che continuino ad essere utilizzati in modo improprio. Il conteggio degli elementi `summary` è maggiore sia su dispositivi mobile che desktop, con un rapporto di 1.11 elementi `summary` per ogni elemento `details` su dispositivi mobile e 1.19 su desktop, rispettivamente:

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >Occorrenze</th>
      </tr>
      <tr>
        <th scope="col">Elemento</th>
        <th scope="col">Mobile (0.39%)</th>
        <th scope="col">Desktop (0.22%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>summary</code></td>
        <td class="numeric">62,992</td>
        <td class="numeric">43,936</td>
      </tr>
      <tr>
        <td><code>details</code></td>
        <td class="numeric">56,60</td>
        <td class="numeric">36,743</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adozione degli elementi <code> details </code> e <code> summary </code>.", sheets_gid="1406534257", sql_file="pages_element_count_by_device.sql") }}</figcaption>
</figure>

### Probabilità di utilizzo dell'elemento

Dando un'altra occhiata alla popolarità degli elementi, quante probabilità ci sono di trovare un determinato elemento nel DOM di una pagina? Certo, `html`, `head`, `body` sono presenti in ogni pagina HTML (anche se <a hreflang="en" href="https://meiert.com/en/blog/optional-html/">questi tag sono tutti opzionali</a>), rendendoli elementi comuni, ma quali altri elementi si trovano comunemente?

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento</th>
        <th>Probabilità</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>title</code></td>
        <td class="numeric">99.34%</td>
      </tr>
      <tr>
        <td><code>meta</code></td>
        <td class="numeric">99.00%</td>
      </tr>
      <tr>
        <td><code>div</code></td>
        <td class="numeric">98.42%</td>
      </tr>
      <tr>
        <td><code>a</code></td>
        <td class="numeric">98.32%</td>
      </tr>
      <tr>
        <td><code>link</code></td>
        <td class="numeric">97.79%</td>
      </tr>
      <tr>
        <td><code>script</code></td>
        <td class="numeric">97.73%</td>
      </tr>
      <tr>
        <td><code>img</code></td>
        <td class="numeric">95.83%</td>
      </tr>
      <tr>
        <td><code>span</code></td>
        <td class="numeric">93.98%</td>
      </tr>
      <tr>
        <td><code>p</code></td>
        <td class="numeric">88.71%</td>
      </tr>
      <tr>
        <td><code>ul</code></td>
        <td class="numeric">87.68%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Elevate probabilità di trovare un dato elemento nelle pagine del campione Web Almanac 2020.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

Gli elementi standard sono quelli che fanno o facevano parte della specifica HTML. Quali sono rari da trovare? Nel nostro esempio, ciò porterebbe a quanto segue:

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento</th>
        <th>Probabilità</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>dir</code></td>
        <td class="numeric">0.0082%</td>
      </tr>
      <tr>
        <td><code>rp</code></td>
        <td class="numeric">0.0087%</td>
      </tr>
      <tr>
        <td><code>basefont</code></td>
        <td class="numeric">0.0092%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Scarse probabilità di trovare un dato elemento nelle pagine del campione.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

Includiamo questi elementi per dare un'idea di quali elementi potrebbero perdere di popolarità. Ma mentre `dir` e `basefont` sono stati specificati l'ultima volta in XHTML 1.0 (2000) e non fanno più parte dell'HTML, il raro uso di `rp` (che è stato menzionato <a hreflang="en" href="https://www.w3.org/TR/1998/WD-ruby-19981221/#a2-4">già nel 1998</a> ed è <a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-rp-element">ancora parte dell'HTML</a>), potrebbe semplicemente suggerire che il <a hreflang="en" href="https://www.w3.org/TR/ruby/">markup di Ruby</a> non è molto popolare.

### Elementi personalizzati

L'edizione 2019 del Web Almanac ha gestito [elementi personalizzati](../2019/markup#custom-elements) discutendo diversi elementi non standard. Quest'anno abbiamo ritenuto utile esaminare più da vicino gli elementi personalizzati. Come li abbiamo determinati? Approssimativamente guardando <a hreflang="en" href="https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements-core-concepts">la loro definizione</a>, in particolare il loro uso di un trattino. Concentriamoci sugli elementi principali, in questo caso elementi utilizzati su ≥1% di tutti gli URL nel campione:

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento</th>
        <th>Pagine</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>ym-measure</code></td>
        <td class="numeric">141,156</td>
        <td class="numeric">2.22%</td>
      </tr>
      <tr>
        <td><code>wix-image</code></td>
        <td class="numeric">76,969</td>
        <td class="numeric">1.21%</td>
      </tr>
      <tr>
        <td><code>rs-module-wrap</code></td>
        <td class="numeric">71,272</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><code>rs-module</code></td>
        <td class="numeric">71,271</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><code>rs-slide</code></td>
        <td class="numeric">70,970</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><code>rs-slides</code></td>
        <td class="numeric">70,993</td>
        <td class="numeric">1.12%</td>
      </tr>
      <tr>
        <td><code>rs-sbg-px</code></td>
        <td class="numeric">70,414</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>rs-sbg-wrap</code></td>
        <td class="numeric">70,414</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>rs-sbg</code></td>
        <td class="numeric">70,413</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>rs-progress</code></td>
        <td class="numeric">70,651</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>rs-mask-wrap</code></td>
        <td class="numeric">63,871</td>
        <td class="numeric">1.01%</td>
      </tr>
      <tr>
        <td><code>rs-loop-wrap</code></td>
        <td class="numeric">63,870</td>
        <td class="numeric">1.01%</td>
      </tr>
      <tr>
        <td><code>rs-layer-wrap</code></td>
        <td class="numeric">63,849</td>
        <td class="numeric">1.01%</td>
      </tr>
      <tr>
        <td><code>wix-iframe</code></td>
        <td class="numeric">63,590</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="I 14 elementi personalizzati più popolari.", sheets_gid="770933671", sql_file="pages_element_count_by_device_and_custom_dash_elements.sql") }}</figcaption>
</figure>

Questi elementi provengono da tre fonti: <a hreflang="en" href="https://metrica.yandex.com/about">Yandex Metrica</a> (`ym-`), una soluzione di analisi che abbiamo visto anche l'anno scorso; <a hreflang="en" href="https://www.sliderrevolution.com/">Slider Revolution</a> (`rs-`), uno slider di WordPress, per cui ci sono più elementi da trovare vicino alla parte superiore del campione; e <a hreflang="en" href="https://www.wix.com/">Wix</a> (`wix-`), un costruttore di siti web.

Altri gruppi che si distinguono includono <a hreflang="en" href="https://amp.dev/">AMP markup</a> su elementi `amp-` come `amp-img` (11.700 pagine), `amp-analytics` (10.256) e `amp-auto-ads` (7.621), nonché elementi <a hreflang="en" href="https://angular.io/">Angular</a> `app-` come `app-root` (16,314), `app-footer` (6,745) e `app-header` (5,274).

### Elementi obsoleti

Ci sono altre domande da porre sull'uso dell'HTML, incluso l'uso di elementi obsoleti (che sono elementi come `applet`,`bgsound`, `blink`, `center`, `font`, `frame`, `isindex` , `marquee` o `spacer`).

Nel nostro set di dati mobile di 6,3 milioni di pagine, circa 0,9 milioni di pagine (14,01%) contengono uno o più di questi elementi. Ecco i primi 9, che vengono utilizzati più di 10.000 volte:

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento</th>
        <th>Pagine</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>center</code></td>
        <td class="numeric">458,402</td>
        <td class="numeric">7.22%</td>
      </tr>
      <tr>
        <td><code>font</code></td>
        <td class="numeric">430,987</td>
        <td class="numeric">6.79%</td>
      </tr>
      <tr>
        <td><code>marquee</code></td>
        <td class="numeric">67,781</td>
        <td class="numeric">1.07%</td>
      </tr>
      <tr>
        <td><code>nobr</code></td>
        <td class="numeric">31,138</td>
        <td class="numeric">0.49%</td>
      </tr>
      <tr>
        <td><code>big</code></td>
        <td class="numeric">27,578</td>
        <td class="numeric">0.43%</td>
      </tr>
      <tr>
        <td><code>frame</code></td>
        <td class="numeric">19,363</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td><code>frameset</code></td>
        <td class="numeric">19,163</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td><code>strike</code></td>
        <td class="numeric">17,438</td>
        <td class="numeric">0.27%</td>
      </tr>
      <tr>
        <td><code>noframes</code></td>
        <td class="numeric">15,016</td>
        <td class="numeric">0.24%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Elementi obsoleti con più di 10.000 utilizzi.", sheets_gid="1972617631", sql_file="pages_element_count_by_device_and_obsolete_elements.sql") }}</figcaption>
</figure>

Anche `spacer` viene ancora utilizzato 1.584 volte e presente su ogni 5.000 pagine. Sappiamo che Google utilizza un elemento `center` sulla <a hreflang="en" href="https://www.google.com/">home page</a> <a hreflang="en" href="https://web.archive.org/web/19981202230410/https://www.google.com/">da 22 anni ormai</a>, ma perché ci sono così tanti imitatori?

#### `isindex`

Se ti stavi chiedendo: il numero totale di elementi <a hreflang="en" href="https://www.w3.org/TR/html401/interact/forms.html#edef-ISINDEX">`isindex`</a> in questo set di dati è: uno. Esattamente una pagina utilizzava un elemento `isindex`. `isindex` faceva parte delle specifiche fino a <a hreflang="en" href="https://meiert.com/en/indices/html-elements/">HTML 4.01 e XHTML 1.0</a>, ma solo correttamente <a hreflang="en" href="https://lists.w3.org/Archives/Public/public-whatwg-archive/2006Feb/0111.html">specificato</a> nel 2006 (in linea con il modo in cui è stato implementato nei browser), quindi <a hreflang="en" href="https://github.com/whatwg/html/pull/1095">rimosso</a> nel 2016.

### Elementi proprietari e inventati

Nel nostro insieme di elementi ne abbiamo trovati alcuni che non erano né elementi HTML standard (né SVG né MathML), né personalizzati, né obsoleti, ma in qualche modo proprietari. I primi 10 che abbiamo individuato sono i seguenti:

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>noindex</code></td>
        <td class="numeric">0.89%</td>
      </tr>
      <tr>
        <td><code>jdiv</code></td>
        <td class="numeric">0.85%</td>
      </tr>
      <tr>
        <td><code>mediaelementwrapper</code></td>
        <td class="numeric">0.49%</td>
      </tr>
      <tr>
        <td><code>ymaps</code></td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td><code>yatag</code></td>
        <td class="numeric">0.20%</td>
      </tr>
      <tr>
        <td><code>ss</code></td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>include</code></td>
        <td class="numeric">0.08%</td>
      </tr>
      <tr>
        <td><code>olark</code></td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td><code>h7</code></td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td><code>limespot</code></td>
        <td class="numeric">0.05%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Elementi di discutibile eredità.", sheets_gid="184700688", sql_file="pages_element_count_by_device_and_element_type_present.sql") }}</figcaption>
</figure>

La fonte di questi elementi sembra essere mista, poiché in alcuni sono sconosciuti mentre altri possono essere rintracciati.  Il più popolare, `noindex`, è probabilmente dovuto al fatto che <a hreflang="en" href="https://yandex.com/support/webmaster/adding-site/indexing-prohibition.html">la raccomandazione di Yandex</a> proibisce l'indicizzazione delle pagine. `jdiv` è stato annotato in [Web Almanac dell'anno scorso](../2019/markup#products-and-libraries-and-their-custom-markup) ed è di JivoChat. `mediaelementwrapper` proviene dal lettore multimediale MediaElement. Sia `ymaps` che `yatag` sono anch'essi di Yandex. L'elemento `ss` potrebbe provenire da ProStores, un precedente prodotto di e-commerce di eBay, e `olark` potrebbe provenire dal software di chat Olark. `h7` sembra essere un errore. `limespot` è probabilmente correlato al programma di personalizzazione Limespot per l'e-commerce. Nessuno di questi elementi fa parte di uno standard web.

### Le intestazioni

<a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#heading-content">Le intestazioni</a> rappresentano una categoria speciale di elementi che svolgono un ruolo importante nel <a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#sectioning-content-2">sezionamento</a> e per <a hreflang="en" href="https://www.w3.org/WAI/tutorials/page-structure/headings/">accessibilità</a>.

<figure>
  <table>
    <thead>
      <tr>
        <th>Intestazione</th>
        <th>Occorrenze</th>
        <th>Media per pagina</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>h1</code></td>
        <td class="numeric">10,524,810</td>
        <td class="numeric">1.66</td>
      </tr>
      <tr>
        <td><code>h2</code></td>
        <td class="numeric">37,312,338</td>
        <td class="numeric">5.88</td>
      </tr>
      <tr>
        <td><code>h3</code></td>
        <td class="numeric">44,135,313</td>
        <td class="numeric">6.96</td>
      </tr>
      <tr>
        <td><code>h4</code></td>
        <td class="numeric">20,473,598</td>
        <td class="numeric">3.23</td>
      </tr>
      <tr>
        <td><code>h5</code></td>
        <td class="numeric">8,594,500</td>
        <td class="numeric">1.36</td>
      </tr>
      <tr>
        <td><code>h6</code></td>
        <td class="numeric">3,527,470</td>
        <td class="numeric">0.56</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Frequenza e utilizzo medio di elementi di intestazione standard.", sheets_gid="277662548", sql_file="pages_wpt_bodies_by_device_and_percentile_and_heading_level.sql") }}</figcaption>
</figure>

Potresti aspettarti di vedere solo gli elementi standard da `<h1>` a `<h6>`, ma alcuni siti utilizzano effettivamente più livelli:

<figure>
  <table>
    <thead>
      <tr>
        <th>Heading</th>
        <th>Occorrenze</th>
        <th>Media per pagina</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>h7</code></td>
        <td class="numeric">30,073</td>
        <td class="numeric">0.005</td>
      </tr>
      <tr>
        <td><code>h8</code></td>
        <td class="numeric">9,266</td>
        <td class="numeric">0.0015</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Frequenza e utilizzo medio di elementi di intestazione non standard.", sheets_gid="277662548", sql_file="pages_wpt_bodies_by_device_and_percentile_and_heading_level.sql") }}</figcaption>
</figure>

Gli ultimi due non hanno mai fatto parte dell'HTML, ovviamente, e non dovrebbero essere usati.

## Attributi

Questa sezione si concentra su come gli attributi vengono usati nei documenti ed esplora i modelli nell'utilizzo di `data-*`. I nostri risultati mostrano che `class` è la regina di tutti gli attributi.

### Gli attributi principali

Simile alla sezione sugli [elementi popolari](#gli-elementi-principali), questa sezione approfondisce gli attributi più popolari sul Web. Dato quanto è importante l'attributo `href` per il web stesso, o l'attributo `alt` per rendere le informazioni [accessibili](./accessibility#images-and-their-text-alternatives), questi attributi sarebbero i più popolari?

<figure>
  <table>
    <thead>
      <tr>
        <th>Attributo</th>
        <th>Occorrenze</th>
        <th>Percentuale</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>class</code></td>
        <td class="numeric">2,998,695,114</td>
        <td class="numeric">34.23%</td>
      </tr>
      <tr>
        <td><code>href</code></td>
        <td class="numeric">928,704,735</td>
        <td class="numeric">10.60%</td>
      </tr>
      <tr>
        <td><code>style</code></td>
        <td class="numeric">523,148,251</td>
        <td class="numeric">5.97%</td>
      </tr>
      <tr>
        <td><code>id</code></td>
        <td class="numeric">452,110,137</td>
        <td class="numeric">5.16%</td>
      </tr>
      <tr>
        <td><code>src</code></td>
        <td class="numeric">341,604,471</td>
        <td class="numeric">3.90%</td>
      </tr>
      <tr>
        <td><code>type</code></td>
        <td class="numeric">282,298,754</td>
        <td class="numeric">3.22%</td>
      </tr>
      <tr>
        <td><code>title</code></td>
        <td class="numeric">231,960,356</td>
        <td class="numeric">2.65%</td>
      </tr>
      <tr>
        <td><code>alt</code></td>
        <td class="numeric">172,668,703</td>
        <td class="numeric">1.97%</td>
      </tr>
      <tr>
        <td><code>rel</code></td>
        <td class="numeric">171,802,460</td>
        <td class="numeric">1.96%</td>
      </tr>
      <tr>
        <td><code>value</code></td>
        <td class="numeric">140,666,779</td>
        <td class="numeric">1.61%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Primi 10 attributi per frequenza di utilizzo.", sheets_gid="1348855449", sql_file="pages_almanac_by_device_and_attribute_name_frequency.sql") }}</figcaption>
</figure>

L'attributo più popolare è `class`, con quasi 3 miliardi di occorrenze nel nostro set di dati e che costituiscono il 34% di tutti gli attributi in uso.

L'attributo `value`, che specifica il valore di un elemento `input`, è tra i primi 10. È sorprendente per noi perché, soggettivamente, non abbiamo avuto l'impressione che gli attributi `value` fossero usati così frequentemente.

### Attributi nelle pagine

Ci sono attributi che troviamo in ogni documento? Non proprio, ma quasi:

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>href</td>
        <td class="numeric">99.21%</td>
      </tr>
      <tr>
        <td>src</td>
        <td class="numeric">99.18%</td>
      </tr>
      <tr>
        <td>content</td>
        <td class="numeric">98.88%</td>
      </tr>
      <tr>
        <td>name</td>
        <td class="numeric">98.61%</td>
      </tr>
      <tr>
        <td>type</td>
        <td class="numeric">98.55%</td>
      </tr>
      <tr>
        <td>class</td>
        <td class="numeric">98.24%</td>
      </tr>
      <tr>
        <td>rel</td>
        <td class="numeric">97.98%</td>
      </tr>
      <tr>
        <td>id</td>
        <td class="numeric">97.46%</td>
      </tr>
      <tr>
        <td>style</td>
        <td class="numeric">95.95%</td>
      </tr>
      <tr>
        <td>alt</td>
        <td class="numeric">90.75%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
  caption="Top 10 attributi per pagina.",
  sheets_gid="1185369559",
  sql_file="pages_almanac_by_device_and_attribute_name_present.sql"
)}}</figcaption>
</figure>

Questi risultati sollevano domande a cui non possiamo rispondere. Ad esempio, `type` viene utilizzato anche su altri elementi, ma perché questa enorme popolarità? Soprattutto dato che di solito non è necessario specificare per fogli di stile o script, con CSS e JavaScript che vengono considerati come predefiniti. Oppure, come andiamo veramente con `alt`? Il 9,25% delle pagine non contiene immagini o è semplicemente inaccessibile?

### Gli attributi "data-*"

Secondo le specifiche HTML, <a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes">gli attributi `data-*`</a> "hanno lo scopo di memorizzare dati personalizzati, stato, annotazioni e simili, privati della pagina o dell'applicazione, per i quali non esistono attributi o elementi più appropriati." Come vengono utilizzati? Quali sono quelli popolari? C'è qualcosa di interessante qui?

I due più popolari si distinguono perché sono quasi il doppio di ciascuno degli attributi che sono seguiti (con> 1% di utilizzo):

<figure>
  <table>
    <thead>
      <tr>
        <th>Attributo</th>
        <th>Occorrenze</th>
        <th>Percentuale</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>data-src</code></td>
        <td class="numeric">26,734,560</td>
        <td class="numeric">3.30%</td>
      </tr>
      <tr>
        <td><code>data-id</code></td>
        <td class="numeric">26,596,769</td>
        <td class="numeric">3.28%</td>
      </tr>
      <tr>
        <td><code>data-toggle</code></td>
        <td class="numeric">12,198,883</td>
        <td class="numeric">1.50%</td>
      </tr>
      <tr>
        <td><code>data-slick-index</code></td>
        <td>11,775,250</td>
        <td>1.45%</td>
      </tr>
      <tr>
        <td><code>data-element_type</code></td>
        <td class="numeric">11,263,176</td>
        <td class="numeric">1.39%</td>
      </tr>
      <tr>
        <td><code>data-type</code></td>
        <td class="numeric">11,130,662</td>
        <td class="numeric">1.37%</td>
      </tr>
      <tr>
        <td><code>data-requiremodule</code></td>
        <td class="numeric">8,303,675</td>
        <td class="numeric">1.02%</td>
      </tr>
      <tr>
        <td><code>data-requirecontext</code></td>
        <td class="numeric">8,302,335</td>
        <td class="numeric">1.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Gli attributi <code> data-* </code> più popolari.", sheets_gid="764700773", sql_file="pages_almanac_by_device_and_data_attribute_name_frequency.sql") }}</figcaption>
</figure>

Attributi come `data-type`, `data-id` e `data-src` possono avere molteplici usi generici sebbene `data-src` sia usato molto con il lazy image loading tramite JavaScript (ad esempio, Bootstrap 4). <a hreflang="en" href="https://getbootstrap.com/">Bootstrap</a> spiega ancora la presenza di `data-toggle`, dove è usato come uno state styling hook sui pulsanti di toggle. Il <a hreflang="en" href="https://kenwheeler.github.io/slick/">Slick carousel plugin</a> è la fonte di `data-slick-index`, mentre `data-element_type` fa parte del <a hreflang="en" href="https://elementor.com/">costruttore di siti Web WordPress di Elementor</a>. Sia `data-requiremodule` che `data-requirecontext`, quindi, fanno parte di <a hreflang="en" href="https://requirejs.org/">RequireJS</a>.

È interessante notare che l'uso del lazy loading nativo sulle immagini è simile a quello di `data-src`. <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1ram47FshAjzvbQVJbAQPgxZN7PPOPCKIK67VJZCo92c/edit#gid=2109061092">3,86% delle pagine</a> utilizza `loading="lazy"` sugli elementi `<img>`. Sembra che stia crescendo molto rapidamente, poiché a febbraio questo numero era di circa [0,8%](https://x.com/zcorpan/status/1237016679667970050). È possibile che vengano utilizzati insieme per una <a hreflang="en" href="https://addyosmani.com/blog/lazy-loading/">soluzione cross-browser</a>.

## Miscellaneo

Abbiamo trattato l'uso dell'HTML in generale, nonché l'adozione degli elementi e degli attributi principali. In questa sezione, esamineremo alcuni casi speciali di viewport, favicon, button, input e link. Una cosa che notiamo qui è che troppi link puntano ancora a URL "http".

### Specifiche di `viewport`

Il meta elemento [viewport](https://developer.mozilla.org/docs/Web/HTML/Viewport_meta_tag) viene utilizzato per controllare il layout sui browser mobile. Mentre anni fa, il motto era una specie di "non dimenticare il meta elemento viewport" durante la creazione di una pagina web, alla fine questa divenne una pratica comune e il motto cambiò in "assicurati che lo zoom e il ridimensionamento non siano disabilitati".

Gli utenti dovrebbero essere in grado di ingrandire e ridimensionare il testo <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.0/meta-viewport-large">fino al 500%</a>.Ecco perché i controlli in strumenti popolari come <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> o <a hreflang="en" href="https://www.deque.com/axe/">axe</a> falliscono quando `user-scalable="no"` è usato all'interno dell'elemento `metaname="viewport"`, e quando il valore dell'attributo `maximum-scale` è minore di `5`.

Abbiamo esaminato i dati e per capire meglio i risultati, li abbiamo normalizzati rimuovendo gli spazi, convertendo tutto in minuscolo e ordinando per virgola dell'attributo `content`.

<figure>
  <table>
    <thead>
      <tr>
        <th>Valore dell'attributo di content</th>
        <th>Pagine</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>initial-scale=1,width=device-width</code></td>
        <td class="numeric">2,728,491</td>
        <td class="numeric">42.98%</td>
      </tr>
      <tr>
        <td>blank</td>
        <td class="numeric">688,293</td>
        <td class="numeric">10,84%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,width=device-width</code></td>
        <td class="numeric">373,136</td>
        <td class="numeric">5.88%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width</code></td>
        <td class="numeric">352,972</td>
        <td class="numeric">5.56%</td>
      </tr>
      <tr>
        <td><code>initial-scale=1,maximum-scale=1,user-scalable=0,width=device-width</code></td>
        <td class="numeric">249,662</td>
        <td class="numeric">3.93%</td>
      </tr>
      <tr>
        <td><code>width=device-width</code></td>
        <td class="numeric">231,668</td>
        <td class="numeric">3.65%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="<code>viewport</code> e la loro mancanza.", sheets_gid="1414206386", sql_file="summary_pages_by_device_and_viewport.sql") }}</figcaption>
</figure>

I risultati mostrano che quasi la metà delle pagine che abbiamo analizzato utilizza il valore tipico di viewport `content`. Tuttavia, circa il 10% delle pagine per dispositivi mobile manca del tutto di un valore `content` appropriato per il meta elemento viewport, con il resto di esse che utilizzano una combinazione impropria di `maximum-scale`, `minimum-scale`, `user-scalable=no`, o `user-scalable=0`.

<p class="note">
  Da un po' di tempo, il browser mobile Edge consente agli utenti di ingrandire una pagina Web almeno <a hreflang="en" href="https://blogs.windows.com/windows-insider/2017/01/12/announcing-windows-10-insider-preview-build-15007-pc-mobile/">fino al 500%</a>, indipendentemente dalle impostazioni di zoom definite da una pagina web che utilizza il meta elemento viewport.
</p>

### I Favicon

La situazione intorno alle favicon è affascinante. Le favicon funzionano con o senza markup: alcuni browser tornerebbero a <a hreflang="en" href="https://realfavicongenerator.net/faq#why_icons_in_root">guardare la root del dominio</a>—, accetta diversi formati di immagine, quindi promuove anche diverse dozzine di dimensioni (si dice che alcuni strumenti ne generino 45; <a hreflang="en" href="https://realfavicongenerator.net/">realfavicongenerator.net</a> restituirebbe _37_ se richiesto per gestire ogni caso). Nel momento in cui scrivo, c'è un <a hreflang="en" href="https://github.com/whatwg/html/issues/4758">open issue</a> per le specifiche HTML per aiutare a migliorare la situazione.

Quando abbiamo creato i nostri test non abbiamo verificato la presenza di immagini, ma abbiamo solo esaminato il markup. Ciò significa che, quando si esamina il seguente, tieni presente che si tratta più di _come_ si fa riferimento alle favicon piuttosto che se o con che frequenza vengono utilizzate.

<figure>
  <table>
    <thead>
      <tr>
        <th>Formato Favicon</th>
        <th>Pagine</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>ICO</td>
        <td class="numeric">2,245,646</td>
        <td class="numeric">35.38%</td>
      </tr>
      <tr>
        <td>PNG</td>
        <td class="numeric">1,966,530</td>
        <td class="numeric">30.98%</td>
      </tr>
      <tr>
        <td>No favicon defined</td>
        <td class="numeric">1,643,136</td>
        <td class="numeric">25.88%</td>
      </tr>
      <tr>
        <td>JPG</td>
        <td class="numeric">319,935</td>
        <td class="numeric">5.04%</td>
      </tr>
      <tr>
        <td>No extension specified (no format identifiable)</td>
        <td class="numeric">37,011</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>GIF</td>
        <td class="numeric">34,559</td>
        <td class="numeric">0.54%</td>
      </tr>
      <tr>
        <td>WebP</td>
        <td class="numeric">10,605</td>
        <td class="numeric">0.17%</td>
      </tr>
      <tr>
        <td>…</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>SVG</td>
        <td class="numeric">5,328</td>
        <td class="numeric">0.08%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Formati favicon comuni.", sheets_gid="1930085905", sql_file="pages_almanac_by_device_and_favicon_image_type.sql") }}</figcaption>
</figure>

Ci sono un paio di sorprese qui:

* Il supporto per altri formati esiste, ma ICO è ancora il formato preferito per le favicon sul web.
* JPG è un formato favicon relativamente popolare anche se potrebbe non produrre i migliori risultati (o un peso relativamente grande) per molte dimensioni favicon.
* WebP è due volte più popolare di SVG! Questo potrebbe cambiare, tuttavia, con il miglioramento di <a hreflang="en" href="https://caniuse.com/link-icon-svg">SVG favicon support</a> improving.

### Pulsanti e tipi di input

Ultimamente ci sono state molte <a hreflang="en" href="https://adrianroselli.com/2016/01/links-buttons-submits-and-divs-oh-hell.html">discussioni</a> sui pulsanti e sulla frequenza con cui vengono utilizzati in modo improprio. Abbiamo esaminato questo aspetto per presentare i risultati su alcuni pulsanti HTML nativi.

{{ figure_markup(
  caption="Percentuale di pagine con elementi pulsante.",
  content="60.56%",
  classes="big-number",
  sheets_gid="410549982",
  sql_file="pages_markup_by_device.sql"
) }}

<figure>
  <table>
    <thead>
      <tr>
        <th>Tipi di pulsanti</th>
        <th>Occorrenze</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>&lt;button type="button"&gt;</code></td>
        <td class="numeric">15,926,061</td>
        <td class="numeric">36.41%</td>
      </tr>
      <tr>
        <td><code>&lt;button&gt;</code> without type</td>
        <td class="numeric">11,838,110</td>
        <td class="numeric">32.43%</td>
      </tr>
      <tr>
        <td><code>&lt;button type="submit"&gt;</code></td>
        <td class="numeric">4,842,946</td>
        <td class="numeric">28.55%</td>
      </tr>
      <tr>
        <td><code>&lt;input type="submit" value="…"&gt;</code></td>
        <td class="numeric">4,000,844</td>
        <td class="numeric">31.82%</td>
      </tr>
      <tr>
        <td><code>&lt;input type="button" value="…"&gt;</code></td>
        <td class="numeric">1,087,182</td>
        <td class="numeric">4.07%</td>
      </tr>
      <tr>
        <td><code>&lt;input type="image" src="…"&gt;</code></td>
        <td class="numeric">322,855</td>
        <td class="numeric">2.69%</td>
      </tr>
      <tr>
        <td><code>&lt;button type="reset"&gt;</code></td>
        <td class="numeric">41,735</td>
        <td class="numeric">0.49%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adozione di tipi di pulsanti.", sheets_gid="410549982", sql_file="pages_markup_by_device.sql") }}</figcaption>
</figure>

La nostra analisi mostra che circa il 60% delle pagine contiene un elemento button e più della metà di quelle pagine (32,43%) ha almeno un button che non riesce a specificare un attributo `type`. Nota che l'elemento `button` ha un <a hreflang="en" href="https://dev.w3.org/html5/spec-LC/the-button-element.html">tipo predefinito</a> di `submit`, quindi il comportamento predefinito dei pulsanti su questo 32% delle pagine è di inviare i dati del modulo corrente. Per evitare possibili comportamenti imprevisti come questo, una buona pratica è quella di specificare l'attributo `type`.

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>Pulsanti per pagina</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>25</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>75</td>
        <td class="numeric">5</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">13</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribuzione del numero di pulsanti per pagina.", sheets_gid="309769153", sql_file="pages_markup_by_device_and_percentile.sql") }}</figcaption>
</figure>

Le pagine nel 10° e 25° percentile non contengono alcun pulsante, mentre una pagina nel 90° percentile contiene 13 elementi `button` nativi. In altre parole, il 10% delle pagine contiene 13 o più pulsanti.

### I target di collegamento

L'[elemento ancora](https://developer.mozilla.org/docs/Web/HTML/Element/a), o l'elemento `a`, collega insieme le risorse web. In questa sezione si analizza l'adozione dei protocolli inclusi nei rispettivi target di collegamento.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocollo</th>
        <th>Occorrenze</th>
        <th>Pagine (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>https</code></td>
        <td class="numeric">5,756,444</td>
        <td class="numeric">90.69%</td>
      </tr>
      <tr>
        <td><code>http</code></td>
        <td class="numeric">4,089,769</td>
        <td class="numeric">64.43%</td>
      </tr>
      <tr>
        <td><code>mailto</code></td>
        <td class="numeric">1,691,220</td>
        <td class="numeric">26.64%</td>
      </tr>
      <tr>
        <td><code>javascript</code></td>
        <td class="numeric">1,583,814</td>
        <td class="numeric">24.95%</td>
      </tr>
      <tr>
        <td><code>tel</code></td>
        <td class="numeric">1,335,919</td>
        <td class="numeric">21.05%</td>
      </tr>
      <tr>
        <td><code>whatsapp</code></td>
        <td class="numeric">34,643</td>
        <td class="numeric">0.55%</td>
      </tr>
      <tr>
        <td><code>viber</code></td>
        <td class="numeric">25,951</td>
        <td class="numeric">0.41%</td>
      </tr>
      <tr>
        <td><code>skype</code></td>
        <td class="numeric">22,378</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td><code>sms</code></td>
        <td class="numeric">17,304</td>
        <td class="numeric">0.27%</td>
      </tr>
      <tr>
        <td><code>intent</code></td>
        <td class="numeric">12,807</td>
        <td class="numeric">0.20%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adozione dei protocolli target di collegamento.", sheets_gid="1963376224", sql_file="pages_wpt_bodies_by_device_and_protocol.sql") }}</figcaption>
</figure>

Possiamo vedere come `https` e `http` siano i più dominanti, seguiti da link "benigni" per rendere più facile scrivere e-mail, fare telefonate e inviare messaggi. `javascript` si distingue come target di collegamento che è ancora molto popolare anche se JavaScript offre opzioni native e degradanti con cui lavorare.

### Links in nuove finestre

{{ figure_markup(
  caption='Percentuale di pagine che non hanno attributi `noopener` né `noreferrer` sui link `target=" _blank"`.',
  content="71.35%",
  classes="big-number",
  sheets_gid="1876528165",
  sql_file="pages_wpt_bodies_by_device.sql"
) }}

L'uso di `target="_blank"` è noto come una <a hreflang="en" href="https://mathiasbynens.github.io/rel-noopener/">vulnerabilità di sicurezza</a> da un po'di tempo. Eppure il 7135% delle pagine contiene link con `target="_blank"`, senza `noopener` o `noreferrer`.

<figure>
  <table>
    <thead>
      <tr>
        <th>Elementi</th>
        <th>Pagine</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>&lt;a target="_blank" rel="noopener noreferrer"&gt;</code></td>
        <td class="numeric">13.63%</td>
      </tr>
      <tr>
        <td><code>&lt;a target="_blank" rel="noopener"&gt;</code></td>
        <td class="numeric">14.14%</td>
      </tr>
      <tr>
        <td><code>&lt;a target="_blank" rel="noreferrer"&gt;</code></td>
        <td class="numeric">0.56%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Relazioni vuote.", sheets_gid="1876528165", sql_file="pages_wpt_bodies_by_device.sql") }}</figcaption>
</figure>

Come regola pratica e per <a hreflang="en" href="https://www.nngroup.com/articles/new-browser-windows-and-tabs/">ragioni di usabilità</a>, si raccomanda di non usare `target="_blank"` in primo luogo.

<p class="note">Nelle ultime versioni di Safari e Firefox, l'impostazione di <code>target="_blank"</code> sugli elementi <code>a</code> fornisce implicitamente lo stesso comportamento <code>rel</code> dell'impostazione di <code>rel="noopener"</code>. Questo è già <a hreflang="en" href="https://chromium-review.googlesource.com/c/chromium/src/+/1630010">implementato anche in Chromium</a> e arriverà in Chrome 88.</p>

## Conclusione

Abbiamo accennato ad alcune osservazioni nel corso del capitolo, ma come riflessione sullo stato del markup nel 2020, ecco alcune cose che ci hanno colpito:

{{ figure_markup(
  caption="Percentuale di pagine con un doctype quirky.",
  content="3.97%",
  classes="big-number",
  sheets_gid="1981441894",
  sql_file="summary_pages_by_device_and_doctype.sql"
) }}

Meno pagine arrivano in modalità quirks. Nel 2016, quel numero era di <a hreflang="en" href="https://discuss.httparchive.org/t/how-many-and-which-pages-are-in-quirks-mode/777">circa il 7,4%</a>. Alla fine del 2019, abbiamo osservato [4,85%](https://x.com/zcorpan/status/1205242913908838400). E ora siamo al 3,97% circa. Questa tendenza, per parafrasare [Simon Pieters](./contributors#zcorpan) nella sua revisione di questo capitolo, sembra chiaro e incoraggiante.

Sebbene non ci siano dati storici per tracciare il quadro completo dello sviluppo, il markup `div`, `span` e `i` "senza significato" ha praticamente [sostituito](#gli-elementi-principali) il markup `table` che abbiamo osservato negli anni '90 e nei primi anni 2000. Sebbene ci si possa chiedere se gli elementi `div` e `span` siano sempre usati senza che ci sia un'alternativa semanticamente più appropriata, questi elementi sono ancora preferibili al markup `table`, sebbene, come durante il periodo di massimo splendore del vecchio web, questi erano apparentemente utilizzati per tutto tranne che per i dati tabulari.

Gli elementi per pagina e i tipi di elementi per pagina sono rimasti più o meno gli stessi, mostrando [nessun cambiamento significativo](#diversità-degli-elementi) nella nostra pratica di scrittura HTML rispetto al 2019. Tali modifiche potrebbero richiedere più tempo per manifestarsi.

Gli elementi proprietari specifici del prodotto come `g:plusone` (utilizzato su 17.607 pagine nell'esempio mobile) e `fb:like` (11.335) sono quasi scomparsi dopo essere ancora [tra i più popolari](../2019/markup#products-and-libraries-and-their-custom-markup) l'anno scorso. Tuttavia, osserviamo più [elementi personalizzati](#elementi-personalizzati) per cose come Slider Revolution, AMP e Angular. Anche elementi come `ym-measure`, `jdiv` e `ymaps` sono ancora prevalenti. Quello che immaginiamo di vedere qui è che, sotto il mare di pratiche che cambiano lentamente, l'HTML è in fase di sviluppo e manutenzione, con autori che rimuovono markup deprecati e adottano nuove soluzioni.

Ora, il [capitolo 2019 Web Almanac Markup](../2019/markup) ha lavorato nel riassumere 14 anni di sviluppo su quest argomento, quindi potresti pensare che non avremmo molto da coprire nell'anno successivo. Tuttavia quello che osserviamo con i dati di quest'anno è che c'è molto movimento sia in superfice che nel fondale del mare dell'HTML. Ci avviciniamo all'adozione quasi completa dell'HTML vivente. Siamo pronti a sfoltire le nostre pagine di mode come i widget di Google e Facebook. Siamo anche veloci nell'adottare ed evitare i framework, poiché sia Angular che AMP (sebbene un "framework di componenti") sembrano aver perso in modo significativo in popolarità, probabilmente per soluzioni come React e Vue.

E ancora, non ci sono segni che abbiamo esaurito le opzioni che l'HTML ci offre. La mediana di 30 diversi elementi utilizzati in una data pagina, che è circa un quarto degli elementi forniti dall'HTML, suggerisce un uso piuttosto unilaterale dell'HTML. Ciò è supportato dall'immensa popolarità di elementi come `div` e `span`, e nessun elemento personalizzato per soddisfare potenzialmente le richieste che questi due elementi possono rappresentare. Sfortunatamente, non è stato possibile convalidare ogni documento nel campione; tuttavia, aneddoticamente e da prendere con cautela, abbiamo appreso che il <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/issues/899#issuecomment-717856201">79%</a> dei documenti testati dal W3C presenta errori di convalida. Dopo tutto quello che abbiamo visto, sembra che siamo ancora lontani dal padroneggiare l'arte dell'HTML.

Questo ci obbliga a chiudere con un appello: Fai attenzione all'HTML. Concentrati sull'HTML. È importante e utile investire in HTML. L'HTML è un linguaggio per documenti che potrebbe non avere il fascino di un linguaggio di programmazione, eppure il Web è costruito su di esso. Usa meno HTML e impara cosa serve veramente. Usa un HTML più appropriato: scopri cosa è disponibile e a cosa serve. E <a hreflang="en" href="https://validator.w3.org/docs/why.html">convalida</a> il tuo HTML. Chiunque può scrivere HTML non valido (basta invitare la prossima persona che incontri a scrivere un documento HTML e convalidare l'output) ma ci si può aspettare che uno sviluppatore professionista produca HTML valido. Scrivere HTML corretto e valido è un mestiere di cui essere orgogliosi.

Per la prossima edizione del capitolo di Web Almanac, prepariamoci a guardare più da vicino l'arte di scrivere HTML e, si spera, come lo abbiamo migliorato.

<p class="note">
  Stiamo lasciando il resto aperto a te. Quali sono le tue osservazioni? Cosa ha attirato la tua attenzione? Cosa pensi che sia peggiorato e cosa è migliorato? <a hreflang="en" href="https://discuss.httparchive.org/t/2039">Lascia un commento</a> per condividere i tuoi pensieri!
</p>
