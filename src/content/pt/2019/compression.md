---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Compressão
description: Capítulo de compressão do Web Almanac de 2019 acerca de compressão HTTP, algoritmos, tipos de contéudo, compressão própria ou por terceiros e oportunidades.
authors: [paulcalvano]
reviewers: [obto, yoavweiss]
analysts: [paulcalvano]
editors: [bazzadp]
translators: [soulcorrosion]
discuss: 1770
results: https://docs.google.com/spreadsheets/d/1IK9kaScQr_sJUwZnWMiJcmHEYJV292C9DwCfXH6a50o/
paulcalvano_bio: Paul Calvano is um arquitecto de Performance Web na <a href="https://www.akamai.com/">Akamai</a>, onde ajuda empresas a melhorar o desempenho dos seus sites. Ele é também umas das pessoas que mantém o projecto HTTP Archive. Podem encontrá-lo no Twitter em <a href="https://twitter.com/paulcalvano">@paulcalvano</a>, a escrever no seu blog <a href="https://paulcalvano.com">http://paulcalvano.com</a> e a partilhar pesquisas do HTTP Archive em <a href="https://discuss.httparchive.org">https://discuss.httparchive.org</a>.
featured_quote: A compressão HTTP é uma técnica que permite codificar informação usando menos bits que a represantação original. Quando é usado para entrega de conteúdo web, isso permite a servidores web reduzir a quantidade de dados transmitodos aos clientes. Isto aumenta a eficiência da largura de banda disponível do ciente, reduz o peso da página e melhora o seu desempenho.
featured_stat_1: 38%
featured_stat_label_1: Respostas HTTP que usam compressão baseada em texto
featured_stat_2: 80%
featured_stat_label_2: Uso da compressão Gzip
featured_stat_3: 56%
featured_stat_label_3: Respostas HTML sem compressão
---

## Introdução

A compressão HTTP é uma técnica que permite codificar informação usando menos bits que a represantação original. Quando é usado para entrega de conteúdo web, isso permite a servidores web reduzir a quantidade de dados transmitodos aos clientes. Isto aumenta a eficiência da largura de banda disponível do ciente, reduz o [peso da página](./page-weight) e melhora o seu [desempenho](./performance).

Algoritmos de compressão são muitas vezes categorizados como podendo ter ou não perdas:

* Quando um algoritmo de compressão com perdas é usado, o processo é irreversível, e o ficheiro original não pode ser restaurado através de descompressão. É uma prática comum para comprimir recursos mídia, tal como imagens e vídeo onde perder alguns dados não irá materialmente afectar o recurso.
* A compressão sem perdas é um processo totalmente reversível sendo tipicamente usado em recurso do tipo texto, como [HTML](./markup), [JavaScript](./javascript), [CSS](./css), etc.

Neste capítulo, vamos explorar como conteúdo de texto é comprimido na web. Análise de conteúdo não baseado em texto faz parte do capítulo [Mídia](./media)


## Como a compressão HTTP funciona

Quando um cliente faz um pedido HTTP, frequentemente inclui um cabeçalho [`Accept-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Encoding) para comunicar os algoritmos de compressão que é capaz de descodificar. O servidor pode depois seleccionar um dos algoritmos comunicados que suporte e servir uma resposta comprimida. A resposta comprimida incluiria o cabeçalho [`Content-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding) para que o cliente esteja ciente que tipo de compressão foi usada. Adicionalmente, um cabeçalho [`Content-Type`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type) é frequentemente usado para indicar o [MIME type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types) do resurso a ser servido.

No exemplo seguinte, o cliente comunica que tem suporte para compressão Gzip, Brotli e Deflate. O servidor decidiu retornar uma resposta comprimida com GZip que contém um documento `text/html`.


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

A organização IANA mantém uma [lista de codificação de conteúdos HTTP válidos](https://www.iana.org/assignments/http-parameters/http-parameters.xml#content-coding) que podem ser usados com os cabeçalhos `Accept-Encoding` e `Content-Encoding`. Alguns destes incluem `gzip`, `deflate`, `br` (Brotli) entre outros. Uma breve descrição destes algoritmos é apresentada de seguida:

* [Gzip](https://tools.ietf.org/html/rfc1952) usa as técnicas de compressão [LZ77](https://en.wikipedia.org/wiki/LZ77_and_LZ78#LZ77) e [Huffman coding](https://en.wikipedia.org/wiki/Huffman_coding) e é mais antigo que a própria web. Foi originalmente desenvolvido para o programa `gzip` do Unix em 1992. Uma implementação para servir conteúdos na web existe desde o HTTP/1.1 e a grande maioria dos browsers e clientes suportam este algoritmo de compressão.
* [Deflate](https://tools.ietf.org/html/rfc1951) usa o mesmo algoritmo que o Gzip mas com um recipiente diferente. Não foi tão adoptado para a web devido a [problemas de compatibilidade](https://en.wikipedia.org/wiki/HTTP_compression#Problems_preventing_the_use_of_HTTP_compression) com alguns servidores e browsers.
* [Brotli](https://tools.ietf.org/html/rfc7932) é um novo algoritmo de compressão [criado pela Google](https://github.com/google/brotli). Combina a variante moderna da técnica de compressão LZ77 e Huffman e uma modelação de contexto de segunda ordem. A compressão via Brotli é computacionalmente mais exigente que o Gzip mas o algoritmo é capaz de reduzir o tamanho dos ficheiros em [15-25%](https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf) em relação à compressão Gzip. O Brotli foi inicialmente usado para compressão de conteúdos web em 2015 e é [suportado em todos os browsers modernos](https://caniuse.com/#feat=brotli).

Aproximadamente 38% das respostas HTTP são servidas com compressão baseada em texto. Poderá parecer uma estatística surpreendente mas deve levar em conta que é baseado em todos os pedidos HTTP no dataset. Algum conteúdo, como imagens, não irá beneficiar destes algoritmos de compressão. A tabela abaixo resume a percentagem de pedidos servidos para cada tipo de codificação de contéudo.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >Percentagem de Pedidos</th>
        <th scope="colgroup" colspan="2" >Pedidos</th>
      </tr>
      <tr>
        <th scope="col">Tipo de codificação de conteúdo</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
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
  <figcaption>{{ figure_link(caption="Adopção de algoritmos de compressão.") }}</figcaption>
</figure>

De todos os recursos servidos com compressão, a maioria usa Gzip (80%) our Brolti (20%). Os restantes algoritmos de compressão raramente são usados.

{{ figure_markup(
  image="fig2.png",
  caption="Adopção de algoritmos de compressão em páginas desktop.",
  description="Gráfico de pizza da tabela de dados da Figura 15.1.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2052550005&format=interactive"
  )
}}

Adicionalmente, existem 67k pedidos que retornam um `Content-Encoding` inválido, como "none", "UTF-8", "base64", "text", etc. Estes recuros muito provavelmente são servidos sem compressão.

Não conseguimos determinar os níveis de compressão dos diagnósticos obtidos do HTTP Archive mas a melhor prática para comprimir conteúdo é:

* No mínimo, activar o nível 6 de compressão Gzip para recursos do tipo texto. Este nível representa um bom balanço entre o custo computacional e taxa de compressão sendo a opção [padrão para muitos servidores web](https://paulcalvano.com/index.php/2018/07/25/brotli-compression-how-much-will-it-reduce-your-content/) apesar do [Nginx ainda recorrer a um nível 1, normalmente muito baixo](http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_comp_level).
* Se conseguir suportar Broti e pre-comprimir esses recursos, então use o nível 11. Este nível é computacionalmente mais exigente que o Gzip - portanto uma pre-compressão é essencial para evitar atrasos. 
* Se conseguir suportar Brotli mas pre-compressão não é uma opção, então comprima com Brotli nível 5. Este nível irá produzir recursos mais pequenos quando comparados com Gzip, com uma exigência computacional semelhante.


## Que tipos de conteúdos estamos a comprimir?

A maior parte dos recursos baseados em texto (como HTML, CSS e Javascript) podem beneficiar de compressão Gzip e Brotli.
No entanto, normamente não é necessário usar estas técnicas de compressão em recursos binários, como imagens, video e algumas fontes web porque os seus formatos de ficheiro já estão comprimidos.

No gráfico abaixo, podemos ver o top 25 de tipos de conteúdo em caixas cujo tamanho representa o número relativo de pedidos. A cor de cada caixa representa a quantidade de recursos servidos com compressão. A maior parte do conteúdo media é mostrado com uma sombra laranja uma vez que, tal como esperado, Gzip e Brotli trariam pouco ou nenhum benefício para os mesmos. A maior parte do conteúdo baseado em texto é sombreado a azul indicando que estão a ser comprimidos. No entanto, o sombreado azul claro para alguns tipos de conteúdo indica que não são comprimidos tão consistentemente como os outros.

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
  description="Gráfico de árevore mostrando font/woff2 (22,622,918 pedidos - 3.87% comprimidos), application/json (16,501,326 pedidos - 59.02% comprimidos), image/webp (12,911,688 pedidos - 1.66% comprimidos), image/svg+xml (9,862,643 pedidos - 64.42% comprimidos), text/plain (6,622,361 pedidos - 24.72% comprimidos), application/octet-stream (3,884,287 pedidos - 6.01% comprimidos), image/x-icon (3,737,030 pedidos - 37.60% comprimidos), application/font-woff2 (3,061,857 pedidos - 5.90% comprimidos), application/font-woff (2,117,999 pedidos - 23.61% comprimidos), image/vnd.microsoft.icon (1,774,995 pedidos - 15.55% comprimidos), video/mp4 (1,472,880 pedidos - 0.03% comprimidos), font/woff (1,255,093 pedidos - 24.33% comprimidos), font/ttf (1,062,747 pedidos - 84.27% comprimidos), application/x-font-woff (1,048,398 pedidos - 30.77% comprimidos), image/jpg (951,610 pedidos - 6.66% comprimidos), application/ocsp-response (883,603 pedidos - 0.00% comprimidos)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=495358423&format=interactive",
  width=780,
  height=482,
  data_width=780,
  data_height=482
  )
}}

Os tipos de conteúdo `application/json` e `image/svg+xml` são comprmidos menos de 65% das vezes.

A maior parte das fontes web customizadas são servidas sem compressão uma vez que já são um formato comprimido. No entanto, a fonte `font/ttf` é comprimível apesar de só 84% dos pedidos a fontes TTF serem servidos com compressão mostrando que ainda existe espaço para melhoria.

Os gráficos abaixo ilustram 
The graphs below illustrate the breakdown of compression techniques used for each content type. Looking at the top three content types, we can see that across both desktop and mobile there are major gaps in compressing some of the most frequently requested content types. 56% of `text/html` as well as 18% of `application/javascript` and `text/css` resources are not being compressed. This presents a significant performance opportunity.

{{ figure_markup(
  image="fig5.png",
  caption="Compression by content type for desktop.",
  description="Stacked bar chart showing application/javascript is 36.18 Million/8.97 Million/10.47 Million by compression type (Gzip/Brotli/None), text/css is 24.29 M/8.31 M/7.20 M, text/html is 11.37 M/4.89 M/20.57 M, text/javascript is 23.21 M/1.72 M/3.03 M, application/x-javascript is 11.86 M/4.97 M/1.66 M, application/json is 4.06 M/0.50 M/3.23 M, image/svg+xml is 2.54 M/0.46 M/1.74 M, text/plain is 0.71 M/0.06 M/2.42 M, and image/x-icon is 0.58 M/0.10 M/1.11 M. Deflate is almost never used by any time and does not register on the chart..",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=148811764&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

{{ figure_markup(
  image="fig6.png",
  caption="Compression by content type for mobile.",
  description="Stacked bar chart showing application/javascript is 43.07 Million/10.17 Million/12.19 Million by compression type (Gzip/Brotli/None), text/css is 28.3 M/9.91 M/8.56 M, text/html is 13.86 M/5.48 M/25.79 M, text/javascript is 27.41 M/1.94 M/3.33 M, application/x-javascript is 12.77 M/5.70 M/1.82 M, application/json is 4.67 M/0.50 M/3.53 M, image/svg+xml is 2.91 M/ 0.44 M/1.77 M, text/plain is 0.80 M/0.06 M/1.77 M, and image/x-icon is 0.62 M/0.11 M/1.22M. Deflate is almost never used by any time and does not register on the chart.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2009060762&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

The content types with the lowest compression rates include `application/json`, `text/xml`, and `text/plain`. These resources are commonly used for XHR requests to provide data that web applications can use to create rich experiences. Compressing them will likely improve user experience.  Vector graphics such as `image/svg+xml`, and `image/x-icon` are not often thought of as text based, but they are and sites that use them would benefit from compression.

{{ figure_markup(
  image="fig7.png",
  caption="Compression by content type as a percent for desktop.",
  description="Stacked bar chart showing application/javascript is 65.1%/16.1%/18.8% by compression type (Gzip/Brotli/None), text/css is 61.0%/20.9%/18.1%, text/html is 30.9%/13.3%/55.8%, text/javascript is 83.0%/6.1%/10.8%, application/x-javascript is 64.1%/26.9%/9.0%, application/json is 52.1%/6.4%/41.4%, image/svg+xml is 53.5%/9.8%/36.7%, text/plain is 22.2%/2.0%/75.8%, and image/x-icon is 32.6%/5.3%/62.1%. Deflate is almost never used by any time and does not register on the chart.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1923565332&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="Compression by content type as a percent for mobile.",
  description="Stacked bar chart showing application/javascript is 65.8%/15.5%/18.6% by compression type (Gzip/Brotli/None), text/css is 60.5%/21.2%/18.3%, text/html is 30.7%/12.1%/57.1%, text/javascript is 83.9%/5.9%/10.2%, application/x-javascript is 62.9%/28.1%/9.0%, application/json is 53.6%/8.6%/34.6%, image/svg+xml is 23.4%/1.8%/74.8%, text/plain is 23.4%/1.8%/74.8%, and image/x-icon is 31.8%/5.5%/62.7%. Deflate is almost never used by any time and does not register on the chart.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=673629979&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

No universo de tipos de conteúdo, Gzip é o algoritmo de compressão mais popular. A compressão Brotli mais recente é usado com menos frequência e os tipos de conteúdo onde aparece mais são `application/javascript`, `text/css` e `application/x-javascript`. Isto deve-se, provavelmente, à existência de CDNs que aplicam compressão Brotli automaticamente ao tráfego que as atravessa.

## First-party vs third-party compression

In the [Third Parties](./third-parties) chapter, we learned about third parties and their impact on performance. When we compare compression techniques between first and third parties, we can see that third-party content tends to be compressed more than first-party content.

Additionally, the percentage of Brotli compression is higher for third-party content. This is likely due to the number of resources served from the larger third parties that typically support Brotli, such as Google and Facebook.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Desktop</th>
        <th scope="colgroup" colspan="2">Mobile</th>
      </tr>
      <tr>
        <th scope="col">Content Encoding</th>
        <th scope="col">First-Party</th>
        <th scope="col">Third-Party</th>
        <th scope="col">First-Party</th>
        <th scope="col">Third-Party</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>No Text Compression</em></td>
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
        <td><em>Other / Invalid</em></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="First-party versus third-party compression by device type.") }}</figcaption>
</figure>

## Identifying compression opportunities

Google's [Lighthouse](https://developers.google.com/web/tools/lighthouse) tool enables users to run a series of audits against web pages. The [text compression audit](https://developers.google.com/web/tools/lighthouse/audits/text-compression) evaluates whether a site can benefit from additional text-based compression. It does this by attempting to compress resources and evaluate whether an object's size can be reduced by at least 10% and 1,400 bytes. Depending on the score, you may see a compression recommendation in the results, with a list of specific resources that could be compressed.

{{ figure_markup(
  image="ch15_fig8_lighthouse.jpg",
  caption="Lighthouse compression suggestions.",
  description="A screenshot of a Lighthouse report showing a list of resources (with the names redacted) and showing the size and the potential saving. For the first item there is a potentially significant saving from 91 KB to 73 KB, while for other smaller files of 6 KB or less there are smaller savings of 4 KB to 1 KB.",
  width=600,
  height=303
  )
}}

Because the [HTTP Archive runs Lighthouse audits](./methodology#lighthouse) for each mobile page, we can aggregate the scores across all sites to learn how much opportunity there is to compress more content. Overall, 62% of websites are passing this audit and almost 23% of websites have scored below a 40. This means that over 1.2 million websites could benefit from enabling additional text based compression.

{{ figure_markup(
  image="fig11.png",
  caption='Lighthouse "enable text compression" audit scores.',
  description="Stacked bar chart showing 7.6% are costing less than 10%, 13.2% of sites are scoring between 10-39%, 13.7% of sites scoring between 40-79%, 2.9% of sites scoring between 80-99%, and 62.5% of sites have a pass with over 100% of text assets being compressed.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2048155673&format=interactive",
  width=760,
  height=331,
  data_width=760,
  data_height=331
  )
}}

Lighthouse also indicates how many bytes could be saved by enabling text-based compression. Of the sites that could benefit from text compression, 82% of them can reduce their page weight by up to 1 MB!

{{ figure_markup(
  image="fig12.png",
  caption='Lighthouse "enable text compression" audit potential byte savings.',
  description="Stacked bar chart showing 82.11% of sites could save less than 1 MB, 15.88% of sites could save 1 - 2 MB and 2% of sites could save > 3 MB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=738657382&format=interactive",
  width=760,
  height=331,
  data_width=760,
  data_height=331
  )
}}

## Conclusion

HTTP compression is a widely used and highly valuable feature for reducing the size of web content. Both Gzip and Brotli compression are the dominant algorithms used, and the amount of compressed content varies by content type. Tools like Lighthouse can help uncover opportunities to compress content.

While many sites are making good use of HTTP compression, there is still room for improvement, particularly for the `text/html` format that the web is built upon! Similarly, lesser-understood text formats like `font/ttf`, `application/json`, `text/xml`, `text/plain`, `image/svg+xml`, and `image/x-icon` may take extra configuration that many websites miss.

At a minimum, websites should use Gzip compression for all text-based resources, since it is widely supported, easily implemented, and has a low processing overhead. Additional savings can be found with Brotli compression, although compression levels should be chosen carefully based on whether a resource can be precompressed.
