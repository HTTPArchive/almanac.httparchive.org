---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Third Parties
description: Capitolo Terze parti del 2020 Web Almanac che copre i dati di cosa vengono utilizzate le terze parti, per cosa vengono utilizzate, impatti sulle prestazioni e impatti sulla privacy.
hero_alt: Hero image of Web Almanac chracters plugging various things into a web page.
authors: [simonhearne]
reviewers: [jzyang, exterkamp]
analysts: [max-ostapenko, paulcalvano]
editors: [tunetheweb]
translators: [chefleo]
simonhearne_bio: Simon è un architetto di prestazioni web. È appassionato di aiutare a fornire un Web più veloce e accessibile. Puoi trovarlo twittare <a href="https://x.com/simonhearne">@SimonHearne</a> e bloggare su <a hreflang="en" href="https://simonhearne.com">simonhearne.com</a>.
discuss: 2042
results: https://docs.google.com/spreadsheets/d/1uW4SMkC45b4EbC4JV1xKAUhwGN2K8j0qFy_jSIYnHhI/
featured_quote: Il contenuto di terze parti è più diffuso che mai, il 94% delle pagine ha almeno una risorsa di terze parti e la pagina mediana ne ha 24. In questo capitolo esaminiamo la prevalenza di contenuti di terze parti, l'impatto sul peso della pagina e sulla CPU del browser, quindi suggerire metodi per ridurre l'impatto dei contenuti di terze parti sulle prestazioni della pagina.
featured_stat_1: 94.1%
featured_stat_label_1: Pagine con contenuti di terze parti
featured_stat_2: 21.5%
featured_stat_label_2: Contenuti di terze parti forniti come JavaScript
featured_stat_3: 24
featured_stat_label_3: Richieste di terze parti nella pagina mediana
---

## Introduzione

Il contenuto di terze parti è oggi un componente critico della maggior parte dei siti web. Alimenta tutto: analisi, chat dal vivo, pubblicità, condivisione di video e altro ancora. I contenuti di terze parti forniscono valore eliminando il pesante fardello dei proprietari dei siti e consentono loro di concentrarsi sulle loro competenze principali.

Molti pensano che i contenuti di terze parti siano basati su JavaScript, ma i dati mostrano che questo è vero solo per il 22% delle richieste. I contenuti di terze parti sono disponibili in tutte le forme, dalle immagini (37%) all'audio (0.1%).

In questo capitolo esamineremo la prevalenza del contenuto di terze parti e come questo è cambiato dal 2019. Esamineremo anche: l'impatto del contenuto di terze parti sul peso della pagina (un buon indicatore per l'impatto complessivo sulle prestazioni), script che vengono caricati all'inizio del ciclo di vita della pagina, l'impatto del contenuto di terze parti sul tempo di CPU del browser e la disponibilità di terze parti con i dati sulle prestazioni.

## Definizioni

Prima di addentrarci nei dati dovremmo definire la terminologia utilizzata in questo capitolo.

### "Terze parti"

Una risorsa di terze parti è un'entità esterna alla relazione sito-utente principale. Coinvolge gli aspetti del sito non direttamente sotto il controllo del proprietario del sito ma presenti, con la sua approvazione. Ad esempio, lo script di Google Analytics è una comune risorsa di terze parti.

Consideriamo le risorse di terze parti come quelle:

* Ospitato su un'origine _shared_ e _public_
* Ampiamente utilizzato da una varietà di siti
* Non influenzato da un singolo proprietario del sito

Per soddisfare questi obiettivi il più fedelmente possibile, la definizione formale utilizzata in questo capitolo per le risorse di terze parti è: una risorsa che proviene da un dominio le cui risorse possono essere trovate su almeno 50 pagine univoche nel set di dati dell'HTTP Archive.

Tieni presente che utilizzando queste definizioni, il contenuto di terze parti offerto da un dominio di prime parti viene conteggiato come contenuto di prime parti. Ad esempio: Google Fonts con hosting autonomo o bootstrap.css viene conteggiato come _contenuto di prime parti_.

Allo stesso modo, i contenuti di prime parti forniti da un dominio di terze parti vengono conteggiati come contenuti di terze parti. Un esempio associato: le immagini di prime parti pubblicate su una CDN su un dominio di terze parti sono considerate _contenuto di terze parti_.

### Categorie di provider

Questo capitolo divide i provider di terze parti in diverse categorie. Una breve descrizione è inclusa con ciascuna delle categorie. La mappatura del dominio alla categoria può essere trovata nella <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5">repository web di terze parti</a>.

* Ad - visualizzazione e misurazione degli annunci pubblicitari
* Analytics - monitoraggio del comportamento dei visitatori del sito
* CDN - provider che ospitano utilities pubbliche condivise o contenuti privati dei propri utenti
* Content - provider che facilitano gli editori e ospitano contenuti distribuiti
* Customer Success - supporto e funzionalità di gestione delle relazioni con i clienti
* Hosting - provider che ospitano il contenuto arbitrario dei propri utenti
* Marketing - vendite, generazione di lead, e email marketing
* Social - social network e loro integrazioni affiliate
* Tag Manager - provider il cui unico ruolo è gestire l'inclusione di altre terze parti
* Utility - codice che aiuta gli obiettivi di sviluppo del proprietario del sito
* Video - provider che ospitano contenuti video arbitrari dei propri utenti
* Altro - attività non classificata o non conforme

_Nota sui CDN: la categoria CDN qui include i provider che forniscono risorse su domini CDN pubblici (ad es. Bootstrapcdn.com, cdnjs.cloudflare.com, ecc.) e non include risorse che vengono semplicemente servite su una CDN. ad esempio, mettere Cloudflare davanti a una pagina non influenzerebbe la sua designazione di prime parti secondo i nostri criteri._

### Avvertenze

* Tutti i dati qui presentati si basano su un caricamento a freddo non interattivo. Questi valori potrebbero iniziare ad apparire molto diversi dopo l'interazione dell'utente.
* Questa pagina è stata testata su un server statunitense senza cookie impostati, quindi non include terze parti richieste dopo l'attivazione. Ciò interesserà in particolare le pagine ospitate e servite prevalentemente nei paesi nell'ambito del [Regolamento generale sulla protezione dei dati](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation) o altre normative simili.
* Vengono testate solo le home page. Altre pagine potrebbero avere requisiti di terze parti diversi.
* Circa l'84% di tutti i domini di terze parti in base al volume di richieste è stato identificato e classificato. Il restante 16% rientra nella categoria "Altro".

Ulteriori informazioni sulla nostra [metodologia](./methodology).

## Prevalenza

Un buon punto di partenza per questa analisi è confermare l'affermazione che il contenuto di terze parti è una componente critica della maggior parte dei siti Web oggi. Quanti siti web utilizzano contenuti di terze parti e quante terze parti usano?

{{ figure_markup(
  image="pages-with-thirdparties.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1149547895&format=interactive",
  caption="Pagine con contenuti di terze parti",
  description="La prevalenza di contenuti di terze parti è aumentata leggermente dal 2019. Nel 2019 il 93.6% delle pagine mobile aveva contenuti di terze parti, nel 2020 era del 94.1%. Nel 2019 il 93.6% delle pagine desktop aveva contenuti di terze parti, nel 2020 era il 93.9%.",
  width=600,
  height=371,
  sheets_gid="1477664642",
  sql_file="percent_of_websites_with_third_party.sql"
  )
}}

Questi numeri di prevalenza mostrano un leggero aumento sui [risultati del 2019](../2019/third-parties): Il 93.87% delle pagine nella scansione desktop aveva almeno una richiesta di terze parti, il numero era leggermente superiore al 94.10% delle pagine nella scansione mobile. Una breve occhiata al numero limitato di pagine senza contenuto di terze parti ha rivelato che molti erano siti per adulti, alcuni erano domini governativi e alcuni sono pagine di destinazione/gestione di base con pochi contenuti. È giusto dire che la stragrande maggioranza delle pagine ha almeno una terza parte.

Il grafico seguente mostra la distribuzione delle pagine in base al conteggio di terze parti. La pagina del 10° percentile ha due richieste di terze parti mentre la pagina mediana ne ha 24. Oltre il 10% delle pagine ha più di 100 richieste di terze parti.

{{ figure_markup(
  image="distribution-of-request-count.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1394563639&format=interactive",
  caption="Distribuzione di richieste di terze parti.",
  description="Grafico percentile di pagine per richieste di terze parti. Il sito web mediano per dispositivi mobile ha 24 richieste di terze parti (23 su desktop) e aumenta esponenzialmente da 2 richieste per entrambi al 10° percentile a 104 richieste su dispositivo mobile e 106 richieste su desktop al 90° percentile.",
  width=600,
  height=371,
  sheets_gid="181718921",
  sql_file="distribution_of_third_parties_by_number_of_websites.sql"
  )
}}

### Tipi di contenuto

Possiamo suddividere le richieste di terze parti in base al tipo di contenuto. Questo è il [tipo di contenuto](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) riportato delle risorse fornite da domini di terze parti.

{{ figure_markup(
  image="thirdparty-by-content-types.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=258155228&format=interactive",
  caption="Contenuti di terze parti per tipo",
  description="Immagini e JavaScript rappresentano la maggior parte (60%) dei contenuti di terze parti: il 37.1% dei contenuti di terze parti sono immagini, il 21.9% è JavaScript, il 16.1% è unknown o altro, il 15.4% è HTML",
  width=600,
  height=371,
  sheets_gid="53929561",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

I risultati mostrano che i principali contributori di contenuti di terze parti sono le immagini (38%) e JavaScript (22%), con il successivo più grande contributore unknown (16%). Unknown è un sottoinsieme di gruppi non classificati come text/plain e risposte senza un header del tipo di contenuto.

Questo mostra un cambiamento quando <a href="../2019/third-parties#resource-types">rispetto al 2019</a>: il contenuto relativo dell'immagine è aumentato dal 33% al 38%, mentre il contenuto JavaScript è diminuito in modo significativo dal 32% al 22%. Questa riduzione è probabilmente dovuta alla maggiore aderenza ai cookie e alle normative sulla protezione dei dati, riducendo l'esecuzione di terze parti fino a dopo l'attivazione esplicita dell'utente, che non rientra nell'ambito delle esecuzioni del test dell'HTTP Archive.

### Domini di terze parti

Quando approfondiamo i domini che servono contenuti di terze parti, vediamo che Google Fonts è di gran lunga il più comune. È presente su oltre il 7.5% delle pagine per dispositivi mobile testate. Sebbene i caratteri rappresentino solo circa il 3% dei contenuti di terze parti, quasi tutti vengono forniti dal servizio Google Fonts. Se la tua pagina utilizza Google Fonts, assicurati di seguire le <a hreflang="en" href="https://csswizardry.com/2020/05/the-fastest-google-fonts/">best practice</a> per garantire la migliore esperienza utente possibile.

{{ figure_markup(
  image="top-domains-by-prevalence.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=2082639138&format=interactive",
  caption="Principali domini per prevalenza.",
  description="Grafico a barre che mostra i principali domini in base alla prevalenza. I domini più diffusi sono font foundries, advertising, social media e CDN JavaScript",
  width=600,
  height=371,
  sheets_gid="583962013",
  sql_file="top100_third_parties_by_number_of_websites.sql"
  )
}}

I prossimi quattro domini più comuni sono tutti provider di pubblicità. Potrebbero non essere richiesti direttamente dalla pagina ma attraverso una complessa catena di reindirizzamenti avviati da un'altra rete pubblicitaria.

Il sesto dominio più comune è `digicert.com`. Le chiamate a `digicert.com` sono generalmente controlli di revoca OCSP a causa dei certificati TLS che non hanno la cucitura OCSP abilitata o l'uso di certificati EV (Extended Validation) che impediscono il blocco dei certificati intermedi. Questo numero è esagerato nel HTTP Archive perché tutte le pagine caricate sono effettivamente visitatori per la prima volta: le risposte OCSP sono generalmente memorizzate nella cache e valide per sette giorni nella navigazione nel mondo reale. Consulta <a hreflang="en" href="https://simonhearne.com/2020/drop-ev-certs/">questo post del blog</a> per ulteriori informazioni su questo problema.

Più in basso nell'elenco al 2.43% c'è `ajax.googleapis.com`, il <a hreflang="en" href="https://developers.google.com/speed/libraries">progetto Hosted Libraries</a> di Google. Sebbene caricare una libreria come jQuery da un servizio ospitato sia facile, il costo aggiuntivo di una connessione a un dominio di terze parti potrebbe avere un impatto negativo sulle prestazioni. È meglio ospitare tutti i JavaScript e CSS critici nel dominio principale, se possibile. Inoltre, ora non vi è alcun vantaggio per la cache nell'utilizzo di una risorsa CDN condivisa, poiché tutti i principali browser <a hreflang="en" href="https://developers.google.com/web/updates/2020/10/http-cache-partitioning">eseguono la partizione della cache per pagina</a>. Harry Roberts ha scritto un post dettagliato sul blog su <a hreflang="en" href="https://csswizardry.com/2019/05/self-host-your-static-assets/">come ospitare le proprie risorse statiche</a>.

## Impatto del peso della pagina

Le terze parti possono avere un impatto significativo sul peso di una pagina, misurato come numero di byte scaricati dal browser. Il [capitolo Page Weight](./page-weight) lo esplora in modo più dettagliato, qui ci concentriamo sulle terze parti che hanno il maggiore impatto sul peso della pagina.
### Terze parti più pesanti

Possiamo estrarre le terze parti più grandi in base all'impatto del peso medio della pagina, ovvero quanti byte portano alle pagine in cui si trovano. I risultati sono interessanti in quanto ciò non tiene conto della popolarità delle terze parti, ma solo del loro impatto in byte.

{{ figure_markup(
  image="page-size-by-host.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=429818290&format=interactive",
  caption="Contributo di dimensioni di terze parti da parte dell'host.",
  description="Grafico degli host di terze parti e impatto sulle dimensioni della pagina, da trailercentral.com a 2.7 MB a contenservice.mc.reyrey.net a 510 KB. I providers di contenuti multimediali danno il maggior contributo alla dimensione della pagina.",
  width=600,
  height=371,
  sheets_gid="1423970958",
  sql_file="top100_third_parties_by_median_body_size_and_time.sql"
  )
}}

I principali contributori del peso della pagina sono generalmente i provider di contenuti multimediali, come l'hosting di immagini e video. Vidazoo, ad esempio, si traduce in un impatto medio sul peso della pagina di circa 2.5 MB. Il dominio `Inventory.vidazoo.com` fornisce l'hosting video, quindi una pagina mediana con questa terza parti ha un _extra_ 2.5MB di contenuto multimediale!

Un metodo semplice per ridurre questo impatto consiste nel posticipare il caricamento del video fino a quando un utente non interagisce con la pagina, in modo da ridurre l'impatto per quei visitatori che non consumano mai il video.

Possiamo portare questa analisi oltre per produrre una distribuzione della dimensione totale della pagina (in byte scaricati per tutte le risorse) in base alla presenza di una categoria di terze parti. Questo grafico mostra che la presenza della maggior parte delle categorie di terze parti non ha un impatto notevole sulla dimensione totale della pagina: ciò sarebbe visibile come una divergenza nei grafici. Un'eccezione degna di nota è la pubblicità (in nero) che mostra una relazione molto piccola con le dimensioni della pagina, indicando che le richieste di pubblicità non aggiungono peso significativo alle pagine. Ciò è probabile perché molte di queste richieste sono piccoli reindirizzamenti, la [mediana è solo 420 byte](#reindirizzamenti-di-grandi-dimensioni). Vediamo un simile basso impatto per i gestori di tag e le analisi.

All'altra estremità dello spettro, le categorie CDN, Content e Hosting rappresentano tutte una forte relazione con il peso totale della pagina. Ciò indica che i siti che utilizzano servizi ospitati hanno generalmente un peso di pagina maggiore.

{{ figure_markup(
  image="page-size-by-category.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1508418357&format=interactive",
  caption="Distribuzioni delle dimensioni della pagina per categoria di terze parti.",
  description="Distribuzione di categorie di terze parti e dimensioni della pagina che mostrano le relazioni tra la presenza di terze parti e la probabilità che le pagine siano grandi. CDN e hosting mostrano una forte correlazione, Analytics mostra una debole correlazione.",
  width=600,
  height=371,
  sheets_gid="727028027",
  sql_file="distribution_of_size_and_time_by_third_parties.sql"
  )
}}

### Cacheability

Alcune risposte di terze parti dovrebbero essere sempre memorizzate nella cache. Supporti come immagini e video forniti da terze parti o librerie JavaScript sono buoni candidati. D'altra parte, i pixel di tracciamento e i beacon di analisi non dovrebbero mai essere memorizzati nella cache. I risultati mostrano che complessivamente due terzi delle richieste di terze parti vengono servite con un header di cache valida come `cache-control`.

{{ figure_markup(
  image="requests-cached-by-content-type.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=299325299&format=interactive",
  caption="Richieste di terze parti memorizzate nella cache per tipo di contenuto.",
  description="Grafico a colonne che mostra la percentuale di richieste memorizzabili nella cache per tipo di contenuto. I caratteri sono i più alti al 96%, XML è il più basso al 18%",
  width=600,
  height=371,
  sheets_gid="1363055589",
  sql_file="percent_of_third_party_cache.sql"
  )
}}

La suddivisione in base al tipo di risposta conferma le nostre ipotesi: è meno probabile che le risposte xml e di testo (come comunemente fornite dai pixel di tracciamento/beacon di analisi) siano memorizzabili nella cache. Sorprendentemente, meno di due terzi delle immagini fornite da terze parti sono memorizzabili nella cache. A un'ulteriore ispezione, ciò è dovuto all'uso di 'pixel' di tracciamento che vengono restituiti come risposte di immagini gif di dimensioni zero non memorizzabili nella cache.

### Reindirizzamenti di grandi dimensioni

Molte terze parti generano risposte di reindirizzamento, ad esempio codici di stato HTTP 3XX. Questi si verificano a causa dell'utilizzo di domini vanity o per condividere informazioni tra domini tramite headers di richiesta. Ciò è particolarmente vero per le reti pubblicitarie. Le risposte di reindirizzamento di grandi dimensioni sono un'indicazione di una configurazione errata, poiché la risposta dovrebbe essere di circa 340B per un header di risposta `Location` valida più i costi generali. Il grafico seguente mostra la distribuzione delle dimensioni di body per tutti i reindirizzamenti di terze parti nell'HTTP Archive.

{{ figure_markup(
  image="redirects-body-size.png",
  caption="Distribuzione delle dimensioni di body 3XX di terze parti",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1145900631&format=interactive",
  description="La distribuzione delle dimensioni di body di reindirizzamento mostra che il 90% è inferiore a 420 B, l\'1% è superiore a 30 kB e lo 0.1% è superiore a 100 kB.",
  width=600,
  height=371,
  sheets_gid="1056232541",
  sql_file="distribution_of_3XX_response_body_size.sql"
  )
}}

I risultati mostrano che la maggior parte delle risposte 3XX è piccola: il 90° percentile è 420 byte, ovvero il 90% delle risposte 3XX è 420 byte o inferiore. Il 95° percentile è 6.5 kB, il 99° è 36 kB e il 99.9° è superiore a 100 kB! Sebbene i reindirizzamenti possano sembrare innocui, 100 kB sono una quantità irragionevole di byte in rete per una risposta che porta semplicemente a un'altra risposta.

## Caricatori precoci

Gli script che vengono caricati in ritardo nella pagina avranno un impatto sulla durata totale del caricamento della pagina e sul peso della pagina, ma potrebbero non avere alcun impatto sull'esperienza dell'utente. Gli script che vengono caricati all'inizio della pagina, tuttavia, possono potenzialmente cannibalizzare la larghezza di banda per le risorse di prime parti critiche e hanno maggiori probabilità di interferire con il caricamento della pagina. Ciò può avere un impatto negativo sulle metriche delle prestazioni e sull'esperienza utente.

Il grafico seguente mostra la percentuale di richieste caricate in anticipo, per tipo di dispositivo e categoria di terze parti. Le tre categorie di spicco sono CDN, Hosting e Tag Manager: tutte tendono a fornire JavaScript richiesto nell'head di un documento. È meno probabile che le risorse pubblicitarie vengano caricate all'inizio della pagina, poiché le richieste della rete pubblicitaria sono generalmente script asincroni eseguiti dopo il caricamento della pagina.

{{ figure_markup(
  image="requests-before-dom-by-category.png",
  caption="Prime richieste di terze parti per categoria.",
  description="Grafico a colonne che mostra la percentuale di richieste caricate prima del caricamento del contenuto DOM. Le risorse CDN pubbliche sono molto probabilmente al 50% su desktop, mentre le risorse pubblicitarie sono meno probabili al 7%",
  width=600,
  height=371,
  sheets_gid="2118409936",
  sql_file="percent_of_third_party_loaded_before_DOMContentLoaded.sql"
  )
}}

## Impatto sulla CPU

Non tutti i byte sul Web sono uguali: un'immagine da 500 KB può essere molto più facile da elaborare per un browser rispetto a un bundle JavaScript compresso da 500 KB, che si gonfia a 1.8 MB di codice lato client! L'impatto degli script di terze parti sul tempo della CPU può essere molto più critico dei byte aggiuntivi o del tempo trascorso sulla rete.

Possiamo correlare la presenza di categorie di terze parti con il tempo CPU totale sulla pagina, questo ci permette di stimare l'impatto di ciascuna categoria di terze parti sul tempo CPU.

{{ figure_markup(
  image="cpu-time-by-category.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=225817673&format=interactive",
  caption="Distribuzione del tempo della CPU per categorie.",
  description="Distribuzione del tempo di caricamento della CPU in base alla presenza di categorie di terze parti. La maggior parte delle categorie segue lo stesso schema, con la pubblicità del valore anomalo che mostra un tempo di caricamento della CPU più elevato, soprattutto a percentili inferiori.",
  width=600,
  height=371,
  sheets_gid="727028027",
  sql_file="distribution_of_size_and_time_by_third_parties.sql"
  )
}}

Questo grafico mostra la funzione di densità di probabilità del tempo CPU totale della pagina in base alle categorie di terze parti presenti su ciascuna pagina. La pagina mediana è a 50 sull'asse percentile. I dati mostrano che tutte le categorie di terze parti seguono uno schema simile, con la pagina mediana compresa tra 400 e 1.000 ms di tempo CPU. Il valore anomalo qui è la pubblicità (in nero): se una pagina ha tag pubblicitari è molto più probabile che abbia un elevato utilizzo della CPU durante il caricamento della pagina. La pagina mediana con tag pubblicitari ha un tempo di caricamento della CPU di 1.500 ms, rispetto ai 500 ms per le pagine senza pubblicità. L'elevato tempo di caricamento della CPU ai percentili inferiori indica che anche i siti più veloci sono influenzati in modo significativo dalla presenza di terze parti classificate come pubblicità.

## prevalenza di `timing-allow-origin`

La [Resource Timing API](https://developer.mozilla.org/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API) consente ai proprietari di siti web di misurare le prestazioni delle singole risorse tramite JavaScript. Questi dati sono, di default, estremamente limitati per le risorse cross-origin come i contenuti di terze parti. Esistono motivi legittimi per non fornire queste informazioni temporali come le risposte che variano in base allo stato di autenticazione: ad es. il proprietario di un sito web potrebbe essere in grado di determinare se un visitatore ha effettuato l'accesso a Facebook misurando la dimensione della risposta a una richiesta di widget. Per la maggior parte dei contenuti di terze parti, tuttavia, impostare l'header `timing-allow-origin` è un atto di trasparenza per consentire al sito Web di hosting di monitorare le prestazioni e le dimensioni del contenuto di terze parti.

{{ figure_markup(
  image="requests-with-tao.png",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSNXusoFJKi8Z1i_yuG_5umUCJOZwBMaZaECq4T8lU5zIQuLR7UHfZOJmXsXzPWQTJFnFa3dcOEPJgy/pubchart?oid=1886505312&format=interactive",
  caption="Richieste con l'header `timing-allow-origin`.",
  description="Meno del 35% delle risposte di terze parti viene fornito con un header timing-allow-origin",
  width=600,
  height=371,
  sheets_gid="1947152286",
  sql_file="tao_by_third_party.sql"
  )
}}

I risultati nel HTTP Archive mostrano che solo un terzo delle risposte di terze parti espone informazioni dettagliate su dimensioni e tempi al sito Web di hosting.

## Ripercussioni

Sappiamo che l'aggiunta di JavaScript arbitrario ai nostri siti introduce rischi sia per la velocità che per la sicurezza del sito. I proprietari dei siti devono essere diligenti per bilanciare il valore degli script di terze parti che includono con le penalità di velocità che possono comportare e utilizzare funzionalità moderne come [integrità subresource](https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity) e [politica di sicurezza dei contenuti](https://developer.mozilla.org/docs/Web/HTTP/CSP) per mantenere una solida posizione di sicurezza. Per maggiori dettagli  puoi vedere il [capitolo sulla sicurezza](./security) e altre funzioni di sicurezza del browser.

## Conclusione

Una delle sorprese nei dati del 2020 è il calo delle richieste JavaScript relative: dal 32% del totale a solo il 22%. È improbabile che la quantità effettiva di JavaScript sul Web sia diminuita in modo significativo, è più probabile che i siti Web stiano implementando la gestione del consenso, in modo che la maggior parte dei contenuti dinamici di terze parti venga caricata solo sull'attivazione dell'utente. Questo processo di attivazione potrebbe essere gestito da una piattaforma di gestione del consenso (CMP) in alcuni casi. Il database di terze parti non ha ancora una categoria per i CMP, ma questa sarebbe una buona analisi per il Web Almanac 2021 ed è trattata attraverso una diversa metodologia nel [capitolo sulla privacy](./privacy#consent-management-platforms).

Le richieste di pubblicità sembrano avere un maggiore impatto sul tempo della CPU. La pagina mediana con script pubblicitari consuma tre volte più CPU di quelle senza. È interessante notare che gli script pubblicitari non sono correlati con l'aumento del peso della pagina. Ciò rende ancora più importante valutare l'impatto totale degli script di terze parti sul browser, non solo il conteggio e le dimensioni delle richieste.

Sebbene il contenuto di terze parti sia fondamentale per molti siti Web, il controllo dell'impatto di ciascun provider è fondamentale per garantire che non influiscano in modo significativo sull'esperienza utente, sul peso della pagina o sull'utilizzo della CPU. Ci sono spesso opzioni di auto-hosting per i principali contributori al peso di terze parti, questo è particolarmente degno di considerazione poiché ora non vi è alcun vantaggio di memorizzazione nella cache nell'utilizzo di risorse condivise:

* Google Fonts consente <a hreflang="en" href="https://www.tunetheweb.com/blog/should-you-self-host-google-fonts/">l'hosting autonomo</a> delle risorse
* I CDN JavaScript possono essere sostituiti con risorse ospitate autonomamente
* Gli script di sperimentazione possono essere ospitati autonomamente, ad es. <a hreflang="en" href="https://help.optimizely.com/Set_Up_Optimizely/Optimizely_self-hosting_for_Akamai_users">Optimizely</a>

In questo capitolo abbiamo discusso i vantaggi e i costi dei contenuti di terze parti sul web. Abbiamo visto che le terze parti sono parte integrante di quasi tutti i siti Web e che l'impatto varia a seconda del provider di terze parti. Prima di aggiungere nuove terze parti alle tue pagine, considera l'impatto che avranno!
