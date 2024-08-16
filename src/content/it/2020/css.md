---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: Capitolo CSS del Web Almanac 2020 che copre colore, unità, selettori, layout, animazione, media queries e utilizzo di Sass.
authors: [LeaVerou, svgeesus, rachelandrew]
reviewers: [estelle, fantasai, j9t, mirisuzanne, catalinred, hankchizljaw]
analysts: [rviscomi, LeaVerou, dooman87]
editors: [tunetheweb]
translators: [chefleo]
LeaVerou_bio: Lea <a hreflang="en" href="https://designftw.mit.edu">insegna HCI e programmazione web</a> e <a hreflang="en" href="https://mavo.io">ricerca come rendere più facile la programmazione web</a> al <a hreflang="en" href="https://mit.edu">MIT</a>. È un <a hreflang="en" href="https://www.amazon.com/CSS-Secrets-Lea-Verou/dp/1449372635?tag=leaverou-20">autore</a> tecnico di bestseller ed è una ottima <a hreflang="en" href="https://lea.verou.me/speaking">speaker</a>. È appassionata di standard web aperti ed è membro di lunga data del <a hreflang="en" href="https://www.w3.org/Style/CSS/members.en.php3">CSS Working Group</a>. Lea ha avviato <a hreflang="en" href="https://github.com/leaverou">diversi popolari progetti open source e applicazioni web</a>, come <a hreflang="en" href="https://prismjs.com">Prism</a> e <a hreflang="en" href="https://github.com/leaverou/awesomplete">Awesomplete</a>. Lei twitta <a href="https://twitter.com/leaverou">@leaverou</a> e fa blog su <a hreflang="en" href="https://lea.verou.me">lea.verou.me</a>.
svgeesus_bio: Chris Lilley è un direttore tecnico presso il World Wide Web Consortium (W3C). Considerato "il padre di SVG", è stato anche coautore di PNG, è stato co-editore di CSS2, ha presieduto il gruppo che ha sviluppato <code>@font-face</code> e ha co-sviluppato WOFF. Ex Gruppo di Architettura Tecnica. Chris sta ancora cercando di ottenere la gestione del colore sul web, sigh. Attualmente sta lavorando ai livelli CSS 3/4/5, Web Audio e WOFF2.
rachelandrew_bio: Sono uno sviluppatore web, scrittore, oratore pubblico. Co-fondatore di <a hreflang="en" href="https://grabaperch.com">Perch CMS</a> e <a hreflang="en" href="https://noti.st">Notist</a>. Membro del <a hreflang="en" href="https://www.w3.org/wiki/CSSWG">CSS Working Group</a>. Editor in Chief di <a hreflang="en" href="https://www.smashingmagazine.com/">Smashing Magazine</a>.
discuss: 2037
results: https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/
featured_quote: Il web non è più un adolescente, ora ha 30 anni e si comporta così. Tende a dare la priorità alla stabilità e alla leggibilità rispetto alla complessità, a parte i piaceri occasionali.
featured_stat_1: 72.58%
featured_stat_label_1: Percentuale di valori `<length>` che utilizzano l'unità `px`
featured_stat_2: 91.05%
featured_stat_label_2: Percentuale di pagine per dispositivi mobile che utilizzano una funzione con prefisso del fornitore
featured_stat_3: `darken()`
featured_stat_label_3: La funzione SCSS più popolare
---

## Introduzione

Cascading Stylesheets (CSS) è un linguaggio utilizzato per disporre, formattare e disegnare pagine web e altri media. È uno dei tre linguaggi principali per la creazione di siti Web, gli altri due sono HTML, utilizzato per la struttura, e JavaScript, utilizzato per specificare il comportamento.

In [Web Almanac inaugurale dello scorso anno](../2019/), abbiamo esaminato [una varietà di metriche CSS](../2019/css) misurate tramite 41 query SQL sul corpus dell'archivio HTTP, per valutare lo stato della tecnologia nel 2019. Quest'anno siamo andati molto più in profondità, per misurare non solo quante pagine usano una determinata funzione CSS, ma anche *come* la usano.

Nel complesso, ciò che abbiamo osservato è stato un Web in due diversi ingranaggi quando si tratta di adozione di CSS. Nei nostri post sul blog e su Twitter, tendiamo a discutere principalmente del nuovo e splendente, tuttavia, ci sono ancora milioni di siti che utilizzano codice vecchio di dieci anni. Cose come [prefissi del fornitore di un'epoca passata](#prefissi-del-fornitore), [filtri IE proprietari](#filtri) e [i float per i layout](#layout), in tutta la loro gloria di [clearfix](#nomi-delle-classi). Ma abbiamo anche osservato un'impressionante adozione di molte nuove funzionalità, anche quelle che hanno ricevuto supporto su tutta la linea solo quest'anno, come [`min()` e `max()`](#le-funzionalità-delle-query). Tuttavia, esiste generalmente una correlazione inversa tra quanto è percepito un elemento popolare e quanto viene effettivamente utilizzato; per esempio, le funzionalità all'avanguardia di [Houdini](#houdini) erano praticamente inesistenti.

Allo stesso modo, nelle nostre conferenze, spesso tendiamo a concentrarci su casi d'uso complicati ed elaborati che sono fuori di testa e i feed di Twitter si riempiono di "CSS può fare *quello*?!". Tuttavia, risulta che la maggior parte dell'utilizzo del classico CSS è abbastanza semplice. [Le variabili CSS sono usate principalmente come costanti](#complessità) e raramente si riferiscono ad altre variabili, `calc()` è [usato principalmente con due termini](#calcoli), gradienti [principalmente hanno due sfumature](#gradienti) e cosi via.

Il web non è più un adolescente, ora ha 30 anni e si comporta così. Tende a dare la priorità alla stabilità e alla leggibilità rispetto alla complessità, a parte i piaceri occasionali.

## Metodologia

L'<a hreflang="en" href="https://httparchive.org/">HTTP Archive</a> esegue la scansione di <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#numUrls">milioni di pagine</a> ogni mese e le esegue tramite un istanza di <a hreflang="en" href="https://webpagetest.org/">WebPageTest</a> per memorizzare le informazioni chiave di ogni pagina. (Puoi saperne di più vedi [metodologia](./methodology)).

Per quest'anno abbiamo deciso di coinvolgere la community su quali metriche studiare. Abbiamo iniziato con un <a hreflang="en" href="https://projects.verou.me/mavoice/?repo=leaverou/css-almanac&labels=proposed%20stat">app per proporre metriche e votarle</a>. Alla fine, c'erano così tante metriche interessanti che abbiamo finito per includerle quasi tutte! Abbiamo escluso solo le metriche dei caratteri, poiché esiste un [capitolo sui caratteri](./fonts) completamente separato e c'era una significativa sovrapposizione.

La produzione dei dati in questo capitolo ha richiesto 121 query SQL, per un totale di oltre 10.000 righe di SQL incluse 3.000 righe di funzioni JavaScript all'interno dell'SQL. Questo lo rende il più grande capitolo nella storia del Web Almanac.

È stato fatto molto lavoro di ingegneria per rendere fattibile questa scala di analisi. Come l'anno scorso, abbiamo inserito tutto il codice CSS attraverso un <a hreflang="en" href="https://github.com/reworkcss/css">CSS parser</a> e memorizzato gli [Abstract Syntax Trees](https://en.wikipedia.org/wiki/Abstract_syntax_tree) (AST) per tutti i fogli di stile nel corpo, risultando in un enorme 10 TB di dati. Quest'anno, abbiamo anche sviluppato una <a hreflang="en" href="https://github.com/leaverou/rework-utils">libreria di helper</a> che opera su questo AST e un <a hreflang="en" href="https://projects.verou.me/parsel">selector parser</a>, entrambi sono stati rilasciati anche come progetti open source separati. La maggior parte delle metriche coinvolgeva <a hreflang="en" href="https://github.com/LeaVerou/css-almanac/tree/master/js">JavaScript</a> per raccogliere dati da un singolo AST e <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/sql/2020/css">SQL</a> per aggregare questi dati sull'intero corpo. Sei curioso di sapere come si comporta il tuo CSS rispetto alle nostre metriche? Abbiamo creato un <a hreflang="en" href="https://projects.verou.me/css-almanac/playground">playground online</a> in cui puoi provarli sui tuoi siti.

Per alcune metriche, guardare al CSS AST non era sufficiente. Volevamo esaminare <a hreflang="en" href="https://sass-lang.com/">SCSS</a> ovunque fosse fornito tramite le mappe dei sorgenti poiché ci mostra ciò di cui gli sviluppatori hanno bisogno dai CSS che non è ancora possibile, mentre lo studio dei CSS ci mostra ciò che gli sviluppatori usano attualmente. Per questo, abbiamo dovuto utilizzare una *custom metric* — codice JavaScript che viene eseguito nel crawler quando visita una determinata pagina. Non è stato possibile utilizzare un parser SCSS appropriato in quanto potrebbe rallentare troppo la scansione, quindi abbiamo dovuto ricorrere a <a hreflang="en" href="https://github.com/LeaVerou/css-almanac/blob/master/runtime/sass.js">espressioni regolari</a>. Nonostante l'approccio rozzo, abbiamo ottenuto [una sovrabbondanza di intuizioni](#sass)!

Le metriche personalizzate (custom metrics) sono state utilizzate anche per parte dell'[analisi delle proprietà personalizzate](#proprietà-personalizzate). Sebbene possiamo ottenere molte informazioni sull'utilizzo delle proprietà personalizzate solo dai fogli di stile, non possiamo costruire un grafico delle dipendenze senza essere in grado di guardare l'albero DOM per il contesto, poiché le proprietà personalizzate vengono ereditate. Guardando lo stile di calcolo dei nodi DOM ci dà anche informazioni come a quali tipi di elementi è applicata ciascuna proprietà e quali di essi sono [registrati](https://developer.mozilla.org/docs/Web/API/CSS/RegisterProperty) - informazioni che non possiamo ottenere dai fogli di stile.

<p class="note">Eseguiamo la scansione delle nostre pagine sia in modalità desktop che mobile ma per molti dati danno risultati simili quindi, se non diversamente specificato, le statistiche presentate in questo capitolo si riferiscono al set di pagine mobile.</p>

## Utilizzo

Mentre JavaScript supera di gran lunga CSS nella sua quota di peso della pagina, CSS è certamente cresciuto di dimensioni nel corso degli anni, con la pagina desktop mediana che carica 62 KB di codice CSS e una pagina su dieci carica più di 240 KB di codice CSS. Le pagine per dispositivi mobile utilizzano un codice CSS leggermente inferiore in tutti i percentili, ma solo da 4 a 7 KB. Sebbene sia decisamente maggiore rispetto agli anni precedenti, non si avvicina a [l'enorme mediana di JavaScript di 444 KB e il principale 10% di 1,2 MB](./javascript#how-much-javascript-do-we-use)

{{ figure_markup(
  image="stylesheet-size.png",
  caption="Distribuzione delle dimensioni di trasferimento del foglio di stile per pagina.",
  description="Grafico a barre che mostra la distribuzione delle dimensioni di trasferimento del foglio di stile per pagina, che include la compressione quando abilitata. Il desktop tende ad avere un po' più di byte del foglio di stile per pagina di circa 10 KB. I percentili 10, 25, 50, 75 e 90 per i dispositivi mobile sono: 5, 22, 56, 122 e 234 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=762340058&format=interactive",
  sheets_gid="314594173",
  sql_file="stylesheet_kbytes.sql"
) }}

Sarebbe ragionevole presumere che molto di questo CSS sia generato tramite preprocessori o altri strumenti di compilazione, tuttavia solo il 15% circa includeva mappe di origine. Non è chiaro se questo dica di più sull'adozione della mappa sorgente o sull'utilizzo degli strumenti di compilazione. Di questi, la stragrande maggioranza (45%) proveniva da altri file CSS, indicando l'utilizzo di processi di compilazione che operano su file CSS, come la minificazione, <a hreflang="en" href="https://autoprefixer.github.io/">autoprefixer</a> e/o <a hreflang="en" href="https://postcss.org/">PostCSS</a>. <a hreflang="en" href="https://sass-lang.com/">Sass</a> era più popolare di <a hreflang="en" href="https://lesscss.org/">Less</a> (34% dei fogli di stile con mappe sorgente vs 21%), con SCSS che è il dialetto più popolare (33% per .scss contro 1% per .sass).

Tutti questi kilobyte di codice sono tipicamente distribuiti su più file ed elementi `<style>`; solo il 7% circa delle pagine concentra tutto il proprio codice CSS in un foglio di stile remoto, come spesso ci viene insegnato a fare. In effetti, la pagina mediana contiene 3 elementi `<style>` e 6 fogli di stile remoti, di cui il 10% contiene oltre 14 elementi `<style>` e oltre 20 file CSS remoti! Sebbene non sia ottimale su desktop, uccide le [prestazioni](./performance) su dispositivi mobile, dove la latenza di andata e ritorno è più importante della velocità di download grezza.

{{ figure_markup(
  caption="Il maggior numero di fogli di stile caricati da una pagina.",
  content="1,379",
  classes="big-number",
  sheets_gid="1111507751",
  sql_file="stylesheet_count.sql"
)
}}

Incredibilmente, il numero massimo di fogli di stile per pagina è un incredibile 26.777 elementi `<style>` e 1.379 remoti! Vorrei sicuramente evitare di caricare quella pagina!

{{ figure_markup(
  image="stylesheet-count.png",
  caption="Distribuzione del numero di fogli di stile per pagina.",
  description="Grafico a barre che mostra la distribuzione dei fogli di stile per pagina. Desktop e mobile sono quasi uguali in tutta la distribuzione. I 10, 25, 50, 75 e 90° percentile per i dispositivi mobile sono: 1, 3, 6, 12 e 21 fogli di stile per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=163217622&format=interactive",
  sheets_gid="1111507751",
  sql_file="stylesheet_count.sql"
) }}

Un'altra metrica della dimensione è il numero di regole. La pagina mediana contiene un totale di 448 regole e 5.454 dichiarazioni. È interessante notare che il 10% delle pagine contiene una piccola quantità di CSS: meno di 13 regole! Nonostante il mobile abbia fogli di stile leggermente più piccoli, ha anche un po' più di regole, indicando regole più piccole in generale (come tende a verificarsi con le media query).

{{ figure_markup(
  image="rules.png",
  caption="Distribuzione del numero totale di regole di stile per pagina.",
  description="Grafico a barre che mostra la distribuzione delle regole di stile per pagina. Il cellulare tende ad avere un po' più di regole rispetto al desktop. I percentili 10, 25, 50, 75 e 90 per i dispositivi mobile sono: 13, 140, 479, 1.074 e 1.831 regole per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1918103300&format=interactive",
  sheets_gid="42376523",
  sql_file="selectors.sql"
) }}

## Selettori e cascade

I CSS offrono diversi modi per applicare gli stili alla pagina, dalle classi, agli ID e utilizzando l'importantissima cascade per evitare la duplicazione degli stili. In che modo gli sviluppatori applicano il loro stile alle loro pagine?

### Nomi delle classi

Per cosa usano gli sviluppatori i nomi delle classi in questi giorni? Per rispondere a questa domanda, abbiamo esaminato i nomi delle classi più popolari. L'elenco era dominato dalle classi <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>, con 192 su 198 `fa` o `fa-*`! L'unica cosa che l'esplorazione iniziale potrebbe dirci è che Font Awesome è estremamente popolare ed è utilizzato da quasi un terzo dei siti web!

Tuttavia, dopo aver compresso le classi `fa-*` e poi `wp-*` (che provengono da <a hreflang="en" href="https://wordpress.com/">WordPress</a>, un altro software estremamente popolare), abbiamo ottenuto risultati significativi. Omettendo queste, le classi relative allo stato sembrano essere le più popolari, con `.active` che compare in quasi la metà dei siti web, e `.selected` e `.disabled` subito dopo.

Solo alcune delle classi migliori erano relative alla presentazione, con la maggior parte di quelle relative all'allineamento (`pull-right` e `pull-left` dal vecchio <a hreflang="en" href="https://getbootstrap.com/">Bootstrap</a>, `alignright`, `alignleft` ecc.) o `clearfix` - che si verifica ancora nel 22% dei siti Web, nonostante i float siano stati sostituiti come metodo di layout dai più moderni moduli Grid e Flexbox.

{{ figure_markup(
  image="popular-class-names.png",
  caption="I nomi delle classi più popolari per percentuale di pagine.",
  description="Grafico a barre che mostra i primi 14 nomi di classi più popolari per le pagine desktop e mobile. La classe attiva si trova sul 40% delle pagine. Le altre classi si trovano nel 20-30% delle pagine e sono, in ordine decrescente: `fa`, `fa-*;`, `pull-right`, `pull-left`, `selected`, `disabled`, `clearfix`, `button`, `title`, `wp-*;`, `btn`, `container`, e `sr-only`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1187401149&format=interactive",
  sheets_gid="863628849",
  sql_file="top_selector_classes_wp_fa_prefixes.sql"
) }}

### Gli ID

Nonostante gli ID siano scoraggiati in questi giorni in alcuni circoli a causa della loro specificità molto più elevata, la maggior parte dei siti Web li utilizza ancora, anche se con parsimonia. Meno della metà delle pagine utilizzava più di un ID in uno qualsiasi dei loro selettori (aveva una specificità massima di (1,x,y) o inferiore) e quasi tutte avevano una specificità mediana che non includeva ID (0,x,y) . Vedere la <a hreflang="en" href="https://www.w3.org/TR/selectors/#specificity-rules">specifica dei selettori</a> per maggiori dettagli sul calcolo della specificità e di questa notazione (a,b,c).

Ma a cosa servono questi ID? Risulta che gli ID più popolari sono strutturali: `#content`, `#footer`, `#header`, `#main`, nonostante [gli elementi HTML corrispondenti](https://developer.mozilla.org/docs/Learn/HTML/Introduction_to_HTML/Document_and_website_structure#HTML_layout_elements_in_more_detail) esistenti che potrebbero essere utilizzati come selettori migliorando allo stesso tempo il markup semantico.

{{ figure_markup(
  image="popular-ids.png",
  caption="Gli ID più popolari per percentuale di pagine.",
  description="Grafico a barre che mostra i primi 10 ID più popolari per le pagine desktop e mobile. Il più popolare è ID `content` al 14% delle pagine. Gli ID `footer` e `header` hanno un'adozione leggermente inferiore. Gli ID `logo`, `main`, `respond`,`comments`, `fancybox-loading`, `wrapper` e `submit` hanno tra il 5 e il 10% di adozione sulle pagine. L'unica differenza notevole tra desktop e mobile è l'ID `comments` utilizzato su circa l'8% delle pagine mobile ma solo sul 5% delle pagine desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=141873739&format=interactive",
  sheets_gid="734822190",
  sql_file="top_selector_ids.sql"
) }}

Gli ID possono essere utilizzati anche per ridurre o aumentare intenzionalmente la specificità. <a hreflang="en" href="https://csswizardry.com/2014/07/hacks-for-dealing-with-specificity/">L'hack di specificità di scrivere un selettore di ID come selettore di attributi</a> (`[id ="foo"]` invece di `#foo` per ridurre la specificità) era sorprendentemente raro, con solo lo 0.3% delle pagine che lo utilizzava almeno una volta. Un altro trucco di specificità relativo all'ID, che utilizzava un selettore di negazione + discendente come `:not(#nonexistent) .foo` invece di `.foo` per aumentare la specificità, era molto raro, apparendo solo nello 0.1% delle pagine.

### `!important` {important}

Invece, il vecchio, crudo `!important` è ancora usato un bel po' nonostante i suoi <a hreflang="en" href="https://www.impressivewebs.com/everything-you-need-to-know-about-the-important-css-declaration/#post-475:~:text=Drawbacks,-to">noti inconvenienti</a>. La pagina mediana usa `!important` in quasi il 2% delle sue dichiarazioni, o 1 su 50.

{{ figure_markup(
  caption="Pagine mobile che utilizzano `!important` in ogni singola dichiarazione!",
  content="2,138",
  classes="big-number",
  sheets_gid="1743048352",
  sql_file="meta_important_adoption.sql"
)
}}

Alcuni sviluppatori letteralmente non ne hanno mai abbastanza: abbiamo trovato 2304 pagine desktop e 2138 pagine mobile che usano `!important` in ogni singola dichiarazione!

{{ figure_markup(
  image="important-properties.png",
  caption="Distribuzione della percentuale di proprietà `!important` per pagina.",
  description="Grafico a barre che mostra la distribuzione della percentuale di proprietà !important per pagina. Le pagine desktop tendono a utilizzare !important su un numero leggermente maggiore di proprietà rispetto ai dispositivi mobile. I percentili 10, 25, 50, 75 e 90 per i dispositivi mobile sono: 0, 1, 2, 4 e 7% delle proprietà con !important.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=768784205&format=interactive",
  sheets_gid="1743048352",
  sql_file="meta_important_adoption.sql"
) }}

Cos'è che gli sviluppatori sono così desiderosi di sovrascrivere? Abbiamo esaminato la suddivisione per proprietà e abbiamo scoperto che quasi l'80% delle pagine utilizza `!important` con la proprietà `display`. È una strategia comune applicare `display: none !important` per nascondere il contenuto nelle classi helper per sovrascrivere i CSS esistenti che usano `display` per definire una modalità di layout. Questo è un effetto collaterale di quello che, col senno di poi, era un difetto nei CSS. Ha combinato tre funzionalità ortogonali in una: la modalità di layout interno, il comportamento del flusso e lo stato di visibilità sono tutti controllati dalla proprietà `display`. Sono stati fatti sforzi per separare questi valori in singole parole chiave `display` in modo che possano essere regolate individualmente tramite proprietà personalizzate, ma per il momento <a hreflang="en" href="https://caniuse.com/mdn-css_properties_display_multi-keyword_values">il supporto del browser è praticamente inesistente.</a>

{{ figure_markup(
  image="important-top-properties.png",
  caption="Le prime proprietà `!important` in base alla percentuale di pagine.",
  description="Grafico a barre che mostra le principali 10 proprietà utilizzate con `!important`. Mobile e desktop hanno un utilizzo simile. La proprietà `display` viene utilizzata maggiormente con `!important`, dal 79% delle pagine mobile. In ordine decrescente, le proprietà successive sul 71-58% delle pagine mobile sono: `color`, `width`, `height`, `background`, `padding`, `margin`, `border`, `background-color` e `float`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=257343566&format=interactive",
  sheets_gid="1222608982",
  sql_file="meta_important_properties.sql"
) }}

### Specificità e classi

Oltre a mantenere gli `id` e le `!important` poche e distanti tra loro, c'è una tendenza ad aggirare del tutto la specificità stipando tutti i criteri di selezione di un selettore in un unico nome di classe, costringendo così tutte le regole ad avere la stessa specificità e trasformare la cascade in un sistema più semplice per chi vince. BEM è una metodologia popolare di quel tipo, anche se non l'unica. Sebbene sia difficile valutare quanti siti web utilizzano esclusivamente metodologie in stile BEM, poiché seguirle in ogni regola è raro (anche il <a hreflang="en" href="https://en.bem.info/">sito web BEM</a> utilizza più classi in molti selettori) , circa il 10% delle pagine presentava una specificità mediana di (0,1,0), che può indicare per lo più seguendo una metodologia in stile BEM. All'estremità opposta di BEM, spesso gli sviluppatori utilizzano <a hreflang="en" href="https://csswizardry.com/2014/07/hacks-for-dealing-with-specificity/#safely-increasing-specificity">classi duplicate</a> per aumentare la specificità e spingere un selettore davanti a un altro (es. `.foo.foo` invece di `.foo`). Questo tipo di hack di specificità è in realtà più popolare del BEM, essendo presente nel 14% dei siti Web mobile (9% dei desktop)! Ciò potrebbe indicare che la maggior parte degli sviluppatori non vuole effettivamente sbarazzarsi del tutto della cascade, ma ha solo bisogno di un maggiore controllo su di essa.

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
        <td>10</td>
        <td>0,1,0</td>
        <td>0,1,0</td>
      </tr>
      <tr>
        <td>25</td>
        <td>0,2,0</td>
        <td>0,1,2</td>
      </tr>
      <tr>
        <td>50</td>
        <td>0,2,0</td>
        <td>0,2,0</td>
      </tr>
      <tr>
        <td>75</td>
        <td>0,2,0</td>
        <td>0,2,0</td>
      </tr>
      <tr>
        <td>90</td>
        <td>0,3,0</td>
        <td>0,3,0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Distribuzione della specificità mediana per pagina.",
      sheets_gid="1213836297",
      sql_file="specificity.sql"
    ) }}
  </figcaption>
</figure>

### Selettori di attributi

Il selettore di attributi più popolare, di gran lunga, è sull'attributo `type`, utilizzato nel 45% delle pagine, probabilmente per definire input di tipi diversi, ad es. per modellare gli input testuali in modo diverso da radios, checkboxes, sliders, file upload, ecc.

{{ figure_markup(
  image="attribute-selectors.png",
  caption="I selettori di attributi più popolari per percentuale di pagine.",
  description="Grafico a barre che mostra i principali selettori di attributi in base alla percentuale di pagine. Mobile e desktop hanno un utilizzo simile. Il selettore di attributi più popolare in assoluto è `type`, utilizzato sul 46% delle pagine mobile. Successivamente, il selettore dell'attributo `class` viene utilizzato sul 30% delle pagine mobile. I seguenti selettori di attributi sono usati tra il 17 e il 3% in ordine decrescente: `disabled`, `dir`, `title`, `hidden`, `controls`, `data-type`, `data-align`, `href`, `poster`, `role`, `style`, `xmlns`, `aria-disabled`, `src`, `id`, `name`, `lang`, e `multiple`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=320159317&format=interactive",
  sheets_gid="1926527049",
  sql_file="top_selector_attributes.sql"
) }}

### pseudo-class e pseudo-elements

C'è sempre molta inerzia quando cambiamo qualcosa nella piattaforma web dopo che è stato stabilito da tempo. Ad esempio, il web non ha ancora in gran parte raggiunto pseudo-elements con sintassi separata rispetto alle pseudo-class, anche se si trattava di un cambiamento avvenuto oltre un decennio fa. Tutti gli pseudo-elements che sono disponibili anche nella sintassi della pseudo-class per motivi di legacy sono molto più prevalenti nella sintassi della pseudo-class (da 2,5 a 5 volte!).

{{ figure_markup(
  image="selector-pseudo-classes.png",
  caption="Uso della sintassi legacy `:pseudo-class` per `::pseudo-elements` come percentuale delle pagine mobile.",
  description="Grafico a barre che mostra la percentuale di pagine che utilizzano la sintassi della pseudo-class (preceduta da un due punti) rispetto alla sintassi degli pseudo-element (due punti) per gli pseudo-elements. Lo pseudo-element `before` viene utilizzato con la sintassi della pseudo-class sul 71% delle pagine mobile e la sintassi dello pseudo-element sul 33% delle pagine mobile. Lo pseudo-element `after` viene utilizzato con la sintassi di classe ed elemento sul 68% e 30% delle pagine mobile,`first-letter` sul 7% e 1% delle pagine mobile e `first-line` sull'1% e 0 % di pagine per dispositivi mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=227968207&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

Le pseudo-classi di gran lunga più popolari sono quelle di azione dell'utente, con `:hover`, `:focus`, e `:active` all'inizio dell'elenco, tutte utilizzate in oltre due terzi delle pagine, a indicare che agli sviluppatori piace la comodità di specificare le interazioni dichiarative dell'interfaccia utente.

`:root` sembra molto più popolare di quanto sia giustificato dalla sua funzione, usata in un terzo delle pagine. Nel contenuto HTML, seleziona semplicemente l'elemento `<html>`, quindi perché gli sviluppatori non hanno usato semplicemente `html`? Una possibile risposta potrebbe risiedere in una pratica comune relativa alla definizione di proprietà personalizzate, [che sono anche molto usate](#proprietà-personalizzate), sulla pseudo-class `:root`. Un'altra risposta potrebbe risiedere nella specificità: `:root`, essendo una pseudo-classe, ha una specificità maggiore di `html`: (0,1,0) vs (0,0,1). È un trucco comune aumentare la specificità di un selettore anteponendolo a `:root`, ad es. `:root .foo` ha una specificità di (0, 2, 0) rispetto a solo (0, 1, 0) per `.foo`. Questo è spesso tutto ciò che serve per spingere un selettore leggermente sopra un altro nella cascade race ed evitare la martellata che è `!important`. Per verificare questa ipotesi, abbiamo anche misurato esattamente questo: quante pagine usano `:root` all'inizio di un selettore discendente? I risultati hanno verificato la nostra ipotesi: un notevole 29% delle pagine usa `:root` in questo modo! Inoltre, il 14% delle pagine desktop e il 19% delle pagine mobile utilizzano `html` all'inizio di un selettore discendente, forse per dare al selettore un incremento di specificità ancora minore. La popolarità di questi hack di specificità indica fortemente che gli sviluppatori necessitano di un controllo granulare più fine per modificare la specificità rispetto a quello che viene loro offerto tramite `!important`. Per fortuna, arriverà presto con [`:where()`](https://developer.mozilla.org/docs/Web/CSS/:where), che è già <a hreflang="en" href="https://caniuse.com/mdn-css_selectors_where">implementato su tutta la linea</a> (anche se dietro una bandiera in Chrome per ora).

{{ figure_markup(
  image="popular-selector-pseudo-classes.png",
  caption="Le pseudo-class più popolari come percentuale di pagine.",
  description="Grafico a barre che mostra le pseudo-class più popolari come percentuale di pagine per desktop e dispositivi mobile. Desktop e dispositivi mobile sono per lo più simili, con i dispositivi mobile che tendono ad avere un'adozione leggermente maggiore. La pseudo-class più popolare è `hover`, utilizzata sull'84% delle pagine. Le seguenti pseudo-class diminuiscono di popolarità dal 71% al 12% in modo quasi lineare: `before`, `after`, `focus`, `active`, `first-child`, `last-child`, `visited`, `not`, `root`, `nth-child`, `link`, `disabled`, `empty`, `nth-of-type`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1363774711&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

Quando si tratta di pseudo-element, dopo i soliti sospetti `::before` e `::after`, quasi tutti gli pseudo-element popolari erano estensioni del browser per lo stile dei controlli dei form e altre UI incorporate, facendo fortemente eco alla necessità degli sviluppatori di un controllo più dettagliato sullo stile dell'interfaccia utente incorporata. Lo stile di focus rings, placeholders, search inputs, spinners, selection, scrollbars, media controls era particolarmente popolare.

{{ figure_markup(
  image="popular-selector-pseudo-elements.png",
  caption="Le pseudo-elements più popolari come percentuale di pagine.",
  description="Grafico a barre che mostra gli pseudo-element più popolari come percentuale delle pagine per desktop e dispositivi mobile. Desktop e dispositivi mobili sono per lo più simili, con i dispositivi mobili che tendono ad avere un'adozione leggermente maggiore. Lo pseudo-element più popolare è `before`, utilizzato sul 33% delle pagine per dispositivi mobile. Lo pseudo-element `after` viene utilizzato nel 30% delle pagine mobile. `-moz-focus-inner` viene utilizzato nel 24% delle pagine. La popolarità scende dopo quelli dal 17% al 4% in ordine decrescente: `-webkit-input-placeholder`, `-moz-placeholder`, `-webkit-search-decoration`, `-webkit-search-cancel-button`, `-webkit-inner-spin-button`, `-webkit-outer-spin-button`, `-webkit-scrollbar` (7%), `selection`, `-ms-clear`, `-moz-selection`, `-webkit-media-controls`, e `-webkit-scrollbar-thumb`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1417577353&format=interactive",
  sheets_gid="1972610663",
  sql_file="top_selector_pseudo_elements.sql",
  width=600,
  height=500
) }}

## Valori e unità

CSS fornisce una serie di modi per specificare valori e unità, sia in lunghezze prestabilite o calcoli o in base a parole chiave globali.

### Lunghezze

L'umile unità `px` ha ricevuto molta stampa negativa nel corso degli anni. All'inizio, perché non funzionava bene con la funzionalità di zoom del vecchio Internet Explorer e, più recentemente, perché ci sono unità migliori per la maggior parte delle attività che vengono ridimensionate in base a un altro fattore di progettazione, come la dimensione del viewport, la dimensione dell'elemento font o la dimensione di root, riducendo lo sforzo di manutenzione rendendo esplicite le relazioni di progettazione implicite. Anche il principale punto di forza di `px`, la sua corrispondenza con un pixel del dispositivo che offre ai progettisti il pieno controllo è scomparso, poiché un pixel non è più un pixel del dispositivo con i moderni schermi ad alta densità di pixel. Nonostante tutto ciò, i pixel CSS guidano ancora quasi ovunque i design del web.

{{ figure_markup(
  caption="Percentuale di valori `<length>` che utilizzano l'unità `px`.",
  content="72.58%",
  classes="big-number",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

L'unità `px` è l'unità di lunghezza complessiva più popolare, con il 72.58% di tutte le lunghezze del foglio di stile che utilizza `px`. Escludendo la percentuale (perché la percentuale non è realmente un'unità), la quota di `px` è aumentata ulteriormente all'84.14%.

{{ figure_markup(
  image="length-units.png",
  caption="Le unità `<length>` più popolari come percentuale di occorrenze.",
  description="Grafico a barre che mostra le unità di lunghezza più popolari come percentuale di occorrenze (la frequenza con cui le unità appaiono in tutti i fogli di stile). L'unità px è di gran lunga la più popolare, utilizzata il 73% delle volte nei fogli di stile per dispositivi mobile. La successiva unità più popolare è `%` (segno di percentuale), al 17%, seguita da `em` al 9% e `rem` all'1%. Le seguenti unità hanno tutte un utilizzo così basso che vengono arrotondate allo 0%: `pt`, `vw`, `vh`, `ch`, `ex`, `cm`, `mm`, `in`, `vmin`, `pc`, and `vmax`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2095127496&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

Come sono distribuiti questi `px` tra le proprietà? C'è qualche differenza a seconda della proprietà? Sicuramente. Ad esempio, come ci si potrebbe aspettare, `px` è molto più popolare nei bordi (80-90%) rispetto alle metriche relative ai font come `font-size`, `line-height` o `text-indent`. Tuttavia, anche per quelli, l'utilizzo di `px` supera di gran lunga qualsiasi altra unità. Infatti, le uniche proprietà per le quali un'altra unità (*qualsiasi* altra unità) è più usata di `px` sono `vertical-align` (55% `em`), `mask-position` (50% `em`), `padding-inline-start` (62% `em`), `margin-block-start` e `margin-block-end` (65% `em`), e il nuovissimo `gap` con il 62% `rem`.

Si potrebbe facilmente sostenere che molti di questi contenuti sono vecchi, scritti prima che gli autori fossero più illuminati sull'uso delle unità relative per rendere i loro progetti più adattabili e risparmiare tempo su tutta la linea. Tuttavia, questo può essere facilmente smascherato guardando proprietà più recenti come `grid-gap` (62% `px`).

<figure>
  <table>
    <thead>
      <tr>
        <th>Proprietà</th>
        <th><code>px</code></th>
        <th><code>&lt;number&gt;</code></th>
        <th><code>em</code></th>
        <th><code>%</code></th>
        <th><code>rem</code></th>
        <th><code>pt</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>font-size</code></td>
        <td class="numeric">70%</td>
        <td class="numeric">2%</td>
        <td class="numeric">17%</td>
        <td class="numeric">6%</td>
        <td class="numeric">4%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td><code>line-height</code></td>
        <td class="numeric">54%</td>
        <td class="numeric">31%</td>
        <td class="numeric">13%</td>
        <td class="numeric">3%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>border</code></td>
        <td class="numeric">71%</td>
        <td class="numeric">27%</td>
        <td class="numeric">2%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>border-radius</code></td>
        <td class="numeric">65%</td>
        <td class="numeric">21%</td>
        <td class="numeric">3%</td>
        <td class="numeric">10%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>text-indent</code></td>
        <td class="numeric">32%</td>
        <td class="numeric">51%</td>
        <td class="numeric">8%</td>
        <td class="numeric">9%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>vertical-align</code></td>
        <td class="numeric">29%</td>
        <td class="numeric">12%</td>
        <td class="numeric">55%</td>
        <td class="numeric">4%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>grid-gap</code></td>
        <td class="numeric">63%</td>
        <td class="numeric">11%</td>
        <td class="numeric">9%</td>
        <td class="numeric">1%</td>
        <td class="numeric">16%</td>
        <td></td>
      </tr>
      <tr>
        <td><code>mask-position</code></td>
        <td></td>
        <td></td>
        <td class="numeric">50%</td>
        <td class="numeric">50%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>padding-inline-start</code></td>
        <td class="numeric">33%</td>
        <td class="numeric">5%</td>
        <td class="numeric">62%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>gap</code></td>
        <td class="numeric">21%</td>
        <td class="numeric">16%</td>
        <td class="numeric">1%</td>
        <td></td>
        <td class="numeric">62%</td>
        <td></td>
      </tr>
      <tr>
        <td><code>margin-block-end</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">31%</td>
        <td class="numeric">65%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>margin-inline-start</code></td>
        <td class="numeric">38%</td>
        <td class="numeric">46%</td>
        <td class="numeric">14%</td>
        <td></td>
        <td class="numeric">1%</td>
        <td></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Utilizzo delle unità per proprietà.",
      sheets_gid="1200981062",
      sql_file="units_properties.sql"
    ) }}
  </figcaption>
</figure>

Allo stesso modo, nonostante i tanto pubblicizzati vantaggi di `rem` rispetto a `em` per molti casi d'uso, e il suo supporto browser universale <a hreflang="en" href="https://caniuse.com/rem">per anni</a>, il web non ha ancora in gran parte raggiunto: il fidato `em` rappresenta l'87% di tutte le unità relative ai font utilizzati e `rem` è molto indietro con il 12%. Abbiamo visto qualche naturale utilizzo di `ch` (larghezza del glifo '0') e `ex` (altezza x del carattere in uso), ma molto piccolo (solo lo 0.37% e lo 0.19% di tutti i caratteri unità relative).

{{ figure_markup(
  image="font-units.png",
  caption="Quota relativa di unità relative ai caratteri",
  description="Grafico a barre che mostra la popolarità relativa di diverse unità basate sui caratteri. `em` viene utilizzato prevalentemente nell'87.3% delle istanze, seguito da `rem` al 12.2, `ch` allo 0.4% e `ex` allo 0.2% delle istanze su pagine mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=166603845&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

Le lunghezze sono gli unici tipi di valori CSS per i quali possiamo omettere l'unità quando il valore è zero, cioè possiamo scrivere `0` invece di `0px` o `0em` ecc. Gli sviluppatori (o CSS minificatori?) ne fanno un ampio uso: di tutti i valori `0`, l'89% era senza unità.

{{ figure_markup(
  image="zero-lengths.png",
  caption="Popolarità relativa di 0 lunghezze per unità come percentuale di occorrenze sulle pagine per dispositivi mobile.",
  description="Grafico a torta che mostra 0 lunghezze senza unità (AKA senza unità) utilizzato l'88.7% delle volte su pagine mobile, l'unità `px` al 10.7% e altre unità allo 0.5% delle istanze.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1935151776&format=interactive",
  sheets_gid="313150061",
  sql_file="units_zero.sql"
) }}

### Calcoli

Quando la funzione [`calc()`](https://developer.mozilla.org/docs/Web/CSS/calc()) è stata introdotta per eseguire calcoli tra diverse unità in CSS, è stata una rivoluzione. In precedenza, solo i preprocessori erano in grado di accogliere tali calcoli, ma i risultati erano limitati a valori statici e inaffidabili, poiché mancava il contesto dinamico che è spesso necessario.

Oggi, `calc()` è <a hreflang="en" href="https://caniuse.com/calc">supportato da ogni browser</a> già da nove anni, quindi non sorprende che sia stato ampiamente adottato con il 60% delle pagine che lo utilizzano almeno una volta. Semmai, ci aspettavamo un'adozione ancora maggiore di questa.

`calc()` è usato principalmente per le lunghezze, con il 96% del suo utilizzo concentrato in proprietà che accettano valori `<length>`, e il 60% (58% dell'uso totale) sulla proprietà `width`!

{{ figure_markup(
  image="calc-properties.png",
  caption="Popolarità relativa delle proprietà che usano `calc()` come percentuale di occorrenze.",
  description="Grafico a barre che mostra la popolarità relativa delle proprietà che utilizzano la funzione calc come percentuale di occorrenze. Desktop e dispositivi mobili hanno risultati simili. La funzione calc viene utilizzata più spesso nella proprietà width, il 59% delle occorrenze calc sulle pagine mobile. viene utilizzato sulla proprietà left l'11% delle volte, top 5%, max-width 4%, height 4% e le restanti proprietà stanno diminuendo al 2% e all'1%: min-height, margin-left, flex-basis, margin-right, max-height (1%), right, padding-bottom, padding-left, font-size, e padding-right.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=722318406&format=interactive",
  sheets_gid="1661677319",
  sql_file="calc_properties.sql"
) }}

Sembra che la maggior parte di questo utilizzo sia quello di sottrarre pixel dalle percentuali, come evidenziato dal fatto che le unità più comuni in `calc()` sono `px` (51% dell'utilizzo di `calc()`) e `%` (Il 42% dell'utilizzo di `calc()`) e il 64% dell'utilizzo di `calc()` implica la sottrazione. È interessante notare che le unità di lunghezza più popolari con `calc()` sono diverse dalle unità di lunghezza popolari in generale (ad esempio `rem` è più popolare di `em`, seguito dalle unità di viewport), molto probabilmente a causa del fatto che il codice che utilizza `calc()` è più recente.

{{ figure_markup(
  image="calc-units.png",
  caption="Popolarità relativa delle unità che usano `calc()` come percentuale di occorrenze.",
  description="Grafico a barre che mostra la popolarità relativa delle proprietà che utilizzano la funzione calc come percentuale di occorrenze. Desktop e mobile hanno risultati simili. La funzione calc viene utilizzata spesso nella proprietà `width`, il 59% delle occorrenze di calc su pagine mobile. Viene usato sulla proprietà `left` l'11% delle volte, `top` 5%, `max-width` 4%, `height` 4% e le restanti proprietà stanno diminuendo al 2% e all'1%: `min-height`, `margin-left`, `flex-basis`, `margin-right`, `max-height` (1%), `right`, `padding-bottom`, `padding-left`, `font-size`, and `padding-right`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=477094785&format=interactive",
  sheets_gid="769910871",
  sql_file="calc_units.sql"
) }}

{{ figure_markup(
  image="calc-operators.png",
  caption="Popolarità relativa degli operatori che usano `calc()` come percentuale di occorrenze.",
  description="Grafico a barre che mostra la popolarità relativa degli operatori che utilizzano la funzione calc come percentuale di occorrenze. Desktop e mobile hanno risultati simili. La funzione calc viene utilizzata più spesso con l'operatore di sottrazione (segno meno), 64% delle istanze di calc su pagine mobili, seguito da divisione (barra in avanti) 20%, addizione (segno più) 11% e moltiplicazione (asterisco) 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1909242522&format=interactive",
  sheets_gid="2077258816",
  sql_file="calc_operators.sql"
) }}

La maggior parte dei calcoli è molto semplice, con il 99.5% dei calcoli che coinvolgono fino a 2 unità diverse, l'88.5% dei calcoli che coinvolgono fino a 2 operatori e il 99.4% dei calcoli che coinvolgono una serie di parentesi o meno (3 calcoli su 4 non includono affatto parentesi ).

{{ figure_markup(
  image="calc-complexity-units.png",
  caption="Distribuzione del numero di unità per occorrenza `calc()`.",
  description="Grafico a barre che mostra la distribuzione del numero di unità per occorrenza della funzione di calc. Desktop e mobile hanno risultati simili. Calc viene utilizzato con un'unità per l'11% delle volte sulle pagine mobile, due volte l'89% delle volte e 3 o più volte circa lo 0% delle volte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=695698141&format=interactive",
  sheets_gid="1493602565",
  sql_file="calc_complexity_units.sql"
)
}}

### Parole chiave globali e `all`

Per molto tempo, CSS ha supportato solo una parola chiave globale: [`inherit`](https://developer.mozilla.org/docs/Web/CSS/inherit), che consente il ripristino di una proprietà ereditabile per il suo valore ereditato o riutilizzando il valore del genitore per una data proprietà non ereditabile. Si scopre che il primo è molto più comune del secondo, con l'81.37% dell'utilizzo di `inherit` trovato su proprietà ereditabili. Il resto è principalmente ereditare sfondi, bordi o dimensioni. Quest'ultimo probabilmente indica problemi di layout, poiché con la giusta modalità di layout uno raramente ha bisogno di forzare `width` e `height` da ereditare.

La parola chiave `inherit` è particolarmente utile per reimpostare il colore del link predefinito con il colore del testo principale. Non sorprende quindi che `color` sia la proprietà più comune su cui viene usata `inherit`. Quasi un terzo di tutto l'utilizzo di `inherit` si trova nella proprietà `color`. Il 75% delle pagine usa `color: inherit` almeno una volta.

Sebbene il *valore iniziale* di una proprietà sia un concetto che <a hreflang="en" href="https://www.w3.org/TR/CSS1/#cascading-order">esiste dai CSS 1</a>, ha solo la sua parola chiave dedicata, `initial`, per fare riferimento esplicito ad esso <a hreflang="en" href="https://www.w3.org/TR/2013/WD-css3-cascade-20130103/#initial-keyword">17 anni dopo</a> e ci sono voluti altri due anni per quella parola chiave ottenere <a hreflang="en" href="https://caniuse.com/css-initial-value">supporto browser universale</a> nel 2015. Non sorprende quindi che sia usato molto meno di `inherit`. Mentre la vecchia inherit si trova nell'85% delle pagine, `initial` appare nel 51% di esse. Inoltre, c'è molta confusione su cosa fa effettivamente `initial`, dal momento che `display` è in cima alla lista delle proprietà più comunemente usate con `initial`, con `display: initial` che appare nel 10% delle pagine. Presumibilmente, gli sviluppatori hanno pensato che questo resetta `display` al suo valore dal valore [user agent stylesheet](https://developer.mozilla.org/docs/Web/CSS/Cascade#User-agent_stylesheets) e lo usavamo per attivare e disattivare `display: none`. Tuttavia, <a hreflang="en" href="https://drafts.csswg.org/css-display/#the-display-properties">il valore iniziale di `display` è `inline`</a>, quindi `display: initial` è solo un altro modo di scrivere `display: inline` e non ha proprietà magiche dipendenti dal contesto.

Invece, `display: revert` avrebbe effettivamente fatto quello che questi sviluppatori probabilmente si aspettavano e avrebbero resettato `display` al valore UA per l'elemento dato. Tuttavia, `revert` è molto più recente: è stato definito <a hreflang="en" href="https://www.w3.org/TR/2015/WD-css-cascade-4-20150908/#valdef-all-revert">nel 2015</a> e <a hreflang="en" href="https://caniuse.com/css-revert-value">ha ottenuto il supporto del browser universale solo quest'anno</a>, il che spiega il suo sottoutilizzo: appare solo nello 0.14% delle pagine e metà del suo utilizzo è `line-height: revert;`, che si trova in <a hreflang="en" href="https://github.com/WordPress/WordPress/commit/303180b392c530b8e2c8b3c27532d591b915caeb">versioni recenti del tema TwentyTwenty di WordPress</a>.

L'ultima parola chiave globale, `unset`, è essenzialmente un ibrido di `initial` e `inherit`. Sulle proprietà ereditate diventa `inherit` e sul resto diventa `initial`, essenzialmente ripristinando la proprietà su tutte le origini cascade. Allo stesso modo, a `initial`, è stato <a hreflang="en" href="https://www.w3.org/TR/2013/WD-css-cascade-3-20130730/#inherit-initial">definito nel 2013</a> e ha ottenuto <a hreflang="en" href="https://caniuse.com/css-unset-value">supporto browser completo nel 2015</a>. Nonostante la maggiore utilità di `unset`, viene utilizzato solo nel 43% delle pagine, mentre `initial` viene utilizzato nel 51% delle pagine. Inoltre, oltre a `max-width` e `min-width`, in ogni altra proprietà l'utilizzo di `initial` supera quello di `unset`.

{{ figure_markup(
  image="keyword-totals.png",
  caption="Adozione di parole chiave globali come percentuale delle pagine.",
  description="Grafico a barre che mostra l'adozione di parole chiave globali come percentuale delle pagine. Le pagine per dispositivi mobile tendono ad avere un tasso di adozione più elevato. La parola chiave `inherit` è usata sull'85% delle pagine mobile, `initial` sul 51%, `unset` sul 43% e `revert` su circa lo 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1246886332&format=interactive",
  sheets_gid="437371205",
  sql_file="keyword_totals.sql"
) }}

La proprietà `all` è stata <a hreflang="en" href="https://www.w3.org/TR/2013/WD-css3-cascade-20130103/#all-shorthand">introdotta nel 2013</a> e ha ottenuto <a hreflang="en" href="https://caniuse.com/css-all">supporto quasi universale nel 2016 (tranne Edge) e il supporto universale all'inizio di quest'anno</a>. È una shorthand di quasi tutte le proprietà in CSS (eccetto le proprietà personalizzate, `direction` e `unicode-bidi`), e accetta solo le <a hreflang="en" href="https://drafts.csswg.org/css-cascade-4/#defaulting-keywords">quattro parole chiave globali</a> (`initial`, `inherit`, `unset`, e `revert`) come valori. È stato concepito come un ripristino CSS di una riga, come `all: unset` o `all: revert`, a seconda del tipo di ripristino che volevamo. Tuttavia, l'adozione è ancora molto bassa: abbiamo trovato solo `all` su 477 pagine (0.01% di tutte le pagine) e utilizzato solo con la parola chiave `revert`.

## Colore

Dicono che le vecchie barzellette siano le migliori, e questo vale anche per i colori. La sintassi esadecimale originale, criptica, `#rrggbb` rimane il modo più popolare per specificare un colore in CSS nel 2020: la metà di tutti i colori è scritta in questo modo. Il prossimo formato più popolare è il formato esadecimale a tre cifre `#rgb` un po' più corto al 26%. Sebbene sia più corto, è anche in grado di esprimere *molti* meno colori; solo 4096, su 16,7 milioni di valori sRGB.

{{ figure_markup(
  image="popular-color-formats.png",
  caption="Popolarità relativa dei formati di colore come percentuale di occorrenze.",
  description="Grafico a barre che mostra la popolarità relativa dei formati di colore come percentuale di occorrenze. Il formato colore `#rrggbb` viene utilizzato nel 50% delle occorrenze sulle pagine mobile, con il desktop leggermente superiore al 52%. Il formato `#rgb` è usato nel 25% delle occorrenze, seguito da `rgba()` al 14%, `transparent` all'8%, un colore con nome (come `red`) all'1% e i restanti formati di colore hanno tutti circa lo 0% di popolarità relativa sulle pagine mobile: `#rrggbbaa`, `rbg()`, `hsla()`, `currentColor`, `#rgba`, un colore di sistema, `hsl()`, and `color()`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=65722098&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

Allo stesso modo, il 99.89% dei colori sRGB specificati in modo funzionale utilizza il formato legacy con virgole `rgb(127, 255, 84)` invece della nuova forma senza virgole `rgb(127 255 84)`. Perché, nonostante tutti i browser moderni accettino la nuova sintassi, il cambiamento non offre alcun vantaggio agli sviluppatori.

Allora perché le persone si allontanano da questi formati provati e veri? Per esprimere la trasparenza alfa. Questo è chiaro quando guardi `rgba()`, che è usato 40 volte di più di `rgb()` (13.82% vs 0.34% per tutti i colori) e `hsla()`, che è usato 30 volte di più di `hsl()`(0.25% vs 0.01% di tutti i colori).

HSL dovrebbe essere <a hreflang="en" href="https://drafts.csswg.org/css-color-4/#the-hsl-notation">facile da capire e facile da modificare</a>. Ma questi numeri mostrano che in pratica, HSL è usato nei fogli di stile molto meno di RGB, probabilmente perché questi vantaggi sono <a hreflang="en" href="https://drafts.csswg.org/css-color-4/#ex-hsl-sucks">notevolmente sopravvalutati</a>.

{{ figure_markup(
  image="color-formats-alpha.png",
  caption="Popolarità relativa dei formati di colore raggruppati in base al supporto alpha come percentuale di occorrenze sulle pagine per dispositivi mobile (esclusi `#rrggbb` e `#rgb`).",
  description="Grafico a barre che mostra la popolarità relativa dei formati di colore raggruppati in base al supporto alfa come percentuale di occorrenze sulle pagine mobile, esclusi `#rrggbb` e `#rgb`. I formati di colore che supportano l'alfa aggiungono fino a circa il 23% delle occorrenze, mentre i formati di colore che non supportano l'alfa aggiungono solo il 2% delle occorrenze sulle pagine per dispositivi mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1861989753&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

E i colori con nome? La parola chiave `transparent`, che è solo un altro modo per dire `rgb (0 0 0 / 0)`, è la più popolare, con l'8.25% di tutti i valori sRGB (66% di tutti i colori con nome); seguito da tutti i colori nominati (X11) - Sto parlando di te, `papayawhip` - all'1,48%. I più popolari di questi erano i nomi facilmente comprensibili come `white`, `black`, `red`, `gray`, `blue`. `whitesmoke` era il più comune dei nomi non ordinari (certo, possiamo visualizzare whitesmoke, giusto) mentre `gainsboro`, `lightCoral` e `burlywood` venivano usati molto meno. Possiamo capire perché: devi cercarli per vedere cosa significano effettivamente!

E se stai cercando nomi di colori fantasiosi, perché non definirne uno tuo con CSS [Custom properties](#proprietà-personalizzate)? `--intensePurple` e `--corporateBlue` significano qualunque cosa tu voglia che significhino. Questo probabilmente spiega perché [50% delle custom properties](#utilizzo-per-tipo) viene utilizzato per i colori.

{{ figure_markup(
  link="https://codepen.io/leaverou/pen/GRjjJwJ",
  image="color-keywords-app.png",
  caption='Esplora in modo interattivo i dati sull\`utilizzo delle parole chiave a colori con <a hreflang="en" href="https://codepen.io/leaverou/pen/GRjjJwJ">questa app interattiva</a>!',
  description="Screenshot di un'app interattiva che ti consente di selezionare i colori e vedere il loro utilizzo relativo in un grafico a torta. I dati per i colori sono mostrati nella tabella successiva.",
  width=600,
  height=1065
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Keyword</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>{{ swatch('transparent') }}</span></td>
        <td>transparent</td>
        <td class="numeric">84.04%</td>
        <td class="numeric">83.51%</td>
      </tr>
      <tr>
        <td>{{ swatch('white') }}</td>
        <td>white</td>
        <td class="numeric">6.82%</td>
        <td class="numeric">7.34%</td>
      </tr>
      <tr>
        <td>{{ swatch('black') }}</span></td>
        <td>black</td>
        <td class="numeric">2.32%</td>
        <td class="numeric">2.42%</td>
      </tr>
      <tr>
        <td>{{ swatch('red') }}</td>
        <td>red</td>
        <td class="numeric">2.03%</td>
        <td class="numeric">2.01%</td>
      </tr>
      <tr>
        <td>{{ swatch('currentColor') }}</span></td>
        <td>currentColor</td>
        <td class="numeric">1.43%</td>
        <td class="numeric">1.43%</td>
      </tr>
      <tr>
        <td>{{ swatch('gray') }}</span></td>
        <td>gray</td>
        <td class="numeric">0.75%</td>
        <td class="numeric">0.79%</td>
      </tr>
      <tr>
        <td>{{ swatch('silver') }}</span></td>
        <td>silver</td>
        <td class="numeric">0.66%</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>{{ swatch('grey') }}</span></td>
        <td>grey</td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td>{{ swatch('green') }}</span></td>
        <td>green</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td>{{ swatch('magenta') }}</span></td>
        <td>magenta</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('blue') }}</span></td>
        <td>blue</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('whitesmoke') }}</span></td>
        <td>whitesmoke</td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgray') }}</span></td>
        <td>lightgray</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td>{{ swatch('orange') }}</span></td>
        <td>orange</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgrey') }}</span></td>
        <td>lightgrey</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('yellow') }}</span></td>
        <td>yellow</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>{{ swatch('Highlight') }}</span></td>
        <td>Highlight</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('gold') }}</span></td>
        <td>gold</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('pink') }}</span></td>
        <td>pink</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>{{ swatch('teal') }}</span></td>
        <td>teal</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Popolarità relativa delle parole chiave relative ai colori come percentuale di occorrenze.",
      sheets_gid="1429541094",
      sql_file="color_keywords.sql"
    ) }}
  </figcaption>
</figure>

E infine, i colori di sistema che una volta erano deprecati, ma ora sono parzialmente deprecati, come `Canvas` e `ThreeDDarkShadow`: erano un'idea terribile, introdotti per emulare l'interfaccia utente come Java o Windows 95, e già incapaci per tenere il passo con Windows 98, sono presto caduti nel dimenticatoio. Alcuni siti utilizzano questi colori di sistema per provare a rilevare le impronte digitali, una scappatoia che <a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5710">stiamo cercando di chiudere mentre parliamo</a>. Ci sono pochi buoni motivi per usarli e la maggior parte dei siti web (99.99%) non lo fa, quindi siamo tutti bravi.

Sorprendentemente, il <a hreflang="en" href="https://css-tricks.com/currentcolor/">valore piuttosto utile `currentColor`</a> era solo lo 0.14% di tutti i colori sRGB (1.62% dei colori nominati)

Tutti i colori di cui abbiamo discusso finora hanno una cosa in comune: sRGB, lo spazio colore standard per il web (e per la TV ad alta definizione, da dove proviene). Perché è così brutto? Perché può visualizzare solo una gamma limitata di colori: il telefono, la TV e probabilmente il laptop sono in grado di visualizzare colori molto più vivaci grazie ai progressi della tecnologia di visualizzazione. I display con un'ampia gamma di colori, che erano riservati a fotografi professionisti e grafici ben pagati, sono ora disponibili per tutti. Le app native utilizzano questa funzionalità, così come i film digitali e i servizi di streaming TV, ma fino a poco tempo fa nel web mancava.

E ci stiamo ancora perdendo. Nonostante sia stato <a hreflang="en" href="https://webkit.org/blog/6682/improving-color-on-the-web/">implementato in Safari nel 2016</a>, l'uso del colore display-p3 nelle pagine web è incredibilmente piccolo. La nostra scansione del Web ha rilevato che solo 29 pagine mobile e 36 desktop lo utilizzano! (E più della metà di questi erano errori di sintassi, errori o tentativi di usare la funzione `color-mod()` mai implementata). Eravamo curiosi del perché.

È compatibile, no? Non vuoi che si rompa? No. Nei fogli di stile che abbiamo esaminato, abbiamo trovato un solido uso del fallback: con l'ordine dei documenti, la cascade, `@supports`, la media query `color-gamut`, tutta roba buona. Quindi in un foglio di stile vedremmo il colore desiderato dal designer, espresso in display-p3, e anche un colore sRGB di riserva. Abbiamo calcolato la differenza visibile (un calcolo chiamato <a hreflang="en" href="https://zschuessler.github.io/DeltaE/learn/">ΔE2000</a>) tra il colore desiderato e il colore di riserva e questo era in genere piuttosto modesto. Un piccolo aggiustamento. Un'attenta esplorazione. Infatti, il 37.6% delle volte, il colore specificato nel display-p3 rientrava effettivamente nella gamma di colori (la gamma) che sRGB può gestire. Per ora, sembra che stiano solo sperimentando con attenzione piuttosto che realizzare effettivamente un profitto, ma mi piacerebbe aspettarmi sviluppi futuri.

<figure>
  <table class="large-table">
    <thead>
      <tr>
        <th scope="col" colspan="2">sRGB</th>
        <th scope="col">display-p3</th>
        <th scope="col">ΔE2000</th>
        <th scope="col" class="no-wrap">In gamut</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>rgba(255,205,63,1)</code></td>
        <td>{{ swatch('rgba(255, 205, 63, 1)') }}</td>
        <td>color(display-p3 1 0.80 0.25 / 1)</td>
        <td class="numeric">3.880</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(120,0,255,1)</code></td>
        <td>{{ swatch('rgba(120, 0, 255, 1)') }}</td>
        <td>color(display-p3 0.47 0 1 / 1)</td>
        <td class="numeric">1.933</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(121,127,132,1)</code></td>
        <td>{{ swatch('rgba(121, 127, 132, 1)') }}</td>
        <td>color(display-p3 0.48 0.50 0.52 / 1)</td>
        <td class="numeric">0.391</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(200,200,200,1)</code></td>
        <td>{{ swatch('rgba(200, 200, 200, 1)') }}</td>
        <td>color(display-p3 0.78 0.78 0.78 / 1)</td>
        <td class="numeric">0.274</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(97,97,99,1)</code></td>
        <td>{{ swatch('rgba(97, 97, 99, 1)') }}</td>
        <td>color(display-p3 0.39 0.39 0.39 / 1)</td>
        <td class="numeric">1.474</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(0,0,0,1)</code></td>
        <td>{{ swatch('rgba(0, 0, 0, 1)') }}</td>
        <td>color(display-p3 0 0 0 / 1)</td>
        <td class="numeric">0.000</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(255,255,255,1)</code></td>
        <td>{{ swatch('rgba(255, 255, 255, 1)') }}</td>
        <td>color(display-p3 1 1 1 / 1)</td>
        <td class="numeric">0.015</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(84,64,135,1)</code></td>
        <td>{{ swatch('rgba(84, 64, 135, 1)') }}</td>
        <td>color(display-p3 0.33 0.25 0.53 / 1)</td>
        <td class="numeric">1.326</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(131,103,201,1)</code></td>
        <td>{{ swatch('rgba(131, 103, 201, 1)') }}</td>
        <td>color(display-p3 0.51 0.40 0.78 / 1)</td>
        <td class="numeric">1.348</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(68,185,208,1)</code></td>
        <td>{{ swatch('rgba(68, 185, 208, 1)') }}</td>
        <td>color(display-p3 0.27 0.75 0.82 / 1)</td>
        <td class="numeric">5.591</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(255,0,72)</code></td>
        <td>{{ swatch('rgb(255, 0, 72)') }}</td>
        <td>color(display-p3 1 0 0.2823 / 1)</td>
        <td class="numeric">3.529</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(255,205,63,1)</code></td>
        <td>{{ swatch('rgba(255, 205, 63, 1)') }}</td>
        <td>color(display-p3 1 0.80 0.25 / 1)</td>
        <td class="numeric">3.880</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(241,174,50,1)</code></td>
        <td>{{ swatch('rgba(241, 174, 50, 1)') }}</td>
        <td>color(display-p3 0.95 0.68 0.17 / 1)</td>
        <td class="numeric">4.701</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(245,181,40,1)</code></td>
        <td>{{ swatch('rgba(245, 181, 40, 1)') }}</td>
        <td>color(display-p3 0.96 0.71 0.16 / 1)</td>
        <td class="numeric">4.218</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(147, 83, 255)</code></td>
        <td>{{ swatch('rgb(147, 83, 255)') }}</td>
        <td>color(display-p3 0.58 0.33 1 / 1)</td>
        <td class="numeric">2.143</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(75,3,161,1)</code></td>
        <td>{{ swatch('rgba(75, 3, 161, 1)') }}</td>
        <td>color(display-p3 0.29 0.01 0.63 / 1)</td>
        <td class="numeric">1.321</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(255,0,0,0.85)</code></td>
        <td>{{ swatch('rgba(255, 0, 0, 0.85)') }}</td>
        <td>color(display-p3 1 0 0 / 0.85)</td>
        <td class="numeric">7.115</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(84,64,135,1)</code></td>
        <td>{{ swatch('rgba(84, 64, 135, 1)') }}</td>
        <td>color(display-p3 0.33 0.25 0.53 / 1)</td>
        <td class="numeric">1.326</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(131,103,201,1)</code></td>
        <td>{{ swatch('rgba(131, 103, 201, 1)') }}</td>
        <td>color(display-p3 0.51 0.40 0.78 / 1)</td>
        <td class="numeric">1.348</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(68,185,208,1)</code></td>
        <td>{{ swatch('rgba(68, 185, 208, 1)') }}</td>
        <td>color(display-p3 0.27 0.75 0.82 / 1)</td>
        <td class="numeric">5.591</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#6d3bff</code></td>
        <td>{{ swatch('#6d3bff') }}</td>
        <td>color(display-p3 .427 .231 1)</td>
        <td class="numeric">1.584</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#03d658</code></td>
        <td>{{ swatch('#03d658') }}</td>
        <td>color(display-p3 .012 .839 .345)</td>
        <td class="numeric">4.958</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#ff3900</code></td>
        <td>{{ swatch('#ff3900') }}</td>
        <td>color(display-p3 1 .224 0)</td>
        <td class="numeric">7.140</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#7cf8b3</code></td>
        <td>{{ swatch('#7cf8b3') }}</td>
        <td>color(display-p3 .486 .973 .702)</td>
        <td class="numeric">4.284</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#f8f8f8</code></td>
        <td>{{ swatch('#f8f8f8') }}</td>
        <td>color(display-p3 .973 .973 .973)</td>
        <td class="numeric">0.028</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e3f5fd</code></td>
        <td>{{ swatch('#e3f5fd') }}</td>
        <td>color(display-p3 .875 .945 .976)</td>
        <td class="numeric">1.918</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e74832</code></td>
        <td>{{ swatch('#e74832') }}</td>
        <td>color( display-p3 .905882353 .282352941 .196078431 / 1 )</td>
        <td class="numeric">3.681</td>
        <td>true</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption='Questa tabella mostra i colori sRGB di fallback, quindi i colori del display-p3. Una differenza di colore (ΔE2000) di 1 è appena visibile, mentre 5 è chiaramente distinta. Questa è una tabella di riepilogo (<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/#gid=264429000">vedi la tabella completa</a>).',
      sheets_gid="1370141402"
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  image="p3-chromaticity-big.svg",
  iframe="p3-chromaticity-big.svg",
  caption="Cromaticità UV dei colori display-p3 specificati e i loro fallback.",
  description="Questo diagramma u'v del 1976 mostra la cromaticità dei colori (appiattita in 2D, quindi la luminosità non viene mostrata). La forma curva esterna rappresenta lo spettro delle lunghezze d'onda singole pure; non ci sono colori visibili al di fuori di questo. La linea retta è porpora, una miscela di rosso e viola. Il triangolo più piccolo, grigio, è la gamma sRGB, mentre il triangolo più grande e più scuro è la gamma display-p3. Vengono mostrati i 23 colori unici del display-p3 attualmente in uso sul web nel 2020; per ogni coppia di colori il cerchio più grande è il fallback sRGB mentre il cerchio più piccolo è il colore del display-p3. Se è all'interno della gamma sRGB, quei cerchi mostrano il colore corretto. In caso contrario, un cerchio bianco con un bordo rosso indica colori fuori gamma sRGB.",
  width=600,
  height=600
) }}

I colori violacei sono simili in sRGB e display-p3, forse perché entrambi gli spazi colore hanno lo stesso blu primario. Vari rossi, arancioni-gialli e verdi sono vicini al limite della gamma sRGB (quasi il più saturo possibile) e mappati a punti analoghi vicino al limite del display p3 gamut.

Sembra che ci siano due ragioni per cui il web è ancora intrappolato nella terra sRGB. Il primo è la mancanza di strumenti, la mancanza di buoni selettori di colori, la mancanza di comprensione di quali colori più vividi siano disponibili. Ma il motivo principale, pensiamo, è che fino ad oggi Safari è l'unico browser a implementarlo. La situazione sta cambiando rapidamente - Chrome e Firefox stanno entrambi implementando in questo momento - ma fino a quando non verrà fornito il supporto, probabilmente utilizzare display-p3 è uno sforzo eccessivo per un guadagno insufficiente perché <a hreflang="en" href="https://gs.statcounter.com/browser-market-share">solo il 17% degli spettatori</a> vedrà quei colori. La maggior parte delle persone vedrà il fallback. Quindi l'uso attuale è un sottile cambiamento nella vivacità del colore, piuttosto che una grande differenza.

Sarà interessante vedere come l'uso del colore display-p3 (esistono altre opzioni, ma questa è l'unica che abbiamo trovato sul web) cambia nel corso del prossimo anno o due.

Perché *l'ampia gamma di colori* (wide color gamut o brevemente WCG) è solo l'inizio. L'industria televisiva e cinematografica è già passata dalla P3 a una gamma ancora più ampia, [*Rec. 2020*](https://it.wikipedia.org/wiki/BT.2020); e anche una gamma più ampia di luminosità, dai riflessi accecanti alle ombre più profonde. *High Dynamic Range* (HDR) è già arrivato nelle nostre case, soprattutto su giochi, TV in streaming e film. Il web ha molto da recuperare.

## Gradienti

Nonostante il minimalismo e il design piatto siano di gran moda, i gradienti CSS vengono utilizzati nel 75% delle pagine. Come previsto, quasi tutte le sfumature vengono utilizzate negli sfondi. Il 74.45% delle pagine specifica i gradienti negli sfondi, ma solo il 7% in qualsiasi altra proprietà.

I gradienti lineari sono 5 volte più popolari di quelli radiali e compaiono in quasi il 73% delle pagine, rispetto al 15% per i gradienti radiali. La differenza di popolarità è così sbalorditiva, che anche `-ms-linear-gradient()`, che non è mai stato necessario (Internet Explorer 10 supportava i gradienti sia con che senza il prefisso `-ms-`), è più popolare di `radial-gradient()`! Il <a hreflang="en" href="https://caniuse.com/css-conic-gradients">nuovo supporto</a> `conic-gradient()` è ancora più sottoutilizzato, apparendo solo in 652 pagine desktop (0.01%) e 848 pagine mobile (0.01%), il che è previsto, poiché Firefox ha appena spedito la sua implementazione al canale stabile.

Anche i gradienti ripetuti di tutti i tipi sono abbastanza sottoutilizzati, con `repeating-linear-gradient()` che appare solo nel 3% delle pagine e gli altri si trascinano ancora di più (`repeating-conic-gradient()` è usato solo in 21 pagine!).

I gradienti prefissati sono ancora molto popolari, anche se i gradienti non richiedono più un prefisso dal 2013. È da notare che -webkit-gradient() è ancora utilizzato in metà di tutti i siti Web, anche se <a hreflang="en" href="https://caniuse.com/css-gradients">non è più stato necessario dal 2011</a>. Inoltre `-webkit-linear-gradient()` è ancora la seconda funzione gradiente più utilizzata di tutte, che appare nel 57% dei siti web.

{{ figure_markup(
  image="gradient-functions.png",
  caption="Le funzioni gradiente più popolari come percentuale di pagine.",
  description="Grafico a barre che mostra le funzioni gradiente più popolari come percentuale delle pagine desktop e mobile. Le funzioni gradiente tendono ad essere più popolari sulle pagine mobile. La funzione gradiente più popolare è `linear-gradient`, utilizzata sul 73% delle pagine mobile. Seguito da `-webkit-linear-gradient` sul 57%, `-webkit-gradient` e `-linear-gradient` sul 50%, `-moz-linear-gradient` sul 49%, `-ms-linear-gradient` sul 33%, `radial-gradient` sul 15%, `-webkit-radial-gradient` sul 9%, e `repeating-linear-gradient` e `-moz-radial-gradient` utilizzato sul 3% delle pagine per dispositivi mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1552177796&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

{{ figure_markup(
  image="gradient-functions-unprefixed.png",
  caption="Le funzioni gradiente più popolari come percentuale di pagine, omettendo i prefissi del fornitore.",
  description="Grafico a barre che mostra le funzioni gradiente più popolari come percentuale delle pagine desktop e mobile, omettendo i prefissi del fornitore. L'adozione da desktop è leggermente inferiore ai dispositivi mobile. Le variazioni di `linear-gradient` sono utilizzate sul 72.57% delle pagine mobile, `radial-gradient` sul 15.13%, `repeating-linear-gradient` su 2.99%, `repeating-radial-gradient` sullo 0.07%, `conic-gradient` sullo 0.01% e `repeating-conic-gradient` su circa lo 0.00% delle pagine per dispositivi mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1676879657&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

Usare le interruzioni di colore con colori diversi nella stessa posizione (interruzioni nette) per creare strisce e altri motivi è una tecnica <a hreflang="en" href="https://lea.verou.me/2010/12/checkered-stripes-other-background-patterns-with-css3-gradients/">resa popolare per la prima volta da Lea Verou nel 2010</a>, che ormai ha molte variazioni interessanti, incluse <a hreflang="en" href="https://bennettfeely.com/gradients/">alcune davvero interessanti con la 'modalità di fusione' (blend modes)</a>. Anche se può sembrare un trucco, nel 50% delle pagine si trovano dei punti fermi, il che indica una forte esigenza degli sviluppatori di grafica leggera dall'interno dei CSS senza ricorrere a editor di immagini o SVG esterni.

Le interpolation hints (o come Adobe, che ha reso popolare la tecnica, li chiama: "midpoints") si trovano solo nel 22% delle pagine, nonostante <a hreflang="en" href="https://caniuse.com/mdn-css_types_image_gradient_linear-gradient_interpolation_hints">il supporto del browser quasi universale dal 2015</a>. Il che è un peccato, perché senza di loro, le interruzioni di colore sono collegate da linee rette nello spazio colore, piuttosto che da curve morbide. Questo basso utilizzo probabilmente riflette un malinteso su ciò che fanno o su come usarli; confrontalo con le transizioni e le animazioni CSS, dove le easing function (che fanno più o meno la stessa cosa, cioè connettono i fotogrammi chiave con le curve piuttosto che con linee rette a scatti) sono più comunemente usate ([80% delle transizioni](#transizioni-e-animazioni)). "Midpoints" non è una descrizione molto comprensibile e "interpolation hint" sembra che tu stia aiutando il browser a fare semplici calcoli aritmetici.

La maggior parte dell'utilizzo del gradiente è piuttosto semplice, con oltre il 75% dei gradienti trovati nell'intero set di dati utilizzando solo 2 interruzioni di colore. In effetti, meno della metà delle pagine contiene anche una singola sfumatura con più di 3 interruzioni di colore!

Il gradiente con il maggior numero di interruzioni di colore è <a hreflang="en" href="https://dabblet.com/gist/4d1637d78c71ef2d8d37952fc6e90ff5">questo</a> con 646 interruzioni! Questo è quasi certamente generato e il codice CSS risultante è 8KB, quindi un PNG alto 1px avrebbe probabilmente fatto anche il lavoro, con un'impronta più piccola (la nostra immagine sotto è di 1,1 KB).

{{ figure_markup(
  image="gradient-most-stops.png",
  classes="height-16vw-122px",
  caption="Il gradiente con il maggior numero di interruzioni di colore, 646.",
  description="Uno screenshot del gradiente con il maggior numero di interruzioni di colore, che è una serie di intricate strisce multicolori di varie tonalità.",
  width=600,
  height=122
) }}

## Layout

CSS ora ha una serie di opzioni di layout che lo distinguono dalle tabelle che dovevano essere utilizzate per il layout. I layout Flexbox, Grid e Multiple-column sono supportati dalla maggior parte dei browser.

### Adozione di Flexbox e Grid

[L'edizione 2019](../2019/css#flexbox), ha riportato che il 41% delle pagine su dispositivi mobile e desktop conteneva proprietà [Flexbox](https://developer.mozilla.org/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox). Nel 2020, questo numero è cresciuto al 63% per i dispositivi mobile e al 65% per i desktop. Questo metodo di layout è ampiamente adottato, poiché esistono ancora numerosi siti legacy sviluppati prima che Flexbox diventasse uno strumento valido.

Se guardiamo [Grid layout](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout), la percentuale di siti che utilizzano il layout Grid è aumentata al 4% per i dispositivi mobile e al 5% per desktop. L'utilizzo è raddoppiato dall'anno scorso, ma è ancora molto indietro rispetto al layout flessibile.

{{ figure_markup(
  image="flexbox-grid-mobile.png",
  caption="Adozione di Flexbox e Grid per anno come percentuale delle pagine mobile.",
  description="Grafico a barre che mostra l'adozione di Flexbox e Grid per anno come percentuale delle pagine mobile. L'adozione di Flexbox è cresciuta dal 2019 al 2020 dal 41% al 63% delle pagine mobile. L'adozione della rete è aumentata dal 2% al 4% nello stesso periodo di tempo.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1879364309&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

{{ figure_markup(
  image="flexbox-grid-desktop.png",
  caption="Adozione di flexbox e grid per anno come percentuale delle pagine desktop.",
  description="Grafico a barre che mostra l'adozione di flexbox e grid per anno come percentuale delle pagine desktop. L'adozione di Flexbox è cresciuta dal 2019 al 2020 dal 41% al 65% delle pagine mobile. L'adozione della rete è aumentata dal 2% al 5% nello stesso periodo di tempo.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1140202160&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

Notare che, a differenza della maggior parte delle altre metriche in questo capitolo, questo è l'effettivo utilizzo misurato del Grid, e non solo le proprietà e i valori relativi del Grid specificati in un foglio di stile e potenzialmente non utilizzati. Sebbene a prima vista questo possa sembrare più accurato, una cosa da tenere a mente è che HTTP Archive esegue la scansione delle home page, quindi questi dati potrebbero essere distorti a causa del Grid che spesso appaiono più nelle pagine interne.

Quindi, diamo un'occhiata anche a un'altra metrica: quante pagine specificano `display: grid` e `display: flex` nei loro fogli di stile? Questa metrica pone il layout Grid a un'adozione significativamente più elevata, con il 30% delle pagine che utilizza `display: grid` almeno una volta. Tuttavia, non influisce in modo significativo sul numero di Flexbox, con il 68% delle pagine che specifica `display: flex`. Anche se questo suona come un'adozione incredibilmente alta per Flexbox, vale la pena notare che le tabelle CSS sono ancora molto più popolari con l'80% delle pagine che utilizzano le table display mode! Parte di questo utilizzo potrebbe essere dovuto a <a hreflang="en" href="https://css-tricks.com/snippets/css/clear-fix/">alcuni tipi di clearfix</a> che usano `display: table` e non il layout effettivo.

{{ figure_markup(
  image="layout-methods.png",
  caption="Modalità di layout e percentuale di pagine in cui appaiono. Questi dati sono una combinazione di alcuni valori dalle proprietà `display`, `position` e `float`.",
  description="Grafico a barre che mostra l'adozione dei metodi di layout come percentuale delle pagine desktop e mobile. I risultati su desktop e dispositivi mobile sono simili se non diversamente specificato. I primi quattro metodi di layout sono block, absolute, floats, and inline-block rispettivamente al 92%, 92%, 91% e 90%. Successivamente, inline, fixed e css tables hanno rispettivamente l'81%, l'80% e l'80% di adozione. Flex ha il 68% di adozione, seguito da box al 46% e nettamente più grande dell'adozione da desktop al 38%, inline-flex al 33%, grid al 30%, list-item al 26%, inline-table al 26%, inline-box al 20% e sticky al 13% delle pagine per dispositivi mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013998073&format=interactive",
  width="600",
  height="588",
  sheets_gid="335708969",
  sql_file="layout_properties.sql"
) }}

Dato che Flexbox era utilizzabile nei browser prima del layout Grid, è probabile che parte dell'utilizzo di Flexbox sia per la configurazione di un grid system. Per utilizzare Flexbox come grid, gli autori devono disabilitare parte della flessibilità intrinseca di Flexbox. Per fare ciò, imposta la proprietà `flex-grow` su `0`, quindi dimensiona gli elementi flessibili usando le percentuali. Utilizzando queste informazioni siamo stati in grado di segnalare che il 19% dei siti sia su desktop che su dispositivi mobile utilizzava Flexbox in questo modo simile a una griglia.

I motivi per scegliere Flexbox su Grid sono spesso citati come supporto del browser, dato che il layout Grid <a hreflang="en" href="https://caniuse.com/css-grid">non era supportato in Internet Explorer</a>. Inoltre, alcuni autori potrebbero non aver ancora imparato il layout Grid o utilizzare un framework con un sistema grid basato su Flexbox. Il framework <a hreflang="en" href="https://getbootstrap.com/docs/4.5/layout/grid/">Bootstrap</a> attualmente utilizza un grid basato su Flexbox, che è comune con alcune scelte di framework popolari.

### Utilizzo di diverse tecniche di layout Grid

La specifica del layout Grid offre diversi modi per descrivere e definire il layout in CSS. L'utilizzo più elementare prevede la disposizione degli elementi [da una grid line all'altra](https://www.smashingmagazine.com/2020/01/understanding-css-grid-lines/). Che dire delle [linee di denominazione](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout/Layout_using_Named_Grid_Lines) o dell'uso di `grid-template-areas`?

Per le righe con nome, abbiamo verificato la presenza di parentesi quadre in un elenco di tracce. Il nome o i nomi inseriti tra parentesi quadre.

```css
.wrapper {
  display: grid;
  grid-template-columns: [main-start] 1fr [content-start] 1fr [content-end] 1fr [main-end];
}
```

Di conseguenza, lo 0.23% delle pagine che utilizzano Grid sui dispositivi mobile avevano linee denominate, rispetto allo 0.27% sui desktop.

La funzione [Grid template areas](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout/Grid_Template_Areas), che consente agli autori di denominare gli grid item e di posizionarli sulla griglia come valore della proprietà `grid-template-areas`. Dei siti che utilizzano Grid, il 19% su dispositivi mobile e il 20% su desktop utilizzava questo metodo.

Questi risultati mostrano che non solo l'utilizzo del layout Grid è ancora relativamente basso sui siti Web di produzione, ma anche il suo utilizzo è relativamente semplice. L'autore preferisce una semplice disposizione basata sulla riga rispetto al modo in cui è possibile denominare righe e aree. Sebbene non ci sia nulla di sbagliato nella scelta di farlo, mi chiedo se la lenta adozione del layout Grid sia in parte dovuta al fatto che gli autori non hanno ancora realizzato la potenza di queste funzionalità. Se il layout Grid è visto essenzialmente come Flexbox con uno scarso supporto del browser, questo lo renderebbe sicuramente una scelta meno convincente.

### Layout a più colonne

Il [layout a più colonne](https://developer.mozilla.org/docs/Web/CSS/CSS_Columns/Basic_Concepts_of_Multicol) o *multicol*, consente la disposizione del contenuto in colonne, proprio come un quotidiano. Sebbene popolare nei CSS come utilizzato per la stampa, è meno utile sul Web a causa del rischio di creare una situazione in cui un lettore deve scorrere su e giù per leggere il contenuto. Sulla base dei dati, tuttavia, ci sono molte più pagine che utilizzano il layout multicol rispetto al layout Grid con il 15.33% su desktop e il 14.95% su dispositivi mobile. Sebbene le proprietà base multicol siano ben supportate, l'uso più complesso e il controllo delle column break con <a hreflang="en" href="https://www.smashingmagazine.com/2019/02/css-fragmentation/">fragmentation</a> ha <a hreflang="en" href="https://caniuse.com/multicolumn">supporto irregolare</a>. Detto questo, è stato abbastanza sorprendente che ci fossero così tanti usi.

### Box sizing

È utile sapere quanto saranno grandi le caselle sulla tua pagina, ma con il [standard CSS box model](https://developer.mozilla.org/docs/Learn/CSS/Building_blocks/The_box_model#What_is_the_CSS_box_model) aggiungendo padding e border alla dimensione della content-box, la dimensione che hai dato alla tua casella è più piccola della casella visualizzata sulla tua pagina. Sebbene non possiamo cambiare la cronologia, la proprietà `box-sizing` consente agli autori di passare ad applicare la dimensione specificata al `border-box`, quindi la dimensione che imposti è la dimensione che vedi renderizzata. Quanti siti usano la proprietà `box-sizing`? La maggior parte di loro! La proprietà `box-sizing` appare nell'83.79% dei CSS desktop e nell'86.39% sui dispositivi mobile.

{{ figure_markup(
  image="box-sizing.png",
  caption="Distribuzione del numero di dichiarazioni `border-box` per pagina.",
  description="Grafico a barre che mostra la distribuzione del numero di dichiarazioni `box-sizing` per pagina per desktop e mobile. La distribuzione mobile porta i desktop da 0 a 11 dichiarazioni per pagina, crescendo nei percentili più alti. I 10, 25, 50, 75 e 90° percentile della distribuzione mobile sono: 0, 4, 17, 46 e 96 dichiarazioni `border-box` per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1626960751&format=interactive",
  sheets_gid="1982524793",
  sql_file="box_sizing.sql"
) }}

La pagina desktop mediana ha 14 dichiarazioni `box-sizing`. Nel mobile ne ha 17. Forse a causa dei sistemi di componenti che inseriscono la dichiarazione per componente, piuttosto che globalmente come regola per tutti gli elementi nel foglio di stile.

## Transizioni e animazioni

Le transizioni e le animazioni sono diventate complessivamente molto popolari con la proprietà `transition` utilizzata sull'81% di tutte le pagine e `animation` sul 73% delle pagine mobile e sul 70% delle pagine desktop. È piuttosto sorprendente che l'utilizzo non sia inferiore sui dispositivi mobile, dove ci si aspetterebbe che <a hreflang="en" href="https://css-tricks.com/how-web-content-can-affect-power-usage/">il risparmio della carica della batteria</a> sia una priorità. D'altra parte, le animazioni CSS sono molto più efficienti dalla batteria rispetto all'animazione JS, specialmente la maggior parte di esse che si limita ad animare trasformazioni e opacità (vedere la sezione successiva).

La singola proprietà di transizione più comune specificata è `all`, utilizzata nel 41% delle pagine. Questo è un po ’sconcertante perché `all` è il valore iniziale, quindi non ha bisogno di essere specificato esplicitamente. Dopodiché, le transizioni fade in/out sembrano essere il tipo più comune, utilizzato in oltre un terzo delle pagine sottoposte a scansione, seguite da transizioni sulla proprietà `transform` (molto probabilmente spin, scale, transizioni di movimento). Sorprendentemente, la transizione di `height` è molto più popolare della transizione di `max-height`, anche se quest'ultima è una soluzione comunemente insegnata quando l'altezza iniziale o finale è sconosciuta (auto). È stato anche sorprendente vedere un utilizzo significativo per la proprietà `scale` (2%), nonostante la sua mancanza di supporto oltre a Firefox. Uso intenzionale di CSS all'avanguardia, un errore di battitura o un malinteso su come animare le trasformazioni?

{{ figure_markup(
  image="transition-properties.png",
  caption="Adozione delle proprietà di transizione come percentuale delle pagine.",
  description="Grafico a barre che mostra l'adozione delle proprietà di transizione più popolari. Le pagine desktop e mobile sono molto simili, tranne per il fatto che il filtro non sembra essere utilizzato in modo significativo sul desktop. La proprietà di transizione più popolare sulle pagine mobili è `all`, utilizzata sul 41% delle pagine, seguita da `opacity` al 37%, `transform` al 26%, `color` al 17%, `none` al 15%, `height` al 13%, `background-color` al 12%, `background` al 10%, `filter` al 7% e le restanti proprietà utilizzate sul 6% delle pagine mobile: `width`, `left`, `top`, `-webkit-transform`, `box-shadow` e `border-color`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1677028861&format=interactive",
  sheets_gid="134272305",
  sql_file="transition_properties.sql"
) }}

Siamo stati lieti di scoprire che la maggior parte di queste transizioni è piuttosto breve, con una durata media della transizione di soli 300 ms e il 90% dei siti Web con una durata media inferiore a mezzo secondo. Questa è generalmente una buona pratica, poiché le transizioni più lunghe possono rendere lenta un'interfaccia utente, mentre una breve transizione comunica un cambiamento senza intralciare.

{{ figure_markup(
  image="transition-durations.png",
  caption="Distribuzione delle durate di transizione.",
  description="Grafico a barre che mostra la distribuzione delle durate di transizione in millisecondi per le pagine desktop e per dispositivi mobili. Desktop e dispositivi mobili sono equivalenti al 10, 25 e 90° percentile con durate rispettivamente di 100, 150 e 500 ms. Tuttavia, alla mediana e al 75° percentile, il desktop ha una durata maggiore di 50 ms: rispettivamente 300 e 400 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1587838983&format=interactive",
  sheets_gid="286912288",
  sql_file="transition_durations.sql"
) }}

`Ease` è la funzione di temporizzazione specificata più popolare, anche se è l'impostazione predefinita, quindi può essere effettivamente omessa. Forse le persone specificano esplicitamente le impostazioni predefinite perché preferiscono la verbosità auto-documentante o, forse più probabilmente, perché non sanno che sono predefinite. Nonostante gli svantaggi dell'animazione che progredisce in modo lineare (tende a sembrare noiosa e innaturale), `linear` è la seconda funzione di temporizzazione più utilizzata con il 19.1%. È anche interessante che le funzioni di andamento integrate soddisfino oltre l'87% di tutte le transizioni: solo il 12.7% ha scelto di specificare un andamento personalizzato tramite `cubic-bezier()`.

{{ figure_markup(
  image="transition-timing-functions.png",
  caption="La popolarità relativa del tempo funziona come percentuale di occorrenze sulle pagine per dispositivi mobile.",
  description="Grafico a torta che mostra la popolarità relativa delle funzioni di temporizzazione come percentuale di occorrenze sulle pagine per dispositivi mobile. La funzione di temporizzazione più popolare è `ease` al 31% delle occorrenze, seguita da `linear` al 19%, `ease-in-out` al 19%, `cubic-bezier` al 13%, `ease-out` a 9%, `steps` al 5% e  `ease`-in al 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=63879013&format=interactive",
  sheets_gid="1514240349",
  sql_file="transition_timing_functions.sql"
) }}

Uno dei principali fattori di adozione dell'animazione sembra essere Font Awesome, come evidenziato dal nome dell'animazione `fa-spin` che appare in una delle quattro pagine e quindi in cima alla lista dei nomi di animazione più popolari. Sebbene ci sia un'ampia varietà di nomi di animazione, sembra che la maggior parte di essi rientri solo in poche categorie di base, con un'animazione su cinque che è una sorta di rotazione. Ciò può anche spiegare l'alta percentuale di transizioni e animazioni che progrediscono linearmente: se vogliamo una rotazione continua e fluida, `linear` è la strada da percorrere.

{{ figure_markup(
  image="transition-animation-names.png",
  caption="Popolarità relativa delle categorie di nomi di animazione utilizzate come percentuale di occorrenze.",
  description="Grafico a barre che mostra la popolarità relativa delle categorie di nomi di animazione come percentuale di occorrenze. La categoria più popolare è `rotate`, che costituisce il 21% delle occorrenze su pagine mobile, seguita da unknown/other al 13%, `fade` al 9%, `bounce` al 7%, `scale` al 6%, `wobble` e `slide` al 5%, `pulse` al 2% e il resto all'1%: `visibility`, `flip` e `move`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=709747830&format=interactive",
  sheets_gid="1998209374",
  sql_file="transition_animation_names.sql"
) }}

## Effetti visivi

CSS offre anche una grande varietà di effetti visivi che danno ai progettisti l'accesso a tecniche di progettazione avanzate integrate nei browser a cui è possibile accedere con piccole quantità di codice.

### I metodi di fusione

L'anno scorso, l'8% delle pagine utilizzava i metodi di fusione (blend modes). Quest'anno, l'adozione è aumentata in modo significativo, con il 13% delle pagine che utilizza modalità di fusione sugli elementi (`mix-blend-mode`) e il 2% sui background (`background-blend-mode`).

### Filtri

L'adozione dei filtri è rimasta elevata, con la proprietà `filter` che compare nel 79.43% delle pagine. Anche se all'inizio era abbastanza eccitante, è probabile che molti siano vecchi filtri DX IE (`-ms-filter`), che condividevano lo stesso nome di proprietà. Quando abbiamo preso in considerazione solo i filtri CSS validi che Blink riconosce, l'utilizzo scende al 22% per i dispositivi mobile e al 20% per i desktop, con `blur()` che è il tipo di filtro più popolare e compare nel 4% delle pagine.

Un'altra proprietà del filtro, `background-filter`, ci consente di applicare filtri solo all'area dietro un elemento, che è incredibilmente utile per migliorare il contrasto su sfondi traslucidi e creare l'elegante <a hreflang="en" href="https://css-tricks.com/backdrop-filter-effect-with-css/">effetto "vetro smerigliato"</a> che abbiamo imparato da molte interfacce utente native. Anche se non così popolare come `filter`, abbiamo trovato `background-filter` nel 6% delle pagine.

La funzione `filter()` ci permette di applicare un filtro solo su una particolare immagine, che può essere estremamente utile per gli sfondi. Purtroppo, è <a hreflang="en" href="https://caniuse.com/css-filter-function">attualmente supportato solo da Safari</a>. Non abbiamo trovato alcun utilizzo di `filter()`.

### Maschere

Un decennio fa, abbiamo ottenuto le maschere in Safari con `-webkit-mask-image` ed è stato emozionante. Tutti lo stavano usando. Alla fine abbiamo ottenuto <a hreflang="en" href="https://www.w3.org/TR/css-masking-1/">una specifica</a> e una serie di proprietà non prefissate modellate strettamente sul prototipo WebKit, e sembrava una questione di tempo prima che il mascheramento diventasse standard, con una sintassi coerente su tutti i browser. 10 anni dopo e la sintassi non prefissata è <a hreflang="en" href="https://caniuse.com/css-masks">ancora non supportata in Chrome o Safari, il che significa che è disponibile su meno del 5% dei browser degli utenti in tutto il mondo</a>. Non sorprende quindi che `-webkit-mask-image` sia ancora più popolare della sua controparte standard, essendo presente nel 22% delle pagine. Tuttavia, nonostante il suo scarso supporto, `mask-image` si trova nel 19% delle pagine. Vediamo un modello simile nella maggior parte delle altre proprietà di mascheramento con le versioni non prefissate che appaiono in quasi tante pagine quante quelle `-webkit-`. Nel complesso, le maschere si trovano ancora in quasi un quarto del web, a indicare che i casi d'uso sono ancora lì, nonostante la mancanza di interesse da parte dell'implementatore.

{{ figure_markup(
  image="mask-properties.png",
  caption="Popolarità relativa delle proprietà della maschera come percentuale di occorrenze.",
  description="`-webkit-mask-image` viene utilizzato sul 22% delle pagine mobile, rispetto al 19% su desktop. Le seguenti proprietà sono `mask-size` e `mask-image` al 19%, `mask-repeat`, `mask-position`, `mask-mode` e `-webkit-mask-size` al 18%, `-webkit-mask-repeat` e `-webkit-mask-position` al 16%, e le proprietà `-webkit-mask` e `mask` al 2% delle pagine mobile. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=615866471&format=interactive",
  width="600",
  height="575",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

### I clipping path

Più o meno nello stesso periodo le maschere sono diventate popolari, un'altra proprietà simile ma più semplice (originariamente da SVG) ha iniziato a girare: `clip-path`. Tuttavia, a differenza delle maschere, ha avuto un destino migliore. È stato standardizzato abbastanza rapidamente e ha ottenuto supporto su tutta la linea relativamente velocemente, con l'ultimo blocco è stato Safari che ha abbandonato il prefisso nel 2016. Oggi, si trova sul 19% delle pagine non prefissate e sul 13% con il prefisso `-webkit-`.

## Responsive design

Realizzare siti in grado di far fronte alle diverse dimensioni dello schermo e ai dispositivi che navigano sul Web è diventato un po' più semplice con i nuovi metodi di layout flessibili e responsive integrati come Flexbox e Grid. Questi metodi di layout sono generalmente ulteriormente migliorati con l'uso di media query. I dati mostrano che l'80% dei siti desktop e l'83% dei siti mobile utilizzano media queries associate al responsive design, come `min-width`.

### Quali media query utilizzano le persone?

Come ci si potrebbe aspettare, le media query più comuni in uso sono le funzionalità delle dimensioni del viewport che sono state in uso sin dai primi giorni del responsive web design. La percentuale di siti che cercano `max-width` è del 78% sia per desktop che per dispositivi mobile. Un controllo per le funzionalità `min-width` sul 75% dei siti mobile e sul 73% dei siti desktop.

La funzione multimediale `orientation`, che consente agli autori di differenziare il proprio layout in base al fatto che lo schermo sia verticale o orizzontale, può essere trovata sul 33% di tutti i siti.

Stiamo vedendo alcune media query più recenti emergere nelle statistiche. La funzione multimediale <a hreflang="en" href="https://web.dev/prefers-reduced-motion/">`prefers-reduction-motion`</a> fornisce un modo per verificare se l'utente ha richiesto un movimento ridotto, in modo che i siti web possano regolare la quantità di animazione che utilizzano. Questo può essere attivato in modo esplicito, tramite un'impostazione del sistema operativo controllata dall'utente o implicitamente, ad esempio a causa della diminuzione del livello della batteria. Il 24% dei siti sta verificando questa funzionalità.

L'altra buona notizia è che stanno iniziando a comparire nuove funzionalità dalla specifica <a hreflang="en" href="https://www.w3.org/TR/mediaqueries-4/">Media Queries Level 4</a>. Sui dispositivi mobile, il 5% dei siti verifica il tipo di puntatore di cui dispone l'utente. Un puntatore `coarse` indica che stanno usando un touchscreen, mentre un puntatore `fine` indica un dispositivo di puntamento. Capire il modo in cui un utente interagisce con il tuo sito è spesso altrettanto utile, se non di più, rispetto alle dimensioni dello schermo. Una persona potrebbe utilizzare un dispositivo con schermo piccolo con tastiera e mouse o un dispositivo con schermo grande ad alta risoluzione con touchscreen.

{{ figure_markup(
  image="media-query-features.png",
  caption="Le media query più popolari come percentuale delle pagine.",
  description="Grafico a barre delle funzioni di media query più popolari come percentuale delle pagine. Desktop e dispositivi mobili sono generalmente simili se non diversamente specificato. La funzione di media query più popolare sulle pagine per dispositivi mobili è `max-width` al 79%, seguita da `min-width` al 75%, `-webkit-min-device-pixel-ratio` al 45% (dal desktop al 39%), orientation al 33%, `max-device-width` al 28%, `-ms-high-contrast` al 24% (in aumento dal desktop al 15%), `prefers-reduced-motion` al 24% , `max-height` e `min-resolution` al 22%, `-webkit-transform-3d`, `transform-3d` e `min-device-pixel-ratio` tutti al 15%, `min-height` utilizzato sul 14% delle pagine mobile ma solo sul 3% delle pagine desktop, `-o-min-device-pixel-ratio` all'8%, `pointer` al 5% e infine `device-width` al 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1998463556&format=interactive",
  sheets_gid="1374950017",
  width="600",
  height="600",
  sql_file="media_query_features.sql"
) }}

### Breakpoint comuni

Il breakpoint più comune in uso tra desktop e mobile è un `min-width` di 768px. Il 54% dei siti utilizza questo breakpoint, seguito da vicino da una `max-width` di 767 px al 50%. <a hreflang="en" href="https://getbootstrap.com/docs/4.1/layout/overview/">Il framework Bootstrap</a> usa una `min-width` di 768 px come dimensione "Media", quindi questa potrebbe essere la fonte di gran parte dell'utilizzo. Gli altri due valori di `min-width` di alto livello di 1200px (40%) e 992px (37%) si trovano anche in Bootstrap.

{{ figure_markup(
  image="breakpoints.png",
  caption="I breakpoint più popolari per `min-width` e `max-width` come percentuale delle pagine per dispositivi mobile",
  description="I breakpoint più popolari di `min-width` e `max-width` come percentuale delle pagine mobile. `480px` viene utilizzato come min-width sul 21% delle pagine per dispositivi mobile e come `max-width` sul 35%. `600px` su 27% e 37% rispettivamente per larghezze min e max, `767px` su 8% e 50%, `768px` su 54% e 35%, `800px` su 8% e 24%, `991px` su 3% e 30%, `992px` su 37% e 11%, `1024px` su 13% e 23%, `1199px` su solo 31% come `max-width` e `1200px` su 40% e 19%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=502128948&format=interactive",
  sheets_gid="1070028321",
  sql_file="media_query_values.sql"
) }}

I pixel sono l'unità utilizzata per i breakpoint. `Em` è molto più in basso nell'elenco, ma l'impostazione dei breakpoint in pixel sembra essere una scelta comune. Probabilmente ci sono molte ragioni per questo. Legacy: tutti i primi articoli sul responsive design utilizzano i pixel e molte persone pensano ancora al targeting di dispositivi particolari durante la creazione di responsive design. Sizing: <a hreflang="en" href="https://zellwk.com/blog/media-query-units/">usare `em`</a> implica considerare la dimensione del contenuto piuttosto che il dispositivo, questo è un nuovo modo di pensare al web design, probabilmente non ancora completamente utilizzato, insieme ai metodi di dimensionamento essenziali per il layout.

### Proprietà utilizzate nelle media query

Il 79% delle media query sui dispositivi mobile e il 77% sui desktop vengono utilizzati per modificare la proprietà `display`. Forse indica che le persone stanno testando prima di passare a un contesto di formattazione Flex o Grid. Anche in questo caso, potrebbe trattarsi di framework collegati, ad esempio le <a hreflang="en" href="https://getbootstrap.com/docs/4.1/utilities/display/">Bootstrap responsive utilities</a>. Il 78% degli autori cambia la proprietà `width` all'interno delle media query, `margin`, `padding` e `font-size` sono tutti classificati in alto nella proprietà modificata.

{{ figure_markup(
  image="media-query-properties.png",
  caption="Le proprietà più popolari utilizzate nelle media query come percentuale delle pagine.",
  description="Grafico a barre delle proprietà più popolari utilizzate nelle media query come percentuale delle pagine. Desktop e mobile sono molto simili. La percentuale di pagine mobile varia dal 79% al 71% per `display`, `width`, `margin-left`, `padding`, `font-size`, `height`, `margin`, `margin-right` , `margin-top` e `position`, in quest'ordine.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1199544976&format=interactive",
  sheets_gid="190367365",
  sql_file="media_query_properties.sql"
) }}

## Proprietà personalizzate

L'anno scorso, solo il 5% dei siti web utilizzava proprietà personalizzate. Quest'anno l'adozione è aumentata alle stelle. Utilizzando la query dello scorso anno (che contava solo le dichiarazioni che impostano proprietà personalizzate), l'utilizzo è quadruplicato sui dispositivi mobile (19.29%) e triplicato sui desktop (14.47%). Tuttavia, quando guardiamo i valori che fanno riferimento a proprietà personalizzate tramite `var()`, otteniamo un'immagine ancora migliore: il 27% delle pagine mobile e il 22% delle pagine desktop utilizzavano la funzione `var()` almeno una volta.

Anche se a prima vista si tratta di un'adozione impressionante, sembra che uno dei principali driver sia WordPress, come dimostrano i nomi di proprietà personalizzate più popolari, i primi 4 dei quali forniti con WordPress.

### Denominazione

{{ figure_markup(
  image="custom-property-names.png",
  caption="Popolarità relativa dei nomi di proprietà personalizzate per entità software come percentuale di occorrenze sulle pagine per dispositivi mobile.",
  description="La popolarità relativa dei nomi delle proprietà personalizzate viene mostrata in un grafico a torta come frequenza di occorrenza sulle pagine per dispositivi mobile per ciascuna entità software responsabile della creazione della proprietà. Il 35% dei nomi di proprietà personalizzate sulle pagine mobile può essere ricondotto ad Avada, il 31% a Bootstrap, il 16% a Elementor, il 13% a WordPress e il 3% a versioni precedenti di Multirange.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1627287194&format=interactive",
  sheets_gid="1043074687",
  sql_file="custom_property_names.sql"
) }}

Dei 1.000 nomi di proprietà principali, meno di 13 sono "personalizzati", in quanto creati da singoli sviluppatori web. La stragrande maggioranza è associata a software popolari, come WordPress, Elementor e Avada. Per determinarlo, abbiamo preso in considerazione non solo quali proprietà personalizzate compaiono in quale software (effettuando una ricerca su GitHub), ma anche quali proprietà compaiono in gruppi con frequenze simili. Questo non significa necessariamente che il modo principale in cui una proprietà personalizzata finisce su un sito web è attraverso l'utilizzo di quel software (le persone continuano a copiare e incollare!), ma indica che non ci sono molte cose in comune tra le proprietà personalizzate che gli sviluppatori definiscono. Gli unici nomi di proprietà personalizzate che sembrano aver fatto organicamente l'elenco dei primi 1000 sono `--height`, `--primary-color` e `--caption-color`.

### Utilizzo per tipo

Il miglior uso delle proprietà personalizzate sembra essere quello di nominare i colori e mantenere i colori coerenti nel complesso. Circa 1 pagina desktop su 5 e 1 pagina mobile su 6 utilizzano proprietà personalizzate in `background-color` e le prime 11 proprietà, inclusi i riferimenti a `var()`, sono proprietà del colore o un'abbreviazione che include il colore. La lunghezza è il secondo utilizzo più grande, con `width` e `height` usati con `var()` nel 7% delle pagine mobile (solo circa il 3% usato nelle pagine desktop). Ciò è stato confermato anche con i tipi di valore più diffusi, in cui i valori di colore costituiscono il 52% delle dichiarazioni di proprietà personalizzate. Le dimensioni (numeri + unità (lengths, angles, times, ecc.)) sono il secondo tipo più popolare e sono superiori ai numeri senza unità (12%). Poiché i numeri possono essere convertiti in dimensioni moltiplicando con `calc()`, ma la divisione in dimensioni non è ancora supportata, quindi le dimensioni non possono essere convertite in numeri.

{{ figure_markup(
  image="custom-property-properties.png",
  caption="I nomi di proprietà più popolari utilizzati con proprietà personalizzate come percentuale delle pagine.",
  description="Grafico a barre dei nomi di proprietà più popolari utilizzati con proprietà personalizzate, come percentuale delle pagine. L'adozione dei dispositivi mobile è molto più elevata per ciascuna proprietà rispetto alle controparti desktop. Le proprietà personalizzate vengono utilizzate su `background-color` e `color` rispettivamente nel 19% e nel 15% delle pagine per dispositivi mobile. Le restanti proprietà usano proprietà personalizzate dal 9% al 6% in ordine decrescente: `border`,`background`, `border-top`, `border-bottom`, `background-image`, `box-shadow`, `height`, `width`, `border-left`, `min-height`, `margin-top`, `border-right` e `border-left-color`. L'adozione da desktop è inferiore di circa 4 punti percentuali.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=16420165&format=interactive",
  sheets_gid="556945658",
  sql_file="custom_property_properties.sql"
) }}

Nei preprocessori, le variabili di colore vengono spesso manipolate per generare variazioni di colore, come tinte diverse. Tuttavia, in CSS <a hreflang="en" href="https://drafts.csswg.org/css-color-5/">le funzioni di modifica del colore</a> sono semplicemente una bozza non implementata. Al momento, l'unico modo per generare nuovi colori dalle variabili è usare le variabili per i singoli componenti e inserirle nelle funzioni del colore, come `rgba()` e `hsla()`. Tuttavia, meno del 4% delle pagine per dispositivi mobile e dello 0.6% delle pagine desktop lo fanno, indicando che l'elevato utilizzo di variabili di colore è principalmente quello di contenere interi colori, con le loro variazioni che sono variabili separate invece che generate dinamicamente.

{{ figure_markup(
  image="custom-property-functions.png",
  caption="I nomi di funzione più popolari utilizzati con proprietà personalizzate come percentuale delle pagine.",
  description="Grafico a barre dei nomi di funzioni più popolari utilizzati con proprietà personalizzate, come percentuale delle pagine. L'adozione da dispositivi mobile è molto più elevata per le prime sei funzioni: `calc` (7%), `linear-gradient`, `rgba` (4%), `radial-gradient`, `hsla` e `drop-shadow`. Le seguenti funzioni hanno l'1% di adozione su desktop e pagine mobile: `-o-linear-gradient`, `translate` e `-webkit-linear-gradient`. E infine queste funzioni hanno circa lo 0% di adozione su desktop e pagine mobile: `scale`, `-webkit-gradient`, `max`, `to`, `from` e `rotate`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1986770560&format=interactive",
  width="600",
  height="525",
  sheets_gid="2076074923",
  sql_file="custom_property_functions.sql"
) }}

### Complessità

Successivamente, abbiamo esaminato quanto sia complesso l'utilizzo delle proprietà personalizzate. Un modo per valutare la complessità del codice nell'ingegneria del software è la forma del grafico delle dipendenze. Per prima cosa abbiamo esaminato la *profondità* di ciascuna proprietà personalizzata. Una proprietà personalizzata impostata su un valore letterale come ad es. `#fff` ha una profondità di 0, mentre una proprietà che fa riferimento a quella tramite var() avrebbe una profondità di 1 e così via. Per esempio:

```css
:root {
  --base-hue: 335; /* depth = 0 */
  --base-color: hsl(var(--base-hue) 90% 50%); /* depth = 1 */
  --background: linear-gradient(var(--base-color), black); /* depth = 2 */
}
```

2 proprietà personalizzate su 3 esaminate (67%) avevano una profondità di 0 e il 30% aveva una profondità di 1 (leggermente inferiore sui dispositivi mobile). Meno dell'1.8% aveva una profondità di 2, mentre le proprietà con profondità di 3 o più sono pochissime (0,7%), il che indica un utilizzo piuttosto semplice. Il vantaggio di questo utilizzo di base è che è più difficile commettere errori: meno dello 0.5% delle pagine includeva cicli.

{{ figure_markup(
  image="custom-property-depth.png",
  caption="Distribuzione delle profondità delle proprietà personalizzate come percentuale di occorrenze.",
  description="Grafico a barre della distribuzione delle profondità delle proprietà personalizzate come percentuale di occorrenze. Le proprietà personalizzate sulla pagina desktop e mobile hanno una profondità pari a 0 rispettivamente per il 67% e il 60% delle occorrenze. Per una profondità di 1 è 31% e 38%. A una profondità di 2, solo il 2% ciascuno. Circa lo 0% delle occorrenze ha una profondità di 3 o più.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=262191540&format=interactive",
  sheets_gid="1368222498",
  sql_file="custom_property_depth.sql"
) }}

L'esame dei selettori su cui vengono dichiarate le proprietà personalizzate conferma ulteriormente che la maggior parte dell'utilizzo di proprietà personalizzate naturali sono abbastanza semplici. Due delle tre dichiarazioni di proprietà personalizzate si trovano sull'elemento radice, a indicare che vengono utilizzate essenzialmente come costanti globali. È importante notare che molti polyfill popolari hanno richiesto che fossero globali in questo senso, quindi gli sviluppatori che utilizzano tali polyfill potrebbero non aver avuto scelta.

## CSS e JS

Negli ultimi anni, l'interazione tra CSS e JavaScript è cresciuta, non solo impostando e disattivando classi e stili CSS. Quindi quanto usi tecniche come Houdini e tecniche come CSS-in-JS?

### Houdini

Probabilmente avrai già sentito parlare di [Houdini](https://developer.mozilla.org/docs/Web/Houdini). Houdini è un insieme di API di basso livello che espone parti del motore CSS, dando agli sviluppatori il potere di estendere CSS agganciandosi allo stile e al processo di layout del motore di rendering di un browser. Poiché <a hreflang="en" href="https://ishoudinireadyyet.com/">diverse specifiche Houdini sono state fornite nei browser</a>, abbiamo pensato che fosse ora di vedere se sono state effettivamente utilizzate allo stato brado. Risposta breve: no. E ora per la risposta più lunga ...

In primo luogo, abbiamo esaminato le [API Properties e Values](https://developer.mozilla.org/docs/Web/API/CSS/RegisterProperty), che consente agli sviluppatori di registrare una proprietà personalizzata e assegnarle un type, un valore iniziale e impedire che venga ereditato. Uno dei casi d'uso principali è la possibilità di animare le proprietà personalizzate, quindi abbiamo anche esaminato la frequenza con cui le proprietà personalizzate vengono animate.

Come spesso accade con la tecnologia più avanzata, specialmente quando non è supportata in tutti i browser, l'adozione naturale è stata estremamente bassa. È stato riscontrato che solo 32 pagine desktop e 20 pagine per dispositivi mobile avevano proprietà personalizzate registrate, sebbene ciò escluda le proprietà personalizzate registrate ma non applicate al momento della scansione. Solo 325 pagine per dispositivi mobile e 330 pagine desktop (0,00%) utilizzano proprietà personalizzate nelle animazioni e la maggior parte (74%) sembra essere guidata da un <a hreflang="en" href="https://quasar.dev/vue-components/expansion-item">componente Vue</a>. Praticamente nessuno di questi sembra averli registrati, anche se è probabile che l'animazione non fosse attiva al momento della scansione, quindi non era necessario registrare alcun stile di calcolo.

La [Paint API](https://developer.mozilla.org/docs/Web/API/CSS_Painting_API) è una specifica Houdini implementata in modo più ampio che consente agli sviluppatori di creare funzioni CSS personalizzate che restituiscono valori `<image>`, ad es per implementare sfumature o pattern personalizzati. È stato riscontrato che solo 12 pagine utilizzano `paint()`. È stato visualizzato un solo nome del worklet (`hexagon`, `ruler`, `lozenge`, `image-cross`, `grid`, `dashed-line`, `ripple`) per pagina

<a hreflang="en" href="https://github.com/w3c/css-houdini-drafts/blob/master/css-typed-om/README.md">Typed OM</a>, un'altra specifica Houdini, consente l'accesso a valori strutturati invece che alle stringhe di il classico CSS OM. Sembra avere un'adozione notevolmente maggiore rispetto ad altre specifiche Houdini, anche se nel complesso ancora bassa. Viene utilizzato in 9.864 pagine desktop (0.18%) e 6.391 pagine mobile (0.1%). Anche se questo può sembrare basso, per metterlo in prospettiva, questi sono numeri simili all'adozione di `<input type ="date">`! Si noti che, a differenza della maggior parte delle statistiche in questo capitolo, questi numeri riflettono l'utilizzo effettivo e non solo l'inclusione nelle risorse di un sito Web.

### CSS-in-JS

Ci sono state così tante discussioni sui CSS-in-JS che tutti sembrano usarlo.

{{ figure_markup(
  caption="La percentuale di siti che utilizzano un qualsiasi metodo CSS-in-JS.",
  content="2%",
  classes="big-number",
  sheets_gid="1368222498",
  sql_file="css_in_js.sql"
)
}}

Tuttavia, quando abbiamo esaminato l'utilizzo di varie librerie CSS-in-JS, è emerso che solo il 2% circa dei siti web utilizza un metodo CSS-in-JS, con <a hreflang="en" href="https://styled-components.com/">Styled Components</a> che ne rappresentano quasi la metà.

{{ figure_markup(
  image="css-in-js.png",
  caption="Popolarità relativa delle librerie CSS-in-JS come percentuale di occorrenze sulle pagine per dispositivi mobile.",
  description="Grafico a torta della popolarità relativa delle librerie CSS-in-JS come percentuale di occorrenze sulle pagine per dispositivi mobile. I Styled Components costituiscono il 42% delle occorrenze sulle pagine per dispositivi mobile, seguito da Emotion al 30%, Aphrodite al 9%, React JSS all'8%, Glamour al 7%, Styled Jsx al 2% e il resto con meno dell'1% di occorrenze: Radium, React Native for Web, Goober, Merge Styles, Styletron e Fela.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=969014374&format=interactive",
  sheets_gid="1368222498",
  sql_file="css_in_js.sql"
) }}

## Internazionalizzazione

L'inglese, come molte lingue, è scritto in linee orizzontali e i caratteri sono disposti da sinistra a destra. Ma alcune lingue (come l'arabo e l'ebraico) sono scritte principalmente da destra a sinistra e poi ci sono lingue che possono essere scritte in linee verticali, dall'alto verso il basso. Per non parlare delle citazioni da altre lingue. Quindi le cose possono diventare piuttosto complicate. Sia HTML che CSS hanno un modo per gestirlo.

### Direzione

Quando il testo è presentato in linee orizzontali, la maggior parte dei sistemi di scrittura visualizza i caratteri da sinistra a destra. L'urdu, l'arabo e l'ebraico visualizzano i caratteri da destra a sinistra, ad eccezione dei numeri, che vengono scritti da sinistra a destra; sono bidirezionali. Alcuni caratteri, come parentesi, virgolette, punteggiatura, potrebbero essere utilizzati in un contesto da sinistra a destra o da destra a sinistra e si dice che siano direzionalmente neutri. Le cose diventano più complesse quando stringhe di testo di lingue diverse sono nidificate l'una nell'altra: testo inglese contenente una breve citazione in ebraico che contiene alcune parole inglesi, per esempio. L'algoritmo bidirezionale Unicode definisce come disporre i paragrafi di testo con direzione mista, ma deve conoscere la direzione di base del paragrafo.

Per supportare la bidirezionalità, il supporto esplicito per indicare la direzione è disponibile sia in HTML (tramite <a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#the-dir-attribute">l'attributo `dir`</a> e l'<a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdo-element">elemento `<bdo>`</a>) e CSS (la <a hreflang="en" href="https://www.w3.org/TR/css-writing-modes-3/#direction">direzione</a> e la proprietà <a hreflang="en" href="https://www.w3.org/TR/css-writing-modes-3/#unicode-bidi">`unicode-bidi`</a>. Abbiamo esaminato l'utilizzo dei metodi HTML e CSS.

Solo il 12.14% delle pagine su dispositivi mobile (e un simile 10.76% su desktop) imposta l'attributo `dir` sull'elemento `<html>`. Il che va bene: la maggior parte dei sistemi di scrittura nel mondo sono `ltr` e il valore predefinito di `dir` è `ltr`. Delle pagine che hanno impostato `dir` su `<html>`, il 91% lo ha impostato a `ltr` mentre l'8.5% lo ha impostato a `rtl` e lo 0.32% a `auto` (la direzione esplicita è un valore sconosciuto, principalmente utile per i modelli che saranno riempiti con contenuto sconosciuto). Un numero ancora più piccolo, 2.63%, imposta `dir` su `<body>` che su `<html>`. Il che è positivo, perché impostarlo su `<html>` copre anche i contenuti in `<head>`, come `<title>`.

Perché impostare la direzione utilizzando gli attributi HTML anziché lo stile CSS? Uno dei motivi è la separazione delle preoccupazioni: la direzione ha a che fare con il contenuto che è di competenza dell'HTML. È anche una <a hreflang="en" href="https://www.w3.org/International/tutorials/bidi-xhtml/index.en">pratica consigliata</a>: <q> Evita di utilizzare codici di controllo CSS o Unicode per la direzione in cui puoi utilizzare il markup </q>. Dopotutto, il foglio di stile potrebbe non essere caricato e il testo deve comunque essere leggibile.

### Proprietà logiche e fisiche

Molte delle prime proprietà che ci vengono insegnate quando impariamo i CSS, cose come `width`, `height`, `margin-left`,`padding-bottom`, `right` e così via sono basate su una specifica direzione fisica. Tuttavia, quando il contenuto deve essere presentato in più lingue con diverse caratteristiche di direzionalità, queste direzioni fisiche dipendono spesso dalla lingua, ad es. `margin-left` spesso ha bisogno di diventare `margin-right` in una lingua da destra a sinistra come l'arabo. La direzionalità è una caratteristica 2D. Ad esempio, `height` potrebbe dover diventare `width` quando presentiamo il contenuto in scrittura verticale (come il cinese tradizionale).

In passato, l'unica soluzione a questi problemi era un foglio di stile separato con sostituzioni per diversi sistemi di scrittura. Tuttavia, più recentemente i CSS hanno acquisito [proprietà e valori *logici*](https://developer.mozilla.org/docs/Web/CSS/CSS_Logical_Properties) che funzionano proprio come i loro omologhi *fisici* ma sono sensibili alla direzionalità del loro contesto. Ad esempio, invece di `width` potremmo scrivere `inline-size`, e invece di `left` potremmo usare [`inset-inline`](https://developer.mozilla.org/docs/Web/CSS/inset-inline). Oltre alle *proprietà* logiche, ci sono anche parole *chiave* logiche, come `float: inline-start` invece di `float: left`.

Sebbene queste proprietà siano abbastanza <a hreflang="en" href="https://caniuse.com/css-logical-props">ben supportate</a> (con alcune eccezioni), non sono usate molto al di fuori dei fogli di stile del programma utente. Nessuna delle proprietà logiche è stata utilizzata su più dello 0.6% delle pagine. La maggior parte dell'uso era specificare i margin e i padding. Le parole chiave logiche per `text-align` sono state utilizzate nel 2.25% delle pagine, ma a parte questo, nessuna delle altre parole chiave è stata nemmeno incontrata. Ciò è in gran parte guidato dal supporto del browser: `text-align: start` e `end` hanno <a hreflang="en" href="https://caniuse.com/mdn-css_properties_text-align_flow_relative_values_start_and_end">un supporto browser abbastanza buono</a> mentre le parole chiave logiche per `clear` e `float` sono supportati solo in Firefox.

## Supporto del browser

Un problema perenne con la piattaforma web è come introdurre nuove funzionalità ed estendere la piattaforma. CSS ci ha visto passare dai prefissi dei fornitori alle query di funzionalità come un modo migliore per introdurre il cambiamento, quindi abbiamo voluto vedere come venivano utilizzate queste due tecniche.

### Prefissi del fornitore

{{ figure_markup(
  caption="Percentuale di pagine per mobile che utilizzano una funzione con prefisso del fornitore.",
  content="91.05%",
  classes="big-number",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

Anche se il prefisso è ora riconosciuto come una via fallimentare per introdurre funzionalità sperimentali agli sviluppatori, e i browser hanno in gran parte smesso di usarlo, optando invece per i flag, un enorme 91% delle pagine utilizza ancora almeno una funzione con prefisso.

{{ figure_markup(
  image="vendor-prefix-features.png",
  caption="Le funzionalità con prefisso del fornitore più popolari in base al tipo come percentuale delle pagine.",
  description="Grafico a barre delle funzionalità con prefisso del fornitore più popolari in base al tipo come percentuale delle pagine. Desktop e mobile sono molto simili. Il 91% delle pagine per dispositivi mobile utilizza proprietà con prefisso del fornitore, il 77% utilizza parole chiave e pseudo-element, il 65% utilizza funzioni, il 61% utilizza pseudo-class e il 52% utilizza media.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1057411197&format=interactive",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

L'84% delle funzioni del prefisso utilizzate sono proprietà, utilizzate dal 90.76% delle pagine mobile e dall'89.66% delle pagine desktop. Questo è probabilmente un residuo dell'era CSS3 intorno al 2009-2014. Questo è chiaro dai prefissi più popolari, ma dal 2014 nessuno ha avuto bisogno di un prefisso.

{{ figure_markup(
  image="vendor-prefix-properties.png",
  caption="Popolarità relativa delle proprietà più utilizzate con i prefissi dei fornitori, come percentuale di occorrenze.",
  description="Grafico a barre della popolarità relativa delle proprietà più utilizzate con i prefissi dei fornitori, come percentuale di occorrenze. Desktop e dispositivi mobile hanno risultati simili. La proprietà `transform` costituisce il 19% dell'utilizzo del prefisso del fornitore, seguita dal 12% `transition`, 9% `border-radius`, 8% `box-shadow`, 5% `user-select` e `box-sizing`, 4% `animation`, 3% `filter`, 2% ciascuno di `font-smoothing`, `backface-visibility`, `appearance`, e `flex` e 1% di utilizzo per le restanti proprietà: `transform-origin`, `osx-font-smoothing`, `animation-name`, `background-size`, `transition-property`, e `tap-highlight-color`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=859599479&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql",
  width="600",
  height="627"
) }}

Alcuni di questi prefissi, come `-moz-border-radius`, non sono stati utili dal 2011. Ancora più sbalorditivo, altre proprietà prefissate che non sono mai esistite, sono ancora moderatamente comuni, con circa il 9% di tutte le pagine che includono `-o-border-radius`!

Non sorprende che `-webkit-` sia di gran lunga il prefisso più popolare, con metà delle proprietà prefissate che lo utilizzano:

{{ figure_markup(
  image="top-vendor-prefixes.png",
  caption="Popolarità relativa dei prefissi dei fornitori, come percentuale di occorrenze.",
  description="Grafico a barre della popolarità relativa dei prefissi dei fornitori, come percentuale di occorrenze. `-webkit` rappresenta il 49% dell'utilizzo del prefisso del fornitore sulle pagine mobili, `-moz` 23%, `-ms` 19%, `-o` 8%, `-khtml` 1% e 0% per `-pie`, `-js` e `-ie`. Lo stesso vale per il desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=702800205&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql"
) }}

Le pseudo-class prefissate non sono così comuni come le proprietà, e nessuna di esse viene utilizzata in più del 10% delle pagine. Quasi due terzi di tutte le pseudo-class prefissate nel complesso sono per lo styling dei placeholders. Al contrario, la pseudo-class standard `:placeholder-shown` è usata a malapena, riscontrata in meno dello 0.34% delle pagine.

{{ figure_markup(
  image="vendor-prefix-pseudo-classes.png",
  caption="Le pseudo-class con prefisso del fornitore più popolari come percentuale delle pagine.",
  description="Grafico a barre delle pseudo-class con prefisso del fornitore più popolari come percentuale di pagine. `:ms-input-placeholder` viene utilizzato sul 10% delle pagine per dispositivi mobili,`:-moz-placeholder` 8%, `:-mox-focusring` 2% e 1% o meno per quanto segue: `:-webkit-full-screen`, :-moz-full-screen, :-moz-any-link, `:-webkit-autofill`, `:-o-prefocus,` `:-ms-fullscreen`, `:-ms-input-placeholder` [sic], `:-ms-lang`, `:-moz-ui-invalid`, `:-webkit-input-placeholder`, `:-moz-input-placeholder`, e `:-webkit-any-link`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1884876858&format=interactive",
  sheets_gid="1477158006",
  width="600",
  height="650",
  sql_file="vendor_prefix_pseudo_classes.sql"
) }}

Lo pseudo-element con prefisso più comune è `::-moz-focus-inner`, usato per disabilitare l'inner focus ring di Firefox. Costituisce quasi un quarto degli pseudo-element prefissati e per i quali non esiste un'alternativa standard. Un altro quarto degli pseudo-element prefissati è ancora una volta per lo styling dei placeholders, mentre la versione standard, `::placeholder`, è in ritardo, usata solo nel 4% delle pagine.

La restante metà degli pseudo-element prefissati è principalmente dedicata allo stile delle barre di scorrimento e Shadow DOM di elementi nativi (input di ricerca, controlli video e audio, spinner button, sliders, meters, progress bar). Ciò dimostra una forte esigenza degli sviluppatori per la personalizzazione del controllo dell'interfaccia utente incorporata basata su standard, sebbene il CSS basato su standard sia ancora inadeguato.

{{ figure_markup(
  image="vendor-prefix-pseudo-elements.png",
  caption="Utilizzo di pseudo-element con prefisso per categoria.",
  description="Grafico a barre della popolarità relativa degli pseudo-element con prefisso del fornitore in base al loro scopo come percentuale di occorrenze. placeholder viene utilizzato nel 29% delle occorrenze prefissate, focus ring 21%, scrollbar 11%, search input 10%, media control 8%, spinner 7%, other, selection, slider, clear button tutto al 3%, progress bar 2% , file upload 1% e il resto con una popolarità relativa di circa lo 0% sulle pagine per dispositivi mobile: date picker, validation, meter, details marker, and resizer.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013685965&format=interactive",
  sheets_gid="1466863581",
  width="600",
  height="566",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

Non è un segreto che Chrome e Safari siano stati molto più soddisfatti dei prefissi, ma è particolarmente vero con gli pseudo-element: quasi la metà di tutti gli pseudo-element con prefisso che abbiamo trovato aveva un prefisso `-webkit-`.

{{ figure_markup(
  image="top-pseudo-element-prefixes.png",
  caption="Popolarità relativa dei prefissi dei fornitori di pseudo-elementi come percentuale di occorrenze sulle pagine per dispositivi mobile.",
  description="Grafico a torta della popolarità relativa dei prefissi dei fornitori di pseudo-element come percentuale di occorrenze sulle pagine per dispositivi mobile. `-webkit` rappresenta il 47% dell'utilizzo del prefisso del fornitore di pseudo-element, seguito da, 26% `-moz`, 15% `-ms`, 7% `-o` e 6% altro.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=744523431&format=interactive",
  sheets_gid="1466863581",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

Quasi tutto l'uso di funzioni con prefisso (98%) è per specificare i gradienti, anche se <a hreflang="en" href="https://caniuse.com/css-gradients">questo non è stato necessario dal 2014</a>. Il più popolare di questi è `-webkit-linear-gradient()` usato in oltre un quarto delle pagine esaminate. Il restante <2% è principalmente per calc, <a hreflang="en" href="https://caniuse.com/calc">per il quale non è stato necessario un prefisso dal 2013</a>.

{{ figure_markup(
  caption="Percentuale di funzioni gradiente in tutte le occorrenze di funzioni con prefisso fornitore nelle pagine per dispositivi mobile.",
  content="98.22%",
  classes="big-number",
  sheets_gid="1586213539",
  sql_file="vendor_prefix_functions.sql"
) }}

L'utilizzo delle funzionalità multimediale con prefisso è complessivamente inferiore, con la più popolare, `-webkit-min-pixel-ratio`, utilizzata nel 13% delle pagine per rilevare i display "Retina". La corrispondente funzionalità multimediale standard, [`resolution`](https://developer.mozilla.org/docs/Web/CSS/@media/resolution) l'ha finalmente superata in popolarità ed è usata nel 22% degli pagine per dispositivi mobile e il 15% di pagine desktop.

Complessivamente, `-*-min-pixel-ratio` comprende tre quarti delle funzionalità multimediali con prefisso su desktop e circa la metà su dispositivi mobile. La ragione della differenza non è il ridotto utilizzo dei dispositivi mobile, ma il fatto che un'altra funzione multimediale con prefisso, `-*-high-contrast`, è molto più popolare sui dispositivi mobile e rappresenta quasi tutta l'altra metà delle funzioni multimediali con prefisso, ma solo il 18% su desktop. La funzione multimediale standard corrispondente, [forced-colors](https://developer.mozilla.org/docs/Web/CSS/@media/forced-colors) è ancora sperimentale in Chrome e Firefox.

{{ figure_markup(
  image="vendor-prefixed-media.png",
  caption="Popolarità relativa delle funzionalità multimediali con prefisso del fornitore come percentuale di occorrenze sulle pagine per dispositivi mobile.",
  description="Grafico a torta della popolarità relativa delle funzionalità multimediali con prefisso del fornitore come percentuale di occorrenze sulle pagine per dispositivi mobile. `min-device-pixel-ratio` e `high-contrast` costituiscono ciascuno il 47% delle occorrenze, `transform-3d` al 5% e le restanti caratteristiche inferiori all'1% sono `device-pixel-ratio`, `max-device-pixel-ratio`, e altre funzionalità.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1940027848&format=interactive",
  sheets_gid="1192245087",
  sql_file="vendor_prefix_media.sql"
) }}

### Le funzionalità delle query

Le funzionalità delle query ([@supports](https://developer.mozilla.org/docs/Web/CSS/@supports)) stanno guadagnando terreno negli ultimi anni e sono state utilizzate nel 39% dei pagine, in notevole aumento rispetto al 30% dello scorso anno.

Ma a cosa servono? Abbiamo esaminato le query più popolari. Il risultato è stato sorprendente. Ci aspettavamo che le query relative a Grid fossero in cima alla lista, ma invece, le funzionalità delle query più popolari sono di gran lunga per `position: sticky`! Comprendono la metà di tutte le funzionalità delle query e vengono utilizzate in circa un quarto delle pagine. Al contrario, le query relative a Grid rappresentano solo il 2% di tutte le query, indicando che gli sviluppatori si sentono abbastanza a loro agio con il supporto del browser di Grid da non aver bisogno di usarlo solo come miglioramento progressivo.

Ciò che è ancora più misterioso è che `position: sticky` stesso non viene utilizzato tanto quanto le funzionalità su di esso, che appare nel 10% delle pagine desktop e nel 13% delle pagine mobile. Quindi ci sono oltre mezzo milione di pagine che rilevano `position: sticky` senza mai usarlo! Perché?!

Infine, è stato incoraggiante vedere `max()` già tra le prime 10 funzionalità più rilevate, che compare nello 0.6% delle pagine desktop e nello 0.7% delle pagine mobile. Dato che `max()` (e `min()` e `clamp()`) erano <a hreflang="en" href="https://caniuse.com/mdn-css_types_max">supportati solo su tutta la linea quest'anno</a>, è abbastanza impressionante l'adozione e sottolinea quanto disperatamente gli sviluppatori ne avessero bisogno.

Un piccolo ma notevole numero di pagine (circa 3000 o 0.05%) utilizzava stranamente `@supports` con la sintassi CSS 2, come `display: block` o `padding: 0px`, sintassi che esisteva ben prima che fosse implementato `@supports`. Non è chiaro cosa intendesse ottenere. Forse è stato usato per proteggere le regole CSS dai vecchi browser che non implementano i `@support`?

{{ figure_markup(
  image="supports-criteria.png",
  caption="Popolarità relativa delle funzionalità delle query @supports come percentuale di occorrenze.",
  description="Grafico a barre della popolarità relativa delle funzionalità delle query @supports come percentuale di occorrenze. La funzionalità più popolare è `sticky` al 49% delle occorrenze su pagine mobile, seguita da `ime-align` al 24%, `mask-image` al 12%, `overflow-scrolling` al 5%, `grid` al 2%, proprietà personalizzate, `transform-style`, `max()` e `object-fit` tutto all'1% e `appearance` a circa 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1901533222&format=interactive",
  sheets_gid="1155233487",
  sql_file="supports_criteria.sql"
) }}

## Meta

Finora abbiamo esaminato cosa hanno usato gli sviluppatori CSS, ma in questa sezione vogliamo approfondire _come_ lo stanno usando.

### Ripetizione della dichiarazione

Uno dei fattori generali per sapere quanto sia efficiente e manutenibile un foglio di stile è la ripetizione di dichiarazioni, cioè il rapporto tra dichiarazioni uniche (diverse) e numero totale di dichiarazioni. Questo fattore è approssimativo e normalizzare la dichiarazione non è banale (`border: none`, `border: 0`, `border-width: 0`, `border-width: 0`.). Inoltre, le iterazioni hanno livelli come le media query (più utili ma difficili da misurare), fogli di stile e livelli di set di dati come le metriche generali di Almanac.

Abbiamo esaminato la ripetizione delle dichiarazioni e abbiamo scoperto che la pagina web mediana, sui dispositivi mobile, utilizza un totale di 5.454 dichiarazioni, di cui 2.398 uniche. Il rapporto mediano (che si basa sul set di dati, non su questi due valori) è del 45.43%. Ciò significa che nella pagina mediana ogni dichiarazione viene utilizzata all'incirca due volte.

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>Unico / Totale</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">30.97%</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">45.43%</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">63.67%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Distribuzione dei rapporti di ripetizione sulle pagine mobile.",
      sheets_gid="2124098640",
      sql_file="repetition.sql"
    ) }}
  </figcaption>
</figure>

Questi rapporti sono quindi migliori di quanto sappiamo da dati storici scarsi. Nel 2017, Jens Oliver Meiert <a hreflang="en" href="https://meiert.com/en/blog/70-percent-css-repetition/">ha campionato 220 siti web popolari</a> e ha ottenuto le seguenti medie: 6.121 dichiarazioni, di cui 1.698 uniche e un rapporto unico/totale del 28% (mediana 34%). L'argomento potrebbe richiedere ulteriori indagini, ma dal poco che sappiamo finora, la ripetizione della dichiarazione è tangibile e potrebbe essere migliorata o essere più un problema per i siti più popolari e probabilmente più grandi.

### Shorthand e forma completa

Alcune shorthand (scorciatoie) hanno più successo di altre. A volte lo shorthand è abbastanza facile da usare e la sua sintassi è facile da ricordare, quindi se vuoi sovrascrivere un particolare valore in modo indipendente, puoi usare intenzionalmente solo la forma completa. Ci sono anche shorthand che vengono usate raramente perché la sintassi è confusa.

#### Shorthand prima della forma completa

Alcune shorthand hanno più successo di altre. A volte la shorthand è abbastanza facile da usare e la sua sintassi è facile da ricordare, quindi se vuoi sovrascrivere un particolare valore in modo indipendente, puoi usare intenzionalmente solo la forma completa. Ci sono anche shorthand che vengono usate raramente perché la sintassi è così confusa. Usare shorthand e sovrascriverle con alcune affermazioni usuali all'interno della stessa regola è una buona strategia per una serie di ragioni.

Innanzitutto, è una buona codifica difensiva. La shorthand ripristina tutte le forme complete ai valori predefiniti, a meno che non sia esplicitamente specificato. Ciò impedisce che valori errati entrino attraverso della cascade.

In secondo luogo, è utile per la manutenibilità, per evitare la ripetizione di valori quando la shorthand ha impostazioni predefinite intelligenti. Ad esempio, invece di `margin: 1em 1em 0 1em` possiamo scrivere:

```css
margin: 1em;
margin-bottom: 0;
```

Allo stesso modo, per le proprietà dei valori di elenco, se tutti i valori di elenco hanno lo stesso valore, è possibile utilizzare la forma completa per ridurre la ripetizione.

```css
background: url("one.png"), url("two.png"), url("three.png");
background-repeat: no-repeat;
```
Terzo, se alcune delle sintassi delle shorthand sono troppo strane, la forma completa può aiutare a migliorare la leggibilità.

```css
/* Invece di: */
background: url("one.svg") center / 50% 50% content-box border-box;

/* Questo è più leggibile: */
background: url("one.svg") center;
background-size: 50% 50%;
background-origin: content-box;
background-clip: border-box;
```

Quindi con che frequenza si verifica questo? Molto, a quanto pare. L'88% delle pagine utilizza questa strategia almeno una volta. Di gran lunga, la forma completa più frequente con cui questo accade è `background-size`, che rappresenta il 40% di tutte le forme complete che vengono dopo la loro shorthand, indicando che la sintassi della barra per `background-size` in `background` potrebbe non essere stata la sintassi più leggibile o memorabile che avremmo potuto trovare. Nessun altra forma completa si avvicina a questa frequenza. Il restante 60% è una coda lunga distribuita uniformemente su molte altre proprietà.

{{ figure_markup(
  image="most-popular-longhand-after-shorthand.png",
  caption="Le forme complete più popolari che vengono dopo le abbreviazioni nella stessa regola.",
  description="Grafico a barre che mostra `background-size` al 15% per desktop e 41% per mobile, `background-image` rispettivamente all'8% e al 6%, `margin-bottom` al 6% e 4%, `margin-top` a 6% e 4%, `border-bottom-color` al 5% e 3%, `font-size` al 4% e 3%, `border-top-color` al 4% e 3%, `background-color` al 4% e al 2%, `padding-left` al 3% e al 2% e infine `margin-left` al 3% e al 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=176504610&format=interactive",
  sheets_gid="17890636",
  sql_file="meta_shorthand_first_properties.sql",
  width="600",
  height="429"
) }}

#### font

La shorthand `font` è abbastanza popolare (usata 49 milioni di volte sull'80% delle pagine) ma usata molto meno della maggior parte delle sue forme complete (eccetto `font-variant` e `font-stretch`). Ciò indica che la maggior parte degli sviluppatori è a proprio agio nell'usarlo (dal momento che appare su così tanti siti Web). Gli sviluppatori spesso hanno bisogno di sovrascrivere aspetti tipografici specifici sulle regole discendenti, il che probabilmente spiega perché le forme complete sono usati molto di più.

{{ figure_markup(
  image="font-shorthands.png",
  caption="Adozione delle proprietà shorthand e forme complete di `font`.",
  description="Grafico a barre che mostra l'adozione delle proprietà shorthand e forme complete dei font. Le proprietà più utilizzate sono forme complete che vanno dal 95% al 92% delle pagine per dispositivi mobile in ordine decrescente: font-weight, font-family, font-size, line-height, e font-style. La shorthand dei font viene utilizzata sull'80% delle pagine mobile. I font a forma completa meno utilizzati sono la font-variant al 43% e font-stretch all'8%. L'adozione è simile su desktop e dispositivi mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1455030576&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### background

Essendo uno degli shorthands più vecchi, anche `background` è molto utilizzato, comparendo 1 miliardo di volte nel 92% delle pagine. è usato più frequentemente di uno qualsiasi delle sue forme complete eccetto `background-color`, che è usato 1.5 miliardi di volte, in circa lo stesso numero di pagine. Tuttavia, questo non significa che gli sviluppatori siano completamente a proprio agio con tutta la sua sintassi: quasi tutto (>90%) l'utilizzo di `background` è molto semplice, con uno o due valori, molto probabilmente colori e immagini o immagini e posizioni. Per qualsiasi altra cosa, le forme complete sono viste come più autoesplicative.

{{ figure_markup(
  image="background-shorthand-versus-longhand.png",
  caption="Confronto di utilizzo della shorthand `background` e delle sue forme complete.",
  description="Grafico a barre che mostra `background` è del 91% su desktop e 92% su dispositivi mobile, `background-color` è rispettivamente del 91% e del 92%, `background-image` è dell'85% e dell'87%, `background-position` è dell'84% e 85%, `background-repeat` è 82% e 84%, `background-size` è 77% e 79%, `background-clip` è 48% e 53%, `background-attachment` è 37% e 38 %, `background-origin` è del 5% su desktop e del 12% su dispositivi mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2014923335&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="429"
) }}

#### Margin e padding

Sia le shorthand `margin` che `padding`, così come le loro forme complete, erano alcune delle proprietà CSS più utilizzate. È molto più probabile che padding sia specificato come shorthand (1.5B usi di `padding` contro 300-400M per ogni shorthand), mentre c'è meno differenza per il margin (1,1B usi di `margin` contro 500-800M per ciascuna delle sue forme complete). Data la confusione iniziale di molti sviluppatori CSS circa l'ordine dei valori in senso orario in queste shorthand e la regola di ripetizione per 2 o 3 valori, ci aspettavamo che la maggior parte di questi usi delle shorthand sarebbe stata semplice (1 valore), tuttavia abbiamo visto l'intero intervallo di 1,2,3 o 4 valori. Ovviamente 1 o 2 valori erano più comuni, ma 3 o 4 non erano affatto rari, poiché si verificavano in oltre il 25% degli usi di `margin` e in oltre il 10% dell'utilizzo di `padding`.

{{ figure_markup(
  image="margin-padding-shorthand-vs-longhand.png",
  caption="Confronto dell'utilizzo delle shorthand `margin` e `padding` e delle loro forme complete.",
  description="Il grafico a barre che mostra `padding` è del 93% su desktop, 94% su dispositivi mobile, `margin` è rispettivamente 93% e 93%, `margin-left` è 91% e 92%, `margin-top` è 90% e 91 %, `margin-right` è 90% e 91%, `margin-bottom` è 90% e 91%, `padding-left` è 90% e 90%, `padding-top` è 88% e 89%, `padding-bottom` è 88% e 89% e `padding-right` è 87% e 88%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=804317202&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Flex

Quasi tutte le proprietà `flex`, `flex-*` sono molto usate e appaiono nel 30-60% delle pagine. Tuttavia, sia `flex-wrap` che `flex-direction` sono usati molto più della loro shorthand, `flex-flow`. Quando viene utilizzato `flex-flow`, viene utilizzato con due valori, ovvero come un modo più breve per impostare entrambe le forme complete. Nonostante gli [elaborati valori predefiniti ragionevoli](https://developer.mozilla.org/docs/Web/CSS/flex#syntax) per l'uso di `flex` con uno o due valori, circa il 90% dell'utilizzo consiste nella sintassi dei 3 valori, impostando esplicitamente tutti e tre delle sue forme complete.

{{ figure_markup(
  image="flex-shorthand-vs-longhand.png",
  caption="Confronto di utilizzo delle shorthand flex e delle loro forme complete.",
  description="Il grafico a barre che mostra `flex-direction` è del 55% su desktop e 60% su mobile, `flex-wrap` è rispettivamente del 55% e del 58%, `flex` è del 52% e del 56%, `flex-grow` è del 44% e 52%, `flex-basis` è 40% e 44%, `flex-shrink` è 28% e 37%, `flex-flow` è 27% e 30%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=930720666&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Grid

Sapevi che `grid-template-columns`, `grid-template-rows` e `grid-template-areas` sono in realtà shorthand di `grid-template`? Sapevi che esiste una proprietà `grid` e tutte queste sono alcune delle sue forme complete? No? Bene, sei il solo a pensarlo: nemmeno la maggior parte degli sviluppatori. La proprietà `grid` è stata utilizzata solo in 5.279 siti web (0.08%) e `grid-template` su 8.215 siti web (0.13%). In confronto, `grid-template-columns` viene utilizzato in 1.7 milioni di siti Web, oltre 200 volte di più!

{{ figure_markup(
  image="usage-of-grid-properties.png",
  caption="Confronto di utilizzo delle shorthand grid e delle loro forme complete.",
  description="Il grafico a barre che mostra `grid-template-columns` è del 27% su desktop e 26% su mobile, `grid-template-rows` è rispettivamente 24% e 24%, `grid-column` è 20% e 20%, `grid-row` è 20% e 19%, `grid-area` è 6% e 6%, `grid-template-areas` è 6% e 6%, `grid-gap` è 4% e 5%, `grid -column-gap` è 4% e 3%, `grid-row-gap` è 3% e 3%, `grid-column-end` è 3% e 2%, `grid-column-start` è 3% e 2%, `grid-row-start` è 3% e 2%, `grid-row-end` è 2% e 2%, `grid-auto-columns` è 2% e 2%, `grid-auto-rows` è 1% e 1%, `grid-auto-flow` è 1% e 1%, `grid-template` è 0% e 0%, `grid` è 0% e 0%, `grid-column-span` è 0% e 0%, `grid-columns` è 0% e 0% e `grid-rows` è 0% e 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=290183398&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="575"
) }}

### Errori CSS

Come con qualsiasi piattaforma complessa e in evoluzione, non tutto è fatto correttamente. Quindi diamo un'occhiata ad alcuni degli errori che gli sviluppatori stanno facendo là fuori.

#### Errori di sintassi

Per la maggior parte delle metriche in questo capitolo, abbiamo utilizzato <a hreflang="en" href="https://github.com/reworkcss/css">Rework</a>, un parser CSS. Anche se questo aiuta a migliorare notevolmente la precisione, significa anche che potremmo essere meno indulgenti degli errori di sintassi rispetto a un browser. Anche se una dichiarazione nell'intero foglio di stile ha un errore di sintassi, l'analisi fallirà e quel foglio di stile rimarrebbe escluso dall'analisi. Ma quanti fogli di stile contengono tali errori di sintassi? Si scopre sostanzialmente più sul desktop che sul mobile! Più specificamente, quasi il 10% dei fogli di stile trovati nelle pagine desktop includeva almeno un errore di sintassi irrecuperabile, mentre solo il 2% dei dispositivi mobile. Si noti che questi sono essenzialmente limiti inferiori per gli errori di sintassi, poiché non tutti gli errori di sintassi effettivamente causano il fallimento dell'analisi. Ad esempio, un punto e virgola mancante comporterebbe semplicemente che la dichiarazione successiva venga analizzata come parte del valore (ad esempio `{property: "color", value: "red background: yellow"}`), non causerebbe il fallimento del parser.

#### Proprietà inesistenti

Abbiamo anche esaminato le proprietà inesistenti più comuni, utilizzando un elenco di proprietà note. Abbiamo escluso le proprietà con prefisso da questa parte dell'analisi ed escluso manualmente le proprietà proprietarie non prefissate (ad esempio il `behavior` di Internet Explorer, che stranamente appare ancora su 200.000 siti web). Delle rimanenti proprietà inesistenti:

- Il 37% di loro era una forma alterata di una proprietà con prefisso (ad es. `webkit-Transition` o `-transition`)
- Il 43% era una forma non prefissata di una proprietà che esiste solo con un prefisso (ad esempio `font-smoothing`, che appariva su 384K siti web), probabilmente inclusa per compatibilità sotto l'errato presupposto che sia standard, o a causa di un pio desiderio che diventerà standard.
- Un errore di battitura che ha trovato la sua strada in una libreria popolare. Attraverso questa analisi, abbiamo scoperto che la proprietà `white-wpace` era presente in 234.027 siti web. Ci sono troppi siti Web perché lo stesso errore di battitura si sia verificato in modo organico, quindi abbiamo deciso di esaminarlo. Ed ecco, [si scopre](https://twitter.com/rick_viscomi/status/1326739379533000704) era il widget di Facebook! La correzione è già in atto.
- E un'altra stranezza: la proprietà `font-rendering` appare su 2.575 pagine. Tuttavia, non possiamo trovare prove dell'esistenza di tale proprietà, con o senza un prefisso. C'è il non standard <a hreflang="en" href="https://medium.com/better-programming/improving-font-rendering-with-css-3383fc358cbc">`-webkit-font-smoothing`</a> che è molto popolare, comparendo in 3 milioni di siti web, o circa il 49% delle pagine, ma `font-rendering` non è sufficientemente vicino per essere un errore di ortografia. C'è [`text-rendering`](https://developer.mozilla.org/docs/Web/CSS/text-rendering) che viene utilizzato in circa 100K di siti web, quindi è concepibile che 2.5K tutti gli sviluppatori abbiano erroneamente scambiato `font-smoothing` e `text-rendering`.

{{ figure_markup(
  image="most-popupular-unknown-properties.png",
  caption="Proprietà sconosciute più popolari.",
  description="Il grafico a barre che mostra `webkit-Transition` è del 15% su desktop e del 14% su dispositivi mobile, `font-smoothing` è rispettivamente del 13% e del 12%, `user-drag` è del 12% su dispositivi mobili, `white-wpace` è 10 % su dispositivi mobile, `tap-highlight-color` è 10% e 10%, `webkit-box-shadow` è 4% e 4%, `ms-transform` è 2% e 2%, `-transition` è 1 % e 1%, `font-rendering` è 0% e 0%, `webkit-border-radius` è 2% su desktop e `moz-border-radius` è 2% su desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1166982997&format=interactive",
  sheets_gid="84286607",
  sql_file="meta_unknown_properties.sql",
  width="600",
  height="401"
) }}

#### Forma completa prima della shorthand

Usare le forme complete dopo le shorthand è un bel modo per usare i valori predefiniti e sovrascrivere alcune proprietà. È particolarmente utile con le proprietà con valori di list, dove l'uso di una forma completa ci aiuta a evitare di ripetere lo stesso valore più volte. L'opposto d'altra parte, usare le forme complete prima degli shorthands, è sempre un errore, poiché la shorthand sovrascriverà la forma completa. Ad esempio, dai un'occhiata a questo:

```css
background-color: rebeccapurple; /* Forma completa */
background: linear-gradient(white, transparent); /* shorthand */
```

Questo non produrrà un gradiente da `white` a `rebeccapurple`, ma da `white` a `transparent`. Il colore di sfondo `rebeccapurple` verrà sovrascritto dalla shorthand `background` che viene dopo di esso che ripristina tutte le sue forme complete ai valori iniziali.

Ci sono due ragioni principali per cui gli sviluppatori commettono questo tipo di errore: o un malinteso su come funzionano gli shorthand e quale forma completa viene ripristinata da quale shorthand, o semplicemente il cruft rimanente dopo aver spostato la dichiarazione.

Quindi quanto è comune questo errore? Sicuramente, non può essere così comune nei primi 6 milioni di siti Web, giusto? Sbagliato! Si scopre che è estremamente comune, si verifica almeno una volta nel 54% dei siti web!

Questo tipo di confusione sembra accadere molto più con la shorthand `background` che con qualsiasi altra shorthand: oltre la metà (55%) di questi errori implica mettere forma completa `background-*` prima di `background`. In questo caso, potrebbe non essere affatto un errore, ma un buon miglioramento progressivo: i browser che non supportano una funzione, come i linear gradient, renderanno i valori a forma completa definiti in precedenza, in questo caso, un background color. I browser che comprendono la shorthand sovrascrivono il valore della forma completa, implicitamente o esplicitamente.

{{ figure_markup(
  image="most-popupular-shorthands-after-longhands.png",
  caption="Le shorthand più popolari dopo le forme complete.",
  description="Grafico a barre che mostra `background` è il 56.46% del desktop e il 55.17% dei dispositivi mobile, `margin` è rispettivamente del 12.51% e del 12.18%, `font` è del 10.15% e del 10.31%, `padding` dell'8.36% e del 7.87%, `border-radius` è 1.08% e 3.14%, `animation` è 3.18% e 3.05%, `list-style` è 2.09% e 2.00% e `transition` è 1.09% e 0.98%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1389278729&format=interactive",
  sheets_gid="1143644053",
  sql_file="meta_longhand_first_properties.sql"
) }}

## Sass

Mentre l'analisi del codice CSS ci dice cosa stanno facendo gli sviluppatori CSS, guardare il codice del preprocessore può dirci qualcosa su ciò che gli sviluppatori CSS vogliono fare, ma non possono, il che in qualche modo è interessante. Sass è costituito da due sintassi: Sass, che è più minimale, e SCSS, che è più vicino a CSS. Il primo sta perdendo di popolarità e oggi non è molto utilizzato, quindi abbiamo considerato solo il secondo. Abbiamo utilizzato file CSS con mappe di origine per estrarre e analizzare fogli di stile SCSS classico. Abbiamo scelto di guardare SCSS perché è la sintassi di pre-elaborazione più popolare, basata sulla nostra analisi delle mappe di origine.

Sappiamo da tempo che gli sviluppatori necessitano di funzioni di modifica del colore e ci stanno lavorando in <a hreflang="en" href="https://drafts.csswg.org/css-color-5/">CSS Color 5</a>. Tuttavia, l'analisi delle chiamate di funzione SCSS ci fornisce dati concreti per dimostrare quanto siano necessarie le funzioni di modifica del colore e ci dice anche quali tipi di modifiche del colore sono più comunemente necessarie.

Complessivamente, oltre un terzo di tutte le chiamate alla funzione Sass serve per modificare i colori o estrarre i componenti del colore. Praticamente tutte le modifiche di colore che abbiamo trovato erano piuttosto semplici. La metà doveva rendere i colori più scuri. In effetti, `darken()` era la chiamata alla funzione Sass più popolare in assoluto, usata anche più del generico `if()`! Sembra che una strategia comune sia quella di definire i colori di base luminosi e usare `darken()` per creare variazioni più scure. Renderle più leggere, invece, è meno comune, con solo il 5% delle chiamate di funzione che sono `lighten()`, sebbene quella fosse ancora la sesta funzione più popolare in generale. Le funzioni che cambiano il canale alfa erano circa il 4% delle chiamate di funzione complessive e la miscelazione dei colori costituisce il 3.5% di tutte le chiamate di funzione. Altri tipi di modifiche del colore come la regolazione della tonalità, della saturazione, dei canali rosso/verde/blu, o la più complessa `adjust-color()` sono stati usati con molta parsimonia.

{{ figure_markup(
  image="most-popupular-sass-function-calls.png",
  caption="Chiamate di funzione Sass più popolari.",
  description="Il grafico a barre che mostra `(other)` è utilizzato al 23% su desktop e al 23% su dispositivi mobile, `darken` è rispettivamente del 17% e del 18%, `if` è del 14% e del 14%, `map-keys` è dell'8% e 9%, `percentuale` è 8% e 8%, `map-get` è 8% e 7%, `lighten` è 5% e 6%, `nth` è 5% e 5%, `mix` è 4% e 4%, `length` è 3% e 3%, `type-of` è 2% e 2% e `(alpha adjustment)` 2% su desktop e 2% su dispositivo mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=774248494&format=interactive",
  sheets_gid="170555219",
  sql_file="sass_function_calls.sql"
) }}

La definizione di funzioni personalizzate è qualcosa <a hreflang="en" href="https://github.com/w3c/css-houdini-drafts/issues/857">discusso per anni in Houdini</a>, ma studiare i fogli di stile Sass ci fornisce dati su quanto sia comune la necessità. Si scopre che è abbastanza comune. Almeno la metà dei fogli di stile SCSS studiati contiene funzioni personalizzate, poiché il foglio SCSS mediano contiene non una, ma due funzioni personalizzate.

Ci sono anche <a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5009">recenti</a> <a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5624">discussioni</a> nel CSS WG sull'introduzione di una forma limitata di condizionali e Sass ci fornisce alcuni dati su quanto comunemente questo sia necessario. Quasi due terzi dei fogli SCSS contengono almeno un blocco `@if`, che costituisce quasi due terzi di tutte le istruzioni del flusso di controllo. Esiste anche una funzione `if()` per i condizionali all'interno dei valori, che è la seconda funzione più comune utilizzata in generale (14%).

{{ figure_markup(
  image="usage-of-control-flow-statements-scss.png",
  caption="Utilizzo delle istruzioni del flusso di controllo in SCSS.",
  description="Il grafico a barre che mostra `@if` è utilizzato sul 63% dei desktop e del 63% sui dispositivi mobile, `@for` è rispettivamente del 55% e del 55%, `@each` è del 54% e del 55% e `@while` è 2 % e 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=157473209&format=interactive",
  sheets_gid="498478750",
  sql_file="sass_control_flow_statements.sql"
) }}

Un'altra specifica futura su cui si sta attualmente lavorando è <a hreflang="en" href="https://drafts.csswg.org/css-nesting/">CSS Nesting</a>, che ci permetterà di annidare regole all'interno di altre regole in modo simile a quello che possiamo fare in Sass e altri preprocessori utilizzando `&`. Con che frequenza viene utilizzato l'annidamento nei fogli SCSS? Molto. La stragrande maggioranza dei fogli SCSS utilizza almeno un selettore nidificato esplicitamente, con pseudo-class (ad esempio `&: hover`) e classi (ad esempio `&.active`) che ne costituiscono i tre quarti. E questo non tiene conto della nidificazione implicita, in cui si presume un discendente e il carattere `&` non è richiesto.

{{ figure_markup(
  image="usage-of-explicit-nesting-in-scss.png",
  caption="Utilizzo della nidificazione esplicita in SCSS.",
  description="Il grafico a barre che mostra `Total` è utilizzato dall'85% su desktop e dall'85% su dispositivi mobile, `&:pseudo-class` è rispettivamente dell'83% e dell'83%, `&.class` è dell'80% e dell'80%, `&::pseudo-element` è 66% e 66%, `& (by itself)` è 62% e 62%, `&[attr]` è 57% e 57%, `& >` 24% e 23%, `& +` 21% e 20%, `& descendant` è 16% e 15% e `&#id` è 6% su desktop e 6% su dispositivo mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=370242263&format=interactive",
  sheets_gid="1872903377",
  sql_file="sass_nesting.sql"
) }}

## Conclusione

Whew! Erano molti dati! Ci auguriamo che tu l'abbia trovato interessante come noi, e forse ti sei persino formato le tue intuizioni su alcuni di essi.

Uno dei nostri suggerimenti è stato che le librerie popolari come WordPress, Bootstrap e Font Awesome sono i driver principali dietro l'adozione di nuove funzionalità, mentre i singoli sviluppatori tendono ad essere più conservatori.

Un'altra osservazione è che sul Web c'è più codice vecchio che codice nuovo. Il web in pratica copre una vasta gamma, dal codice che avrebbe potuto essere scritto 20 anni fa alla tecnologia all'avanguardia che funziona solo nei browser più recenti. Ciò che questo studio ci ha mostrato, tuttavia, è che ci sono potenti funzionalità che sono spesso fraintese e sottoutilizzate, nonostante una buona interoperabilità.

Ci ha anche mostrato alcuni dei modi in cui gli sviluppatori desiderano utilizzare i CSS ma non possono e ci ha fornito alcune informazioni su ciò che trovano confuse. Alcuni di questi dati verranno riportati al CSS WG per aiutare a guidare l'evoluzione dei CSS, perché le decisioni guidate dai dati sono il miglior tipo di decisioni.

Siamo entusiasti dei modi in cui questa analisi potrebbe avere un ulteriore impatto sul modo in cui sviluppiamo i siti web e non vediamo l'ora di vedere come queste metriche si svilupperanno nel tempo!
