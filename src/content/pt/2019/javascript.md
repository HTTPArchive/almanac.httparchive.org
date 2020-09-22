---
part_number: I
chapter_number: 1
title: JavaScript
description: Capítulo de JavaScript de 2019 Web Almanac que cobre quanto JavaScript usamos na web, compressão, bibliotecas e estruturas, carregamento e mapas de origem.
authors: [housseindjirdeh]
reviewers: [obto, paulcalvano, mathiasbynens]
translators: [HakaCode]
discuss: 1756
results: https://docs.google.com/spreadsheets/d/1kBTglETN_V9UjKqK_EFmFjRexJnQOmLLr-I2Tkotvic/
queries: 01_JavaScript
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-09-01T00:00:00.000Z
---

## Introdução

JavaScript é uma linguagem de script que torna possível construir experiências interativas e complexas na web. Isso inclui responder às interações do usuário, atualizar o conteúdo dinâmico em uma página e assim por diante. Qualquer coisa que envolva como uma página da web deve se comportar quando ocorre um evento é para o que o JavaScript é usado.

A especificação da linguagem em si, junto com muitas bibliotecas e estruturas construídas pela comunidade usadas por desenvolvedores em todo o mundo, mudou e evoluiu desde que a linguagem foi criada em 1995. As implementações e os interpretadores de JavaScript também continuaram a progredir, tornando a linguagem utilizável em muitos ambientes, não apenas navegadores.

O [HTTP Archive](https://httparchive.org/) rastreia [milhões de páginas](https://httparchive.org/reports/state-of-the-web#numUrls) todos os meses e os executa por meio de uma instância privada de [WebPageTest](https://webpagetest.org/) para armazenar informações importantes de cada página. (Você pode aprender mais sobre isso em nossa [metodologia](./methodology)). No contexto do JavaScript, o HTTP Archive fornece informações abrangentes sobre o uso da linguagem em toda a web. Este capítulo consolida e analisa muitas dessas tendências.

## Quanto JavaScript usamos?

JavaScript é o recurso mais caro que enviamos aos navegadores; tendo que ser baixado, analisado, compilado e finalmente executado. Embora os navegadores tenham diminuído significativamente o tempo que leva para analisar e compilar scripts, [download e execução se tornaram as etapas mais caras](https://v8.dev/blog/cost-of-javascript-2019) quando o JavaScript é processado por uma página da web.

O envio de pacotes menores de JavaScript para o navegador é a melhor maneira de reduzir o tempo de download e, por sua vez, melhorar o desempenho da página. Mas quanto JavaScript realmente usamos?

<figure>
   <a href="/static/images/2019/javascript/fig1.png">
      <img src="/static/images/2019/javascript/fig1.png" alt="Figura 1. Distribuição de bytes de JavaScript por página." aria-labelledby="fig1-caption" aria-describedby="fig1-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1974602890&format=interactive">
   </a>
   <div id="fig1-description" class="visually-hidden">Gráfico de barras mostrando 70 bytes de JavaScript usados no 10º percentil, 174 bytes no 25º percentil, 373 bytes no 50º percentil, 693 bytes no 75º percentil, e 1.093 bytes no 90º percentil</div>
   <figcaption id="fig1-caption">Figura 1. Distribuição de bytes de JavaScript por página.</figcaption>
</figure>

A Figura 1 acima mostra que usamos 373 KB de JavaScript no 50º percentil, ou mediana. Em outras palavras, 50% de todos os sites fornecem mais do que essa quantidade de JavaScript para seus usuários.

Olhando para esses números, é natural imaginar se isso é muito JavaScript. No entanto, em termos de desempenho da página, o impacto depende inteiramente das conexões de rede e dos dispositivos usados. O que nos leva à nossa próxima pergunta: quanto JavaScript enviamos quando comparamos clientes móveis e de desktop?

<figure>
   <a href="/static/images/2019/javascript/fig2.png">
      <img src="/static/images/2019/javascript/fig2.png" alt="Figura 2. Distribuição de JavaScript por página por dispositivo." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1914565673&format=interactive">
   </a>
   <div id="fig2-description" class="visually-hidden">Gráfico de barras mostrando 76 bytes / 65 bytes de JavaScript usados no 10º percentil em computadores e dispositivos móveis, respectivamente, 186/164 bytes para 25º percentil, 391/359 bytes para 50º percentil, 721/668 bytes para 75º percentil, e 1.131 / 1.060 bytes para o 90º percentil.</div>
   <figcaption id="fig2-caption">Figura 2. Distribuição de JavaScript por página por dispositivo.</figcaption>
</figure>

Em cada percentil, estamos enviando um pouco mais de JavaScript para dispositivos de desktop do que para dispositivos móveis.

### Tempo de processamento

Depois de ser analisado e compilado, o JavaScript obtido pelo navegador precisa ser processado (ou executado) antes de ser utilizado. Os dispositivos variam e seu poder de computação pode afetar significativamente a velocidade com que o JavaScript pode ser processado em uma página. Quais são os tempos de processamento atuais na web?

Podemos ter uma ideia analisando os tempos de processamento do thread principal para V8 em diferentes percentis:

<figure>
   <a href="/static/images/2019/javascript/fig3.png">
      <img src="/static/images/2019/javascript/fig3.png" alt="Figura 3. Tempos de processamento do thread principal V8 por dispositivo." aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=924000517&format=interactive">
   </a>
   <div id="fig3-description" class="visually-hidden">O gráfico de barras mostrando 141 ms / 377 ms de tempo de processamento é usado no 10º percentil em computadores e dispositivos móveis, respectivamente, 352/988 ms para 25º percentil, 849 / 2.437 ms para 50º percentil, 1.850 / 5.518 ms para 75º percentil e 3.543 / 10.735 ms para o percentil 90.</div>
   <figcaption id="fig3-caption">Figura 3. Tempos de processamento do thread principal V8 por dispositivo.</figcaption>
</figure>

A cada percentil, os tempos de processamento são mais longos para páginas da web para celular do que para desktop. A mediana do tempo total do thread principal no desktop é de 849 ms, enquanto no celular está em um número maior: 2.437 ms.

Embora esses dados mostrem quanto tempo pode levar para um dispositivo móvel processar JavaScript em comparação com uma máquina de desktop mais poderosa, os dispositivos móveis também variam em termos de capacidade de computação. O gráfico a seguir mostra como os tempos de processamento em uma única página da web podem variar significativamente dependendo da classe do dispositivo móvel.

<figure>
   <a href="/static/images/2019/javascript/js-processing-reddit.png">
      <img src="/static/images/2019/javascript/js-processing-reddit.png" alt="Tempos de processamento de JavaScript para Reddit.com" aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="363">
   </a>
   <div id="fig4-description" class="visually-hidden">Gráfico de barras mostrando 3 dispositivos diferentes: no topo, um Pixel 3 tem uma pequena quantidade no thread principal e no thread de trabalho de menos de 400ms. Para um Moto G4, é aproximadamente 900 ms no thread principal e mais 300 ms no thread de trabalho. E a barra final é um Alcatel 1X 5059D com mais de 2.000 ms no thread principal e mais de 500 ms no thread de trabalho.</div>
   <figcaption id="fig4-caption">Figura 4. Tempos de processamento de JavaScript para reddit.com. De <a href="https://v8.dev/blog/cost-of-javascript-2019">O custo do JavaScript em 2019</a>.</figcaption>
</figure>

### Número de pedidos

Uma via que vale a pena explorar ao tentar analisar a quantidade de JavaScript usada por páginas da web é o número de solicitações enviadas. Com [HTTP/2](./http2), enviar vários pedaços menores pode melhorar o carregamento da página em comparação ao envio de um pacote maior e monolítico. Se também dividirmos por cliente do dispositivo, quantas solicitações estão sendo buscadas?

<figure>
   <a href="/static/images/2019/javascript/fig5.png">
      <img src="/static/images/2019/javascript/fig5.png" alt="Figura 5. Distribuição do total de solicitações de JavaScript." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1632335480&format=interactive">
   </a>
   <div id="fig5-description" class="visually-hidden">O gráfico de barras mostrando 4/4 solicitações para desktop e celular, respectivamente, são usadas no 10º percentil, 10/9 no 25º percentil, 19/18 no 50º percentil, 33/32 no 75º percentil e 53/52 no 90º percentil.</div>
   <figcaption id="fig5-caption">Figura 5. Distribuição do total de solicitações de JavaScript.</figcaption>
</figure>

Na mediana, 19 solicitações são enviadas para desktop e 18 para celular.

### First-party vs. third-party

Of the results analyzed so far, the entire size and number of requests were being considered. In a majority of websites however, a significant portion of the JavaScript code fetched and used comes from [third-party](./third-parties) sources.

Third-party JavaScript can come from any external, third-party source. Ads, analytics and social media embeds are all common use-cases for fetching third-party scripts. So naturally, this brings us to our next question: how many requests sent are third-party instead of first-party?

<figure>
   <a href="/static/images/2019/javascript/fig6.png">
      <img src="/static/images/2019/javascript/fig6.png" alt="Figure 6. Distribution of first and third-party scripts on desktop." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1108490&format=interactive">
   </a>
   <div id="fig6-description" class="visually-hidden">Bar chart showing 0/1 request on desktop are first-party and third-party respectively in 10th percentile, 2/4 in 25th percentile, 6/10 in 50th percentile, 13/21 in 75th percentile, and 24/38 in 90th percentile.</div>
   <figcaption id="fig6-caption">Figure 6. Distribution of first and third-party scripts on desktop.</figcaption>
</figure>

<figure>
   <a href="/static/images/2019/javascript/fig7.png">
      <img src="/static/images/2019/javascript/fig7.png" alt="Figure 7. Distribution of first and third party scripts on mobile." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=998640509&format=interactive">
   </a>
   <div id="fig7-description" class="visually-hidden">Bar chart showing 0/1 request on mobile are first-party and third-party respectively in 10th percentile, 2/3 in 25th percentile, 5/9 in 50th percentile, 13/20 in 75th percentile, and 23/36 in 90th percentile.</div>
   <figcaption id="fig7-caption">Figure 7. Distribution of first and third party scripts on mobile.</figcaption>
</figure>

For both mobile and desktop clients, more third-party requests are sent than first-party at every percentile. If this seems surprising, let's find out how much actual code shipped comes from third-party vendors.

<figure>
   <a href="/static/images/2019/javascript/fig8.png">
      <img src="/static/images/2019/javascript/fig8.png" alt="Figure 8. Distribution of total JavaScript downloaded on desktop." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=633945705&format=interactive">
   </a>
   <div id="fig8-description" class="visually-hidden">Bar chart showing 0/17 bytes of JavaScript are downloaded on desktop for first-party and third-party requests respectively in the 10th percentile, 11/62 in 25th percentile, 89/232 in 50th percentile, 200/525 in 75th percentile, and 404/900 in 90th percentile.</div>
   <figcaption id="fig8-caption">Figure 8. Distribution of total JavaScript downloaded on desktop.</figcaption>
</figure>

<figure>
   <a href="/static/images/2019/javascript/fig9.png">
      <img src="/static/images/2019/javascript/fig9.png" alt="Figure 9. Distribution of total JavaScript downloaded on mobile." aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1611383649&format=interactive">
   </a>
   <div id="fig9-description" class="visually-hidden">Bar chart showing 0/17 bytes of JavaScript are downloaded on mobile for first-party and third-party requests respectively in the 10th percentile, 6/54 in 25th percentile, 83/217 in 50th percentile, 189/477 in 75th percentile, and 380/827 in 90th percentile.</div>
   <figcaption id="fig9-caption">Figure 9. Distribution of total JavaScript downloaded on mobile.</figcaption>
</figure>

At the median, 89% more third-party code is used than first-party code authored by the developer for both mobile and desktop. This clearly shows that third-party code can be one of the biggest contributors to bloat. For more information on the impact of third parties, refer to the ["Third Parties"](./third-parties) chapter.

## Resource compression

In the context of browser-server interactions, resource compression refers to code that has been modified using a data compression algorithm. Resources can be compressed statically ahead of time or on-the-fly as they are requested by the browser, and for either approach the transferred resource size is significantly reduced which improves page performance.

There are multiple text-compression algorithms, but only two are mostly used for the compression (and decompression) of HTTP network requests:

- [Gzip](https://www.gzip.org/) (gzip): The most widely used compression format for server and client interactions
- [Brotli](https://github.com/google/brotli) (br): A newer compression algorithm aiming to further improve compression ratios. [90% of browsers](https://caniuse.com/#feat=brotli) support Brotli encoding.

Compressed scripts will always need to be uncompressed by the browser once transferred. This means its content remains the same and execution times are not optimized whatsoever. Resource compression, however, will always improve download times which also is one of the most expensive stages of JavaScript processing. Ensuring JavaScript files are compressed correctly can be one of the most significant factors in improving site performance.

How many sites are compressing their JavaScript resources?

<figure>
   <a href="/static/images/2019/javascript/fig10.png">
      <img src="/static/images/2019/javascript/fig10.png" alt="Figure 10. Percentage of sites compressing JavaScript resources with gzip or brotli." aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=241928028&format=interactive">
   </a>
   <div id="fig10-description" class="visually-hidden">Bar chart showing 67%/65% of JavaScript resources are compressed with gzip on desktop and mobile respectively, and 15%/14% are compressed using Brotli.</div>
   <figcaption id="fig10-caption">Figure 10. Percentage of sites compressing JavaScript resources with gzip or brotli.</figcaption>
</figure>

The majority of sites are compressing their JavaScript resources. Gzip encoding is used on ~64-67% of sites and Brotli on ~14%. Compression ratios are similar for both desktop and mobile.

For a deeper analysis on compression, refer to the ["Compression"](./compression) chapter.

## Open source libraries and frameworks

Open source code, or code with a permissive license that can be accessed, viewed and modified by anyone. From tiny libraries to entire browsers, such as [Chromium](https://www.chromium.org/Home) and [Firefox](https://www.openhub.net/p/firefox), open source code plays a crucial role in the world of web development. In the context of JavaScript, developers rely on open source tooling to include all types of functionality into their web page. Regardless of whether a developer decides to use a small utility library or a massive framework that dictates the architecture of their entire application, relying on open-source packages can make feature development easier and faster. So which JavaScript open-source libraries are used the most?

<figure>
   <table>
      <thead>
        <tr>
          <th>Library</th>
          <th>Desktop</th>
          <th>Mobile</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>jQuery</td>
          <td class="numeric">85.03%</td>
          <td class="numeric">83.46%</td>
        </tr>
        <tr>
          <td>jQuery Migrate</td>
          <td class="numeric">31.26%</td>
          <td class="numeric">31.68%</td>
        </tr>
        <tr>
          <td>jQuery UI</td>
          <td class="numeric">23.60%</td>
          <td class="numeric">21.75%</td>
        </tr>
        <tr>
          <td>Modernizr</td>
          <td class="numeric">17.80%</td>
          <td class="numeric">16.76%</td>
        </tr>
        <tr>
          <td>FancyBox</td>
          <td class="numeric">7.04%</td>
          <td class="numeric">6.61%</td>
        </tr>
        <tr>
          <td>Lightbox</td>
          <td class="numeric">6.02%</td>
          <td class="numeric">5.93%</td>
        </tr>
        <tr>
          <td>Slick</td>
          <td class="numeric">5.53%</td>
          <td class="numeric">5.24%</td>
        </tr>
        <tr>
          <td>Moment.js</td>
          <td class="numeric">4.92%</td>
          <td class="numeric">4.29%</td>
        </tr>
        <tr>
          <td>Underscore.js</td>
          <td class="numeric">4.20%</td>
          <td class="numeric">3.82%</td>
        </tr>
        <tr>
          <td>prettyPhoto</td>
          <td class="numeric">2.89%</td>
          <td class="numeric">3.09%</td>
        </tr>
        <tr>
          <td>Select2</td>
          <td class="numeric">2.78%</td>
          <td class="numeric">2.48%</td>
        </tr>
        <tr>
          <td>Lodash</td>
          <td class="numeric">2.65%</td>
          <td class="numeric">2.68%</td>
        </tr>
        <tr>
          <td>Hammer.js</td>
          <td class="numeric">2.28%</td>
          <td class="numeric">2.70%</td>
        </tr>
        <tr>
          <td>YUI</td>
          <td class="numeric">1.84%</td>
          <td class="numeric">1.50%</td>
        </tr>
        <tr>
          <td>Lazy.js</td>
          <td class="numeric">1.26%</td>
          <td class="numeric">1.56%</td>
        </tr>
        <tr>
          <td>Fingerprintjs</td>
          <td class="numeric">1.21%</td>
          <td class="numeric">1.32%</td>
        </tr>
        <tr>
          <td>script.aculo.us</td>
          <td class="numeric">0.98%</td>
          <td class="numeric">0.85%</td>
        </tr>
        <tr>
          <td>Polyfill</td>
          <td class="numeric">0.97%</td>
          <td class="numeric">1.00%</td>
        </tr>
        <tr>
          <td>Flickity</td>
          <td class="numeric">0.83%</td>
          <td class="numeric">0.92%</td>
        </tr>
        <tr>
          <td>Zepto</td>
          <td class="numeric">0.78%</td>
          <td class="numeric">1.17%</td>
        </tr>
        <tr>
          <td>Dojo</td>
          <td class="numeric">0.70%</td>
          <td class="numeric">0.62%</td>
        </tr>
      </tbody>
    </table>
   <figcaption>Figure 11. Top JavaScript libraries on desktop and mobile.</figcaption>
</figure>

[jQuery](https://jquery.com/), the most popular JavaScript library ever created, is used in 85.03% of desktop pages and 83.46% of mobile pages. The advent of many Browser APIs and methods, such as [Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) and [querySelector](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector), standardized much of the functionality provided by the library into a native form. Although the popularity of jQuery may seem to be declining, why is it still used in the vast majority of the web?

There are a number of possible reasons:

- [WordPress](https://wordpress.org/), which is used in more than 30% of sites, includes jQuery by default.
- Switching from jQuery to a newer client-side library can take time depending on how large an application is, and many sites may consist of jQuery in addition to newer client-side libraries.

Other top used JavaScript libraries include jQuery variants (jQuery migrate, jQuery UI), [Modernizr](https://modernizr.com/), [Moment.js](https://momentjs.com/), [Underscore.js](https://underscorejs.org/) and so on.

### Frameworks and UI libraries

<p class="note">As mentioned in our <a href="./methodology#wappalyzer">methodology</a>, the third-party detection library used in HTTP Archive (Wappalyzer) has a number of limitations with regards to how it detects certain tools. There is an open issue <a href="https://github.com/AliasIO/wappalyzer/issues/2450">to improve detection of JavaScript libraries and frameworks</a>, which will have impacted the results presented here.</p>

In the past number of years, the JavaScript ecosystem has seen a rise in open-source libraries and frameworks to make building **single-page applications** (SPAs) easier. A single-page application is characterized as a web page that loads a single HTML page and uses JavaScript to modify the page on user interaction instead of fetching new pages from the server. Although this remains to be the main premise of single-page applications, different server-rendering approaches can still be used to improve the experience of such sites. How many sites use these types of frameworks?

<figure>
   <a href="/static/images/2019/javascript/fig12.png">
      <img src="/static/images/2019/javascript/fig12.png" alt="Figure 12. Most frequently used frameworks on desktop." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1699359221&format=interactive">
   </a>
   <div id="fig12-description" class="visually-hidden">Bar chart showing 4.6% of sites use React, 2.0% AngularJS, 1.8% Backbone.js, 0.8% Vue.js, 0.4% Knockout.js, 0.3% Zone.js, 0.3% Angular, 0.1% AMP, 0.1% Ember.js.</div>
   <figcaption id="fig12-caption">Figure 12. Most frequently used frameworks on desktop.</figcaption>
</figure>

Only a subset of popular frameworks are being analyzed here, but it's important to note that all of them either follow one of these two approaches:   

- A [model-view-controller](https://developer.chrome.com/apps/app_frameworks) (or model-view-viewmodel) architecture   
- A component-based architecture   

Although there has been a shift towards a component-based model, many older frameworks that follow the MVC paradigm ([AngularJS](https://angularjs.org/), [Backbone.js](https://backbonejs.org/), [Ember](https://emberjs.com/)) are still being used in thousands of pages. However, [React](https://reactjs.org/), [Vue](https://vuejs.org/) and [Angular](https://angular.io/) are the most popular component-based frameworks ([Zone.js](https://github.com/angular/zone.js) is a package that is now part of Angular core).   

## Differential loading

[JavaScript modules](https://v8.dev/features/modules), or ES modules, are supported in [all major browsers](https://caniuse.com/#feat=es6-module). Modules provide the capability to create scripts that can import and export from other modules. This allows anyone to build their applications architected in a module pattern, importing and exporting wherever necessary, without relying on third-party module loaders.

To declare a script as a module, the script tag must get the `type="module"` attribute:

```html
<script type="module" src="main.mjs"></script>
```

How many sites use `type="module"` for scripts on their page?

<figure>
   <a href="/static/images/2019/javascript/fig13.png">
      <img src="/static/images/2019/javascript/fig13.png" alt="Figure 13. Percentage of sites utilizing type=module." aria-labelledby="fig13-caption" aria-describedby="fig13-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1409239029&format=interactive">
   </a>
   <div id="fig13-description" class="visually-hidden">Bar chart showing 0.6% of sites on desktop use 'type=module', and 0.8% of sites on mobile.</div>
   <figcaption id="fig13-caption">Figure 13. Percentage of sites utilizing type=module.</figcaption>
</figure>

Browser-level support for modules is still relatively new, and the numbers here show that very few sites currently use `type="module"` for their scripts. Many sites are still relying on module loaders (2.37% of all desktop sites use [RequireJS](https://github.com/requirejs/requirejs) for example) and bundlers ([webpack](https://webpack.js.org/) for example) to define modules within their codebase.

If native modules are used, it's important to ensure that an appropriate fallback script is used for browsers that do not yet support modules. This can be done by including an additional script with a `nomodule` attribute.

```html
<script nomodule src="fallback.js"></script>
```

When used together, browsers that support modules will completely ignore any scripts containing the `nomodule` attribute. On the other hand, browsers that do not yet support modules will not download any scripts with `type="module"`. Since they do not recognize `nomodule` either, they will download scripts with the attribute normally. Using this approach can allow developers to [send modern code to modern browsers for faster page loads](https://web.dev/serve-modern-code-to-modern-browsers/). So, how many sites use `nomodule` for scripts on their page?

<figure>
   <a href="/static/images/2019/javascript/fig14.png">
      <img src="/static/images/2019/javascript/fig14.png" alt="Figure 14. Percentage of sites using nomodule." aria-labelledby="fig14-caption" aria-describedby="fig14-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=781034243&format=interactive">
   </a>
   <div id="fig14-description" class="visually-hidden">Bar chart showing 0.8% of sites on desktop use 'nomobule', and 0.5% of sites on mobile.</div>
   <figcaption id="fig14-caption">Figure 14. Percentage of sites using nomodule.</figcaption>
</figure>

Similarly, very few sites (0.50%-0.80%) use the `nomodule` attribute for any scripts.

## Preload and prefetch

[Preload](https://developer.mozilla.org/en-US/docs/Web/HTML/Preloading_content) and [prefetch](https://developer.mozilla.org/en-US/docs/Web/HTTP/Link_prefetching_FAQ) are [resource hints](./resource-hints) which enable you to aid the browser in determining what resources need to be downloaded.

- Preloading a resource with `<link rel="preload">` tells the browser to download this resource as soon as possible. This is especially helpful for critical resources which are discovered late in the page loading process (e.g., JavaScript located at the bottom of your HTML) and are otherwise downloaded last.
- Using `<link rel="prefetch">` tells the browser to take advantage of any idle time it has to fetch these resources needed for future navigations 

So, how many sites use preload and prefetch directives?

<figure>
   <a href="/static/images/2019/javascript/fig15.png">
      <img src="/static/images/2019/javascript/fig15.png" alt="Figure 15. Percentage of sites using rel=preload for scripts." aria-labelledby="fig15-caption" aria-describedby="fig15-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=2007534370&format=interactive">
   </a>
   <div id="fig15-description" class="visually-hidden">Bar chart showing 14% of sites on desktop use rel=preload' for scripts, and 15% of sites on mobile.</div>
   <figcaption id="fig15-caption">Figure 15. Percentage of sites using rel=preload for scripts.</figcaption>
</figure>

For all sites measured in HTTP Archive, 14.33% of desktop sites and 14.84% of mobile sites use `<link rel="preload">` for scripts on their page.

For prefetch, we have the following:

<figure>
   <a href="/static/images/2019/javascript/fig16.png">
      <img src="/static/images/2019/javascript/fig16.png" alt="Figure 16. Percentage of sites using rel=prefetch for scripts." aria-labelledby="fig16-caption" aria-describedby="fig16-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=547807937&format=interactive">
   </a>
   <div id="fig16-description" class="visually-hidden">Bar chart showing 0.08% of sites on desktop use 'rel=prefetch', and 0.08% of sites on mobile.</div>
   <figcaption id="fig16-caption">Figure 16. Percentage of sites using rel=prefetch for scripts.</figcaption>
</figure>

For both mobile and desktop, 0.08% of pages leverage prefetch for any of their scripts.

## Newer APIs

JavaScript continues to evolve as a language. A new version of the language standard itself, known as ECMAScript, is released every year with new APIs and features passing proposal stages to become a part of the language itself.

With HTTP Archive, we can take a look at any newer API that is supported (or is about to be) and see how widespread its usage is. These APIs may already be used in browsers that support them _or_ with an accompanying polyfill to make sure they still work for every user.

How many sites use the following APIs?

- [Atomics](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Atomics)
- [Intl](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl)
- [Proxy](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy)
- [SharedArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer)
- [WeakMap](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap)
- [WeakSet](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakSet)

<figure>
   <a href="/static/images/2019/javascript/fig17.png">
      <img src="/static/images/2019/javascript/fig17.png" alt="Figure 17. Usage of new JavaScript APIs." aria-labelledby="fig17-caption" aria-describedby="fig17-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=594315296&format=interactive">
   </a>
   <div id="fig17-description" class="visually-hidden">Bar chart showing 25.5%/36.2% of sites on desktop and mobile respectivdely use WeakMap, 6.1%/17.2% use WeakSet, 3.9%/14.0% use Intl, 3.9%/4.4% use Proxy, 0.4%/0.4% use Atomics, and 0.2%/0.2% use SharedArrayBuffer.</div>
   <figcaption id="fig17-caption">Figure 17. Usage of new JavaScript APIs.</figcaption>
</figure>

Atomics (0.38%) and SharedArrayBuffer (0.20%) are barely visible on this chart since they are used on such few pages.

It is important to note that the numbers here are approximations and they do not leverage [UseCounter](https://chromium.googlesource.com/chromium/src.git/+/master/docs/use_counter_wiki.md) to measure feature usage.

## Source maps

In many build systems, JavaScript files undergo minification to minimize its size and transpilation for newer language features that are not yet supported in many browsers. Moreover, language supersets like [TypeScript](https://www.typescriptlang.org/) compile to an output that can look noticeably different from the original source code. For all these reasons, the final code served to the browser can be unreadable and hard to decipher.

A **source map** is an additional file accompanying a JavaScript file that allows a browser to map the final output to its original source. This can make debugging and analyzing production bundles much simpler.

Although useful, there are a number of reasons why many sites may not want to include source maps in their final production site, such as choosing not to expose complete source code to the public. So how many sites actually include sourcemaps?

<figure>
   <a href="/static/images/2019/javascript/fig18.png">
      <img src="/static/images/2019/javascript/fig18.png" alt="Figure 18. Percentage of sites using source maps." aria-labelledby="fig18-caption" aria-describedby="fig18-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=906754154&format=interactive">
   </a>
   <div id="fig18-description" class="visually-hidden">Bar chart showing 18% of desktop sites and 17% of mobile sites use source maps.</div>
   <figcaption id="fig18-caption">Figure 18. Percentage of sites using source maps.</figcaption>
</figure>

For both desktop and mobile pages, the results are about the same. 17-18% include a source map for at least one script on the page (detected as a first-party script with `sourceMappingURL`).

## Conclusão

O ecossistema JavaScript continua mudando e evoluindo a cada ano. APIs mais recentes, motores de navegador aprimorados e bibliotecas e estruturas novas são coisas que podemos esperar que aconteçam indefinidamente. O HTTP Archive nos fornece informações valiosas sobre como os sites locais usam a linguagem.

Sem o JavaScript, a web não estaria onde está hoje, e todos os dados coletados para este artigo apenas provam isso.
