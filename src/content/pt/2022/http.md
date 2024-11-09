---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP
description: O capítulo HTTP do Web Almanac de 2022 aborda dados sobre versões históricas do HTTP utilizadas na web, além do aumento das novas versões, incluindo HTTP/2 e HTTP/3, enquanto também examina métricas-chave como parte do ciclo de vida do HTTP.
authors: [paivaspol]
reviewers: [tunetheweb, rmarx, LPardue]
analysts: [paivaspol]
editors: [tunetheweb]
translators: [HakaCode]
paivaspol_bio: Vaspol Ruamviboonsuk é um Engenheiro de Software na Microsoft. Ele concluiu seu doutorado na Universidade de Michigan, conduzindo pesquisas em sistemas para acelerar o carregamento de páginas da web. Você pode se conectar com ele no <a hreflang="en" href="https://www.linkedin.com/in/vaspol-ruamviboonsuk-7898b824/">LinkedIn</a>.
results: https://docs.google.com/spreadsheets/d/1NJrPOjBoJSDsHV0rAHpcZ9qBUgy6RVG3QtvbTqrj5_o/
featured_quote: Este último ano foi um ano movimentado para o protocolo HTTP, especialmente com a padronização do HTTP/3. Continuamos a observar uma alta utilização do HTTP/2 e esperamos um forte suporte ao HTTP/3 por parte dos servidores web.
featured_stat_1: 77%
featured_stat_label_1: Requests served on HTTP/2 or above
featured_stat_2: 1.5%
featured_stat_label_2: Websites adopting 103 Early Hints
featured_stat_3: 50%
featured_stat_label_3: Increase in requests that have HTTP/3 support
---

## Introdução

O HTTP é o alicerce do ecossistema da web, fornecendo a base para a troca de dados e possibilitando diversos tipos de serviços na internet. Ele passou por várias evoluções, especialmente nos últimos anos, com a introdução do HTTP/2 e, mais recentemente, do HTTP/3. O HTTP/2 procurou abordar as limitações do HTTP/1.1, como o número limitado de solicitações simultâneas. À primeira vista, o HTTP/3 é semelhante ao HTTP/2, pois as semânticas são as mesmas, mas, por baixo dos panos, o HTTP/3 é radicalmente diferente de seus antecessores, pois utiliza o protocolo de transporte QUIC em vez do TCP.

Como o HTTP/2 serve de base para o HTTP/3, analisamos recursos-chave do HTTP/2, como o HTTP/2 Push, a priorização e a multiplexação, para entender em que medida eles ainda são usados. Também apresentamos estudos de caso de várias experiências de implantação desses recursos. Por exemplo, o HTTP/2 Push permite que os servidores web enviem antecipadamente a resposta de um recurso antes que o cliente o solicite.

Embora tanto o push quanto a priorização teoricamente possam ser benéficos para os usuários finais, eles podem ser desafiadores de usar. Discutimos novas tecnologias que podem ser potencialmente utilizadas como alternativas aos recursos do HTTP/2 que não apresentam bom desempenho. Por exemplo, as respostas 103 Early Hints fornecem uma alternativa ao push do servidor do HTTP/2 que alcança o mesmo objetivo de desempenho de buscas de recursos preemptivas.

Por fim, exploramos o HTTP/3 discutindo como ele representa uma melhoria em relação ao HTTP/2 e analisando o suporte atual para o HTTP/3, onde observamos um aumento em relação a 2021. Esperamos que os pontos de dados apresentados neste capítulo proporcionem algumas perspectivas sobre as tendências futuras e indicativos de novas tecnologias que os desenvolvedores podem experimentar para melhorar as experiências dos usuários.

## Evolução do HTTP

O HTTP é um dos protocolos mais importantes da Internet, pois é responsável por possibilitar a comunicação na web. Ele começou como um protocolo baseado em texto nas três primeiras versões: 0.9, 1.0 e 1.1. Com sua capacidade de extensibilidade, o HTTP/1.1 foi a versão predominante do HTTP por 15 anos, até 2015.

O HTTP/2 representou um marco importante na evolução do HTTP, pois passou de um protocolo baseado em texto para um baseado em binário. Enquanto o HTTP/1.1 suporta apenas trocas de solicitação e resposta de forma serial, o HTTP/2 suporta concorrência. Clientes e servidores representam solicitações e respostas como fluxos de quadros binários. Os fluxos têm identificadores exclusivos, o que permite que os quadros sejam multiplexados e intercalados.

A versão mais recente do HTTP é o HTTP/3, que foi recentemente <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9114.html">padronizado pelo IETF em junho de 2022</a>. Embora o HTTP/3 implemente as mesmas funcionalidades do HTTP/2, há uma diferença fundamental em como ele é transportado pela internet. O HTTP/3 é construído em cima do QUIC, um protocolo baseado em UDP, o que ameniza alguns dos problemas de desempenho que o HTTP/2 pode enfrentar em uma rede com perda de pacotes.

## Adoção do HTTP/2

Com diversas versões do HTTP introduzidas ao longo dos anos, começamos descrevendo o estado atual da adoção das versões do HTTP. Medimos o uso das versões do HTTP considerando todos os recursos no conjunto de dados do Web Almanac de 2022 e identificamos em qual versão do HTTP cada recurso foi servido.

Entretanto, com a nossa configuração, não é trivial contar com precisão os recursos entregues através do HTTP/3, pois os clientes precisam descobrir o suporte para o HTTP/3, geralmente através do [cabeçalho de resposta HTTP  `alt-svc`](https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Headers/Alt-Svc). No entanto, no momento em que o cliente recebe o cabeçalho `alt-svc`, ele já completou a negociação do protocolo para o HTTP/1.1 ou HTTP/2. Somente após esse ponto, o cliente pode atualizar o protocolo para o HTTP/3 em solicitações subsequentes ou carregamentos de página. Como resultado, nossos dados nunca capturam um carregamento completo de página usando o HTTP/3.

Com a descoberta do HTTP/3 sendo tão atrasada por meio do mecanismo do cabeçalho HTTP `alt-svc` , nossas medições podem subestimar os recursos que seriam entregues através do HTTP/3 para os usuários de navegação normal. Portanto, agrupamos os recursos entregues através do HTTP/2 e HTTP/3 juntos como HTTP/2+.

{{ figure_markup(
  image="http2-adoption-per-request.png",
  caption="Adoção do HTTP/2 e acima como porcentagem das solicitações.",
  description="A adoção do HTTP/2 e versões posteriores é muito alta. Em junho de 2022, 77% das solicitações foram atendidas utilizando o HTTP/2 e versões superiores tanto em ambientes de desktop quanto em dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=109625269&format=interactive",
  sheets_gid="1707754058",
  sql_file="h2_adoption_pages_reqs.sql"
  )
}}

Primeiramente, para entender o cenário atual, medimos a prevalência da adoção do HTTP/2+. Em junho de 2022, observamos que cerca de 77% das solicitações em nossas cargas usavam o HTTP/2+. Isso representa um aumento de [5% na adoção do HTTP/2+ em relação a julho de 2021](../2021/http#adoption-by-request), quando observamos que 73% das solicitações estavam no HTTP/2+.

{{ figure_markup(
  image="http2-adoption-per-site.png",
  caption="A adoção do HTTP/2 e versões superiores como porcentagem de sites.",
  description="66% dos sites em junho de 2022 foram servidos utilizando o HTTP/2 ou versões superiores tanto nas configurações de desktop quanto nas de dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=328815423&format=interactive",
  sheets_gid="1707754058",
  sql_file="h2_adoption_pages_reqs.sql"
  )
}}

Com o aumento na adoção do HTTP/2+, gostaríamos de entender os fatores que impulsionam esse aumento. Primeiro, analisamos a adoção do HTTP/2+ em granularidade por site, verificando se a página de entrada do site foi servida no HTTP/2+. Observamos que aproximadamente 66% dos sites em nosso conjunto de dados, tanto em configurações de desktop quanto em dispositivos móveis, foram servidos no HTTP/2+, enquanto que isso era verdade para [aproximadamente 60% dos sites em nosso conjunto de dados em 2021](../2021/http#adoption-of-http2). Esse aumento é uma tendência positiva que sugere que os sites estão prontos e se movendo em direção a uma versão atualizada do HTTP.

{{ figure_markup(
  image="http2-adoption-per-cdn.png",
  caption="A adoção do HTTP/2 e acima como porcentagem das solicitações atendidas por um CDN.",
  description="Tanto nas configurações de desktop quanto em dispositivos móveis, 95% das solicitações atendidas por um CDN foram feitas usando o HTTP/2 ou versões superiores. Isso sugere que o CDN é o principal impulsionador para o aumento da adoção do HTTP/2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=1268139215&format=interactive",
  sheets_gid="427272739",
  sql_file="h2_adoption_by_cdn_pct.sql"
  )
}}

Outro fator que possibilita a adoção do HTTP/2+ são os recursos servidos a partir de um CDN. Semelhante à observação em nossa [análise de 2021](../2021/http#adoption-by-cdns), notamos que a maioria dos recursos servidos a partir de um CDN estava no HTTP/2+. A figura acima mostra que 95% das solicitações atendidas a partir do CDN foram entregues no HTTP/2+.

## Benefícios do HTTP/2 e HTTP/3

A seguir, concentramos nossa atenção em como os recursos que o HTTP/2 introduziu estão sendo adotados. Nós nos concentramos principalmente em três conceitos notáveis: _multiplexação_ de solicitações em uma única conexão de rede, _priorização_ de recursos, e _HTTP/2 Push_.

### Multiplexação de solicitações em uma única conexão

Uma característica importante do HTTP/2 é a multiplexação de solicitações em uma única conexão TCP. Isso representa uma melhoria significativa em relação às versões anteriores do HTTP, onde apenas uma solicitação concorrente é permitida em uma conexão TCP e, na maioria dos casos, apenas seis conexões TCP paralelas são permitidas para um nome de host. O HTTP/2 introduz o conceito de stream, uma representação lógica de uma conexão que é usada para a entrega de recursos. Múltiplos streams do HTTP/2 podem então ser multiplexados em uma única conexão TCP, eliminando assim as limitações de concorrência por conexão.

Uma implicação da multiplexação de solicitações em uma única conexão TCP é a redução das conexões necessárias durante o carregamento de páginas. Semelhante às [nossas descobertas em 2021](../2021/http#number-of-connections), páginas com suporte a HTTP/2 têm menos conexões do que páginas que não têm HTTP/2 ativado.

{{ figure_markup(
  image="connections-comparison-per-page.png",
  caption="Conexões usadas por página por versão do HTTP.",
  description="Gráfico de colunas mostrando o número de conexões utilizadas por página por versão do HTTP e percentil. Em todos os percentis, as páginas HTTP/2+ usam menos conexões. No percentil 10, são 6 para o HTTP/1.1 e 4 para o HTTP/2+; no percentil 25, são 9 e 7, respectivamente; no percentil 50, são 15 contra 12; no percentil 75, são 23 contra 20; e no percentil 90, são 38 contra 32.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=461867891&format=interactive",
  sheets_gid="901907129",
  sql_file="connections_per_page_load_dist.sql"
  )
}}

A figura acima mostra que a mediana das páginas móveis possui 12 conexões estabelecidas durante o carregamento da página quando o HTTP/2 está ativado. Em contraste, a página mediana sem o HTTP/2 possui 15 conexões estabelecidas, representando um acréscimo de 3 conexões adicionais. No entanto, esse acréscimo se torna ainda maior em percentis mais altos. A página no percentil 90 com o HTTP/2 ativado possui 32 conexões, enquanto a página no percentil 90 sem o HTTP/2 ativado possui 38 conexões, representando um acréscimo de 6 conexões adicionais. Essas tendências são as mesmas entre as versões de sites para desktop e móvel.

Dado que observamos um aumento na adoção do HTTP/2 ao longo do ano, não é surpreendente que o número total de conexões TCP tenha diminuído gradualmente ao longo dos anos. <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#tcp">Uma visão longitudinal do HTTP Archive </a> mostra que o número médio de conexões estabelecidas diminuiu em 9 conexões, passando de 22 conexões em 2017 para 13 conexões em 2022.

### Priorização de recursos

Com o HTTP/2, os clientes podem <a hreflang="en" href="https://stackoverflow.com/questions/36517829/what-does-multiplexing-mean-in-http-2/36519379#36519379">multiplexar</a> várias solicitações na mesma conexão. Uma implicação disso é que isso pode afetar negativamente a entrega de recursos que bloqueiam a renderização se muitos recursos estiverem sendo transmitidos simultaneamente. Isso pode resultar em uma experiência do usuário ruim. Em sua  <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc7540#page-25">specificação original</a>, o HTTP/2 tentou resolver esse problema propondo uma árvore de prioridade que os clientes constroem durante o carregamento da página e que os servidores web podem usar para priorizar o envio de respostas mais importantes.  No entanto, esse método é difícil de usar e muitos servidores web e CDNs <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">não o implementaram corretamente ou simplesmente o ignoraram</a>. Por causa disso, em uma <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9113.html#section-5.3">iteração posterior do HTTP/2</a> foi sugerido que um esquema diferente deveria ser utilizado.

Com os desafios das prioridades do HTTP/2, foi necessário um novo esquema de priorização. O <a hreflang="en" href="https://httpwg.org/specs/rfc9218.html">Esquema de Priorização Extensível para HTTP</a> foi desenvolvido separadamente do HTTP/3 e foi padronizado em junho de 2022. Nesse esquema, os clientes podem atribuir explicitamente uma prioridade composta por dois parâmetros através do cabeçalho HTTP `priority` ou do quadro `PRIORITY_UPDATE`.  O primeiro parâmetro, `urgency`,  indica ao servidor a prioridade do recurso solicitado. O segundo parâmetro, `incremental`, informa ao servidor se um recurso pode ser parcialmente utilizado no cliente (por exemplo, exibindo parcialmente uma imagem à medida que partes dela chegam). Definir o esquema como um cabeçalho HTTP e como o quadro `PRIORITY_UPDATE` torna-o extensível, pois ambos os formatos foram projetados para fornecer extensibilidade futura. No momento da escrita, o esquema foi implementado para HTTP/3 no Safari, Firefox e Chrome.

Embora a maioria das prioridades de recursos seja decidida pelo próprio navegador, os desenvolvedores agora também podem usar as novas <a hreflang="en" href="https://web.dev/articles/fetch-priority">dicas de prioridade</a> para ajustar a prioridade de um recurso específico. As dicas de prioridade podem ser especificadas através do atributo `fetchpriority` no HTML. Por exemplo, suponha que um site queira dar prioridade a uma imagem de destaque, ele pode adicionar o atributo `fetchpriority` à tag da imagem:

```html
<img src="hero.png" fetchpriority="high">
```

As dicas de prioridade podem ser muito eficazes para melhorar a experiência do usuário. Por exemplo, o <a hreflang="en" href="https://www.etsy.com/codeascraft/priority-hints-what-your-browser-doesnt-know-yet">Etsy conduziu um experimento</a> e observou uma melhoria de 4% no Maior Conteúdo Pintado (Largest Contentful Paint - LCP) em páginas de listagem de produtos que incluíam dicas de prioridade para certas imagens.

{{ figure_markup(
  caption="Páginas móveis utilizando Dicas de Prioridade.",
  content="1.2%",
  classes="big-number",
  sheets_gid="1067615125",
  sql_file="priority_hints_usage.sql"
)
}}

Embora as Dicas de Prioridade tenham sido lançadas recentemente no final de abril de 2022 como parte do Chrome 101, elas têm uma adoção muito promissora, pois observamos que aproximadamente 1% das páginas da web para desktop e 1,2% das páginas da web para dispositivos móveis já adotaram as dicas de prioridade em agosto de 2022. Com seu potencial para melhorar a experiência do usuário com relativa facilidade, pode ser uma boa funcionalidade para experimentar.

### HTTP/2 Push

O HTTP/2 Push permite que os servidores da web enviem antecipadamente uma resposta para uma solicitação antes mesmo que essa solicitação seja enviada pelo cliente. Por exemplo, um provedor de site pode enviar de forma preemptiva um recurso que será usado durante o carregamento de uma página para o usuário final, juntamente com o HTML principal.

{{ figure_markup(
  image="h2-push-usage.png",
  caption="Uso do HTTP/2 Push.",
  description="Gráfico de colunas mostrando o uso do HTTP/2 Push em desktop e dispositivos móveis em julho de 2021 e junho de 2022. Para desktop, esse uso caiu de 1,04% para 0,71%. Para dispositivos móveis, esse uso caiu de 1,26% para 0,66%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=1440772038&format=interactive",
  sheets_gid="1278005075",
  sql_file="h2_h3_pushed.sql"
  )
}}

Em 2021, como mostrado no gráfico acima, o percentual de sites que utilizavam o HTTP/2 Push era muito baixo, atingindo 1,26% para dispositivos móveis. No entanto, na análise deste ano, o número de sites que utilizam o Push diminuiu para 0,66% para sites móveis. Isso representa a primeira redução no uso do Push desde 2020.

A diminuição no uso do Push provavelmente ocorre porque <a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">é difícil utilizá-lo de forma eficaz</a>. Por exemplo, os sites não podem saber com precisão se um recurso que está sendo empurrado já existe no cache do cliente. Se estiver no cache do cliente, a largura de banda utilizada para empurrar o recurso será desperdiçada.

Com as dificuldades encontradas, O <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/ho4qP49oAwAJ">Chrome decidiu depreciar o HTTP/2 Push</a> a partir da <a hreflang="en" href="https://developer.chrome.com/blog/removing-push">Chrome versão 106</a>. Apesar de o push ainda ser oficialmente parte do padrão HTTP/3, o Chrome - que é utilizado pelo rastreador HTTP Archive - nunca implementou o push para conexões HTTP/3, o que pode explicar ainda mais a redução do uso, já que os sites migraram para essa versão e perderam a capacidade de empurrar recursos.

### Alternativas ao HTTP/2 Push

Dadas as dificuldades de uso do HTTP/2 Push e sua depreciação no Chrome, os desenvolvedores podem estar se perguntando sobre alternativas.

#### Pré-carregamento (Preload)

Os desenvolvedores podem usar o Pré-carregamento (Preload) como uma alternativa para solicitar previamente um recurso que será usado posteriormente durante o carregamento de uma página. Isso é habilitado incluindo[`<link rel="preload">`](https://developer.mozilla.org/docs/Web/HTML/Link_types/preload) na seção `<head>` do HTML. Por exemplo:

```html
<link rel="preload" href="/css/style.css" as="style">
```

Ou como um cabeçalho HTTP `Link`:

```
Link: </css/style.css>; rel="preload"; as="style"
```

Ambas as opções permitem que os servidores web incluam URLs adicionais ou recursos importantes. O cliente pode, então, enviar solicitações para as URLs fornecidas antes que os recursos sejam normalmente descobertos durante o carregamento da página.

Embora não seja tão rápido quanto o envio proativo de recursos, essa abordagem é muito mais segura, permitindo que o navegador escolha se deseja buscar esses recursos ou não, por exemplo, se já possui uma cópia em cache.

{{ figure_markup(
  caption='Páginas que utilizam a tag `<link rel="preload">`.',
  content="25%",
  classes="big-number",
  sheets_gid="2036031560",
  sql_file="sites_using_link_preload_header.sql"
)
}}

Observamos que um grande número de páginas em nosso conjunto de dados inclui a tag `<link rel="preload">`, aproximadamente 25% em ambos os ambientes, desktop e mobile.

#### 103 Early Hints

In 2017, theEm 2017, o  <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8297">código de status 103 Early Hints foi proposto</a> e o <a hreflang="en" href="https://developer.chrome.com/blog/early-hints">Chrome adicionou suporte para ele este ano.</a>.

As dicas antecipadas (Early Hints) podem ser usadas para enviar respostas HTTP intermediárias antes da resposta final do objeto solicitado. Elas podem melhorar o desempenho ao aproveitar o fato de que os servidores web frequentemente precisam de algum tempo para preparar uma resposta, especialmente para o documento HTML principal, se ele for renderizado dinamicamente.

Um caso de uso das dicas antecipadas (Early Hints) é fornecer `Link: rel="preload"` para recursos a serem buscados antecipadamente ou `Link: rel="preconnect"` para conexões prévias a outros domínios. Outros cabeçalhos também podem ser conceitualmente transmitidos, embora isso ainda não seja suportado por nenhum navegador.

As dicas antecipadas (Early Hints) podem ser uma alternativa melhor do que o push, pois os clientes têm maior controle sobre como os recursos são buscados, mas ainda permitem uma melhoria apenas adicionando pré-carregamentos (preloads) e pré-conexões (preconnects) ao HTML do documento principal. Além disso, as dicas antecipadas têm o potencial de serem usadas para recursos de terceiros, o que não era possível com o push, embora, novamente, <a hreflang="en" href="https://developer.chrome.com/blog/early-hints#current-limitations">isso ainda não seja suportado em nenhum navegador atualmente</a>.

{{ figure_markup(
  caption="Páginas para desktop usando 103 Early Hints.",
  content="1.6%",
  classes="big-number",
  sheets_gid="187640264",
  sql_file="early_hints_usage.sql"
)
}}

Existem estudos mostrando que a adoção de "Early Hints" pode melhorar a experiência do usuário. Por exemplo, o <a hreflang="en" href="https://blog.cloudflare.com/early-hints-performance/">Shopify observou melhorias de 20-30% no LCP (Largest Contentful Paint)</a> em seu estudo de laboratório. Observamos que aproximadamente 1,6% dos sites em nosso conjunto de dados já adotaram "Early Hints", mesmo nessa fase inicial, e a maioria da adoção (1,5%) vem de sites que estão sendo executados na plataforma do Shopify.

Com 25% dos sites incluindo `<link rel="preload">` na resposta da página, há um grande potencial para converter esses nós de link em "Early Hints" (Dicas Antecipadas).

## HTTP/3

No restante desta seção, focaremos no HTTP/3, pois ele representa o futuro do protocolo HTTP e foi <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9114.html">padronizado em junho de 2022</a>. Em particular, exploraremos as melhorias do HTTP/3 em relação às suas versões anteriores e o nível de suporte que ele possui atualmente. Para uma explicação mais detalhada sobre o HTTP/3, você pode consultar <a hreflang="en" href="https://www.smashingmagazine.com/2021/08/http3-core-concepts-part1/">esta excelente série de artigos</a> de [Robin Marx](https://x.com/programmingart), que também ajudou a revisar este capítulo.

### Benefícios do HTTP/3

Embora o HTTP/2 tenha introduzido várias melhorias em relação ao seu predecessor, ainda existem desafios e oportunidades adicionais para o protocolo. Por exemplo, mesmo que a multiplexação de solicitações em uma única conexão TCP tenha aliviado problemas de bloqueio de linha de frente para cada solicitação, a entrega de solicitações usando esse método ainda <a hreflang="en" href="https://calendar.perfplanet.com/2020/head-of-line-blocking-in-quic-and-http-3-the-details/">pode ser ineficiente</a>. Isso ocorre porque pacotes TCP perdidos podem impedir que pacotes TCP corretamente recebidos posteriormente sejam processados até que sua retransmissão chegue, mesmo que o pacote TCP posterior seja para um fluxo HTTP separado. O TCP não tem conceito da multiplexação que ocorre no protocolo HTTP superior e, portanto, bloqueia todos os fluxos.

O HTTP/3 tem como objetivo melhorar as limitações do HTTP/2 e para isso é construído sobre o QUIC, um protocolo de transporte baseado em UDP. O QUIC soluciona o problema de bloqueio de linha de frente do TCP, implementando a entrega confiável de pacotes sobre o UDP em granularidade por fluxo (stream).

### Suporte a HTTP/3

Para anunciar que o HTTP/3 é suportado, os servidores web utilizam o cabeçalho `alt-svc` na resposta HTTP. O valor do cabeçalho `alt-svc` contém uma lista dos protocolos suportados pelo servidor.

{{ figure_markup(
  image="alt-svc-example.png",
  caption="Exemplo de cabeçalho de resposta `alt-svc`.",
  description="Captura de tela mostrando o cabeçalho de resposta  `alt-svc` com suporte a HTTP/3 e os valores `h3`, e `h3-29`.",
  width=417,
  height=267
  )
}}

Por exemplo, em setembro de 2022, o valor do cabeçalho `alt-svc` na resposta para <a hreflang="en" href="https://www.cloudflare.com">https://www.cloudflare.com</a> é `h3=":443"; ma=86400, h3-29=":443"; ma=86400` como mostrado na captura de tela abaixo. Os valores `h3` e `h3-29` indicam que a Cloudflare oferece suporte ao HTTP/3 e ao rascunho 29 do HTTP/3 através da porta UDP 443. Também existe uma proposta para acelerar a descoberta do HTTP/3 como parte da consulta DNS; para mais detalhes, veja <a hreflang="en" href="https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/">este post da Cloudflare</a>.

Nós analisamos a adoção do HTTP/3 identificando um recurso que foi servido através do HTTP/3 ou cujo cabeçalho de resposta continha um cabeçalho `alt-svc` com `h3` ou `h3-29` como um dos protocolos anunciados. Isso nos permite entender se o HTTP/3 poderia ser usado e ignora as limitações mencionadas acima, relacionadas à instância recente executada pelo nosso rastreador, que ainda não viu o cabeçalho `alt-svc`.

{{ figure_markup(
  image="h3-support-per-request.png",
  caption="Suporte ao HTTP/3 em requisições.",
  description="Gráfico de colunas mostrando o suporte ao HTTP/3 em desktops e dispositivos móveis em julho de 2021 e junho de 2022. Em ambos os casos, houve um aumento de 10% para 15%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTsnJP1ulTTc-j9n7CIbGHxO1SaFvmZWMPQnJHrluku254CqKXz_D2fn2Ck54FC-m9135eCFg83NHOc/pubchart?oid=971486939&format=interactive",
  sheets_gid="1456324569",
  sql_file="h3_support.sql"
  )
}}

A figura acima mostra um aumento de 5 pontos percentuais, de 10% para 15%, na porcentagem de solicitações com suporte ao HTTP/3 desde o Web Almanac do ano passado. O mesmo aumento foi observado tanto nas solicitações de desktop quanto nas de dispositivos móveis.

Assim como a adoção do HTTP/2+, a maioria do suporte ao HTTP/3 provém de CDNs (Content Delivery Networks - Redes de Distribuição de Conteúdo). Esperamos que o suporte continue crescendo no futuro, à medida que mais CDNs passem a oferecer suporte ao HTTP/3.

## Conclusão

Este último ano foi um ano agitado para o protocolo HTTP, especialmente com a padronização do HTTP/3. Continuamos a observar uma alta utilização do HTTP/2 e vemos um forte suporte futuro ao HTTP/3 por parte dos servidores web.

Além disso, temos visto um forte crescimento no ecossistema de tecnologias que abordam alguns dos desafios críticos do HTTP/2. O recurso 103 Early Hints oferece uma alternativa mais segura para o Server Push, e seu suporte pelo cliente deu um grande passo à frente com o Chrome agora o apoiando. Um novo padrão para Prioritização HTTP foi finalizado; os principais navegadores e alguns servidores web já o suportam para o HTTP/3. Além disso, os Priority Hints foram adicionados à plataforma web para permitir que os clientes refinem ainda mais a priorização tanto no HTTP/2 quanto no HTTP/3, e os primeiros experimentos têm apresentado melhorias promissoras na experiência do usuário.

Este é um momento empolgante para o protocolo HTTP e para o ecossistema da web. Estamos animados para ver como essas novas tecnologias serão adotadas e quais efeitos elas terão na experiência do usuário.
