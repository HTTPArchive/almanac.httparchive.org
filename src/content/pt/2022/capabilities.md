---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Capacidades
description: Capítulo "Capacidades" do Web Almanac de 2022 abordando APIs inovadoras e poderosas da plataforma web que proporcionam acesso a interfaces de hardware para aplicativos web, aprimoram aplicativos de produtividade baseados na web e muito mais.
hero_alt: Hero image of Web Almanac characters with superhero capes plugging various capabilities into a web page.
authors: [MichaelSolati]
reviewers: [tomayac, christianliebel]
analysts: [tunetheweb]
editors: [tunetheweb]
translators: [HakaCode]
MichaelSolati_bio: Michael é um Defensor de Desenvolvedores na Amplication, concentrando-se em ajudar desenvolvedores a construir APIs e apreciar IPAs. Além disso, ele é um Web GDE (Google Developer Expert) e encontrou seu amor na criação de experiências envolventes na web e nas práticas misteriosas da web...
results: https://docs.google.com/spreadsheets/d/13S9FRj8OPRtoMPb94jFh6pPNz3lNS9yztIaorZYe288/
featured_quote: O Projeto Capacidades permite que aplicativos migrem para a web, eliminando algumas barreiras associadas a aplicativos específicos de plataformas.
featured_stat_1: 38
featured_stat_label_1: As capacidades foram utilizadas em um site.
featured_stat_2: ~10%
featured_stat_label_2: Sites em dispositivos móveis e desktop utilizam a _Async Clipboard API_.
featured_stat_3: 8%
featured_stat_label_3: Sites em dispositivos móveis e desktop utilizam a _Web Share API_.
---

## Introdução

Experiências envolventes na web não estão limitadas às capacidades básicas do navegador; elas podem aproveitar o sistema operacional subjacente. As APIs da plataforma web expõem essas capacidades que são a base para [Progressive Web Apps (PWA)](./pwa)— aplicativos web capazes de oferecer experiências de alta qualidade, semelhantes a aplicativos específicos de plataformas.

Além disso, algumas funcionalidades na plataforma web proporcionam acesso a recursos de nível mais baixo, como acesso ao [sistema de arquivos](https://developer.mozilla.org/docs/Web/API/File_System_Access_API), [geolocalização](https://developer.mozilla.org/pt-BR/docs/Web/API/Geolocation_API), acesso à [área de transferência](https://developer.mozilla.org/docs/Web/API/Clipboard_API), e até mesmo a capacidade de detectar [gamepads](https://developer.mozilla.org/pt-BR/docs/Web/API/Gamepad_API).

## Metodologia

Este capítulo utilizou o conjunto de dados público do HTTP Archive, composto por milhões de páginas. Essas páginas foram arquivadas como se fossem visitadas tanto em desktop quanto em dispositivos móveis, pois alguns sites fornecem conteúdo diferente com base no dispositivo que está solicitando a página.

O rastreador do HTTP Archive analisou o código-fonte de todas essas páginas para determinar quais APIs foram (potencialmente) utilizadas nelas. Por exemplo, expressões regulares, como `/navigator\.share\s*\(/g`, testam as páginas para verificar se, no caso específico, a [Web Share API](https://developer.mozilla.org/docs/Web/API/Web_Share_API) é encontrada em seu código-fonte.

Este método apresenta dois problemas significativos. Em primeiro lugar, ele pode sub-relatar o uso de algumas APIs, pois não consegue detectar código ofuscado que pode existir devido à minificação, por exemplo, quando `navigator` foi minificado para `n`. Além disso, pode super-relatar ocorrências de APIs porque não executa o código para verificar se uma API é realmente utilizada. Apesar dessas limitações, acreditamos que esta metodologia deve fornecer uma visão suficientemente boa das capacidades que são utilizadas na web.

Existem setenta e cinco expressões regulares no total para capacidades suportadas; consulte este <a hreflang="en" href="https://github.com/HTTPArchive/custom-metrics/blob/5d2f74fbdc580e76da5d1dad738fca8381429b9a/dist/fugu-apis.js">arquivo fonte</a> para ver todas as expressões utilizadas.

Os dados de uso neste capítulo são de um rastreamento em junho de 2022; você pode visualizar os dados brutos na <a hreflang="en" href="https://docs.google.com/spreadsheets/d/13S9FRj8OPRtoMPb94jFh6pPNz3lNS9yztIaorZYe288/edit?usp=sharing">Planilha de Resultados das Capacidades 2022</a>.

Este capítulo também comparará o uso de APIs com o uso do ano passado; você pode visualizar os dados brutos do ano anterior na <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/edit#gid=2077755325">Planilha de Resultados das Capacidades 2021</a>.

## Async Clipboard API

Nossa primeira API, o [_Async Clipboard API_](https://developer.mozilla.org/docs/Web/API/Clipboard_API), permite acesso de leitura/escrita à área de transferência do sistema.

Observe que a Async Clipboard API substitui a API `document.execCommand()` obsoleta para acessar a área de transferência.

### Acesso de escrita

Para escrever dados na área de transferência, existem os métodos [`writeText()`](https://developer.mozilla.org/docs/Web/API/Clipboard/writeText) e [`write()`](https://developer.mozilla.org/docs/Web/API/Clipboard/write). O método `writeText()` recebe um argumento de String e retorna uma Promise, enquanto `write()` recebe um array de objetos [`ClipboardItem`](https://developer.mozilla.org/docs/Web/API/ClipboardItem)  e também retorna uma Promise. Objetos `ClipboardItem` podem conter dados arbitrários, como imagens.

Existe uma lista dos tipos de dados obrigatórios que um navegador deve suportar pela especificação da Clipboards API; consulte esta <a hreflang="en" href="https://www.w3.org/TR/clipboard-apis/#mandatory-data-types-x">lista do W3C</a>. Infelizmente, nem todos os fornecedores suportam a lista completa; verifique a documentação específica do navegador sempre que possível.

```js
await navigator.clipboard.writeText("hello world");

const blob = new Blob(["hello world"], { type: "text/plain" });
await navigator.clipboard.write([
  new ClipboardItem({
    [blob.type]: blob,
  }),
]);
```

### Acesso de leitura

Para ler dados da área de transferência, existem os métodos [`readText()`](https://developer.mozilla.org/docs/Web/API/Clipboard/readText) e [`read()`](https://developer.mozilla.org/docs/Web/API/Clipboard/read) . Ambos os métodos retornam uma Promise que será resolvida com os dados da área de transferência. O método `readText()`  resolve como uma String, enquanto `read()` resolve como um array de objetos `ClipboardItem`.

```js
const item = await navigator.clipboard.readText();
const items = await navigator.clipboard.read();
```

Para manter os dados do usuário seguros, a permissão `"clipboard-read"` da [Permissions API](https://developer.mozilla.org/docs/Web/API/Permissions_API) deve ser concedida para ler dados da área de transferência.

Tanto o acesso de leitura quanto de escrita à área de transferência estão disponíveis nas versões modernas do Chrome, Edge e Safari. O Firefox suporta apenas `writeText()`.

### Crescimento da Async Clipboard API

{{ figure_markup(
  image="Async-Clipboard-API-Usage.png",
  caption="O uso da Async Clipboard API de 2021 para 2022 em desktop e dispositivos móveis.",
  description="O uso da Async Clipboard API cresceu de 8,91% em 2021 para 10,10% em 2022 em desktop. Em dispositivos móveis, o uso cresceu de 8,25% em 2021 para 9,27% em 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=602028150&format=interactive",
  sheets_gid="637848098",
  sql_file="fugu.sql"
) }}

A Async Clipboard API apresentou crescimento no uso, passando de 8,91% em 2021 para 10,10% em 2022 em desktop. Em dispositivos móveis, também houve crescimento, de 8,25% em 2021 para 9,27% em 2022. Como resultado, este ano, a Async Clipboard API foi a API mais utilizada tanto em desktop quanto em dispositivos móveis, superando a Web Share API (API mais utilizada no ano anterior).

## Web Share API

A [_Web Share API_](https://developer.mozilla.org/docs/Web/API/Web_Share_API) invoca o mecanismo de compartilhamento específico da plataforma do dispositivo, permitindo que dados, como texto, uma URL ou arquivos, de um aplicativo web sejam compartilhados com qualquer outro aplicativo, como clientes de e-mail, aplicativos de mensagens e muito mais.

O método chamado para compartilhar dados é [`navigator.share()`](https://developer.mozilla.org/pt-BR/docs/Web/API/Navigator/share). O método `navigator.share()` aceita um objeto contendo os dados a serem compartilhados e retorna uma Promise. Nem todo tipo de arquivo pode ser compartilhado, no entanto, o método [`navigator.canShare()`](https://developer.mozilla.org/docs/Web/API/Navigator/canShare) pode testar um objeto de dados para verificar se o navegador pode compartilhá-lo. Você pode ver a [lista de tipos de arquivo compartilháveis](https://developer.mozilla.org/pt-BR/docs/Web/API/Navigator/share#shareable_file_types) na MDN.

Após chamar `navigator.share()`, o navegador abrirá uma folha específica da plataforma onde os usuários selecionam com qual aplicativo compartilhar os dados.

Além disso, a Web Share API só pode ser acionada por uma interação do usuário com a página, como um clique em um botão; a Web Share API não pode ser chamada arbitrariamente por código executado.

```js
const data = {
  url: "https://almanac.httparchive.org/en/2022/capabilities",
};

if (navigator.canShare(data)) {
  try {
    await navigator.share(data);
  catch (err) {
    console.error(err.name, err.message);
  }
}
```

A Web Share API está disponível em versões modernas do Chrome, Edge e Safari. No entanto, para o Chrome, ela é suportada apenas no Windows e no ChromeOS.

### Crescimento da Web Share API

{{ figure_markup(
  image="Web-Share-API-Usage.png",
  caption="O uso da Web Share API de 2021 para 2022 em desktop e dispositivos móveis.",
  description="O uso da Web Share API diminuiu de 9,00% em 2021 para 8,84% em 2022 em desktop. Em dispositivos móveis, o uso diminuiu de 8,58% em 2021 para 8,36% em 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=934956615&format=interactive",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
) }}

A Web Share API diminuiu em uso de 9,00% em 2021 para 8,84% em 2022 em desktop. Em dispositivos móveis, o uso diminuiu de 8,58% em 2021 para 8,36% em 2022. Como resultado, este ano, a Web Share API foi a segunda API mais utilizada tanto em desktop quanto em dispositivos móveis, ficando atrás da Async Clipboard API — a segunda API mais utilizada no ano passado.

Em muitos sites, é possível encontrar a Web Share API em uso. Por exemplo, plataformas de mídia social, sites de documentação e outros a utilizam como uma ótima maneira de compartilhar conteúdo. Alguns exemplos onde você pode encontrar a API em uso incluem <a hreflang="en" href="https://web.dev/">web.dev</a> e [twitter.com](https://x.com/).

{{ figure_markup(
  gif="Web-Share-API.gif",
  image="Web-Share-API.webp",
  caption="Compartilhando um perfil do Twitter usando a Web Share API.",
  description="Compartilhando um perfil do Twitter usando a Web Share API.",
  width=640,
  height=360
) }}

## Adicionar à Tela Inicial

A capacidade de adicionar um aplicativo web à tela inicial de um dispositivo é uma funcionalidade que não examinamos no relatório de Capacidades do ano passado. Para calcular quantos sites têm essa funcionalidade, as páginas foram testadas para ver se tinham um ouvinte para o evento [`beforeinstallprompt`](https://developer.mozilla.org/docs/Web/API/Window/beforeinstallprompt_event) event.

Observe que o evento `beforeinstallprompt` é uma API exclusiva do Chromium e atualmente está <a hreflang="en" href="https://wicg.github.io/manifest-incubations/index.html#installation-prompts">em fase de incubação dentro do WICG</a>.

O evento `beforeinstallprompt` é acionado imediatamente antes de um usuário ser solicitado a "instalar" um aplicativo web. O uso de um ouvinte de eventos para o evento `beforeinstallprompt` não é necessário para que aplicativos web sejam adicionados à tela inicial de um dispositivo, portanto, é seguro assumir que o uso real é muito maior. No entanto, essa metodologia nos permitirá ter uma ideia de quão popular é essa funcionalidade.

A capacidade de adicionar um aplicativo à tela inicial é uma característica crucial das PWAs. Para usar essa funcionalidade, os aplicativos web devem atender aos <a hreflang="en" href="https://web.dev/articles/install-criteria?hl=pt-br#criteria">seguintes critérios</a>:

- O aplicativo web não deve estar instalado.
- O usuário deve ter passado pelo menos 30 segundos visualizando a página em algum momento.
- O usuário deve ter clicado ou tocado pelo menos uma vez na página em algum momento.
- O aplicativo web deve ser servido por HTTPS.
- O aplicativo web deve incluir um [manifesto de aplicativo web](https://developer.mozilla.org/pt-BR/docs/Web/Manifest) com:
  - `short_name` ou `name`.
  - `icons` (deve incluir um ícone de 192x192 pixels e um ícone de 512x512 pixels).
  - `start_url`.
  - `display` (deve ser um dos seguintes: `fullscreen`, `standalone`, ou `minimal-ui`).
  - `prefer_related_applications` (não deve estar presente ou deve ser `false`).
- O aplicativo web deve registrar um service worker com um manipulador de `fetch`.

Aplicações instaladas podem aparecer em menus Iniciar, desktops, telas iniciais, na pasta de Aplicativos, ao procurar aplicativos em um dispositivo, em folhas de compartilhamento de conteúdo e muito mais.

A capacidade de adicionar à tela inicial está disponível apenas em versões modernas do Chrome, Edge e Safari no iOS e iPadOS.

### Usage of Add to Home Screen

{{ figure_markup(
  caption="Uso do Adicionar à Tela Inicial",
  content="7.71%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

Como mencionado, a capacidade de "Adicionar à Tela Inicial" não foi medida no ano passado. No entanto, para posteridade e relatórios detalhados, o evento `beforeinstallprompt` foi usado em 8,56% das páginas desktop e 7,71% das páginas móveis, tornando-se a terceira capacidade mais usada em desktop e mobile.

Ao aproveitar o evento `beforeinstallprompt`, os desenvolvedores podem fornecer uma experiência personalizada na forma como os usuários instalam seu aplicativo web. Um exemplo é o YouTube TV, que convida os usuários a instalar seu aplicativo para acessá-lo de forma mais rápida e fácil.

{{ figure_markup(
  gif="Add-to-Home-Screen.gif",
  image="Add-to-Home-Screen.webp",
  caption="Instalando o YouTube TV a partir de um prompt no aplicativo, alimentado pelo evento `beforeinstallprompt`.",
  description="Instalando o YouTube TV a partir de um prompt no aplicativo, alimentado pelo evento `beforeinstallprompt`.",
  width=640,
  height=360
) }}

## Media Session API

A [_Media Session API_](https://developer.mozilla.org/docs/Web/API/Media_Session_API) permite que os desenvolvedores criem notificações personalizadas para conteúdo de áudio ou vídeo na web. A API inclui manipuladores de ações que os navegadores podem usar para acessar o controle de mídia em teclados, headsets e os controles de software na área de notificação e nas telas de bloqueio de um dispositivo. A Media Session API capacita os usuários a saberem e controlarem o que está sendo reproduzido em uma página da web sem precisar estar ativamente visualizando essa página.

Quando uma página reproduz conteúdo de áudio ou vídeo, os usuários recebem uma notificação de mídia que aparece na bandeja de notificações de seus dispositivos móveis ou no hub de mídia de seus desktops. Os navegadores tentarão mostrar um título e um ícone, mas a Media Session API permite que a notificação seja personalizada com metadados de mídia ricos, como título, nome do artista, nome do álbum e arte do álbum.

```js
navigator.mediaSession.metadata = new MediaMetadata({
  title: "Creep",
  artist: "Radiohead",
  album: "Pablo Honey",
  artwork: [
    {
      src: "https://via.placeholder.com/96",
      sizes: "96x96",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/128",
      sizes: "128x128",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/192",
      sizes: "192x192",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/256",
      sizes: "256x256",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/384",
      sizes: "384x384",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/512",
      sizes: "512x512",
      type: "image/png",
    },
  ],
});
```

A Media Session API está disponível em versões modernas do Chrome, Edge, Firefox e Safari.

### Uso da Media Session API

{{ figure_markup(
  caption="Uso da Media Session API em dispositivos móveis.",
  content="7.41%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

A Media Session API não foi medida no ano passado. Em seu primeiro ano de rastreamento, a API foi utilizada em 8,37% das páginas desktop e 7,41% das páginas móveis, tornando-se a quarta capacidade mais utilizada em desktop e mobile.

Aplicativos web, como YouTube, YouTube Music, Spotify e outros, aproveitam a Media Session API e fornecem controles avançados para o vídeo ou áudio reproduzido.

{{ figure_markup(
  image="Media-Session-API.png",
  caption="Acessando controles e informações para o YouTube Music pela barra de tarefas do Windows.",
  description="Acessando controles e informações para o YouTube Music pela barra de tarefas do Windows.",
) }}

Para uma análise mais aprofundada sobre o uso de vídeo na web, confira o capítulo [Media](./media#video).

## Device Memory API

As capacidades de um dispositivo dependem de algumas coisas, como a rede, a contagem de núcleos da CPU e a quantidade de memória disponível. A [_Device Memory API_](https://developer.mozilla.org/docs/Web/API/Device_Memory_API) fornece insights sobre a memória disponível, disponibilizando a propriedade somente leitura `deviceMemory` na interface `Navigator`. A propriedade retorna uma quantidade aproximada de memória do dispositivo em gigabytes como um número de ponto flutuante.

O valor retornado é impreciso para proteger a privacidade do usuário. Ele é calculado arredondando para baixo para a potência de 2 mais próxima e, em seguida, dividindo esse número por 1.024. O número também é limitado a um valor máximo e mínimo. Assim, você pode esperar números como `0.25`, `0.5`, `1`, `2`, `4`, e `8` (gigabytes).

```js
const memory = navigator.deviceMemory;
console.log('This device has at least ', memory, 'GiB of RAM.');
```

A Device Memory API está disponível apenas em versões modernas do Chrome e Edge.

### Uso da Device Memory API

{{ figure_markup(
  caption="Uso da Device Memory API em dispositivos móveis.",
  content="5.76%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

A Device Memory API não foi medida no ano passado. Em seu primeiro ano de rastreamento, a API foi utilizada em 6,27% das páginas desktop e 5,76% das páginas móveis, tornando-se a quinta capacidade mais utilizada em desktop e mobile.

Para o lançamento do redesenho do Facebook em 2019, o FB5, eles integraram ativamente o carregamento adaptativo nesta nova versão. Eles fizeram isso adaptando-se com base no hardware real dos usuários, alterando o que era carregado e executado com base no que os usuários estavam utilizando. Por exemplo, no desktop, o Facebook definiu grupos de usuários com base nos núcleos da CPU ([`navigator.hardwareConcurrency`](https://developer.mozilla.org/docs/Web/API/Navigator/hardwareConcurrency)) e na memória do dispositivo (`navigator.deviceMemory`) disponíveis.

Confira <a hreflang="en" href="https://www.youtube.com/watch?v=puUPpVrIRkc&t=1443s">este vídeo</a> do Chrome Dev Summit 2019, começando em 24:03, onde Nate Schloss compartilha como o Facebook lida com o carregamento adaptativo usando recursos como a Device Memory API.

## Service Worker API

[_Service workers_](https://developer.mozilla.org/pt-BR/docs/Web/API/Service_Worker_API) são um dos componentes principais das Progressive Web Apps. Eles atuam como um proxy no lado do cliente que coloca os desenvolvedores no controle do cache do sistema e de como responder às solicitações de recursos. Ao pré-armazenar recursos essenciais, os desenvolvedores podem eliminar a dependência da rede, garantindo experiências instantâneas e confiáveis.

Além de armazenar em cache recursos, os service workers podem atualizar ativos do servidor, permitir notificações push e conceder acesso às APIs de segundo plano e de sincronização de segundo plano periódica.

Embora os service workers tenham sido amplamente adotados e suportados pelos principais navegadores, nem todos os recursos dos service workers estão disponíveis em todos os navegadores. Um exemplo de recurso atualmente não suportado é o Push API no Safari. O Safari oferecerá suporte ao Push API no próximo lançamento do <a hreflang="en" href="https://www.apple.com/macos/macos-ventura-preview/features/">macOS Ventura</a> em 2022 e no <a hreflang="en" href="https://www.apple.com/ios/ios-16/features/">iOS 16</a> e iPadOS 16 em 2023.

A Service Worker API está disponível em versões modernas do Chrome, Edge, Firefox e Safari.

### Growth of the Service Worker API

{{ figure_markup(
  image="Service-Worker-API-Usage.png",
  caption="Uso da Service Worker API de 2021 para 2022 em desktop e dispositivos móveis.",
  description="O uso da Service Worker API cresceu de 3,05% em 2021 para 4,17% em 2022 em desktop. Em dispositivos móveis, o uso aumentou de 3,22% em 2021 para 3,85% em 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=304563360&format=interactive",
  sheets_gid="208641216",
  sql_file="fugu.sql"
) }}

A Service Worker API não foi medida no capítulo de Capacidades do ano passado. No entanto, usando [dados do capítulo PWA do ano anterior](/en/2021/pwa#service-workers-usage), a API cresceu em uso de 3,05% para 4,17% em páginas desktop e de 3,22% para 3,85% em páginas móveis, tornando-se a sexta capacidade mais usada em desktop e a sétima mais usada em dispositivos móveis.

Observe que a forma como o uso do service worker no capítulo PWA é medido difere da maneira como o capítulo de Capacidades o mede. Além disso, um bug no pipeline de dados do capítulo PWA do ano passado foi encontrado, resultando em uma contagem menor do uso do service worker.

Para uma análise mais aprofundada sobre o uso de service workers na web, confira o [capítulo PWA](/en/2022/pwa#service-workers) do Web Almanac de 2022.

## Gamepad API

A [_Gamepad API_](https://developer.mozilla.org/pt-BR/docs/Web/API/Gamepad_API) é como as aplicações web respondem à entrada de gamepads e outros controladores de jogos. Esta API possui três interfaces: uma que representa o controlador conectado ao dispositivo, uma que representa os botões no controlador conectado e, finalmente, uma para eventos disparados quando um gamepad é conectado ou desconectado.

```js
window.addEventListener("gamepadconnected", (e) => {
  const gp = navigator.getGamepads()[e.gamepad.index];
  console.log(`Controller connected at index ${gp.index}`);
});
```

A Gamepad API está disponível em versões modernas do Chrome, Edge, Firefox e Safari.

### Crescimento da Gamepad API

{{ figure_markup(
  image="Gamepad-API-Usage.png",
  caption="Uso da Gamepad API de 2021 para 2022 em desktop e dispositivos móveis.",
  description="O uso da Gamepad API diminuiu de 4,39% em 2021 para 4,12% em 2022 em desktop. Em dispositivos móveis, o uso diminuiu de 5,10% em 2021 para 4,65% em 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=679096832&format=interactive",
  sheets_gid="1737472884",
  sql_file="fugu.sql"
) }}

O uso da Gamepad API diminuiu de 4,39% em 2021 para 4,12% em 2022 em desktop. Em dispositivos móveis, o uso diminuiu de 5,10% em 2021 para 4,65% em 2022. Como resultado, neste ano, a Gamepad API foi a sétima capacidade mais usada em desktop e a sexta mais usada em dispositivos móveis.

Aplicações web como o Google Stadia, o NVIDIA GeForce Now e o Xbox Cloud Gaming da Microsoft fornecem experiências de jogo que rodam na nuvem, comparáveis à experiência de executar jogos em dispositivos locais ou um console de jogos. Graças à Gamepad API, essas aplicações web permitem que os usuários usem controladores de jogo tradicionais em vez de apenas um teclado e mouse.

{{ figure_markup(
  image="Gamepad-API.webp",
  gif="Gamepad-API.gif",
  caption="Conectando um controle Xbox ao Google Stadia no navegador Chrome.",
  description="Conectando um controle Xbox ao Google Stadia no navegador Chrome.",
  width=640,
  height=360
) }}

## Push API

A [_Push API_](https://developer.mozilla.org/pt-BR/docs/Web/API/Push_API) permite que as aplicações web recebam mensagens de um servidor, independentemente de a aplicação estar em primeiro plano. Os desenvolvedores podem enviar notificações e atualizações assíncronas para usuários que optaram por isso, fornecendo atualizações significativas e um estímulo para se envolverem novamente com uma aplicação.

As aplicações web também devem ter um service worker para receber notificações push de um servidor. Dentro do service worker, as notificações push podem ser inscritas usando o método [`PushManager.subscribe()`](https://developer.mozilla.org/docs/Web/API/PushManager/subscribe).

A Push API está disponível em versões modernas do Chrome, Edge e Firefox.

### Uso da Push API

{{ figure_markup(
  caption="Uso da Push API em dispositivos móveis.",
  content="1.86%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

A Push API não foi medida no ano passado. Em seu primeiro ano de rastreamento, a API foi utilizada em 2,03% das páginas desktop e 1,86% das páginas móveis, tornando-se a oitava capacidade mais utilizada em desktop e dispositivos móveis.

## Projeto Fugu

Muitos recursos que os usuários esperam encontrar em aplicativos específicos de plataformas também estão disponíveis na web. No entanto, graças ao Projeto Fugu, conhecido por muitos como Projeto Fugu, esses recursos existem na web. O Projeto Fugu é um esforço conjunto entre várias empresas para trazer paridade de recursos para aplicações web, considerando o que os aplicativos para iOS, Android ou desktop podem fazer. O Projeto Fugu trabalha na exposição de capacidades específicas de plataformas para a web, mantendo a segurança, privacidade, confiança do usuário e outros princípios fundamentais da web.

O Projeto Fugu inclui a participação da Microsoft, Intel, Samsung, Google e muitos outros grupos e indivíduos.

Confira <a hreflang="en" href="https://developer.chrome.com/docs/capabilitiesstatus?hl=pt-br">este post</a> o blog dos desenvolvedores do Chrome para saber mais sobre o Projeto Fugu.

## Conclusão

As capacidades desbloqueiam novas possibilidades e funcionalidades para os desenvolvedores aproveitarem na web. Este capítulo compartilhou oito das APIs de plataforma web mais populares atualmente utilizadas na web. Ele também destacou algumas dessas capacidades utilizadas em diferentes aplicações web. A beleza da web está no fato de que ela pode utilizar essas funcionalidades baseadas em plataformas sem precisar (necessariamente) ser instalada em um dispositivo ou depender de bibliotecas e plugins adicionais.

Algumas experiências empolgantes que utilizam as capacidades da web incluem <a hreflang="en" href="https://whatwebcando.today/">What Web Can Do Today?</a> (WWCDT) e <a hreflang="en" href="https://www.discourse.org/">Discourse</a>. O WWCDT, que utiliza 38 das capacidades que rastreamos, apresenta muitas APIs da web com uma demonstração ao vivo de cada API. O Discourse fornece comunidades com fóruns na web e utiliza 14 das capacidades que rastreamos, como a Badging API, para que os usuários possam ver o número de notificações não lidas que têm.

O Projeto Fugu, também conhecido como Projeto Capabilities, permite que aplicativos migrem para a web, eliminando algumas barreiras associadas a aplicativos específicos de plataformas. Não há necessidade de escrever código "nativo", não é preciso se preocupar com os usuários tendo acesso às últimas atualizações, e não é necessário fazer com que os usuários busquem e baixem seu aplicativo nas lojas de aplicativos. A web, com suas capacidades, abre todas as novas possibilidades na construção de experiências envolventes para os usuários.
