---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Comércio eletrônico
description: Capítulo de comércio eletrônico do Web Almanac 2019 que abrange plataformas de comércio eletrônico, cargas úteis, imagens, de terceiros, desempenho, SEO e PWAs.
hero_alt: Hero image of a Web Almanac character at a super market checkout loading items from a shopping basket onto the conveyor belt while another character payes with a credit card.
authors: [samdutton, alankent]
reviewers: [voltek62]
analysts: [rviscomi]
editors: [tunetheweb]
translators: [HakaCode]
discuss: 1768
results: https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/
samdutton_bio: Sam Dutton trabalha com a equipe do Google Chrome como Defensor do desenvolvedor desde 2011. Ele organizou e apresentou em uma série de eventos, criou e ministrou vários cursos de desenvolvimento da web e trabalhou em uma variedade de vídeos, codelabs e orientações escritas sobre PWA, desempenho, mídia, imagem e iniciativas de 'Próximo Bilhão de Usuários'. Ele mantém <a hreflang="en" href="https://simpl.info">simpl.info</a>, que fornece os exemplos mais simples possíveis de HTML, CSS e JavaScript. Sam cresceu na Austrália do Sul, foi para a universidade em Sydney e mora desde 1986 em Londres.
alankent_bio: Alan Kent é um Developer Advocate do Google com foco em e-commerce e ecossistemas de conteúdo. Ele bloga em <a hreflang="en" href="https://alankent.me">alankent.me</a> e tweeta como <a href="https://x.com/akent99">@akent99</a>.
featured_quote: Quase 10% das home pages neste estudo foram encontradas em uma plataforma de comércio eletrônico. Uma "plataforma de comércio eletrônico" é um conjunto de software ou serviços que permite criar e operar uma loja online, incluindo serviços pagos como Shopify, plataformas de software como Magento Open Source e plataformas hospedadas como Magento Commerce.
featured_stat_1: 3.98%
featured_stat_label_1: Sites que usam WooCommerce, a plataforma de comércio eletrônico mais popular
featured_stat_2: 116
featured_stat_label_2: Número de plataformas de comércio eletrônico detectadas
featured_stat_3: 1,517 KB
featured_stat_label_3: Bytes medianos de imagem por página de comércio eletrônico para celular
---

## Introdução

Quase 10% das home pages neste estudo foram encontradas em uma plataforma de comércio eletrônico. Uma “plataforma de comércio eletrônico” é um conjunto de software ou serviços que permite criar e operar uma loja online. Existem vários tipos de plataformas de comércio eletrônico, por exemplo:

- **Serviços pagos** como o <a hreflang="en" href="https://www.shopify.com/">Shopify</a> que hospedam sua loja e ajudam você a começar. Eles fornecem hospedagem de sites, modelos de sites e páginas, gerenciamento de dados de produtos, carrinhos de compras e pagamentos.
- **Plataformas de software**, como <a hreflang="en" href="https://magento.com/products/magento-open-source">Magento Open Source</a> que você mesmo configura, hospeda e gerencia. Essas plataformas podem ser poderosas e flexíveis, mas podem ser mais complexas de configurar e executar do que serviços como o Shopify.
- **Plataformas hospedadas**, como <a hreflang="en" href="https://magento.com/products/magento-commerce">Magento Commerce</a> que oferecem os mesmos recursos que suas contrapartes auto-hospedadas, exceto que a hospedagem é gerenciada como um serviço por um terceiro.

{{ figure_markup(
  caption="Porcentagem de páginas em uma plataforma de comércio eletrônico.",
  content="10%",
  classes="big-number"
)
}}

Essa análise só detectou sites criados em uma plataforma de comércio eletrônico. Isso significa que a maioria das grandes lojas e mercados online - como Amazon, JD e eBay - não estão incluídos aqui. Observe também que os dados aqui são apenas para páginas iniciais: não categorias, produtos ou outras páginas. Saiba mais sobre nossa [metodologia](./methodology).

## Detecção de plataforma

Como verificamos se uma página está em uma plataforma de comércio eletrônico?

A detecção é feita através do [Wappalyzer](./methodology#wappalyzer). é um utilitário de plataforma cruzada que descobre as tecnologias usadas em sites. Ele detecta [sistemas de gerenciamento de conteúdo](./cms), plataformas de comércio eletrônico, servidores da web, estruturas [JavaScript](./javascript), ferramentas [analíticas](./third-parties) e muito mais.

A detecção de página nem sempre é confiável e alguns sites bloqueiam explicitamente a detecção para proteger contra ataques automatizados. Podemos não ser capazes de capturar todos os sites que usam uma plataforma de comércio eletrônico específica, mas estamos confiantes de que aqueles que detectamos estão realmente nessa plataforma.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Mobile</th>
        <th scope="col">Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Páginas de comércio eletrônico</td>
        <td class="numeric">500,595</td>
        <td class="numeric">424,441</td>
      </tr>
      <tr>
        <td>Total de páginas</td>
        <td class="numeric">5,297,442</td>
        <td class="numeric">4,371,973</td>
      </tr>
      <tr>
        <td>Taxa de adoção</td>
        <td class="numeric">9.45%</td>
        <td class="numeric">9.70%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Porcentagem de plataformas de comércio eletrônico detectadas.") }}</figcaption>
</figure>

## Plataformas de comércio eletrônico

<figure>
  <table>
    <thead>
      <tr>
        <th>Plataforma</th>
        <th>Mobile</th>
        <th>Desktop</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">3.98</td>
        <td class="numeric">3.90</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">1.59</td>
        <td class="numeric">1.72</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">1.10</td>
        <td class="numeric">1.24</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">0.91</td>
        <td class="numeric">0.87</td>
      </tr>
      <tr>
        <td>Bigcommerce</td>
        <td class="numeric">0.19</td>
        <td class="numeric">0.22</td>
      </tr>
      <tr>
        <td>Shopware</td>
        <td class="numeric">0.12</td>
        <td class="numeric">0.11</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adoção das seis principais plataformas de comércio eletrônico.") }}</figcaption>
</figure>

Das 116 plataformas de comércio eletrônico detectadas, apenas seis são encontradas em mais de 0,1% dos sites de desktop ou móveis. Observe que esses resultados não mostram variação por país, tamanho do site ou outras métricas semelhantes.

A Figura 13.3 acima mostra que o WooCommerce tem a maior adoção em cerca de 4% dos sites de desktop e móveis. O Shopify é o segundo com cerca de 1,6% de adoção. Magento, PrestaShop, Bigcommerce e Shopware seguem com adoção cada vez menor, aproximando-se de 0,1%.

### Cauda longa

{{ figure_markup(
  image="fig4.png",
  caption="Adoção das principais plataformas de comércio eletrônico.",
  description="Gráfico de barras da adoção das 20 principais plataformas de comércio eletrônico. Consulte a Figura 13.3 acima para obter uma tabela de dados de adoção das seis principais plataformas.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1565776696&format=interactive",
  width=600,
  height=414,
  data_width=600,
  data_height=414
  )
}}

Existem 110 plataformas de comércio eletrônico, cada uma com menos de 0,1% dos sites para desktop ou móveis. Cerca de 60 deles têm menos de 0,01% dos sites para celular ou desktop.

{{ figure_markup(
  image="fig5.png",
  caption="Adoção combinada das seis principais plataformas de comércio eletrônico em comparação com as outras 110 plataformas.",
  description="As seis principais plataformas de comércio eletrônico representam 8% de todos os sites. O restante das 110 plataformas representam apenas 1,5% dos sites. Os resultados para desktop e celular são semelhantes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2093212206&format=interactive",
  width=600,
  height=361,
  data_width=600,
  data_height=361
  )
}}

7,87% de todas as solicitações no celular e 8,06% no desktop são para páginas iniciais em uma das seis principais plataformas de comércio eletrônico. Outros 1,52% das solicitações no celular e 1,59% no desktop são para páginas iniciais nas outras 110 plataformas de comércio eletrônico.

## Comércio eletrônico (todas as plataformas)

No total, 9,7% das páginas para desktop e 9,5% das páginas para celular usaram uma plataforma de comércio eletrônico.

{{ figure_markup(
  image="fig6.png",
  caption="Porcentagem de páginas que usam qualquer plataforma de comércio eletrônico.",
  description="9,7% das páginas para desktop usam uma plataforma de comércio eletrônico e 9,5% das páginas para celular usam uma plataforma de comércio eletrônico.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1360307171&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

Embora a proporção de sites de desktop seja ligeiramente maior no geral, algumas plataformas populares (incluindo WooCommerce, PrestaShop e Shopware) têm, na verdade, mais sites móveis do que sites de desktop.

## Peso da página e solicitações

O [peso da página](./page-weight) de uma plataforma de comércio eletrônico inclui todos os HTML, CSS, JavaScript, JSON, XML, imagens, áudio e vídeo.

{{ figure_markup(
  image="fig7.png",
  caption="Distribuição do peso da página de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 do peso da página de comércio eletrônico. A página média de comércio eletrônico em computadores carrega 2,7 MB. O 10º percentil é 1,0 MB, 25º 1,6 MB, 75º 4,5 MB e 90 7,6 MB. Os sites para desktop são ligeiramente mais altos do que para dispositivos móveis em décimos de megabyte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=448248428&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="Distribuição de solicitações por página de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 das solicitações por página de comércio eletrônico. A página média de comércio eletrônico para desktop faz 108 solicitações. O 10º percentil é 53 solicitações, 25º 76, 75º 153 e 90º 210. Os sites para desktop são ligeiramente mais elevados do que para celular em cerca de 10 solicitações.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1968521689&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

A página média da plataforma de comércio eletrônico para desktop carrega 108 solicitações e 2,7 MB. O peso médio para todas as páginas de desktop é de 74 solicitações e [1.9 MB](./page-weight#page-weight). Em outras palavras, as páginas de comércio eletrônico fazem quase 50% mais solicitações do que outras páginas da web, com cargas em torno de 35% maiores. Em comparação, a página inicial <a hreflang="en" href="https://amazon.com">amazon.com</a> faz cerca de 300 solicitações no primeiro carregamento, para um peso de página de cerca de 5 MB, e o <a hreflang="en" href="https://ebay.com">ebay.com</a> faz cerca de 150 solicitações para um peso de página de aproximadamente 3 MB. O peso da página e o número de solicitações de home pages em plataformas de comércio eletrônico são ligeiramente menores no celular a cada percentil, mas cerca de 10% de todas as home pages de comércio eletrônico carregam mais de 7 MB e fazem mais de 200 solicitações.

Esses dados representam a carga útil da página inicial e as solicitações sem rolagem. Claramente, há uma proporção significativa de sites que parecem estar recuperando mais arquivos (a média é mais de 100), com uma carga útil total maior do que o necessário para o primeiro carregamento. Veja também: [Solicitações de terceiros e bytes](#solicitações-de-terceiros-e-bytes) abaixo.

Precisamos fazer mais pesquisas para entender melhor por que tantas páginas iniciais em plataformas de comércio eletrônico fazem tantas solicitações e têm cargas úteis tão grandes. Os autores veem regularmente home pages em plataformas de comércio eletrônico que fazem centenas de solicitações no primeiro carregamento, com payloads de vários megabytes. Se o número de solicitações e a carga útil são um problema para o desempenho, como podem ser reduzidos?

## Solicitações e carga útil por tipo

Os gráficos abaixo são para solicitações de desktop:

<figure>
  <table>
    <thead>
      <tr>
        <th>Modelo</th>
        <th>10</th>
        <th>25</th>
        <th>50</th>
        <th>75</th>
        <th>90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>imagem</td>
        <td class="numeric">353</td>
        <td class="numeric">728</td>
        <td class="numeric">1,514</td>
        <td class="numeric">3,104</td>
        <td class="numeric">6,010</td>
      </tr>
      <tr>
        <td>vídeo</td>
        <td class="numeric">156</td>
        <td class="numeric">453</td>
        <td class="numeric">1,325</td>
        <td class="numeric">2,935</td>
        <td class="numeric">5,965</td>
      </tr>
      <tr>
        <td>script</td>
        <td class="numeric">199</td>
        <td class="numeric">330</td>
        <td class="numeric">572</td>
        <td class="numeric">915</td>
        <td class="numeric">1,331</td>
      </tr>
      <tr>
        <td>Fonte</td>
        <td class="numeric">47</td>
        <td class="numeric">85</td>
        <td class="numeric">144</td>
        <td class="numeric">226</td>
        <td class="numeric">339</td>
      </tr>
      <tr>
        <td>css</td>
        <td class="numeric">36</td>
        <td class="numeric">59</td>
        <td class="numeric">102</td>
        <td class="numeric">180</td>
        <td class="numeric">306</td>
      </tr>
      <tr>
        <td>html</td>
        <td class="numeric">12</td>
        <td class="numeric">20</td>
        <td class="numeric">36</td>
        <td class="numeric">66</td>
        <td class="numeric">119</td>
      </tr>
      <tr>
        <td>audio</td>
        <td class="numeric">7</td>
        <td class="numeric">7</td>
        <td class="numeric">11</td>
        <td class="numeric">17</td>
        <td class="numeric">140</td>
      </tr>
      <tr>
        <td>xml</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">1</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>outro</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>texto</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
    </tbody>
  </table>
<figcaption>{{ figure_link(caption="Percentis da distribuição do peso da página (em KB) por tipo de recurso.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Modelo</th>
        <th>10</th>
        <th>25</th>
        <th>50</th>
        <th>75</th>
        <th>90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>imagem</td>
        <td class="numeric">16</td>
        <td class="numeric">25</td>
        <td class="numeric">39</td>
        <td class="numeric">62</td>
        <td class="numeric">97</td>
      </tr>
      <tr>
        <td>script</td>
        <td class="numeric">11</td>
        <td class="numeric">21</td>
        <td class="numeric">35</td>
        <td class="numeric">53</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>css</td>
        <td class="numeric">3</td>
        <td class="numeric">6</td>
        <td class="numeric">11</td>
        <td class="numeric">22</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td>Fonte</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
        <td class="numeric">5</td>
        <td class="numeric">8</td>
        <td class="numeric">11</td>
      </tr>
      <tr>
        <td>html</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">7</td>
        <td class="numeric">12</td>
      </tr>
      <tr>
        <td>vídeo</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">5</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>outro</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>texto</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">3</td>
      </tr>
      <tr>
        <td>xml</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">2</td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>audio</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">3</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentis da distribuição de solicitações por página por tipo de recurso.") }}</figcaption>
</figure>

As imagens constituem o maior número de solicitações e a maior proporção de bytes para páginas de comércio eletrônico. A página média de comércio eletrônico para desktop inclui 39 imagens com 1.514 KB (1,5 MB).

O número de solicitações de [JavaScript](./javascript) indica que um melhor empacotamento (e/ou multiplexação [HTTP/2](./http)) pode melhorar o desempenho. Os arquivos JavaScript não são significativamente grandes em termos de bytes totais, mas muitas solicitações separadas são feitas. De acordo com o capítulo [HTTP/2](./http#adoption-of-http2) , mais de 40% das solicitações não são via HTTP/2. Da mesma forma, os arquivos CSS têm o terceiro maior número de solicitações, mas geralmente são pequenos. Mesclar arquivos CSS (e/ou HTTP/2) pode melhorar o desempenho de tais sites. Na experiência dos autores, muitas páginas de comércio eletrônico têm uma alta proporção de CSS e JavaScript não usados.  [Os vídeos](./media) podem exigir um pequeno número de solicitações, mas (não surpreendentemente) consomem uma grande proporção do peso da página, especialmente em sites com cargas úteis pesadas.

## Tamanho da carga HTML

{{ figure_markup(
  image="fig11.png",
  caption="Distribuição de bytes HTML (em KB) por página de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 de bytes HTML por página de comércio eletrônico. A página média de comércio eletrônico para desktop tem 36 KB de HTML. O 10º percentil é 12 KB, 25º 20, 75º 66 e 90º 118. Os sites para desktop têm um pouco mais de bytes HTML do que para dispositivos móveis em 1 ou 2 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=908924961&format=interactive"
  )
}}

Observe que os payloads HTML podem incluir outro código, como JSON, JavaScript ou CSS embutido diretamente na própria marcação, em vez de referenciado como links externos. O tamanho médio da carga útil HTML para páginas de comércio eletrônico é de 34 KB em dispositivos móveis e 36 KB em computadores. No entanto, 10% das páginas de comércio eletrônico têm uma carga útil de HTML de mais de 115 KB.

Os tamanhos da carga útil do HTML móvel não são muito diferentes dos do desktop. Em outras palavras, parece que os sites não estão entregando arquivos HTML significativamente diferentes para dispositivos ou tamanhos de janela de visualização diferentes. Em muitos sites de comércio eletrônico, as cargas úteis de HTML da página inicial são grandes. Não sabemos se isso se deve a um HTML inchado ou a outro código (como JSON) nos arquivos HTML.

## Estatísticas de imagem

{{ figure_markup(
  image="fig12.png",
  caption="Distribuição de bytes de imagem (em KB) por página de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 de bytes de imagem por página de comércio eletrônico. A página média de comércio eletrônico para celular tem 1.517 KB de imagens. O 10º percentil é 318 KB, 25º 703, 75º 3.132 e 90º 5.881. Os sites para computadores e dispositivos móveis têm distribuições semelhantes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=323146848&format=interactive"
  )
}}

{{ figure_markup(
  image="fig13.png",
  caption="Distribuição de solicitações de imagem por página de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 das solicitações de imagem por página de comércio eletrônico. A página média de comércio eletrônico para desktop faz 40 solicitações de imagem. O 10º percentil é 16 solicitações, 25º 25, 75º 62 e 90º 97. A distribuição de desktop é ligeiramente maior do que a de celular em 2 a 10 solicitações em cada percentil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1483037371&format=interactive"
  )
}}

<p class="note">Observe que, como nossa <a href="./methodology">metodologia</a> de coleta de dados não simula as interações do usuário em páginas como clicar ou rolar, as imagens com carregamento lento não seriam representadas nesses resultados.</p>

As Figuras 13.12 e 13.13 acima mostram que a página média de comércio eletrônico tem 37 imagens e uma carga útil de imagens de 1.517 KB no celular, 40 imagens e 1.524 KB no desktop. 10% das páginas iniciais têm 90 ou mais imagens e uma carga útil de imagem de quase 6 MB!

{{ figure_markup(
  caption="O número médio de bytes de imagem por página de comércio eletrônico para celular.",
  content="1,517 KB",
  classes="big-number"
)
}}

Uma proporção significativa de páginas de comércio eletrônico tem cargas úteis de imagem consideráveis ​​e faz um grande número de solicitações de imagem no primeiro carregamento. Consulte o relatório de <a hreflang="en" href="https://httparchive.org/reports/state-of-images">estado de imagens</a> do HTTP Archive's e os capítulos de [mídia](./media) e [peso de página](./page-weight) para obter mais contexto.

Os proprietários de sites desejam que seus sites tenham uma boa aparência em dispositivos modernos. Como resultado, muitos sites oferecem as mesmas imagens de produtos de alta resolução para todos os usuários, _independentemente da resolução ou do tamanho da tela_. Os desenvolvedores podem não estar cientes (ou não querem usar) técnicas responsivas que permitem a entrega eficiente da melhor imagem possível para diferentes usuários. Vale lembrar que imagens de alta resolução podem não necessariamente aumentar as taxas de conversão. Por outro lado, o uso excessivo de imagens pesadas pode afetar a velocidade da página e, portanto, _reduzir_ as taxas de conversão. Na experiência dos autores em análises e eventos de sites, alguns desenvolvedores e outras partes interessadas têm SEO ou outras preocupações sobre o uso de carregamento lento para imagens.

Precisamos fazer mais análises para entender melhor por que alguns sites não estão usando técnicas de imagem responsiva ou carregamento lento. Também precisamos fornecer orientação que ajude as plataformas de comércio eletrônico a entregar belas imagens de maneira confiável para aqueles com dispositivos de última geração e boa conectividade, ao mesmo tempo em que fornece a melhor experiência possível para dispositivos de baixo custo e com conectividade ruim.

## Formatos de imagem populares

{{ figure_markup(
  image="fig15.png",
  caption="Formatos de imagem populares.",
  description="Gráfico de barras mostrando a popularidade de vários formatos de imagem. JPEG é o formato mais popular com 54% das imagens em páginas de comércio eletrônico de desktop. Em seguida estão PNG em 27%, GIF em 14%, SVG em 2% e WebP e ICO em 1% cada.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2108999644&format=interactive"
  )
}}

<p class="note">Observe que alguns serviços de imagem ou CDNs entregarão automaticamente WebP (em vez de JPEG ou PNG) para plataformas que suportam WebP, mesmo para uma URL com sufixo `.jpg` ou `.png`. Por exemplo, <a hreflang="en" href="https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg">IMG_20190113_113201.jpg</a> retorna uma imagem WebP no Chrome. No entanto, a maneira como o HTTP Archive <a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/31a25b9064a365d746d4811a1d6dda516c0e4985/bulktest/batch_lib.inc#L994">detecta o formato da imagem como o texto original é</a> e verificar primeiro as palavras-chave no tipo MIME e, em seguida, recorrer à extensão do arquivo. Isso significa que o formato para imagens com URLs como o acima será fornecido como WebP, uma vez que WebP é suportado pelo HTTP Archive como um agente de usuário.</p>

### PNG

Uma em cada quatro imagens nas páginas de comércio eletrônico são PNG. O alto número de solicitações de PNG de páginas em plataformas de comércio eletrônico é provavelmente para imagens de produtos. Muitos sites de comércio usam PNG com imagens fotográficas para permitir a transparência.

Usar o WebP com um PNG substituto pode ser uma alternativa muito mais eficiente, por meio de um [elemento de imagem](http://simpl.info/picturetype) ou usando a detecção de capacidade do agente do usuário por meio de um serviço de imagem como o <a hreflang="en" href="https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg">Cloudinary</a>.

### WebP

Apenas 1% das imagens em plataformas de comércio eletrônico são WebP, o que corresponde à experiência dos autores em análises de sites e trabalho de parceiros. O WebP é <a hreflang="en" href="https://caniuse.com/#feat=webp">compatível com todos os navegadores modernos, exceto o Safari</a>, e possui bons mecanismos de fallback disponíveis. WebP oferece suporte a transparência e é um formato muito mais eficiente do que PNG para imagens fotográficas (consulte a seção PNG acima).

Nós, como comunidade da web, podemos fornecer melhor orientação / defesa para habilitar a transparência usando WebP com PNG substituto e / ou WebP / JPEG com um fundo de cor sólida. O WebP parece ser raramente usado em plataformas de comércio eletrônico, apesar da disponibilidade de <a hreflang="pt" href="https://web.dev/i18n/pt/serve-images-webp">guias</a> e ferramentas (por exemplo, <a hreflang="en" href="https://squoosh.app/">Squoosh</a> e <a hreflang="en" href="https://developers.google.com/speed/webp/docs/cwebp">cwebp</a>). Precisamos fazer mais pesquisas sobre por que não houve mais adoção do WebP, que agora tem <a hreflang="en" href="https://blog.chromium.org/2010/09/webp-new-image-format-for-web.html">quase 10 anos</a>.

## Dimensões da imagem

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Mobile</th>
        <th scope="colgroup" colspan="2">Desktop</th>
      </tr>
      <tr>
        <th scope="col">Percentile</th>
        <th scope="col">Largura (px)</th>
        <th scope="col">Altura (px)</th>
        <th scope="col">Largura (px)</th>
        <th scope="col">Altura (px)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
        <td class="numeric">16</td>
      </tr>
      <tr>
        <td>25</td>
        <td class="numeric">100</td>
        <td class="numeric">64</td>
        <td class="numeric">100</td>
        <td class="numeric">60</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">247</td>
        <td class="numeric">196</td>
        <td class="numeric">240</td>
        <td class="numeric">192</td>
      </tr>
      <tr>
        <td>75</td>
        <td class="numeric">364</td>
        <td class="numeric">320</td>
        <td class="numeric">400</td>
        <td class="numeric">331</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">693</td>
        <td class="numeric">512</td>
        <td class="numeric">800</td>
        <td class="numeric">546</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribuição das dimensões intrínsecas da imagem (em pixels) por página de comércio eletrônico.") }}</figcaption>
</figure>

As dimensões medianas ('mid-range') para imagens solicitadas por páginas de comércio eletrônico é 247x196 px no celular e 240x192 px no desktop. 10% das imagens solicitadas por páginas de comércio eletrônico têm pelo menos 693x512 px no celular e 800x546 px no desktop. Observe que essas dimensões são os tamanhos intrínsecos das imagens, não o tamanho de exibição.

Dado que as dimensões da imagem em cada percentil até a mediana são semelhantes no celular e no desktop, ou mesmo um pouco _maiores_ no celular em alguns casos, parece que muitos sites não estão entregando diferentes dimensões de imagem para diferentes janelas de visualização ou, em outras palavras, não usando técnicas de imagem responsivas. A entrega de imagens _maiores_ para celular em alguns casos pode (ou não!) Ser explicada por sites que usam dispositivo ou detecção de tela.

Precisamos fazer mais pesquisas sobre por que muitos sites (aparentemente) não estão entregando tamanhos de imagem diferentes para janelas de exibição diferentes.

## Solicitações de terceiros e bytes

Muitos sites - especialmente lojas online - carregam uma quantidade significativa de código e conteúdo de terceiros: para análises, testes A / B, rastreamento do comportamento do cliente, publicidade e suporte de mídia social. O conteúdo de terceiros pode ter um <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript">impacto significativo no desempenho</a>. [Patrick Hulce](https://x.com/patrickhulce)'s <a hreflang="en" href="https://github.com/patrickhulce/third-party-web">third-party-web tool</a> é usado para determinar os pedidos de terceiros para este relatório, e isso é discutido mais no [Terceiros](./third-parties) capítulo.

{{ figure_markup(
  image="fig17.png",
  caption="Distribuição de solicitações de terceiros por página de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 de solicitações de terceiros por página de comércio eletrônico. O número médio de solicitações de terceiros em computadores é 19. Os percentis 10, 25, 75 e 90 são: 4, 9, 34 e 54. A distribuição em computadores é maior em cada percentil do que em dispositivos móveis em apenas 1-2 solicitações.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=865791628&format=interactive"
  )
}}

{{ figure_markup(
  image="fig18.png",
  caption="Distribuição de bytes de terceiros por página de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 de bytes de terceiros por página de comércio eletrônico. O número médio de bytes de terceiros no desktop é 320 KB. Os percentis 10, 25, 75 e 90 são: 42, 129, 651 e 1.071. A distribuição da área de trabalho é maior em cada percentil do que a móvel em 10-30 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=164264869&format=interactive"
  )
}}

A página inicial média ('mid-range') em uma plataforma de comércio eletrônico faz 17 solicitações de conteúdo de terceiros no celular e 19 no desktop. 10% de todas as páginas iniciais em plataformas de comércio eletrônico fazem mais de 50 solicitações de conteúdo de terceiros, com uma carga útil total de mais de 1 MB.

<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript/">Outros estudos</a> indicaram que o conteúdo de terceiros pode ser um grande gargalo de desempenho. Este estudo mostra que 17 ou mais solicitações (50 ou mais para os 10% principais) é a norma para páginas de comércio eletrônico.

## Solicitações de terceiros e carga útil por plataforma

Observe que os gráficos e tabelas abaixo mostram dados apenas para dispositivos móveis.

{{ figure_markup(
  image="fig19.png",
  caption="Distribuição de solicitações de terceiros por página móvel para cada plataforma de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 de solicitações de terceiros por página de comércio eletrônico para cada plataforma. Shopify e Bigcommerce carregam a maioria das solicitações de terceiros nas distribuições em cerca de 40 solicitações na média.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1242665725&format=interactive"
  )
}}

{{ figure_markup(
  image="fig20.png",
  caption="Distribuição de bytes de terceiros (KB) por página móvel para cada plataforma de comércio eletrônico.",
  description="Distribuição dos percentis 10, 25, 50, 75 e 90 de bytes de terceiros (KB) por página de comércio eletrônico para cada plataforma. Shopify e Bigcommerce carregam a maioria dos bytes de terceiros nas distribuições em mais de 1.000 KB na mediana.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1017068803&format=interactive"
  )
}}

Plataformas como Shopify podem estender seus serviços usando JavaScript do lado do cliente, enquanto outras plataformas como Magento usam mais extensões do lado do servidor. Essa diferença na arquitetura afeta as figuras vistas aqui.

Claramente, as páginas em algumas plataformas de comércio eletrônico fazem mais solicitações de conteúdo de terceiros e geram uma carga útil maior de conteúdo de terceiros. Uma análise mais aprofundada pode ser feita sobre o _motivo_ pelo qual as páginas de algumas plataformas fazem mais solicitações e têm cargas úteis de terceiros maiores do que outras.

## Primeira pintura com conteúdo (FCP)

{{ figure_markup(
  image="fig21.png",
  caption="Distribuição média de experiências FCP por plataforma de comércio eletrônico.",
  description="Gráfico de barras da distribuição média de experiências FCP para as seis principais plataformas de comércio eletrônico. WooCommerce tem a maior densidade de experiências lentas de FCP com 43%. O Shopify tem a maior densidade de experiências de FCP rápido com 47%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1341906463&format=interactive"
  )
}}

[O First Contentful Paint](./performance#first-contentful-paint) mede o tempo que leva desde a navegação até que o conteúdo, como texto ou imagem, seja exibido pela primeira vez. Neste contexto, **rápido** significa FCP em menos de um segundo, **lento** significa FCP em 3 segundos ou mais e **moderado** é tudo o que está entre os dois. Observe que o conteúdo e o código de terceiros podem ter um impacto significativo no FCP.

Todas as seis principais plataformas de comércio eletrônico têm pior FCP no celular do que no desktop: menos rápido e mais lento. Observe que o FCP é afetado pela capacidade do dispositivo (capacidade de processamento, memória, etc.), bem como pela conectividade.

Precisamos estabelecer por que o FCP é pior no celular do que no desktop. Quais são as causas: conectividade e/ou capacidade do dispositivo ou outra coisa?

## Pontuações do Progressive Web App (PWA)

Consulte também o [Capítulo sobre PWA](./pwa) para obter mais informações sobre este tópico, além de apenas sites de comércio eletrônico.

{{ figure_markup(
  image="fig22.png",
  caption="Distribution of Lighthouse PWA category scores for mobile ecommerce pages.",
  description="Distribuição das pontuações da categoria PWA do Lighthouse para páginas de comércio eletrônico. Em uma escala de 0 (reprovação) a 1 (perfeito), 40% das páginas obtêm uma pontuação de 0.33. 1% das páginas obtém uma pontuação acima de 0.6.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1148584930&format=interactive"
  )
}}

Mais de 60% das páginas iniciais em plataformas de comércio eletrônico obtêm uma <a hreflang="en" href="https://developers.google.com/web/ilt/pwa/lighthouse-pwa-analysis-tool">pontuação Lighthouse PWA</a> entre 0.25 e 0.35. Menos de 20% das páginas iniciais em plataformas de comércio eletrônico obtêm uma pontuação de mais de 0.5 e menos de 1% das páginas iniciais obtêm uma pontuação superior a 0.6.

O Lighthouse retorna uma pontuação do Progressive Web App (PWA) entre 0 e 1. 0 é a pior pontuação possível e 1 é a melhor. As auditorias do PWA são baseadas na <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist"> Lista de Verificação de Base do PWA</a>, que lista 14 requisitos. O Lighthouse automatizou auditorias para 11 dos 14 requisitos. Os 3 restantes só podem ser testados manualmente. Cada uma das 11 auditorias PWA automatizadas são ponderadas igualmente, de modo que cada uma contribui com aproximadamente 9 pontos para sua pontuação PWA.

Se pelo menos uma das auditorias PWA obtiver uma pontuação nula, o Lighthouse anula a pontuação de toda a categoria PWA. Esse foi o caso de 2,32% das páginas móveis.

Claramente, a maioria das páginas de comércio eletrônico está falhando na maioria das <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist">auditorias de lista de verificação de PWA</a>. Precisamos fazer mais análises para entender melhor quais auditorias estão falhando e por quê.

## Conclusão

Este estudo abrangente do uso do comércio eletrônico mostra alguns dados interessantes e também as grandes variações em sites de comércio eletrônico, mesmo entre aqueles construídos na mesma plataforma de comércio eletrônico. Embora tenhamos entrado em muitos detalhes aqui, há muito mais análises que poderíamos fazer neste espaço. Por exemplo, não obtivemos pontuações de acessibilidade este ano (verifique o [capítulo de acessibilidade](./accessibility) para saber mais sobre isso). Da mesma forma, seria interessante segmentar essas métricas por geografia. Este estudo detectou 246 provedores de anúncios em home pages em plataformas de comércio eletrônico. Estudos adicionais (talvez no Web Almanac do próximo ano?) Poderiam calcular a proporção de sites em plataformas de comércio eletrônico que mostram anúncios. O WooCommerce obteve números muito altos neste estudo, então outra estatística interessante que poderíamos ver no próximo ano é se alguns provedores de hospedagem estão instalando o WooCommerce, mas não o habilitando, causando números inflacionados.
