---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Dicas de recursos
description: Capítulo de dicas de recursos do Web Almanac 2019 que cobre o uso de dns-prefetch, preconnect, preload, prefetch, priority hints, e native lazy loading.
authors: [khempenius]
reviewers: [andydavies, tunetheweb, yoavweiss]
analysts: [rviscomi]
editors: [rviscomi]
translators: [HakaCode]
discuss: 1774
results: https://docs.google.com/spreadsheets/d/14QBP8XGkMRfWRBbWsoHm6oDVPkYhAIIpfxRn4iOkbUU/
khempenius_bio: Katie Hempenius é engenheira da equipe do Chrome, onde trabalha para tornar a web mais rápida.
featured_quote: As dicas de recursos fornecem <em>dicas</em> ao navegador sobre quais recursos serão necessários em breve. A ação que o navegador executa ao receber essa dica irá variar dependendo do tipo de dica de recurso; diferentes dicas de recursos dão início a diferentes ações. Quando usados corretamente, eles podem melhorar o desempenho da página, dando uma vantagem inicial para importantes ações antecipadas.
featured_stat_1: 29%
featured_stat_label_1: Sites usando `dns-prefetch`
featured_stat_2: 88%
featured_stat_label_2: Recursos usando o atributo `as`
featured_stat_3: 0.04%
featured_stat_label_3: Uso de dicas de prioridade
---

## Introdução

<a hreflang="en" href="https://www.w3.org/TR/resource-hints/">As dicas de recursos</a> fornecem "dicas" ao navegador sobre quais recursos serão necessários em breve. A ação que o navegador executa ao receber essa dica irá variar dependendo do tipo de dica de recurso; diferentes dicas de recursos dão início a diferentes ações. Quando usados ​​corretamente, eles podem melhorar o desempenho da página, dando uma vantagem inicial para importantes ações antecipadas.

<a hreflang="en" href="https://youtu.be/YJGCZCaIZkQ?t=1956">Exemplos</a> de melhorias de desempenho como resultado de dicas de recursos incluem:

* O Jabong diminuiu o tempo de interação em 1,5 segundos ao pré-carregar scripts críticos.
* O Barefoot Wine diminuiu o tempo de interação das páginas futuras em 2,7 segundos, obtendo previamente links visíveis.
* O Chrome.com diminuiu a latência em 0,7 segundo ao conectar-se previamente às origens críticas.

Há quatro sugestões de recursos separados suportados pela maioria dos navegadores de hoje: `dns-prefetch`, `preconnect`, `preload`, e `prefetch`.

### `dns-prefetch`

A função de [`dns-prefetch`](https://developer.mozilla.org/en-US/docs/Learn/Performance/dns-prefetch) é iniciar uma pesquisa DNS antecipada. É útil para completar a busca DNS de terceiros. Por exemplo, a pesquisa DNS de um CDN, provedor de fontes ou API de terceiros.

### `preconnect`

<a hreflang="en" href="https://web.dev/uses-rel-preconnect">`preconnect`</a> inicia uma conexão antecipada, incluindo pesquisa DNS, handshake TCP e negociação TLS. Esta dica é útil para estabelecer uma conexão com terceiros. Os usos de `preconnect` são muito semelhantes aos de `dns-prefetch`, mas `preconnect` tem menos suporte entre os navegadores. No entanto, se você não precisa do suporte do IE 11, a pré-conexão provavelmente é uma escolha melhor.

### `preload`

A dica <a hreflang="en" href="https://medium.com/reloading/preload-prefetch-and-priorities-in-chrome-776165961bbf">`preload`</a> inicia uma solicitação antecipada. Isso é útil para carregar recursos importantes que, de outra forma, seriam descobertos tardiamente pelo analisador. Por exemplo, se uma imagem importante só puder ser descoberta depois que o navegador receber e analisar a folha de estilo, pode fazer sentido pré-carregar a imagem.

### `prefetch`

<a hreflang="en" href="https://calendar.perfplanet.com/2018/all-about-prefetching/">`prefetch`</a> inicia uma solicitação de baixa prioridade. É útil para carregar recursos que serão usados ​​no carregamento de página subsequente (em vez de atual). Um uso comum de pré-busca é carregar recursos que o aplicativo  "prevê" que serão usados ​​no próximo carregamento de página. Essas previsões podem ser baseadas em sinais como o movimento do mouse do usuário ou fluxos/jornadas comuns do usuário.

## Sintaxe

97% do uso da dica de recurso dependia do uso da tag [`<link>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link) para especificar uma dica de recurso. Por exemplo:

```html
<link rel="prefetch" href="shopping-cart.js">
```

Apenas 3% do uso de dicas de recursos usaram [HTTP headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link) para especificar dicas de recursos. Por exemplo:

```
Link: <https://example.com/shopping-cart.js>; rel=prefetch
```

Como o uso de dicas de recursos em cabeçalhos HTTP é muito baixo, o restante deste capítulo se concentrará exclusivamente na análise do uso de dicas de recursos em conjunto com a tag `<link>`. No entanto, é importante notar que, nos próximos anos, o uso de dicas de recursos em cabeçalhos HTTP pode aumentar à medida que o [HTTP/2 Push](./http#http2-push) for adotado. Isso se deve ao fato de que o HTTP/2 Push redirecionou o `Link` cabeçalho de pré-carregamento HTTP como um sinal para enviar recursos.

## Dicas de recursos

<p class="note">Observação: não houve diferença perceptível entre os padrões de uso de dicas de recursos em dispositivos móveis e computadores. Assim, para fins de concisão, este capítulo inclui apenas as estatísticas para dispositivos móveis.</p>

<figure>
  <table>
    <tr>
     <th>Dica de recurso</th>
     <th>Uso (porcentagem de sites)</th>
    </tr>
    <tr>
     <td><code>dns-prefetch</code>
     </td>
     <td>29%
     </td>
    </tr>
    <tr>
     <td><code>preload</code>
     </td>
     <td>16%
     </td>
    </tr>
    <tr>
     <td><code>preconnect</code>
     </td>
     <td>4%
     </td>
    </tr>
    <tr>
     <td><code>prefetch</code>
     </td>
     <td>3%
     </td>
    </tr>
    <tr>
     <td><code>prerender</code> (descontinuada)
     </td>
     <td>0.13%
     </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Adoção de dicas de recursos.") }}</figcaption>
</figure>

A popularidade relativa de `dns-prefetch` não é surpreendente; é uma API bem estabelecida (apareceu pela primeira vez em <a hreflang="en" href="https://caniuse.com/#feat=link-rel-dns-prefetch">2009</a>), é suportada por todos os principais navegadores e é a mais "barata" de todas as dicas de recursos. Como `dns-prefetch` executa apenas pesquisas de DNS, ele consome muito poucos dados e, portanto, há muito poucas desvantagens em usá-lo. `dns-prefetch` é mais útil em situações de alta latência.

Dito isso, se um site não precisa ser compatível com o IE11 e versões anteriores, alternar `dns-prefetch` para `preconnect` é provavelmente uma boa ideia. Em uma era em que o HTTPS é onipresente, `preconnect` produz maiores melhorias de [performance](./performance) e ainda é barato. Observe que `dns-prefetch`, ao contrário de `preconnect` não apenas inicia a pesquisa DNS, mas também o handshake TCP e a negociação TLS. A <a hreflang="en" href="https://knowledge.digicert.com/solution/SO16297.html">certificate chain</a> é baixada durante a negociação TLS e isso normalmente custa alguns kilobytes.

`prefetch` é usado por 3% dos sites, tornando-se a dica de recurso menos amplamente usada. Esse baixo uso pode ser explicado pelo fato de que `prefetch` é útil para melhorar os carregamentos de página subsequentes-em vez de atuais. Assim, será esquecido se um site está focado apenas na melhoria de sua landing page, ou no desempenho da primeira página visualizada.

<figure>
  <table>
    <tr>
     <th>Dica de recurso</th>
     <th>Dicas de recursos por página:<br>mediana</th>
     <th>Dicas de recursos por página:<br>90th percentil</th>
    </tr>
    <tr>
     <td><code>dns-prefetch</code>
     </td>
     <td>2
     </td>
     <td>8
     </td>
    </tr>
    <tr>
     <td><code>preload</code>
     </td>
     <td>2
     </td>
     <td>4
     </td>
    </tr>
    <tr>
     <td><code>preconnect</code>
     </td>
     <td>2
     </td>
     <td>8
     </td>
    </tr>
    <tr>
     <td><code>prefetch</code>
     </td>
     <td>1
     </td>
     <td>3
     </td>
    </tr>
    <tr>
     <td><code>prerender</code> (descontinuada)
     </td>
     <td>1
     </td>
     <td>1
     </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="A mediana e o 90 percentil do número de dicas de recursos usadas por página, de todas as páginas que usam essa dica de recursos.") }}</figcaption>
</figure>

As dicas de recursos são mais eficazes quando usadas seletivamente (_"quando tudo é importante, nada é"_). A Figura 19.2 acima mostra o número de dicas de recursos por página para páginas que usam pelo menos uma dica de recursos. Embora não haja uma regra clara para definir o que é um número apropriado de dicas de recursos, parece que a maioria dos sites está usando dicas de recursos de forma adequada.

## O atributo `crossorigin`

A maioria dos recursos "tradicionais" obtidos na web ([images](./media), [stylesheets](./css), e [scripts](./javascript)) são obtidos sem a opção de Compartilhamento de recursos entre origens ([CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)). Isso significa que se esses recursos forem obtidos de um servidor de cross-origin, por padrão, seu conteúdo não pode ser lido de volta pela página, devido à política de mesma origem.

Em alguns casos, a página pode optar por buscar o recurso usando CORS se precisar ler seu conteúdo. O CORS permite que o navegador "peça permissão" e obtenha acesso a esses recursos de origem cruzada.

Para tipos de recursos mais novos (por exemplo, fontes, solicitações `fetch()`, módulos ES), o padrão do navegador é solicitar esses recursos usando CORS, falhando totalmente nas solicitações se o servidor não conceder permissão para acessá-los.

<figure>
  <table>
    <tr>
     <th><code>crossorigin</code> valor</th>
     <th>Uso</th>
     <th>Explicação</th>
    </tr>
    <tr>
     <td>Não configurado
     </td>
     <td>92%
     </td>
     <td>Se o atributo crossorigin estiver ausente, a solicitação seguirá a política de origem única.
     </td>
    </tr>
    <tr>
     <td>anônimo (ou equivalente)
     </td>
     <td>7%
     </td>
     <td>Executa uma solicitação de cross-origin que não inclui credenciais.
     </td>
    </tr>
    <tr>
     <td>use-credentials
     </td>
     <td>0.47%
     </td>
     <td>Executa uma solicitação de cross-origin que inclui credenciais.
     </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Adoção do atributo <code>crossorigin</code> como um percentual das instâncias de dica de recursos.") }}</figcaption>
</figure>

No contexto de dicas de recursos, o uso do atributo `crossorigin` permite que eles correspondam ao modo CORS dos recursos aos quais devem corresponder e indica as credenciais a serem incluídas na solicitação. Por exemplo, `anonymous` ativa o CORS e indica que nenhuma credencial deve ser incluída para essas solicitações de origem cruzada:

```html
<link rel="prefetch" href="https://other-server.com/shopping-cart.css" crossorigin="anonymous">
```

Embora outros elementos HTML suportem o atributo crossorigin, esta análise apenas considera o uso com dicas de recursos.

## O atributo `as`

`as` é um atributo que deve ser usado com a dica do recurso `preload` para informar ao navegador o tipo (por exemplo, imagem, script, estilo, etc.) de recurso solicitado. Isso ajuda o navegador a priorizar corretamente a solicitação e a aplicar a Política de Segurança de Conteúdo (<a hreflang="en" href="https://developers.google.com/web/fundamentals/security/csp">CSP</a>). CSP é um mecanismo de [segurança](./security), expresso via cabeçalho HTTP, que ajuda a mitigar o impacto de XSS e outros ataques maliciosos, declarando uma lista segura de fontes confiáveis; apenas o conteúdo dessas fontes pode ser processado ou executado.

{{ figure_markup(
  caption="A porcentagem de instâncias de dicas de recursos usando o atributo <code>as</code>.",
  content="88%",
  classes="big-number"
)
}}

88% das instâncias de dicas de recursos usam o atributo `as`. Quando `as` é especificado, é predominantemente usado para scripts: 92% do uso é para scripts, 3% para fontes e 3% para estilos. Isso não é surpreendente, dado o papel proeminente que os scripts desempenham na arquitetura da maioria dos sites, bem como a alta frequência com que os scripts são usados ​​como vetores de ataque (tornando, portanto, particularmente importante que os scripts obtenham o CSP correto aplicado a eles).

## O futuro

No momento, não há propostas para expandir o conjunto atual de dicas de recursos. No entanto, dicas de prioridade e carregamento lento nativo são duas tecnologias propostas que são semelhantes em espírito às dicas de recursos, pois fornecem APIs para otimizar o processo de carregamento.

### Dicas de prioridade

<a hreflang="en" href="https://wicg.github.io/priority-hints/">Sugestões prioritárias</a> são uma API para expressar a prioridade de busca de um recurso: `high`, `low`, ou `auto`. Eles podem ser usados ​​com uma ampla variedade de tags HTML: especificamente `<image>`, `<link`>, `<script>`, e `<iframe>`.

<figure class="figure-block">
<div class="code-block floating-card">
  <pre role="region" aria-label="Code 0" tabindex="0"><code>&lt;carousel>
  &lt;img src="cat1.jpg" importance="high">
  &lt;img src="cat2.jpg" importance="low">
  &lt;img src="cat3.jpg" importance="low">
&lt;/carousel></code></pre></div>
<figcaption>{{ figure_link(caption="HTML de exemplo de uso de dicas de prioridade em um carrossel de imagens.") }}</figcaption>
</figure>

Por exemplo, se você tivesse um carrossel de imagens, as dicas de prioridade poderiam ser usadas para priorizar a imagem que os usuários veem imediatamente e diminuir a prioridade das imagens posteriores.

{{ figure_markup(
  caption="A taxa de adoção da dica de prioridade.",
  content="0.04%",
  classes="big-number"
)
}}

Dicas de prioridade são <a hreflang="en" href="https://www.chromestatus.com/feature/5273474901737472">implementadas</a> e podem ser testadas por meio de um sinalizador de recurso nas versões 70 e superiores dos navegadores Chromium. Dado que ainda é uma tecnologia experimental, não é surpreendente que seja usada apenas por 0,04% dos sites.

85% do uso de dica de prioridade é com tags `<img>`. As dicas de prioridade são usadas principalmente para diminuir a prioridade de recursos: 72% do uso é `importance="low"`; 28% do uso é  `importance="high"`.

### Native lazy loading

<a hreflang="en" href="https://web.dev/native-lazy-loading">O carregamento lento nativo</a> é uma API nativa para adiar o carregamento de imagens e iframes fora da tela. Isso libera recursos durante o carregamento inicial da página e evita o carregamento de ativos que nunca são usados. Anteriormente, essa técnica só podia ser alcançada por meio de bibliotecas [JavaScript](./javascript) de terceiros.

A API para carregamento lento nativa parece com isso: `<img src="cat.jpg" loading="lazy">`.

O carregamento lento nativo está disponível em navegadores baseados no Chromium 76 e superior. A API foi anunciada tarde demais para ser incluída no conjunto de dados do Web Almanac deste ano, mas é algo para ficar de olho no próximo ano.

## Conclusão

No geral, esses dados parecem sugerir que ainda há espaço para adoção adicional de dicas de recursos. A maioria dos sites se beneficiaria com a adoção e/ou troca `preconnect` de `dns-prefetch`. Um subconjunto muito menor de sites se beneficiaria com a adoção `prefetch` e/ou `preload`. Há uma nuance maior no uso bem-sucedido de `prefetch` e `preload`, o que restringe sua adoção até certo ponto, mas a recompensa potencial também é maior. O push HTTP / 2 e o amadurecimento das tecnologias de aprendizado de máquina também podem aumentar a adoção de `preload` e `prefetch`.
