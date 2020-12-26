---
part_number: IV
chapter_number: 21
title: Resource Hints
description: Resource Hints chapter of the 2020 Web Almanac covering usage of dns-prefetch, preconnect, preload, prefetch, Priority Hints, and native lazy loading.
authors: [Zizzamia]
reviewers: [jessnicolet, pmeenan, giopunt, mgechev, notwillk]
analysts: [khempenius]
translators: []
Zizzamia_bio: Leonardo is a Staff Software Engineer at <a href="https://www.coinbase.com/">Coinbase</a>, leading web performance and growth initiatives. He curates the <a href="https://ngrome.io">NGRome Conference</a>. Leo also maintains the <a href="https://github.com/Zizzamia/perfume.js">Perfume.js</a> library, which helps companies prioritize roadmaps and make better business decisions through performance analytics.
discuss: 2057
results: https://docs.google.com/spreadsheets/d/1lXjd8ogB7kYfG09eUdGYXUlrMjs4mq1Z7nNldQnvkVA/
queries: 21_Resource_Hints
featured_quote: During the past year resource hints increased in adoption, and they have become essential APIs for developers to have more granular control over many aspects of resource prioritizations and ultimately, user experience.
featured_stat_1: 33%
featured_stat_label_1: Sites using <code>dns-prefetch</code>
featured_stat_2: 9%
featured_stat_label_2: Sites using <code>preload</code>
featured_stat_3: 4.02%
featured_stat_label_3: Sites using native lazy loading
---

## Introduzione

<!-- Over the past decade [resource hints](https://www.w3.org/TR/resource-hints/) have become essential primitives that allow developers to improve page performance and therefore the user experience. -->

Negli ultimi dieci anni [resource hints](https://www.w3.org/TR/resource-hints/) sono diventati primitivi essenziali che consentono agli sviluppatori di migliorare le prestazioni della pagina e quindi la user experience.

<!-- Preloading resources and having browsers apply some intelligent prioritization is something that was actually started way back in 2009 by IE8 with something called the [preloader](https://speedcurve.com/blog/load-scripts-async/). In addition to the HTML parser, IE8 had a lightweight look-ahead preloader that scanned for tags that could initiate network requests (`<script>`, `<link>`, and `<img>`). -->

Il precaricamento delle risorse e il fatto che i browser applichino una priorità intelligente è qualcosa che è stato effettivamente avviato nel lontano 2009 da IE8 con qualcosa chiamato [preloader](https://speedcurve.com/blog/load-scripts-async/). Oltre al parser HTML, IE8 aveva un preloader leggero che analizzava i tag in grado di avviare richieste di rete (`<script>`, `<link>` e `<img>`).

<!-- Over the following years, browser vendors did more and more of the heavy lifting, each adding their own special sauce for how to prioritize resources. But it's important to understand that the browser alone has some limitations. As developers however, we can overcome these limits by making good use of resource hints and help decide how to prioritize resources, determining which should be fetched or preprocessed to further boost page performance. -->

Negli anni successivi, i fornitori di browser hanno svolto sempre più il lavoro pesante, ognuno aggiungendo la propria salsa speciale su come dare la priorità alle risorse. Ma è importante capire che il browser da solo ha alcune limitazioni. In qualità di sviluppatori, tuttavia, possiamo superare questi limiti facendo un buon uso delle resource hints e aiutandoci a decidere come assegnare la priorità alle risorse, determinando quali dovrebbero essere fetched o preprocessed per aumentare ulteriormente le prestazioni della pagina.

<!-- In particular we can mention a few of the victories resource hints achieved/made in the last year: -->
In particolare possiamo citare alcune vittorie raggiunte/ottenute nell'ultimo anno riguardante le resource hints:
- [CSS-Tricks](https://www.zachleat.com/web/css-tricks-web-fonts/) web fonts vengono visualizzati più velocemente su un primo rendering 3G.
- [Wix.com](https://www.youtube.com/watch?v=4QqlGgF8Y2I&t=1469) l'utilizzo delle resource hints ha ottenuto un miglioramento del 10% per FCP.
- [Ironmongerydirect.co.uk](https://andydavies.me/blog/2019/03/22/improving-perceived-performance-with-a-link-rel-equals-preconnect-http-header/) ha utilizzato la preconnect per migliorare il caricamento dell'immagine del prodotto di 400 ms alla mediana e di oltre 1s al 95° percentile.
- [Facebook.com](https://engineering.fb.com/2020/05/08/web/facebook-redesign/) preload utilizzato per una navigazione più veloce.

<!-- Let's take a look at most predominant resource hints supported by most browsers today: `dns-prefetch`, `preconnect`, `preload`, `prefetch`, and native lazy loading. -->

Diamo un'occhiata alle resource hints più predominanti supportati dalla maggior parte dei browser oggi: `dns-prefetch`, `preconnect`, `preload`, `prefetch`, e native lazy loading.

<!-- When working with each individual hint we advise to always measure the impact before and after in the field, by using libraries like [WebVitals](https://github.com/GoogleChrome/web-vitals), [Perfume.js](https://github.com/zizzamia/perfume.js), or any other utility that supports the Web Vitals metrics. -->

Quando si lavora con ogni singolo hint, consigliamo di misurare sempre l'impatto prima e dopo sul campo, utilizzando librerie come [WebVitals](https://github.com/GoogleChrome/web-vitals), [Perfume.js](https://github.com/zizzamia/perfume.js) o qualsiasi altra utility che supporti le metriche di Web Vitals.

### `dns-prefetch`

<!-- [`dns-prefetch`](https://web.dev/preconnect-and-dns-prefetch/) helps resolve the IP address for a given domain ahead of time. As the [oldest](https://caniuse.com/link-rel-dns-prefetch) resource hint available, it uses minimal CPU and network resources compared to `preconnect`, and helps the browser to avoid experiencing the "worst-case" delay for DNS resolution, which can be [over 1 second](https://www.chromium.org/developers/design-documents/dns-prefetching). -->

[`dns-prefetch`](https://web.dev/preconnect-and-dns-prefetch/) aiuta a risolvere in anticipo l'indirizzo IP per un determinato dominio. Essendo la più [vecchia](https://caniuse.com/link-rel-dns-prefetch) resource hint disponibile, utilizza CPU e risorse di rete minime rispetto a `preconnect` e aiuta il browser a evitare di sperimentare il "worst-case" delay per la risoluzione DNS, che può essere [oltre 1 secondo](https://www.chromium.org/developers/design-documents/dns-prefetching).

```html
<link rel="dns-prefetch" href="https://www.googletagmanager.com/">
```

<!-- Be mindful when using `dns-prefetch` as even if they are lightweight to do it's easy to exhaust browser limits for the number of concurrent in-flight DNS requests allowed (Chrome still has a [limit of 6](https://source.chromium.org/chromium/chromium/src/+/master:net/dns/host_resolver_manager.cc;l=353)). -->

Fai attenzione quando usi `dns-prefetch` perché anche se sono leggeri da fare è facile esaurire i limiti del browser per il numero di richieste DNS simultanee in volo consentite (Chrome ha ancora un [limite di 6](https://source.chromium.org/chromium/chromium/src/+/master:net/dns/host_resolver_manager.cc;l=353)).

### `preconnect`

<!-- [`preconnect`](https://web.dev/uses-rel-preconnect/) helps resolve the IP address and open a TCP/TLS connection for a given domain ahead of time. Similar to `dns-prefetch` it is used for any cross-origin domain and helps the browser to warm up any resources used during the initial page load. -->

[`preconnect`](https://web.dev/uses-rel-preconnect/) aiuta a risolvere l'indirizzo IP e ad aprire in anticipo una connessione TCP/TLS per un dato dominio. Simile a `dns-prefetch`, viene utilizzato per qualsiasi dominio cross-origin e aiuta il browser a riscaldare le risorse utilizzate durante il caricamento iniziale della pagina.

```html
<link rel="preconnect" href="https://www.googletagmanager.com/">
```

<!-- Be mindful when you use `preconnect`: -->
Sii consapevole quando usi `preconnect`:

<!-- - Only warm up the most frequent and significant resources. -->
- Riscaldare solo le risorse più frequenti e significative.
<!-- - Avoid warming up origins used too late in the initial load. -->
- Evitare di riscaldare le origini utilizzate troppo tardi nel caricamento iniziale.
<!-- - Use it for no more than three origins because it can have CPU and battery cost. -->
- Usalo per non più di tre origini perché può avere costi di CPU e batteria.

<!-- Lastly, `preconnect` is not available for [Internet Explorer or Firefox](https://caniuse.com/?search=preconnect), and [using `dns-prefetch` as a fallback](https://web.dev/preconnect-and-dns-prefetch/#resolve-domain-name-early-with-reldns-prefetch) is highly advised. -->

Infine, `preconnect` non è disponibile per [Internet Explorer o Firefox](https://caniuse.com/?search=preconnect), e [usare `dns-prefetch` come fallback](https://web.dev/preconnect-and-dns-prefetch/#resolution-domain-name-early-with-reldns-prefetch) è altamente consigliato.

### `preload`

<!-- The [`preload`](https://web.dev/uses-rel-preload/) hint initiates an early request. This is useful for loading important resources that would otherwise be discovered late by the parser. -->

L'hint [`preload`](https://web.dev/uses-rel-preload/) avvia una richiesta anticipata. Ciò è utile per caricare risorse importanti che altrimenti verrebbero scoperte in ritardo dal parser.

```html
<link rel="preload" href="style.css" as="style">
<link rel="preload" href="main.js" as="script">
```

<!-- Be mindful of what you are going to `preload`, because it can delay the download of other resources, so use it only for what is most critical to help you improve the Largest Contentful Paint ([LCP](https://web.dev/lcp/)). Also, when used on Chrome, it tends to over-prioritize `preload` resources and potentially dispatches preloads before other critical resources. -->

Sii consapevole quando andrai ad utilizzare `preload`, perché può ritardare il download di altre risorse, quindi usalo solo per ciò che è più critico per aiutarti a migliorare il Largest Contentful Paint ([LCP](https://web.dev/lcp/)). Inoltre, se utilizzato su Chrome, tende a dare priorità alle risorse di "preload" e potenzialmente invia preloads prima di altre risorse critiche.

<!-- Lastly, if used in a HTTP response header, some CDN's will also automatically turn a `preload` into a [HTTP/2 push](#http2-push) which can over-push cached resources. -->

Infine, se usati in un header di risposta HTTP, alcuni CDN trasformeranno automaticamente un "preload" in un [HTTP/2 push](#http2-push) che può sovraccaricare le risorse memorizzate nella cache.

### `prefetch`

<!-- The [`prefetch`](https://web.dev/link-prefetch/) hint allows us to initiate low-priority requests we expect to be used on the next navigation. The hint will download the resources and drop it into the HTTP cache for later usage. Important to notice, `prefetch` will not execute or otherwise process the resource, and to execute it the page will still need to call the resource by the `<script>` tag. -->

L'hint [`prefetch`](https://web.dev/link-prefetch/) ci permette di avviare richieste a bassa priorità che ci aspettiamo vengano usate nella prossima navigazione. L'hint scaricherà le risorse e le rilascerà nella cache HTTP per un utilizzo successivo. È importante notare che `prefetch` non eseguirà o elaborerà in altro modo la risorsa, e per eseguirlo la pagina dovrà comunque chiamare la risorsa tramite il tag `<script>`.

```html
<link rel="prefetch" as="script" href="next-page.bundle.js">
```

<!-- There are a variety of ways to implement a resource's prediction logic, it could be based on signals like user mouse movement, common user flows/journeys, or even based on a combination of both on top of machine learning. -->

Esistono diversi modi per implementare la logica di previsione di una risorsa, che potrebbe essere basata su segnali come il movimento del mouse dell'utente, flussi/percorsi comuni degli utenti o anche sulla base di una combinazione di entrambi in aggiunta al machine learning.

<!-- Be mindful, depending on the [quality](https://github.com/andydavies/http2-prioritization-issues#current-status) of HTTP/2 prioritization of the CDN used, `prefetch` prioritization could either improve performance or make it slower, by over prioritizing `prefetch` requests and taking away important bandwidth for the initial load. Make sure to double check the CDN you are using and adapt to take into consideration some of the best practices shared in [Andy Davies's](https://andydavies.me/blog/2020/07/08/rel-equals-prefetch-and-the-importance-of-effective-http-slash-2-prioritisation/) article. -->

Fai attenzione, a seconda della [qualità](https://github.com/andydavies/http2-prioritization-issues#current-status) della prioritizzazione HTTP/2 del CDN utilizzato, la prioritizzazione di `prefetch` potrebbe migliorare le prestazioni o renderle più lente, dando priorità alle richieste di `prefetch` e togliendo della larghezza di banda importante per il caricamento iniziale. Assicurati di ricontrollare la CDN che stai utilizzando e adattati per prendere in considerazione alcune delle migliori pratiche condivise di [Andy Davies's](https://andydavies.me/blog/2020/07/08/rel-equals-prefetch-and-the-importance-of-effective-http-slash-2-prioritisation/).

### Native lazy loading

<!-- The [native lazy loading](https://web.dev/browser-level-image-lazy-loading/) hint is a native browser API for deferring the load of offscreen images and iframes. By using it, assets that are not needed during the initial page load will not initiate a network request, this will reduce data consumption and improve page performance. -->

L'hint [native lazy loading](https://web.dev/browser-level-image-lazy-loading/) è un'API del browser nativa per differire il caricamento di immagini offscreen e iframe. Usandolo, le risorse che non sono necessarie durante il caricamento iniziale della pagina non avvieranno una richiesta di rete, questo ridurrà il consumo di dati e migliorerà le prestazioni della pagina.

```html
<img src="image.png" loading="lazy" alt="…" width="200" height="200">
```

<!-- Be mindful Chromium's implementation of lazy-loading thresholds logic historically has been quite [conservative](https://web.dev/browser-level-image-lazy-loading/#distance-from-viewport-thresholds), keeping the offscreen limit to 3000px. During the last year the limit has been actively tested and improved on to better align developer expectations, and ultimately moving the thresholds to 1250px. Also, there is [no standard across the browsers](https://github.com/whatwg/html/issues/5408) and no ability for web developers to override the default thresholds provided by the browsers, yet. -->

Tieni presente che l'implementazione di Chromium della logica delle soglie di lazy-loading è stata storicamente piuttosto [conservativa](https://web.dev/browser-level-image-lazy-loading/#distance-from-viewport-thresholds), mantenendo il limite offscreen a 3000px. Durante l'ultimo anno il limite è stato attivamente testato e migliorato per allineare meglio le aspettative degli sviluppatori e, infine, spostare le soglie a 1250px. Inoltre, non esiste [nessuno standard nei browser](https://github.com/whatwg/html/issues/5408) e non è ancora possibile per gli sviluppatori web ignorare le soglie predefinite fornite dai browser.

## Resource hints

<!-- Based on the HTTP Archive, let's jump into analyzing the 2020 trends, and compare the data with the previous 2019 dataset. -->
Sulla base dell'archivio HTTP, passiamo all'analisi delle tendenze del 2020 e confrontiamo i dati con il precedente dataset del 2019.

### Hints adoption

<!-- More and more web pages are using the main resource hints, and in 2020 we are seeing the adoption remains consistent between desktop & mobile. -->
Sempre più pagine web utilizzano le principali resource hints, e nel 2020 stiamo vedendo che l'adozione rimane coerente tra desktop e mobile.

{{ figure_markup(
  image="adoption-of-resource-hints.png",
  caption="Adozione delle resource hints.",
  description="Un grafico a barre del tasso di adozione delle resource hint suddiviso per tipo di hint e fattore di form. Per desktop, il 33% delle pagine usa la resource hint `dns-prefetch`, il 18% usa `preload`, l'8% usa `preconnect`, il 3% usa `prefetch` e meno dell'1% usa `prerender`. Mobile è simile, tranne per il fatto che "dns-prefetch" ha un utilizzo del 34% (1% in più) e "preconnect" ha il 9% (1% in più).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1550112064&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

<!-- The relative popularity of `dns-prefetch` with 33% adoption compared with other resource hints is unsurprising as it first appeared in 2009, and has the widest support out of all major resource hints. -->
La relativa popolarità di `dns-prefetch` con il 33% di adozione rispetto ad altre resource hints non sorprende poiché è apparso per la prima volta nel 2009 e ha il supporto più ampio tra tutti le principali resource hints.

<!-- Compared to [2019](../2019/resource-hints#resource-hints) the `dns-prefetch` had a 4% increase in Desktop adoption. We saw a similar increase for `preconnect` as well. One key reason this was the largest growth between all hints, is the clear and useful advice the [Lighthouse audit](https://web.dev/uses-rel-preconnect/) is giving on this matter. Starting from this year's report we also introduce how the latest dataset performs against Lighthouse recommendations. -->
Rispetto a [2019](../2019/resource-hints#resource-hints), `dns-prefetch` ha avuto un aumento del 4% nell'adozione su desktop. Abbiamo visto un aumento simile anche su "preconnect". Uno dei motivi principali per cui questa è stata la crescita più grande tra tutti le hints, è il chiaro e utile consiglio che il [Lighthouse audit](https://web.dev/uses-rel-preconnect/) sta dando su questo argomento. A partire dal rapporto di quest'anno, introduciamo anche come si comporta l'ultimo dataset rispetto alle raccomandazioni di Lighthouse.

{{ figure_markup(
  image="resource-hint-adoption-2019-vs-2020.png",
  caption="Adozione delle resource hints 2019 vs 2020.",
  description="Un grafico a barre che confronta il tasso di adozione delle resource hints nei dispositivi mobile tra il 2019 e il 2020, suddiviso per tipo di hint. Mostra un aumento dell'utilizzo in quasi tutti i tipi di resource hints. `dns-prefetch` è aumentato del 5%, dal 29% al 34%. `preload` aumentato del 2%, dal 16% al 18%. `preconnect` è aumentato del 5%, dal 4% al 9%. `prefetch` è rimasto invariato al 3% di utilizzo. Anche `prerender` è rimasto invariato con un utilizzo inferiore all'1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=1494186122&format=interactive",
  sheets_gid="1805612941",
  sql_file="adoption.sql"
) }}

<!-- `preload` usage has had a slower growth with only a 2% increase from 2019. This could be in part because it requires a bit more specification. While you only need the domain to use `dns-prefetch` and `preconnect`, you must specify the resource to use `preload`. While `dns-prefetch` and `preconnect` are reasonably low risk, though still can be abused, `preload` has a much greater potential to actually damage performance if used incorrectly. -->
L'utilizzo di `preload` ha avuto una crescita più lenta con solo un aumento del 2% dal 2019. Ciò potrebbe essere in parte dovuto al fatto che richiede un po' più di specifiche. Anche se hai solo bisogno del dominio per usare `dns-prefetch` e `preconnect`, devi specificare la risorsa per usare `preload`. Mentre `dns-prefetch` e `preconnect` sono ragionevolmente a basso rischio, sebbene possano ancora essere abusati, `preload` ha un potenziale maggiore di danneggiare effettivamente le prestazioni se usato in modo errato.

<!-- `prefetch` is used by 3% of sites on Desktop, making it the least widely used resource hint. This low usage may be explained by the fact that `prefetch` is useful for improving subsequent, rather than current, page loads. Thus, it will be overlooked if a site is only focused on improving its landing page, or the performance of the first page viewed. In the coming years with a more clear definition on what to measure for improving subsequent page experience, it could help teams prioritize `prefetch` adoption with clear performance quality goals to reach. -->
`prefetch` è usato dal 3% dei siti su Desktop, rendendolo la resource hint meno utilizzata. Questo basso utilizzo può essere spiegato dal fatto che `prefetch` è utile per migliorare i caricamenti delle pagine successive, piuttosto che correnti. Pertanto, verrà trascurato se un sito si concentra solo sul miglioramento della sua pagina di destinazione o sul rendimento della prima pagina visualizzata. Negli anni a venire, con una definizione più chiara di cosa misurare per migliorare la successiva esperienza della pagina, potrebbe aiutare i team a dare la priorità all'adozione di `prefetch` con chiari obiettivi di qualità delle prestazioni da raggiungere.

### Hints per page

<!-- Across the board developers are learning how to better use resource hints, and compared to [2019](../2019/resource-hints#resource-hints) we've seen an improved use of `preload`, `prefetch`, and `preconnect`. For expensive operations like preload and preconnect the median usage on desktop decreased from 2 to 1. We have seen the opposite for loading future resources with a lower priority with `prefetch`, with an increase from 1 to 2 in median per page. -->

Gli sviluppatori stanno imparando a usare meglio le resource hints e rispetto al [2019](../2019/resource-hints#resource-hints) abbiamo visto un uso migliorato di `preload`, `prefetch` e `preconnect`. Per operazioni costose come preload e preconnect, l'utilizzo mediano sul desktop è diminuito da 2 a 1. Abbiamo visto l'opposto per caricamento delle risorse future con una priorità inferiore con `prefetch`, con un aumento da 1 a 2 in mediana per pagina.

{{ figure_markup(
  image="median-number-of-hints-per-page.png",
  caption="Numero mediano di hint per pagina.",
  description="Un grafico a barre che mostra il numero mediano di resource hints presenti per pagina suddiviso per tipo di resource hint e fattore di form. `preload` e `prerender` hanno entrambi (mediano) un hint per pagina sia su dispositivo mobile che su desktop. `prefetch` e `dns-prefetch` hanno entrambi (mediana) due hints per pagina sia su dispositivo mobile che su desktop. `preconnect` ha (mediana) un hint per pagina su desktop e (mediana) due hints per pagina su dispositivo mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=320451644&format=interactive",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

<!-- Resource hints are most effective when they're used selectively ("when everything is important, nothing is"). Having a more clear definition of what resources help improve critical rendering, versus future navigation optimizations, can move the focus away from using `preconnect` and more towards `prefetch` by shifting some of the resource prioritization and freeing up bandwidth for what most helps the user at first. -->
Le resource hints sono più efficaci quando vengono utilizzati in modo selettivo ("quando tutto è importante, niente lo è"). Avere una definizione più chiara di quali risorse aiutano a migliorare il rendering critico, rispetto alle future ottimizzazioni di navigazione, può spostare l'attenzione dall'uso di `preconnect` e più verso `prefetch` spostando parte della priorità delle risorse e liberando la larghezza di banda per ciò che più aiuta l'utente all'inizio.

<!-- However, this hasn't stopped some misuse of the `preload` hint, since in one instance we discovered a page dynamically adding the hint and causing an infinite loop that created over 20k new preloads. -->
Tuttavia, questo non ha impedito un uso improprio del hint `preload`, poiché in un caso abbiamo scoperto una pagina che aggiungeva dinamicamente l'hint e causava un ciclo infinito che ha creato oltre 20k nuovi precarichi.

{{ figure_markup(
  caption="Le hints più precaricati su una singola pagina.",
  content="20,931",
  classes="big-number",
  sheets_gid="175042082",
  sql_file="hints_per_page.sql"
) }}

<!-- As we create more and more automation with resource hints, be cautious when dynamically injecting preload hints - or any elements for that matter! -->
Man mano che creiamo sempre più automazione con le resource hints, sii cauto quando si inseriscono dinamicamente le hint di preload o qualsiasi elemento per quella materia!

### L'attributo `as`

<!-- With `preload` and `prefetch`, it's crucial to use the `as` attribute to help the browser prioritize the resource more accurately. Doing so allows for proper storage in the cache for future requests, applying the correct Content Security Policy ([CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)), and setting the correct `Accept` request headers. -->
Con `preload` e `prefetch`, è fondamentale usare l'attributo `as` per aiutare il browser a dare la priorità alla resource in modo più accurato. Ciò consente una corretta memorizzazione nella cache per richieste future, l'applicazione della corretta Content Security Policy ([CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)) e l'impostazione le headers di richiesta "Accept" corrette.

<!-- With `preload` many different content-types can be preloaded and the [full list](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link#Attributes) follows the recommendations made in the Fetch [spec](https://fetch.spec.whatwg.org/#concept-request-destination). The most popular is the `script` type with 64% usage. This is likely related to a large group of sites built as Single Page Apps that need the main bundle as soon as possible to start downloading the rest of their JS dependencies. Subsequent usage comes from font at 8%, style at 5%, image at 1%, and fetch at 1%. -->
Con `preload` possono essere precaricati molti diversi tipi di contenuto e la [lista completa](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link#Attributes) segue i consigli fatti nelle [specifiche](https://fetch.spec.whatwg.org/#concept-request-destination) Fetch. Il più popolare è il tipo `script` con il 64% di utilizzo. Ciò è probabilmente correlato a un ampio gruppo di siti creati come Single Page Apps che richiedono il pacchetto principale il prima possibile per avviare il download del resto delle loro dipendenze JS. L'utilizzo successivo proviene dal font all'8%, dallo stile al 5%, dall'immagine all'1% e dal fetch all'1%.

{{ figure_markup(
  image="mobile-as-attribute-values-by-year.png",
  caption="Un grafico a barre che confronta il tasso di valori dell'attributo `as` sulle pagine mobile del 2019 e del 2020, suddiviso per valore dell'attributo `as`. La maggior parte dei valori `as` sono \ "script \" con l'81% di utilizzo nel 2019 e il 64% nel 2020. L'utilizzo di \ "script \" è diminuito del 17% anno su anno, mentre tutti gli altri valori sono aumentati. \ "non impostato \" aumentato dell'8%, \ "font \" aumentato del 5%, \ "stile \" aumentato del 2%, il resto dei valori notevoli sono dell'1% o meno per entrambi gli anni.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=903180926&format=interactive",
  sheets_gid="1829901599",
  sql_file="as_attribute_by_year.sql"
) }}

<!-- Compared to the trend in [2019](../2019/resource-hints#the-as-attribute), we've seen rapid growth in font and style usage with the `as` attribute. This is likely related to developers increasing the priority of critical CSS and also combining `preload` fonts with `display:optional` to [improve](https://web.dev/optimize-cls/#web-fonts-causing-foutfoit) Cumulative Layout Shift ([CLS](https://web.dev/cls/)). -->
Rispetto alla tendenza in [2019](../2019/resource-hints#the-as-attribute), abbiamo visto una rapida crescita nell'utilizzo di font e style con l'attributo `as`. Ciò è probabilmente correlato agli sviluppatori che aumentano la priorità dei CSS critici e combinano anche i font `preload` con `display:optional` per [migliorare](https://web.dev/optimize-cls/#web-fonts-causing-foutfoit) Cumulative Layout Shift ([CLS](https://web.dev/cls/)).

<!-- Be mindful that omitting the `as` attribute, or having an invalid value will make it harder for the browser to determine the correct priority and in some cases, such as scripts, can even cause the resource to be fetched twice. -->
Tieni presente che omettere l'attributo `as` o avere un valore non valido renderà più difficile per il browser determinare la priorità corretta e in alcuni casi, come gli script, può anche causare il fetch della risorsa due volte.

### L'attibuto `crossorigin`

<!-- With `preload` and `preconnect` resources that have CORS enabled, such as fonts, it's important to include the `crossorigin` attribute, in order for the resource to be properly used. If the `crossorigin` attribute is absent, the request will follow the single-origin policy thereby making the use of preload useless. -->
Con le risorse `preload` e `preconnect` che hanno CORS abilitato, come i fonts, è importante includere l'attributo `crossorigin`, in modo che la risorsa venga utilizzata correttamente. Se l'attributo `crossorigin` è assente, la richiesta seguirà la politica della single-origin rendendo così inutile l'uso del preload.

{{ figure_markup(
  caption="La percentuale di elementi con `preload` che usano `crossorigin`.",
  content="16.96%",
  classes="big-number",
  sheets_gid="1185042785",
  sql_file="attribute_usage.sql"
) }}

<!-- The latest trends show that 16.96% of elements that `preload` also set `crossorigin` and load in anonymous (or equivalent) modes, and only 0.02% utilize the `use-credentials` case. This rate has increased in conjunction with the increase in font-preloading, as mentioned earlier. -->
Le ultime tendenze mostrano che il 16,96% degli elementi che `preload` imposta anche `crossorigin` e si caricano in modalità anonima (o equivalente), e solo lo 0,02% utilizza il caso `use-credentials`. Questa velocità è aumentata in concomitanza con l'aumento del precaricamento dei font, come accennato in precedenza.

```html
<link rel="preload" href="ComicSans.woff2" as="font" type="font/woff2" crossorigin>
```

<!-- Be mindful that fonts preloaded without the `crossorigin` attribute will be fetched [twice](https://web.dev/preload-critical-assets/#how-to-implement-relpreload)! -->
Tieni presente che i fonts precaricati senza l'attributo `crossorigin` verranno recuperati [due volte](https://web.dev/preload-critical-assets/#how-to-implement-relpreload)!

### L'attributo `media`

<!-- When it's time to choose a resource for use with different screen sizes, reach for the `media` attribute with `preload` to optimize your media queries. -->
Quando è il momento di scegliere una risorsa da usare con schermi di dimensioni diverse, cerca l'attributo `media` con `preload` per ottimizzare le tue query multimediali.

```html
<link rel="preload" href="a.css" as="style" media="only screen and (min-width: 768px)">
<link rel="preload" href="b.css" as="style" media="screen and (max-width: 430px)">
```

<!-- Seeing over 2,100 different combinations of media queries in the 2020 dataset encourages us to consider how wide the variance is between concept and implementation of responsive design from site to site. The ever popular `767px/768px` breakpoints (as popularized by Bootstrap amongst others) can be seen in the data. -->
Vedere oltre 2.100 diverse combinazioni di media query nel dataset del 2020 ci incoraggia a considerare quanto sia ampia la varianza tra il concetto e l'implementazione del responsive design da un sito all'altro. I punti di interruzione sempre popolari `767px/768px` (resi popolari da Bootstrap tra gli altri) possono essere visti nei dati.

### Best practices

<!-- Using resource hints can be confusing at times, so let's go over some quick best practices to follow based on Lighthouse's automated audit. -->
L'uso delle resource hints a volte può creare confusione, quindi esaminiamo alcune veloci best practice da seguire in base all'audit automatizzato di Lighthouse.

<!-- To safely implement `dns-prefetch` and `preconnect` make sure to have them in separate links tags. -->
Per implementare in modo sicuro `dns-prefetch` e `preconnect` assicurati di averli in tag di link separati.

```html
<link rel="preconnect" href="http://example.com">
<link rel="dns-prefetch" href="http://example.com">
```

<!-- Implementing a `dns-prefetch` fallback in the same `<link>` tag causes a [bug](https://bugs.webkit.org/show_bug.cgi?id=197010) in Safari that cancels the `preconnect` request. Close to 2% of pages (~40k) reported the issue of both `preconnect` & `dns-prefetch` in a single resource. -->
L'implementazione di un fallback `dns-prefetch` nello stesso tag `<link>` causa un [bug](https://bugs.webkit.org/show_bug.cgi?id=197010) in Safari che annulla la richiesta `preconnect`. Quasi il 2% delle pagine (~ 40k) ha segnalato il problema sia di `preconnect` che di `dns-prefetch` in una singola risorsa.

<!-- In the case of "[Preconnect to required origins](https://web.dev/uses-rel-preconnect/)" audit, we saw only 19.67% of pages passing the test, creating a large opportunity for thousands of websites to start using `preconnect` or `dns-prefetch` to establish early connections to important third-party origins. -->
Nel caso dell'audit "[Preconnect to required origins](https://web.dev/uses-rel-preconnect/)", abbiamo visto che solo il 19,67% delle pagine ha superato il test, creando una grande opportunità per migliaia di siti web per iniziare a utilizzare `preconnect` o `dns-prefetch` per stabilire connessioni iniziali a importanti origins di terze parti.

{{ figure_markup(
  caption="La percentuale di pagine che superano l'audit Lighthouse `preconnect`.",
  content="19.67%",
  classes="big-number",
  sheets_gid="152449420",
  sql_file="lighthouse_preconnect.sql"
) }}

<!-- Lastly, running Lighthouse's "[Preload key requests](https://web.dev/uses-rel-preload/)" audit resulted in 84.6% of pages passing the test. If you are looking to use `preload` for the first time, remember, fonts and critical scripts are a good place to start. -->
Infine, l'esecuzione dell'audit "[Preload key requests](https://web.dev/uses-rel-preload/)" di Lighthouse ha portato l'84,6% delle pagine a superare il test. Se stai cercando di usare `preload` per la prima volta, ricorda che i fonts e gli script critici sono un buon punto di partenza.

{# TODO(authors/reviewers) - revisit this sentence - Ref https://github.com/HTTPArchive/almanac.httparchive.org/pull/1587#discussion_r532291496 #}

### Native Lazy Loading

<!-- Now let's celebrate the first year of the [Native Lazy Loading](https://addyosmani.com/blog/lazy-loading/) API, which at the time of publishing already has over [72%](https://caniuse.com/loading-lazy-attr) browser support. This new API can be used to defer the load of below-the-fold iframes and images on the page until the user scrolls near them. This can reduce data usage, memory usage, and helps speed up above-the-fold content. Opting-in to lazy load is as simple as adding `loading=lazy`  on `<iframe>` or `<img>` elements. -->
Ora festeggiamo il primo anno dell'API [Native Lazy Loading](https://addyosmani.com/blog/lazy-loading/), che al momento della pubblicazione ha già superato il [72%](https://caniuse.com/loading-lazy-attr) supporto browser. Questa nuova API può essere utilizzata per posticipare il caricamento di iframe e immagini sulla pagina finché l'utente non scorre accanto a essi. Ciò può ridurre l'utilizzo dei dati, l'utilizzo della memoria e velocizzare i contenuti. Attivare il lazy load è semplice come aggiungere `loading = lazy` sugli elementi `<iframe>` o `<img>`.

La percentuale di pagine che utilizzano il Native Lazy Loading.

{{ figure_markup(
  caption="La percentuale di pagine che utilizzano il native lazy loading.",
  content="4.02%",
  classes="big-number",
  sheets_gid="2039808014",
  sql_file="native_lazy_loading_attrs.sql"
) }}

{# TODO(authors/reviewers) - revisit this figure - Ref https://github.com/HTTPArchive/almanac.httparchive.org/pull/1587#discussion_r532292106 #}

<!-- Adoption is still in its early days, especially with the official thresholds earlier this year being too conservative, and only [recently](https://addyosmani.com/blog/better-image-lazy-loading-in-chrome/) aligning with developer expectations. With almost 72% of browsers supporting native image/source lazy loading, this is another area of opportunity especially for pages looking to improve data usage and performance on low-end devices. -->
L'adozione è ancora agli inizi, soprattutto con le soglie ufficiali all'inizio di quest'anno troppo conservative e solo di [recente](https://addyosmani.com/blog/better-image-lazy-loading-in-chrome/) si allineano con le aspettative degli sviluppatori. Con quasi il 72% dei browser che supportano il lazy loading di image/source, questa è un'altra area di opportunità, specialmente per le pagine che cercano di migliorare l'utilizzo dei dati e le prestazioni sui dispositivi di fascia bassa.

<!-- Running Lighthouse's "[Defer offscreen images](https://web.dev/offscreen-images/)" audit resulted in 68.65% of pages passing the test. For those pages there is an opportunity to lazy-load images after all critical resources have finished loading. -->
L'esecuzione dell'audit "[Defer offscreen images](https://web.dev/offscreen-images/)" di Lighthouse ha portato il 68,65% delle pagine a superare il test. Per queste pagine c'è la possibilità di caricare le immagini dopo che tutte le risorse critiche hanno terminato il caricamento.

<!-- Be mindful to run the audit on both desktop and mobile as images may move off screen when the viewport changes. -->
Ricorda di eseguire l'audit sia su desktop che su dispositivi mobile poiché le immagini potrebbero spostarsi fuori dallo schermo quando la visualizzazione cambia.

## Prefetching predittivo

<!-- Combining `prefetch` with machine learning can help improve the performance of subsequent page(s). One solution is [Guess.js](https://github.com/guess-js/guess) which made the initial breakthrough in predictive-prefetching, with over a dozen websites already using it in production. -->
La combinazione di `prefetch` con il machine learning può aiutare a migliorare le prestazioni delle pagine successive. Una soluzione è [Guess.js](https://github.com/guess-js/guess) che ha compiuto il primo passo avanti nel prefetching predittivo, con oltre una dozzina di siti Web che già lo utilizzano in produzione.

<!-- [Predictive prefetching](https://web.dev/predictive-prefetching/) is a technique that uses methods from data analytics and machine learning to provide a data-driven approach to prefetching. Guess.js is a library that has predictive prefetching support for popular frameworks (Angular, Nuxt.js, Gatsby, and Next.js) and you can take advantage of it today. It ranks the possible navigations from a page and prefetches only the JavaScript that is likely to be needed next. -->
[Predictive prefetching](https://web.dev/predictive-prefetching/) è una tecnica che utilizza metodi di analisi dei dati e machine learning per fornire un approccio al precaricamento basato sui dati. Guess.js è una libreria che supporta il prefetching predittivo per framework popolari (Angular, Nuxt.js, Gatsby e Next.js) e puoi trarne vantaggio oggi. Classifica le possibili navigazioni da una pagina e precarica solo il JavaScript che probabilmente sarà necessario in seguito.

<!-- Depending on the training set, the prefetching of Guess.js comes with over 90% accuracy. -->
A seconda del set di allenamento, il prefetching di Guess.js ha una precisione superiore al 90%.

<!-- Overall, predictive prefetching is still uncharted territory, but combined with prefetching on mouse over and Service Worker prefetching, it has great potential to provide instant experiences for all users of the website, while saving their data. -->
Nel complesso, il prefetching predittivo è ancora un territorio inesplorato, ma combinato con il prefetch al passaggio del mouse e il prefetching di Service Worker, ha un grande potenziale per fornire esperienze istantanee a tutti gli utenti del sito Web, salvando i dati.

## HTTP/2 Push

<!-- [HTTP/2](./http2) has a feature called "server push" that can potentially improve page performance when your product experiences long Round Trip Times([RTTs](https://developer.mozilla.org/en-US/docs/Glossary/Round_Trip_Time_(RTT))) or server processing. In brief, rather than waiting for the client to send a request, the server preemptively pushes a resource that it predicts the client will request soon afterwards. -->
[HTTP/2](./http2) ha una feature chiamata "server push" che può potenzialmente migliorare le prestazioni della pagina quando il tuo prodotto ha lunghi Round Trip Times ([RTT](https://developer.mozilla.org/en-US/docs/Glossary/Round_Trip_Time_(RTT))) o elaborazione server. In breve, invece di aspettare che il client invii una richiesta, il server invia preventivamente una risorsa che prevede che il client richiederà subito dopo.

{{ figure_markup(
  caption="La percentuale di pagine HTTP/2 Push che utilizzano `preload`/`nopush`.",
  content="75.36%",
  classes="big-number",
  sheets_gid="308166349",
  sql_file="h2_preload_nopush.sql"
) }}

<!-- HTTP/2 Push is often initiated through the `preload` link header. In the 2020 dataset we have seen 1% of mobile pages using HTTP/2 Push, and of those 75% of preload header links use the `nopush` option in the page request. This means that even though a website is using the `preload` resource hint, the majority prefer to use just this and disable HTTP/2 pushing of that resource. -->
HTTP/2 Push viene spesso avviato tramite l'header del link `preload`. Nel dataset del 2020 abbiamo visto l'1% delle pagine mobile utilizzare HTTP/2 Push, e di quel 75% dei links di header precaricati utilizzare l'opzione `nopush` nella richiesta della pagina. Ciò significa che anche se un sito web utilizza la resource hint `preload`, la maggioranza preferisce usare solo questo e disabilitare il push HTTP/2 di quella risorsa.

<!-- It's important to mention that HTTP/2 Push can also damage performance if not used correctly which probably explains why it is often disabled. -->
È importante ricordare che HTTP/2 Push può anche danneggiare le prestazioni se non utilizzato correttamente, il che probabilmente spiega perché è spesso disabilitato.

<!-- One solution to this, is to use the [PRPL Pattern](https://addyosmani.com/blog/the-prpl-pattern/) which stands for **Push** (or preload) the critical resources, **Render** the initial route as soon as possible, **Pre-cache** remaining assets, and **Lazy-load** other routes and non-critical assets. This is possible only if your website is a Progressive Web App and uses a Service Worker to improve the caching strategy. By doing this, all subsequent requests never even go out to the network and so there's no need to push all the time and we still get the best of both worlds. -->
Una soluzione a questo problema è utilizzare il [PRPL Pattern](https://addyosmani.com/blog/the-prpl-pattern/) che sta per **Push** (o precarica) le risorse critiche, **Render** la route iniziale il prima possibile, **pre-cache** le risorse rimanenti e **Lazy-load** altre route e risorse non critiche. Ciò è possibile solo se il tuo sito Web è una Progressive Web App e utilizza un Service Worker per migliorare la strategia di memorizzazione nella cache. In questo modo, tutte le richieste successive non vengono nemmeno inviate alla rete e quindi non è necessario spingere tutto il tempo e otteniamo comunque il meglio di entrambi i mondi.

## Service Workers

<!-- For both `preload` and `prefetch` we've had an increase in adoption when the page is controlled by a [Service Worker](https://developers.google.com/web/fundamentals/primers/service-workers). This is because of the potential to both improve the resource prioritization by preloading when the Service Worker is not active yet and intelligently prefetching future resources while letting the Service Worker cache them before they're needed by the user. -->
Sia per `preload` che per `prefetch` abbiamo avuto un aumento dell'adozione quando la pagina è controllata da un [Service Worker](https://developers.google.com/web/fundamentals/primers/service-workers). Ciò è dovuto al potenziale sia di migliorare la prioritizzazione delle risorse precaricando quando il Service Worker non è ancora attivo, sia di precaricare in modo intelligente le risorse future consentendo al Service Worker di memorizzarle nella cache prima che siano necessarie all'utente.

{{ figure_markup(
  image="resource-hint-adoption-onservice-worker-pages.png",
  caption="Adozione delle resource hint nelle pagine di Service Worker.",
  description="Un grafico a barre del tasso di adozione delle resource hint nelle pagine di Service Worker suddiviso per tipo di hint e fattore di form. Per desktop, il 29% delle pagine usa la resource hint `dns-prefetch`, il 47% usa `preload`, il 34% usa `preconnect`, il 10% usa `prefetch` e meno dell'1% usa `prerender`. Il cellulare è simile, tranne per il fatto che `dns-prefetch` ha un utilizzo del 30% (1% in più) e `preconnect` ha il 34% (13% in meno).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTYAbLxN40s6mNR1jo0XDe_V4siN8TAsx2mryMp5IQmlJ-9O9eJxYROz7Rw6ozyFP6hlIZHxxh95GqX/pubchart?oid=252958553&format=interactive",
  sheets_gid="691299508",
  sql_file="adoption_service_workers.sql"
) }}

<!-- For `preload` on desktop we have an outstanding 47% rate of adoption and `prefetch` a 10% rate of adoption. In both cases the data is much higher compared to average adoption without a Service Worker. -->
Per `preload` su desktop abbiamo un eccezionale tasso di adozione del 47% e `prefetch` un tasso di adozione del 10%. In entrambi i casi i dati sono molto più alti rispetto all'adozione media senza un Service Worker.

<!-- As mentioned earlier, the [PRPL Pattern](https://addyosmani.com/blog/the-prpl-pattern/) will play a significant role in the coming years in how we combine resource hints with the Service Worker caching strategy. -->
Come accennato in precedenza, il [PRPL Pattern](https://addyosmani.com/blog/the-prpl-pattern/) giocherà un ruolo significativo nei prossimi anni nel modo in cui combineremo le resource hints con la strategia di caching del Service Worker.

## Futuro

<!-- Let's dive into a couple of experimental hints. Very close to release we have Priority Hints, which is actively experimented with in the web community. We also have the 103 Early Hints in HTTP/2, which is still in early inception and there are a few players like [Chrome and Fastly collaborating for upcoming test trials](https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code). -->
Immergiamoci in un paio di hints sperimentali. Molto vicino al rilascio abbiamo i hint prioritari(Priority hints), che vengono attivamente sperimentati nella comunità web. Abbiamo anche i 103 Early Hints in HTTP/2, che è ancora all'inizio e ci sono alcuni giocatori come [Chrome e Fastly che collaborano per i prossimi test di prova](https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code).

### Hints prioritari

<!-- [Priority hints](https://developers.google.com/web/updates/2019/02/priority-hints) are an API for expressing the fetch priority of a resource: high, low, or auto. They can be used to help deprioritize images (e.g. inside a Carousel), re-prioritize scripts, and even help de-prioritize fetches. -->
[Priority hints](https://developers.google.com/web/updates/2019/02/priority-hints) sono un'API per esprimere la priorità di fetch di una risorsa: alta, bassa o automatica. Possono essere utilizzati per ridurre la priorità delle immagini (ad esempio all'interno di un Carousel), ridefinire la priorità degli script e persino aiutare a ridurre la priorità dei fetch.

<!-- This new hint can be used either as an HTML tag or by changing the priority of fetch requests via the `importance` option, which takes the same values as the HTML attribute. -->
Questo nuovo hint può essere utilizzato come tag HTML o modificando la priorità delle richieste di fetch tramite l'opzione `importance`, che assume gli stessi valori dell'attributo HTML.

```html
<!-- We want to initiate an early fetch for a resource, but also deprioritize it -->
<link rel="preload" href="/js/script.js" as="script" importance="low">

<!-- An image the browser assigns "High" priority, but we don't actually want that. -->
<img src="/img/in_view_but_not_important.svg" importance="low" alt="I'm not important!">
```

<!-- With `preload` and `prefetch`, the priority is set by the browser depending on the type of resource. By using Priority Hints we can force the browser to change the default option. -->
Con `preload` e `prefetch`, la priorità è impostata dal browser a seconda del tipo di risorsa. Utilizzando le Priority Hints possiamo forzare il browser a modificare l'opzione predefinita.

{{ figure_markup(
  caption="La percentuale di adozione del Priority Hint sui dispositivi mobile.",
  content="0.77%",
  classes="big-number",
  sheets_gid="1596669035",
  sql_file="priority_hints.sql"
) }}

<!-- So far only 0.77% websites adopted this new hint as Chrome is still [actively](https://www.chromestatus.com/features/5273474901737472) experimenting, and at the time of this article's release the feature is on-hold. -->
Finora solo lo 0,77% dei siti web ha adottato questo nuovo hint poiché Chrome sta ancora [attivamente](https://www.chromestatus.com/features/5273474901737472) sperimentando e al momento del rilascio di questo articolo la feature è in attesa.

<!-- The largest use is with script elements, which is unsurprising as the number of JS primary and third-party files continues to grow. -->
L'utilizzo maggiore è con elementi di script, il che non sorprende poiché il numero di file JS primari e di terze parti continua a crescere.

{{ figure_markup(
  caption="La percentuale di risorse nei dispositivi mobile con un hint che utilizza la \"low\" priority.",
  content="16%",
  classes="big-number",
  sheets_gid="1098063134",
  sql_file="priority_hints_by_importance.sql"
) }}

<!-- The data shows us that 83% of resources using Priority Hints use a "high" priority on mobile, but something we should pay even more attention to is the 16% of resources with "low" priority. -->
I dati ci mostrano che l'83% delle risorse che utilizzano le Priority Hints utilizza una priorità "alta" sui dispositivi mobile, ma qualcosa a cui dovremmo prestare ancora più attenzione è il 16% delle risorse con priorità "bassa".

<!-- Priority hints have a clear advantage as a tool to prevent wasteful loading via the "low" priority by helping the browser decide what to de-prioritize and giving back significant CPU and bandwidth to complete critical requests first, rather than as a tactic to try to get resources loaded more quickly with the "high" priority. -->
Priority hints hanno un chiaro vantaggio come strumento per prevenire il caricamento dispendioso tramite la priorità "bassa" aiutando il browser a decidere cosa togliere la priorità e restituendo CPU e larghezza di banda significative per completare prima le richieste critiche, piuttosto che come tattica per provare a ottenere risorse caricate più rapidamente con la priorità "alta".

### 103 Early Hints in HTTP/2
<!-- Previously we mentioned that HTTP/2 Push could actually cause regression in cases where assets being pushed were already in the browser cache. The [103 Early Hints](https://tools.ietf.org/html/rfc8297) proposal aims to provide similar benefits promised by HTTP/2 push. With an architecture that is potentially 10x simpler, it addresses the long RTT's or server processing without suffering from the known worst-case issue of unnecessary round trips with server push. -->
In precedenza abbiamo accennato al fatto che HTTP/2 Push potrebbe effettivamente causare la regressione nei casi in cui gli asset inviati erano già nella cache del browser. La proposta [103 Early Hints](https://tools.ietf.org/html/rfc8297) mira a fornire vantaggi simili promessi dal HTTP/2 push. Con un'architettura potenzialmente 10 volte più semplice, risolve le lunghe RTT o l'elaborazione del server senza soffrire del noto problema worst-case dei round trip non necessari con il server push.

<!-- As of right now you can follow the conversation on Chromium with issues [671310](https://bugs.chromium.org/p/chromium/issues/detail?id=671310), [1093693](https://bugs.chromium.org/p/chromium/issues/detail?id=1093693), and [1096414](https://bugs.chromium.org/p/chromium/issues/detail?id=1096414). -->
A partire da ora puoi seguire la conversazione su Chromium con i problemi [671310](https://bugs.chromium.org/p/chromium/issues/detail?id=671310), [1093693](https://bugs.chromium.org/p/chromium/issues/detail?id=1093693) e [1096414](https://bugs.chromium.org/p/chromium/issues/detail?id=1096414).

## Conclusione

<!-- During the past year resource hints increased in adoption, and they have become essential APIs for developers to have more granular control over many aspects of resource prioritizations and ultimately, user experience. But let's not forget that these are hints, not instructions and unfortunately the Browser and the network will always have the final say. -->
Durante lo scorso anno le resource hints sono aumentati nell'adozione e sono diventati API essenziali per gli sviluppatori per avere un controllo più granulare su molti aspetti delle priorità delle risorse e, in definitiva, sulla user experience. Ma non dimentichiamo che questi sono hints, non istruzioni e purtroppo il Browser e la rete avranno sempre l'ultima parola.

<!-- Sure, you can slap them on a bunch of elements, and the browser may do what you're asking it to. Or it may ignore some hints and decide the default priority is the best choice for the given situation. In any case, make sure to have a playbook for how to best use these hints: -->
Certo, puoi schiaffeggiarli su un mucchio di elementi e il browser potrebbe fare quello che gli chiedi. Oppure può ignorare alcune hints e decidere che la default priority è la scelta migliore per la situazione data. In ogni caso, assicurati di avere un playbook su come utilizzare al meglio questi suggerimenti:

- Identifica le pagine chiave per l'user experience.
- Analizza le risorse più importanti da ottimizzare.
- Adotta il [PRPL Pattern](https://addyosmani.com/blog/the-prpl-pattern/) quando possibile.
- Misurare la performance experience prima e dopo ogni implementazione.

<!-- As a final note, let's remember that the web is for everyone. We must continue to protect it and stay focused on building experiences that are easy and frictionless. -->
Come nota finale, ricordiamo che il web è per tutti. Dobbiamo continuare a proteggerlo e rimanere concentrati sulla building experiences che sono semplici e senza attriti.

<!-- We are thrilled to see that year after year we get incrementally closer to offering all the APIs required to simplify building a great web experience for everyone, and we can't wait to see what comes next. -->
Siamo entusiasti di vedere che anno dopo anno ci avviciniamo sempre di più all'offerta di tutte le API necessarie per semplificare la creazione di un'ottima esperienza web per tutti e non vediamo l'ora di vedere cosa verrà dopo.
