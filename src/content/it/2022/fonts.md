---
##See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Font
description: Capitolo sui font del Web Almanac 2022 che tratta i seguenti argomenti&colon; da dove vengono serviti i font, i formati di font, le prestazioni di caricamento dei font, i font variabili e i font a colori.
hero_alt: Hero image of Web Almanac chracters on an assembly line preparing various F letters in various styles and shapes.
authors: [bramstein]
reviewers: [alexnj, jmsole, RoelN, svgeesus]
analysts: [bramstein, konfirmed]
editors: [shantsis]
translators: [webmatter-it]
bramstein_bio: Bram Stein è uno sviluppatore e product manager. È molto appassionato di tipografia ed si trova a suo agio nel lavorare all'intersezione tra design e tecnologia. È autore del manuale <a hreflang="en" href="https://abookapart.com/products/webfont-handbook">Webfont Handbook</a> edito da A Book Apart e della libreria software <a hreflang="en" href="https://fontfaceobserver.com">FontFace Observer</a>. Inoltre parla di tipografia e performance web in conferenze in tutto il mondo.
results: https://docs.google.com/spreadsheets/d/1A1XwuGa1DkqNLaF-lSXz4ndxO9G6SfACHwUvvywHgbQ/
featured_quote: Pensiamo, infatti, che sia tempo di affermare con forza&colon; "Usiamo esclusivamente il formato WOFF2 e scordiamoci di tutti gli altri". Così semplifichiamo di molto i nostri CSS e il nostro metodo di lavoro ed inoltre WOFF2 è ora supportato ovunque.
featured_stat_1: 29%
featured_stat_label_1: Siti che usano `font-display&colon; swap`
featured_stat_2: 18%
featured_stat_label_2: Siti che usano i web font di icone (<i lang="en">icon web fonts</i>).
featured_stat_3: 97%
featured_stat_label_3: Font variabili utilizzati che sono serviti da Google
---

## Introduzione

Molta strada è stata fatta dai primi tempi dell'introduzione dei web font. Si è passati da una manciata di font web safe all'esplosione di centinaia di migliaia di web font. La tecnologia e la facilità di utilizzo è pressoché irriconoscibile rispetto all'inizio: da elaborate strategie di caricamento dei font che prevedevano l'inclusione di svariati formati, strategie cosiddette "bullet-proof" [ovvero "a prova di proiettile"], si è arrivati all'inclusione dei soli file WOFF2.

{{ figure_markup(
  image="webfont-usage.png",
  caption="Utilizzo dei web font.",
  description="Grafico a dispersione che mostra la percentuale di richieste di font web nel tempo dal 2010 (0% di utilizzo) al 2022 (oltre l'80%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1021821560&format=interactive",
  sheets_gid="1517999851",
  sql_file="font_usage_over_time.sql"
  )
}}

Questa progressione dei web font lo dimostra. L'utilizzo dei web font è in continua crescita. Nel capitolo sui [Font del 2020](../2020/fonts), l'82% di tutti i siti desktop usava i web font. Nei due anni seguenti l'utilizzo è cresciuto per arrivare a circa l'84%. Le percentuali sono leggermente più basse per il mondo dei dispositivi mobili, ma indicano una crescita simile.

Tuttavia, sebbene abbiamo fatto notevoli progressi, ancora non ci siamo del tutto. Un'ampia fetta di popolazione mondiale non può usare i web font perché il proprio sistema di scrittura è o troppo corposo o troppo complesso per essere racchiuso in forma di web font (perlomeno di un web font leggero). Per fortuna, il <a hreflang="en" href="https://www.w3.org/Fonts/WG/">W3C Fonts Working Group</a> [Gruppo di lavoro sui font del W3C] sta lavorando assiduamente sul nuovo standard web chiamato <a hreflang="en" href="https://www.w3.org/TR/IFT/"><i lang="en">Incremental Font Transfer</i></a> [Trasferimento Incrementale dei Font], che ottimisticamente risolverà questo problema.

Nel 2021 non è stato scritto il capitolo sui Font, speriamo di porre rimedio quest'anno. Abbiamo analizzato i dati da un'angolazione leggermente diversa quest'anno, dando un'occhiata più da vicino a cosa c'è all'interno dei file dei font e a come vengono utilizzati i font nei CSS. Ovviamente siamo anche tornati ai "classici" come i servizi di hosting, la proprietà CSS `font-display` e l'utilizzo dei suggerimenti per le risorse. Infine, il capitolo si conclude con due approfondimenti speciali sui _font variabili_ e sui _font a colori_ – semplicemente perché pensiamo che siano grandiosi.

## Prestazioni

{{ figure_markup(
  image="popular-web-font-mime-types.png",
  caption="I più diffusi tipi MIME per i font.",
  description="Istogramma che mostra che `woff2` viene utilizzato il 78% delle volte su desktop e il 75% su dispositivi mobili, `woff` rispettivamente il 10% e il 12%, `octet-stream` il 6% e 7%, `ttf` il 3 % e 4%, `sfnt` l'1% e 1%, `otf` lo 0% e 0% e infine `opentype` lo 0% nei desktop e 0% nei dispositivi mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1637212263&format=interactive",
  sheets_gid="510414604",
  sql_file="font_format_usage.sql"
  )
}}

A sorpresa non molto è cambiato nei tipi di file di font serviti dai server. Il 75% circa dei file di font sono serviti come <a hreflang="en" href="https://www.w3.org/TR/WOFF2/">WOFF2</a>, il 12% circa come WOFF e i restanti o come octet-stream o come font TrueType (TTF) – seguiti da un sacco di tipi MIME a caso.
Il che è piuttosto simile ai [risultati pubblicati nel capitolo Font del 2020](../2020/fonts#formats-and-mime-types). Fortunatamente è quasi scomparso del tutto l'uso dei formati di font SVG e EOT.

Come precisato già nel 2019 e 2020 il formato WOFF2 offre la migliore compressione e dovrebbe essere il formato preferito. Pensiamo, infatti, che sia tempo di affermare con forza:

> Usiamo esclusivamente il formato WOFF2 e scordiamoci di tutti gli altri.

Questo semplificherà di molto i nostri CSS e il nostro metodo di lavoro ed inoltre impedirà uno scaricamento di font che accidentalmente risulti doppio o scorretto. WOFF2 è ora <a hreflang="en" href="https://caniuse.com/woff2">supportato ovunque</a>. Dunque, a meno che non dobbiamo necessariamente supportare dei browser molto datati, usiamo semplicemente WOFF2. Se non possiamo, consideriamo l'opzione di non servire alcun web font ai vecchi browser. Fatto che non costituirà un problema se avremo adottato una robusta strategia di ripiego. I visitatori con i vecchi browser vedranno semplicemente i font di riserva (fallback font).

### Hosting

Da dove prende i font la gente? Li ospitano sui propri server o utilizzano un servizio esterno di web font? Entrambe le cose? Diamo un'occhiata ai numeri.

{{ figure_markup(
  image="hosting-type.png",
  caption="Tipo di hosting.",
  description="Il grafico a barre mostra che i font in self-hosting (non in esclusiva) sono utilizzati nel 67% delle pagine desktop e nel 67% delle pagine mobili, il self-hosting (in esclusiva) è utilizzato rispettivamente nel 18% e nel 20%, i servizi di font (non in esclusiva) nel 68 % e nel 65%, e infine i servizi di font (in esclusiva) nel 19% delle pagine desktop e nel 18% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1751970122&format=interactive",
  sheets_gid="1791297167",
  sql_file="font_usage_by_service.sql"
  )
}}

In generale, è un misto: nel 67% dei casi i font sono in self-hosting e contemporaneamente utilizzano un servizio. Solo il 19% utilizza esclusivamente il self hosting. Prevediamo che questo numero aumenterà nei prossimi anni per due motivi: non c'è più un vantaggio in termini di prestazioni nell'utilizzo di un servizio in hosting dopo l'introduzione del <a hreflang="en" href="https://developers.google.com/web/updates/2020/10/http-cache-partitioning">partizionamento della cache</a> e <a hreflang="en" href="https://www.theregister.com/2022/01/31/website_fine_google_fonts_gdpr/">i tribunali europei stanno lentamente diventando molto scettici nei confronti delle aziende con sede in Europa che utilizzano il servizio Google Fonts</a>.

Possiamo suddividere ulteriormente questi dati per servizio. Forse non sorprende che <a hreflang="en" href="https://fonts.google.com/">Google Fonts</a> sia il servizio di font web più popolare con quasi il 65% di tutte le pagine web che lo utilizzano. Ciò che gratuito è davvero difficile da battere.

{{ figure_markup(
  image="webfont-usage-by-service.png",
  caption="Utilizzo dei web font per servizio.",
  description="L'istogramma mostra che Google Fonts è stato utilizzato nel 59,4% delle pagine nel 2019, 63,9% nel 2020, 65,2% nel 2021 e 64,5% nel 2022, Font Awesome rispettivamente nel 3,7%, 5,4%, 6,3% e 6,9%, Adobe Fonts nel 3,4%, 3,6%, 3,9% e 4,2%, Fonts.com nello 0,4%, 0,3%, 0,3% e 0,2% e infine Cloud.Typography nello 0,3% nel 2019, 0,2% nel 2020, 0,2% in 2021 e 0,2% nel 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1049143598&format=interactive",
  sheets_gid="1791297167",
  sql_file="font_usage_by_service.sql"
  )
}}

Il secondo classificato è il servizio web <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>, che è usato in circa il 7% dei siti. Questo è un risultato straordinario per una singola famiglia di caratteri! Al terzo posto c'è il servizio web <a href="https://fonts.adobe.com/">Adobe Fonts</a>, utilizzato nel 4,2% dei siti. Seguono a distanza i servizi <a hreflang="en" href="https://www.fonts.com/">Fonts.com</a> e <a hreflang="en" href="https://www.typography.com/webfonts">Cloud.Typography</a>, entrambi presenti nello 0,2% dei siti.

Guardando indietro agli anni precedenti, possiamo vedere che l'utilizzo di Google Fonts è diminuito per la prima volta quest'anno! È difficile dire se ciò sia dovuto al già citato partizionamento della cache, al GDPR o a qualcos'altro. Il calo è solo lieve, quindi sarà interessante vedere se il trend continuerà il prossimo anno.

Al contrario, sia Font Awesome che il servizio Adobe Fonts sono cresciuti in modo significativo negli ultimi anni. L'utilizzo del servizio Font Awesome è cresciuto dell'86% dal 2019 al 2022, mentre l'utilizzo di Adobe Fonts è cresciuto del 24% nello stesso periodo.

Va precisato che i dati sui servizi sono qui misurati in modo diverso rispetto a quanto fatto nei capitoli Font del 2020 e del 2019. Allora si era esaminato il numero di richieste ai servizi, mentre i dati del 2022 riportano il numero di pagine che utilizzano i servizi. Quindi i dati del 2022 sono più accurati in quanto non sono influenzati dal numero di font caricati su ciascun sito. Ad esempio, il calo dell'utilizzo di Google Fonts notato nel capitolo Font del 2020 è stato molto probabilmente causato dal passaggio di Google Fonts ai _font variabili_, con conseguente riduzione significativa del numero di richieste al loro servizio.

### Dimensioni dei file

La compressione è un ottimo modo per ridurre la quantità di dati che devono essere scaricati, ma ha i suoi limiti. Per capire meglio cosa influenza le dimensioni dei file dei font, diamo un'occhiata alle dimensioni medie dei font fra tutti i font.

{{ figure_markup(
  image="font-sizes.png",
  caption="Dimensioni (peso in KB) dei font.",
  description="Al 10° percentile vengono utilizzati 10 KB di font su desktop e 8 KB su dispositivi mobili, il 25° percentile è rispettivamente di 15 KB e 13 KB, il 50° percentile è di 20 KB e 20 KB, il 75° percentile è di 44 KB e 43 KB e infine al 90° percentile è di 75 KB sia su desktop che su dispositivi mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=2083466743&format=interactive",
  sheets_gid="1323521462",
  sql_file="font_size_quantiles.sql"
  )
}}

La dimensione media dei font è di circa 20 kilobyte. Il che va piuttosto bene. Tuttavia, come abbiamo visto in precedenza, i servizi di font esterni rappresentano quasi il 70% di tutte le richieste di font da parte dei siti. Servizi come Google Fonts e Adobe Fonts hanno dei team dedicati alla massima ottimizzazione dei font, quindi è probabile che la dimensione media dei font sia fortemente distorta da questi servizi.

{{ figure_markup(
  image="self-hosted-font-sizes.png",
  caption='Dimensioni (in KB) dei font pubblicati sui server dei siti (<i lang="en">self-hosted</i>).',
  description='Istogramma che mostra le dimensioni dei font (<i lang="en">self-hosted</i> a vari percentili. Al 10° percentile i font (<i lang="en">self-hosted</i> pesano 7 KB su desktop e 7 KB sui dispositivi mobili, al 25° percentile pesano rispettivamente 17 KB e 17 KB, al 50° percentile pesano 37 KB su entrambi, al 75° percentile pesano 75 KB su entrambi e infine al 90° percentile pesano 96 KB su desktop e 91 KB sui dispositivi mobili.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=15369234&format=interactive",
  sheets_gid="1359064325",
  sql_file="font_size_quantiles_without_services.sql"
  )
}}

Guardando alle dimensioni dei font <i lang="en">self-hosted</i> abbiamo un'immagine abbastanza diversa. La dimensione media del font quasi raddoppia a circa 40 kilobyte. Come mai? Se rivediamo il grafico dei tipi MIME dei web font più diffusi togliendo tutte le richieste provenienti dai servizi di font esterni, otteniamo alcuni indizi su quello che forse sta succedendo.

Molti siti web che richiamano i font in <i lang="en"> self-hosting</i> utilizzano ancora il formato WOFF anziché WOFF2. Non è chiaro se i font su questi siti non siano mai stati aggiornati da quando è stato introdotto WOFF2, o se solo pochi sviluppatori conoscano WOFF2 e i suoi vantaggi. Indipendentemente da ciò, WOFF2 è una facile ottimizzazione che potrebbe avvantaggiare molti siti.

{{ figure_markup(
  image="popular-web-font-mimetypes-self-hosted.png",
  caption='Tipi MIME di web font più diffusi (<i lang="en">self-hosted</i>).',
  description='Istogramma che mostra che woff2 rappresenta il 45% su desktop e il 46% sui dispositivi mobili dei font in <i lang="en">self-hosting</i>, woff copre rispettivamente il 26% e il 26%, octet-stream è presente nel 15% e nel 15% e infine ttf riguarda il 6% su desktop e il 6% sui dispositivi mobili dei font in <i lang="en">self-hosting</i>.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=291490668&format=interactive",
  sheets_gid="259914355",
  sql_file="font_format_usage_without_services.sql"
  )
}}

Sebbene WOFF2 offra un'eccellente compressione, la compressione da sola non spiega la grande differenza nella dimensione media dei caratteri. I servizi di web font esterni sembrano eseguire altri tipi di ottimizzazioni che non vengono eseguite (o non vengono eseguite abbastanza) per i font in <i lang="en">self-hosting</i>. Per averne la certezza, dovremmo poter guardare all'interno di ciascun font.

### Dimensioni (peso) delle tabelle dell'OpenType

Un font è essenzialmente un <a hreflang="en" href="https://simoncozens.github.io/fonts-and-layout/opentype.html">minuscolo database relazionale</a> in cui ogni tabella memorizza dei dati come le forme dei glifi, le relazioni fra i glifi e dei metadati. Ad esempio, ci sono tabelle per memorizzare le curve di Bézier vettoriali che compongono i glifi, ovvero i singoli caratteri nel font. Ci sono anche tabelle, pensate per mettere in relazione i glifi tra loro, che memorizzano cose come le relazioni di crenatura (<i lang="en">kerning</i>) e legatura (<i lang="en">ligature</i>), (ad esempio istruzioni del tipo "scambia questi due glifi con quest'altro quando vengono usati insieme", come la famosa legatura _fi_).

Un modo pratico per misurare l'impatto di una tabella sulla dimensione complessiva del file è moltiplicare la sua dimensione mediana per il numero dei font che includono quella tabella.

<figure>
  <table>
    <thead>
      <tr>
        <th>Tabella OpenType</th>
        <th>Impatto</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>glyf</code> (forme vettoriali)</code></td>
        <td class="numeric">79.6%</td>
      </tr>
      <tr>
        <td><code>CFF</code> (forme vettoriali)</td>
        <td class="numeric">4.9%</td>
      </tr>
      <tr>
        <td><code>GPOS</code> (relazioni di posizionamento)</td>
        <td class="numeric">4.7%</td>
      </tr>
      <tr>
        <td><code>hmtx</code> (metriche orizzontali)</td>
        <td class="numeric">2.5%</td>
      </tr>
      <tr>
        <td><code>post</code> (metadati)</td>
        <td class="numeric">2.2%</td>
        </tr>
      <tr>
        <td><code>name</code> (metadati del nome)</td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td><code>cmap</code> (abbinamento codici dei caratteri - glifi)</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td><code>fpgm</code> (programma di creazione font)</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td><code>kern</code> (dati di crenatura)</td>
        <td class="numeric">0.6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Impatto (dimensione mediana del file × il numero di richieste come percentuale del totale).",
      sheets_gid="1853636944",
      sql_file="font_size_quantiles_by_opentype_table.sql",
    ) }}
  </figcaption>
</figure>

La top ten delle tabelle di maggior impatto inizia con le tabelle `glyf`, `CFF`, `GPOS` e `hmtx`. Queste tabelle contengono i dati delle curve di Bézier che costituiscono i contorni di tutti i glifi (`glyf` e `CFF`), i dati di posizionamento OpenType (`GPOS`) e le metriche orizzontali (`hmtx`). Che queste tabelle siano ad alto impatto è un bene perché queste tabelle sono direttamente correlate al numero di glifi nel font. Se decidiamo di ridurre il numero di glifi nel font rimuovendo i glifi che non ci servono, allora ridurremo drasticamente le dimensioni del file.

Capire <a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-subsetting.html">cosa ci serve e cosa non ci serve</a> è però la parte più difficile. Potremmo rimuovere accidentalmente i glifi o interrompere le funzionalità OpenType che ci servono per un corretto rendering del testo. Invece di fare un subsetting manuale utilizzando, ad esempio, <a hreflang="en" href="https://fonttools.readthedocs.io/en/latest/subset/index.html">font tools</a>, possiamo utilizzare strumenti come <a hreflang="en" href="https://github.com/Munter/subfont">subfont</a> o <a hreflang="en" href="https://github.com/zachleat/glyphhanger">glyphhanger</a> per creare automaticamente un sottoinsieme "perfetto" in base al contenuto del tuo sito. Tuttavia, occorre controllare se la licenza del font consente tali modifiche.

È interessante notare che le tabelle `name` e `post` sono tra le prime 10. Queste due tabelle contengono principalmente dei metadati importanti per i font installati sulle macchine (<i lang="en"> desktop fonts </i>), ma non necessari per i web font. Questo ci indica che molti web font contengono metadati che potrebbero essere rimossi senza conseguenze, come voci nella tabella `name` (nome), nomi dei glifi nella tabella `post`, voci non Unicode nella tabella `cmap`, ecc. Ci piacerebbe si arrivasse ad un insieme di raccomandazioni condivise (o addirittura ad uno strumento simile a <a hreflang="en" href="https://pmt.sourceforge.io/pngcrush/">pngcrush</a>) che possa essere utilizzato da fonderie e sviluppatori web per rimuovere da un font web fino all'ultimo byte non necessario.

### Formati di outline

Potresti aver notato che la tabella precedente sulle dimensioni di OpenType contiene due voci per i dati di contorno vettoriale (<i lang="en">vector outline</i>) del glifo: `glyf` e `CFF`. In realtà esistono quattro modi alternativi per memorizzare i contorni vettoriali in OpenType: TrueType (`glyf`), Compact Font Format (`CFF`), Compact Font Format 2 (`CFF2`) e Scalable Vector Graphics (`SVG`; da non confondere con il vecchio formato di font SVG). Esistono anche tre formati basati su immagini - parleremo di due di questi nella sezione dei font a colori.

La specifica OpenType è ciò che, ad esser buoni, potresti chiamare "un compromesso". Nella specifica, poiché non c'era consenso, sono stati inseriti diversi approcci in competizione fra loro per fare per lo più la stessa cosa. Se desideri capire come si è arrivati a questo, <a hreflang="en" href="https://www.pastemagazine.com/design/adobe/the-font-wars/">The Font Wars</a> di David Lemon è un'ottima lettura. Vedremo ripetutamente questo schema di approcci in competizione fra loro anche nelle sezioni sui font variabili e sui font a colori (sebbene con attori diversi). In fin dei conti, avere più modi per archiviare il contorno vettoriale funziona bene per lo più, ma comporta un pesante onere aggiuntivo per i type designer e per le implementazioni, per non parlare dell'aumento della superficie di azione per gli attacchi malevoli al software.

I type designers possono scegliere il formato di outline che preferiscono. Osservando la distribuzione dei formati è abbastanza chiaro quale sia stato preferito dai type designer. La stragrande maggioranza (91%) dei font utilizza il formato di outline `glyf`, mentre il 9% utilizza il formato `CFF`. Si registra anche il formato di outline `SVG` in uso nei font a colori, ma nelle misura di meno dell'1% (non mostrato nel grafico).

{{ figure_markup(
  image="outline-formats.png",
  caption='Formati di contorno (<i lang="en">outline</i>).',
  description='Il grafico a torta mostra che i font sui dispositivi mobili sono nel formato TrueType (`glyf`) nel 90,8% dei casi e sono nel formato `CFF` nel 9,2%.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=934239411&format=interactive",
  sheets_gid="1181700309",
  sql_file="outline_formats.sql"
  )
}}

La specifica OpenType elenca le <a hreflang="en" href="https://docs.microsoft.com/en-us/typography/opentype/otspec191alpha/glyphformatcomparison_delta">differenze tra `glyf` e `CFF`</a>:

- Il formato `glyf` utilizza curve di Bézier quadratiche mentre `CFF` (e `CFF2`) utilizza curve di Bézier cubiche. Questo interessa ad alcuni type designer, ma non agli utilizzatori del font.
- Il formato `glyf` ha un maggiore controllo nell'hinting, consente piccole regolazioni in modo che i contorni del glifo si allineino ai pixel corretti quando i font sono a piccole dimensioni, mentre `CFF` ha la maggior parte del suo processo di hinting incorporato nel rasterizzatore di testo.
- Il formato `CFF` si vanta di essere un formato più efficiente, avendo dimensioni dei font più ridotte.

L'ultima affermazione è interessante. `CFF` è più piccolo?

{{ figure_markup(
  image="font-outline-sizes.png",
  caption='Dimensioni del contorno dei caratteri (<i lang="en">font outlines</i>).',
  description="Grafico a colonne che mostra le dimensioni del contorno dei caratteri a percentili comuni. Al 10° percentile `CFF` è 1 KB e `glyf` 10 KB, al 25° percentile è rispettivamente 14 e 21, al 50° percentile è 29 e 49, al 75° percentile è 54 e 109, e infine al 90° percentile `CFF` è 124 KB e `glyf` 136 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=672500092&format=interactive",
  sheets_gid="1853636944",
  sql_file="font_size_quantiles_by_opentype_table.sql"
  )
}}

In media, il formato `CFF` produce effettivamente una tabella di dimensioni più piccole (meno pesanti). Tuttavia, la realtà ha più sfumature, e infatti l'affermazione precedente sembra non tener conto della compressione: le dimensioni della tabelle sono qui annotate dopo che il font è stato decompresso.

Come si può vedere nel <a hreflang="en" href="https://www.w3.org/TR/2016/NOTE-WOFF20ER-20160315/#brotli-adobe-cff">rapporto di valutazione WOFF2</a>, il fattore di compressione medio per `glyf` è del 66% mentre per `CFF` è al 50% (da non compresso a compresso usando WOFF2).

{{ figure_markup(
  image="compressed-font-outline-sizes.png",
  caption='Dimensioni del contorno dei caratteri compressi (<i lang="en">compressed font outlines</i>).',
  description="L'istogramma mostra che al 25° percentile la dimensione dei font sia per `CFF` che per `glyf` è di 6 KB, al 50° percentile iniziano a divergere con `CFF` a 15 KB e `glyf` a 17 KB, al 75° percentile sono rispettivamente di 32 e 39 KB, e infine al 90° percentile `CFF` è al 86 KB e `glyf` è solo al 56 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1880460638&format=interactive",
  sheets_gid="1853636944",
  sql_file="font_size_quantiles_by_opentype_table.sql"
  )
}}

Se applichiamo la compressione vediamo una situazione molto diversa. Le differenze medie di dimensione dei file sono trascurabili e font grandi (con tanti glifi) sono molto più piccoli (pesano meno) quando hanno il formato di outline `glyf`!

In altre parole, anche se `CFF` inizia con dimensioni inferiori, si comprime molto meno di `glyf`, quindi alla fine le differenze si appianano. In realtà, per file di font più grandi (con tanti glifi o altro), l'utilizzo del formato `glyf` produce file di dimensioni più piccole grazie alla compressione.

### <i lang="en">Resource hints</i>

I suggerimenti sul trattamento delle risorse (<i lang="en">resource hints</i>) sono istruzioni specifiche per il browser di caricare o eseguire il rendering di una risorsa prima di quando lo farebbe di solito. Normalmente i browser caricano i web font solo quando sanno che quel dato font viene utilizzato nella pagina. Per saperlo, devono aver analizzato sia l'HTML che il CSS. Tuttavia, se noi, come sviluppatori web, sappiamo che quel font verrà utilizzato, potremo adoperare i suggerimenti per le risorse per dire al browser di caricare i font in anticipo.

Esistono diversi tipi di suggerimenti per le risorse che hanno rilevanza per i web font: `dns-prefetch`, `preconnect` e `preload`, qui elencati nell'ordine dal più basso al più alto impatto. Idealmente vorremmo precaricare i nostri font più importanti, ma a seconda di dove sono ospitati, ciò potrebbe non essere sempre possibile.

{{ figure_markup(
  image="fonts-resource-hints-usage.png",
  caption="Utilizzo dei suggerimenti per le risorse per i font.",
  description="L'istogramma mostra che `dns-prefetch` viene utilizzato per i font nel 30% delle pagine desktop e nel 32% delle pagine su dispositivi mobili, `preload` rispettivamente nel 21% e 20%, `preconnect` nel 16% e 16% e infine `prefetch` viene utilizzato nel 2% delle pagine desktop e nel 2% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1831399490&format=interactive",
  sheets_gid="592046045",
  sql_file="resource_hints_usage.sql"
  )
}}

Dal 2020 non c'è stato alcun grande cambiamento nell'uso dei suggerimenti `dns-prefetch`, ma c'è stato un aumento abbastanza significativo nell'uso di `preload` (dal 17% nel 2020 al 20% nel 2022) e `preconnect` (dall'8% nel 2020 al 15% nel 2022). È fantastico!

Come già [accennato nel capitolo del 2020](../2020/fonts#resource-hints), i suggerimenti per le risorse `preload` (precaricamento) e `preconnect` (preconnessione) hanno singolarmente il maggiore impatto sulla prestazione di caricamento dei font (<i lang="en">font loading performance</i>). Nella maggior parte dei casi è semplice come aggiungere un tag link nella head del documento. Ad esempio, se utilizzi Google Fonts:

```html
<link rel="preconnect" href="https://fonts.gstatic.com">
```

Se mettiamo i font in autopubblicazione (<i lang="en">self-hosting</i>) possiamo spingerci anche oltre e fornire suggerimenti al browser per precaricare (<i lang="en">preload</i>) i font più importanti, ad esempio il nostro font principale per il corpo del testo. In questo modo il browser può caricarlo in anticipo e sarà possibilmente disponibile nel momento d'inizio del rendering del testo.

### `font-display`

Per diversi anni la maggior parte dei browser non iniziava il rendering del testo fino a quando i web font non venivano caricati. Su connessioni lente, ciò comportava spesso diversi secondi di testo invisibile anche se il contenuto del testo era già stato caricato. Questo comportamento prende il nome di _block_ (blocco), perché blocca il rendering del testo. Altri browser mostravano immediatamente i font di riserva (<i lang="en">fallback font</i>) e li sostituivano (<i lang="en">swap</i>) non appena il web font risultava caricato. Quando un font di riserva viene sostituito da un web font, questo processo viene chiamato _swap_.

Per offrire agli sviluppatori web un maggiore controllo sul caricamento dei font, è stato introdotto il descrittore `font-display` nato per indicare al browser come comportarsi durante il caricamento dei web font. Esso prevede quattro diversi valori per indicare al browser cosa fare durante il caricamento dei font. Questi valori vengono implementati utilizzando diverse combinazioni dei comportamenti di _block_ e di _swap_.

- `swap`: blocca per un brevissimo periodo e sostituisce sempre.
- `block`: blocca per un breve periodo e sostituisce sempre.
- `fallback`: blocco per un periodo molto breve e sostituisce entro un breve periodo.
- `optional`: blocco per brevissimo periodo e nessun periodo di sostituzione.

C'è anche `auto`, che lascia la decisione al browser - tutti i browser moderni usano `block` come valore predefinito.

{{ figure_markup(
  image="usage-of-font-display.png",
  caption="Uso di `font-display`.",
  description="L'istogramma mostra che `font-display: swap` è utilizzato sul 32% delle pagine desktop e sul 29% delle pagine per dispositivi mobili, `block` è usato rispettivamente nel 16% e nel 17%, `auto` nel 9% e 8%, `fallback` nel 2% e 2% e infine `optional` è allo 0% sia delle pagine desktop che delle pagine per dispositivi mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1648924039&format=interactive",
  sheets_gid="1599822681",
  sql_file="font_display_usage.sql"
  )
}}

L'utilizzo di `font-display: swap` è cresciuto fino ad un impressionante 30% ([dall'11% nel 2020](../2020/fonts#racing-to-first-paint)). Molto probabilmente una buona parte di questo aumento può essere attribuita a <a hreflang="en" href="https://www.youtube.com/watch?v=YJGCZCaIZkQ&t=1880s">Google Fonts che nel 2019 ha indicato swap come valore consigliato</a>. È anche interessante vedere al secondo posto fra i più utilizzati è ora il valore `block` al posto di `auto`. Non siamo sicuri del motivo per cui gli sviluppatori stiano intenzionalmente degradando le prestazioni del loro sito, ma si tratta di uno sviluppo interessante, anche se leggermente preoccupante.

La nostra ipotesi è che agli sviluppatori, o ai loro clienti, non piaccia vedere il <i lang="en">Flash of Fallback Fonts</i>. L'utilizzo di `font-display: block` è un modo semplice per "risolvere" il problema. Tuttavia, c'è una soluzione migliore all'orizzonte. Nel prossimo futuro si potranno utilizzare le proprietà CSS di sovrascrittura delle metriche dei font per modificare i font di fallback in modo da farle assomigliare a quelle dei web font scelti. Ciò ridurrà la fastidiosa ridistribuzione del testo quando, [dopo il caricamento], il font di fallback viene rimpiazzato dal web font.

I descrittori CSS `ascent-override`, `descent-override`, `line-gap-override` e `size-adjust` della regola `@font-face` offrono la possibilità di sovrascrivere le metriche di qualsiasi tipo di font. Possiamo usare questi descrittori in abbinamento a `local()` per <a hreflang="en" href="https://developer.mozilla.org/docs/Web/CSS/@font-face/ascent-override#overriding_metrics_of_a_fallback_font">creare un font di fallback personalizzato</a> che corrisponda più o meno al nostro web font — ehi, finalmente un buon uso per <a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html">`local()`</a>.

{{ figure_markup(
  image="css-font-metrics-override-usage.png",
  caption='Utilizzo della sovrascrittura (<i lang="en">override</i>) CSS delle metriche dei font.',
  description="L'istogramma mostra che `ascent-override` viene utilizzato nello 0,11% delle pagine desktop e nello 0,20% di pagine per dispositivi mobili, `descent-override` rispettivamente sullo 0,07% e 0,13%, `line-gap-override` sullo 0,07% e 0,13% e infine `size-adjust` sullo 0,05% delle pagine desktop e sullo 0,13% delle pagine per dispositivi mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=2058878625&format=interactive",
  sheets_gid="241586017",
  sql_file="font_metric_override_usage.sql"
  )
}}

Questi descrittori di `@font-face` sono appena stati definiti, ma stanno già vedendo un certo utilizzo. Per renderli ancora più utili gli sviluppatori hanno bisogno di due cose:

1. Uno stesso insieme di font di fallback disponibile in tutti i browser e su tutte le piattaforme. Si potrebbe anche trattare di font variabili. Immagina le possibilità che si aprono.
2. Strumenti per abbinare automaticamente il font di fallback al web font modificandone le dimensioni e le metriche. Farlo a mano richiede molto tempo, quindi uno strumento è necessario. Con ciò non si intende rimpiazzare il web font, ma semplicemente configurare un font di fallback temporaneo che ne faccia le funzioni durante il caricamento dei web font (o ne diventi il sostituto solo se i font non vengono caricati o il browser è molto vecchio).

Ci stiamo lentamente arrivando con strumenti come <a hreflang="en" href="https://meowni.ca/font-style-matcher/">Font Style Matcher</a> e <a hreflang="en" href="https://www.industrialempathy.com/perfect-ish-font-fallback/">Perfect-ish Font Fallback</a>, ma sfortunatamente i font di fallback dipendono ancora molto dalla piattaforma.

## Utilizzo dei font

Le prestazioni sono importanti, ma è anche interessante vedere come vengono utilizzati i caratteri sul web. Ad esempio, quali sono i font e le fonderie più popolari? Le persone utilizzano le funzionalità di OpenType? Diamo un'occhiata ai dati.

### Famiglie di font e fonderie

<figure>
  <table>
    <thead>
      <tr>
        <th>Famiglia</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Roboto</td>
        <td class="numeric">14.5%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Font Awesome</td>
        <td class="numeric">10.5%</td>
        <td class="numeric">12.8%</td>
      </tr>
      <tr>
        <td>Noto Sans</td>
        <td class="numeric">10.1%</td>
        <td class="numeric">8.0%</td>
      </tr>
      <tr>
        <td>Open Sans</td>
        <td class="numeric">5.9%</td>
        <td class="numeric">7.7%</td>
      </tr>
      <tr>
        <td>Lato</td>
        <td class="numeric">3.6%</td>
        <td class="numeric">3.9%</td>
      </tr>
      <tr>
        <td>Poppins</td>
        <td class="numeric">3.0%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td>Montserrat</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>Source Sans Pro</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">1.9%</td>
      </tr>
      <tr>
        <td>icomoon</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Proxima Nova</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Raleway</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>Noto Serif</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Ubuntu</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.9%</td>
      </tr>
      <tr>
        <td>NanumGothic</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Oswald</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>PT Sans</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>GLYPHICONS Halflings</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Rubik</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>eicons</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>revicons</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="I font più utilizzati.",
      sheets_gid="1543752771",
      sql_file="popular_font_families_by_vendor.sql",
    ) }}
  </figcaption>
</figure>

Con l'enorme impatto di Google Fonts sulla fornitura di web font, non sorprende che il carattere più utilizzato sul web sia il Roboto. Roboto è stato creato da Google come font di sistema per il suo sistema operativo Android. Questo spiega anche l'enorme discrepanza tra l'utilizzo di Roboto sui dispositivi mobili rispetto ai siti desktop. Su Android, Google Fonts utilizzerà la versione installata dal sistema invece di scaricarla come web font.

Font Awesome occupa il secondo posto, il che è un risultato impressionante per quella che è essenzialmente una famiglia di caratteri con un unico font. Font Awesome, assieme a Icomoon, Glyphicons, eicons e revicons, costituisce quasi il 18% di tutti i web font utilizzati sui siti web! Gli icon font sono problematici dal <a hreflang="en" href="https://fontawesome.com/docs/web/dig-deeper/accessibility">punto di vista dell'accessibilità</a>, quindi è preoccupante riscontrarli così popolari.

{{ figure_markup(
  content="18%",
  caption="Siti che utilizzano gli icon font.",
  classes="big-number",
  sheets_gid="1543752771",
  sql_file="popular_font_families_by_vendor.sql",
) }}

Una menzione speciale dovrebbe essere fatta anche sul carattere Proxima Nova all'1% di utilizzo. È l'unico font commerciale, non di icone, tra i primi 20. È un risultato straordinario per il <a hreflang="en" href="https://www.marksimonson.com/">Mark Simonson Studio</a>.

Un altro fatto interessante è che la gran parte delle famiglie più utilizzate è open source. Il merito può essere attribuito a Google Fonts che ha o commissionato questi font, oppure incluso nella propria libreria dei font open source esistenti.

<figure>
  <table>
    <thead>
      <tr>
        <td>Distributore</td>
        <td>desktop</td>
        <td>mobile</td>
      </tr>
    </thead>
    <tbody>
    <tr>
      <td>Google</td>
      <td class="numeric">30.5%</td>
      <td class="numeric">17.7%</td>
    </tr>
    <tr>
      <td>Font Awesome</td>
      <td class="numeric">12.3%</td>
      <td class="numeric">15.6%</td>
    </tr>
    <tr>
      <td>Łukasz Dziedzic</td>
      <td class="numeric">3.6%</td>
      <td class="numeric">4.3%</td>
    </tr>
    <tr>
      <td>Indian Type Foundry</td>
      <td class="numeric">3.0%</td>
      <td class="numeric">4.1%</td>
    </tr>
    <tr>
      <td>Julieta Ulanovsky</td>
      <td class="numeric">2.5%</td>
      <td class="numeric">3.1%</td>
    </tr>
    <tr>
      <td>Adobe</td>
      <td class="numeric">1.6%</td>
      <td class="numeric">1.9%</td>
    </tr>
    <tr>
      <td>Ascender Corporation</td>
      <td class="numeric">1.6%</td>
      <td class="numeric">2.0%</td>
    </tr>
    <tr>
      <td>Icomoon</td>
      <td class="numeric">1.3%</td>
      <td class="numeric">1.5%</td>
    </tr>
    <tr>
      <td>Mark Simonson Studio</td>
      <td class="numeric">1.3%</td>
      <td class="numeric">1.3%</td>
    </tr>
    <tr>
      <td>ParaType Inc.</td>
      <td class="numeric">1.0%</td>
      <td class="numeric">1.4%</td>
    </tr>
  </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Le fonderie più popolari.",
      sheets_gid="1543752771",
      sql_file="popular_font_families_by_vendor.sql",
    ) }}
  </figcaption>
</figure>

L'elenco delle fonderie tipografiche più popolari (o in alcuni casi di progettisti di caratteri) è altrettanto affascinante. Oltre a grandi aziende come Google, Adobe, Ascender (Monotype), è bello vedere diverse aziende più piccole e persino diversi individui che hanno un impatto così grande.

### Le funzionalità OpenType

Le funzionalità OpenType sono spesso indicate come i superpoteri di un font. E, naturalmente, i font con superpoteri spesso non vengono riconosciuti. Le funzionalità di OpenType sono difficili da scoprire e utilizzare. Fortunatamente, ci sono strumenti web, come <a hreflang="en" href="https://wakamaifondue.com/">Wakamai Fondue</a>, che mostrano chiaramente quali funzionalità ci sono in un font, cosa fanno e come usarle.

{{ figure_markup(
  content="44%",
  caption="Font dotati di funzionalità OpenType.",
  classes="big-number",
  sheets_gid="183792112",
  sql_file="font_opentype_support.sql",
) }}

Alcune funzionalità OpenType nascono solo a scopo stilistico, mentre altre sono necessarie per la resa corretta del testo. Spesso queste due funzionalità vengono nominate come funzionalità discrezionali e funzionalità necessarie. Quasi il 44% di tutti i font ha funzionalità OpenType o discrezionali o necessarie. Quindi, ci sono buone probabilità che anche il font che stiamo usando abbia dei super poteri!

Le funzionalità discrezionali possono essere impiegate, ad esempio, per sostituire due glifi adiacenti con una legatura per migliorare la leggibilità. È anche comune per le funzionalità OpenType offrire versioni alternative di glifi, ad esempio aggiungendo degli <i lang="en">swash</i> (gli svolazzi dei font calligrafici).

Un numero significativo di font ha <a hreflang="en" href="https://fonts.google.com/knowledge/introducing_type/introducing_alternate_glyphs">funzionalità OpenType discrezionali</a>. La caratteristica discrezionale più comune riguarda, non sorprenda, le legature. A seguire un'intera gamma di funzionalità che modificano i numeri come frazioni, numeri proporzionali, numeri tabulari, numeri in linea e ordinali. Anche gli apici sono abbastanza comuni.

{{ figure_markup(
  image="opentype-features-support-in-fonts.png",
  caption="Supporto delle funzionalità OpenType nei font.",
  description="L'istogramma mostra che `kern` è utilizzato sul 12,8% dei font desktop e sul 12,4% dei font su dispositivi mobili, `liga` rispettivamente sul 10,0% e 10,1%, `locl` sul 9,6% e 9,7%, `frac` sull'8,1% e 7,6 %, `numr` sul 6,8% e 5,8%, `dnom` sul 6,7% e 5,8%, `pnum` sul 5,1% e 4,7% e infine `tnum` sul 5,0% dei font desktop e 4,5% dei font per dispositvi mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1500912295&format=interactive",
  sheets_gid="83804141",
  sql_file="font_opentype_feature_usage.sql"
  )
}}

Se osserviamo le funzionalità OpenType necessarie, ce ne sono due che si distinguono da tutto il resto: crenatura (_kerning_) e forme localizzate (_localized forms_). Le forme localizzate vengono utilizzate per specificare glifi alternativi tipici o preferiti in alcune lingue. Ciò implica che una buona quantità di font supporta più lingue, il che è un grande segno di progresso per l'internazionalizzazione.

La crenatura è il processo che aumenta o diminuisce leggermente lo spazio tra due glifi in qualsiasi combinazione al fine di far apparire più regolare lo spazio tra di loro. La crenatura è abilitata per impostazione predefinita su tutti i browser, quindi se il font supporta la crenatura, questa sarà abilitata.

{{ figure_markup(
  content="34%",
  caption="Font che includono i dati di crenatura.",
  classes="big-number",
  sheets_gid="1953603748",
  sql_file="font_kerning.sql",
) }}

Solo il 34% di tutti i web font ha dati di crenatura archiviati o come funzionalità OpenType o per mezzo della precedente tabella di crenatura `kern`. Quasi tutti i font necessitano di una crenatura per apparire corretti, quindi ci saremmo aspettati di trovare un valore molto più alto di quello che è. Una spiegazione è che quando i web font hanno iniziato ad essere utilizzati, il supporto del browser per la crenatura non era molto buono, quindi molti dei primi web font non includevano i dati di crenatura per risparmiare spazio. Al giorno d'oggi, tutti i browser supportano la crenatura, quindi non c'è motivo per cui i caratteri non debbano contenere i dati di crenatura.

{{ figure_markup(
  image="openType-feature-usage-in-css.png",
  caption="Utilizzo delle funzionalità OpenType in CSS.",
  description="L'istogramma mostra che `kern` è utilizzato sul 3,6% delle pagine desktop e sul 3,2% delle pagine mobili, `liga` rispettivamente sul 2,2% e 2,2%, `palt` sullo 0,4% e 0,4%, `pnum` sullo 0,4% e 0,4 %, `tnum` sullo 0,4% e 0,3%, `lnum` sullo 0,3% e 0,3% e infine `calt` sullo 0,1% delle pagine desktop e 0,1% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1359153027&format=interactive",
  sheets_gid="1050025794",
  sql_file="font_feature_settings_tags_usage.sql"
  )
}}

Cosa ancora più interessante è che la crenatura è anche il tag di funzionalità più comune utilizzato nella proprietà `font-feature-settings`. Quasi il 3,2% dei siti abilita (o peggio, disabilita) la crenatura manualmente. Non c'è alcun bisogno di farlo; è abilitata di default. In realtà, non è _mai_ necessario modificare le impostazioni di crenatura tramite `font-feature-settings` o tramite la proprietà di più alto livello <a hreflang="en" href="https://drafts.csswg.org/css-fonts/#font-kerning-prop">`font-kerning`</a>. Disabilitare la crenatura non renderà il nostro sito più veloce, ma la nostra composizione del testo sarà più sciatta per questo.

Le altre funzionalità più utilizzate sono più o meno in linea con ciò che i type designer di fatto includono: legature e vari tipi di numeri. È interessante notare in questa lista la funzionalità `palt` (alternative proporzionali), poiché principalmente viene utilizzata per i caratteri CJK (che a loro volta non sono comuni da trovare, perché di solito sono troppo grandi per essere utilizzati come web font, perfino con la compressione WOFF2). Come la crenatura, anche la funzionalità `calt` (alternative contestuali) è abilitata per impostazione predefinita e non dovrebbe essere abilitata o disabilitata in modo esplicito. Ci sono molte altre funzionalità OpenType utili come i set stilistici, le varianti di caratteri, il maiuscoletto e gli swash (svolazzi) che hanno un utilizzo ridotto, ma hanno il potenziale per migliorare tantissimo la tipografia. Il nostro consiglio è di trascinare sul sito <a hreflang="en" href="https://wakamaifondue.com/">Wakamai Fondue</a> i font con in quali si lavora per esplorarne tutti i superpoteri nascosti.

{{ figure_markup(
  image="usage-of-font-feature-settings-vs-font-variant.png",
  caption="Uso di font-feature-settings vs font-variant.",
  description="L'istogramma mostra che `font-feature-settings` è utilizzato nel 13,3% delle pagine desktop e nel 12,6% delle pagine per dispositivi mobili e `font-variant` è utilizzato nel 3,9% delle pagine desktop e nel 3,5% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1087474243&format=interactive",
  sheets_gid="959516935",
  sql_file="font_feature_settings_vs_font_variant.sql"
  )
}}

Nel complesso, l'utilizzo delle funzionalità OpenType è piuttosto basso sul web. Avremmo sperato che la maggior parte delle persone utilizzasse le proprietà di alto livello `font-variant` per abilitare le funzionalità OpenType, ma il loro utilizzo è persino inferiore di `font-feature-settings`. La proprietà `font-feature-settings` viene utilizzata nel 12,6% dei siti, mentre le proprietà `font-variant` vengono utilizzate solo nel 3,5% dei siti.

Questi dati sono deludenti. Non solo le persone non utilizzano le funzionalità OpenType presenti nei font, ma,come non bastasse, quando lo fanno, anziché la proprietà di alto livello `font-variant`, adoperano per lo più la proprietà `font-feature-settings`, fucina di errori. Con la proprietà `font-feature-settings` infatti occorre porre molta attenzione, poiché <a hreflang="en" href="https://pixelambacht.nl/2022/boiled-down-fixing-variable-font-inheritance/">riporta al suo valore predefinito (<i lang="en">reset</i>) qualsiasi funzionalità OpenType che non sia stata esplicitamente elencata</a>.

Tutti i valori più comunemente utilizzati per la proprietà `font-feature-settings` hanno equivalenti `font-variant` che sono più leggibili e non annullano l'impostazione di altre funzionalità OpenType come effetto collaterale. Sebbene il supporto per queste funzionalità di alto livello non sia stato eccezionale in passato, oggi sono <a hreflang="en" href="https://caniuse.com/?search=font-variant">ben supportate</a>, ad eccezione della proprietà `font-variant-alternates` introdotta di recente.

{{ figure_markup(
  image="usage-of-css-font-variant-values.png",
  caption="Utilizzo dei valori della proprietà CSS font-variant.",
  description="Il grafico a barre mostra che `font-variant: small-caps` viene utilizzato sull'1,5% delle pagine desktop e sull'1,4% delle pagine mobili, `font-variant: tabular-nums` rispettivamente sull'1,0% e 0,6%, `font-variant-numeric : tabular-nums` sullo 0,8% e 0,7%, `font-variant-ligatures: discretionary-ligatures` sullo 0,4% e 0,3%, `font-variant-ligatures: no-common-ligatures` sullo 0,3% e 0,3%, `font-variant-caps: all-small-caps` sullo 0,2% e 0,2%, `font-variant-numeric: lining-nums` sullo 0,2% e 0,2% e infine `font-variant-ligatures: common-ligatures` sullo 0,1% delle pagine desktop e mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=682306512&format=interactive",
  sheets_gid="1231655846",
  sql_file="font_variant_values.sql",
  width=600,
  height=535
  )
}}

Il valore più utilizzato per `font-variant` è `small-caps` nell'1,4% delle pagine. Il che sorprende, perché il maiuscoletto (<i lang="en">small caps</i>) è supportato solo dallo 0,7% dei font. Ciò significa che la maggior parte delle persone che usano `font-variant: small-caps` e `font-variant-caps` otterranno un finto maiuscoletto generato dal browser invece del maiuscoletto creato dal type designer! In futuro, potremo evitare il falso maiuscoletto usando la <a hreflang="en" href="https://drafts.csswg.org/css-fonts-4/#font-synthesis-small-caps">proprietà font-synthesis-small-caps</a>.

Gli altri valori corrispondono all'incirca a quanto fornito dagli stessi font. Anche se la frequenza d'uso delle proprietà `font-variant` è bassa, ci aspettiamo, o meglio speriamo, che questi numeri aumentino nel tempo e l'impiego di `font-feature-settings` venga relegato per gestire solo partricolari funzionalità OpenType personalizzate o proprietarie.

### Sistema di scrittura e lingue

Per capire che tipo di font vengono realizzati e utilizzati, abbiamo pensato che sarebbe stato interessante esaminare quali lingue sono supportate dai font. Ad esempio, si creano molti font tedeschi, vietnamiti o urdu? Sfortunatamente, è difficile rispondere a questa domanda perché molte lingue condividono lo stesso sistema di scrittura. Ciò significa che possono anche condividere lo stesso set di caratteri, ma con tutta probabilità sono stati progettati esplicitamente solo per una specifica lingua. Quindi, invece che alle lingue, daremo un'occhiata ai sistemi di scrittura.

{{ figure_markup(
  image="writing-systems-supported-by-fonts.png",
  caption="Sistemi di scrittura supportati dai font.",
  description="Il grafico a barre mostra che il Latin (latino) è utilizzato sul 57,6% delle pagine desktop e sul 53,6% delle pagine mobili, il Cyrillic (cirillico)rispettivamente sul 6,1% e sul 6,2%, il Greek (greco) sul 3,4% e sul 3,4%, il Katakana (un tipo di scrittura giapponese) sullo 0,9% e sull'1,0%, l'Hiragana (un altro tipo di scrittura giapponese) sullo 0,9% e lo 0,9 %, Hebrew (l'ebraico) sullo 0,5% e 0,5%, Arabic (l'arabo) sullo 0,3% e 0,4%, Thai (il tailandese) sullo 0,2% e 0,3%, Hangul (alfabeto coreano) sullo 0,5% e 0,3%, il Devanagari (alfabeto indiano) sullo 0,2% e 0,3% e infine Han (cinese) è sullo 0,2% di pagine desktop e mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=45355249&format=interactive",
  sheets_gid="841363278",
  sql_file="font_writing_scripts.sql",
  width=600,
  height=401
  )
}}

Non sorprende che il sistema latino sia in testa con un enorme 53,6% di tutti i font che supportano (un significativo) sottoinsieme del [sistema di scrittura latino](https://en.wikipedia.org/wiki/List_of_languages_by_writing_system#Latin_script). Il Latin include molte lingue utilizzate nel mondo occidentale, come inglese, francese e tedesco. In aggiunta, copre anche alcune lingue asiatiche, come il vietnamita e il tagalog. Il secondo e terzo posto dei sistemi di scrittura sono occupati da cirillico e greco. Di nuovo, ciò non sorprende, si tratta di alfabeti comunemente usati e che per giunta richiedono poco sforzo lavorativo per aggiungere un numero limitato di glifi extra. Katakana e Hiragana (giapponese) sono rispettivamente all'1% e allo 0,9%, combinato: un 1,9%. Si noti che circa il 10% dei font non ha raggiunto la soglia minima di un sistema di scrittura (non illustrato nel grafico). Questa percentuale include i font che, ad esempio, supportano solo un numero limitato di caratteri o font che hanno subito un forte subsetting.

Purtroppo, altri sistemi di scrittura sono molto meno diffusi. Ad esempio, Han (cinese) è il <a hreflang="en" href="https://www.worldatlas.com/articles/the-world-s-most-popular-writing-scripts.html">secondo sistema di scrittura più utilizzato al mondo</a> (dopo il latino), ma è supportato solo dallo 0,2% dei web font. L'arabo è il terzo sistema di scrittura più utilizzato, ma anche qui è supportato solo dallo 0,4% dei web font. Il motivo per cui alcuni di questi <a hreflang="en" href="https://www.w3.org/TR/PFE-evaluation/#fail-large">sistemi di scrittura non vengono utilizzati come web font</a> è che sono molto grandi a causa del numero di glifi che devono supportare e della difficoltà di fare un subsetting corretto.

Sebbene servizi come Google Fonts e Adobe Fonts supportino questi sistemi di scrittura, utilizzano tecnologie proprietarie che semplicemente non sono disponibili per il self-hosting. Ad ogni modo, il W3C Fonts Working Group sta lavorando ad un nuovo standard chiamato <a hreflang="en" href="https://www.w3.org/TR/IFT/">Incremental Font Transfer</a> (trasferimento incremetale dei font) che consente agli sviluppatori web di pubblicare in self-hosting font di grandi dimensioni. Speriamo di vedere altri sistemi di scrittura gareggiare con il latino una volta che questa tecnologia sarà ampiamente disponibile.

### Famiglie di font generiche

Abbiamo già accennato ai font di riserva (<i lang="en">fallback fonts</i>) parlando del descrittore `font-display`. Ci sono casi in cui non c'è affatto bisogno di web font, ad esempio potrebbere essere negli elementi dell'interfaccia utente o negli input dei moduli. Uno bel modo, mio preferito, per evitare l'uso dei web font è utilizzare il nuovo nome di famiglia generico `system-ui` che si riferisce alla famiglia di font utilizzata dal sistema operativo. Sapevate che ci sono molte altre famiglie generiche? Esistono `ui-monospace`, `ui-sans-serif`, `ui-serif` e anche `ui-rounded`, per chi desidera utilizzare un font del sistema operativo, ma ha esigenze un po' più specifiche.

{{ figure_markup(
  image="usage-of-css-generic-font-family-names.png",
  caption="Uso in CSS dei nomi generici per la famiglia di font.",
  description="Il grafico a barre mostra che `sans-serif` è utilizzato nell'89,1% delle pagine desktop e nell'89,3% delle pagine mobili, `monospace` rispettivamente nel 65,8% e nel 64,7%, `serif` nel 54,0% e 55,0%, `cursive` nel 3,7% e 3,9%, `system-ui` nel 4,0% e 3,6%, `fantasy` nello 0,5% e 0,5%, `ui-monospace` nello 0,6% e 0,5%, e infine `ui-sans-serif` viene utilizzato nello 0,5% delle pagine desktop e 0,4% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1479159855&format=interactive",
  sheets_gid="467837585",
  sql_file="usage_of_system_families.sql",
  width=600,
  height=400
  )
}}

Sebbene siano abbastanza nuovi, se ne sta già vedendo un uso significativo. I soliti sospetti, `sans-serif`, `monospace` e `serif` si trovano ovviamente al comando, poiché sono in circolazione dalla prima versione delle specifiche CSS.

Il più popolare e noto è `system-ui` al 3,6%, seguito da `ui-monospace` allo 0,5% e `ui-sans-serif` allo 0,4%. Non è chiaro cosa sperasse di ottenere lo 0,5% delle richieste con `fantasy`, poiché si tratta di un nome generico così poco preciso da essere di fatto inutile.

Speriamo il prossimo anno di vedere un uso maggiore di questi nomi generici di famiglie. Sono adattissimi agli elementi dell'interfaccia utente, ai moduli o a qualsiasi altra situazione per la quale si desideri richiamare un'atmosfera nativa del contesto. Come ulteriore vantaggio, sono anche ottimi per le prestazioni in quanto garantiscono l'uso di un font installato localmente.

### <i lang="en">Font smoothing</i> (smussamento dei contorni dei font)

{{ figure_markup(
  image="usage-of-font-smoothing-properties.png",
  caption="Uso delle proprietà di font smoothing.",
  description="Il grafico a barre mostra che `-webkit-font-smoothing: antialiased` è utilizzato nel 74% delle pagine desktop e nel 73% delle pagine mobili, `-moz-osx-font-smoothing: grayscale` nel 67% e 66%, `-webkit- font-smoothing: auto` nel 13% e 12%, e infine `-webkit-font-smoothing: subpixel-antialiased` viene utilizzato nel 13% delle pagine desktop e nel 13% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=534216530&format=interactive",
  sheets_gid="1970926839",
  sql_file="font_smoothing_usage.sql"
  )
}}

E ora, una sorpresa assoluta, per noi almeno: sembra che alle persone piaccia davvero specificare solo per i sistemi MacOS le proprie [preferenze di font smoothing](https://developer.mozilla.org/docs/Web/CSS/font-smooth). Ad esempio, il valore `-webkit-font-smoothing: antialiased` viene utilizzato sul 73,4% di tutti i siti. La cosa è sorprendente perché questa prprietà - come le sorelle `-mox-osx-font-smoothing` e `font-smoothing` - non è nemmeno una proprietà CSS ufficiale. Queste proprietà CSS sono forse le proprietà non ufficiali più utilizzate!

La nostra impressione è che questo sia derivato da una combinazione di fattori: framework CSS che includono queste proprietà da una parte e un'antipatia per la resa dei font su MacOS (leggermente più in grassetto) dall'altra: l'asse grade dei font variabili ci venga in soccorso! Sarà interessante tornare su queste proprietà nel capitolo Font del 2023. E poi, forse, è il momento di iniziare a immettere queste proprietà negli standard, no? C'è una chiara domanda a riguardo.

## Font variabili

I _font variabili_ consentono ai progettisti di caratteri di combinare più stili di una famiglia in un unico file di font. Lo fanno definendo uno o più assi di progettazione, come peso (sottile, regolare e grassetto) o larghezza (condensato, normale ed espanso). Invece di memorizzare gli stili come singoli file di font, un font variabile li interpola da una manciata di istanze "master".

Ad esempio, anche se il type designer non ha creato esplicitamente uno stile semigrassetto, utilizzando un font variabile con un asse di spessore, il motore di rendering del testo interpolerà per noi in automatico uno stile semigrassetto (e qualsiasi altro peso di cui potremmo aver bisogno, a condizione che il l'asse del peso del font variabile supporti tale intervallo). I font variabili non solo aumentano l'espressività tipografica, ma offrono anche un grande vantaggio per gli sviluppatori web in termini di risparmio di dimensioni dei file quando vengono utilizzate diverse varianti del font. Ad ogni modo i font variabili sono più pesanti se comparati al peso di una singola variazione.

{{ figure_markup(
  image="usage-of-variable-fonts.png",
  caption="Uso dei font variabili.",
  description="Grafico a colonne che mostra che nel 2020 l'11% delle pagine su desktop e dispositivi mobili utilizzava font variabili, nel 2021 è cresciuto fino al 13% di entrambi e nel 2022 ha raggiunto il 28% delle pagine desktop e il 29% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=920070467&format=interactive",
  sheets_gid="1460535004",
  sql_file="variable_font_usage.sql"
  )
}}

L'utilizzo dei font variabili è quasi triplicato dall'ultima misurazione nel capitolo Font del Web Almanac 2020! Quasi il 29% dei siti web utilizza font variabili. La maggior parte di questa crescita sembra essere avvenuta nell'ultimo anno, con un'incredibile crescita del 125%.

{{ figure_markup(
  content="97%",
  caption="Font variabili utilizzati serviti da Google Fonts.",
  classes="big-number",
  sheets_gid="325872648",
  sql_file="variable_font_googlefonts_vs_other.sql",
) }}

Questa impressionante crescita dell'utilizzo può essere spiegata suddividendo i dati della richiesta per host. Google Fonts rappresenta il 97% dei font variabili serviti, mentre tutti gli altri rappresentano solo il 3%. Anche considerando l'enorme presenza di Google nel servizio di hosting dei web font, questa crescita può essere spiegata solo dalla sostituzione automatica dei font statici più diffusi con le rispettive versioni variabili, piuttosto che dall'introduzione di font variabili completamente nuovi.

In conseguenza di ciò, Google Fonts e i suoi utenti hanno probabilmente enormi benefici in termini di prestazioni. Un font variabile è generalmente più leggero rispetto all'utilizzo di più istanze statiche. Ad esempio, se un sito web utilizza più di due o tre stili della stessa famiglia, un font variabile ha dimensioni del file inferiori e richiede una singola richiesta. Non ci vuole molto [per avere il beneficio]: l'uso di tre pesi (normale, bold e light) è generalmente una ragione sufficiente per passare ad un font variabile. Come ulteriore vantaggio, con un font variabile è possibile anche regolare gli assi in base alle proprie esigenze: qualcuno desidera un semi-demi-grassetto?

Indipendentemente dal fatto che vi sia un singolo responsabile della crescita, si tratta di un risultato straordinario e un buon indice dell'utilità dei font variabili per ottimizzare le prestazioni dei nostri siti.

I font variabili hanno anche due formati concorrenti: le estensioni variabili del formato `glyf` e il formato Compact Font Format 2 (`CFF2`). Le principali differenze del formato `glyf` con il formato `CFF2` sono le stesse che col suo predecessore `CFF`: tipologie di curve di Bézier differenti, hinting più automatizzato e una rivendicazione di dimensioni di file più piccole.

{{ figure_markup(
  content="99.99%",
  caption="Font variabili che usano il formato di outline `glyf`.",
  classes="big-number",
  sheets_gid="993301429",
  sql_file="types_of_variable_font.sql",
) }}

Quindi, quale formato si dovrebbe usare? Fortunatamente, per sviluppatori, type designer e fornitori di browser la situazione è abbastanza chiara. Di tutti i font variabili offerti, il 99,99% utilizza il formato variabile `glyf`. Anche se si escludono dal calcolo Google Fonts e altri servizi di font, il numero arriva alla considerevole cifra del 99,98%. Nessuno usa `CFF2`.

Il nostro consiglio è di evitare i font variabili basati su `CFF2` (almeno per ora). I browser e i sistemi operativi hanno aggiunto solo di recente il supporto per `CFF2` e alcuni browser ancora non lo supportano. L'unico vantaggio tangibile dell'utilizzo di font variabili basati su `CFF2` rispetto a quelli basati su `glyf` è il presunto risparmio di dimensioni del file, ma come abbiamo visto nella sezione delle prestazioni questa affermazione è nella migliore delle ipotesi dubbia.

{{ figure_markup(
  image="usage-of-font-variation-settings-axes.png",
  caption="Uso degli assi con la proprietà font-variation-settings.",
  description="L'istogramma mostra che `wght` è utilizzato nel'82% delle pagine desktop e nel'87% delle pagine mobili, `opsz` rispettivamente nel 5% e nel 4%, `wdth` nel 5% e 4%, `slnt` nel 3% e 2 %, `ital` nel 2% e 1% e infine `GRAD` viene utilizzato nell'1% delle pagine desktop e mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=2021084759&format=interactive",
  sheets_gid="1634075051",
  sql_file="variable_font_axis_css.sql"
  )
}}

Quindi, le persone come stanno usando i font variabili? Non sorprende che sia l'asse del peso il valore più utilizzato con la proprietà `font-variation-settings`, seguito da dimensioni ottiche (opsz), larghezza (wdth), inclinazione (slnt), corsivo (ital) e gradi (GRAD).

Questo in qualche modo ci ha sorpreso, perché non è necessario utilizzare la proprietà di basso livello `font-variation-settings` per impostare un valore personalizzato per l'asse del peso. Si può semplicemente utilizzare la proprietà `font-weight` con un valore personalizzato, ad esempio `font-weight: 550` per uno spessore a metà tra 500 e 600.

{{ figure_markup(
  image="popular-variable-font-weight-values.png",
  caption="Valori più diffusi per il peso dei font variabili.",
  description="Il grafico a barre mostra che uno peso del font di `400` viene utilizzato nel 22% delle pagine desktop che utilizzano font variabili e nel 23% delle pagine mobili che utilizzano font variabili, `600` nel 22% di entrambi, `700` nel 21% di desktop e 22% delle pagine mobili, `300` rispettivamente nel 19% e 21%, `500` nel 4% e 3%, `800` nel 2% di entrambi i tipi di pagine, `550` nel 2% su desktop e 1% sulle pagine mobili, `900` nell'1% di entrambi, `200` nell'1% di entrambi e infine `450` nell'1% di entrambi i tipi di pagine: desktop e mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1275376550&format=interactive",
  sheets_gid="1634075051",
  sql_file="variable_font_axis_css.sql",
  width=600,
  height=401
  )
}}

Ancora più sconcertante è notare che i valori dell'asse del peso più popolari sono i valori di peso CSS "di default" che esistono sin dagli esordi dei CSS! Solo il 16% dei valori di peso sono valori personalizzati lungo la gamma dei pesi.

Il peso "personalizzato" più popolare è `550` con solo l'1,5% di utilizzo, seguito da `450` con l'1% di utilizzo. Risultati simili possono essere osservati per gli assi della dimensione ottica, della larghezza, dell corsivo e dell'inclinazione, che possono essere impostati utilizzando le proprietà di alto livello `font-optical-sizing`, `font-stretch` e `font-style`. L'uso delle proprietà di alto livello rende il CSS più leggibile ed evita la disabilitazione accidentale di un asse, errore comune con la proprietà di basso livello.

Uno dei vantaggi maggiormente sbandierati dei font variabili è la possibilità di animazione di uno o più assi. Nonostante l'elevato utilizzo di font variabili, pochissime persone li stanno effettivamente animando tramite transizioni CSS o fotogrammi chiave. Dell'intero set di dati dell'HTTP Archive, solo un paio di centinaia di siti web eseguono un qualche tipo di animazione che coinvolge font variabili.

A noi sembra che i font variabili siano usati principalmente per un vantaggio in termini di prestazioni e meno per la loro capacità di apportare regolazioni tipografiche. Anche se le prestazioni sono un ottimo motivo, speriamo di vedere più persone utilizzare i font variabili al massimo del loro potenziale tipografico nei prossimi anni.

## Font a colori (<i lang="en">Color fonts</i>)

I font a colori sono più o meno quello che ci si potrebbe aspettare: font con colori incorporati. Sebbene la tecnologia sia stata originariamente creata per i font emoji, ora ci sono più font di testo a colori rispetto ai font emoji.

{{ figure_markup(
  image="color-font-usage.png",
  caption="Uso dei font a colori.",
  description="Il grafico a colonne mostra che nel 2020 i font a colori sono stati utilizzati nello 0,005% delle pagine desktop e nello 0,004% delle pagine mobili, nel 2021 rispettivamente nello 0,013% e nello 0,015%, nel 2022 nello 0,015% delle pagine desktop e nello 0,018% delle pagine mobili.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=1366906842&format=interactive",
  sheets_gid="1630630917",
  sql_file="color_font_usage.sql"
  )
}}

L'utilizzo dei caratteri a colori è cresciuto un po' dall'ultimo capitolo sui Font del 2020. L'utilizzo è passato dallo 0,004% delle pagine che utilizzavano font a colori nel 2020 a circa lo 0,018% nel 2022. Sebbene questi numeri siano ancora minimi, c'è una chiara crescita nell'utilizzo.

Tuttavia, rispetto alla crescita nell'utilizzo dei font variabili, l'adozione limitata dei caratteri a colori è alquanto deludente. Se è vero che i font a colori sono un'aggiunta relativamente nuova alla specifica OpenType (2015), è vero anche che i font variabili sono un'aggiunta ancora più recente (2016).

I fattori principali che hanno fortemente ostacolato l'adozione dei font a colori (e potrebbero continuare a farlo) sono da una parte l'infinita "battaglia" sullo standard per il _formato definitivo dei font a colori_, dall'altra la mancanza di supporto dei browser per il CSS che consente di selezionare e modificare le _font palettes_ (tavolozze colori dei font), almeno fino a poco tempo fa.

Attualmente ci sono quattro formati di font a colori concorrenti: due basati su contorni vettoriali (`SVG` e `COLR`) e due basati su immagini (`CBDT` e `sbix`). Il formato `COLR` riutilizza il contorno esistente del glifo  per aggiungere dei colori solidi e dei livelli. La versione più recente, soprannominata `COLRv1`, ha introdotto inoltre i gradienti e delle modalità di composizione e fusione dei livelli. Grazie al riutilizzo dei contorni esistenti dei glifi, il formato `COLR` supporta anche i font variabili, quindi si possono avere <a hreflang="en" href="https://www.typearture.com/variable-fonts/">font a colori animati</a>. Il formato `SVG` adotta un approccio diverso ed essenzialmente incorpora nel font un'immagine SVG per ciascun glifo. Sfortunatamente, il formato `SVG` non supporta i font variabili ed è improbabile che lo faccia in futuro. Sia `CBDT` che `sbix` incorporano immagini per ciascun glifo e differiscono fra loro solo per i formati di immagine supportati.

{{ figure_markup(
  image="color-font-formats.png",
  caption="I formati dei font a colori.",
  description="Il grafico a torta mostra che SVG è il font a colori utilizzato il 74,2% delle volte sui dispositivi mobili, COLRv0 il 22,8%, CBDT il 2,5%, sbix lo 0,2% e infine COLRv1 anche lui lo 0,2% delle volte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQF6OH_2-0apcFzjE-iHSQNuZqp9DtM7udIeOzPSOSMM-Pf6KdTnRwAclX9QPZF1vNNgu6acZvqoN5b/pubchart?oid=2109618513&format=interactive",
  sheets_gid="1976816146",
  sql_file="color_fonts.sql"
  )
}}

Dando uno sguardo ai dati di utilizzo vediamo un quadro interessante: il 79% degli impieghi dei font a colori usa il formato `SVG`, il 19% adopera `COLRv0` e il 2% utilizza `CBDT`.

Possiamo dunque sicuramente concludere che i formati basati su immagini non sono popolari, e per buoni motivi: le immagini incorporate non si ridimensionano bene e il peso dei file non è appropriato per l'utilizzo sul web.

Anche se la divisione tra i formati vettoriali dei font a colori è più sfumata. Mentre `SVG` sembra avere il sopravvento al momento, `COLR` ha comunque un utilizzo significativo. Il formato `COLR` ha molto da offrire: è supportato da tutti i browser, può essere utilizzato per i font variabili ed è facile da implementare. Se non altro per questi motivi, ci aspettiamo che diventi il formato più popolare. Una versione più cinica è che diventerà il formato più popolare perché Google si <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=306078">rifiuta di implementare il supporto `SVG` in Chrome e Android</a>. È interessante notare che <a hreflang="en" href="https://lists.webkit.org/pipermail/webkit-dev/2021-March/031765.html">Apple si rifiuta di implementare `COLRv1`</a>, perché molte funzionalità `COLRv1` sono già supportate dal formato `SVG`. Sfortunatamente, gli sviluppatori web sono immobilizzati nel mezzo di questa "guerra dei font a colori". Ci auguriamo che questa situazione si risolva presto per poter tutti iniziare ad utilizzare i font a colori.

La specifica CSS è stata aggiornata nel supporto ai font a colori in modo da consentire <a hreflang="en" href="https://css-tricks.com/colrv1-and-css-font-palette-web-typography/">la selezione e la personalizzazione delle tavolozze colori</a>. Le tavolozze colori (<i lang="en">color palettes</i>) sono schemi colore personalizzati memorizzati nel font dal type designer. La proprietà CSS `font-palette` consente di selezionare una tavolozza prevista dal font e la regola `@font-palette-values` permette di creare nuove tavolozze o sovrascrivere quelle esistenti. Uno dei casi d'uso più ovvi di questa tecnologia è avere le tavolozze delle modalità chiare e scure integrate direttamente nel font a colori. C'è un sacco di potenziale inesplorato da quelle parti.

{{ figure_markup(
  image="bradley-initials.png",
  caption='<a hreflang="en" href="https://tools.djr.com/misc/bradley-initials/">Bradley Initials</a>, di <a hreflang="en" href="https://djr.com/">David Jonathan Ross</a>, utilizza COLR v1 e tavolozze multiple.',
  description="Uno specimen del carattere Bradley Initials di David Jonathan Ross che mostra sei diverse tavolozze colore.",
  width=1911,
  height=1142
  )
}}

Sfortunatamente, l'utilizzo di queste proprietà CSS è attualmente inesistente. Ciò è probabilmente dovuto al fatto che il supporto per queste proprietà è stato aggiunto solo di recente ai browser, in combinazione con il numero limitato di font a colori disponibili.

Uno dei principali fattori alla base dello sviluppo della tecnologia dei font a colori sono stati gli emoji. Tuttavia, ci sono solo un paio di dozzine di web font che hanno emoji a colori. La maggior parte dei font a colori serve per scrivere testo, non emoji. Potrebbero esserci diverse spiegazioni per questo:

- Ogni sistema operativo include già il proprio font emoji a colori, quindi gli utenti non sentono il bisogno di usarne altri.
- Ci sono tantissimi emoji e ci vuole molto impegno, e denaro, per creare font con emoji.
- I font con emoji sono generalmente abbastanza grandi e dunque non adatti come web font.

Ad ogni modo, sarebbe bello vedere un po' più di diversità nei font di emoji. Con l'introduzione del formato COLR v1 è probabile che in futuro vedremo più font di emoji.

Lo ripeto: tutto ciò si basa su numeri di utilizzo molto bassi, ma sembrano esserci alcune tendenze in via di sviluppo. Non siamo ancora pronti per dichiarare il 2023 l'anno dei font a colori, ma sembra chiaro che vedremo una crescita significativa dei font a colori nei prossimi anni, soprattutto se l'industria si accorda su un unico formato di font a colori e se migliora il supporto del browser per i font a colori. Google Fonts ha anche appena aggiunto alla propria libreria <a hreflang="en" href="https://material.io/blog/color-fonts-are-here">il primo lotto di font a colori</a>, il che avrà sicuramente un impatto.

## Conclusione

Riguardando questo capitolo e i capitoli degli anni precedenti, risulta evidente l'impatto che i servizi di web font hanno avuto e probabilmente continueranno ad avere. Ad esempio, Google Fonts da solo ha causato la maggior parte di utilizzi dei web font, ha messo in campo la maggior parte dei web font più diffusi e servito la maggior parte dei font variabili. È un'impresa impressionante.

Anche se crediamo fermamente che il self-hosting sia il futuro per i web font, non si può negare che l'utilizzo di un servizio di web font abbia molto senso per molti sviluppatori. Sono facili da usare, offrono delle buone prestazioni pronte all'uso, anche se non le migliori, e sostanzialmente non occorre preoccuparsi delle licenze dei font. È un buon compromesso.

D'altra parte, il self-hosting ora è più facile di quanto non lo sia mai stato e offre le migliori prestazioni, un maggior controllo e nessun problema di privacy. Se pensiamo di pubblicare i font in self-hosting, assicuriamoci di utilizzare WOFF2, i suggerimenti per le risorse e `font-display`. La combinazione di questi tre fattori avrà il maggiore impatto possibile sulle prestazioni del caricamento dei font del sito.

I font variabili sono decollati in modo spettacolare negli ultimi due anni - grazie Google! Sebbene la maggior parte delle persone sembri utilizzarli per motivi di prestazioni, riteniamo che questo sia un caso in cui l'adozione guiderà l'innovazione. Non vediamo l'ora di vedere che tipo di tipografia divertente e sicuramente pazzesca emergerà nei prossimi anni.

Siamo cautamente ottimisti anche sui font a colori. L'utilizzo è finalmente in aumento. La tecnologia esiste da un po', ma i disaccordi sui formati dei font a colori e il limitato supporto CSS ne hanno ostacolato l'adozione. Ci auguriamo che questi problemi vengano risolti presto e che inizieremo a vedere una vera crescita.

È chiaro che l'utilizzo dei font web continuerà a crescere e ad evolvere nel tempo. Siamo curiosi di vedere cosa ci riserva il futuro. Tecnologie come <a hreflang="en" href="https://www.w3.org/TR/IFT/">Incremental Font Transfer</a> (trasferimento incrementale dei font) sbloccheranno i web font per un maggior numero di sistemi di scrittura, consentendo a miliardi di persone di iniziare a utilizzare i web font per la prima volta. Questo futuro è eccitante!
