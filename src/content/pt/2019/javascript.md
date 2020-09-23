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

Olhando para esses números, é natural imaginar se isso é muito JavaScript. No entanto, em termos de desempenho da página, o impacto depende inteiramente das conexões de rede e dos dispositivos usados. O que nos leva à nossa próxima pergunta: **quanto JavaScript enviamos quando comparamos clientes móveis e de desktop?**

<figure>
   <a href="/static/images/2019/javascript/fig2.png">
      <img src="/static/images/2019/javascript/fig2.png" alt="Figura 2. Distribuição de JavaScript por página por dispositivo." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1914565673&format=interactive">
   </a>
   <div id="fig2-description" class="visually-hidden">Gráfico de barras mostrando 76 bytes / 65 bytes de JavaScript usados no 10º percentil em computadores e dispositivos móveis, respectivamente, 186/164 bytes para 25º percentil, 391/359 bytes para 50º percentil, 721/668 bytes para 75º percentil, e 1.131 / 1.060 bytes para o 90º percentil.</div>
   <figcaption id="fig2-caption">Figura 2. Distribuição de JavaScript por página por dispositivo.</figcaption>
</figure>

Em cada percentil, estamos enviando um pouco mais de JavaScript para dispositivos de desktop do que para dispositivos móveis.

### Tempo de processamento

Depois de ser analisado e compilado, o JavaScript obtido pelo navegador precisa ser processado (ou executado) antes de ser utilizado. Os dispositivos variam e seu poder de computação pode afetar significativamente a velocidade com que o JavaScript pode ser processado em uma página. **Quais são os tempos de processamento atuais na web?**

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

Uma via que vale a pena explorar ao tentar analisar a quantidade de JavaScript usada por páginas da web é o número de solicitações enviadas. Com [HTTP/2](./http2), enviar vários pedaços menores pode melhorar o carregamento da página em comparação ao envio de um pacote maior e monolítico. Se também dividirmos por cliente do dispositivo, **quantas solicitações estão sendo buscadas?**

<figure>
   <a href="/static/images/2019/javascript/fig5.png">
      <img src="/static/images/2019/javascript/fig5.png" alt="Figura 5. Distribuição do total de solicitações de JavaScript." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1632335480&format=interactive">
   </a>
   <div id="fig5-description" class="visually-hidden">O gráfico de barras mostrando 4/4 solicitações para desktop e celular, respectivamente, são usadas no 10º percentil, 10/9 no 25º percentil, 19/18 no 50º percentil, 33/32 no 75º percentil e 53/52 no 90º percentil.</div>
   <figcaption id="fig5-caption">Figura 5. Distribuição do total de solicitações de JavaScript.</figcaption>
</figure>

Na mediana, 19 solicitações são enviadas para desktop e 18 para celular.

### Conteúdo de origem vs. conteúdo de terceiros

Dos resultados analisados até o momento, foram considerados todo o tamanho e número de solicitações. Na maioria dos sites, no entanto, uma parte significativa do código JavaScript obtido e usado vem de fontes [de terceiros](./third-parties).

JavaScript de conteúdo de terceiros pode vir de qualquer fonte externa de terceiros. Anúncios, ferramentas de análise e conteúdo de mídia social são casos de uso comuns para a obtenção de scripts de terceiros. Então, naturalmente, isso nos leva à nossa próxima pergunta: **Quantas solicitações enviadas são para conteúdo de terceiros em vez de conteúdo de origem?**

<figure>
   <a href="/static/images/2019/javascript/fig6.png">
      <img src="/static/images/2019/javascript/fig6.png" alt="Figura 6. Distribuição de scripts de origem e de terceiros em dispositivos desktop." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1108490&format=interactive">
   </a>
   <div id="fig6-description" class="visually-hidden">O gráfico de barras que mostra a solicitação 0/1 no desktop são primárias e terceiras, respectivamente, no 10º percentil, 2/4 no 25º percentil, 6/10 no 50º percentil, 13/21 no 75º percentil e 24/38 no 90º percentil.</div>
   <figcaption id="fig6-caption">Figura 6. Distribuição de scripts de origem e de terceiros em dispositivos desktop.</figcaption>
</figure>

<figure>
   <a href="/static/images/2019/javascript/fig7.png">
      <img src="/static/images/2019/javascript/fig7.png" alt="Figura 7. Distribuição de scripts de origem e de terceiros em dispositivos móveis." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=998640509&format=interactive">
   </a>
   <div id="fig7-description" class="visually-hidden">O gráfico de barras que mostra 0/1 solicitações em dispositivos móveis é para conteúdo de origem e conteúdo de terceiros, respectivamente, no 10º percentil, 2/3 no 25º percentil, 5/9 no 50º percentil, 13/20 em no 75º percentil e 23/36 no 90º percentil.</div>
   <figcaption id="fig7-caption">Figura 7. Distribuição de scripts de origem e de terceiros em dispositivos móveis.</figcaption>
</figure>

Para clientes móveis e de desktop, mais solicitações são enviadas para conteúdo de terceiros do que conteúdo de origem em cada percentil. Se isso parece surpreendente, vamos descobrir quanto código real enviado vem de fornecedores terceirizados.

<figure>
   <a href="/static/images/2019/javascript/fig8.png">
      <img src="/static/images/2019/javascript/fig8.png" alt="Figura 8. Distribuição do JavaScript total baixado em dispositivos desktop." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=633945705&format=interactive">
   </a>
   <div id="fig8-description" class="visually-hidden">Gráfico de barras mostrando 0/17 bytes de JavaScript sendo baixado para dispositivos desktop para conteúdo de origem e conteúdo de terceiros, respectivamente, no 10º percentil, 11/62 no 25º percentil, 89/232 no 50º percentil, 200/525 no percentil 75 e 404/900 no percentil 90.</div>
   <figcaption id="fig8-caption">Figura 8. Distribuição do JavaScript total baixado em dispositivos desktop.</figcaption>
</figure>

<figure>
   <a href="/static/images/2019/javascript/fig9.png">
      <img src="/static/images/2019/javascript/fig9.png" alt="Figura 9. Distribuição do JavaScript total baixado em dispositivos móveis." aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1611383649&format=interactive">
   </a>
   <div id="fig9-description" class="visually-hidden">Gráfico de barras mostrando 0/17 bytes de JavaScript sendo baixados para dispositivos móveis para conteúdo de origem e conteúdo de terceiros, respectivamente, no 10º percentil, 6/54 no 25º percentil, 83/217 no 50º percentil, 189/477 no 75º percentil e 380/827 no 90º percentil.</div>
   <figcaption id="fig9-caption">Figura 9. Distribuição do JavaScript total baixado em dispositivos móveis.</figcaption>
</figure>

Na média, 89% mais código de conteúdo de terceiros é usado do que código de conteúdo de origem criado pelo desenvolvedor para desktops e dispositivos móveis. Isso mostra claramente que o código de terceiros pode ser um dos maiores contribuintes para a inflação. Para obter mais informações sobre o impacto de terceiros, consulte o capítulo ["Terceiros"](./third-parties).

## Compressão de recursos

No contexto das interações navegador-servidor, a compactação de recursos se refere ao código que foi modificado usando um algoritmo de compactação de dados. Os recursos podem ser compactados estaticamente com antecedência ou em tempo real, conforme solicitado pelo navegador, e para ambas as abordagens o tamanho do recurso transferido é reduzido significativamente, melhorando o desempenho da página.

Existem vários algoritmos de compactação de texto, mas apenas dois são usados ​​principalmente para compactação (e descompressão) de solicitações de rede HTTP:

- [Gzip](https://www.gzip.org/) (gzip): O formato de compactação mais amplamente usado para interações de servidor e cliente.
- [Brotli](https://github.com/google/brotli) (br): Um algoritmo de compressão mais recente que visa melhorar ainda mais as taxas de compressão. [90% dos navegadores](https://caniuse.com/#feat=brotli) eles suportam a codificação Brotli.

Scripts compactados devem sempre ser descompactados pelo navegador depois de transferidos. Isso significa que seu conteúdo permanece o mesmo e os tempos de execução não são otimizados de forma alguma. No entanto, a compactação de recursos sempre melhorará os tempos de download, que também é um dos estágios mais caros do processamento de JavaScript. Garantir que os arquivos JavaScript sejam compactados corretamente pode ser um dos fatores mais importantes para melhorar o desempenho do site.

**Quantos sites estão compactando seus recursos JavaScript?**

<figure>
   <a href="/static/images/2019/javascript/fig10.png">
      <img src="/static/images/2019/javascript/fig10.png" alt="Figura 10. Porcentagem de sites que compactam recursos JavaScript com gzip ou brotli." aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=241928028&format=interactive">
   </a>
   <div id="fig10-description" class="visually-hidden">Gráfico de barras mostrando 67% / 65% dos recursos JavaScript são compactados com gzip em desktops e dispositivos móveis, respectivamente, e 15% / 14% são compactados com Brotli.</div>
   <figcaption id="fig10-caption">Figura 10. Porcentagem de sites que compactam recursos JavaScript com gzip ou brotli.</figcaption>
</figure>

A maioria dos sites está compactando seus recursos JavaScript. A codificação Gzip é usada em ~ 64-67% dos sites e Brotli em cerca de 14%. As taxas de compressão são semelhantes para computadores desktop e dispositivos móveis.

Para uma discussão mais aprofundada sobre compressão, veja o capítulo sobre ["Compressão"](./compression).

## Bibliotecas e estruturas de código aberto

Código-fonte aberto ou código com licença permissiva que qualquer pessoa pode acessar, visualizar e modificar. De pequenas bibliotecas a navegadores completos, como [Chromium](https://www.chromium.org/Home) e [Firefox](https://www.openhub.net/p/firefox), o código-fonte aberto reproduz um papel crucial no mundo do desenvolvimento web. No contexto do JavaScript, os desenvolvedores contam com ferramentas de código aberto para incluir todos os tipos de funcionalidade em suas páginas da web. Independentemente de o desenvolvedor decidir usar uma pequena biblioteca de utilitários ou uma estrutura enorme que dita a arquitetura de todo o seu aplicativo, confiar em pacotes de código aberto pode tornar o desenvolvimento de recursos mais fácil e rápido. **Então, quais bibliotecas de código aberto JavaScript são mais usadas?**

<figure>
   <table>
      <thead>
        <tr>
          <th>Biblioteca</th>
          <th>Área de Trabalho</th>
          <th>Móvel</th>
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
   <figcaption>Figura 11. Principais bibliotecas JavaScript em computadores desktop e dispositivos móveis.</figcaption>
</figure>

[jQuery](https://jquery.com/), a biblioteca JavaScript mais popular já criada, é usada em 85,03% das páginas de desktop e 83,46% das páginas móveis. O advento de muitas APIs e métodos de navegador, como [Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) e [querySelector](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector), eles padronizaram muitas das funcionalidades fornecidas pela biblioteca em um formato nativo. Embora a popularidade do jQuery pareça estar diminuindo, por que ele ainda é usado na grande maioria da web?

Existem vários motivos possíveis:

- [WordPress](https://wordpress.org/), usado por mais de 30% dos sites, inclui jQuery por padrão.
- Mudar de jQuery para uma biblioteca mais recente do lado do cliente pode levar algum tempo, dependendo do tamanho do aplicativo, e muitos sites podem consistir em jQuery e bibliotecas do lado do cliente mais novas.

Outras bibliotecas JavaScript comumente usadas incluem variantes jQuery (jQuery migrate, jQuery UI), [Modernizr](https://modernizr.com/), [Moment.js](https://momentjs.com/), [Underscore.js](https://underscorejs.org/) e assim por diante.

### Frameworks e bibliotecas de UI

<p class="note">Conforme mencionado em nossa <a href="./methodology#wappalyzer">metodologia</a>, a biblioteca de detecção de terceiros usada no HTTP Archive (Wappalyzer) tem uma série de limitações com relação à maneira como detecta certas ferramentas. Há um problema aberto <a href="https://github.com/AliasIO/wappalyzer/issues/2450">para melhorar a detecção de bibliotecas e frameworks JavaScript</a>, que terá impactado os resultados apresentados aqui.</p>

Nos últimos anos, o ecossistema JavaScript tem visto um aumento em bibliotecas e frameworks de código aberto para facilitar a construção de **aplicativos de página única** (SPAs por sua sigla em Inglês). Um aplicativo de página única é caracterizado como uma página da web que carrega uma única página HTML e usa JavaScript para modificar a página na interação do usuário em vez de procurar novas páginas no servidor. Embora essa continue sendo a premissa principal dos aplicativos de página única, diferentes abordagens de renderização de servidor ainda podem ser usadas para aprimorar a experiência de tais sites. **Quantos sites usam este tipo de framework?**

<figure>
   <a href="/static/images/2019/javascript/fig12.png">
      <img src="/static/images/2019/javascript/fig12.png" alt="Figura 12. Os frameworks mais usados ​​no desktop." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1699359221&format=interactive">
   </a>
   <div id="fig12-description" class="visually-hidden">Gráfico de barras mostrando que 4,6% dos sites usam React, 2.0% AngularJS, 1.8% Backbone.js, 0.8% Vue.js, 0.4% Knockout.js, 0.3% Zone.js, 0.3% Angular, 0.1% AMP, 0.1% Ember.js.</div>
   <figcaption id="fig12-caption">Figura 12. Os frameworks mais usados ​​no desktop.</figcaption>
</figure>

Apenas um subconjunto de estruturas populares é discutido aqui, mas é importante observar que todos eles seguem uma das duas abordagens:   

- Arquitetura [modelo-visualização-controlador](https://developer.chrome.com/apps/app_frameworks) (ou model-view-viewmodel)   
- Arquitetura baseada em componentes   

Embora tenha havido uma mudança em direção a um modelo baseado em componentes, muitos frameworks mais antigos que seguem o paradigma MVC ([AngularJS](https://angularjs.org/), [Backbone.js](https://backbonejs.org/), [Ember](https://emberjs.com/)) ainda estão sendo usados em milhares de páginas. Contudo, [React](https://reactjs.org/), [Vue](https://vuejs.org/) e [Angular](https://angular.io/) são frameworks baseadas em componentes mais populares ([Zone.js](https://github.com/angular/zone.js) é um pacote que agora faz parte do núcleo Angular).   

## Carregamento diferencial

[Módulos JavaScript](https://v8.dev/features/modules), ou módulos ES, são suportados em [todos os principais navegadores](https://caniuse.com/#feat=es6-module). Os módulos fornecem a capacidade de criar scripts que você pode importar e exportar de outros módulos. Isso permite que qualquer pessoa crie seus aplicativos projetados em um padrão de módulo, importando e exportando quando necessário, sem depender de carregadores de módulo de terceiros.

Para declarar um script como um módulo, a tag do script deve ter o código `type="module"`:

```html
<script type="module" src="main.mjs"></script>
```

**Quantos sites usam `type="module"` para scripts em suas páginas?**

<figure>
   <a href="/static/images/2019/javascript/fig13.png">
      <img src="/static/images/2019/javascript/fig13.png" alt="Figura 13. Porcentagem de sites usando type=module." aria-labelledby="fig13-caption" aria-describedby="fig13-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1409239029&format=interactive">
   </a>
   <div id="fig13-description" class="visually-hidden">Gráfico de barras mostrando 0,6% dos sites de desktop usam 'type=module', e 0.8% de sites mobile.</div>
   <figcaption id="fig13-caption">Figura 13. Porcentagem de sites usando type=module.</figcaption>
</figure>

O suporte de nível de navegador para módulos ainda é relativamente novo, e os números aqui mostram que muito poucos sites atualmente usam `type="module"` para seus scripts. Muitos sites ainda dependem de carregadores de módulo (2,37% de todos os sites de desktop usam [RequireJS](https://github.com/requirejs/requirejs) por exemplo) e bundlers ([webpack](https://webpack.js.org/)  por exemplo) para definir módulos em seu código-fonte.

Se estiver usando módulos nativos, é importante garantir que um script de backup apropriado seja usado para navegadores que ainda não suportam módulos. Isso pode ser feito incluindo um script adicional com um atributo `nomodule`.

```html
<script nomodule src="fallback.js"></script>
```

Quando usados ​​juntos, os navegadores que suportam módulos irão ignorar completamente qualquer script que contenha o atributo `nomodule`. Por outro lado, navegadores que ainda não suportam módulos não irão baixar nenhum script com `type="module"`. Como eles também não reconhecem `nomodule`, eles normalmente baixam scripts com o atributo. O uso dessa abordagem pode permitir que os desenvolvedores [empurrem código moderno para navegadores modernos para carregamentos de página mais rápidos](https://web.dev/serve-modern-code-to-modern-browsers/). Então, **Quantos sites usam `nomodule` para os scripts em sua página?**

<figure>
   <a href="/static/images/2019/javascript/fig14.png">
      <img src="/static/images/2019/javascript/fig14.png" alt="Figura 14. Porcentagem de sites usando nomodule." aria-labelledby="fig14-caption" aria-describedby="fig14-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=781034243&format=interactive">
   </a>
   <div id="fig14-description" class="visually-hidden">Gráfico de barras mostrando 0,8% dos sites para desktop usam 'nomodule' e 0,5% dos sites para celular.</div>
   <figcaption id="fig14-caption">Figura 14. Porcentagem de sites usando nomodule.</figcaption>
</figure>

Da mesma forma, poucos sites (0,50% - 0,80%) usam o atributo `nomodule` para qualquer script.

## Preload e prefetch

[Preload](https://developer.mozilla.org/en-US/docs/Web/HTML/Preloading_content) e [prefetch](https://developer.mozilla.org/en-US/docs/Web/HTTP/Link_prefetching_FAQ) são [dicas de recursos](./resource-hints) que permitem que você ajude o navegador a determinar quais recursos precisam ser baixados.

- Pré-carregar um recurso com `<link rel="preload">` diz ao navegador para baixar este recurso o mais rápido possível. Isso é especialmente útil para recursos críticos que são descobertos no final do processo de carregamento da página (por exemplo, JavaScript localizado na parte inferior de seu HTML) e, caso contrário, são baixados por último.
- Usar `<link rel="prefetch">` diz ao navegador para tirar vantagem de qualquer tempo ocioso que ele tenha para buscar esses recursos necessários para navegações futuras. 

Então, quantos sites usam diretivas de preload e prefetch?

<figure>
   <a href="/static/images/2019/javascript/fig15.png">
      <img src="/static/images/2019/javascript/fig15.png" alt="Figura 15. Porcentagem de sites usando rel=preload para scripts." aria-labelledby="fig15-caption" aria-describedby="fig15-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=2007534370&format=interactive">
   </a>
   <div id="fig15-description" class="visually-hidden">Gráfico de barras mostrando 14% dos sites para desktop usam 'rel=preload' para scripts e 15% dos sites para celular.</div>
   <figcaption id="fig15-caption">Figura 15. Porcentagem de sites usando rel=preload para scripts.</figcaption>
</figure>

Para todos os sites medidos no arquivo HTTP, 14,33% dos sites de desktop e 14,84% dos sites móveis usam `<link rel="preload">` para scripts em suas páginas.

Para prefetch, temos o seguinte:

<figure>
   <a href="/static/images/2019/javascript/fig16.png">
      <img src="/static/images/2019/javascript/fig16.png" alt="Figura 16. Porcentagem de sites usando rel=prefetch para scripts." aria-labelledby="fig16-caption" aria-describedby="fig16-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=547807937&format=interactive">
   </a>
   <div id="fig16-description" class="visually-hidden">Gráfico de barras mostrando 0,08% dos sites para desktop usam 'rel=prefetch', e 0,08% dos sites para celular.</div>
   <figcaption id="fig16-caption">Figura 16. Porcentagem de sites usando rel=prefetch para scripts.</figcaption>
</figure>

Para dispositivos móveis e desktops, 0,08% das páginas aproveitam a pré-busca para qualquer um de seus scripts.

## Novas APIs

JavaScript continua a evoluir como linguagem. A cada ano uma nova versão do padrão da linguagem, conhecida como ECMAScript, é lançada com novas APIs e recursos que passam pelas etapas da proposta de se tornar parte da própria linguagem.

Com o HTTP Archive, podemos dar uma olhada em qualquer API mais recente que seja suportada (ou prestes a ser) e ver o quão difundida ela está em uso. Essas APIs já podem ser usadas em navegadores que as suportam _ou_ com um polyfill anexado para garantir que ainda funcionem para todos os usuários.

**Quantos sites usam as seguintes APIs?**

- [Atomics](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Atomics)
- [Intl](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl)
- [Proxy](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy)
- [SharedArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer)
- [WeakMap](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap)
- [WeakSet](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakSet)

<figure>
   <a href="/static/images/2019/javascript/fig17.png">
      <img src="/static/images/2019/javascript/fig17.png" alt="Figura 17. Uso de novas APIs JavaScript." aria-labelledby="fig17-caption" aria-describedby="fig17-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=594315296&format=interactive">
   </a>
   <div id="fig17-description" class="visually-hidden">Gráfico de barras mostrando 25,5% / 36,2% dos sites em computadores e dispositivos móveis usam WeakMap, 6,1% / 17,2% usam WeakSet, 3.9%/14.0% usa Intl, 3.9%/4.4% usa Proxy, 0.4%/0.4% usa Atomics, e 0.2%/0.2% usa SharedArrayBuffer.</div>
   <figcaption id="fig17-caption">Figura 17. Uso de novas APIs JavaScript.</figcaption>
</figure>

Atomics (0.38%) e SharedArrayBuffer (0.20%) eles mal são visíveis neste gráfico, pois são usados ​​em tão poucas páginas.

É importante notar que os números aqui são aproximações e não aproveitam [UseCounter](https://chromium.googlesource.com/chromium/src.git/+/master/docs/use_counter_wiki.md) para medir o uso de recursos.

## Mapas de origem

Em muitos sistemas de construção, os arquivos JavaScript são minificados para minimizar seu tamanho e transpilar para recursos de linguagem mais recentes que ainda não são suportados em muitos navegadores. Além disso, os superconjuntos de linguagem como [TypeScript](https://www.typescriptlang.org/) são compilados para uma saída que pode parecer visivelmente diferente do código-fonte original. Por todos esses motivos, o código final fornecido ao navegador pode ser ilegível e difícil de decifrar.

Um **mapas de origem** é um arquivo adicional que acompanha um arquivo JavaScript que permite a um navegador mapear a saída final para sua fonte original. Isso pode tornar a depuração e análise de pacotes configuráveis de produção muito mais simples.

Embora úteis, existem vários motivos pelos quais muitos sites podem não querer incluir mapas de origem em seu site de produção final, como a escolha de não expor o código-fonte completo ao público. Então, quantos sites realmente incluem mapas de origem?

<figure>
   <a href="/static/images/2019/javascript/fig18.png">
      <img src="/static/images/2019/javascript/fig18.png" alt="Figura 18. Porcentagem de sites usando mapas de origem." aria-labelledby="fig18-caption" aria-describedby="fig18-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=906754154&format=interactive">
   </a>
   <div id="fig18-description" class="visually-hidden">Gráfico de barras mostrando 18% dos sites para desktop e 17% dos sites para celular usam mapas de origem.</div>
   <figcaption id="fig18-caption">Figura 18. Porcentagem de sites usando mapas de origem.</figcaption>
</figure>

Para páginas de desktop e móveis, os resultados são quase os mesmos. 17-18% incluem um mapa de origem para pelo menos um script na página (detectado como um script primário com `sourceMappingURL`).

## Conclusão

O ecossistema JavaScript continua mudando e evoluindo a cada ano. APIs mais recentes, motores de navegador aprimorados e bibliotecas e estruturas novas são coisas que podemos esperar que aconteçam indefinidamente. O HTTP Archive nos fornece informações valiosas sobre como os sites locais usam a linguagem.

Sem o JavaScript, a web não estaria onde está hoje, e todos os dados coletados para este artigo apenas provam isso.
