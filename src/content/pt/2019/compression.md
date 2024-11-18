---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Compressão
description: Capítulo de compressão do Web Almanac de 2019 acerca de compressão HTTP, algoritmos, tipos de conteúdo, compressão própria ou por terceiros e oportunidades.
hero_alt: Hero image of Web Almanac characters using a ray gun to shrink an HTML page to make it much smaller.
authors: [paulcalvano]
reviewers: [foxdavidj, yoavweiss]
analysts: [paulcalvano]
editors: [tunetheweb]
translators: [soulcorrosion]
discuss: 1770
results: https://docs.google.com/spreadsheets/d/1IK9kaScQr_sJUwZnWMiJcmHEYJV292C9DwCfXH6a50o/
paulcalvano_bio: Paul Calvano é um arquiteto de Performance Web na <a hreflang="en" href="https://www.akamai.com/">Akamai</a>, onde ajuda empresas a melhorarem o desempenho dos seus sites. Ele é também umas das pessoas que mantém o projeto HTTP Archive. Você pode encontrá-lo no Twitter em <a href="https://x.com/paulcalvano">@paulcalvano</a>, escrevendo no seu blog <a hreflang="en" href="https://paulcalvano.com">http://paulcalvano.com</a> e compartilhando pesquisas do HTTP Archive em <a hreflang="en" href="https://discuss.httparchive.org">https://discuss.httparchive.org</a>.
featured_quote: A compressão HTTP é uma técnica que permite codificar informação usando menos bits que a represantação original. Quando é usado para entrega de conteúdo web, isso permite a servidores web reduzir a quantidade de dados transmitodos aos clientes. Isto aumenta a eficiência da largura de banda disponível do cliente, reduz o peso da página e melhora o seu desempenho.
featured_stat_1: 38%
featured_stat_label_1: Respostas HTTP que usam compressão baseada em texto
featured_stat_2: 80%
featured_stat_label_2: Uso da compressão Gzip
featured_stat_3: 56%
featured_stat_label_3: Respostas HTML sem compressão
---

## Introdução

A compressão HTTP é uma técnica que permite codificar informação usando menos bits que a representação original. Quando é usado para entrega de conteúdo web, isso permite a servidores web reduzir a quantidade de dados transmitidos aos clientes. Isto aumenta a eficiência da largura de banda disponível do cliente, reduz o [peso da página](./page-weight) e melhora o seu [desempenho](./performance).

Algoritmos de compressão são muitas vezes categorizados como podendo ter ou não perdas:

* Quando um algoritmo de compressão com perdas é usado, o processo é irreversível e o arquivo original não pode ser restaurado através de descompressão. É uma prática comum para comprimir recursos mídia, tais como imagens e vídeos onde perder alguns dados não irá materialmente afetar o recurso.
* A compressão sem perdas é um processo totalmente reversível sendo, tipicamente, usado em recursos do tipo texto, como [HTML](./markup), [JavaScript](./javascript), [CSS](./css), etc.

Neste capítulo, vamos explorar como conteúdo de texto é comprimido na web. Análise de conteúdo não baseado em texto faz parte do capítulo [Mídia](./media)

## Como a compressão HTTP funciona

Quando um cliente faz um pedido HTTP, frequentemente, inclui um cabeçalho [`Accept-Encoding`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Accept-Encoding) para comunicar os algoritmos de compressão que é capaz de descodificar. O servidor pode depois selecionar um dos algoritmos comunicados que suporte e servir uma resposta comprimida. A resposta comprimida iria por sua vez incluir o cabeçalho [`Content-Encoding`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Encoding) para que o cliente perceba que tipo de compressão foi usada. Adicionalmente, um cabeçalho [`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) é, frequentemente, usado para indicar o [MIME type](https://developer.mozilla.org/docs/Web/HTTP/Basico_sobre_HTTP/MIME_types) do resurso a ser servido.

No exemplo seguinte, o cliente comunica que tem suporte para compressão Gzip, Brotli e Deflate. O servidor decidiu retornar uma resposta comprimida com Gzip que contém um documento `text/html`.

```
    > GET / HTTP/1.1
    > Host: httparchive.org
    > Accept-Encoding: gzip, deflate, br

    < HTTP/1.1 200
    < Content-type: text/html; charset=utf-8
    < Content-encoding: gzip
```

O HTTP Archive contém leituras de 5.3 milhões de sites e cada site carregou pelo menos 1 recurso de texto comprimido na sua página de início. Adicionalmente, 81% dos sites reportaram ter recursos comprimidos no seu domínio primário.

## Algoritmos de compressão

A organização IANA mantém uma <a hreflang="en" href="https://www.iana.org/assignments/http-parameters/http-parameters.xml#content-coding">lista de codificação de conteúdos HTTP válidos</a> que podem ser usados com os cabeçalhos `Accept-Encoding` e `Content-Encoding`. Alguns destes incluem `gzip`, `deflate`, `br` (Brotli) entre outros. Uma breve descrição destes algoritmos é apresentada a seguir:

* <a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a> usa as técnicas de compressão [LZ77](https://en.wikipedia.org/wiki/LZ77_and_LZ78#LZ77) e [Huffman coding](https://pt.wikipedia.org/wiki/Codifica%C3%A7%C3%A3o_de_Huffman) e é mais antigo que a própria web. Foi originalmente desenvolvido para o programa `gzip` do Unix em 1992. Uma implementação para servir conteúdos na web existe desde o HTTP/1.1 e a grande maioria dos browsers e clientes suportam este algoritmo de compressão.
* <a hreflang="en" href="https://tools.ietf.org/html/rfc1951">Deflate</a> usa o mesmo algoritmo que o Gzip mas com um recipiente diferente. Não foi tão amplamente usado na web devido a [problemas de compatibilidade](https://en.wikipedia.org/wiki/HTTP_compression#Problems_preventing_the_use_of_HTTP_compression) com alguns servidores e browsers.
* <a hreflang="en" href="https://tools.ietf.org/html/rfc7932">Brotli</a> é um novo algoritmo de compressão <a hreflang="en" href="https://github.com/google/brotli">criado pela Google</a>. Combina a variante moderna da técnica de compressão LZ77 e Huffman e uma modelação de contexto de segunda ordem. A compressão via Brotli é computacionalmente mais exigente que o Gzip mas o algoritmo é capaz de reduzir o tamanho dos arquivos em <a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">15-25%</a> em relação à compressão Gzip. O Brotli foi inicialmente usado para compressão de conteúdos web em 2015 e é <a hreflang="en" href="https://caniuse.com/#feat=brotli">suportado em todos os browsers modernos</a>.

Aproximadamente 38% das respostas HTTP são servidas com compressão baseada em texto. Pode parecer uma estatística surpreendente mas deve-se levar em conta que é baseado em todos os pedidos HTTP no dataset. Algum conteúdo, como imagens, não irá beneficiar destes algoritmos de compressão. A tabela abaixo resume a porcentagem de pedidos servidos para cada tipo de codificação de contéudo.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >Porcentagem de Pedidos</th>
        <th scope="colgroup" colspan="2" >Pedidos</th>
      </tr>
      <tr>
        <th scope="col">Tipo de codificação de conteúdo</th>
        <th scope="col">Desktop</th>
        <th scope="col">Celular</th>
        <th scope="col">Desktop</th>
        <th scope="col">Celular</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Sem Compressão de Texto</em></td>
        <td class="numeric">62.87%</td>
        <td class="numeric">61.47%</td>
        <td class="numeric">260,245,106</td>
        <td class="numeric">285,158,644</td>
      </tr>
      <tr>
        <td><code>gzip</code></td>
        <td class="numeric">29.66%</td>
        <td class="numeric">30.95%</td>
        <td class="numeric">122,789,094</td>
        <td class="numeric">143,549,122</td>
      </tr>
      <tr>
        <td><code>br</code></td>
        <td class="numeric">7.43%</td>
        <td class="numeric">7.55%</td>
        <td class="numeric">30,750,681</td>
        <td class="numeric">35,012,368</td>
      </tr>
      <tr>
        <td><code>deflate</code></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">68,802</td>
        <td class="numeric">70,679</td>
      </tr>
      <tr>
        <td><em>Outro / Inválido</em></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">67,527</td>
        <td class="numeric">68,352</td>
      </tr>
      <tr>
        <td><code>identity</code></td>
        <td class="numeric">0.000709%</td>
        <td class="numeric">0.000563%</td>
        <td class="numeric">2,935</td>
        <td class="numeric">2,611</td>
      </tr>
      <tr>
        <td><code>x-gzip</code></td>
        <td class="numeric">0.000193%</td>
        <td class="numeric">0.000179%</td>
        <td class="numeric">800</td>
        <td class="numeric">829</td>
      </tr>
      <tr>
        <td><code>compress</code></td>
        <td class="numeric">0.000008%</td>
        <td class="numeric">0.000007%</td>
        <td class="numeric">33</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td><code>x-compress</code></td>
        <td class="numeric">0.000002%</td>
        <td class="numeric">0.000006%</td>
        <td class="numeric">8</td>
        <td class="numeric">29</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adoção de algoritmos de compressão.") }}</figcaption>
</figure>

De todos os recursos servidos com compressão, a maioria usa Gzip (80%) ou Brotli (20%). Os algoritmos restantes de compressão raramente são usados.

{{ figure_markup(
  image="fig2.png",
  caption="Adoção de algoritmos de compressão em páginas desktop.",
  description="Gráfico de pizza da tabela de dados da Figura 15.1.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2052550005&format=interactive"
  )
}}

Adicionalmente, existem 67k pedidos que retornam um `Content-Encoding` inválido, como "none", "UTF-8", "base64", "text", etc. Estes recursos muito provavelmente são servidos sem compressão.

Não conseguimos determinar os níveis de compressão dos diagnósticos obtidos do HTTP Archive mas a melhor prática para comprimir conteúdo é:

* No mínimo, ativar o nível 6 de compressão Gzip para recursos do tipo texto. Este nível representa um bom balanço entre o custo computacional e taxa de compressão sendo a opção <a hreflang="en" href="https://paulcalvano.com/index.php/2018/07/25/brotli-compression-how-much-will-it-reduce-your-content/">padrão para muitos servidores web</a> apesar do [Nginx ainda recorrer a um nível 1, normalmente muito baixo](http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_comp_level).
* Se conseguir suportar Brotli e pre-comprimir esses recursos, então use o nível 11. Este nível é computacionalmente mais exigente que o Gzip - portanto uma pre-compressão é essencial para evitar atrasos.
* Se conseguir suportar Brotli mas pre-compressão não é uma opção, então comprima com Brotli nível 5. Este nível irá produzir recursos mais pequenos quando comparados com Gzip, com uma exigência computacional semelhante.

## Que tipos de conteúdos estamos comprimindo?

A maior parte dos recursos baseados em texto (como HTML, CSS e JavaScript) podem se beneficiar de compressão Gzip e Brotli. No entanto, normalmente não é necessário usar estas técnicas de compressão em recursos binários, como imagens, videos e algumas fontes web porque os seus formatos de arquivo já estão comprimidos.

No gráfico abaixo, podemos ver o top 25 de tipos de conteúdo em caixas cujo tamanho representa o número relativo de pedidos. A cor de cada caixa representa a quantidade de recursos servidos com compressão. A maior parte do conteúdo mídia é mostrado com uma sombra laranja uma vez que, tal como esperado, Gzip e Brotli trariam pouco ou nenhum benefício para os mesmos. A maior parte do conteúdo baseado em texto é sombreado a azul indicando que foram comprimidos. No entanto, o sombreado azul claro para alguns tipos de conteúdo indica que não são comprimidos tão consistentemente como os outros.

{{ figure_markup(
  image="fig3.png",
  caption="Top 25 tipos de conteúdo comprimidos.",
  description="Gráfico de árvore mostrando  image/jpeg (167,912,373 pedidos - 3.23% comprimidos), application/javascript (121,058,259 pedidos - 81.29% comprimidos), image/png (113,530,400 pedidos - 3.81% comprimidos), text/css (86,634,570 pedidos - 81.81% comprimidos), text/html (81,975,252 pedidos - 43.44% comprimidos), image/gif (70,838,761 pedidos - 3.87% comprimidos), text/javascript (60,645,767 pedidos - 89.52% comprimidos), application/x-javascript (38,816,387 pedidos - 91.02% comprimidos), font/woff2 (22,622,918 pedidos - 3.87% comprimidos), application/json (16,501,326 pedidos - 59.02% comprimidos), image/webp (12,911,688 pedidos - 1.66% comprimidos), image/svg+xml (9,862,643 pedidos - 64.42% comprimidos), text/plain (6,622,361 pedidos - 24.72% comprimidos), application/octet-stream (3,884,287 pedidos - 6.01% comprimidos), image/x-icon (3,737,030 pedidos - 37.60% comprimidos), application/font-woff2 (3,061,857 pedidos - 5.90% comprimidos), application/font-woff (2,117,999 pedidos - 23.61% comprimidos), image/vnd.microsoft.icon (1,774,995 pedidos - 15.55% comprimidos), video/mp4 (1,472,880 pedidos - 0.03% comprimidos), font/woff (1,255,093 pedidos - 24.33% comprimidos), font/ttf (1,062,747 pedidos - 84.27% comprimidos), application/x-font-woff (1,048,398 pedidos - 30.77% comprimidos), image/jpg (951,610 pedidos - 6.66% comprimidos), application/ocsp-response (883,603 pedidos - 0.00% comprimidos).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1790056981&format=interactive",
  width=780,
  height=482,
  data_width=780,
  data_height=482
  )
}}

Excluindo os 8 tipos de conteúdo mais populares permite-nos ver as estatísticas de compressão dos restantes tipos de conteúdo com mais clareza.

{{ figure_markup(
  image="fig4.png",
  caption="Tipos de conteúdo comprimidos, excluindo o top 8.",
  description="Gráfico de árvore mostrando font/woff2 (22,622,918 pedidos - 3.87% comprimidos), application/json (16,501,326 pedidos - 59.02% comprimidos), image/webp (12,911,688 pedidos - 1.66% comprimidos), image/svg+xml (9,862,643 pedidos - 64.42% comprimidos), text/plain (6,622,361 pedidos - 24.72% comprimidos), application/octet-stream (3,884,287 pedidos - 6.01% comprimidos), image/x-icon (3,737,030 pedidos - 37.60% comprimidos), application/font-woff2 (3,061,857 pedidos - 5.90% comprimidos), application/font-woff (2,117,999 pedidos - 23.61% comprimidos), image/vnd.microsoft.icon (1,774,995 pedidos - 15.55% comprimidos), video/mp4 (1,472,880 pedidos - 0.03% comprimidos), font/woff (1,255,093 pedidos - 24.33% comprimidos), font/ttf (1,062,747 pedidos - 84.27% comprimidos), application/x-font-woff (1,048,398 pedidos - 30.77% comprimidos), image/jpg (951,610 pedidos - 6.66% comprimidos), application/ocsp-response (883,603 pedidos - 0.00% comprimidos)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=495358423&format=interactive",
  width=780,
  height=482,
  data_width=780,
  data_height=482
  )
}}

Os tipos de conteúdo `application/json` e `image/svg+xml` são comprimidos menos de 65% das vezes.

A maior parte das fontes web customizadas são servidas sem compressão uma vez que já são um formato comprimido. No entanto, a fonte `font/ttf` é comprimível apesar de só 84% dos pedidos a fontes TTF serem servidos com compressão, mostrando que ainda existe espaço para melhoria.

Os gráficos abaixo ilustram a distribuição de cada técnica de compressão para cada tipo de conteúdo. Olhando os 3 tipos de conteúdo com mais compressão, conseguimos ver que tanto em dekstop como em celular existem grandes diferenças na compressão em alguns dos tipos de conteúdo mais frequentemente requisitados. 56% dos recursos `text/html` bem como 18% do tipo `application/javascript` e `text/css` não são comprimidos. Isto representa uma oportunidade significativa para melhoria de desempenho.

{{ figure_markup(
  image="fig5.png",
  caption="Compressão por tipo de conteúdo para desktop.",
  description="Gráfico de barras que mostra o tipo de conteúdo application/javascript com 36.18 Milhões/8.97 Milhões/10.47 Milhões por tipo de compressão (Gzip/Brotli/None), text/css com 24.29 M/8.31 M/7.20 M, text/html com 11.37 M/4.89 M/20.57 M, text/javascript com 23.21 M/1.72 M/3.03 M, application/x-javascript com 11.86 M/4.97 M/1.66 M, application/json com 4.06 M/0.50 M/3.23 M, image/svg+xml com 2.54 M/0.46 M/1.74 M, text/plain com 0.71 M/0.06 M/2.42 M, e image/x-icon com 0.58 M/0.10 M/1.11 M. Deflate raramente é usado e como tal não entra no gráfico.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=148811764&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

{{ figure_markup(
  image="fig6.png",
  caption="Compressão por tipo de conteúdo para celular.",
  description="Gráfico de barras que mostra o tipo de conteúdo application/javascript com 43.07 Milhões/10.17 Milhões/12.19 Milhões por tipo de compressão (Gzip/Brotli/None), text/css com 28.3 M/9.91 M/8.56 M, text/html com 13.86 M/5.48 M/25.79 M, text/javascript com 27.41 M/1.94 M/3.33 M, application/x-javascript com 12.77 M/5.70 M/1.82 M, application/json com 4.67 M/0.50 M/3.53 M, image/svg+xml com 2.91 M/ 0.44 M/1.77 M, text/plain com 0.80 M/0.06 M/1.77 M, e image/x-icon com 0.62 M/0.11 M/1.22M. Deflate raramente é usado e como tal não entra no gráfico.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2009060762&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

Os tipos de conteúdo com a taxa de compressão mais baixa incluem `application/json`, `text/xml`, e `text/plain`. Estes recursos são normalmente usados em pedidos XHR para fornecer dados que aplicações web podem usar para criar as melhores experiências. Comprimir esses recursos irá, muito provavelmente, melhorar a experiência do usuário. Gráficos de vetores, como `image/svg+xml` e `image/x-icon` não são muitas vezes encarados como baseados em texto, mas na realidade são e sites que os usam iriam se beneficiar da compressão.

{{ figure_markup(
  image="fig7.png",
  caption="Compressão por tipo de conteúdo como porcentagem para desktop.",
  description="Gráfico de barras que mostra application/javascript com 65.1%/16.1%/18.8% por tipo de compressão (Gzip/Brotli/None), text/css com 61.0%/20.9%/18.1%, text/html com 30.9%/13.3%/55.8%, text/javascript com 83.0%/6.1%/10.8%, application/x-javascript com 64.1%/26.9%/9.0%, application/json com 52.1%/6.4%/41.4%, image/svg+xml com 53.5%/9.8%/36.7%, text/plain com 22.2%/2.0%/75.8%, e image/x-icon com 32.6%/5.3%/62.1%. Deflate raramente é usado e como tal não entra no gráfico.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1923565332&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="Compressão por tipo de conteúdo como porcentagem para celular.",
  description="Gráfico de barras com application/javascript com 65.8%/15.5%/18.6% por tipo de compressão (Gzip/Brotli/None), text/css com 60.5%/21.2%/18.3%, text/html com 30.7%/12.1%/57.1%, text/javascript com 83.9%/5.9%/10.2%, application/x-javascript com 62.9%/28.1%/9.0%, application/json com 53.6%/8.6%/34.6%, image/svg+xml com 23.4%/1.8%/74.8%, text/plain com 23.4%/1.8%/74.8%, com image/x-icon com 31.8%/5.5%/62.7%. Deflate raramente é usado e como tal não entra no gráfico.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=673629979&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

No universo de tipos de conteúdo, Gzip é o algoritmo de compressão mais popular. A compressão Brotli mais recente é usado com menos frequência e os tipos de conteúdo onde aparece mais são `application/javascript`, `text/css` e `application/x-javascript`. Isto deve-se, provavelmente, à existência de CDNs que aplicam compressão Brotli automaticamente ao tráfego que as atravessa.

## Compressão em conteúdo próprio vs terceiros

No capítulo de [Terceiros](./third-parties), aprendemos sobre terceiros e o seu impacto no desempenho. Quando comparamos técnicas de compressão entre conteúdo próprio e terceiro, podemos ver que conteúdo de terceiros tende a ser mais comprimido que o conteúdo próprio.

Adicionalmente, a porcentagem de compressão Brotli é mais alta para conteúdo de terceiros. Isto deve-se, provavelmente, ao número de recursos servidos por grandes empresas de terceiros que suportam Brotli, tal como a Google e o Facebook.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Desktop</th>
        <th scope="colgroup" colspan="2">Celular</th>
      </tr>
      <tr>
        <th scope="col">Codificação de conteúdo</th>
        <th scope="col">Próprio</th>
        <th scope="col">Terceiros</th>
        <th scope="col">Próprio</th>
        <th scope="col">Terceiros</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Sem compressão de texto</em></td>
        <td class="numeric">66.23%</td>
        <td class="numeric">59.28%</td>
        <td class="numeric">64.54%</td>
        <td class="numeric">58.26%</td>
      </tr>
      <tr>
        <td><code>gzip</code></td>
        <td class="numeric">29.33%</td>
        <td class="numeric">30.20%</td>
        <td class="numeric">30.87%</td>
        <td class="numeric">31.22%</td>
      </tr>
      <tr>
        <td><code>br</code></td>
        <td class="numeric">4.41%</td>
        <td class="numeric">10.49%</td>
        <td class="numeric">4.56%</td>
        <td class="numeric">10.49%</td>
      </tr>
      <tr>
        <td><code>deflate</code></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
      </tr>
      <tr>
        <td><em>Outro / Inválido</em></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Compressão de conteúdo próprio versus terceiros por tipo de dispositivo.") }}</figcaption>
</figure>

## Como identificar oportunidades para compressão

A ferramenta <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> da Google permite aos usuários executarem uma série de auditorias para páginas web. A <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/text-compression">auditoria de compressão de texto</a> avalia se o site pode beneficiar de compressão baseada em texto adicional. Isso é feito através de uma tentativa de compressão dos recursos avaliando se o tamanho dos objetos pode ser reduzido pelo menos 10% e 1400 bytes. Dependendo da pontuação, é possível ver uma recomendação para compressão nos resultados, com uma lista dos recursos específicos que podem ser comprimidos.

{{ figure_markup(
  image="ch15_fig8_lighthouse.jpg",
  caption="Sugestões de compressão do Lighthouse.",
  description="A captura de um relatório do Lighthouse que mostra a lista de recursos (com respectivos nomes) e o tamanho do potencial ganho. Para o primeiro elemento há um ganho potencial significativo de 91 KB para 73 KB, enquanto que para outros arquivos mais pequenos de 6 KB ou menos, encontram-se ganhos menores de 4 KB para 1 KB.",
  width=600,
  height=303
  )
}}

Devido ao fato do [HTTP Archive executar auditorias Lighthouse](./methodology#lighthouse) para cada página celular, podemos agregar as pontuações para todos os sites para entender que mais oportunidade existem para comprimir mais conteúdo. No total, 62% dos sites passam esta auditoria e quase 23% têm uma pontuação abaixo de 40. Isto significa que mais de 1.2 milhões de sites poderiam beneficiar com uma compressão baseada em texto adicional.

{{ figure_markup(
  image="fig11.png",
  caption='Pontuações da auditoria de "ativar compressão de texto" do Lighthouse.',
  description="Gráfico de barras que mostra 7.6% a pontuar menos de 10%, 13.2% dos sites estão a pontuar entre 10-39%, 13.7% dos sites estão a pontuar entre 40-79%, 2.9% dos sites estão a pontuar entre 80-99%, e 62.5% dos sites passam a auditoria com 100% dos recursos de texto comprimidos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2048155673&format=interactive",
  width=760,
  height=331,
  data_width=760,
  data_height=331
  )
}}

O Lighthouse também indica quantos bytes podem ser poupados por ligar a compressão baseada em texto. Dos sites que podem beneficiar de compressão de texto, 82% podem reduzir o peso das suas páginas até 1 MB!

{{ figure_markup(
  image="fig12.png",
  caption='Auditoria de "compressão de texto" do Lighthouse com a potencial poupança de bytes.',
  description="Gráfico de barras que mostra 82.11% dos sites poderiam poupar menos de 1 MB, 15.88% dos sites poderiam poupar 1 - 2 MB e 2% dos sites poderiam poupar > 3 MB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=738657382&format=interactive",
  width=760,
  height=331,
  data_width=760,
  data_height=331
  )
}}

## Conclusão

Compressão HTTP é extensivamente usada e uma funcionalidade com muito valor para reduzir o tamanho de conteúdo web. Tanto Gzip e Brotli são os algoritmos dominantes e a quantidade de conteúdo comprimido varia por tipo de conteúdo. Ferramentas como o Lighthouse podem ajudar a revelar oportunidades para comprimir conteúdo.

Enquanto muitos sites estão fazendo um bom uso da compressão HTTP, ainda existe margem para melhoria, particularmente para o formato `text/html` que é o formato em que a web é construída! De forma similar, outros formatos menos compreendidos como `font/ttf`, `application/json`, `text/xml`, `text/plain`, `image/svg+xml`, e `image/x-icon` podem exigir configurações extra que muitos sites falham.

No mínimo, os sites deviam usar compressão Gzip para todos os recursos baseados em texto, uma vez que é largamente suportado, facilmente implementado, e tem um baixo custo de processamento. Ganhos adicionais podem ser encontrados com compressão Brotli, ainda que os níveis de compressão devam ser escolhidos com cuidado dependendo dos recursos poderem ser pré comprimidos.
