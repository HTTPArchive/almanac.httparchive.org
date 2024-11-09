---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: Capitolo sui CSS del Web Almanac 2022 che tratta delle tendenza, dei cambiamenti e dei modelli nell'uso dei CSS nel web.
authors: [rachelandrew]
reviewers: [svgeesus, j9t]
analysts: [rviscomi]
editors: [rviscomi]
translators: [webmatter-it]
rachelandrew_bio: Rachel Andrew lavora per Google in qualità di scrittrice tecnica, in particolare sul sito <a hreflang="en" href="https://web.dev">web.dev</a> e sul <a hreflang="en" href=" https://developer.chrome.com/">sito per sviluppatori Chrome</a>. È una front e back-end web developer, autrice e relatrice, autrice o coautrice di 22 libri tra cui <a hreflang="en" href="https://abookapart.com/products/the-new-css-layout">The New CSS Layout</a> e contribuisce regolarmente a numerose pubblicazioni sia online che offline. Rachel è un membro del CSS Working Group e la si può trovare su Twitter a pubblicare foto dei suoi gatti sotto il _nick_ [@rachelandrew](https://x.com/rachelandrew).
results: https://docs.google.com/spreadsheets/d/1OU8ahxC5oYU8VRryQs9BzHToaXcOntVlh6KUHjm15G4/
featured_quote: Gli ultimi anni hanno visto una raffica di nuove funzionalità CSS. Molte di queste sono nate prendendo ispirazione da cose che gli sviluppatori facevano già con JavaScript o tramite i preprocessori, mentre altre forniscono ora metodi per fare cose che erano impossibili alcuni anni fa. Ok, avere nuove funzionalità disponibili è una cosa, ma gli sviluppatori le usano effettivamente in produzione nelle loro pagine web e applicazioni?
featured_stat_1: 43%
featured_stat_label_1: Percentuale di pagine che utilizzano le <i lang="en">custom properties</i> [proprietà personalizzate anche dette variabili CSS]
featured_stat_2: 0.3%
featured_stat_label_2: Percentuale di pagine che utilizzano la nuova proprietà `accent-color`
featured_stat_3: 12%
featured_stat_label_3: Percentuale di pagine che utilizzano i layout a griglia (<i lang="en">grid layouts</i>)
---

## Introduzione

CSS è il linguaggio utilizzato per impaginare e formattare pagine web e altri media. È uno dei tre linguaggi principali del web e si unisce all'[HTML](./markup), che viene utilizzato per la struttura, e al [JavaScript](./javascript), utilizzato per il comportamento.

Gli ultimi anni hanno visto una raffica di nuove funzionalità CSS. Molte di queste sono nate prendendo ispirazione da cose che gli sviluppatori facevano già con JavaScript o tramite i preprocessori, mentre altre forniscono ora metodi per fare cose che erano impossibili alcuni anni fa. Ok, avere nuove funzionalità disponibili è una cosa, ma gli sviluppatori le usano effettivamente in produzione nelle loro pagine web e applicazioni? È a questa domanda che cercheremo di rispondere con i dati.

In questo capitolo usiamo i dati per scoprire ciò che effettivamente gli sviluppatori utilizzano in produzione, piuttosto che le funzionalità più discusse su Twitter, mostrate alle conferenze o ritrovabili in demo ingegnosi. Possiamo vedere quali delle nuove funzionalità vengono adottate, quali vecchie tecniche stanno cadendo in disuso e le tecniche legacy che rimangono ostinatamente nei nostri fogli di stile.

## Utilizzo

Ogni anno vediamo che i file CSS aumentano di dimensioni e il 2022 non ha fatto eccezione.

{{ figure_markup(
    image="stylesheet-transfer-size.png",
    caption="Distribuzione delle peso dei fogli di stile per pagina",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile del peso dei fogli di stile per pagina. Per le pagine mobili, i valori sono 6, 28, 68, 139 e 256 KB. In tutti i percentili queste statistiche tendono a essere inferiori a quelle desktop per meno di 10 KB.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1081662712&format=interactive",
    sheets_gid="1921790724",
    sql_file="stylesheet_kbytes.sql"
  )
}}

A parte il 25° percentile, che è sceso di un punto percentuale, ogni percentile mostra un piccolo aumento delle dimensioni. Al 90° percentile l'aumento è di quasi il 7%, un aumento simile a quello osservato tra il [2020](../2020/css) e il [2021](../2021/css). I fogli di stile serviti ai dispositivi mobili rimangono leggermente più piccoli di quelli serviti ai desktop.

La pagina desktop con il maggior peso CSS, leggermente inferiore rispetto allo scorso anno, è di 62.631 KB. Il foglio di stile mobile più pesante è cresciuto da 17.823 KB a 78.543 KB, fortunatamente questa è un'eccezione.

{{ figure_markup(
    image="stylesheet-count.png",
    caption="Distribuzione del numero di fogli di stile per pagina.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile del numero di fogli di stile per pagina. I valori per le pagine desktop e mobile sono quasi identici rispettivamente a 1, 3, 7, 13 e 22 fogli di stile per pagina.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=358463962&format=interactive",
    sheets_gid="398646778",
    sql_file="stylesheet_count.sql"
  )
}}

Il numero di fogli di stile per pagina è rimasto pressoché identico al 2021, con un aumento di uno per i dispositivi mobili al 50° percentile.

L'anno scorso è stato battuto il record per il numero di fogli di stile caricati da una singola pagina a 2.368. Quest'anno abbiamo trovato un sito che caricava 1.387 fogli di stile sui dispositivi mobili, ancora una quantità significativa.

{{ figure_markup(
    image="rules-per-page.png",
    caption="Distribuzione del numero totale di regole di stile per pagina.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile del numero di regole di stile per pagina. Le pagine mobili e desktop tendono ad essere molto simili. I valori per i dispositivi mobili sono 52, 224, 613, 1.197 e 2.023 regole per pagina.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=2137701589&format=interactive",
    sheets_gid="1977925185",
    sql_file="rules_per_stylesheet.sql"
  )
}}

Dando un'occhiata al numero di regole di stile per pagina notiamo un aumento in tutti i percentili; nei percentili più bassi si riscontrano più regole per i dispositivi mobili, nei percentili più alti ci sono più regole per i desktop. Questi aumenti sono sostanziali. Le regole desktop per il 50° percentile sono aumentate di 130 regole e per il 90° percentile di 202.

{{ figure_markup(
    image="rules-per-stylesheet.png",
    caption="Distribuzione del numero di regole per foglio di stile.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile del numero di regole per foglio di stile. I valori mobili e desktop sono quasi identici. Sulle pagine mobili, i valori sono 0, 4, 31, 110 e 285 regole per foglio di stile.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=56198269&format=interactive",
    sheets_gid="1977925185",
    sql_file="rules_per_stylesheet.sql"
  )
}}

Possiamo vedere dal numero totale di fogli di stile caricati, che in genere le persone suddividono i loro CSS in più fogli di stile. Al 50° percentile risultano 31 regole per foglio di stile, che al 90° percentile salgono a 276 regole su desktop e 285 regole sui dispositivi mobili.

## I selettori e la cascata

Il 2022 ha visto uno scossone alla cascata con la regola [`@layer`](https://developer.mozilla.org/docs/Web/CSS/@layer) che si afferma su tutti i motori. Questa nuova <i lang="en">at-rule</i> consente il raggruppamento dei selettori in livelli (detti appunto <i lang="en">layers</i> in inglese), quindi - una volta raggruppati - è possibile gestire l'ordine di precedenza dei livelli.

È un po' presto per vedere un uso diffuso di questo nuovo metodo di gestione della cascata, ma diamo un'occhiata a come si è evoluto l'utilizzo del selettore.

### I nomi delle classi

{{ figure_markup(
    image="top-selector-classes.png",
    caption="I nomi delle classi più popolari per la percentuale di pagine che li utilizzano.",
    description="Grafico a barre che mostra i nomi delle classi CSS utilizzati nella maggior parte delle pagine. Mobile e desktop hanno risultati simili. Sui dispositivi mobili il nome di classe più usato è `active`, presente nel 47% delle pagine. Seguito da `fa` sul 33% delle pagine, altre classi con prefisso `fa` sul 32% delle pagine e classi con prefisso `wp` sul 31%. Il resto delle prime 10 classi in ordine decrescente sono: `button` con il 27% di adozione, `pull-right`, `emoji` e `disabled` al 26%, e infine `pull-left` e `title` al 25%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1082092053&format=interactive",
    height="691",
    sheets_gid="1020483137",
    sql_file="top_selector_classes_wp_fa_prefixes.sql"
  )
}}

Come nel 2020 e nel 2021, il nome della classe più popolare sul web è `active`. I prefissi `fa`, `fa-*` per Font Awesome rimangono fissi al secondo e terzo posto. Tuttavia, i nomi delle classi `wp-*` sono saliti di posizione, spostandosi al quarto posto. Ora compaiono nel 31% delle pagine, essendo già stati nel 20% delle pagine nel 2021. Vediamo anche comparire nomi di classi come `has-large-font-size`, che sono usati nel nuovo editor a blocchi di WordPress.

`clearfix` è scomparso dalla top 20, ora si trova solo nel 10% delle pagine, un'indicazione molto chiara che i layout basati su float stanno scomparendo dal web.

{{ figure_markup(
    image="top-selector-ids.png",
    caption="I nomi degli ID più popolari per la percentuale di pagine che li utilizzano.",
    description="Grafico a barre che mostra gli ID CSS utilizzati nella maggior parte delle pagine. Le tendenze per il mobile e per il desktop sono simili. L'ID `content` viene utilizzato nel 15% delle pagine, seguito da `footer` nel 12%, `header`, `fb-root`, `fb_dialog_loader_close`, `fb_dialog_ipad_overlay` e `fb_dialog_loader_spinner` tutti nel 10%, quindi `respond` e `comments` nel 9% e infine `main` nell'8% delle pagine.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=224121847&format=interactive",
    height="497",
    sheets_gid="756835829",
    sql_file="top_selector_ids.sql"
  )
}}

Il nome `content` è ancora una volta il nome ID più popolare, seguito da `footer` e `header`. Gli ID che iniziano con `fb_` indicano l'utilizzo dei widget di Facebook. Nel 2021 gli ID che iniziano con `rc-`, a indicare l'uso del sistema reCAPTCHA di Google, erano presenti nel 7% delle pagine e sono ancora presenti con la stessa frequenza, nonostante siano stati scalzati dalla top ten dai nomi degli ID di Facebook.

### `!important`

{{ figure_markup(
    image="important-adoption.png",
    caption="La distribuzione per pagina del numero di proprietà contrassegnate `!important`.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile del numero di occorrenze della proprietà contrassegnate come `!important` per pagina. Nelle pagine mobili, i valori sono rispettivamente 0%, 1%, 2%, 5% e 9%. Stessi valori nelle pagine desktop.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=316255168&format=interactive",
    sheets_gid="1802353995",
    sql_file="meta_important_adoption.sql"
  )
}}

L'uso di `!important` è leggermente aumentato per i primi due percentili quest'anno. Man mano che l'utilizzo di `@layer` prenderà piede, sarà interessante vedere come la nuova pratica influirà sull'uso di questa proprietà, tipicamente usata per affrontare problemi di specificità.

{{ figure_markup(
    image="important-props.png",
    caption="Le principali proprietà a cui viene applicato `!important` in percentuale di pagine.",
    description="Grafico a barre che mostra le proprietà più popolari contrassegnate con !important. Per le pagine mobili, i valori sono: `display` nell'83% delle pagine, `color` nel 77%, `width` nel 76%, `height` nel 74%, `padding` nel 72%, `background`, `background-color` e `margin` ciascuno nel 70%, `border` nel 69% e infine `font-size` nel 64%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1202340370&format=interactive",
    height="604",
    sheets_gid="377488072",
    sql_file="meta_important_properties.sql"
  )
}}

Rispetto a ciò a cui viene applicato `!important`, le proprietà principali rimangono invariate. Tuttavia va notato che `position` è uscito dalla top ten per essere sostituito da `font-size`.

### Specificità dei selettori

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">0,1,0</td>
        <td class="numeric">0,1,0</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">0,1,2</td>
        <td class="numeric">0,1,3</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">0,2,0</td>
        <td class="numeric">0,2,0</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">0,2,0</td>
        <td class="numeric">0,2,0</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">0,3,0</td>
        <td class="numeric">0,3,0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Distribuzione della mediana di specificità per pagina.",
    sheets_gid="1684019013",
    sql_file="specificity.sql"
  ) }}</figcaption>
</figure>

Fatta eccezione per il valore dei desktop al 25° percentile, i valori mediani di specificità sono esattamente gli stessi dell'anno scorso, rimanendo costanti negli ultimi due anni. Questi valori indicano la specificità appiattita creata da metodologie come <a href="https://en.bem.info/methodology/quick-start/" hreflang="en">BEM</a>.

### Pseudo-classi e pseudo-elementi

{{ figure_markup(
    image="pseudo-classes.png",
    caption="Le pseudo-classi più popolari per percentuale di pagine.",
    description="Grafico a barre che mostra le pseudo-classi più utilizzate nelle pagine. Sul mobile i valori sono `hover` nel 91%, `before` nel 77%, `focus` nel 76%, `after` nel 75%, `active` nel 73%, `first-child` nel 63%, `last-child` nel 60%, `not` nel 59%, dopodiché la popolarità diminuisce rapidamente con `visited` nel 48%, `root` nel 45%, `nth-child` nel 39%, `link` nel 34%, `disabled` nel 29%, `checked` nel 22% e infine `-ms-input-placeholder` nel 19%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=108638805&format=interactive",
    height="612",
    sheets_gid="370286500",
    sql_file="top_selector_pseudo_classes.sql"
  )
}}

Ancora una volta le pseudo-classi legate alle azioni utente `:hover`, `:focus` e `:active` sono nelle prime tre posizioni. Anche la pseudo-classe di negazione `:not()` continua a crescere in popolarità, insieme a `:root`, probabilmente usata per creare proprietà personalizzate (variabili CSS).

L'anno scorso è stato notato che `:focus-visible`, un modo per dare uno stile agli elementi in focus in un modo che corrisponda meglio alle aspettative degli utenti, è apparso in meno dell'1% delle pagine. La proprietà è disponibile in tutti e tre i principali motori da marzo 2022 e ora si trova sul 10% delle pagine desktop e sul 9% delle pagine mobili.

{{ figure_markup(
    image="pseudo-elements.png",
    caption="Gli pseudo-elementi più popolari per percentuale di pagine.",
    description="Grafico a barre che mostra gli pseudo-elementi senza prefisso più utilizzati nelle pagine. Per i dispositivi mobili, si ha `before` nel 41%, `after` nel 38%, `placeholder` nell'11%, `selection` nel 9%, `root` e `first-letter` entrambe nel 2%, `marker` nell'1% e infine `backdrop`, `full-page-media` e `file-selector-button` che si registrano a malapena in meno dell'1% delle pagine.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1671689923&format=interactive",
    height="500",
    sheets_gid="425572900",
    sql_file="top_selector_pseudo_elements.sql"
  )
}}

Abbiamo escluso dai dati qualsiasi pseudo-elemento con prefisso, e quindi specifico per browser. Tali pseudo-elementi infatti sono in genere utilizzati per selezionare i componenti dell'interfaccia o parti della cromatura del browser e noi qui siamo interessati agli pseudo-elementi che gli sviluppatori stanno effettivamente utilizzando.

L'uso di `::before` e `::after` è aumentato rispetto allo scorso anno. Questi pseudo-elementi vengono utilizzati per inserire nel documento del contenuto generato a partire dal CSS. Controllando l'uso della proprietà `content`, si nota che viene spesso utilizzata per inserire una stringa vuota, usata per scopi di stile. Il contenuto generato è un modo per modellare un'area di una griglia senza dover aggiungere un elemento; è forse questo il motivo che ha contribuito all'aumento dell'uso di queste proprietà?

L'uso dello pseudo-elemento `::marker` ha ora guadagnato la posizione dell'1%, dimostrando che le persone stanno lentamente iniziando a sfruttare la capacità di selezionare e definire lo stile dei punti elenco.

### Selettori di attributo

{{ figure_markup(
    image="attribute-selectors.png",
    caption="Selettori di attributo più popolari per percentuale di pagine.",
    description="Grafico a barre che mostra i selettori di attributo più utilizzati nelle pagine. Il valore più presente è `type` usato nel 54% delle pagine, quindi `class` nel 37%, `disabled` nel 24%, `dir` nel 17%, `role` e `title` nell'11%, `hidden` e `href` nel 10%, `aria-disabled` nel 9%, `style` e `src` nell'8%, `controls` e `id` nel 7%, `lang` e `aria-hidden` nel 5%, seguiti da `tabindex`, `name`, `data-type` e `aria-selected` tutti nel 4% e infine `multiple` nel 3% delle pagine.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1566442848&format=interactive",
    height="675",
    sheets_gid="1504728475",
    sql_file="top_selector_attributes.sql"
  )
}}

Il selettore di attributo più popolare è `type`, che si trova nel 54% delle pagine. I successivi selettori di attributo più popolari sono `class` nel 37%, `disabled` nel 25% e `dir` nel 17% delle pagine.

## Valori e unità di misura

I CSS offrono diversi modi per specificare valori e unità, o in misure prestabilite o come risultato di calcoli basati su parole chiave globali.

### Lunghezza

{{ figure_markup(
    image="length-units.png",
    caption="Unità di misura della lunghezza più popolari per percentuale di pagine.",
    description="Grafico a barre che mostra le unità di misura della lunghezza utilizzate nella maggior parte delle pagine. L'unità più popolare è pixel (`px`), utilizzata nel 71% delle pagine, seguita dalla percentuale (`%`) nel 18%, `em` nell'8% e `rem` nel 2%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1742992649&format=interactive",
    sheets_gid="161285719",
    sql_file="units_frequency.sql"
  )
}}

Le lunghezze in pixel rimangono le più popolari con il 71% delle pagine, la stessa percentuale del 2021. Anche la diffusione dell'utilizzo rimane più o meno la stessa.

<figure>
  <table>
    <thead>
      <tr>
        <th>Proprietà</th>
        <th><code>px</code></th>
        <th><code>&lt;numero&gt;</code></th>
        <th><code>em</code></th>
        <th><code>%</code></th>
        <th><code>rem</code></th>
        <th><code>pt</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>font-size</td>
        <td class="numeric"><span class="numeric-good">(▲2%)</span> 71%</td>
        <td class="numeric">2%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 15%</td>
        <td class="numeric">5%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 6%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 2%</td>
      </tr>
      <tr>
        <td>border-radius</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 64%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 20%</td>
        <td class="numeric">3.13%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 11%</td>
        <td class="numeric"><span class="numeric-good">(▲2%)</span> 2%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>line-height</td>
        <td class="numeric"><span class="numeric-bad">(▼5%)</span> 49%</td>
        <td class="numeric"><span class="numeric-good">(▲4%)</span> 35%</td>
        <td class="numeric">12.94%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 2%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 1%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>border</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 70%</td>
        <td class="numeric">28%</td>
        <td class="numeric">2%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>text-indent</td>
        <td class="numeric"><span class="numeric-bad">(▼5%)</span> 26%</td>
        <td class="numeric"><span class="numeric-good">(▲13%)</span> 65%</td>
        <td class="numeric"><span class="numeric-bad">(▼4%)</span> 5%</td>
        <td class="numeric"><span class="numeric-bad">(▼3%)</span> 5%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>vertical-align</td>
        <td class="numeric"><span class="numeric-bad">(▼26%)</span> 3%</td>
        <td class="numeric"><span class="numeric-bad">(▼9%)</span> 3%</td>
        <td class="numeric"><span class="numeric-good">(▲39%)</span> 94%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>gap</td>
        <td class="numeric"><span class="numeric-good">(▲4%)</span> 25%</td>
        <td class="numeric"><span class="numeric-bad">(▼6%)</span> 10%</td>
        <td class="numeric"><span class="numeric-good">(▲32%)</span> 33%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-bad">(▼31%)</span> 32%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>margin-inline-start</td>
        <td class="numeric"><span class="numeric-bad">(▼31%)</span> 7%</td>
        <td class="numeric"><span class="numeric-good">(▲3%)</span> 49%</td>
        <td class="numeric"><span class="numeric-good">(▲30%)</span> 44%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>grid-gap</td>
        <td class="numeric"><span class="numeric-good">(▲5%)</span> 68%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 10%</td>
        <td class="numeric"><span class="numeric-bad">(▼2%)</span> 7%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 15%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>margin-block-end</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 3%</td>
        <td class="numeric"><span class="numeric-good">(▲54%)</span> 85%</td>
        <td class="numeric"><span class="numeric-bad">(▼53%)</span> 12%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>padding-inline-start</td>
        <td class="numeric"><span class="numeric-bad">(▼4%)</span> 29%</td>
        <td class="numeric"><span class="numeric-good">(▲11%)</span> 16%</td>
        <td class="numeric"><span class="numeric-bad">(▼10%)</span> 53%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-good">(▲3%)</span> 3%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>mask-position</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 1%</td>
        <td class="numeric"><span class="numeric-good">(▲3%)</span> 3%</td>
        <td class="numeric"><span class="numeric-bad">(▼14%)</span> 36%</td>
        <td class="numeric"><span class="numeric-good">(▲10%)</span> 60%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(
    caption=" Distribuzione dei tipi di unità di lunghezza per proprietà.",
    sheets_gid="1471089154",
    sql_file="units_properties.sql"
  ) }}</figcaption>
</figure>

Le frecce in su e in giù nel grafico mostrano il cambiamento rispetto ai [risultati del 2021](../2021/css#fig-15). Come visto l'anno scorso, nella maggior parte dei casi si passa dall'impiego dei pixel a quello di altre unità di lunghezza. Ancora una volta, la proprietà `vertical-align` ha visto un enorme calo nell'uso di pixel e del semplice valore numerico, e un grande aumento nell'uso dell'unità `em`.

{{ figure_markup(
    image="font-relative-length-units.png",
    caption="Le più diffuse unità di misura della lunghezza relative ai font.",
    description="Grafico a torta che mostra la diffusione relativa delle unità di lunghezza applicate ai caratteri sulle pagine mobili. `em` costituisce il 79,9% delle occorrenze, `rem` il 19,5% e `ch` lo 0,5%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1099832022&format=interactive",
    sheets_gid="161285719",
    sql_file="units_frequency.sql"
  )
}}

Mentre `em` rimane il metodo più popolare per fissare le dimensioni dei caratteri, il passaggio a `rem` continua con un piccolo aumento (poco meno di due punti) rispetto allo scorso anno.

{{ figure_markup(
    image="zero-length-units.png",
    caption="Le unità di misura per la lunghezza (esplicitate o mancanti) utilizzate per indicare il valore a zero.",
    description="Grafico a torta che mostra la popolarità relativa delle unità di misura utilizzate su valori di lunghezza zero. Il più popolare è lo 0 senza unità nell'86,6% delle pagine, seguito da px nel 12,7% e altre unità nello 0,7%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=782579377&format=interactive",
    sheets_gid="242535636",
    sql_file="units_zero.sql"
  )
}}

Esistono alcune proprietà che consentono l'uso delle semplici unità numeriche (ad esempio, `line-height`), ma anche i valori che esprimono la lunghezza si comportano in modo speciale quando la lunghezza è pari a zero, non richiedendo che venga specificata l'unità di misura. Quando abbiamo esaminato tutti i valori di lunghezza zero, quasi l'87% di essi ometteva l'unità, una piccola diminuzione rispetto allo scorso anno. Quasi tutte le lunghezze zero che includevano un'unità utilizzavano i pixel (0px).

### Calcoli

{{ figure_markup(
    image="calc-props.png",
    caption="Le proprietà più popolari che utilizzano la funzione `calc()`.",
    description="Grafico a barre che mostra le proprietà che fanno uso di `calc()` presenti nella maggior parte delle pagine. La più popolare è `width` nel 27% delle pagine, seguita da `max-width` e `top` nel 14%, `height` nel 13%, `left` nel 10%, `max-height` nell'8%, `right` e `margin-left` nel 6%, `min-height` nel 5%, `margin-right` nel 4%, `padding-left` e `margin-top` nel 3%, quindi `padding-bottom`, `margin`, `bottom`, `padding-right`, `flex-basis` e `transform` tutte nel 2%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=203539180&format=interactive",
    height="695",
    sheets_gid="2120544742",
    sql_file="calc_properties.sql"
  )
}}

Come negli anni precedenti, l'uso più diffuso di `calc()` è nel calcolare i valori per la proprietà `width`. Questo utilizzo è diminuito di 12 punti percentuali, al tempo stesso, per `max-width` è aumentato di 9 punti.

{{ figure_markup(
    image="calc-units.png",
    caption="Le unità di lunghezza più diffuse utilizzate nelle funzioni `calc()`.",
    description="Grafico a barre che mostra le unità di misura usate per `calc()` nella maggior parte delle pagine. Percentuale (`%`) e pixel (`px`) sono entrambe usate nel 42% delle pagine, larghezza viewport (`vw`), altezza viewport (`vh`) ed `em` sono tutte usate nell'8% delle pagine e `rem` è usata nel 6%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1749089658&format=interactive",
    sheets_gid="1431660156",
    sql_file="calc_units.sql"
  )
}}

La percentuale di siti che utilizzano i pixel nei calcoli è diminuita di 9 punti, ora è al livello dell'utilizzo di `%` al 42%. C'è un aumento significativo dell'utilizzo di altri valori, le unità relative alla viewport `vw` e `vh` sono aumentate entrambe dal 2% all'8% quest'anno, `em` è aumentato della stessa quantità e l'uso di `rem` è raddoppiato dal 3% al 6%.

{{ figure_markup(
    image="calc-operators.png",
    caption="Gli operatori più diffusi utilizzati nelle funzioni `calc()`.",
    description="Grafico a barre che mostra gli operatori usati in `calc()` nella maggior parte delle pagine. L'operatore di sottrazione (-) viene utilizzato nel 42% delle pagine, seguito dall'operatore dell'addizione (+) nel 18%, da quello della divisione (/) nell'11% e da quello della moltiplicazione (*) nel 10%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1571752832&format=interactive",
    sheets_gid="220199231",
    sql_file="calc_operators.sql"
  )
}}

La sottrazione rimane nettamente la favorita in termini di operatori di calcolo, ma tutti e quattro i valori più diffusi hanno visto un calo dal 2021, a parte l'addizione, che è rimasta inalterata.

{{ figure_markup(
    image="calc-unit-complexity.png",
    caption="Il numero di tipi di unità utilizzate nei valori `calc()`.",
    description="Grafico a barre che mostra la distribuzione del numero di unità per occorrenza di `calc()`. Il 79% delle occorrenze di `calc()` utilizza due tipi di unità, seguito dal 20% delle occorrenze che utilizza un'unità. Solo l'1% delle occorrenze utilizza tre o più unità.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=220014387&format=interactive",
    sheets_gid="87407358",
    sql_file="calc_complexity_units.sql"
  )
}}

Come l'anno scorso, i valori di `calc()` tendono ad essere abbastanza semplici. La maggior parte utilizza due valori, come il caso d'uso comune della sottrazione di una lunghezza fissa (espressa ad esempio in pixel) da una percentuale. C'è stato un piccolo aumento per un tipo di unità e un piccolo calo per due tipi di unità.

## Keyword globali

{{ figure_markup(
    image="keywords.png",
    caption="Utilizzo di keyword globali.",
    description="Grafico a barre che mostra le keyword globali utilizzate nella maggior parte delle pagine. `inherit` (eredita) viene utilizzata nell'87% delle pagine, seguita da `initial` (iniziale) nel 64%, `unset` (annulla l'impostazione) nel 51% e `revert` (ripristina) nel 4%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1675598127&format=interactive",
    sheets_gid="393924630",
    sql_file="keyword_totals.sql"
  )
}}

L'anno scorso l'uso delle keyword globali era aumentato in modo significativo, nel 2022 `inherit` (eredita) si trova nella medesima percentuale di pagine, a differenza delle altre tre keyword che sono aumentate nell'uso. La keyword più recente `revert` (ripristina) è aumentata nell'uso dall'1% al 4%.

## Proprietà personalizzate (variabili CSS)

{{ figure_markup(
    image="custom-property-adoption.png",
    caption='Uso delle proprietà personalizzate (<i lang="en">custom property</i>) negli ultimi quattro anni.',
    description='Grafico a barre che mostra la cronologia per anno dell’utilizzo delle proprietà personalizzate (<i lang="en">custom property</i>) nelle pagine mobili a partire dal 2019. Dal 2019 al 2022, l’utilizzo delle proprietà personalizzate è cresciuto dal 5%, al 19%, al 29% e ora, nel 2022, al 42%. La funzione `var()` era utilizzata nel 27% delle pagine nel 2020, nel 35% nel 2021 e ora (2022) nel 43%.',
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=832908182&format=interactive",
    sheets_gid="786267748",
    sql_file="custom_property_adoption.sql"
  )
}}

Le proprietà personalizzate (<i lang="en">custom property</i>, chiamate anche "variabili CSS") hanno visto un enorme aumento di utilizzo, la crescita tra il 2021 e il 2022 non fa eccezione. Il 43% delle pagine, sia per desktop che per dispositivi mobili, utilizza proprietà personalizzate e ha almeno una funzione `var()`.

{{ figure_markup(
    image="custom-property-names.png",
    caption="Origine dei nomi delle proprietà personalizzate comuni.",
    description="Grafico a torta che mostra la diffusione relativa ddi ciò che causa l'origine dei nomi delle proprietà personalizzate. WordPress rappresenta la fonte per il 40,2% delle occorrenze delle proprietà personalizzate, altre fonti per il 36,5%, Elementor per l'11,4%, Bootstrap per il 10,2% e Woocommerce per l'1,3%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=321767420&format=interactive",
    sheets_gid="409270558",
    sql_file="custom_property_names.sql"
  )
}}

Come si è visto l'anno scorso, WordPress è la scaturigine principale per i nomi di proprietà personalizzate più comuni, che sono facilmente identificabili dal prefisso `–wp–*`. A seguire troviamo ancora una volta molti nomi di colori `–white`, `–blue` e così via, usati per assegnare una particolare tonalità di quel colore.

### Tipi

{{ figure_markup(
    image="custom-property-value-types.png",
    caption="Distribuzione dei tipi di valori assegnati alle proprietà personalizzate.",
    description="Grafico a torta che mostra la diffusione relativa dei tipi di valori assegnati alle proprietà personalizzate. Le proprietà personalizzate che impostano un valore di colore costituiscono il 30,6% degli utilizzi, seguite dai tipi di dimensione al 24,0%, altri tipi al 15,3%, tipi numerici all'11,4%, immagini al 9,0%, font stack al 7,6% e valori calcolati al 2,2% .",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=2125209096&format=interactive",
    sheets_gid="1053355643",
    sql_file="custom_property_value_types.sql"
  )
}}

L'assegnazione di un valore ad una proprietà personalizzata include l'assegnazione di un determinato tipo. Ad esempio, la stringa `--red: #EF2143` sta assegnando un valore di colore a `--red`, mentre `--multiplier: 2.5` sta assegnando un valore numerico. I tipi nel grafico sono leggermente cambiati rispetto allo scorso anno. Sappiamo che l'impostazione di un colore è l'uso più comune delle proprietà personalizzate e la quantità di pagine su cui si trovano i tipi di colore è in aumento. Tuttavia, in termini di quota di utilizzo, questa è scesa dal 40% al 30%. Entrano nel grafico della distribuzione `calc()` e le immagini come tipi di valore.

### Proprietà

{{ figure_markup(
    image="custom-property-props.png",
    caption="Le proprietà più popolari assegnate tramite proprietà personalizzate per percentuale di pagine.",
    description="Grafico a barre che mostra le proprietà contenenti proprietà personalizzate utilizzate nella maggior parte delle pagine. La proprietà `color` è impostata con una proprietà personalizzata nel 38% delle pagine, seguita da `background-color` nel 34%, `background` nel 32%, `border-color` nel 30%, `font-size` e `width` nel 27%, `padding-top` nel 21 %, `justify-content` nel 20%, `border` nel 19% e `height` nel 17%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1522542060&format=interactive",
    height="530",
    sheets_gid="1294760653",
    sql_file="custom_property_properties.sql"
  )
}}

Sebbene il numero di pagine che includono queste proprietà sia aumentato, le proprietà che hanno proprietà personalizzate come valore sono rimaste più o meno nello stesso ordine dell'anno scorso. È molto probabile che le proprietà personalizzate vengano utilizzate per `color`, non sorprende poiché la creazione di schemi di colori è un uso ovvio di questa funzionalità. Tuttavia, l'utilizzo della funzione `var()` per impostare `font-size` è passato dal 10° al 5° posto nell'elenco, e l'impostazione del valore di allineamento di `justify-content` è tra i primi dieci. Nel 2021 il 5% delle pagine mobili e il 4% delle pagine desktop utilizzavano proprietà personalizzate per impostare questo valore di allineamento, questo è salito al 20%. Dai dati sembra che parte di questo aumento sia dovuto all'utilizzo di WordPress, ad esempio il 5% delle pagine utilizza la proprietà personalizzata `–navigation-layout-justify`.

### Funzioni

{{ figure_markup(
    image="custom-property-functions.png",
    caption="Le funzioni più popolari assegnate alle proprietà personalizzate per percentuale di pagine.",
    description="Grafico a barre che mostra le funzioni assegnate a proprietà personalizzate utilizzate nella maggior parte delle pagine. La funzione più popolare è `calc`, usata nel 30% delle pagine, seguita da `linear-gradient` nell'11%, `rgba` nel 6%, `rotate`, `translate` e `scaleX` tutte nel 5% delle pagine, `translateX`, `scaleY`, `translateY`, `skewY`, `skewX` e `min` nel 4% delle pagine, `rgb`, `rotateY` e `rotateX` tutte nel 3% delle pagine.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=580147519&format=interactive",
    height="525",
    sheets_gid="580592610",
    sql_file="custom_property_functions.sql"
  )
}}

Abbiamo visto che la funzione `calc()` ha iniziato ad essere degna di nota come tipo di valore per le proprietà personalizzate, ed è di gran lunga la funzione più comunemente utilizzata in questo contesto. È seguita da `linear-gradient()` e dalla funzione `rgba()` usata per impostare i valori di colore RGB con un canale alfa. Dopo queste si posizionano le varie funzioni utilizzate per le transizioni e le animazioni, il che dimostra un uso crescente delle proprietà personalizzate per questo scopo.

### Complessità

È possibile includere proprietà personalizzate nei valori di altre proprietà personalizzate. Si consideri [questo esempio](../2020/css#complexity) dal Web Almanac 2020:

```css
:root {
  --base-hue: 335; /* profondità = 0 */
  --base-color: hsl(var(--base-hue) 90% 50%); /* profondità = 1 */
  --background: linear-gradient(var(--base-color), black); /* profondità = 2 */
}
```

Come indicano i commenti nell'esempio, più questi sottoriferimenti sono concatenati, maggiore è la profondità della proprietà personalizzata.

{{ figure_markup(
    image="custom-property-depth.png",
    caption="La distribuzione della profondità di proprietà personalizzate.",
    description="Grafico a barre che mostra la distribuzione dei valori di profondità delle proprietà personalizzate. Il 62% delle occorrenze di proprietà personalizzate ha una profondità di 0, non avendo proprietà personalizzate nidificate. Il 36% delle occorrenze ha una profondità di 1, con un livello di proprietà personalizzate nidificate. Il 2% delle occorrenze ha una profondità di 2 e meno dell'1% ha una profondità di 3 o più proprietà personalizzate.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=742584548&format=interactive",
    sheets_gid="1220007551",
    sql_file="custom_property_depth.sql"
  )
}}

Come si è visto nel 2021, la stragrande maggioranza delle proprietà personalizzate aveva una profondità pari a zero, il che significa che non includevano i valori di altre proprietà personalizzate nel loro valore. C'è stato un piccolo aumento del numero di proprietà con una profondità di uno e una piccola diminuzione del numero con una profondità di due. Tuttavia, dai dati non sembra che l'uso delle proprietà personalizzate sia diventato molto più complesso nell'ultimo anno.

## Colori

{{ figure_markup(
    image="color-formats.png",
    caption="I formati di colore più diffusi per percentuale di occorrenze.",
    description="Grafico a barre che mostra i formati colore utilizzati nella maggior parte delle pagine. La sintassi a sei cifre `#RRGGBB` è utilizzata nel 49% delle pagine, `#RGB` a tre cifre nel 25% delle pagine, la funzione `rgba()` nel 14% delle pagine, la parola chiave `transparent` nell'8% delle pagine, un nome di colore nel 2%, la funzione `rgb()` nel'1% e il resto dei formati sono stati utilizzati in meno dell'1% delle pagine, inclusi: `#RRGGBBAA` a otto cifre, la funzione `hsla()`, la parola chiave `currentColor`, `#RGBA` a quattro cifre, parole chiave del colore di sistema, la funzione `hsl()`, la funzione `color()`, la funzione `hwb()`, la funzione `lch()` e infine la funzione `lab()`, in ordine decrescente di popolarità.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=523191620&format=interactive",
    height="652",
    sheets_gid="750894349",
    sql_file="color_formats.sql"
  )
}}

L'uso della storica sintassi a sei cifre `#RRGGBB` rimane invariata rispetto al 2021, essendo utilizzata nella metà delle dichiarazioni di colore. Nonostante l'ampia compatibilità della sintassi esadecimale a otto cifre  `#RRGGBBAA`, la funzione `rgba()` è il modo più diffuso per aggiungere un componente alfa, probabilmente perché questa modalità è stata implementata nei browser molto prima.

Il basso utilizzo degli altri valori ci mostra una storia simile: la comunità web non ha ancora iniziato a sfruttare altri formati di colore, anche quelli ampiamente supportati come `hsl()`.

{{ figure_markup(
    image="color-keywords.png",
    caption="I nomi-colore meno diffusi per numero di occorrenze",
    description="Grafico a barre che mostra i nomi-colore utilizzati sul minor numero di pagine. `MediumSpringGreen` viene utilizzato solo in 1.793 pagine mobili. L'adozione aumenta gradualmente con `DarkSalmon`, `MediumOrchid`, `DarkOrchid`, `MediumSlateBlue`, `LavenderBlush`, `RosyBrown`,`Moccasin`, `SpringGreen` e `Thistle`, che arriva ad essere utilizzato in 2.205 pagine.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=80217989&format=interactive",
    height="464",
    sheets_gid="2096495459",
    sql_file="color_keywords.sql"
  )
}}

L'8% delle pagine utilizza la parola chiave `transparent`, rendendolo il nome-colore più popolare. Il 2% delle pagine utilizza altri nomi-colore, `white` è il più diffuso seguito da `black`. All'altra estremità della scala `mediumspringgreen` è il nome-colore meno popolare.

### Supporto alpha e suo utilizzo

{{ figure_markup(
    image="color-formats-alpha.png",
    caption="I formati di colore più diffusi e supporto alfa.",
    description="Grafico a barre che mostra la diffusione dei formati di colore alfa rispetto ai formati senza supporto alfa. Il 23% dei formati colore utilizzati supporta l'alfa e il 77% no.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=806405561&format=interactive",
    sheets_gid="750894349",
    sql_file="color_formats.sql"
  )
}}

La funzione `rgba()` è il terzo formato colore più diffuso, utilizzato molto di più della forma `rgb()`, presumibilmente per utilizzare il supporto del canale alfa. Abbiamo esaminato le occorrenze di valori con e senza supporto alfa, per scoprire che il 77% dei formati colore utilizzati non supporta un canale alfa.

{{ figure_markup(
    image="color-formats-alpha-distribution.png",
    caption="Distribuzione dei formati colore per supporto alfa.",
    description="Grafico a barre che mostra l'utilizzo relativo dei formati colore che supportano l'alfa. La funzione `rgba()` viene utilizzata nel 14% delle occorrenze, seguita dalla parola chiave `transparent` nell'8%. Altri formati si registrano in meno dell'1% delle occorrenze.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1242036465&format=interactive",
    sheets_gid="750894349",
    sql_file="color_formats.sql"
  )
}}

Come ci si aspetterebbe da altri dati, `rgba()` è il formato di supporto alfa più in uso, seguito dalla parola chiave `transparent`. Altri formati come `hsla()` compaiono a malapena.

### Nuove proprietà e valori del colore

Cose interessanti accadono nel mondo del colore. Oltre ai nuovi spazi colore, abbiamo una serie di proprietà e valori relativi al colore. Ci siamo chiesti se qualcuno di questi avesse avuto un impatto sui dati.

La proprietà <a hreflang="en" href="https://web.dev/accent-color/">`accent-color`</a> consente di aggiungere il colore del marchio come colore di accento a quegli elementi del moduli che sono notoriamente difficili da personalizzare, come i <i lang="en">checkbox</i> (caselle di controllo), i <i lang="en">radio buttons</i> (pulsanti di opzione) e i <i lang="en">range sliders</i> (cursori di intervallo). Forse a causa del fatto che è disponibile in tutti i motori solo da marzo di quest'anno, mostra ancora meno dello 0,3% di utilizzo.

Un'altra proprietà disponibile in tutti i motori a partire da quest'anno è [`color-scheme`](https://developer.mozilla.org/docs/Web/CSS/color-scheme), una proprietà che ti consente di specificare in quali combinazioni di colori (chiari o scuri) un componente può essere renderizzato. Questa proprietà è, in qualche modo sorprendentemente, finora trovata solo nello 0,2% delle pagine.

## Gradienti e immagini

{{ figure_markup(
    image="gradient-functions.png",
    caption='Le funzioni <i lang="en">gradient</i> (di sfumatura) più popolari per percentuale di pagine',
    description="Grafico a barre che mostra le funzioni di sfumatura utilizzate sulla maggior parte delle pagine. `linear-gradient` viene utilizzata nel 76% delle pagine, seguita da `-webkit-linear-gradient` nel 53%, `-webkit-gradient` nel 44%, `-o-linear-gradient` nel 43%, `-moz-linear-gradient` nel 38% , `-ms-linear-gradient` nel 23%, `radial-gradient` nel 15%, `-webkit-radial-gradient` nel 6%, `repeating-linear-gradient` nel 4% e infine `-moz-radial-gradient` nel 2% delle pagine.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=824533060&format=interactive",
    height="486",
    sheets_gid="972045834",
    sql_file="gradient_functions.sql"
  )
}}

Le sfumature lineari continuano a essere la scelta più frequente, compaiono infatti in una percentuale di pagine leggermente superiore rispetto al 2021, anche se l'uso delle sfumature in generale è rimasto praticamente lo stesso negli ultimi due anni. C'è ancora un cospicuo utilizzo del prefisso quando si tratta della proprietà `linear-gradient`, nonostante questa proprietà sia supportata senza prefisso in tutti i motori già da oltre nove anni.

### Formati di immagine

{{ figure_markup(
    image="image-formats.png",
    caption="Formati di immagine caricati dai CSS.",
    description="Grafico a torta che mostra la popolarità relativa dei formati di immagini caricati dai CSS. PNG rappresenta il 30,3% dell'utilizzo, seguito da SVG nel 23,1%, GIF nel 19,0%, JPG nel 18,1%, WebP nel 9,3% e altri formati in meno dell'1% delle occorrenze.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1771292057&format=interactive",
    sheets_gid="947921429",
    sql_file="image_formats.sql"
  )
}}

Questo grafico scompone i formati immagine delle immagini caricate dai CSS. Non include le immagini caricate da HTML, ma solo quelle che appaiono in una regola di stile. C'è stato un significativo allontanamento da PNG, un calo dal 44% al 30%, con SVG e WebP in aumento di 6 punti percentuali ciascuno.

### Numero di immagini in CSS

{{ figure_markup(
    image="css-initiated-images.png",
    caption="Distribuzione del numero di immagini caricate da CSS.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile delle immagini caricate dai CSS per pagina. I valori per le pagine mobili sono rispettivamente 1, 1, 3, 5 e 10 e sono molto simili a quelli delle pagine desktop.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1307100659&format=interactive",
    sheets_gid="504054046",
    sql_file="image_weights.sql"
  )
}}

Il numero di immagini caricate dai CSS è rimasto lo stesso del 2021. I CSS non causano molti caricamenti di immagini: i due percentili più bassi arrivavano entrambi ad un'immagine e persino il 90° percentile si aggira attorno a 10 immagini, per tutti i tipi di immagine.

### Peso delle immagini nei CSS

Sebbene i CSS non causino molti caricamenti di immagini, il peso di tali immagini è importante. I dati hanno mostrato che il peso delle immagini è aumentato dal 2021, nonostante il numero di immagini sia rimasto lo stesso.

{{ figure_markup(
    image="image-weights.png",
    caption="Distribuzione del peso totale delle immagini caricate da CSS.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile dei byte totali di immagini richiamate da CSS per pagina. Sulle pagine mobili i valori sono 1, 3, 17, 134 e 547 KB. Le pagine desktop tendono a caricare immagini più pesanti ai percentili più alti, nella misura di decine di KB in più.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1802160609&format=interactive",
    sheets_gid="504054046",
    sql_file="image_weights.sql"
  )
}}

La pagina mediana, sui dispositivi mobili, presenta un aumento del peso delle immagini da 1 KB a 17 KB. All'estremità superiore del grafico, tuttavia, al 90° percentile vediamo un aumento di 67 KB su dispositivi mobili e 42 KB su desktop. Come nel 2021, il peso è costantemente inferiore sui dispositivi mobili, un'indicazione che gli sviluppatori stanno cercando di offrire immagini più piccole ai contesti mobili.

### Dimensione in pixel delle immagini in CSS

{{ figure_markup(
    image="image-dimensions.png",
    caption="Distribuzione delle dimensioni delle immagini caricate da CSS.",
    description="Grafico a barre che mostra il 25°, 50° e 75° percentile delle dimensioni delle immagini richiamate da CSS per pagina, misurate in pixel quadrati. Sulle pagine mobili, i valori sono 729, 2.910 e 44.096 pixel quadrati. Le pagine del desktop tendono a caricare immagini significativamente più piccole.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=86638563&format=interactive",
    sheets_gid="366877201",
    sql_file="image_dimensions.sql"
  )
}}

Questo è un grafico interessante che mostra che in corrispondenza dei valori più bassi del grafico le persone forniscono immagini di dimensioni più o meno simili su desktop e su dispositivi mobili, al 50° e 75° percentile le pagine offrono ai loro utenti mobili immagini molto più grandi di quanto non facciano sul desktop. Ciò che mostrano i dati è che le persone forniscono immagini molto più ampie ai propri utenti mobili, forse nel tentativo di tenere conto dei tablet in modalità orizzontale.

## Layout

Abbiamo molte opzioni tra cui scegliere quando progettiamo il layout sul web ed è ragionevole pensare che la maggior parte dei siti utilizzerà diversi fra questi metodi. Una semplice analisi dei dati, ricercando combinazioni di proprietà e valori che rilevino i metodi di layout utilizzati, ci fornisce la tabella seguente.

{{ figure_markup(
    image="layout-props.png",
    caption="Metodi di layout per percentuale di pagine.",
    description="Grafico a barre che mostra i metodi di layout utilizzati nella maggior parte delle pagine. I layout con `block` e `absolute` vengono utilizzati nel 92% delle pagine, seguiti da `inline-block` nel 90%, `float` nel'89%, `fixed` nell'84%, `inline` nell'82%, le tabelle CSS nel 79%, `flex` nel 77% e `box` nel 51% delle pagine.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1738709324&format=interactive",
    height=756,
    sheets_gid="1793404870",
    sql_file="layout_properties.sql"
  )
}}

Questo grafico non ci dice il metodo di layout principale utilizzato in una pagina. Indica che una proprietà o un valore appare nel CSS per quelle pagine. Ad esempio, il 51% delle pagine utilizza la vecchia versione del 2009 di flexbox, con `display: box`. È probabile che tale dichiarazione sia stata aggiunta per la compatibilità con le versioni precedenti, forse tramite uno strumento come Autoprefixer.

### Adozione di `flexbox` e `grid`

{{ figure_markup(
    image="flexbox-grid.png",
    caption="Adozione di flexbox e grid negli ultimi quattro anni.",
    description="Grafico a barre che mostra le tendenze di adozione di flexbox e grid sulle pagine mobili dal 2019 al 2022, per anno. Flexbox è stato utilizzato nel 49% delle pagine nel 2019, nel 63% nel 2020, nel 71% nel 2021 e nel 74% nel 2022. Grid è stato utilizzato nel 2% delle pagine nel 2019, nel 5% nel 2020, nell'8% nel 2021 e nel 12% nel 2022.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1410523848&format=interactive",
    sheets_gid="1855799827",
    sql_file="flexbox_grid.sql"
  )
}}

L'utilizzo di flexbox e grid continua a crescere. Nel 2021, l'adozione di flexbox era del 71%, ora è al 74%. Grid è passato dall'8% al 12%. Va notato che, contrariamente alla sezione precedente, ciò che si è misurato qui è la percentuale di pagine che stanno effettivamente utilizzando flexbox o grid per il layout, al contrario di prima dove si sono misurate le pagine che semplicemente hanno una qualche proprietà flexbox o grid nel foglio di stile.

L'adozione di grid è piuttosto lenta. Riteniamo che ciò possa essere dovuto alla prevalenza di framework utilizzati per il layout, molti dei quali hanno basato i loro layout su flexbox.

Abbiamo anche dato un'occhiata ad un paio di valori delle proprietà `flex` e `grid` che sono più recenti, per vedere come si stava sviluppando l'adozione di queste nuove funzionalità.

Il valore del contenuto per la proprietà `flex-basis` è un'istruzione esplicita al browser di guardare alla dimensione del contenuto intrinseco dell'elemento, piuttosto che a qualsiasi larghezza impostata sull'elemento stesso. È un valore recente, al momento in cui scrivo non disponibile nella versione di rilascio di Safari. Attualmente, solo lo 0,5% dei siti mobili e lo 0,6% dei siti desktop utilizzano questo valore.

Il valore `subgrid` per `grid-template-rows` e `grid-template-columns` è, al momento dell'indagine, supportato solo da Firefox. Forse non sorprende notare che compare solo in 211 pagine mobili e 212 desktop nell'intero set di dati. Dal momento che il valore fa parte del progetto [Interop 2022](./interoperabilità), sarà interessante vedere come crescerà il supporto una volta diventato interoperabile.

### `Box-sizing`

{{ figure_markup(
    content="92%",
    caption="La percentuale di pagine che imposta `box-sizing: border-box`.",
    classes="big-number",
    sheets_gid="859735058",
    sql_file="box_sizing.sql"
  )
}}

Il web ha votato in modo schiacciante per rifiutare il _box model_ originale del W3C a favore di `box-sizing: border-box`. Il numero di pagine che utilizzano questa combinazione di proprietà e valore è leggermente aumentato di nuovo, superando il 90% delle pagine.


{{ figure_markup(
    content="44%",
    caption="La percentuale di pagine che dichiara `box-sizing: border-box` applicato al selettore universale `*`.",
    classes="big-number",
    sheets_gid="1754933881",
    sql_file="box_sizing_border_box_selectors.sql"
  )
}}

Quasi la metà di tutte le pagine analizzate applica il ridimensionamento `border-box` a ogni elemento della pagina tramite il selettore universale (`*`).

Circa il 22% delle pagine utilizza `border-box` su caselle di controllo (checkbox) e pulsanti di opzione (radio button). Incontriamo ancora molte classi `.wp-`, a dimostrazione del fatto che WordPress è responsabile dell'uso nel 20% delle pagine analizzate.

{{ figure_markup(
    image="box-sizing.png",
    caption="Distribuzione del numero di dichiarazioni `border-box` per pagina.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile del numero di dichiarazioni `box-sizing: border-box` per pagina. I valori in ordine sono: 1, 7, 22, 52 e 101 dichiarazioni per pagina.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1043112167&format=interactive",
    sheets_gid="859735058",
    sql_file="box_sizing.sql"
  )
}}

La pagina mobile mediana dichiara `border-box` 22 volte. Al 90° percentile viene dichiarato ben 101 volte. Si tenga presente che le query degli anni precedenti presentavano un bug che interessava questa metrica. Correggendo l'errore, i risultati nel 2021 risultano comparabili a questi.

### Multicolonna

{{ figure_markup(
    content="23%",
    caption="Percentuale di pagine che utilizzano il layout a più colonne.",
    classes="big-number",
    sheets_gid="1226061352",
    sql_file="multicol.sql"
  )
}}

L'uso del layout [multi-colonna](https://developer.mozilla.org/docs/Web/CSS/CSS_Columns) è aumentato ancora una volta, ora si trova nel 23% delle pagine, con un aumento di 3 punti dal 2021.

### La proprietà `aspect-ratio`

{{ figure_markup(
    content="2%",
    caption="Percentuale di pagine che usano la proprietà `aspect-ratio`.",
    classes="big-number",
    sheets_gid="1009310505",
    sql_file="all_properties.sql"
  )
}}

La nuova proprietà `aspect-ratio` viene usata nel 2% delle pagine. La proprietà è diventata interoperabile verso la fine del 2021, quindi sarà interessante vederne crescere nel tempo l'utilizzo.

## Transizioni e animazioni

La proprietà `animation` compare nel 77% delle pagine mobili (la stessa percentuale dello scorso anno) e aumenta leggermente su desktop arrivando al 76,8%. La proprietà `transition` è ancora più popolare, si trova nell'85% delle pagine mobili e nell'85,6% delle pagine desktop. La frequenza su desktop è leggermente diminuita di circa 4 punti percentuali dal 2021.

{{ figure_markup(
    image="transition-props.png",
    caption="Le proprietà `transition` più popolari per percentuale di pagine.",
    description="Grafico a barre che mostra le proprietà `transition` utilizzate nella maggior parte delle pagine. La proprietà più popolare `all` viene utilizzata nel 53% delle pagine, seguita da `opacity` nel 50%, `transform` 38%, `none` 25%, `height` 22%, `color` 21%, `background-color` 20%, `background` 17%, `box-shadow` 13% , `left` 12%, `width`, `top` e `-webkit-transform` 10%, `border-color` e `visibility` 8%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1745619326&format=interactive",
    height="533",
    sheets_gid="349042756",
    sql_file="transition_properties.sql"
  )
}}

Come visto l'anno scorso, l'uso più comune consiste nell'applicare transizioni a tutte le proprietà animabili con la parola chiave `all`. Questo utilizzo è cresciuto fino al 53%, in salita di 7 punti percentuali, seguito da `opacity` nel 50% delle pagine.

{{ figure_markup(
    image="transition-durations.png",
    caption="Distribuzione della durata delle transizioni.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile della durata delle transizioni. I valori nell'ordine sono: 100, 170, 300, 400 e 1.000 millisecondi.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=364746687&format=interactive",
    sheets_gid="1177632572",
    sql_file="transition_durations.sql"
  )
}}

Guardando la durata delle transizioni, vediamo un cambiamento rispetto allo scorso anno. Nel 2021, al 90° percentile, la durata mediana della transizione era di mezzo secondo, ora è salita a 1 secondo. Registriamo aumenti in tutti i primi quattro percentili.

{{ figure_markup(
    image="transition-delays.png",
    caption="Distribuzione del ritardo delle transizioni.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile del ritardo delle transizioni. I valori in ordine sono: -600, 0, 140, 300 e 500 millisecondi.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=658113477&format=interactive",
    sheets_gid="1737381354",
    sql_file="transition_delays.sql"
  )
}}

Anche la distribuzione del ritardo delle transizioni è cambiata. Il ritardo del 90° percentile è sceso da 1,7 secondi a mezzo secondo. Sebbene il ritardo mediano del 10° percentile sia ora di oltre mezzo secondo negativo. Caso che si vede quando una transizione inizia a metà dell'animazione risultante.

{{ figure_markup(
    image="transition-keyframe-distribution.png",
    caption="Distribuzione dei fotogrammi chiave per animazione.",
    description="Grafico a barre che mostra il 10°, 25°, 50°, 75° e 90° percentile del numero di fotogrammi chiave per animazione. I valori nell'ordine sono: 2, 2, 2, 3 e 5 fotogrammi chiave.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=646157411&format=interactive",
    sheets_gid="376876473",
    sql_file="transition_keyframes_distribution.sql"
  )
}}

Abbiamo anche esaminato il numero medio di fotogrammi chiave utilizzati per animazione e abbiamo trovato un sito che utilizzava l'incredibile cifra di 6.995 fotogrammi chiave. Un caso insolito comunque, infatti, anche al 90° percentile, il numero di fotogrammi chiave per animazione è cinque sia su desktop che su dispositivi mobili.

{{ figure_markup(
    image="transition-keyframe-stops.png",
    caption="I fotogrammi chiave di transizione più popolari per percentuale di occorrenze.",
    description="Grafico a barre che mostra i fotogrammi chiave utilizzati nella maggior parte delle regole di transizione. Il fotogramma chiave più popolare è il valore 0% nel 22% delle occorrenze, seguito dal valore `to` nel 16%, il valore 100% nel 15%, il valore `from` nel 7%, con i restanti fotogrammi chiave in diminuzione di popolarità: 50%, 60%, 40%, 80%, 20%, 75% e 90%, che termina al 2% di adozione.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=550751466&format=interactive",
    sheets_gid="1859883128",
    sql_file="transition_keyframe_stops.sql"
  )
}}

Come ci si potrebbe aspettare, gli stop alle animazioni più popolari sono al valore 0% da e verso il valore 100%, seguiti dal valore 50%. Gli sviluppatori generalmente impostano questi stop a intervalli del valore di 10%, solo l'1% delle pagine utilizza il valore 33%, ad esempio.

{{ figure_markup(
    image="transition-timing-functions.png",
    caption="Distribuzione delle funzioni di temporizzazione.",
    description="Grafico a torta che mostra la distribuzione relativa dell'utilizzo della funzione di temporizzazione. La funzione `ease` viene utilizzata nel 31,8% delle transizioni, seguita da `linear` nel 17,9%, `ease-in-out` nel 17,5%, `cubic-bezier` nel 16,4%, `ease-out` nell'8,4%, `ease-in` nel 5,2% e `steps` nel 2,8%",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=586595091&format=interactive",
    sheets_gid="1907298177",
    sql_file="transition_timing_functions.sql"
  )
}}

Rispetto al 2021, c'è stato poco cambiamento nella distribuzione delle funzioni di temporizzazione utilizzate durante le transizioni. Come allora, il leader indiscusso è `ease`.

{{ figure_markup(
    image="transition-animation-names.png",
    caption="Tipi di animazione identificati a partire dal nome dell'animazione.",
    description="Grafico a barre che mostra i tipi di animazione utilizzati per la maggior parte delle volte. Il tipo più popolare è _uncategorized_ al 13%, seguito da `rotate` al 13%, `bounce` all'11%, `slide` al 10%, `fade` al 9%, `wobble` al 5%, `scale` al 4%, `pulse` al 2% e `visibility` al 2%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=214267440&format=interactive",
    height="463",
    sheets_gid="1632805666",
    sql_file="transition_animation_names.sql"
  )
}}

Per capire come gli sviluppatori utilizzano le animazioni, abbiamo dato un'occhiata ai nomi usati per le classi di animazione. Ad esempio, qualsiasi cosa con `spin` nel nome della classe viene considerata ruotata (`rotate`). Le animazioni di rotazione sono state anche quest'anno le più popolari, come nel 2021, anche se la percentuale è scesa dal 18% al 13%; con le animazioni di rimbalzo (`bounce`) che sono passate dal 5° al 3° posto nell'elenco.

Come l'anno scorso, l'alto valore nella categoria _unknown/other_ è dovuto alla prevalenza del nome di classe `a`, che non riusciamo a ricondurre ad un tipo di animazione specifico.

## Effetti visivi

{{ figure_markup(
    content="18%",
    caption="Percentuale di pagine che utilizzano i metodi di fusione.",
    classes="big-number",
    sheets_gid="971500",
    sql_file="effects_blend_mode_popularity.sql"
  )
}}

Abbiamo esaminato alcuni effetti visivi utilizzati nei CSS. Ad esempio, il 18% delle pagine desktop definisce degli stili per le proprietà `background-blend-mode` o `mix-blend-mode`.

{{ figure_markup(
    image="blend-mode-values.png",
    caption="I metodi di fusione più usati nelle pagine che impostano la modalità di fusione.",
    description="Grafico a barre che mostra i metodi di fusione utilizzati nella maggior parte delle pagine. Il valore `multiply` viene utilizzato nel 42% delle pagine che impostano la proprietà `blend-mode`, seguito da `overlay` e `screen` nel 33% delle pagine, `darken` nel 32%, `lighten` nel 31%, `soft-light` nel 29%, `color` nel 28% , `color-burn` e `color-dodge` nel 28% e infine `difference` nel 21%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=204649391&format=interactive",
    height="515",
    sheets_gid="648874350",
    sql_file="effects_blend_mode_values.sql"
  )
}}

Il valore più frequente per i metodi di fusione è stato `multiply`, comparso nel 42% delle pagine. Anche per gli altri valori comunque c'è un'equa distribuzione.

Circa il 18% delle pagine utilizzava una proprietà personalizzata `var(--overlay-mix-blend-mode)`, un nome specifico che deve provenire da una libreria o da uno strumento di qualche tipo.

{{ figure_markup(
    image="filter-functions.png",
    caption="Le funzioni di filtro più popolari nelle pagine che impostano i filtri.",
    description="Grafico a barre che mostra le funzioni utilizzate nella maggior parte delle pagine che impostano i filtri. La funzione `alpha` viene utilizzata l'82% delle volte, seguita da nessun filtro (`none`) il 59%, `progid:DXImageTransform.Microsoft.gradient` il 46%, `blur` il 31%, `drop-shadow` e `grayscale` il 22%, `brightness` il 20%, `progid:DXImageTransform.Microsoft.BasicImage` il 16%, `saturate` l'11%, `inherit` il 10%, `url`, `sepia`, `contrast` e `none !important` tutte l'8%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1568163707&format=interactive",
    height="591",
    sheets_gid="1004790461",
    sql_file="effects_filter_functions.sql"
  )
}}

Della percentuale di pagine che usano i filtri per applicare effetti grafici, l'82% utilizza il valore `alpha()`, che non è un valore standard e viene utilizzato per Internet Explorer 8 e versioni precedenti. Inoltre vediamo anche un elevato utilizzo del filtro <a hreflang="en" href="https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms532997(v=vs.85)">`Microsoft.gradient()`</a>.

Fra i [valori standard](https://developer.mozilla.org/docs/Web/CSS/filter), il 31% delle pagine usa `blur()`, facendone il valore più popolare dopo `none`.

{{ figure_markup(
    image="clip-path-functions.png",
    caption="Valori `clip-path` più diffusi in pagine che settano `clip-path()`.",
    description="Grafico a barre che mostra i valori per `clip-path` (percorso di ritaglio) utilizzati nella maggior parte delle pagine che impostano `clip-path`. Il valore più popolare è `inset`, che viene utilizzato l'88% delle volte, seguito da `none` al 70%, `polygon` al 17%, `var` al 9%, `circle` al 7%, `url` al 3% ed `ellipse` al 2%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=163739565&format=interactive",
    sheets_gid="1458239816",
    sql_file="effects_clip_path_functions.sql"
  )
}}

Nelle pagine che usano `clip-path` per ritagliare un elemento, la stragrande maggioranza usa `inset()`, il valore che semplicemente inserisce la casella dell'elemento, l'88% delle pagine che usano `clip-path` hanno usato questa funzione.

Dopo di che, e dopo il valore `none`, la maggior parte degli sviluppatori ha scelto di usare `polygon()`, che è il valore che offre la flessibilità maggiore per definire il proprio percorso.

## Responsive design

Mentre molti sviluppatori stanno aspettando con impazienza le [container queries](https://developer.mozilla.org/docs/Web/CSS/CSS_Container_Queries) e contemporaneamente i nuovi metodi di layout come flexbox e grid possono in molti casi consentire ad un progetto di funzionare bene su diverse dimensioni di schermo, sono le [media queries](https://developer.mozilla.org/docs/Web/CSS/Media_Queries/Using_media_queries) ad essere utilizzate nella maggior parte delle pagine per realizzare il _responsive design_.

Quando gli sviluppatori scrivono le _media query_, ciò che testano più spesso è la larghezza del viewport. `max-width` e `min-width` sono state di gran lunga le query più popolari quest'anno, proprio come nel 2020 e nel 2021. Non ci sono stati cambiamenti in classifica nemmeno per i risultati del terzo e quarto posto.

{{ figure_markup(
    image="media-query-features.png",
    caption="Funzionalità delle media query più popolari.",
    description="Grafico a barre che mostra le funzionalità di media query utilizzate nella maggior parte delle pagine. La funzionalità più popolare è `max-width` nell'83% delle pagine, seguita da `min-width` nel 79%, `-webkit-min-device-pixel-ratio` nel 35%, `prefers-reduced-motion` nel 34%, `orientation` nel 30%, `max-device-width` nel 26%, `-ms-high-contrast` nel 24%, `max-height` nel 23%, `min-resolution` nel 19%, `-webkit-transform-3d` e `transform-3d` nel 12%, `min-device-pixel-ratio` e `min-height` nell'11%, `min--moz-device-pixel-ratio` nel 10%, `forced-colors`, `min-device-width`, e `prefers-color-scheme` nell'8%, `-o-min-device-pixel-ratio` nel 7%, `hover` nel 5% e `pointer` nel 2%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=2066259966&format=interactive",
    height="598",
    sheets_gid="2106336302",
    sql_file="media_query_features.sql"
  )
}}

La media query `prefers-reduced-motion`, che era in ascesa in classifica già nel 2021, ha ora scalzato `orientation` dal quarto posto. Ciò è dovuto sia all'aumento pari al 2% di `prefers-reduced-motion` ma anche al calo del 4% di `orientation`.

{{ figure_markup(
    image="prefers-features.png",
    caption="Uso delle funzionalità di preferenze utente per percentuale di pagine.",
    description="Grafico a barre che mostra le funzionalità delle media query con il prefisso `prefers`. Il valore più popolare è `prefers-reduced-motion` nel 34% delle pagine, quindi `prefers-color-scheme` nell'8%, `prefers-contrast` nell'1% e `prefers-reduced-transparency` in meno dell'1%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=632942914&format=interactive",
    sheets_gid="2106336302",
    sql_file="media_query_features.sql"
  )
}}

Se guardiamo solo alle funzionalità delle preferenze utente con prefisso `prefers-*`, possiamo vedere che `prefers-reduced-motion` è di gran lunga la più popolare, grazie al buon supporto dei browser e alla diffusione di animazioni e transizioni sul web. La funzionalità `prefers-color-scheme`, che controlla se l'utente ha impostato una preferenza per uno schema chiaro o scuro, è leggermente aumentata in uso, poiché l'uso del _dark mode_ su siti web e applicazioni è sempre più popolare.

{{ figure_markup(
    image="hover-features.png",
    caption="Utilizzo delle funzionalità del tipo di medium `hover` e `pointer`.",
    description="Grafico a barre che mostra la popolarità delle _media feature_ `hover` e `pointer`. La _media feature_ `hover` viene utilizzata nel 5% delle pagine, `pointer` nel 2% e `any-pointer` e `any-hover` al di sotto dell'1% delle pagine.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1898240066&format=interactive",
    sheets_gid="2106336302",
    sql_file="media_query_features.sql"
  )
}}

Le _media feature_ `hover` e `pointer` aiutano gli sviluppatori a testare le capacità del dispositivo e il modo in cui l'utente potrebbe interagire con esso. Sono un modo migliore per scoprire se un utente utilizza un touchscreen, ad esempio, rispetto alle sole dimensioni dello schermo, dato il numero di tablet di grandi dimensioni e laptop touchscreen in uso.

Sia `hover` che `pointer` ora appaiono nei primi dieci risultati. Le _media feature_ meno utili `any-pointer` e `any-hover` sono usate molto poco. L'utilizzo di `any-pointer` consente di determinare se un utente ha accesso a un puntatore fine come un mouse o un trackpad, anche se `pointer` indica che sta attualmente utilizzando il touchscreen. Chiedere a un utente di cambiare il puntatore fra quelli a disposizione non è sicuramente l'ideale, anche se una combinazione di queste caratteristiche potrebbe fornire una buona comprensione dell'ambiente in cui sta lavorando l'utente.

### Breakpoint comuni

{{ figure_markup(
    image="media-query-breakpoints.png",
    caption="Distribuzione dei breakpoints più popolari.",
    description="Grafico a barre che mostra i breakpoint più popolari utilizzati nelle media query. Il 35% delle pagine utilizza 480px come `max-width` e il 23% come `min-width`. Il 39% delle pagine utilizza 600px come `max-width` e il 32% come `min-width`. Il 51% delle pagine utilizza 767px come `max-width` e l'8% come `min-width`. Il 38% delle pagine utilizza 768px come `max-width` e il 57% come `min-width`. Il 12% delle pagine utilizza 782px come `max-width` e il 25% come `min-width`. Il 25% delle pagine utilizza 800px come `max-width` e il 7% come `min-width`. Il 29% delle pagine utilizza 991px come `max-width` e il 3% come `min-width`. Il 13% delle pagine utilizza 992px come `max-width` e il 39% come `min-width`. Il 26% delle pagine utilizza 1024px per la larghezza massima e il 17% per la larghezza minima. Il 19% delle pagine utilizza 1200px come `max-width` e il 42% come `min-width`.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1285928011&format=interactive",
    sheets_gid="1037504354",
    sql_file="media_query_values.sql"
  )
}}

Come negli ultimi due anni, i breakpoint più comuni sono cambiati poco. Il grafico mantiene la stessa forma e il breakpoint più comune è una `max-width` di 767px e una `min-width` di 768px. Come notato nel 2021, ciò corrisponde a un iPad in modalità verticale.

Ancora una volta, i breakpoint sono in gran parte impostati in pixel, non abbiamo convertito altri valori in pixel per il grafico. Il primo valore di `em` è anche quest'anno `48em`, e si trova alla posizione 78.

## Proprietà modificate nelle query

Abbiamo esaminato le proprietà che compaiono all'interno dei blocchi delle media query per vedere quali proprietà le persone stavano modificando in base ai breakpoint.

{{ figure_markup(
    image="media-query-props.png",
    caption="Proprietà più popolari trovate nei blocchi delle media query.",
    description="Grafico a barre che mostra le proprietà trovate nei blocchi delle media query utilizzate nella maggior parte delle pagine. Le proprietà `display` e `width` si trovano nelle media query nell'83% delle pagine, seguite da `height` e `padding` nel 78%, `margin-left` nel 77%, `font-size` nel 76%, `margin` e `position` nel 75%, `margin-right`, `left`, `top`, `margin-top` e `max-width` nel 74%, `right` e `margin-bottom` nel 73%, `padding-left` nel 72%, `text-align` nel 71%, `padding-right` nel 70%, `background` nel 69% e `float` nel 67%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1670810448&format=interactive",
    height="714",
    sheets_gid="2050421561",
    sql_file="media_query_properties.sql"
  )
}}

La proprietà `display` è ancora in cima alla classifica per le proprietà modificate all'interno delle media query, tuttavia ci sono stati alcuni rimescolamenti in classifica. Non così drammatici come potrebbero sembrare però. La proprietà `color` è scomparsa dal grafico, anche se questo rappresenta solo un cambiamento dal 74% al 67%. Ad esso si aggiunge comunque anche una riduzione dell'uso della proprietà `background-color` dal 65% al 63%, il che ci fa chiedere se qualche framework, o forse WordPress, abbiano smesso di usarla in un foglio di stile.

Un altro punto interessante da notare è che nel 2020 `font-size` compariva nel 73% dei blocchi di media query ed era il quinto nell'elenco. Nel 2021 è comparso nel 60% dei blocchi, al 12° posto. Quest'anno ha guadagnato terreno, tornando al 76% e al sesto posto.

## Feature queries

Le _features queries_, utilizzate per testare il supporto di una funzionalità CSS, sono presenti nel 40% delle pagine mobili e nel 38% delle pagine desktop. Cifra scesa dal 48% nel 2021. Ciò potrebbe indicare che il supporto per le funzionalità comuni testate è diventato abbastanza diffuso da consentire alle persone di non preoccuparsi di testare le funzionalità prima dell'uso.

Il numero di blocchi di feature query per pagina è 4 al 75° percentile e al 90° percentile 7 per desktop e 8 per dispositivi mobili. Tuttavia, abbiamo trovato un sito con 1.722 blocchi di feature query.

{{ figure_markup(
    image="supports-features.png",
    caption="Funzionalità più popolari testate tramite feature query",
    description="Grafico a barre che mostra le funzionalità testate con il maggior numero di feature query (`@supports`). La funzione `sticky` rappresenta il 36% dell'utilizzo, seguita da `mask-image` al 20%, `touch-callout` all'11%, `ime-align` al 5%, `grid` al 5%, `overflow-scrolling` al 5%, `appearance` al 3%, le _custom property_ al 2%, `object-fit` all'1% e la funzione `max` all'1%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=316208344&format=interactive",
    sheets_gid="542186816",
    sql_file="supports_criteria.sql"
  )
}}

Come l'anno scorso, la funzionalità più popolare testata nelle feature query è stata `position: sticky`, anche se è scesa dal 53% al 36% delle occorrenze, forse a causa del miglioramento del supporto del browser per questa funzionalità.

In questi test risaltano molto le funzionalità non standard come `touch-callout` (`-webkit-touch-callout`) e `ime-align` (`-ms-ime-align`). La prima è cresciuta nell'utilizzo dal 5% all'11%, mentre `ime-align` è scesa dal 7% al 5%.

{{ figure_markup(
    image="supports-props.png",
    caption="Proprietà utilizzate all'interno dei blocchi di feature query per percentuale di pagine.",
    description="Grafico a barre che mostra le proprietà utilizzate all'interno dei blocchi di feature query che si trovano nella maggior parte delle pagine. La proprietà `object-fit` si trova in un blocco di feature query nel 27% delle pagine, seguita da `content` nel 26%, `background-attachment` nel 25%, `border-radius`, `mask-size`, `mask-image`, `mask-repeat`, `mask-position`, `mask-mode` e `-webkit-mask-image` nel 24%, `-webkit-mask-size`, `-webkit-mask-repeat`, `-webkit-mask-position` e `-o-object-fit` nel 23%, `display` nel 17%, `width` nel 15%, `height` nel 13%, `flex` nel 11%, `justify-content` e `align-items` nel 10%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1247122547&format=interactive",
    height="783",
    sheets_gid="1467181186",
    sql_file="supports_properties.sql"
  )
}}

Dopo aver verificato il supporto, quali proprietà vengono poi utilizzate all'interno di questi blocchi di feature query? La proprietà `object-fit` risulta in testa, le proprietà `mask-*` sono in buona posizione, assieme alle loro controparti `-webkit-mask-*`. Ciò è probabilmente dovuto alla mancanza di interoperabilità anche recente delle funzioni di mascheramento, con le proprietà che richiedono ancora un prefisso `-webkit` per Chrome.

Sebbene la proprietà `display` sia tra le prime 20, occorre scendere molto in basso nell'elenco per trovare le proprietà legate alle griglie. La proprietà `grid-template-columns` è presente nel 2% dei blocchi di feature query.

## Internazionalizzazione

L'inglese è descritto come una lingua orizzontale dall'alto verso il basso, perché le frasi sono scritte orizzontalmente, a partire dalla parte superiore della pagina. La direzione di scrittura va da sinistra a destra, <i lang="en">left-to-right</i> (LTR). Anche l'arabo, l'ebraico e l'urdu sono lingue orizzontali dall'alto verso il basso, ma hanno una direzione della scrittura da destra a sinistra, <i lang="en">right-to-left</i> (RTL). Ci sono anche lingue scritte verticalmente, dall'alto verso il basso, come il cinese, il giapponese e il mongolo. I CSS si sono evoluti per far fronte meglio a queste diverse modalità di scrittura e direzioni dello script.

### Direzione

Il numero di pagine che utilizzano la proprietà CSS `direction` per impostare la direzione di scrittura sull'elemento `<body>` o su `<html>` è rimasto invariato dal 2021, con l'11% delle pagine che lo ha impostato su `<html>` e il 3% su `<body>`. <a hreflang="en" href="https://www.w3.org/International/questions/qa-html-dir"><i lang="en">It's recommended to use HTML</i> (Si consiglia di utilizzare HTML)</a>, anziché CSS per impostare la proprietà `direction`, quindi qui solo una minoranza attua la best practice.

## Proprietà logiche vs. fisiche

Le proprietà logiche (o relative al flusso) come `border-block-start` e i valori come `start` per `text-align` sono utili per l'internazionalizzazione poiché seguono il flusso del testo piuttosto che essere legati alle dimensioni fisiche dello schermo. Visto che il supporto dei browser per queste proprietà è ora eccellente, ci siamo chiesti se ne avremmo visto una maggiore adozione.

{{ figure_markup(
    image="logical-props.png",
    caption="La distribuzione delle proprietà logiche utilizzate.",
    description="Grafico a torta che mostra la distribuzione relativa dell'utilizzo delle proprietà logiche. La proprietà `margin` viene utilizzata il 70,0% delle volte, `text-aliugn` il 12,6%, `padding` l'11,2%, `border` il 4,5% e `inset` dl'1,7%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=597319721&format=interactive",
    sheets_gid="1478929671",
    sql_file="i18n_logical_properties.sql"
  )
}}

L'utilizzo delle proprietà logiche è leggermente aumentato dal 2021, passando dal 4% al 5%. Tuttavia, il grafico per il 2022 sembra molto diverso da quello per il 2021. Per grandissima parte le persone utilizzano le proprietà logiche per impostare le proprietà dei margini (`margin`), arrivando al 70% dal 26% dello scorso anno. Le proprietà `margin` più popolari sono `margin-inline-start` e `margin-inline-end`, che si trovano nel 9% delle pagine totali. Queste proprietà sono particolarmente utili per assicurarsi che la spaziatura tra un'etichetta e il campo successivo, ad esempio, funzioni allo stesso modo in uno script LTR e RTL.

### Ruby

Abbiamo nuovamente verificato l'utilizzo di [Ruby CSS](https://developer.mozilla.org/docs/Web/CSS/CSS_Ruby), un insieme di proprietà utilizzate per l'annotazione fra linee: brevi sequenze di testo presentate in corrispondenza del testo di base.

{{ figure_markup(
    content="0.2%",
    caption="Percentuale di pagine mobili che utilizzano Ruby CSS.",
    classes="big-number",
    sheets_gid="1827604622",
    sql_file="ruby_adoption.sql"
  )
}}

Il suo utilizzo è ancora minimo, ma è aumentato dal 2021. Solo 8.157 pagine desktop e 9.119 pagine mobili lo utilizzavano, meno dello 0,1% di tutte le pagine analizzate. Quest'anno, 16.698 pagine desktop e 21.266 mobili, ovvero lo 0,2% di tutte le pagine analizzate, lo utilizzavano.

## CSS in JS

{{ figure_markup(
    image="css-in-js.png",
    caption="Uso delle librerie CSS in JS.",
    description="Grafico a torta che mostra la distribuzione relativa per popolarità delle librerie CSS in JS. La libreria più popolare è Styled Components con il 49,4% di tutti i casi in cui sono adottati i CSS in JS, seguita da Emotion al 22,9%, Goober al 10,9%, Glamour al 7,7%, Aphrodite al 5,0% e Styled Jax al 2,4%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=140888375&format=interactive",
    sheets_gid="1374787728",
    sql_file="css_in_js.sql"
  )
}}

L'uso di CSS-in-JS non è aumentato rispetto allo scorso anno, rimanendo fermo al 3%. Questo utilizzo è quasi tutto da librerie, la più popolare delle quali è Styled Components. Questa libreria è scesa in quota dal 57% al 49%, con una nuova libreria che è entrata nel mix a quasi l'11%. <a hreflang="en" href="https://goober.js.org/">Goober</a> si descrive come "una soluzione css-in-js di che pesa meno di 1KB" e sta sicuramente facendo breccia tra persone a cui piace questo tipo di cose.

## Houdini

C'è ancora molto poco utilizzo di [Houdini](https://developer.mozilla.org/docs/Web/CSS/CSS_Houdini) nell'open web. Guardando i numeri, la quantità di pagine che utilizzano proprietà personalizzate animate mostra solo un piccolo aumento dal 2021. Abbiamo anche esaminato l'utilizzo dell'API Houdini Paint. Ne troviamo degli esempi in uso nel web. Analizzando i nomi dei worklet utilizzati, si nota che per la maggior parte è usato il worklet <a hreflang="en" href="https://css-houdini.rocks/smooth-corners/">smooth corners (angoli smussati)</a>, il che indica che le persone lo usano come un miglioramento progressivo, dato che questo può, nel caso non sia supportato, essere sostituito degnamente da un semplice `border-radius`.

## Sass

I preprocessori come Sass possono essere visti come buoni indicatori di ciò che gli sviluppatori desiderano poter fare con i CSS, ma non riescono fare. E, con la crescente potenza dei CSS, una domanda comune da parte degli sviluppatori è se abbiamo in fondo ancora bisogno di usare Sass. Lo capiamo dall'aumento dell'utilizzo delle proprietà personalizzate CSS (le _custom property_): uno degli usi più comuni del preprocessore (la possibilità di avere variabili o costanti) ha ora un equivalente CSS nativo.

{{ figure_markup(
    image="sass-function-calls.png",
    caption="Le chiamate di funzioni Sass più popolari per percentuale di chiamate.",
    description="Grafico a barre che mostra le chiamate di funzioni Sass utilizzate per la maggior parte delle volte. La funzione `if` costituisce il 19% delle chiamate di funzione Sass, seguita da altre funzioni al 17%, `darken` al 14%, `map-get` al 10%, `map-keys` al 9%, `percentage` al 6%, `nth` al 5%, `lighten` e `mix` al 4%, `type-of`, regolazione alfa, `unit` e `lenght` al 3%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1702171363&format=interactive",
    height="552",
    sheets_gid="1751596973",
    sql_file="sass_function_calls.sql"
  )
}}

Guardando alle chiamate di funzione si nota che le funzioni relative al colore sono ancora un uso molto popolare di Sass, qualcosa che potrebbe presto essere sostituito con <a href="https://www.w3.org/TR/css-color-5/" hreflang="en">nuove funzioni colore in CSS</a> come `color-mix()`. Ci sono alcuni cambiamenti rispetto allo scorso anno. La funzione `darken` è scesa di 2 punti percentuali al 14% e al terzo posto. La funzione `lighten` ha, in compenso, guadagnato punti.

{{ figure_markup(
    image="sass-control-flow-statements.png",
    caption="Distribuzione delle dichiarazioni di flusso di controllo in  SCSS.",
    description="Grafico a barre che mostra le dichiarazioni di flusso di controllo utilizzate nella maggior parte delle pagine in SCSS. `@if` viene utilizzato nel 65% delle pagine SCSS, seguito da `@for` nel 60%, `@each` nel 60% e `@while` nel 7%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=652567190&format=interactive",
    sheets_gid="2100910538",
    sql_file="sass_control_flow_statements.sql"
  )
}}

Osservando le dichiarazioni di flusso di controllo, vediamo un piccolo aumento di `@for` e `@each`, mentre `@while` è aumentato dal 2% al 7%.

{{ figure_markup(
    image="sass-nesting.png",
    caption="Uso dell'annidamento esplicito in SCSS per percentuale di pagine che utilizzano SCSS.",
    description="Grafico a barre che mostra i selettori di annidamento utilizzati nella maggior parte delle pagine con SCSS. L'88% delle pagine SCSS utilizza selettori di annidamento. Il selettore più popolare è `&:pseudo-class` nell'85% delle pagine SCSS, seguito da `&.class` nell'81%, `&::pseudo-element` nel 70%, `&` usato da solo nel 65%, `&[attr]` nel 59%, `& + (adjacent sibling)` nel 31% e `& descendent` nel 25%, `& > (child)` nel 24%, `& ~` e `&#id`nel 5%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1858217462&format=interactive",
    height="455",
    sheets_gid="1739922540",
    sql_file="sass_nesting.sql"
  )
}}

Anche l'annidamento (<i lang="en">nesting</i>) è interessante, dato che una specifica futura per CSS Nesting è attualmente in fase di sviluppo e discussione presso il CSS Working Group. L'annidamento nei fogli SCSS è molto comune e può essere identificato cercando il carattere `&`. Come l'anno scorso, pseudo-classi come `:hover` e classi come `.active` costituiscono la maggior parte dei casi di annidamento. Tutti gli utilizzi sono leggermente aumentati, tuttavia `& descendent` è aumentato di 7 punti percentuali dal 18% al 25%. L'annidamento implicito non viene misurato in questa analisi, poiché non utilizza caratteri speciali.

## CSS per la stampa

{{ figure_markup(
    content="5%",
    caption="La percentuale di pagine desktop con stili specifici per la stampa.",
    classes="big-number",
    sheets_gid="2112165521",
    sql_file="print_stylesheet_adoption.sql"
  )
}}

Ci siamo chiesti se gli sviluppatori stessero creando fogli di stile di stampa per fornire una migliore esperienza di pagine stampate e solo il 5% dei siti desktop e il 4% dei siti mobili lo facevano.

{{ figure_markup(
    image="print-props.png",
    caption="Le principali proprietà trovate negli stili di stampa sulle pagine che hanno un foglio di stile di stampa.",
    description="Grafico a barre che mostra le proprietà di stampa utilizzate sulla maggior parte delle pagine che hanno fogli di stile di stampa. La proprietà `display` viene utilizzata nel 55% delle pagine con fogli di stile di stampa, seguita da `margin` nel 48%, `color` nel 47%, `width` nel 43%, `background` nel 42%, `padding` e `text-decoration` nel 39%, `font-size` nel 37%, `text-align` nel 36% e `content` 34%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1905758001&format=interactive",
    height="455",
    sheets_gid="962139614",
    sql_file="print_all_properties.sql"
  )
}}

Delle pagine che utilizzano gli stili di stampa, più della metà modifica il valore di `display`, forse per semplificare una griglia o un layout flex per la stampa. Vediamo anche persone che cambiano i colori, modificano il margine e il padding e impostano la proprietà `font-size`. Al 34% è la proprietà `content`, utilizzata per inserire del contenuto generato.

La stampa è un mezzo frammentato; il contenuto è frammentato in pagine e abbiamo una serie di proprietà di frammentazione che mirano a fornire un certo controllo su come si verificano queste interruzioni. Ad esempio, gli sviluppatori di solito vogliono evitare che un'intestazione sia l'ultima cosa su una pagina o che una didascalia venga disconnessa dalla figura a cui si riferisce.

{{ figure_markup(
    image="print-fragmentation-props.png",
    caption="Proprietà di frammentazione utilizzate nei fogli di stile di stampa.",
    description="Grafico a barre che mostra l'utilizzo delle proprietà di frammentazione nelle pagine con fogli di stile di stampa. La proprietà `page-break-inside` viene utilizzata nel 32% delle pagine con fogli di stile di stampa, seguita da `page-break-after` nel 30%, `orphans` nel 22%, `page-break-before` nel 19% e `break-after` nel 2%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=141331795&format=interactive",
    height="455",
    sheets_gid="962139614",
    sql_file="print_all_properties.sql"
  )
}}

In questo grafico vediamo che molti sviluppatori stanno usando le vecchie proprietà di frammentazione di `page-break-inside`, `page-break-after` e `page-break-before`, piuttosto che le nuove proprietà come `break-before`, che ha invece un utilizzo molto basso.

La proprietà `orphans` appare nel 22% dei fogli di stile di stampa, nonostante manchi il supporto in Firefox. Questa proprietà definisce il numero di righe che devono essere lasciate in fondo a una pagina prima di un'interruzione di frammentazione. La proprietà `widows` (che imposta il numero di righe da sole dopo un'interruzione di frammentazione) compare con circa la stessa frequenza. È probabile che le persone stiano impostando lo stesso valore per entrambi.

### Media con pagine

C'è un'intera specifica per la gestione dei media con pagine (<i lang="en">Paged Media</i>) e CSS per la stampa. Anche se sono state implementate male nei browser. Per trovare una buona implementazione di queste funzionalità è necessario utilizzare uno user agent (browser) specifico per la stampa.

C'è un certo supporto dei browser per la regola [`@page`](https://developer.mozilla.org/docs/Web/CSS/@page) e per le sue pseudo-classi, e in realtà abbiamo riscontrato che degli sviluppatori le usano per impostare proprietà di pagina diverse per la prima pagina e le pagine sinistra e destra di uno _spread_ (doppia pagina).

<figure>
  <table>
    <thead>
      <tr>
        <th>Pseudo-classe</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>:first</code></td>
        <td class="numeric">5,950</td>
        <td class="numeric">7,352</td>
      </tr>
      <tr>
        <td><code>:right</code></td>
        <td class="numeric">1,548</td>
        <td class="numeric">2,115</td>
      </tr>
      <tr>
        <td><code>:left</code></td>
        <td class="numeric">1,554</td>
        <td class="numeric">2,101</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(
    caption="Numero di pagine trovate che usano le pseudo-classi di doppia pagina con `@page`.",
    sheets_gid="590030258",
    sql_file="print_page_pseudo_classes.sql"
  ) }}</figcaption>
</figure>

Per le persone che hanno usato queste pseudo-classi, l'uso era principalmente quello di impostare i margini della pagina e anche la dimensione della pagina.

## Meta

Questa sezione raccoglie alcune informazioni generali sull'utilizzo dei CSS, ad esempio la frequenza con cui le dichiarazioni vengono ripetute e gli errori comuni nei CSS.

### Ripetizione dichiarazioni

Nel 2020 e nel 2021 era stata effettuata un'analisi per determinare la quantità di "ripetizioni delle dichiarazioni". Questo era teso ad identificare l'efficienza di un foglio di stile valutando il numero di dichiarazioni che utilizzano la stessa proprietà e valore.

{{ figure_markup(
    image="repetition.png",
    caption="Distribuzione delle ripetizioni.",
    description="Grafico a barre che mostra i percentili 10°, 25°, 50°, 75° e 90° della percentuale di dichiarazioni univoche per pagina. I valori nell'ordine sono 32%, 38%, 45%, 53% e 61% delle dichiarazioni per pagina che sono univoche.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1151123515&format=interactive",
    sheets_gid="477246191",
    sql_file="repetition.sql"
  )
}}

Nel 2021 si era visto un leggero calo delle ripetizioni, quest'anno c'è un leggero aumento. Questa metrica sembra quindi abbastanza stabile anno su anno.

### Abbreviazioni e proprietà singole

In CSS, una proprietà abbreviata (<i lang="en">shorthand</i>) è quella che può impostare un numero di proprietà singole (<i lang="en">longhand</i>) in un'unica dichiarazione. Ad esempio, la proprietà abbreviata `background` può essere utilizzata per impostare tutte le seguenti proprietà singole:

- `background-attachment`
- `background-clip`
- `background-color`
- `background-image`
- `background-origin`
- `background-position`
- `background-repeat`
- `background-size`

Quando gli sviluppatori mescolano proprietà abbreviate come `background` e proprietà singole come `background-size` in un foglio di stile, è sempre meglio avere la sintassi estesa dopo l'abbreviazione. Abbiamo esaminato i casi di questo utilizzo per vedere quali proprietà singole fossero più comuni.

{{ figure_markup(
    image="shorthand-first-props.png",
    caption="Le proprietà singole più diffuse che vengono dopo le abbreviazioni.",
    description="Grafico a barre che mostra la popolarità relativa delle proprietà singole che seguono le proprietà con sintassi abbreviata a loro associate. La proprietà `background-size` costituisce il 15% di questo schema, seguita da `background-image` al 6%, `font-size`, `margin-bottom`, `margin-top` e `border-bottom-color` al 5%, `line-height`, `border-top-color` e `margin-left` al 4% e `padding-left` al 3%.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=1722219756&format=interactive",
    height="445",
    sheets_gid="293529425",
    sql_file="meta_shorthand_first_properties.sql"
  )
}}

Come nel 2020 e nel 2021, `background-size` è risultata in cima alla classifica e con poca differenza rispetto al 2021.

### Errori di sintassi irrecuperabili

Come negli anni precedenti, utilizziamo il motore <a hreflang="en" href="https://github.com/reworkcss/css">Rework</a> per il parsing CSS. Un errore irrecuperabile è quello in cui l'errore è così grave che l'intero foglio di stile non può essere analizzato da Rework. L'anno scorso, lo 0,94% delle pagine desktop e lo 0,55% delle pagine mobili contenevano un errore irrecuperabile. Quest'anno, il 13% delle pagine desktop e il 12% delle pagine mobili hanno riscontrato un tale errore. Questo sembra essere un grosso salto, tuttavia a causa di alcuni cambiamenti nella metodologia (l'aggiunta di soglie di dimensione) è probabile che non tutte le istanze riscontrate siano errori irrecuperabili.

## Proprietà inesistenti

Come negli anni precedenti, abbiamo ricercato la presenza di dichiarazioni con sintassi valida, ma riferite a proprietà che in realtà non esistono. Ciò comprende errori di ortografia, prefissi vendor non corretti e cose che gli sviluppatori si sono semplicemente inventati.

{{ figure_markup(
    image="unknown-props.png",
    caption="Le proprietà sconosciute più frequentemente riscontrate.",
    description="Grafico a barre che mostra le proprietà non valide presenti nella maggior parte delle pagine. La più popolare è `-archetype` nell'11% delle pagine, seguita da `font-smoothing` e `behavior` nel 10%, `tap-highlight-color` nel 6%, `moz-transition` nel 5%, `margin-center` nel 4%, `box-flex` nel 3%, `webkit-transition` nel 3% e le restanti si trovano tutte in meno dell'1% delle pagine: `url-encoded`, `border-collapse`, `webkit-border-radius`, `moz-border-radius` e `enable-background`.",
    chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSPMUe75uC8laUvzfECAPpT9fPoTdZA6FYDULorsUzKVmLmagphzh1UoXRcmyd6a3gxqr6dxIhmJyv5/pubchart?oid=932637515&format=interactive",
    height="514",
    sheets_gid="127761236",
    sql_file="meta_unknown_properties.sql"
  )
}}

La proprietà più misteriosa è `-archetype`, che ora appare nell'11% dei casi di fogli di stile con proprietà inesistenti. Questa proprietà è passata dal 4% dell'anno scorso all'11% raggiungendo il primo posto. La seconda proprietà è `font-smoothing` con un calo del 4% rispetto allo scorso anno. Questa sembrerebbe essere una versione senza prefisso di `-webkit-font-smoothing`, ma in realtà non esiste. L'uso della forma errata `webkit-transition` (che dovrebbe invece essere `-webkit-transition`) è scesa dal 14% al 3%. Questo ci fa pensare che forse rientrava in un gran numero di fogli di stile tramite un framework o altro [third party](./third-parties) poi aggiornato per risolvere il problema.

## Conclusioni

I CSS continuano ad evolversi ad un ritmo sostenuto, tuttavia possiamo vedere dai dati che le nuove funzionalità vengono adottate abbastanza lentamente, anche quando sono supportate da tutti i principali motori da diversi anni. Ci sono alcune funzionalità molto richieste, come le _container query_, che saranno disponibili nei browser proprio al momento della stesura di questo articolo. Sarà interessante vedere se l'adozione di queste funzionalità corrisponderà all'ampia domanda che le ha caratterizzate.

Una cosa che è risultata evidente da questi dati è quanto le piattaforme più popolari, in particolare WordPress, possano influire sulle statistiche di utilizzo. Nei dati è facile individuare i nomi delle classi e delle proprietà personalizzate di WordPress, ma ciò che è più difficile da riconoscere sono le proprietà e i valori assegnati alle classi che si trovano nella maggior parte dei siti WordPress. Se WordPress adotta una nuova funzionalità, come parte di una di queste classi standard, dovremmo aspettarci un improvviso aumento dell'utilizzo.

Come già notato nelle conclusioni dello scorso anno, i dati ci raccontano una storia di adozione graduale e costante di nuove funzionalità (come il _grid layout_) o di buone pratiche (come l'utilizzo di proprietà logiche anziché fisiche). Non vediamo l'ora di vedere come questi cambiamenti si svilupperanno negli anni a venire.
