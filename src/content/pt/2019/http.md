---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP/2
description: Capítulo de HTTP/2 de 2019 do Web Almanac que cobre a adoção e o impacto do HTTP/2, HTTP/2 Push, Problemas do HTTP/2 e HTTP/3.
hero_alt: Hero image of Web Almanac chracters driving vehicles in various lanes carrying script and images resources.
authors: [tunetheweb]
reviewers: [bagder, rmarx, dotjs]
analysts: [paulcalvano]
editors: [rachellcostello]
translators: [elaynelemos]
discuss: 1775
results: https://docs.google.com/spreadsheets/d/1z1gdS3YVpe8J9K3g2UdrtdSPhRywVQRBz5kgBeqCnbw/
tunetheweb_bio: Barry Pollard é um desenvolvedor de software e autor do livro Manning <a hreflang="en" href="https://www.manning.com/books/http2-in-action"><i lang="en">HTTP/2 in Action</i></a>. Ele acha a web incrível, mas quer torná-la ainda melhor. Você pode encontrá-lo twittar <a href="https://x.com/tunetheweb">@tunetheweb</a> e bloga em <a hreflang="en" href="https://www.tunetheweb.com">www.tunetheweb.com</a>.
featured_quote: O HTTP/2 foi a primeira grande atualização do principal protocolo de transporte da web em quase 20 anos. Ele chegou com muitas expectativas&colon; prometia um aumento de desempenho gratuito e sem desvantagens. Mais do que isso, poderíamos deixar de lado todos as adaptações e saídas mirabolantes a que o HTTP/1.1 nos forçava, devido às suas ineficiências. Técnicas como bundling, spriting, inlining e até mesmo sharding se tornariam não canônicas em um mundo com HTTP/2, visto que a performance otimizada já seria fornecida por padrão. Este capítulo examina como essa tecnologia relativamente nova se saiu no mundo real.
featured_stat_1: 95%
featured_stat_label_1: Usuários que podem usar HTTP/2
featured_stat_2: 27.83%
featured_stat_label_2: Requisições com problemas de priorização no HTTP/2
featured_stat_3: 8.38%
featured_stat_label_3: Sites que suportam QUIC
---

## Introdução
O HTTP/2 foi a primeira grande atualização do principal protocolo de transporte da web em quase 20 anos. Ele chegou com muitas expectativas: prometia um aumento de desempenho gratuito e sem desvantagens. Mais do que isso, poderíamos deixar de lado todos as adaptações e saídas mirabolantes a que o HTTP/1.1 nos forçava, devido às suas ineficiências. Técnicas como bundling, spriting, inlining e até mesmo sharding se tornariam não canônicas em um mundo com HTTP/2, visto que a performance otimizada já seria fornecida por padrão.

Isso significava que mesmo aqueles sem as habilidades e os recursos para se concentrar na [performance na web](./performance) de repente teriam sites com bom desempenho. Contudo, a realidade foi, como sempre, um pouco mais sutil do que isso. Já se passaram mais de quatro anos desde a aprovação formal do HTTP/2 como um padrão em maio de 2015 como <a hreflang="en" href="https://tools.ietf.org/html/rfc7540">RFC 7540</a>, assim agora é um bom momento para verificar como essa tecnologia relativamente nova se saiu no mundo real.

## O que é HTTP/2?
Para aqueles que não estão familiarizados com a tecnologia, um pouco de experiência é útil para aproveitar ao máximo as métricas e descobertas neste capítulo. Até recentemente, o HTTP sempre foi um protocolo baseado em texto. Um cliente HTTP como um navegador web abria uma conexão TCP com um servidor, e então enviava um comando como `GET /index.html` para solicitar um recurso.

Isso foi aprimorado no HTTP/1.0 ao adicionar *HTTP headers* (cabeçalhos HTTP), asim várias partes de metadados poderiam ser incluídas além da requisição, como qual é o navegador, que formatos entende, etc. Esses cabeçalhos também eram baseados em texto e e separados por caracteres de nova linha. Os servidores analisavam as requisições recebidas, lendo a requisição e quaisquer cabeçalhos linha por linha, e em seguida respondiam com seus próprios cabeçalhos HTTP de resposta junto ao recurso de fato sendo solicitado.

O protocolo parecia simples, mas também apresentava limitações. Como o HTTP era essencialmente síncrono, uma vez que uma requisição HTTP era feita, toda a conexão TCP ficava basicamente fora do alcance de qualquer outra coisa até que a resposta fosse retornada, lida e processada. Isso era incrivelmente ineficiente e exigia múltiplas conexões TCP (os navegadores normalmente usam 6) para permitir uma forma limitada de paralelização.

Isso por si só já trás seus próprios problemas considerando que as conexões TCP demandam tempo e recursos para serem estabelecidas e obter eficiência total, especialmente ao usar HTTPS, que requer etapas adicionais para configurar a criptografia. O HTTP/1.1 melhorou isso em alguma medida, permitindo a reutilização de conexões TCP para requisições subsequentes, mas ainda não resolveu a dificuldade em paralelização.

Apesar do HTTP ser baseado em texto, a realidade é que ele raramente era usado para transportar texto, ao menos em seu formato puro. Embora fosse verdade que os cabeçalhos ainda eram texto, os payloads em si frequentemente não eram. Arquivos de texto como [HTML](./markup), [JS](./javascript) e [CSS](./css) costumam ser [compactados](./compression) para transporte em formato binário usando Gzip, Brotli ou similar. Arquivos não textuais como [imagens e vídeos](./media) são distribuidos em seus próprio formatos. A mensagem HTTP completa é então costumeiramente encapsulada em HTTPS para criptografar as mensagens por razões de [segurança](./security).

Portanto, a web tinha basicamente movido de um transporte baseado em texto há muito tempo, mas o HTTP não. Uma razão para essa estagnação foi porque era muito difícil introduzir qualquer alteração significativa em um protocolo tão onipresente como o HTTP (esforços anteriores haviam tentado e falhado). Muitos roteadores, firewalls e outros dispositivos de rede entendiam o HTTP e reagiriam mal a grandes mudanças maiores. Atualizar todos eles para suportar uma nova versão simplesmente não era impossível.

Em 2009, a Google anunciou que estava trabalhando em uma alternativa ao HTTP baseado em texto chamada <a hreflang="en" href="https://www.chromium.org/spdy">SPDY</a>, que já foi descontinuada. Isso tiraria vantagem do fato de que as mensagens HTTP eram frequentemente criptografadas em HTTPS, o que evita que sejam lidas ou sofram interferência no trajeto.

A Google controlava um dos navegadores mais populares (Chrome) e alguns dos sites mais polulares (Google, YouTube, Gmail, etc) — logo, ambas as extremidades da conexão quando usados juntos. A ideia da Google era empacotar mensagens HTTP em um formato propriertário, enviá-las através da internet e desempacotá-las do outro lado. O formato proprietário, SPDY, era baseado em binário ao invés de texto. Isso resolveu alguns dos principais problemas de desempenho com o HTTP/1.1 ao permitir o uso mais eficiente de uma única conexão TCP, desprezando a necessidade de abrir as seis conexões que se tornaram regra no HTTP/1.1.

Ao usar SPDY no mundo real, eles conseguiram provar que era mais eficiente para usuários reais, e não apenas por causa de alguns resultados experimentais baseados em laboratório. Depois da implantação do SPDY em todos os sites da Google, outros servidores e navegadores começaram a implementá-lo e, então, era hora de padronizar este formato proprietário em um padrão na internet, e assim nasceu o HTTP/2.

O HTTP/2 tem os seguintes conceitos-chave:

* Formato binário
* Multiplexação
* Controle de fluxo
* Priorização
* Compressão de cabeçalho
* Push

**Formato binário** significa que as mensagens HTTP/2 são encapsuladas em quadros de um formato predefinido, fazendo com que as mensagens HTTP sejam mais fáceis de analisar e não precisem mais da verificação de caracteres de nova linha. Isso é melhor para a segurança já que havia um número considerável de <a hreflang="en" href="https://www.owasp.org/index.php/HTTP_Response_Splitting">exploits</a> para as versões anteriores do HTTP. Isso também quer dizer que as conexões HTTP/2 podem ser **multiplexadas**. Quadros diferentes para fluxos diferentes podem ser enviados na mesma conexão sem a interferência de um no outro, pois cada quadro inclui um identificador de fluxo e seu comprimento. A multiplexação permite o uso bem mais eficiente de uma única conexão TCP sem a sobrecarga de abrir conexões adicionais. Idealmente, abriríamos uma única conexão por domínio ou mesmo para <a hreflang="en" href="https://daniel.haxx.se/blog/2016/08/18/http2-connection-coalescing/">vários domínios</a>!

Ter fluxos separados introduz algumas complexidades junto com alguns benefícios potenciais. O HTTP/2 precisa do conceito de **controle de fluxo** para permitir que os diferentes fluxos enviem dados em taxas diferentes, enquanto anteriormente, com apenas uma resposta em movimento a qualquer momento, isso era controlado a nível de conexão pelo controle de fluxo do TCP. Da mesma forma, a **priorização** permite que múltiplas requisições sejam enviadas juntas, mas com as requisições mais importantes obtendo mais largura de banda.

Por fim, o HTTP/2 introduziu dois novos conceitos: **compactação de cabeçalho** e **HTTP/2 push**. A compactação de cabeçalho permitiu que os cabeçalhos HTTP baseados em texto fossem enviados com mais eficiência, usando um formato <a hreflang="en" href="https://tools.ietf.org/html/rfc7541">HPACK</a> específico do HTTP/2 por motivos de segurança. O HTTP/2 push permitia que mais de uma resposta fosse enviada em retorno a uma requisição, permitindo que o servidor enviasse recursos antes mesmo que o cliente soubesse que precisava deles. O push deveria acabar com a solução alternativa de performance de ter de incorporar recursos como CSS e JavaScript diretamente no HTML para evitar que a página fique suspensa enquanto esses recursos são solicitados. Com o HTTP/2, o CSS e o JavaScript podem permanecer como arquivos externos, mas ser enviados junto com o HTML inicial para que estejam disponíveis imediatamente. As requisições subsequentes da página não enviariam esses recursos, uma vez que agora eles estariam armazenados na cache e, portanto, não desperdiçariam largura de banda.

Este passeio rápido pelo HTTP/2 fornece a história e os conceitos principais do protocolo mais recente. Como deve ficar claro a partir dessa explicação, o principal benefício do HTTP/2 é abordar as limitações de desempenho do protocolo HTTP/1.1. Também houve melhorias de segurança — talvez o mais importante é tratar dos problemas de desempenho do uso de HTTPS, uma vez que HTTP/2, mesmo sobre HTTPS, <a hreflang="en" href="https://www.httpvshttps.com/">costuma ser muito mais rápido do que o HTTP simples</a>. Exceto pelo navegador web que empacota as mensagens HTTP no novo formato binário e pelo servidor web que as desempacota no outro lado, os princípios básicos do próprio HTTP permaneceram praticamente os mesmos. Isso significa que os aplicativos web não precisam fazer quaisquer alterações para suportar o HTTP/2, uma vez que o navegador e o servidor cuidam disso. Ativá-lo deve ser um aumento de desempenho gratuito, portanto, a adoção deve ser relativamente fácil. Obviamente, existem maneiras dos desenvolvedores web otimizarem para HTTP/2 para aproveitar ao máximo suas diferenças.

## Adoção do HTTP/2
Como mencionado acima, os protocolos da internet são frequentemente difíceis de adotar, uma vez que estão enraizados em grande parte da infraestrutura que compõe a internet. Isso torna a introdução de quaisquer mudanças lenta e difícil. O IPv6, por exemplo, existe há 20 anos, mas tem <a hreflang="en" href="https://www.google.com/intl/pt/ipv6/statistics.html">dificuldade de ser adotado</a>.

{{ figure_markup(
  caption="O percentual dos usuários no mundo que podem utilizar HTTP/2.",
  content="95%",
  classes="big-number"
)
}}

O HTTP/2, contudo, era diferente, visto que estava efetivamente oculto em HTTPS (pelo menos para os casos de uso do navegador), removendo as barreiras para adoção, desde que o navegador e o servidor o suportassem. O suporte do navegador tem sido muito forte há algum tempo e o advento da atualização automática nos navegadores, *evergreen*, significou que cerca de <a hreflang="en" href="https://caniuse.com/#feat=http2">95% dos usuários globais agora suportam HTTP/2</a>.

Nossa análise é proveniente do HTTP Archive, que testa aproximadamente 5 milhões dos principais sites para desktop e dispositivos móveis (mobile) no navegador Chrome. (Saiba mais sobre nossa [metodologia](./methodology).)

{{ figure_markup(
  image="ch20_fig2_http2_usage_by_request.png",
  caption='Uso de HTTP/2 por requisição. (Fonte: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#h2">HTTP Archive</a>)',
  description="Gráfico da série temporal mostrando a adoção de HTTP/2 em 55% para desktops e dispositivos móveis em julho de 2019. A tendência está crescendo continuamente em cerca de 15 pontos por ano.",
  width=600,
  height=321
  )
}}

Os resultados mostram que o uso do protocolo HTTP/2 agora é majoritário — um feito impressionante 4 anos após apenas a padronização formal! Olhando para o detalhamento de todas as versões de HTTP por requisição, vemos o seguinte:

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocol</th>
        <th>Desktop</th>
        <th>Mobile</th>
        <th>Ambos</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
        <td class="numeric">5.60%</td>
        <td class="numeric">0.57%</td>
        <td class="numeric">2.97%</td>
      </tr>
      <tr>
        <td>HTTP/0.9</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
      </tr>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">40.36%</td>
        <td class="numeric">45.01%</td>
        <td class="numeric">42.79%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">53.96%</td>
        <td class="numeric">54.37%</td>
        <td class="numeric">54.18%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Uso de versão HTTP por requisição.") }}</figcaption>
</figure>

A Figura 20.3 mostra que o HTTP/1.1 e o HTTP/2 são as versões usadas pela grande maioria das requisições conforme o esperado. Há apenas um número muito pequeno de requisições nos protocolos HTTP/1.0 e HTTP/0.9 mais antigos. Incomodamente, há uma porcentagem maior em que o protocolo não foi mapeado corretamente pelo rastreamento do HTTP Archive, especialmente no desktop. Investigar isso mostrou várias razões, algumas das quais podem ser explicadas e outras não. Com base em verificações pontuais, eles geralmente parecem ser requisições HTTP/1.1 e, presumindo que sejam, o uso de desktop e mobile é semelhante.

Não obstante haja uma porcentagem um pouco maior de ruído do que gostaríamos, isso não altera a mensagem geral transmitida aqui. Fora isso, a semelhança mobile/desktop não é inesperada; Testes do HTTP Archive com Chrome, que oferece suporte a HTTP/2 para desktop e dispositivo móvel. O uso no mundo real pode ter estatísticas ligeiramente diferentes com alguns usos mais antigos de navegadores em ambos, mas mesmo assim o suporte é generalizado, logo, não esperamos uma grande variação entre desktop e mobile.

No momento, o HTTP Archive não rastreia HTTP no <a hreflang="en" href="https://www.chromium.org/quic">QUIC</a> (em breve padronizado como [HTTP/3](#http3)) separadamente, então, essas requisições estão listadas no momento sob HTTP/2, mas veremos outras maneiras de medir isso posteriormente neste capítulo.

Olhar para o número de requisições distorce um pouco os resultados devido a requisições populares. Por exemplo, muitos sites carregam o Google Analytics, que suporta o HTTP/2 e, portanto, seria exibido como uma requisição HTTP/2, mesmo se o próprio site incorporando não oferecer suporte ao HTTP/2. Por outro lado, sites populares que tendem a oferecer suporte a HTTP/2 também são sub-representados nas estatísticas acima, pois são medidos apenas uma vez (por exemplo, "google.com" e "obscuresite.com" recebem pesos iguais). _Há mentiras, mentiras tremendas e estatísticas._

No entanto, nossas descobertas são corroboradas por outras fontes, como <a hreflang="en" href="https://telemetry.mozilla.org/new-pipeline/dist.html#!cumulative=0&measure=HTTP_RESPONSE_VERSION">telemetria da Mozilla</a>, que analisa o uso em cenário real através do navegador Firefox.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocolo</th>
        <th>Desktop</th>
        <th>Mobile</th>
        <th>Ambos</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.08%</td>
      </tr>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.09%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">62.36%</td>
        <td class="numeric">63.92%</td>
        <td class="numeric">63.22%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">37.46%</td>
        <td class="numeric">35.92%</td>
        <td class="numeric">36.61%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Uso de versão HTTP por páginas iniciais.") }}</figcaption>
</figure>

Ainda é interessante olhar as páginas iniciais apenas para obter uma estimativa aproximada do número de sites que suportam HTTP/2 (pelo menos em sua página inicial). A Figura 20.4 mostra menos suporte do que as requisições gerais, conforme esperado, em torno de 36%.

HTTP/2 só é suportado pelos navegadores em HTTPS, embora oficialmente HTTP/2 possa ser usado em HTTPS ou em conexões sem HTTPS, não criptografadas. Conforme mencionado anteriormente, ocultar o novo protocolo em conexões HTTPS criptografadas evita que os dispositivos de rede que não compreendem esse novo protocolo interfiram no (ou rejeitem!) seu uso. Além disso, o handshake executado no HTTPS permite um método fácil do cliente e do servidor concordarem em usar HTTP/2.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocolo</th>
        <th>Desktop</th>
        <th>Mobile</th>
        <th>Ambos</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.09%</td>
      </tr>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">45.81%</td>
        <td class="numeric">44.31%</td>
        <td class="numeric">45.01%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">54.04%</td>
        <td class="numeric">55.53%</td>
        <td class="numeric">54.83%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Uso de versão HTTP por páginas iniciais em HTTPS.") }}</figcaption>
</figure>

A web está mudando para HTTPS e o HTTP/2 vira de cabeça para baixo o argumento tradicional de que o HTTPS piora o desempenho. Nem todo site fez a transição para HTTPS, portanto, HTTP/2 nem estará disponível para aqueles que não transicionaram. Olhando apenas para os sites que usam HTTPS, na Figura 20.5 vemos uma maior adoção de HTTP/2 em cerca de 55%, semelhante à porcentagem de *todas as requisições* na Figura 20.2.

Mostramos que o suporte do navegador para HTTP/2 é forte e que há um caminho seguro para a adoção, então por que nem todo site (ou pelo menos todo site HTTPS) suporta HTTP/2? Bem, aqui chegamos ao requisito final para o suporte que ainda não medimos: suporte do servidor.

Isso é mais problemático do que o suporte do navegador, pois, diferente dos navegadores modernos, os servidores geralmente não são atualizados de maneira automática para a versão mais recente. Mesmo quando o servidor passa por manutenção e é corrigido regularmente, isso comumente apenas aplicará as atualizações de segurança em vez de novas funcionalidades como o HTTP/2. Vejamos primeiro os cabeçalhos HTTP no servidor para aqueles sites que oferecem suporte a HTTP/2.

<figure>
  <table>
    <thead>
      <tr>
        <th>Servidor</th>
        <th>Desktop</th>
        <th>Mobile</th>
        <th>Ambos</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>nginx</td>
        <td class="numeric">34.04%</td>
        <td class="numeric">32.48%</td>
        <td class="numeric">33.19%</td>
      </tr>
      <tr>
        <td>cloudflare</td>
        <td class="numeric">23.76%</td>
        <td class="numeric">22.29%</td>
        <td class="numeric">22.97%</td>
      </tr>
      <tr>
        <td>Apache</td>
        <td class="numeric">17.31%</td>
        <td class="numeric">19.11%</td>
        <td class="numeric">18.28%</td>
      </tr>
      <tr>
        <td></td>
        <td class="numeric">4.56%</td>
        <td class="numeric">5.13%</td>
        <td class="numeric">4.87%</td>
      </tr>
      <tr>
        <td>LiteSpeed</td>
        <td class="numeric">4.11%</td>
        <td class="numeric">4.97%</td>
        <td class="numeric">4.57%</td>
      </tr>
      <tr>
        <td>GSE</td>
        <td class="numeric">2.16%</td>
        <td class="numeric">3.73%</td>
        <td class="numeric">3.01%</td>
      </tr>
      <tr>
        <td>Microsoft-IIS</td>
        <td class="numeric">3.09%</td>
        <td class="numeric">2.66%</td>
        <td class="numeric">2.86%</td>
      </tr>
      <tr>
        <td>openresty</td>
        <td class="numeric">2.15%</td>
        <td class="numeric">2.01%</td>
        <td class="numeric">2.07%</td>
      </tr>
      <tr>
        <td>…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Servidores usados para HTTP/2.") }}</figcaption>
</figure>

O Nginx fornece repositórios de pacotes que facilitam a instalação ou atualização para a versão mais recente, portanto, não é nenhuma surpresa vê-lo liderando o caminho aqui. Cloudflare é o [CDN](./cdn) mais popular e habilita HTTP/2 por padrão, então, novamente, não surpreende ver que hospeda uma grande porcentagem dos sites com HTTP/2. A propósito, a Cloudflare usa uma versão <a hreflang="en" href="https://blog.cloudflare.com/nginx-structural-enhancements-for-http-2-performance/">altamente personalizada</a> do nginx como seu servidor web. Depois disso, vemos o Apache com cerca de 20% de uso, seguido por alguns servidores que optam por ocultar o que são, e então os players menores, como LiteSpeed, IIS, Google Servlet Engine e openresty, que é baseado em nginx.

O mais interessante são os servidores que *não* suportam o HTTP/2:

<figure>
  <table>
    <thead>
      <tr>
        <th>Servidor</th>
        <th>Desktop</th>
        <th>Mobile</th>
        <th>Ambos</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Apache</td>
        <td class="numeric">46.76%</td>
        <td class="numeric">46.84%</td>
        <td class="numeric">46.80%</td>
      </tr>
      <tr>
        <td>nginx</td>
        <td class="numeric">21.12%</td>
        <td class="numeric">21.33%</td>
        <td class="numeric">21.24%</td>
      </tr>
      <tr>
        <td>Microsoft-IIS</td>
        <td class="numeric">11.30%</td>
        <td class="numeric">9.60%</td>
        <td class="numeric">10.36%</td>
      </tr>
      <tr>
        <td></td>
        <td class="numeric">7.96%</td>
        <td class="numeric">7.59%</td>
        <td class="numeric">7.75%</td>
      </tr>
      <tr>
        <td>GSE</td>
        <td class="numeric">1.90%</td>
        <td class="numeric">3.84%</td>
        <td class="numeric">2.98%</td>
      </tr>
      <tr>
        <td>cloudflare</td>
        <td class="numeric">2.44%</td>
        <td class="numeric">2.48%</td>
        <td class="numeric">2.46%</td>
      </tr>
      <tr>
        <td>LiteSpeed</td>
        <td class="numeric">1.02%</td>
        <td class="numeric">1.63%</td>
        <td class="numeric">1.36%</td>
      </tr>
      <tr>
        <td>openresty</td>
        <td class="numeric">1.22%</td>
        <td class="numeric">1.36%</td>
        <td class="numeric">1.30%</td>
      </tr>
      <tr>
        <td>…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Servidores usados para HTTP/1.1 ou inferior.") }}</figcaption>
</figure>

Parte disso será tráfego sem HTTPS que usaria HTTP/1.1 mesmo que o servidor suportasse HTTP/2, mas um problema maior são aqueles que não suportam HTTP/2 de jeito nenhum. Nesses dados, vemos uma participação muito maior para o Apache e o IIS, que provavelmente estão executando versões mais antigas.

Para o Apache em particular, geralmente não é fácil adicionar suporte ao HTTP/2 a uma instalação existente, já que o Apache não fornece um repositório oficial para instalar a partir dele. Isso usualmente significa recorrer à compilação da fonte ou confiar em um repositório de terceiros, nenhum dos quais é particularmente atraente para muitos administradores.

Apenas as versões mais recentes de distribuições Linux (RHEL e CentOS 8, Ubuntu 18 e Debian 9) vêm com uma versão do Apache que suporta HTTP/2, e muitos servidores ainda não estão rodando nelas. No lado da Microsoft, apenas o Windows Server 2016 e superior oferecem suporte a HTTP/2, portanto, novamente aqueles que rodam versões mais antigas não oferecem suporte ao protocolo no IIS.

Mesclando essas duas estatísticas, podemos ver a porcentagem de instalações por servidor, que usam HTTP/2:

<figure>
  <table>
    <thead>
      <tr>
        <th>Servidor</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>cloudflare</td>
        <td class="numeric">85.40%</td>
        <td class="numeric">83.46%</td>
      </tr>
      <tr>
        <td>LiteSpeed</td>
        <td class="numeric">70.80%</td>
        <td class="numeric">63.08%</td>
      </tr>
      <tr>
        <td>openresty</td>
        <td class="numeric">51.41%</td>
        <td class="numeric">45.24%</td>
      </tr>
      <tr>
        <td>nginx</td>
        <td class="numeric">49.23%</td>
        <td class="numeric">46.19%</td>
      </tr>
      <tr>
        <td>GSE</td>
        <td class="numeric">40.54%</td>
        <td class="numeric">35.25%</td>
      </tr>
      <tr>
        <td></td>
        <td class="numeric">25.57%</td>
        <td class="numeric">27.49%</td>
      </tr>
      <tr>
        <td>Apache</td>
        <td class="numeric">18.09%</td>
        <td class="numeric">18.56%</td>
      </tr>
      <tr>
        <td>Microsoft-IIS</td>
        <td class="numeric">14.10%</td>
        <td class="numeric">13.47%</td>
      </tr>
      <tr>
        <td>…</td>
        <td class="numeric">…</td>
        <td class="numeric">…</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Porcentagem de instalações de cada servidor usado para fornecer HTTP/2.") }}</figcaption>
</figure>

É claro que o Apache e o IIS ficam para trás com 18% e 14%, respectivamente, sobre seu suporte na instalação com base em HTTP/2, o que deve ser (ao em parte) uma consequência de ser mais difícil atualizá-los. Frequentemente, é necessária uma atualização completa do sistema operacional no caso de vários servidores para conseguir esse suporte facilmente. Com sorte, isso se tornará mais fácil à medida que as novas versões de sistemas operacionais se tornarem regra.

Nada disso é um comentário sobre as implementações HTTP/2 aqui ([acho que o Apache tem uma das melhores implementações](https://x.com/tunetheweb/status/988196156697169920?s=20)), mas mais sobre a facilidade de habilitar o HTTP/2 em cada um desses servidores — ou a falta dela.

## Impacto do HTTP/2
O impacto do HTTP/2 é muito mais difícil de medir, especialmente usando o HTTP Archive [metodologia](./methodology). Idealmente, os sites seriam rastreados com ambos HTTP/1.1 e HTTP/2 e a diferença medida, mas isso não é possível com as estatísticas que estamos investigando aqui. Além disso, medir se o site com HTTP/2 médio é mais rápido do que o site com HTTP/1.1 médio apresenta muitas outras variáveis que requerem um estudo mais exaustivo do que podemos cobrir aqui.

Um impacto que pode ser medido é a mudança no uso de HTTP, agora que estamos em um mundo do HTTP/2. Várias conexões eram uma solução alternativa com o HTTP/1.1 para permitir uma forma limitada de paralelização, mas isso é na verdade o oposto do que geralmente funciona melhor com HTTP/2. Uma única conexão reduz a sobrecarga da configuração do TCP, a inicialização lenta do TCP e a negociação HTTPS, além de permitir o potencial de priorização de requisições cruzadas.

{{ figure_markup(
  image="ch20_fig9_num_tcp_connections_trend_over_years.png",
  caption='Conexões TCP por página. (Fonte: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#tcp">HTTP Archive</a>)',
  description="Gráfico de série temporal do número de conexões TCP por página, com a página média em desktop tendo 14 conexões e a página média em dispositivos móveis tendo 16 conexões, em julho de 2019.",
  width=600,
  height=320
  )
}}

O HTTP Archive mede o número de conexões TCP por página, e isso está caindo constantemente à medida que mais sites suportam HTTP/2 e usam sua única conexão em vez de seis conexões separadas.

{{ figure_markup(
  image="ch20_fig10_total_requests_per_page_trend_over_years.png",
  caption='Requisições totais por página. (Fonte: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#reqTotal">HTTP Archive</a>)',
  description="Gráfico de série temporal do número de requisições por página, com a página média em desktop tendo 74 requisições e a página média em dispositivos móveis tendo 69 requisições, em julho de 2019. A tendência é relativamente estável.",
  width=600,
  height=320
  )
}}

O agrupamento (e minificação) de recursos para obter menos requisições era outra solução alternativa do HTTP/1.1 que tinha muitos nomes: agrupamento, concatenação, empacotamento, spriting etc. Isso é menos necessário ao usar HTTP/2, pois há menos sobrecarga com requisições, mas deve ser observado que as requisições não são gratuitas em HTTP/2 e <a hreflang="en" href="https://engineering.khanacademy.org/posts/js-packaging-http2.htm">aqueles que experimentaram remover o agrupamento completamente notaram uma perda de desempenho</a>. Observando o número de requisições carregadas por página ao longo do tempo, vemos uma ligeira queda, em vez do aumento esperado.

Essa baixa taxa de mudança pode talvez ser atribuída às observações mencionadas acima de que o agrupamento não pode ser removido (pelo menos, não completamente) sem um impacto negativo na performance e que muitas ferramentas de compilação atualmente agrupam por motivos históricos com base nas recomendações ao HTTP/1.1. Também é provável que muitos sites não estejam dispostos a penalizar os usuários do HTTP/1.1 desfazendo suas adaptações de desempenho do HTTP/1.1 ainda, ou pelo menos que eles não tenham a confiança (ou tempo!) pra sentir que isso vale a pena.

O fato do número de requisições permanecer praticamente estático é interessante, dado o [peso da página](./page-weight) sempre crescente, embora talvez isso não esteja totalmente relacionado ao HTTP/2.

## HTTP/2 Push
O processo de HTTP/2 push tem uma história mista, apesar de ser uma funcionalidade nova muito elogiada do HTTP/2. Os outros recursos eram basicamente melhorias de desempenho sob o capô, mas o push era um conceito totalmente novo que quebrou completamente a natureza de requisição única para resposta única do HTTP. Isso permitiu que respostas extras fossem retornadas; quando você pedisse pela página web, o servidor poderia responder com a página HTML como de costume, mas também enviá-lo o CSS e o JavaScript críticos, evitando assim quaisquer viagens de ida e volta adicionais para determinados recursos. Teoricamente, isso nos permitiria parar de inserir CSS e JavaScript diretamente no HTML e ainda obter os mesmos ganhos de desempenho de fazê-lo. Resolver isso, poderia depois levar a todos os tipos de casos de uso novos e interessantes.

A realidade tem sido, bem, um pouco decepcionante. O HTTP/2 push provou ser muito mais difícil de usar de maneira efetiva do que o previsto originalmente. Parte disso foi atribuído à <a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">complexidade de como o HTTP/2 push funciona</a> e aos problemas de implementação devido a isso.

Uma preocupação maior é que o push pode facilmente causar, em vez de resolver, problemas de desempenho. O excesso de push é um risco real. Frequentemente, o navegador está no melhor lugar para decidir *o que* solicitar, e tão crucialmente *quando* solicitá-lo, mas o HTTP/2 push coloca essa responsabilidade no servidor. Enviar recursos que um navegador já possui em seu cache é um desperdício de largura de banda (embora, em minha opinião, igualmente seja incluir CSS diretamente no HTML, mas isso é menos difícil do que o HTTP/2 push!).

<a hreflang="en" href="https://lists.w3.org/Archives/Public/ietf-http-wg/2019JanMar/0033.html">As propostas de informar o servidor sobre o status do cache do navegador foram bloqueadas</a> especialmente em questões de privacidade. Mesmo sem esse problema, existem outros problemas potenciais se o push não for usado corretamente. Por exemplo, enviar imagens grandes e, portanto, impedir o envio de CSS e JavaScript essenciais levará a sites mais lentos do que se você nem tivesse feito push!

Também há muito pouca evidência até o momento de que o push, mesmo quando implementado corretamente, resulta no aumento de desempenho prometido. Esta é uma área em que, novamente, o HTTP Archive não está na melhor posição para responder, devido à natureza de como ele é executado (um rastreamento de sites populares usando o Chrome em um estado), então não vamos nos aprofundar muito aqui. No entanto, basta dizer que os ganhos de performance estão longe de ser claros e os problemas potenciais são reais.

Deixando isso de lado, vamos analisar o uso do HTTP/2 push.

<figure>
  <table>
    <thead>
      <tr>
        <th>Cliente</th>
        <th>Sites Usando o HTTP/2 Push</th>
        <th>Sites Usando o HTTP/2 Push (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">22,581</td>
        <td class="numeric">0.52%</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">31,452</td>
        <td class="numeric">0.59%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Sites Usando o HTTP/2 Push.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Cliente</th>
        <th>Méd. de Requisições Enviadas</th>
        <th>Méd. de KB Enviados</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Desktop</td>
        <td class="numeric">7.86</td>
        <td class="numeric">162.38</td>
      </tr>
      <tr>
        <td>Mobile</td>
        <td class="numeric">6.35</td>
        <td class="numeric">122.78</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Quanto é enviado em push quando é usado.") }}</figcaption>
</figure>

Essas estatísticas mostram que a aceitação do HTTP/2 push é muito baixa, provavelmente por causa dos problemas descritos anteriormente. No entanto, quando os sites usam push, eles tendem a usá-lo bastante, em vez de para um ou recursos, conforme mostrado na Figura 20.12.

Essa é uma preocupação, pois o conselho anterior era ser conservador com o push e <a hreflang="en" href="https://docs.google.com/document/d/1K0NykTXBbbbTlv60t5MyJvXjqKGsCVNYHyLEXIxYMv0/edit">"enviar apenas recursos suficientes para preencher o tempo de rede ocioso e nada mais"</a>. As estatísticas acima sugerem que muitos recursos de um tamanho combinado significativo são enviados.

{{ figure_markup(
  image="ch20_fig13_what_push_is_used_for.png",
  caption="Para que tipo de recurso o push é usado?",
  description="Gráfico de pizza detalhando a porcentagem dos tipos de recurso que são enviados. JavaScript compõe quase metade, seguido de CSS com cerca de um quarto, as imagens cerca de um oitavo e vários outros tipos de recurso baseados em texto compõem o resto.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQLxLA5Nojw28P7ceisqti3oTmNSM-HIRIR0bDb2icJS5TzONvRhdqxQcooh_45TmK97XVpot4kEQA0/pubchart?oid=466353517&format=interactive"
  )
}}

A Figura 20.13 nos mostra quais recursos são mais comumente enviados. JavaScript e CSS são a esmagadora maioria dos itens enviados, tanto por volume quanto por bytes. Depois disso, há uma variedade de imagens, fontes e dados. No final, vemos cerca de 100 sites enviando vídeo, o que pode ser intencional ou pode ser um sinal de excesso de envio dos tipos de recurso errados!

Uma preocupação levantada por alguns é que as implementações HTTP/2 redesignaram o `link` do cabeçalho `preload` do HTTP como um sinal para o push. Um dos usos mais populares da dica de recurso `preload` é informar o navegador sobre recursos descobertos posteriormente, como fontes e imagens, que o navegador não perceberá até que o CSS tenha sido solicitado, baixado e analisado. Se agora eles são enviados com base nesse cabeçalho, havia uma preocupação de que reutilizá-los poderia resultar em muitos envios indesejados.

No entanto, o uso relativamente baixo de fontes e imagens pode significar que o risco não está sendo percebido tanto quanto se temia. As tags `<link rel="preload"...>` são comumente usadas no HTML ao invés dos cabeçalhos `link` no HTTP e as meta tags não são um sinal de envio. As estatísticas no capítulo de [Sugestão de Recursos](./resource-hints) mostram que menos de 1% dos sites usam o cabeçalho `link` do HTTP pré-carregado e aproximadamente a mesma quantidade usam pré-conexão, que não tem significado algum no HTTP/2, portanto, isso sugeriria que não é tanto um problema. Embora haja uma número de fontes e outros recursos sendo enviados, o que pode ser um sinal disso.

Como um contra argumento a essas reclamações, se um recurso é importante o suficiente para pré-carregar, então pode-se argumentar que esses recursos devem ser enviados se possível, já que os navegadores tratam uma sugestão de pré-carregamento como requisições de prioridade muito alta de qualquer forma. Qualquer preocupação com o desempenho é, portanto (mais uma vez, sem dúvida), no uso excessivo do pré-carregamento, em vez do HTTP/2 push que resulta disso.

Para contornar esse push não intencional, você pode fornecer o atributo `nopush` em seu cabeçalho de pré-carregamento:

```
link: </assets/jquery.js>; rel=preload; as=script; nopush
```

5% dos cabeçalhos HTTP pré-carregados usam esse atributo, que é maior do que eu esperava, pois consideraria isso uma otimização de nicho. Então, novamente, também é o uso de cabeçalhos HTTP pré-carregados e/ou HTTP/2 push em si!

## Problemas do HTTP/2
O HTTP/2 é principalmente parte de uma atualização contínua que, uma vez que seu servidor suporte, você pode fazer uso sem a necessidade de alterar seu site ou aplicativo. Você pode otimizar para HTTP/2 ou parar de usar as soluções alternativas do HTTP/1.1, mas em geral, um site normalmente funcionará sem a necessidade de nenhuma alteração — será apenas mais rápido. Entretanto, existem algumas pegadinhas de que você deve ter ciência, que podem afetar qualquer atualização, e alguns sites descobriram isso da maneira mais difícil.

Uma das causas de problemas no HTTP/2 é o suporte insuficiente para a priorização do HTTP/2. Este recurso permite que múltiplas requisições em andamento façam o uso apropriado da conexão. Isso é especialmente importante por que o HTTP/2 aumentou enormemente o número de requisições que podem ser executadas na mesma conexão. Ter 100 ou 128 como limites de requisição paralela são comuns em implementações de servidor. Anteriormente, o navegador tinha no máximo seis conexões por domínio e, portanto, usava sua habilidade e julgamento para decidir a como melhor usar essas conexões. Agora, raramente precisa fazer fila e pode enviar todas as requisições assim que as reconhece delas. Isso pode fazer com que a largura de banda seja "desperdiçada" em requisições de prioridade mais baixa, enquanto requisições críticas são atrasadas (e, incidentalmente, <a hreflang="en" href="https://www.lucidchart.com/techblog/2019/04/10/why-turning-on-http2-was-a-mistake/">também podem levar a sobrecarga do seu servidor de back-end com mais requisições que o usado!</a>).

O HTTP/2 tem um modelo de priorização complexo (muitos dizem que é demasiado complexo — daí por que está sendo reconsiderado para o HTTP/3!), porém, poucos servidores o empregam adequadamente. Isso pode ser porque suas implementações do HTTP/2 não estão à altura ou por causa do chamado *bufferbloat*, em que as respostas já estão a caminho antes que o servidor perceba que há uma requisição de prioridade mais alta. Devido à natureza variável dos servidores, pilhas TCP e localizações, é difícil medir isso para a maioria dos sites, mas com CDNs isso deve ser mais consistente.

[Patrick Meenan](https://x.com/patmeenan) criou <a hreflang="en" href="https://github.com/pmeenan/http2priorities/tree/master/stand-alone">uma página de teste de exemplo</a>, que deliberadamente tenta baixar uma carga de recursos de baixa prioridade, imagens fora do foco da tela, antes de fazer a requisição de algumas imagens de alta prioridade, na tela. Um bom servidor HTTP/2 deve ser capaz de reconhecer isso e enviar as imagens de alta prioridade logo após solicitadas, às custas das imagens de baixa prioridade. Um servidor HTTP/2 ruim apenas responderá na ordem de requisição e ignorará quaisquer sinais de prioridade. [Andy Davies](./contributors#andydavies) tem <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">uma página rastreando o status de vários CDNs para o teste de Patrick</a>. O HTTP Archive identifica quando um CDN é usado como parte do seu rastreamento e a fusão desses dois conjuntos de dados pode nos dizer a porcentagem de páginas que usam um CDN aprovado ou com falha.

<figure>
  <table>
    <thead>
      <tr>
        <th>CDN</th>
        <th>Prioriza Corretamente?</th>
        <th>Desktop</th>
        <th>Mobile</th>
        <th>Ambos</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Sem uso de CDN</td>
        <td>Desconhecido</td>
        <td class="numeric">57.81%</td>
        <td class="numeric">60.41%</td>
        <td class="numeric">59.21%</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>Passa</td>
        <td class="numeric">23.15%</td>
        <td class="numeric">21.77%</td>
        <td class="numeric">22.40%</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>Falha</td>
        <td class="numeric">6.67%</td>
        <td class="numeric">7.11%</td>
        <td class="numeric">6.90%</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>Falha</td>
        <td class="numeric">2.83%</td>
        <td class="numeric">2.38%</td>
        <td class="numeric">2.59%</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>Passa</td>
        <td class="numeric">2.40%</td>
        <td class="numeric">1.77%</td>
        <td class="numeric">2.06%</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>Passa</td>
        <td class="numeric">1.79%</td>
        <td class="numeric">1.50%</td>
        <td class="numeric">1.64%</td>
      </tr>
      <tr>
        <td></td>
        <td>Desconhecido</td>
        <td class="numeric">1.32%</td>
        <td class="numeric">1.58%</td>
        <td class="numeric">1.46%</td>
      </tr>
      <tr>
        <td>WordPress</td>
        <td>Passa</td>
        <td class="numeric">1.12%</td>
        <td class="numeric">0.99%</td>
        <td class="numeric">1.05%</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>Falha</td>
        <td class="numeric">0.88%</td>
        <td class="numeric">0.75%</td>
        <td class="numeric">0.81%</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>Falha</td>
        <td class="numeric">0.39%</td>
        <td class="numeric">0.34%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>Falha</td>
        <td class="numeric">0.23%</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.19%</td>
      </tr>
      <tr>
        <td>OVH CDN</td>
        <td>Desconhecido</td>
        <td class="numeric">0.19%</td>
        <td class="numeric">0.18%</td>
        <td class="numeric">0.18%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Suporte à priorização no HTTP/2 em CDNs comuns.") }}</figcaption>
</figure>

A Figura 20.14 mostra que uma parte bastante significativa do tráfego está sujeita ao problema identificado, totalizando 26,82% em desktop e 27,83% em dispositivos móveis. O quão problemático isso é depende exatamente de como a página é carregada e se os recursos de alta prioridade são descobertos tardiamente ou não para os sites afetados.

{{ figure_markup(
  caption="A porcentagem de requisições de dispositivos móveis com priorização no HTTP/2 subotimizada.",
  content="27.83%",
  classes="big-number"
)
}}

Outro problema é com o cabeçalho `upgrade` do HTTP sendo usado incorretamente. Os servidores web podem responder às requisições com um cabeçalho `upgrade`, sugerindo que ele suporta um protocolo melhor que o cliente pode desejar usar (por exemplo, indicar HTTP/2 para um cliente usando apenas HTTP/1.1). Você pode pensar que isso seria útil como um método de informar ao navegador que um servidor suporta HTTP/2, mas como os navegadores só suportam HTTP/2 sobre HTTPS e como o uso de HTTP/2 pode ser negociado por meio do handshake do HTTPS, o uso do cabeçalho `upgrade` para anunciar o HTTP/2 é bastante limitado (para navegadores, pelo menos).

Pior do que isso, é quando um servidor envia um cabeçalho `upgrade` com erro. Isso pode ocorrer porque um servidor de back-end com suporte a HTTP/2 está enviando o cabeçalho e, em seguida, um servidor de borda com suporte apenas para HTTP/1.1 o está encaminhando cegamente ao cliente. O Apache emite o cabeçalho `upgrade` quando `mod_http2` está habilitado e o HTTP/2 não está sendo usado, e uma instância nginx colocada na frente de tal instância Apache felizmente encaminha este cabeçalho mesmo quando o nginx não suporta HTTP/2. Essa propaganda enganosa, então, leva os clientes a tentar (sem sucesso!) usar HTTP/2 conforme recomendado.

108 sites usam HTTP/2, embora também sugiram a atualização para HTTP/2 no cabeçalho `upgrade`. Outros 12.767 sites no desktop (15.235 em dispositivos móveis) sugerem atualizar uma conexão HTTP/1.1 entregue por HTTPS para HTTP/2 quando está claro que não estava disponível, ou já teria sido usado. Essa é uma pequena minoria dos 4,3 milhões de sites rastreados em desktop e 5,3 milhões de sites rastreados em dispositivos móveis, mas mostra que esse ainda é um problema que afeta vários sites por aí. Os navegadores lidam com isso de maneira inconsistente, com o Safari em particular tentando atualizar e, em seguida, se metendo em uma bagunça e se recusando de vez a exibir o site.

Tudo isso antes de entrarmos nos poucos sites que recomendam a atualização para `http1.0`, `http://1.1`, ou mesmo `-all,+TLSv1.3,+TLSv1.2`. Existem claramente alguns erros de digitação nas configurações do servidor web acontecendo aqui!

Existem outros problemas além de implementação que podemos analisar. Por exemplo, HTTP/2 é muito mais restrito sobre os nomes de cabeçalho HTTP, rejeitando a requisição inteira se você responder com espaços, dois pontos ou outros nomes de cabeçalho HTTP inválidos. Os nomes de cabeçalho também são convertidos em letras minúsculas, o que pega alguns de surpresa se sua aplicação assumir certa capitalização. Isso nunca foi garantido anteriormente, já que o HTTP/1.1 afirma especificamente que <a hreflang="en" href="https://tools.ietf.org/html/rfc7230#section-3.2">os nomes dos cabeçalhos não diferenciam maiúsculas de minúsculas</a>, mas ainda assim alguns dependeram disso. O HTTP Archive também pode ser usado para identificar esses problemas, embora alguns deles não sejam aparentes na página inicial, mas não nos aprofundamos nisso este ano.

## HTTP/3
O mundo não para e, apesar do HTTP/2 não ter sequer completado seu quinto aniversário, as pessoas já o estão vendo como uma notícia velha e ficando mais entusiasmadas com seu sucessor, o <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-quic-http">HTTP/3</a>. O HTTP/3 baseia-se nos conceitos do HTTP/2, mas vai do trabalho sobre conexões TCP que o HTTP sempre usou para um protocolo baseado em UDP chamado <a hreflang="en" href="https://datatracker.ietf.org/wg/quic/about/">QUIC</a>. Isso nos permite corrigir um caso em que o HTTP/2 é mais lento que o HTTP/1.1, quando há uma grande perda de pacotes e a natureza garantidora do TCP retém e restringe todos os fluxos. Também nos permite abordar algumas ineficiências do TCP e do HTTPS, como a consolidação em um só handshake para ambos e o suporte a muitas ideias para TCP que se mostraram difíceis de implementar na vida real (TCP fast open, 0-RTT, etc.).

O HTTP/3 também elimina algumas sobreposições entre o TCP e o HTTP/2 (por exemplo, controle de fluxo sendo implementado em ambas as camadas), mas conceitualmente é muito semelhante a HTTP/2. Os desenvolvedores web que entendem e otimizam soluções para HTTP/2 não devem fazer mais alterações para HTTP/3. No entanto, operadores de servidor terão mais trabalho a fazer já que as diferenças entre TCP e QUIC são bem mais inovadoras. Elas tornarão a implementação mais difícil, de modo que o lançamento de HTTP/3 pode demorar consideravelmente mais do que HTTP/2 e, inicialmente, ser limitado àqueles com certa experiência no campo, como os CDNs.

O QUIC foi implementado pela Google por vários anos e agora está passando por um processo de padronização semelhante ao que o SPDY fez em seu caminho para HTTP/2. O QUIC tem ambições além de apenas HTTP, mas é o caso de uso que sendo trabalhado atualmente. Quando este capítulo estava sendo escrito, <a hreflang="en" href="https://blog.cloudflare.com/http3-the-past-present-and-future/">Cloudflare, Chrome e Firefox anunciaram suporte ao HTTP/3</a>, apesar do fato de que o HTTP/3 ainda não está formalmente completo ou aprovado como padrão. Isso é bem-vindo, pois estava faltando suporte ao QUIC fora da Google até recentemente e definitivamente fica atrás do suporte a SPDY e HTTP/2 de um estágio semelhante de padronização.

Como o HTTP/3 usa QUIC sobre UDP em vez de TCP, ele torna a descoberta do suporte HTTP/3 um desafio maior do que a descoberta para o HTTP/2. Com HTTP/2, podemos usar principalmente o handshake do HTTPS, mas como o HTTP/3 está em uma conexão completamente diferente, que essa não é uma opção aqui. HTTP/2 também usa o cabeçalho HTTP `upgrade` para informar ao navegador sobre o suporte HTTP/2, e embora isso não seja tão útil para HTTP/2, um mecanismo semelhante foi colocado em prática para QUIC que é mais útil. O cabeçalho *alternative services* (serviços alternativos) do HTTP (`alt-svc`) anuncia protocolos alternativos que podem ser usados em conexões completamente diferentes, ao contrário de protocolos alternativos que podem ser usados nesta conexão, que é para o que o cabeçalho `upgrade` do HTTP é usado.

{{ figure_markup(
  caption="A porcentagem de sites em dispositivos móveis com suporte a QUIC.",
  content="8.38%",
  classes="big-number"
)
}}

A análise desse cabeçalho mostra que 7,67% dos sites em desktop e 8,38% dos sites em dispositivos móveis já suportam QUIC, o que representa aproximadamente a porcentagem de tráfego do Google, o que não é novidade, já que ele vem usando isso há algum tempo. E 0,04% já suportam HTTP/3. Eu imagino que até o Web Almanac do próximo ano, esse número terá aumentado significativamente.

## Conclusão
Esta análise das estatísticas disponíveis no projeto HTTP Archive mostrou o que muitos de nós na comunidade HTTP já sabíamos: o HTTP/2 está aqui e está provando ser muito popular. Já é o protocolo dominante em termos de número de requisições, mas ainda não superou o HTTP/1.1 em termos de número de sites que o suportam. A extensão da internet significa que muitas vezes leva um tempo exponencialmente mais longo para obter ganhos perceptíveis nos sites menos bem mantidos do que nos sites mais reconhecidos e de alto volume.

Também falamos sobre como (ainda!) não é fácil conseguir suporte ao HTTP/2 em algumas instalações. Desenvolvedores de servidores, distribuidores de sistemas operacionais e clientes finais, todos têm um papel a desempenhar para tornar isso mais fácil. Atrelar software a sistemas operacionais sempre aumenta o tempo de implantação. De fato, um dos principais motivos a favor o QUIC é quebrar uma barreira similar com a implantação de alterações do TCP. Em muitos casos, não há razão real para vincular as versões do servidor web aos sistemas operacionais. O Apache (para usar um dos exemplos mais populares) rodará com suporte a HTTP/2 em sistemas operacionais mais antigos, mas obter uma versão atualizada no servidor não deve exigir a experiência ou o risco que exige atualmente. O Nginx se sai muito bem aqui, hospedando repositórios para as distribuições comuns de Linux para tornar a instalação mais fácil, e se a equipe do Apache (ou os fornecedores de distribuição Linux) não oferecerem algo semelhante, então eu só posso ver o uso do Apache continuando a diminuir enquanto luta para manter a relevância e mudar sua reputação de ser antigo e lento (com base em instalações mais antigas), embora as versões atualizadas tenham uma das melhores implementações do HTTP/2. Eu vejo isso como um problema menor para o IIS, já que geralmente é o servidor web preferido no lado do Windows.

Fora isso, o HTTP/2 tem sido um caminho de atualização relativamente fácil, e é por isso que teve a forte aceitação que já viu. Para a maior parte, é uma ativação fácil e, portanto, para a maioria, revelou-se um aumento de desempenho descomplicado que requer pouca reflexão, uma vez que seu servidor ofereça suporte. Contudo, o diabo está nos detalhes (como sempre), e pequenas diferenças entre as implementações de servidor podem resultar em melhor ou pior uso do HTTP/2 e, em última análise, na experiência do usuário final. Também houve uma série de bugs e até mesmo <a hreflang="en" href="https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-002.md">problemas de segurança</a>, como deve ser esperado com qualquer protocolo novo.

Garantir que você esteja usando uma implementação forte, atualizada e bem mantida de qualquer protocolo novato, como o HTTP/2, garantirá que você fique atento a esses problemas. No entanto, isso pode exigir experiência e gerenciamento. A implementação do QUIC e do HTTP/3 provavelmente será ainda mais complicada e exigirá mais experiência. Talvez seja melhor deixar isso para provedores de serviços terceirizados, como CDNs, que têm esse conhecimento e podem fornecer ao seu site acesso fácil a esses recursos. Entretanto, mesmo quando deixado para os especialistas, não há garantia (como mostram as estatísticas de priorização), mas se você escolher seu provedor de servidor com sabedoria e se envolver com eles sobre quais são suas prioridades, a implementação deve ser mais fácil.

Por falar nisso, seria ótimo se os CDNs priorizassem esses problemas (trocadilho definitivamente intencional!), embora eu suspeite que com o advento de um novo método de priorização no HTTP/3, muitos vão segurar firme. O próximo ano será uma época ainda mais interessante no mundo do HTTP.
