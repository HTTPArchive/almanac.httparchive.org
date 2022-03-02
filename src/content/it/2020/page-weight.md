---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
description: Capitolo Page Weight (Peso della pagina) del Web Almanac 2020 che spiega perché il peso della pagina è importante, la larghezza di banda, le pagine complesse, il peso della pagina nel tempo, page requests e i formati di file.
authors: [henrihelvetica]
reviewers: [paulcalvano]
analysts: [paulcalvano]
editors: [tunetheweb]
translators: [chefleo]
henrihelvetica_bio: Henri è uno sviluppatore freelance che ha trasformato i suoi interessi in un pot-pourri di ingegneria delle prestazioni con pizzichi di esperienza utente. Quando non si legge il diluvio di documenti di ricerca quotidiana e casi di studio, o non si controlla indiscriminatamente i siti di auditing nei dev tools, Henri può essere trovato a contribuire alla comunità, co-programmando meetup tra cui <a href="https://twitter.com/towebperf">Toronto Web Performance Group</a> o offre volontariamente il suo tempo per pranzo e impara in vari bootcamp. Altrimenti, si sta attrezzando con software di produzione musicale o con una formazione quasi certa e si concentra sul correre 5k il più veloce possibile.
discuss: 2054
results: https://docs.google.com/spreadsheets/d/1wG4u0LV5PT9aN-XB1hixSFtI8KIDARTOCX0sp7ZT3h0/
featured_quote: Il viaggio sul web è passato dall'essere più vicini a una piattaforma mediocre ed educativa a un'app innovativa, complessa e altamente interattiva, con metriche di peso della pagina rudimentali che nascondono storie e due punti; una ratatouille di risorse, ognuna delle quali influenza le metriche moderne e, a sua volta, influisce sull'esperienza dell'utente.
featured_stat_1: 1,915
featured_stat_label_1: Il numero mediano di byte di pagine per dispositivi mobile
featured_stat_2: 916
featured_stat_label_2: Il numero mediano di byte dell'immagine della pagina per dispositivi mobile
featured_stat_3: 70
featured_stat_label_3: Il numero mediano di richieste di pagine per dispositivi mobile
---

## Introduzione

Il peso della pagina è una delle metriche più semplici disponibili. Proprio come salire su una bilancia per avere un'idea del tuo peso personale, caricare una pagina fornirà un senso del numero e della dimensione delle risorse raccolte e richieste. Ma con la maturazione e la crescita del Web e delle pagine Web, anche le metriche associate, come il peso della pagina. Può influire sulle prestazioni di una pagina proprio come il peso personale (massa) può fare lo stesso. Questo capitolo farà un'immersione più approfondita e sbloccherà gli strati delle pagine web e vedrà cosa costituisce il peso di una pagina a possibile discapito dell'utente finale: tu, io, noi.

<!-- markdownlint-disable MD018 -->
## #PageWeightStillMatters

#PageWeightStillMatters significherebbe quasi che non ha importanza o che non ha avuto importanza. Potrebbe non aver avuto importanza quando è stato lanciato Craigslist basato su testo. Ma 25 anni fa, quando è stata fondata, anche Mosaic 1.0 è stata lanciata lo stesso anno e Waterfalls di TLC è stato un grande successo. Il web è maturato così come le risorse. Erano passati solo pochi anni da quando il twitterverse era stato messo a punto discutendo di come la dimensione media delle pagine web ora fosse uguale alla dimensione del <a hreflang="en" href="https://www.wired.com/2016/04/average-webpage-now-size-original-doom/">originale doom</a>. Molti di noi hanno riflettuto su quale sarebbe stata la dimensione della pagina nel tempo, incluso il <a hreflang="en" href="https://speedcurve.com/blog/web-performance-page-bloat/">il nostro Tammy Everts</a>, ma la realtà è sorprendente. Una pagina si trova @ ~ 4 MB e 3.7 MB, desktop/mobile rispettivamente, al 75° percentile e uno scioccante 7.4 MB e 6.7 MB al 90° percentile. Ci sono moltitudini di implicazioni nell'avere pagine così pesanti, come la probabilità di una scarsa esperienza utente a causa di reti inaffidabili. Oggi, nonostante le lezioni <a hreflang="en" href="https://blog.chriszacharias.com/page-weight-matters">apprese un decennio fa</a>, stiamo sperimentando variazioni delle stesse sfide: nonostante abbiamo reti leggermente migliori, stiamo lavorando con risorse molto più grandi.
<!-- markdownlint-enable MD018 -->

### Larghezza di banda

Nel 2016, quando mi è stato chiesto di spiegare perché un turista australiano con cui avevo parlato era soddisfatto di Internet nel Regno Unito, Ilya Grigorik di Google <a hreflang="en" href="https://youtu.be/x4S38hpgxuM?t=89">aveva due parole</a>: Fisica dannazione!.

Il punto era semplice: sebbene si possa trarre vantaggio da una maggiore larghezza di banda, le leggi della fisica continuano a prevalere. Un australiano non è in grado di sfuggire alle leggi sulla latenza. Nella migliore delle ipotesi, a casa a Sydney, questo australiano stava vivendo una latenza sufficiente che a volte la sua connessione Internet era percepita come non rispondente.

Ora, immagina che lo stesso australiano, sapendo che al 75° percentile, la sua pagina stia facendo circa 108 richieste (ne parleremo più avanti), e non abbiamo ancora idea del protocollo di rete, delle risorse richieste, del livello di compressione o ottimizzazione. È possibile seguire i capitoli [HTTP/2](./http) e [Compressione](./compression) per ulteriori informazioni sulla durata di una richiesta moderna.

### Gli Assets

In 25 anni di navigazione moderna, gli assets e le risorse per lo più non sono cambiati, a parte la quantità. Il modus operandi del HTTP archive è "come è stato costruito il web", e questo è stato fatto principalmente con HTML, CSS, JavaScript e infine immagini.

Prima del 1995, il peso della pagina web era per lo più prevedibile e gestibile. Ma con <a hreflang="en" href="https://tools.ietf.org/html/rfc1866">RFC 1866</a>, che ha introdotto HTML 2.0 che ha introdotto immagini inline tramite l'elemento `<img>`, il peso della pagina aumenterebbe notevolmente, tutto per il bene dello sviluppo web (l'aggiunta di immagini era vista come un esperimento positivo).

Per la maggior parte, la regola generale è stata che le immagini rappresenterebbero la maggior parte del peso della pagina. Era certamente il caso e una preoccupazione quando le immagini inline sono state aggiunte al web allora e rimane il caso oggi. In uno scenario separato, poiché i dati di image saranno la principale fonte di peso della pagina, sarà anche la principale fonte di risparmio di peso della pagina (di nuovo, ne parleremo più avanti). Ciò sarà ottenuto assicurando che le immagini siano dimensionate correttamente, ma anche assicurandosi che le immagini siano nel punto ottimale dell'ottimizzazione, trovando il miglior equilibrio tra qualità e dimensione del file.

Sebbene JavaScript sia in media la seconda risorsa più abbondante in una pagina, tendiamo ad avere più opportunità nel lavorare con quel tipo di file: dal raggruppamento, compressione e minimizzazione per citarne alcuni.

### Intricato e interattivo

Il viaggio sul web è passato dall'essere più vicini a una piattaforma mediocre ed educativa a un'app innovativa, complessa e altamente interattiva, con metriche di peso della pagina rudimentali che nascondono storie e due punti; una ratatouille di risorse, ognuna delle quali influenza le metriche moderne e, a sua volta, influisce sull'esperienza dell'utente.

Ogni volta che parliamo di interattività, parliamo quasi esclusivamente di JavaScript. Ora, sebbene non siamo qui per discutere dell'interattività in modo approfondito, sappiamo che esistono metriche focalizzate e dipendenti dal contenuto e dall'esecuzione di JavaScript. Quindi più pesante è il JavaScript, più è probabile che influenzi le metriche interattive (tempo per l'interattività, tempo di blocco totale). Per maggiori, consultare il [capitolo JavaScript](./javascript) di quest'anno.

## Analisi

Quando pubblichiamo e analizziamo i risultati statistici, i dati sono spesso basati sulle dimensioni di trasferimento. Tuttavia, quando possibile utilizziamo dimensioni decompresse in questa analisi.

### Peso della pagina

Diamo un'occhiata al peso delle pagine tradizionali sia su desktop che su dispositivi mobile. La maggior parte del delta è dovuta al minor numero di risorse trasferite sui dispositivi mobile e a un pizzico di gestione dei media, ma in media possiamo vedere che la differenza tra i due client non è così grande.

{{ figure_markup(
  image="bytes-distribution.png",
  caption="Distribuzione dei byte totali per pagina.",
  description="Grafico a barre che mostra la distribuzione dei byte totali per pagina. Le pagine desktop tendono ad avere più byte in tutta la distribuzione. I percentili 10, 25, 50, 75 e 90 per le pagine per dispositivi mobile sono: 369, 900, 1.915, 3.710 e 6.772 KB per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=248363224&format=interactive",
  sheets_gid="378779486",
  sql_file="bytes_per_type_2020.sql"
) }}

Tuttavia, possiamo dedurre quanto segue: il peso della pagina di 7 MB su dispositivi mobile e 7.5 MB su desktop si sta avvicinando al 90° percentile. Questi dati seguono un trend di lunga data: la crescita del peso delle pagine è nuovamente in aumento rispetto all'anno precedente.

{{ figure_markup(
  image="bytes-distribution-content-type.png",
  caption="Byte mediani per pagina in base al tipo di contenuto.",
  description="Grafico a barre che mostra il numero mediano di byte per pagina per immagini, JavaScript, CSS e HTML. La pagina desktop mediana tende ad avere più byte. La pagina mobile mediana ha 916 KB di immagini, 411 KB di JS, 62 KB di CSS e 25 KB di HTML.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=1147150650&format=interactive",
  sheets_gid="378779486",
  sql_file="bytes_per_type_2020.sql"
) }}

Puoi vedere come appaiono i valori mediani e medi per ciascuna risorsa. Resta ancora una cosa: le immagini sono la risorsa dominante e JavaScript è la seconda.

### Richieste

Abbiamo un vecchio detto: la richiesta più rapida è quella che non viene mai fatta. Basti pensare che la risorsa più piccola è quella che non è mai stata richiesta. A livello di richiesta, molto è lo stesso. La risorsa più pesante fa il maggior numero di richieste.

{{ figure_markup(
  image="requests-distribution.png",
  caption="Distribuzione delle richieste per pagina.",
  description="Grafico a barre che mostra la distribuzione delle richieste per pagina. Le pagine desktop tendono a caricare più richieste. I percentili 10, 25, 50, 75 e 90 per le pagine per dispositivi mobile sono: 23, 42, 70, 114 e 174 richieste per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=971564375&format=interactive",
  sheets_gid="457486298",
  sql_file="request_type_distribution_2020.sql"
) }}

La distribuzione delle richieste mostra che la differenza tra desktop e mobile non è così significativa, con il desktop in testa. Qualcosa che vale la pena notare: la richiesta mediana sul desktop in questo momento è la stessa [dell'anno scorso](../2019/page-weight#page-requests) (74), ma il peso della pagina è aumentato (+122kb). Una semplice osservazione, ma che conferma la traiettoria che abbiamo visto negli anni.

{{ figure_markup(
  image="requests-content-type.png",
  caption="Numero mediano di richieste per pagina per dispositivi mobile in base al tipo di contenuto.",
  description="Grafico a barre che mostra il numero medio di richieste per pagina per dispositivi mobile in base al tipo di contenuto. Il numero medio di richieste di immagini per pagina è 27, 19 per JS, 7 per CSS e 3 per HTML. Desktop e mobile tendono ad essere uguali, tranne per il fatto che le pagine desktop caricano un po' più di richieste di immagini e JS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=101271976&format=interactive",
  sheets_gid="457486298",
  sql_file="request_type_distribution_2020.sql"
) }}

Le immagini costituiscono ancora il maggior numero di richieste, anche se JavaScript si sta riducendo poiché il divario si è leggermente ridotto nell'ultimo anno.

### I formati di file

{{ figure_markup(
  image="response-distribution-format.png",
  caption="Distribuzione delle dimensioni delle immagini per formato.",
  description="Box plot della distribuzione delle dimensioni delle immagini per formato: gif, ico, jpg, png, svg e webp. Jpg si distingue per avere la distribuzione più alta con un 90° percentile superiore a 150 KB per immagine. Png è il secondo più alto con circa 100 KB al 90° percentile. Sebbene WebP abbia un 90° percentile più piccolo di png, il suo 75° percentile è più alto. gif, ico e svg hanno tutte distribuzioni relativamente piccole vicino a 0 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=211653520&format=interactive",
  sheets_gid="142855724",
  sql_file="response_format_distribution.sql"
) }}

Sappiamo che le immagini sono una grande fonte di peso della pagina. Il grafico sopra ci mostra le principali fonti di peso dell'immagine e la distribuzione del peso. Top 3: JPG, PNG e WebP. Quindi non solo il JPG è il formato di immagine più popolare, ma tende anche ad essere il più grande per dimensione, anche più grande di un formato senza perdita di dati come il PNG. Ma come abbiamo [notato l'anno scorso](../2019/page-weight#file-size-by-image-format-for-images--1024-bytes), ciò ha a che fare con il caso d'uso predominante per il PNG, che sembrano essere icone e loghi.

### Byte immagine

{{ figure_markup(
  image="response-distribution-images.png",
  caption="Distribuzione delle dimensioni delle risposte alle immagini per pagina.",
  description="Grafico a barre che mostra la distribuzione dei byte dell'immagine per pagina. Le pagine desktop tendono a caricare più byte di immagine per pagina in tutta la distribuzione. I percentili 10, 25, 50, 75 e 90 per le pagine per dispositivi mobile sono: 67, 284, 928, 2.365 e 4.975 KB di immagini per pagina.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=2019686506&format=interactive",
  sheets_gid="730277265",
  sql_file="request_type_distribution_2020.sql"
) }}

Osservando i byte totali dell'immagine, vediamo la stessa tendenza al rialzo, come notato in precedenza sul peso complessivo della pagina.

## COVID-19

Il 2020 è stato l'anno più impegnativo nella storia di Internet. Questo si basa sull'auto-segnalazione di <a hreflang="en" href="https://www2.telegeography.com/network-impact">società di telecomunicazioni</a> in tutto il mondo. YouTube, Netflix, i produttori di console di gioco e molti altri sono stati invitati a <a hreflang="en" href="https://www.bloomberg.com/news/articles/2020-03-19/netflix-to-cut-streaming-traffic-in-europe-to-relieve-networks">limitare le loro reti</a> a causa delle richieste di larghezza di banda previste del coronavirus e dagli ordini di restare a casa. Ora ci sono nuovi sospetti che creano richieste sulle reti: ora stiamo lavorando da casa, in teleconferenza da casa e anche a scuola da casa. Nel bel mezzo di questa crisi alcune organizzazioni governative si sono mosse per ottimizzare tutti gli aspetti del sito e riprogettarlo o aggiornarlo. Due di questi esempi sono <a hreflang="en" href="https://ca.gov">ca.gov</a> (<a hreflang="en" href="https://news.alpha.ca.gov/prioritizing-users-in-a-crisis-building-covid19-ca-gov/">link</a>) e <a hreflang="en" href="https://gov.uk"> gov.uk </a>. In questi tempi, COVID-19 ha certificato Internet come servizio essenziale e la possibilità di accedere a informazioni cruciali e salvavita, deve essere il più possibile priva di attriti, il che include un peso di pagina gestibile tramite la consegna disciplinare dei dati.

Se siamo stati sposati con Internet, il COVID-19 ci ha costretti a rinnovare i nostri voti. Garantendo che il contenuto venga distribuito nel modo più efficiente possibile su Internet, il peso della pagina deve essere mantenuto in primo piano in ogni momento.

## Un futuro non così lontano

Abbiamo osservato per 25 anni il peso delle pagine crescere costantemente. Potrebbe essere stato uno dei più grandi investimenti in azioni, se fosse stato uno. Ma questo è il web e, stiamo cercando di gestire i dati, le richieste, le dimensioni dei file e in definitiva il peso della pagina.

Abbiamo appena setacciato i dati, vedendo come le immagini siano la maggiore fonte di peso. Ciò significa che sarà anche la nostra più grande fonte di risparmio. Il 2020 è stato un anno fondamentale, un possibile punto di svolta per il monitoraggio dei dati web da parte del HTTP Archive. Il 2020 ha segnato l'anno in cui il formato moderno WebP è stato finalmente adottato da Safari, rendendo questo formato finalmente supportato da tutti i browser su tutta la linea. Ciò significa che il formato potrebbe essere utilizzato comodamente con poche o nessuna possibilità di ripiego. Il punto più importante? Il potenziale per un significativo risparmio di peso della pagina esiste - a un possibile 30%.

Ancora più interessante è l'idea di un formato più moderno: avif. Questo formato è esploso sulla scena con un supporto sufficiente oggi per una quota di mercato del browser di circa il 70%, creando uno scenario per file di immagine di piccole dimensioni, anche più piccoli di WebP. E infine, e forse il più distante: media query di livello 5, `prefers-reduced-data`. Sebbene all'inizio della bozza, questa funzione multimediale verrà utilizzata per rilevare se un utente può avere una preferenza per le risorse varianti in situazioni sensibili ai dati e ha già <a hreflang="en" href="https://caniuse.com/mdn-css_at-rules_media_prefers-reduced-data">iniziato a essere disponibile nei browser</a>.

Guardando la sfera di cristallo, la terza puntata del Web Almanac e il capitolo Page Weight potrebbero avere un aspetto molto diverso nel 2021. I grandi investimenti tecnologici e ingegneristici nelle immagini potrebbero finalmente fornire i rendimenti decrescenti che stavamo cercando.

## Conclusione

Non c'è da meravigliarsi se le pagine web generalmente continuano a crescere. Abbiamo investito più risorse per offrire esperienze più ricche, interattività più avvincente e immagini accattivanti con immagini più potenti. Abbiamo creato queste applicazioni a scapito del sovraccarico di dati e dell'esperienza utente. Ma mentre andiamo avanti e spingiamo il Web in luoghi inaspettati, come accennato in precedenza, stiamo facendo ulteriori progressi nella progettazione. Non appena verranno adottati i più recenti formati di immagine raster, JavaScript sarà gestito in modo più efficiente e i dati potranno essere forniti con la disciplina che gli utenti desiderano, il peso della pagina sarà ridotto già dal prossimo anno.
