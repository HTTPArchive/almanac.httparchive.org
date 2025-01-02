---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Markup
description: Capitolo sul markup del Web Almanac 2022 che tratta di dati relativi ai documenti (doctype, compressione, lingue, conformità all'HTML, dimensione dei documenti), di uso di elementi e attributi HTML, di attributi di dati e di social media.
hero_alt: Hero image of Web Almanac characters as dressed as constructor workers putting together a web page from HTML element blocks.
authors: [j9t]
reviewers: [bkardell, zcorpan]
analysts: [rviscomi]
editors: [tunetheweb]
translators: [webmatter-it]
j9t_bio: Jens Oliver Meiert è un ingegnere capo e autore (<a hreflang="en" href="https://leanpub.com/web-development-glossary"><cite lang="en">The Web Development Glossary</cite></a>, <a hreflang="en" href="https://www.amazon.com/dp/B094W54R2N/"><cite lang="en">Upgrade Your HTML</cite></a>), che lavora in qualità di engineering manager presso <a hreflang="en" href="https://www.liveperson.com/">LivePerson</a>. È specializzato nella minimizzazione e ottimizzazione dell'HTML e dei CSS. Jens scrive regolarmente a proposito dell'arte dello sviluppo web sul suo sito <a hreflang="en" href="https://meiert.com/en/">meiert.com</a>.
results: https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/
featured_quote: Senza l'HTML non ci possono essere pagine web, siti web, app web. Si può dire che senza HTML non ci sarebbe il Web. Ciò rende l'HTML uno degli standard web più importanti, se non il più importante standard web.
featured_stat_1: 90%
featured_stat_label_1: Documenti che usano il doctype HTML.
featured_stat_2: 30 KB
featured_stat_label_2: Il peso mediano di un documento HTML
featured_stat_3: 29%
featured_stat_label_3: Elementi HTML che sono `div`.
---

## Introduzione

Come diceva il [capitolo del 2020](../2020/markup#introduction), senza l'HTML non ci possono essere pagine web, siti web, app web. Si può dire che senza HTML non ci sarebbe il Web. Ciò rende l'HTML uno degli standard web più importanti, se non il più importante standard web.

Di conseguenza, come ogni anno, abbiamo utilizzato i milioni di pagine nel nostro set di dati (7,9 milioni nel set di pagine per dispositivi mobili, 5,4 milioni nel set di paginne desktop, con sovrapposizione) per esaminare anche l'HTML. Questo capitolo non copre "tutto" sull'HTML, quindi siete caldamente invitati ad [analizzare anche i dati raccolti](https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit) e a condividere le vostre riflessioni e, nel caso, a taggarle: [#htmlalmanac](https://x.com/hashtag/htmlalmanac).

## Dati del documento

C'è molto di cui essere curiosi quando si tratta di come scriviamo l'HTML. Possiamo porre molte domande, ma quando si tratta di HTML in generale, diamo un'occhiata a come il nostro HTML viene inviato ai browser, prima ancora di entrare nel contenuto del markup stesso.

### Doctype

<figure>
  <table>
    <thead>
      <tr>
        <th>Doctype</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`html`</td>
        <td class="numeric">88,1%</td>
        <td class="numeric">90,0%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd xhtml 1.0 transitional//en http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd`</td>
        <td class="numeric">4,7%</td>
        <td class="numeric">3,9%</td>
      </tr>
      <tr>
        <td>Nessun doctype</td>
        <td class="numeric">3,0%</td>
        <td class="numeric">2,7%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd xhtml 1.0 strict//en http://www.w3.org/tr/xhtml1/dtd/xhtml1-strict.dtd`</td>
        <td class="numeric">1,2%</td>
        <td class="numeric">1,1%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd html 4.01 transitional//en http://www.w3.org/tr/html4/loose.dtd`</td>
        <td class="numeric">0,9%</td>
        <td class="numeric">0,6%</td>
      </tr>
      <tr>
        <td>`html -//w3c//dtd html 4.01 transitional//en`</td>
        <td class="numeric">0,4%</td>
        <td class="numeric">0,4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Utilizzo del doctype.",
      sheets_gid="1535288056",
      sql_file="doctype.sql",
    ) }}
  </figcaption>
</figure>

Cominciamo con i doctype: qual è il più popolare? Certamente conoscete già la risposta: è il semplice, stringato e noioso doctype standard HTML, vale a dire `<!DOCTYPE html>`.

{{ figure_markup(
  content="90%",
  caption="Pagine mobili che usano il doctype standard HTML.",
  classes="big-number",
  sheets_gid="1535288056",
  sql_file="doctype.sql",
) }}

Il 90% di tutte le pagine per dispositivi mobili lo utilizza: poiché il set di dati per dispositivi mobili è più grande di quello desktop, questo capitolo si baserà principalmente su tali dati. Il secondo doctype più popolare è XHTML 1.0 Transitional (3,9%, [in calo rispetto al 4,6% del 2021](../2021/markup#doctypes)). A seguire al 2,7% sono le pagine in cui non viene definito alcun doctype, in salita rispetto al 2,5% dell'anno scorso.

### Compressione

{{ figure_markup(
  image="content-encoding.png",
  caption="Codifica del contenuto del documento HTML.",
  description="Grafico a barre impilate, che mostra che il 28% dei documenti HTML desktop e mobili viene compresso con Brotli, il 58% dei documenti desktop e mobili viene compresso con Gzip e il 14% dei documenti HTML desktop e il 13% dei dispositivi mobili non viene compresso affatto.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1176900527&format=interactive",
  sheets_gid="1434175283",
  sql_file="content_encoding.sql",
)}}

I documenti HTML sono compressi? Quanti lo sono? In che modo? L'86% di essi lo è, con il 58% (in calo del 5,8% rispetto allo scorso anno) compresso tramite Gzip e il 28% (in aumento del 6,1%) compresso tramite Brotli. In totale rispetto all'anno scorso risulta compresso un numero leggermente maggiore di documenti e con compressione più efficiente.

### Lingue

{{ figure_markup(
  image="html-languages.png",
  caption="Valori di lingue regionali più diffusi (attributo `lang` dell'HTML).",
  description="Grafico a barre che mostra che `en` è la lingua impostata nel 22% delle pagine desktop e nel 19% delle pagine mobili, `(not set)` è rispettivamente nel 18% e 17%, `en-us` nel 16% e 13%, `ja` nel 6% e 6%, `es` nel 4% e 5%, `pt-br` nel 2% e 3%, `en-gb` nel 2% e 2%, `ru` nel 2 % e 2%, `de` nel 2% e 2% e `de-de` nell'1% delle pagine desktop e sul 2% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=677908280&format=interactive",
  sheets_gid="1194853402",
  sql_file="lang.sql",
  width=600,
  height=511
)}}

E le lingue? Nel nostro set di dati, il 35% delle pagine utilizzava un attributo di `lang` riconducibile all'inglese; il 17% non aveva la lingua impostata; e avrete già capito la problematica: il campione è plausibilmente distorto e anche non così grande da riflettere tutto il mondo. Inoltre nessun attributo `lang` utilizzato non equivale a nessuna lingua impostata quindi, per questo scopo i nostri dati non sembrano esserci utili.

### Conformità

I documenti sono conformi alle specifiche HTML, ovvero sono validi? Un modo rapido per capirlo è utilizzare uno strumento come il <a hreflang="en" href="https://validator.w3.org/">servizio di convalida del markup W3C</a>.

Non l'abbiamo fatto e non abbiamo ancora potuto verificarlo. Allora perché includere questa sezione?

Il motivo per almeno citare la conformità è che se non controllate la conformità, se non validate i documenti, ci sono buone probabilità (in pratica, <a hreflang="en" href="https://meiert.com/it/blog/valid-html-2022/">di fatto una probabilità del 100%</a>) che finirete per scrivere almeno un po' di codice HTML fittizio e di fantasia (e quindi sbagliato). Ma l'HTML non è finzione o fantasia: è uno standard tecnico rigido con regole chiare su cosa funziona e cosa no.

Per un professionista, è bene conoscere queste regole. È un bene produrre codice che funzioni e che non contenga nulla di superfluo. Ed entrambe le azioni (l'imparare e il non licenziare alcunché di non funzionante o superfluo) rappresentano il motivo per cui la conformità è importante e perché la validazione è importante.

Non abbiamo ancora dati di conformità da condividere nel Web Almanac, ma ciò non significa che il punto sia meno importante. E se non vi siete ancora concentrati sulla conformità, cominciate ora a validare il vostro output HTML. Forse una delle prossime edizioni del Web Almanac avrà qualche notizia positiva da condividere grazie a voi.

### Dimensione del documento

Il caruco HTML e le dimensioni del documento sono un punto fermo in questa serie: abbiamo guardato a queste informazioni dal 2019. Ma la tendenza è chiara e, sebbene segua un tema comune che anche altri capitoli confermeranno, non è buona:

{{ figure_markup(
  image="html-document-transfer-size.png",
  caption="Dimensione di trasferimento mediana per documento HTML.",
  description="Grafico a colonne che mostra che la dimensione di trasferimento mediana di un documento HTML è in aumento. Nel 2019 era di 27 KB su desktop e 26 KB su dispositivo mobile, nel 2020 è scesa leggermente rispettivamente a 26 KB e 25 KB, ma nel 2021 è aumentata di nuovo a 29 KB e 27 KB, e nel 2022 è la più grande arrivando fino a 31 KB su desktop e 30 KB su dispositivo mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=381017848&format=interactive",
  sheets_gid="1090657426",
  sql_file="document_trends.sql",
)}}

Dopo un breve sollievo nel 2020, le dimensioni dei documenti hanno continuato a crescere nel 2021 e di nuovo nel 2022, con una dimensione mediana di trasferimento di 30 KB nel nostro set di dati relativo a dispositivi mobili.

Un modo per contrastare questa tendenza è <a hreflang="en" href="https://css-tricks.com/write-html-the-html-way-not-the-xhtml-way/">scrivere HTML alla HTML (e non alla XHTML)</a>, in quanto ciò da solo comporterebbe un peso di trasferimento dell'HTML inferiore. _Chiarimento: al vostro autore qui piace inventare classificazioni sui tipi di scrittura HTML ed è un forte promotore dell'HTML minimale._

## Elementi

Se non si contano gli elementi `svg` e `math` (poiché sono specificati al di fuori dell'HTML) l'attuale specifica HTML consiste al momento di 111 elementi.

<aside class="note">Elementi, non tag, perché non ci riferiamo a semplici tag di inizio o fine, come `<li>` o `</ins>`. E alcune persone contano gli elementi HTML in modo diverso, ma la cosa più importante è <a hreflang="en" href="https://meiert.com/it/blog/the-number-of-html-elements/">essere chiari su come si contano</a>.</aside>

Cosa possiamo osservare?

### Varietà degli elementi

{{ figure_markup(
  image="element-count-distribution.png",
  caption="Distribuzione di elementi distinti per pagina.",
  description="Grafico a colonne che mostra il conteggio di elementi distinti per pagina a percentili comuni. Desktop e dispositivi mobili sono quasi identici con 22 elementi al 10° percentile, 27 al 25°, 32 al 50° percentile, 39 per desktop e 38 per mobili a al 75° percentile e 45 al 90° percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=2146886292&format=interactive",
  sheets_gid="1201800477",
  sql_file="element_count_distribution.sql",
)}}

La prima cosa che possiamo notare è che ora gli sviluppatori utilizzano un po' di più degli elementi diversi per pagina, con una mediana di 32 elementi differenti per documento.

La mediana è più alta rispetto ai [31 elementi del 2021](../2021/markup#element-diversity) e ai [30 elementi del 2020](../2020/markup#element-diversity). Poiché questa è una tendenza generale, potrebbe essere un flebile segnale che gli sviluppatori usino meglio gli elementi HTML, utilizzandone di più per quello per cui sono stati concepiti.

Purtroppo, c'è un'altra tendenza che si allinea con l'aumento delle dimensioni del documento, e questo è un numero crescente di elementi per pagina in totale:

{{ figure_markup(
  image="element-count-distribution.png",
  caption="Distribuzione degli elementi per pagina.",
  description="Grafico a colonne che mostra il conteggio degli elementi per dispositivo ai percentili comuni. Per desktop sono 177 elementi al 10° percentile, 394 al 25° percentile, 711 al 50° percentile, 1.220 al 75° percentile e 2.023 al 90° percentile. Le tendenze per i dispositivi mobili sono le stesse ma con cifre inferiori: rispettivamente 192, 371, 653, 1.104 e 1.832.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1598321449&format=interactive",
  sheets_gid="1201800477",
  sql_file="element_count_distribution.sql",
)}}

La mediana è attualmente di 653 elementi per pagina, rispetto ai 616 nel 2021 e ai 587 nel 2020, tutti per il rispettivo set di dati sui dispositivi mobili. Pubblichiamo più contenuti, che richiedono più elementi per contenerli (qualcosa come, più paragrafi per il testo, più elementi `p`)? Oppure è solo un altro segno di una pandemia fuori controllo di elementi `div`? I nostri dati non rispondono a questa domanda, ma ciò è probabilmente dovuto ad entrambi questi fattori (e anche ad ulteriori motivi).

### Elementi più usati

I seguenti elementi sono usati con più frequenza:

<figure>
  <table>
    <thead>
      <tr>
        <th>2019</th>
        <th>2020</th>
        <th>2021</th>
        <th>2022</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`div`</td>
        <td>`div`</td>
        <td>`div`</td>
        <td>`div`</td>
      </tr>
      <tr>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
      </tr>
      <tr>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
      </tr>
      <tr>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
      </tr>
      <tr>
        <td>`img`</td>
        <td>`img`</td>
        <td>`img`</td>
        <td>`img`</td>
      </tr>
      <tr>
        <td>`script`</td>
        <td>`script`</td>
        <td>`script`</td>
        <td>`script`</td>
      </tr>
      <tr>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
      </tr>
      <tr>
        <td>`option`</td>
        <td>`link`</td>
        <td>`link`</td>
        <td>`link`</td>
      </tr>
      <tr>
        <td></td>
        <td>`i`</td>
        <td>`meta`</td>
        <td>`i`</td>
      </tr>
      <tr>
        <td></td>
        <td>`option`</td>
        <td>`i`</td>
        <td>`meta`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Elementi più utilizzati.",
      sheets_gid="571472591",
      sql_file="element_frequency.sql",
    ) }}
  </figcaption>
</figure>

L'elemento `div` è di gran lunga l'elemento più popolare: abbiamo trovato 2.123.819.193 occorrenze nel set di dati mobile e 1.522.017.185 nel nostro set di dati desktop.

{{ figure_markup(
  content="29%",
  caption="Percentuale di elementi che sono elementi `div`.",
  classes="big-number",
  sheets_gid="571472591",
  sql_file="element_frequency.sql",
)}}

[Divitis](https://en.wiktionary.org/wiki/divitis) è una realtà.

Se vi state chiedendo qual è l'elemento strano, [l'elemento `i`](https://developer.mozilla.org/docs/Web/HTML/Element/i), è logico che ciò sia ancora in gran parte dovuto a <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a> e il suo discutibile uso improprio di questo elemento. L'elemento ha anche una cattiva reputazione perché durante i tempi di XHTML, tutti suggerivano di usare invece `em`, che invece non era un buon consiglio e infatti si veda <a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-i-element">Gli elementi `i` hanno i loro casi d'uso</a>.

Quando poi si analizza quali elementi vengono utilizzati nella maggior parte dei documenti, l'elenco ha un aspetto leggermente diverso:

{{ figure_markup(
  image="adoption-of-top-html-elements.png",
  caption="Adozione dei principali elementi HTML.",
  description="Grafico a barre che mostra che `html` è utilizzato nel 99,3% delle pagine desktop e nel 99,4% delle pagine mobili, `head` rispettivamente nel 99,3% e 99,4%, `body` nel 99,1% e 99,2%, `title` nel 98,9 % e 99,0%, `meta` nel 98,5% e 98,9%, `div` nel 98,3% e 98,5%, `a` nel 98,0% e 98,1%, `link` nel 97,8% e 98,0%, `script` nel 97,6 % e 97,8%, `img` nel 95,9% e 96,1%, `span` nel 94,2% e 94,7%, `p` nel 89,9% e 90,0%, `ul` nel 88,8% e 88,7% e infine `li` nell'88,7% delle pagine desktop e nell'88,6% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=714125011&format=interactive",
  sheets_gid="2057119066",
  sql_file="element_popularity.sql",
  width=600,
  height=656
)}}

Non è una sorpresa che quasi tutti i documenti utilizzino i tag `html`, `head` o `body`: vengono inseriti automaticamente nel DOM e questo è ciò che viene conteggiato qui. Il fatto che i numeri siano leggermente inferiori al 100% è dovuto a un piccolo numero di pagine che bloccano il rilevamento sovrascrivendo le API JavaScript che utilizziamo, ad esempio <a hreflang="en" href="https://mootools.net/" >MooTools</a> sovrascrive l'API `JSON.stringify()`.

È molto più sorprendente il `title` mancante nell'1% di tutti i documenti campionati: questo elemento non è facoltativo e non viene inserito nel DOM e la sua omissione è un indicatore della mancanza di controllo di conformità.

Gli elementi che seguono sono vecchie conoscenze, in particolare `a`, `img` e `meta` sono stati elementi popolari sin da tempi de <a hreflang="en" href="https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html">L'importante studio sull'HTML di Ian Hickson</a> nel 2005.

Qual è l'elemento HTML meno utilizzato che fa parte dello standard attuale, vi state forse chiedendo? Ebbene è <a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-samp-element">`samp`</a>, con appena 2.002 occorrenze nel nostro set di dati sui dispositivi mobili.

### Elementi personalizzati

<a hreflang="en" href="https://html.spec.whatwg.org/multipage/custom-elements.html#custom-elements-core-concepts">Elementi personalizzati</a>: elementi che possiamo approssimativamente identificare come quelli che hanno un trattino nel nome, erano nuovamente presenti nei siti campionati quest'anno. Ora, però, la Top 10 è interamente dominata da <a hreflang="en" href="https://www.sliderrevolution.com/">Slider Revolution</a>:

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento personalizzato</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`rs-module-wrap`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-module`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-slides`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-slide`</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.3%</td>
      </tr>
      <tr>
        <td>`rs-sbg-wrap`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-sbg-px`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-sbg`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-progress`</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`rs-layer`</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`rs-mask-wrap`</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Elementi personalizzati più usati.",
      sheets_gid="2057119066",
      sql_file="element_popularity.sql",
    ) }}
  </figcaption>
</figure>

È impressionante, ma ci dà poco su cui lavorare oltre a dire che Slider Revolution viene utilizzato in circa il 2% di tutte le pagine campionate.

Quali sono gli elementi personalizzati che seguono per popolarità e che non fanno parte di Slider Revolution?

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento personalizzato</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`pages-css`</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`wix-image`</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>`router-outlet`</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>`wix-iframe`</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>`ss3-loader`</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Elementi personalizzati più usati esclusi quelli che iniziano con `rs-`.",
      sheets_gid="2057119066",
      sql_file="element_popularity.sql",
    ) }}
  </figcaption>
</figure>

Qui i dati sono più vari: `pages-css`, `wix-image` e `wix-iframe` provengono dal website builder Wix. `router-outlet` ha origine in Angular. E `ss3-loader` sembra essere correlato a Smart Slider.

### Elementi obsoleti

Gli elementi obsoleti si ritrovano ancora? Dato che la non-validazione continua ad essere una pratica, ecco che sì, si trovano ancora.

{{ figure_markup(
  image="obsolete-elements.png",
  caption="Elementi obsoleti.",
  description="Grafico a barre che mostra che `center` viene utilizzato nel 6,3% delle pagine desktop e nel 6,1% delle pagine mobili, `font` viene utilizzato rispettivamente nel 5,7% e nel 5,4% delle pagine, `marquee` nello 0,8% e nell'1,0%, `nobr` nello 0,5% e nello 0,4% e infine `big` nello 0,4% delle pagine desktop e mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=2039309980&format=interactive",
  sheets_gid="69619977",
  sql_file="obsolete_elements.sql",
)}}

Nel 6,1% delle pagine si trovano ancora gli elementi `center` (ciao <a href="https://www.google.com/">home page di Google</a>) e nel 5,4% delle pagine si trovano gli elementi `font`. L'uso di entrambi questi elementi è diminuito (meno dello 0,5% in entrambi i casi), fortunatamente, mentre `marquee`, `nobr` e `big` non hanno registrato cambiamenti significativi.

`center` e `font` fanno la parte del leone (81,2%) di tutti gli elementi obsoleti, secondo la nostra analisi:

{{ figure_markup(
  image="obsolete-elements-relative-use.png",
  caption="Uso relativo degli elementi obsoleti.",
  description="Grafico a torta che mostra che `center` rappresenta il 43,0% dell'utilizzo di elementi obsoleti su dispositivi mobili, `font` è il 38,2%, `marquee` è il 7,0%, `nobr` il 2,6%, `big` il 2,6%, `frame` l'1,5% e il resto della torta è costituito da altri elementi senza etichetta.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1875548366&format=interactive",
  sheets_gid="69619977",
  sql_file="obsolete_elements.sql",
)}}

## Attributi

Se gli elementi sono il pane dell'HTML, gli attributi sono il burro. Cosa possiamo imparare da questo?

### Attributi principali

L'attributo più popolare, di gran lunga, era ed è ancora `class`:

{{ figure_markup(
  image="attribute-usage.png",
  caption="Utilizzo degli attributi.",
  description="Grafico a barre che mostra che `class` vanta il 34% dell'utilizzo degli attributi sia su dispositivi mobili che desktop, `href` è il 10% dell'utilizzo su desktop e il 9% su dispositivi mobili, `style` è il 5% su entrambi, `id` è il 5% su entrambi, `src` è il 4% su entrambi, `type` è il 3% su entrambi, `title` è il 2% su entrambi, `alt` è il 2% su entrambi, `rel` è il 2% su entrambi, e infine `value` è l'1% su entrambi.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=143284257&format=interactive",
  sheets_gid="1979652187",
  sql_file="attributes.sql",
  width=600,
  height=558
)}}

Questo ordine degli attributi non è diverso da quello che abbiamo visto l'anno scorso, ma ci sono alcuni cambiamenti:

- `class` (<span class="numeric-bad">▼0,3%</span>), `href` (<span class="numeric-bad">▼0,9%</span>), `style` (<span class="numeric-bad">▼0,6%</span>), `id` (<span class="numeric-bad">▼0,2%</span>), `type` (<span class="numeric-bad">▼0,1%</span>), `title` (<span class="numeric-bad">▼0,3%</span>)e e `value` (<span class="numeric-bad">▼0,5%</span>) sono tutti usati un po' meno di prima.
- `src` (<span class="numeric-good">▲0,3%</span>) e `alt` (<span class="numeric-good">▲0,1%</span>) sono usati più di prima, buone notizie per l'accessibilità per il momento!
- L'utilizzo di `rel` non è cambiato in modo significativo.

Ci sono attributi che troviamo su (quasi) tutti i documenti? Sì, ci sono:

{{ figure_markup(
  image="attribute-usage.png",
  caption="Utilizzo degli attributi per pagina.",
  description="Grafico a barre che mostra che `href` è utilizzato nel 99% delle pagine desktop e mobili, `src` nel 99% di entrambe, `content` nel 98% delle desktop e nel 99% di quelle mobili, `name` nel 98% e 99% rispettivamente, `type` nel 98% di entrambe, `class` nel 98% di entrambe, `rel` nel 98% di entrambe, `id` nel 97% e 98% di dispositivi mobili, `style` nel 96% di entrambe e, infine, `alt` viene utilizzato nel 91% di entrambe.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=143284257&format=interactive",
  sheets_gid="1979652187",
  sql_file="attributes.sql",
  width=600,
  height=558
)}}

`href`, `src`, `content` (metadati) e `name` (metadati, identificatori dei form) sono presenti in quasi tutti i documenti del nostro campione.

### Attributi `data-*`

Per quanto riguarda gli <a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes">attributi `data-*`</a>, che consentono agli autori di incorporare i propri metadati personalizzati, abbiamo anche estratto nuove informazioni.

Questo è cambiato solo di poco rispetto alle [statistiche degli attributi `data-*` dell'anno scorso](../2021/markup#data--attributes). Ecco alcune modifiche da sottolineare:

- `data-id` è ancora l'attributo `data-*` più popolare, con un aumento dello 0,7% rispetto al 2021.
- `data-element_type`, anche se la sua posizione è rimasta la stessa, ha guadagnato lo 0,7%.
- `data-testid` prima sesto in classifica, ha guadagnato lo 0,3% ed è balzato al quarto posto.
- `data-widget_type` prima all'ottavo posto, ha guadagnato lo 0,4% di popolarità e ha anche guadagnato due posizioni, conquistando il sesto posto nel 2022.

`data-element_type` e `data-widget_type` si riferiscono a <a hreflang="en" href="https://developers.elementor.com/">Elementor</a>, mentre `data-testid` proviene da <a hreflang="en" href="https://testing-library.com/">Testing Library</a>.

Diamo un'occhiata alla frequenza con cui troviamo gli attributi `data-*` sulle nostre pagine:

{{ figure_markup(
  image="data-attribute-popularity.png",
  caption="Popolarità degli attributi dei dati.",
  description="Grafico a barre che mostra che `data-toggle` viene utilizzato nel 23% delle pagine desktop e nel 22% delle pagine mobili, `data-src` rispettivamente nel 20% e 20%, `data-target` nel 20% e 20%, `data-id` nel 18% e 19%, `data-type` nel 15% e 15%, `data-href` nel 9% e 10%, `data-fbcssmodules` nel 10% e 10%, `data- slick-index` nel 10% e 9%, `data-google-container-id` nel 10% e 9% e infine `data-load-complete` viene utilizzato nel 10% delle pagine mobili e nel 9% delle pagine desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=1008069119&format=interactive",
  sheets_gid="1727867391",
  sql_file="data_attributes.sql",
  width=600,
  height=558
)}}

La loro popolarità è alta! Secondo il grafico sopra, quasi un documento su quattro utilizza gli attributi `data-*`. Ma i dati complessivi mostrano che l'88% dei documenti usa almeno un attributo `data-*`. Indubbiamente un alto livello di adozione.

### Social markup

L'edizione dello scorso anno ha introdotto [una sezione sul social markup](../2021/markup#social-markup), un markup speciale che rende più facile per le piattaforme social identificare e visualizzare i rispettivi metadati. Ecco l'aggiornamento 2022:

{{ figure_markup(
  image="social-meta-nodes-usage.png",
  caption="Utilizzo dei metanodi social.",
  description="Grafico a barre che mostra che `og:title` è nel 56% delle pagine desktop e nel 57% delle pagine mobili, `og:url` rispettivamente nel 53% e 54%, `og:type` nel 51% e 51%, `og:description` nel 50% e 50%, `og:site_name` nel 45% e 45%, `twitter:card` nel 40% e 39%, `og:image` nel 39% e 39%, `og:locale` nel 28% e 29%, `twitter:title` nel 24% e 23% e infine `twitter:description` nel 21% di entrambi.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRjXjOczLu9q3mcQ-UFLUOmZgefGNCPVYeEwo4cDxQTymgmD_1D5dbZ728Mz1SkEMZHxQgwcWmLjkgx/pubchart?oid=429652195&format=interactive",
  sheets_gid="1925328234",
  sql_file="meta_node_names.sql",
  width=600,
  height=604
)}}

Ma c'è proprio bisogno di tutti questi metadati? Dipende dalle esigenze. Infatti, se questi requisiti riguardano la visualizzazione di titolo, descrizione e immagine, non sembra che siano necessari così tanti. Potreste essere in grado di farlo con `twitter:card`, `og:title`, `og:description` (collegato ai metadati standard di `description`) e `og:image`. L'autore e molti altri hanno descritto le opzioni per il <a hreflang="en" href="https://meiert.com/en/blog/minimal-social-markup/">social markup minimo</a>.

## Conclusione

Chiudiamo il nostro sguardo all'HTML del 2022.

La conclusione è breve: analizzando da un anno all'altro è difficile dire quali tendenze importanti si siano avviate o siano in recessione. Le dimensioni dei documenti sembrano continuare a crescere, almeno dal 2020 al 2021 al 2022. Anche il numero di elementi per pagina aumenta ogni anno. Ci potrebbe essere qualche attributo `alt` in più ora, ma il dato è relativo a se stesso e non possiamo dire se ora più immagini abbiano impostato un appropriato attributo `alt`, né se il testo contenuto sia davvero <a hreflang="en" href ="https://html.spec.whatwg.org/multipage/images.html#alt">significativo</a>.

Ma per questo scopo, il Web Almanac potrà aiutare. Esamineremo di nuovo l'HTML l'anno prossimo, l'anno dopo il prossimo e l'anno dopo ancora. Ed entreremo ancora più nel dettaglio confrontando i dati con più anni precedenti.

Quello che forse saremo anche in grado di fare è guardare anche alla conformità. In questo momento forse non a tutti nel nostro campo interessa l'argomento. Ma siamo tutti professionisti e sembra quantomeno rilevante sapere se nel nostro complesso produciamo un codice che corrisponde a <a hreflang="en" href="https://html.spec.whatwg.org/multipage/">gli standard web sottostanti</a>. Dopo tutto, questo non dovrebbe essere un capitolo sull'HTML di fantasia, piuttosto un capitolo sull'HTML che funziona davvero. L'HTML è infatti uno degli standard web più importanti.
