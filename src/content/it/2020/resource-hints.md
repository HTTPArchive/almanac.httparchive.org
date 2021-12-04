---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Resource Hints
description: Capitolo Resource Hints del Web Almanac 2020 che copre l'utilizzo di dns-prefetch, preconnect, preload, prefetch, Priority Hints, and native lazy loading.
authors: [Zizzamia]
reviewers: [jessnicolet, pmeenan, giopunt, mgechev, notwillk]
analysts: [khempenius]
editors: [exterkamp]
translators: [chefleo]
Zizzamia_bio: Leonardo è uno Staff Software Engineer presso <a hreflang="en" href="https://www.coinbase.com/">Coinbase</a>, leader nel web performance e iniziative di crescita. È a cura della <a hreflang="en" href="https://ngrome.io">conferenza NGRome</a>. Leo gestisce anche la libreria <a hreflang="en" href="https://github.com/Zizzamia/perfume.js"> Perfume.js </a>, che aiuta le aziende a stabilire le priorità delle roadmap e a prendere decisioni aziendali migliori attraverso la performance analytics.
discuss: 2057
results: https://docs.google.com/spreadsheets/d/1lXjd8ogB7kYfG09eUdGYXUlrMjs4mq1Z7nNldQnvkVA/
featured_quote: Durante lo scorso anno, le resource hints sono aumentati nell'adozione e sono diventati API essenziali per gli sviluppatori per avere un controllo più granulare su molti aspetti delle priorità delle risorse e, in definitiva, sull'user experience.
featured_stat_1: 33%
featured_stat_label_1: Siti che utilizzano `dns-prefetch`
featured_stat_2: 9%
featured_stat_label_2: Siti che utilizzano `preload`
featured_stat_3: 4.02%
featured_stat_label_3: Siti che utilizzano native lazy loading
---

## Introduzione

Negli ultimi dieci anni <a hreflang="en" href="https://www.w3.org/TR/resource-hints/">resource hints</a> sono diventati essenzialmente delle primitive che consentono agli sviluppatori di migliorare le prestazioni della pagina e l'user experience.

Il precaricamento delle risorse e il fatto che i browser applichino una priorità intelligente è qualcosa che è stato effettivamente avviato nel lontano 2009 da IE8 con qualcosa chiamato <a hreflang="en" href="https://speedcurve.com/blog/load-scripts-async/">preloader</a>. Oltre al parser HTML, IE8 aveva un preloader leggero che analizzava i tag in grado di avviare richieste di rete (`<script>`, `<link>` e `<img>`).

Negli anni successivi, i fornitori di browser hanno svolto sempre più il grosso del lavoro, ognuno aggiungendo la propria salsa speciale su come dare la priorità alle risorse. Ma è importante capire che da solo il browser ha alcune limitazioni. In qualità di sviluppatori, tuttavia, possiamo superare questi limiti facendo un buon uso delle resource hints e aiutandoci a decidere come assegnare la priorità alle risorse, determinando quali dovrebbero essere fetched o preprocessed per aumentare ulteriormente le prestazioni della pagina.

In particolare possiamo citare alcune vittorie raggiunte/ottenute nell'ultimo anno riguardante le resource hints:
- <a hreflang="en" href="https://www.zachleat.com/web/css-tricks-web-fonts/">CSS-Tricks</a> web fonts vengono visualizzati più velocemente su un primo rendering 3G.
- <a hreflang="en" href="https://www.youtube.com/watch?v=4QqlGgF8Y2I&t=1469">Wix.com</a> l'utilizzo delle resource hints ha ottenuto un miglioramento del 10% per FCP.
- <a hreflang="en" href="https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/">Ironmongerydirect.co.uk</a> ha utilizzato la preconnect per migliorare il caricamento dell'immagine del prodotto di 400 ms alla mediana e di oltre 1s al 95° percentile.
- <a hreflang="en" href="https://engineering.fb.com/2020/05/08/web/facebook-redesign/">Facebook.com</a> preload utilizzato per una navigazione più veloce.

Diamo un'occhiata alle resource hints più predominanti supportati ultimamente dalla maggior parte dei browser: `dns-prefetch`, `preconnect`, `preload`, `prefetch`, e <i lang="en">native lazy loading</i>.

Quando si lavora con ogni singolo hint, consigliamo di misurare sempre l'impatto prima e dopo sul campo, utilizzando librerie come <a hreflang="en" href="https://github.com/GoogleChrome/web-vitals">WebVitals</a>, <a hreflang="en" href="https://github.com/zizzamia/perfume.js">Perfume.js</a> o qualsiasi altra utility che supporti le metriche di Web Vitals.

### `dns-prefetch`

<a hreflang="en" href="https://web.dev/preconnect-and-dns-prefetch/">dns-prefetch</a> aiuta a risolvere in anticipo l'indirizzo IP per un determinato dominio. Essendo la più <a hreflang="en" href="https://caniuse.com/link-rel-dns-prefetch"> vecchia </a> resource hint disponibile, utilizza CPU e risorse di rete minime rispetto a `preconnect` e aiuta il browser a evitare di sperimentare il "worst-case" delay per la risoluzione DNS, che può essere <a hreflang="en" href="https://www.chromium.org/developers/design-documents/dns-prefetching">oltre 1 secondo</a>.

```html
<link rel="dns-prefetch" href="https://www.googletagmanager.com/">
```

Fai attenzione quando usi `dns-prefetch` perché anche se sono leggeri da fare è facile esaurire i limiti del browser per il numero di richieste DNS simultanee in volo consentite (Chrome ha ancora un <a hreflang="en" href="https://source.chromium.org/chromium/chromium/src/+/master:net/dns/host_resolver_manager.cc;l=353">limite di 6</a>).

### `preconnect`

<a hreflang="en" href="https://web.dev/uses-rel-preconnect/">preconnect</a> aiuta a risolvere l'indirizzo IP e ad aprire in anticipo una connessione TCP/TLS per un dato dominio. Simile a `dns-prefetch`, viene utilizzato per qualsiasi dominio cross-origin e aiuta il browser a riscaldare le risorse utilizzate durante il caricamento iniziale della pagina.

```html
<link rel="preconnect" href="https://www.googletagmanager.com/">
```

Sii consapevole quando usi `preconnect`:

- Riscaldare solo le risorse più frequenti e significative.
- Evitare di riscaldare le origini utilizzate troppo tardi nel caricamento iniziale.
- Usalo per non più di tre origini perché può avere costi di CPU e batteria.

Infine, `preconnect` non è disponibile per <a hreflang="en" href="https://caniuse.com/?search=preconnect">Internet Explorer o Firefox</a>, e <a hreflang="en" href="https://web.dev/preconnect-and-dns-prefetch/#resolution-domain-name-early-with-reldns-prefetch">usare `dns-prefetch` come fallback</a> è altamente consigliato.

### `preload`

L'hint <a hreflang="en" href="https://web.dev/uses-rel-preload/">preload</a> avvia una richiesta anticipata. Ciò è utile per caricare risorse importanti che altrimenti verrebbero scoperte in ritardo dal parser.

```html
<link rel="preload" href="style.css" as="style">
<link rel="preload" href="main.js" as="script">
```

Sii consapevole quando andrai ad utilizzare `preload`, perché può ritardare il download di altre risorse, quindi usalo solo per ciò che è più critico per aiutarti a migliorare il Largest Contentful Paint (<a hreflang="en" href="https://web.dev/lcp/">LCP</a>). Inoltre, se utilizzato su Chrome, tende a dare priorità alle risorse di "preload" e potenzialmente invia preloads prima di altre risorse critiche.

Infine, se usati in un header di risposta HTTP, alcuni CDN trasformeranno automaticamente un "preload" in un <a hreflang="en" href="#http2-push">HTTP/2 push</a> che può sovraccaricare le risorse memorizzate nella cache.

### `prefetch`

L'hint <a hreflang="en" href="https://web.dev/link-prefetch/">prefetch</a> ci permette di avviare richieste a bassa priorità che ci aspettiamo vengano usate nella prossima navigazione. L'hint scaricherà le risorse e le rilascerà nella cache HTTP per un utilizzo successivo. È importante notare che `prefetch` non eseguirà o elaborerà in altro modo la risorsa, e per eseguirlo la pagina dovrà comunque chiamare la risorsa tramite il tag `<script>`.

```html
<link rel="prefetch" as="script" href="next-page.bundle.js">
```

Esistono diversi modi per implementare la logica di previsione di una risorsa, che potrebbe essere basata su segnali come il movimento del mouse dell'utente, flussi/percorsi comuni degli utenti o anche sulla base di una combinazione di entrambi in aggiunta al machine learning.

Fai attenzione, a seconda della <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues#current-status">qualità</a> della prioritizzazione HTTP/2 del CDN utilizzato, la prioritizzazione di `prefetch` potrebbe migliorare le prestazioni o renderle più lente, dando priorità alle richieste di `prefetch` e togliendo della larghezza di banda importante per il caricamento iniziale. Assicurati di ricontrollare la CDN che stai utilizzando e adattati per prendere in considerazione alcune delle migliori pratiche condivise di <a hreflang="en" href="https://andydavies.me/blog/2020/07/08/rel-equals-prefetch-and-the-importance-of-effective-http-slash-2-prioritisation/">Andy Davies's</a>.

### Native lazy loading

L'hint <a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/">native lazy loading</a> è un'API del browser nativa per differire il caricamento di immagini offscreen e iframe. Usandolo, le risorse che non sono necessarie durante il caricamento iniziale della pagina non avvieranno una richiesta di rete, questo ridurrà il consumo di dati e migliorerà le prestazioni della pagina.

```html
<img src="image.png" loading="lazy" alt="…" width="200" height="200">
```

Tieni presente che l'implementazione di Chromium della logica delle soglie di lazy-loading è stata storicamente piuttosto <a hreflang="en" href="https://web.dev/browser-level-image-lazy-loading/#distance-from-viewport-thresholds">conservativa</a>, mantenendo il limite offscreen a 3000px. Durante l'ultimo anno il limite è stato attivamente testato e migliorato per allineare meglio le aspettative degli sviluppatori e, infine, spostare le soglie a 1250px. Inoltre, non esiste <a hreflang="en" href="https://github.com/whatwg/html/issues/5408">nessuno standard nei browser</a> e non è ancora possibile per gli sviluppatori web ignorare le soglie predefinite fornite dai browser.

## Resource hints

Sulla base dell'archivio HTTP, passiamo all'analisi delle tendenze del 2020 e confrontiamo i dati con il precedente dataset del 2019.

### Hints adoption

Sempre più pagine web utilizzano le principali resource hints, e nel 2020 stiamo vedendo che l'adozione rimane coerente tra desktop e mobile.

{{ figure_markup(
  image="adoption-of-resource-hints.png",
  caption="Adozione delle resource hints.",
  description="Un grafico a barre del tasso di adozione delle resource hint suddiviso per tipo di hint e fattore di form. Per desktop, il 33% delle pagine usa la resource hint `dns-prefetch`, il 18% usa `preload`, l'8% usa `preconnect`, il 3% usa `prefetch` e meno dell'1% usa `prerender`. Mobile è simile, tranne per il fatto che `dns-prefetch` ha un utilizzo del 34% (1% in più) e `preconnect` ha il 9% (1% in più).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1550112064&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

La relativa popolarità di `dns-prefetch` con il 33% di adozione rispetto ad altre resource hints non sorprende poiché è apparso per la prima volta nel 2009 e ha il supporto più ampio tra tutti le principali resource hints.

Rispetto a <a href="../2019/resource-hints#resource-hints">2019</a>, `dns-prefetch` ha avuto un aumento del 4% nell'adozione su desktop. Abbiamo visto un aumento simile anche su "preconnect". Uno dei motivi principali per cui questa è stata la crescita più grande tra tutti le hints, è il chiaro e utile consiglio che il <a hreflang="en" href="https://web.dev/uses-rel-preconnect/">Lighthouse audit</a> sta dando su questo argomento. A partire dal rapporto di quest'anno, introduciamo anche come si comporta l'ultimo dataset rispetto alle raccomandazioni di Lighthouse.

{{ figure_markup(
  image="resource-hint-adoption-2019-vs-2020.png",
  caption="Adozione delle resource hints 2019 vs 2020.",
  description="Un grafico a barre che confronta il tasso di adozione delle resource hints nei dispositivi mobile tra il 2019 e il 2020, suddiviso per tipo di hint. Mostra un aumento dell'utilizzo in quasi tutti i tipi di resource hints. `dns-prefetch` è aumentato del 5%, dal 29% al 34%. `preload` aumentato del 2%, dal 16% al 18%. `preconnect` è aumentato del 5%, dal 4% al 9%. `prefetch` è rimasto invariato al 3% di utilizzo. Anche `prerender` è rimasto invariato con un utilizzo inferiore all'1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1494186122&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

L'utilizzo di `preload` ha avuto una crescita più lenta con solo un aumento del 2% dal 2019. Ciò potrebbe essere in parte dovuto al fatto che richiede un po' più di specifiche. Anche se hai solo bisogno del dominio per usare `dns-prefetch` e `preconnect`, devi specificare la risorsa per usare `preload`. Mentre `dns-prefetch` e `preconnect` sono ragionevolmente a basso rischio, sebbene possano ancora essere abusati, `preload` ha un potenziale maggiore di danneggiare effettivamente le prestazioni se usato in modo errato.

`prefetch` è usato dal 3% dei siti su Desktop, rendendolo la resource hint meno utilizzata. Questo basso utilizzo può essere spiegato dal fatto che `prefetch` è utile per migliorare i caricamenti delle pagine successive, piuttosto che correnti. Pertanto, verrà trascurato se un sito si concentra solo sul miglioramento della sua pagina di destinazione o sul rendimento della prima pagina visualizzata. Negli anni a venire, con una definizione più chiara di cosa misurare per migliorare la successiva esperienza della pagina, potrebbe aiutare i team a dare la priorità all'adozione di `prefetch` con chiari obiettivi di qualità delle prestazioni da raggiungere.

### Hints per pagina

Gli sviluppatori stanno imparando a usare meglio le resource hints e rispetto al <a href="../2019/resource-hints#resource-hints">2019</a> abbiamo visto un uso migliorato di `preload`, `prefetch` e `preconnect`. Per operazioni costose come preload e preconnect, l'utilizzo mediano sul desktop è diminuito da 2 a 1. Abbiamo visto l'opposto per caricamento delle risorse future con una priorità inferiore con `prefetch`, con un aumento da 1 a 2 in mediana per pagina.

{{ figure_markup(
  image="median-number-of-hints-per-page.png",
  caption="Numero mediano di hint per pagina.",
  description="Un grafico a barre che mostra il numero mediano di resource hints presenti per pagina suddiviso per tipo di resource hint e fattore di form. `preload` e `prerender` hanno entrambi (mediano) un hint per pagina sia su dispositivo mobile che su desktop. `prefetch` e `dns-prefetch` hanno entrambi (mediana) due hints per pagina sia su dispositivo mobile che su desktop. `preconnect` ha (mediana) un hint per pagina su desktop e (mediana) due hints per pagina su dispositivo mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=320451644&format=interactive",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

Le resource hints sono più efficaci quando vengono utilizzati in modo selettivo ("quando tutto è importante, niente lo è"). Avere una definizione più chiara di quali risorse aiutano a migliorare il rendering critico, rispetto alle future ottimizzazioni di navigazione, può spostare l'attenzione dall'uso di `preconnect` e più verso `prefetch` spostando parte della priorità delle risorse e liberando la larghezza di banda per ciò che più aiuta l'utente all'inizio.

Tuttavia, questo non ha impedito un uso improprio del hint `preload`, poiché in un caso abbiamo scoperto una pagina che aggiungeva dinamicamente l'hint e causava un ciclo infinito che ha creato oltre 20k nuovi precarichi.

{{ figure_markup(
  caption="Le hints più precaricati su una singola pagina.",
  content="20,931",
  classes="big-number",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

Man mano che creiamo sempre più automazione con le resource hints, sii cauto quando si inseriscono dinamicamente le hint di preload o qualsiasi elemento per quella materia!

### L'attributo `as`

Con `preload` e `prefetch`, è fondamentale usare l'attributo `as` per aiutare il browser a dare la priorità alla resource in modo più accurato. Ciò consente una corretta memorizzazione nella cache per richieste future, l'applicazione della corretta Content Security Policy ([CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)) e l'impostazione le headers di richiesta "Accept" corrette.

Con `preload` possono essere precaricati molti diversi tipi di contenuto e la <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link#Attributes">lista completa</a> segue i consigli fatti nelle <a hreflang="en" href="https://fetch.spec.whatwg.org/#concept-request-destination">specifiche</a> Fetch. Il più popolare è il tipo `script` con il 64% di utilizzo. Ciò è probabilmente correlato a un ampio gruppo di siti creati come Single Page Apps che richiedono il pacchetto principale il prima possibile per avviare il download del resto delle loro dipendenze JS. L'utilizzo successivo proviene dal font all'8%, dallo stile al 5%, dall'immagine all'1% e dal fetch all'1%.

{{ figure_markup(
  image="mobile-as-attribute-values-by-year.png",
  caption="Valori dell'attributo `as` mobile per anno.",
  description="Un grafico a barre che confronta il tasso di valori dell'attributo `as` sulle pagine mobile del 2019 e del 2020, suddiviso per valore dell'attributo `as`. La maggior parte dei valori `as` sono `script` con l'81% di utilizzo nel 2019 e il 64% nel 2020. L'utilizzo di `script` è diminuito del 17% anno su anno, mentre tutti gli altri valori sono aumentati. `non impostato` aumentato dell'8%, `font` aumentato del 5%, `style` aumentato del 2%, il resto dei valori notevoli sono dell'1% o meno per entrambi gli anni.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=903180926&format=interactive",
  sheets_gid="1829901599",
  sql_file="as_attribute_by_year.sql"
) }}

Rispetto alla tendenza in <a href="../2019/resource-hints#the-as-attribute">2019</a>, abbiamo visto una rapida crescita nell'utilizzo di font e style con l'attributo `as`. Ciò è probabilmente correlato agli sviluppatori che aumentano la priorità dei CSS critici e combinano anche i font `preload` con `display:optional` per <a hreflang="en" href="https://web.dev/optimize-cls/#web-fonts-causing-foutfoit">migliorare</a> Cumulative Layout Shift (<a hreflang="en" href="https://web.dev/cls/">CLS</a>).

Tieni presente che omettere l'attributo `as` o avere un valore non valido renderà più difficile per il browser determinare la priorità corretta e in alcuni casi, come gli script, può anche causare il fetch della risorsa due volte.

### L'attibuto `crossorigin`

Con le risorse `preload` e `preconnect` che hanno CORS abilitato, come i fonts, è importante includere l'attributo `crossorigin`, in modo che la risorsa venga utilizzata correttamente. Se l'attributo `crossorigin` è assente, la richiesta seguirà la politica della single-origin rendendo così inutile l'uso del preload.

{{ figure_markup(
  caption="La percentuale di elementi con `preload` che usano `crossorigin`.",
  content="16.96%",
  classes="big-number",
  sheets_gid="1185042785",
  sql_file="attribute_usage.sql"
) }}

Le ultime tendenze mostrano che il 16,96% degli elementi che `preload` imposta anche `crossorigin` e si caricano in modalità anonima (o equivalente), e solo lo 0,02% utilizza il caso `use-credentials`. Questa velocità è aumentata in concomitanza con l'aumento del precaricamento dei font, come accennato in precedenza.

```html
<link rel="preload" href="ComicSans.woff2" as="font" type="font/woff2" crossorigin>
```

Tieni presente che i fonts precaricati senza l'attributo `crossorigin` verranno recuperati <a hreflang="en" href="https://web.dev/preload-critical-assets/#how-to-implement-relpreload">due volte</a>!

### L'attributo `media`

Quando è il momento di scegliere una risorsa da usare con schermi di dimensioni diverse, cerca l'attributo `media` con `preload` per ottimizzare le tue query multimediali.

```html
<link rel="preload" href="a.css" as="style" media="only screen and (min-width: 768px)">
<link rel="preload" href="b.css" as="style" media="screen and (max-width: 430px)">
```

Vedere oltre 2.100 diverse combinazioni di media query nel dataset del 2020 ci incoraggia a considerare quanto sia ampia la varianza tra il concetto e l'implementazione del responsive design da un sito all'altro. I punti di interruzione sempre popolari `767px/768px` (resi popolari da Bootstrap tra gli altri) possono essere visti nei dati.

### Best practices

L'uso delle resource hints a volte può creare confusione, quindi esaminiamo alcune veloci best practice da seguire in base all'audit automatizzato di Lighthouse.

Per implementare in modo sicuro `dns-prefetch` e `preconnect` assicurati di averli in tag di link separati.

```html
<link rel="preconnect" href="http://example.com">
<link rel="dns-prefetch" href="http://example.com">
```

L'implementazione di un fallback `dns-prefetch` nello stesso tag `<link>` causa un <a hreflang="en" href="https://bugs.webkit.org/show_bug.cgi?id=197010">bug</a> in Safari che annulla la richiesta `preconnect`. Quasi il 2% delle pagine (~ 40k) ha segnalato il problema sia di `preconnect` che di `dns-prefetch` in una singola risorsa.

Nel caso dell'audit "<a hreflang="en" href="https://web.dev/uses-rel-preconnect/">Preconnect to required origins</a>", abbiamo visto che solo il 19,67% delle pagine ha superato il test, creando una grande opportunità per migliaia di siti web per iniziare a utilizzare `preconnect` o `dns-prefetch` per stabilire connessioni iniziali a importanti origins di terze parti.

{{ figure_markup(
  caption="La percentuale di pagine che superano l'audit Lighthouse `preconnect`.",
  content="19.67%",
  classes="big-number",
  sheets_gid="152449420",
  sql_file="lighthouse_preconnect.sql"
) }}

Infine, l'esecuzione dell'audit "<a hreflang="en" href="https://web.dev/uses-rel-preload/">Preload key requests</a>" di Lighthouse ha portato l'84,6% delle pagine a superare il test. Se stai cercando di usare `preload` per la prima volta, ricorda che i fonts e gli script critici sono un buon punto di partenza.

### Native Lazy Loading

Ora festeggiamo il primo anno dell'API <a hreflang="en" href="https://addyosmani.com/blog/lazy-loading/">Native Lazy Loading</a>, che al momento della pubblicazione ha già superato il <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">72%</a> supporto browser. Questa nuova API può essere utilizzata per posticipare il caricamento di iframe e immagini sulla pagina finché l'utente non scorre accanto a essi. Ciò può ridurre l'utilizzo dei dati, l'utilizzo della memoria e velocizzare i contenuti. Attivare il lazy load è semplice come aggiungere `loading = lazy` sugli elementi `<iframe>` o `<img>`.

{{ figure_markup(
  caption="La percentuale di pagine che utilizzano il native lazy loading.",
  content="4.02%",
  classes="big-number",
  sheets_gid="2039808014",
  sql_file="native_lazy_loading_attrs.sql"
) }}

L'adozione è ancora agli inizi, soprattutto con le soglie ufficiali all'inizio di quest'anno troppo conservative e solo di <a hreflang="en" href="https://addyosmani.com/blog/better-image-lazy-loading-in-chrome/">recente</a> si allineano con le aspettative degli sviluppatori. Con quasi il 72% dei browser che supportano il lazy loading di image/source, questa è un'altra area di opportunità, specialmente per le pagine che cercano di migliorare l'utilizzo dei dati e le prestazioni sui dispositivi di fascia bassa.

L'esecuzione dell'audit "<a hreflang="en" href="https://web.dev/offscreen-images/">Defer offscreen images</a>" di Lighthouse ha portato il 68,65% delle pagine a superare il test. Per queste pagine c'è la possibilità di caricare le immagini dopo che tutte le risorse critiche hanno terminato il caricamento.

Ricorda di eseguire l'audit sia su desktop che su dispositivi mobile poiché le immagini potrebbero spostarsi fuori dallo schermo quando la visualizzazione cambia.

## Prefetching predittivo

La combinazione di `prefetch` con il machine learning può aiutare a migliorare le prestazioni delle pagine successive. Una soluzione è <a hreflang="en" href="https://github.com/guess-js/guess">Guess.js</a> che ha compiuto il primo passo avanti nel prefetching predittivo, con oltre una dozzina di siti Web che già lo utilizzano in produzione.

<a hreflang="en" href="https://web.dev/predictive-prefetching/">Predictive prefetching</a> è una tecnica che utilizza metodi di analisi dei dati e machine learning per fornire un approccio al precaricamento basato sui dati. Guess.js è una libreria che supporta il prefetching predittivo per framework popolari (Angular, Nuxt.js, Gatsby e Next.js) e puoi trarne vantaggio oggi. Classifica le possibili navigazioni da una pagina e precarica solo il JavaScript che probabilmente sarà necessario in seguito.

A seconda del set di allenamento, il prefetching di Guess.js ha una precisione superiore al 90%.

Nel complesso, il prefetching predittivo è ancora un territorio inesplorato, ma combinato con il prefetch al passaggio del mouse e il prefetching di Service Worker, ha un grande potenziale per fornire esperienze istantanee a tutti gli utenti del sito Web, salvando i dati.

## HTTP/2 Push

<a href="./http">HTTP/2</a> ha una feature chiamata "server push" che può potenzialmente migliorare le prestazioni della pagina quando il tuo prodotto ha lunghi Round Trip Times ([RTT](https://developer.mozilla.org/en-US/docs/Glossary/Round_Trip_Time_(RTT))) o elaborazione server. In breve, invece di aspettare che il client invii una richiesta, il server invia preventivamente una risorsa che prevede che il client richiederà subito dopo.

{{ figure_markup(
  caption="La percentuale di pagine HTTP/2 Push che utilizzano `preload`/`nopush`.",
  content="75.36%",
  classes="big-number",
  sheets_gid="308166349",
  sql_file="h2_preload_nopush.sql"
) }}

HTTP/2 Push viene spesso avviato tramite l'header del link `preload`. Nel dataset del 2020 abbiamo visto l'1% delle pagine mobile utilizzare HTTP/2 Push, e di quel 75% dei links di header precaricati utilizzare l'opzione `nopush` nella richiesta della pagina. Ciò significa che anche se un sito web utilizza la resource hint `preload`, la maggioranza preferisce usare solo questo e disabilitare il push HTTP/2 di quella risorsa.

È importante ricordare che HTTP/2 Push può anche danneggiare le prestazioni se non utilizzato correttamente, il che probabilmente spiega perché è spesso disabilitato.

Una soluzione a questo problema è utilizzare il <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL Pattern</a> che sta per **Push** (o precarica) le risorse critiche, **Render** la route iniziale il prima possibile, **pre-cache** le risorse rimanenti e **Lazy-load** altre route e risorse non critiche. Ciò è possibile solo se il tuo sito Web è una Progressive Web App e utilizza un Service Worker per migliorare la strategia di memorizzazione nella cache. In questo modo, tutte le richieste successive non vengono nemmeno inviate alla rete e quindi non è necessario spingere tutto il tempo e otteniamo comunque il meglio di entrambi i mondi.

## Service Workers

Sia per `preload` che per `prefetch` abbiamo avuto un aumento dell'adozione quando la pagina è controllata da un <a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers">Service Worker</a>. Ciò è dovuto al potenziale sia di migliorare la prioritizzazione delle risorse precaricando quando il Service Worker non è ancora attivo, sia di precaricare in modo intelligente le risorse future consentendo al Service Worker di memorizzarle nella cache prima che siano necessarie all'utente.

{{ figure_markup(
  image="resource-hint-adoption-onservice-worker-pages.png",
  caption="Adozione delle resource hint nelle pagine di Service Worker.",
  description="Un grafico a barre del tasso di adozione delle resource hint nelle pagine di Service Worker suddiviso per tipo di hint e fattore di form. Per desktop, il 29% delle pagine usa la resource hint `dns-prefetch`, il 47% usa `preload`, il 34% usa `preconnect`, il 10% usa `prefetch` e meno dell'1% usa `prerender`. Il cellulare è simile, tranne per il fatto che `dns-prefetch` ha un utilizzo del 30% (1% in più) e `preconnect` ha il 34% (13% in meno).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=252958553&format=interactive",
  sheets_gid="691299508",
  sql_file="adoption_service_workers.sql"
) }}

Per `preload` su desktop abbiamo un eccezionale tasso di adozione del 47% e `prefetch` un tasso di adozione del 10%. In entrambi i casi i dati sono molto più alti rispetto all'adozione media senza un Service Worker.

Come accennato in precedenza, il <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL Pattern</a> giocherà un ruolo significativo nei prossimi anni nel modo in cui combineremo le resource hints con la strategia di caching del Service Worker.

## Futuro

Immergiamoci in un paio di hints sperimentali. Molto vicino al rilascio abbiamo i hint prioritari(Priority hints), che vengono attivamente sperimentati nella comunità web. Abbiamo anche i 103 Early Hints in HTTP/2, che è ancora all'inizio e ci sono alcuni giocatori come <a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">Chrome e Fastly che collaborano per i prossimi test di prova</a>.

### Hints prioritari

<a hreflang="en" href="https://developers.google.com/web/updates/2019/02/priority-hints">Priority hints</a> sono un'API per esprimere la priorità di fetch di una risorsa: alta, bassa o automatica. Possono essere utilizzati per ridurre la priorità delle immagini (ad esempio all'interno di un Carousel), ridefinire la priorità degli script e persino aiutare a ridurre la priorità dei fetch.

Questo nuovo hint può essere utilizzato come tag HTML o modificando la priorità delle richieste di fetch tramite l'opzione `importance`, che assume gli stessi valori dell'attributo HTML.

```html
<!-- Vogliamo avviare un recupero anticipato di una risorsa, ma anche ridimensionarla -->
<link rel="preload" href="/js/script.js" as="script" importance="low">

<!-- Un'immagine che il browser assegna priorità "Alta", ma in realtà non la vogliamo. -->
<img src="/img/in_view_but_not_important.svg" importance="low" alt="I'm not important!">
```

Con `preload` e `prefetch`, la priorità è impostata dal browser a seconda del tipo di risorsa. Utilizzando le Priority Hints possiamo forzare il browser a modificare l'opzione predefinita.

{{ figure_markup(
  caption="La percentuale di adozione del Priority Hint sui dispositivi mobile.",
  content="0.77%",
  classes="big-number",
  sheets_gid="1596669035",
  sql_file="priority_hints.sql"
) }}

Finora solo lo 0,77% dei siti web ha adottato questo nuovo hint poiché Chrome sta ancora <a hreflang="en" href="https://www.chromestatus.com/features/5273474901737472">attivamente</a> sperimentando e al momento del rilascio di questo articolo la feature è in attesa.

L'utilizzo maggiore è con elementi di script, il che non sorprende poiché il numero di file JS primari e di terze parti continua a crescere.

{{ figure_markup(
  caption="La percentuale di risorse nei dispositivi mobile con un hint che utilizza la `low` priority.",
  content="16%",
  classes="big-number",
  sheets_gid="1098063134",
  sql_file="priority_hints_by_importance.sql"
) }}

I dati ci mostrano che l'83% delle risorse che utilizzano le Priority Hints utilizza una priorità "alta" sui dispositivi mobile, ma qualcosa a cui dovremmo prestare ancora più attenzione è il 16% delle risorse con priorità "bassa".

Priority hints hanno un chiaro vantaggio come strumento per prevenire il caricamento dispendioso tramite la priorità "bassa" aiutando il browser a decidere cosa togliere la priorità e restituendo CPU e larghezza di banda significative per completare prima le richieste critiche, piuttosto che come tattica per provare a ottenere risorse caricate più rapidamente con la priorità "alta".

### 103 Early Hints in HTTP/2
In precedenza abbiamo accennato al fatto che HTTP/2 Push potrebbe effettivamente causare la regressione nei casi in cui gli asset inviati erano già nella cache del browser. La proposta <a hreflang="en" href="https://tools.ietf.org/html/rfc8297">103 Early Hints</a> mira a fornire vantaggi simili promessi dal HTTP/2 push. Con un'architettura potenzialmente 10 volte più semplice, risolve le lunghe RTT o l'elaborazione del server senza soffrire del noto problema worst-case dei round trip non necessari con il server push.

A partire da ora puoi seguire la conversazione su Chromium con i problemi <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=671310">671310</a>, <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=1093693">1093693</a> e <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=1096414">1096414</a>.

## Conclusione

Durante lo scorso anno le resource hints sono aumentati nell'adozione e sono diventati API essenziali per gli sviluppatori per avere un controllo più granulare su molti aspetti delle priorità delle risorse e, in definitiva, sulla user experience. Ma non dimentichiamo che questi sono hints, non istruzioni e purtroppo il Browser e la rete avranno sempre l'ultima parola.

Certo, puoi schiaffeggiarli su un mucchio di elementi e il browser potrebbe fare quello che gli chiedi. Oppure può ignorare alcune hints e decidere che la default priority è la scelta migliore per la situazione data. In ogni caso, assicurati di avere un playbook su come utilizzare al meglio questi suggerimenti:

- Identifica le pagine chiave per l'user experience.
- Analizza le risorse più importanti da ottimizzare.
- Adotta il <a hreflang="en" href="https://addyosmani.com/blog/the-prpl-pattern/">PRPL Pattern</a> quando possibile.
- Misurare la performance experience prima e dopo ogni implementazione.

Come nota finale, ricordiamo che il web è per tutti. Dobbiamo continuare a proteggerlo e rimanere concentrati sulla building experiences che sono semplici e senza attriti.

Siamo entusiasti di vedere che anno dopo anno ci avviciniamo sempre di più all'offerta di tutte le API necessarie per semplificare la creazione di un'ottima esperienza web per tutti e non vediamo l'ora di vedere cosa verrà dopo.
