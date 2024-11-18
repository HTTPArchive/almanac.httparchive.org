---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Ecommerce
description: Capítulo sobre comercio electrónico del Almanaque Web de 2019 que cubre plataformas de comercio electrónico, payloads, imágenes, third-parties, rendimiento, seo y PWAs.
hero_alt: Hero image of a Web Almanac character at a super market checkout loading items from a shopping basket onto the conveyor belt while another character payes with a credit card.
authors: [samdutton, alankent]
reviewers: [voltek62]
analysts: [rviscomi]
editors: [tunetheweb]
translators: [JMPerez]
discuss: 1768
results: https://docs.google.com/spreadsheets/d/1FUMHeOPYBgtVeMU5_pl2r33krZFzutt9vkOpphOSOss/
samdutton_bio: <i lang="en">Sam Dutton has worked with the Google Chrome team as a Developer Advocate since 2011. He has organized and presented at a number of events, created and taught several web development courses, and worked on a range of videos, codelabs and written guidance covering PWA, performance, media, image and 'Next Billion Users' initiatives. He maintains <a hreflang="en" href="https://simpl.info">simpl.info</a>, which provides simplest possible examples of HTML, CSS and JavaScript. Sam grew up in South Australia, went to university in Sydney, and has lived since 1986 in London.</i>
alankent_bio: <i lang="en">Alan Kent is a Developer Advocate at Google focusing on e-commerce and content ecosystems. He blogs at <a hreflang="en" href="https://alankent.me">alankent.me</a> and tweets as <a href="https://x.com/akent99">@akent99</a>.</i>
featured_quote: Casi el 10% de las páginas de inicio en este estudio resultaron ser parte de una plataforma de comercio electrónico. Una "plataforma de comercio electrónico" es un conjunto de software o servicios que permiten crear y operar una tienda en línea, incluidos los servicios de pago como Shopify, plataformas de software como Magento Open Source y plataformas alojadas como Magento Commerce.
featured_stat_1: 3.98%
featured_stat_label_1: Sitios que utilizan WooCommerce, la plataforma de comercio electrónico más popular
featured_stat_2: 116
featured_stat_label_2: Número de plataformas de comercio electrónico detectadas
featured_stat_3: 1,517 KB
featured_stat_label_3: Mediana de bytes de imagen por página de comercio electrónico móvil
---

## Introducción

Casi el 10% de las páginas de inicio en este estudio resultaron ser parte de una plataforma de comercio electrónico. Una "plataforma de comercio electrónico" es un conjunto de software o servicios que permiten crear y operar una tienda en línea. Existen varios tipos de plataformas de comercio electrónico, por ejemplo:

- **Servicios de pago** como <a hreflang="en" href="https://www.shopify.com/">Shopify</a> que alojan su tienda y lo ayuda a comenzar. Proporcionan alojamiento de sitios web, plantillas de sitios y páginas, gestión de datos de productos, carritos de compras y pagos.
- **Plataformas de software** como <a hreflang="en" href="https://magento.com/products/magento-open-source">Magento Open Source</a> que configura, aloja y administra usted mismo. Estas plataformas pueden ser potentes y flexibles, pero pueden ser más complejas de configurar y ejecutar que servicios como Shopify.
- **Plataformas _hosted_ o alojadas** como <a hreflang="en" href="https://magento.com/products/magento-commerce">Magento Commerce</a> que ofrecen las mismas funciones que sus homólogos autohospedados, excepto que el alojamiento es administrado como un servicio por un tercero.

{{ figure_markup(
  caption="Porcentaje de páginas servidas por una plataforma de comercio electrónico.",
  content="10%",
  classes="big-number"
)
}}

Este análisis sólo pudo detectar sitios creados en una plataforma de comercio electrónico. Esto significa que las tiendas y mercados en línea más grandes, como Amazon, JD y eBay, no están incluidos aquí. También tenga en cuenta que los datos aquí proceden sólo de las páginas de inicio, por lo que no se incluyen páginas de categoría, producto u otras páginas. Lea más información sobre nuestra [metodología](./methodology).

## Detección de plataforma

¿Cómo comprobamos si una página está en una plataforma de comercio electrónico?

La detección se realiza a través de [Wappalyzer](./methodology#wappalyzer). Wappalyzer es una utilidad multiplataforma que descubre las tecnologías utilizadas en los sitios web. Detecta [sistemas de gestión de contenido](./cms), plataformas de comercio electrónico, servidores web, frameworks [JavaScript](./javascript), herramientas de [analíticas](./third-parties) y muchos más.

La detección de páginas no siempre es confiable, y algunos sitios bloquean explícitamente la detección para protegerse contra ataques automáticos. Es posible que no podamos capturar todos los sitios web que usan una plataforma de comercio electrónico en particular, pero estamos seguros de que los que detectamos están realmente en esa plataforma.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Móvil</th>
        <th scope="col">Escritorio</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Páginas de comercio electrónico</td>
        <td class="numeric">500.595</td>
        <td class="numeric">424.441</td>
      </tr>
      <tr>
        <td>Total de páginas</td>
        <td class="numeric">5.297.442</td>
        <td class="numeric">4.371.973</td>
      </tr>
      <tr>
        <td>Índice de adopción</td>
        <td class="numeric">9,45%</td>
        <td class="numeric">9,70%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Porcentaje de plataformas de comercio electrónico detectado.") }}</figcaption>
</figure>

## Plataformas de comercio electrónico

<figure>
  <table>
    <thead>
      <tr>
        <th>Plataforma</th>
        <th>Móvil</th>
        <th>Escritorio</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">3,98</td>
        <td class="numeric">3,90</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">1,59</td>
        <td class="numeric">1,72</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">1,10</td>
        <td class="numeric">1,24</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">0,91</td>
        <td class="numeric">0,87</td>
      </tr>
      <tr>
        <td>Bigcommerce</td>
        <td class="numeric">0,19</td>
        <td class="numeric">0,22</td>
      </tr>
      <tr>
        <td>Shopware</td>
        <td class="numeric">0,12</td>
        <td class="numeric">0,11</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adopción de las 6 principales plataformas de comercio electrónico.") }}</figcaption>
</figure>

De las 116 plataformas de comercio electrónico que se detectaron, sólo seis se encuentran en más del 0,1% de los sitios web de escritorio o móviles. Tenga en cuenta que estos resultados no muestran variaciones por país, por tamaño de sitio u otras métricas similares.

La Figura 13.3 anterior muestra que WooCommerce tiene la mayor adopción con alrededor del 4% de los sitios web de escritorio y móviles. Shopify es el segundo con aproximadamente el 1,6% de adopción. Magento, PrestaShop, Bigcommerce y Shopware siguen con una adopción cada vez más pequeña, acercándose al 0,1%.

### La larga cola

{{ figure_markup(
  image="fig4.png",
  caption="Adopción de las principales plataformas de comercio electrónico.",
  description="Gráfico de barras de la adopción de las 20 principales plataformas de comercio electrónico. Consulte la Figura 13.3 anterior para obtener una tabla de datos de adopción de las 6 plataformas principales.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1565776696&format=interactive",
  width=600,
  height=414,
  data_width=600,
  data_height=414
  )
}}

Hay 110 plataformas de comercio electrónico usadas por menos de un 0,1% de sitios web de escritorio o móvil. Alrededor de 60 de éstas tienen menos del 0,01% de sitios web móviles o de escritorio.

{{ figure_markup(
  image="fig5.png",
  caption="Adopción combinada de las 6 principales plataformas de comercio electrónico versus las otras 110 plataformas.",
  description="Las 6 principales plataformas de comercio electrónico representan el 8% de todos los sitios web. El resto de las 110 plataformas solo representan el 1,5% de los sitios web. Los resultados para escritorio y móvil son similares.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2093212206&format=interactive",
  width=600,
  height=361,
  data_width=600,
  data_height=361
  )
}}

El 7,87% de todas las peticiones en dispositivos móviles y el 8,06% en escritorio son para páginas de inicio servidas en una de las seis principales plataformas de comercio electrónico. Otro 1,52% de las peticiones en dispositivos móviles y 1,59% en escritorio son para páginas de inicio en las otras 110 plataformas de comercio electrónico.

## Comercio electrónico (todas las plataformas)

En total, el 9,7% de las páginas de escritorio y el 9,5% de las páginas móviles usaron una plataforma de comercio electrónico.

{{ figure_markup(
  image="fig6.png",
  caption="Porcentaje de páginas que utilizan una plataforma de comercio electrónico.",
  description="El 9,7% de las páginas de escritorio usan una plataforma de comercio electrónico y el 9,5% de las páginas móviles usan una plataforma de comercio electrónico.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1360307171&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

Aunque la proporción de sitios web de escritorio fue ligeramente mayor en general, algunas plataformas populares (incluyendo WooCommerce, PrestaShop y Shopware) en realidad tienen más sitios web móviles que de escritorio.

## Peso de página y peticiones

El [peso de la página](./page-weight) de una plataforma de comercio electrónico incluye todo su HTML, CSS, JavaScript, JSON, XML, imágenes, audio y video.

{{ figure_markup(
  image="fig7.png",
  caption="Distribución del peso de la página de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 del peso de la página de comercio electrónico. La página de comercio electrónico de escritorio situada en la mediana carga 2,7 MB. El percentil 10 es 1,0 MB, el 25 es 1,6 MB, el 75 es 4,5 MB y el 90 es 7,6 MB. Los sitios web de escritorio son ligeramente más altos que los móviles por décimas de megabytes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=448248428&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="Distribución de peticiones por página de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 de peticiones por página de comercio electrónico. La página de comercio electrónico de escritorio situada en la mediana realiza 108 peticiones. El percentil 10 es 53 peticiones, el 25 es 76, el 75 es 153 y el 90 es 210. Los sitios web de escritorio son ligeramente más altos que los móviles en aproximadamente 10 peticiones.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1968521689&format=interactive",
  width=600,
  height=363,
  data_width=600,
  data_height=363
  )
}}

La página de una plataforma de comercio electrónico de escritorio situada en la mediana carga 108 peticiones y 2,7 MB. El peso medio para _todas_ páginas de escritorio es 74 peticiones y [1,9 MB] (./page-weight#peso-de-pagina). En otras palabras, las páginas de comercio electrónico realizan casi un 50% más de peticiones que otras páginas web, con _payloads_ aproximadamente un 35% más grandes. En comparación, la página de inicio de <a hreflang="en" href="https://amazon.com">amazon.com</a> realiza alrededor de 300 peticiones en la primera carga, con un peso de página de alrededor de 5 MB, y <a hreflang="en" href="https://ebay.com">ebay.com</a> realiza alrededor de 150 peticiones con un peso de página de aproximadamente 3 MB. El peso de la página y el número de peticiones de páginas de inicio en plataformas de comercio electrónico es ligeramente menor en dispositivos móviles en cada percentil, pero alrededor del 10% de todas las páginas de inicio de comercio electrónico cargan más de 7 MB y realizan más de 200 peticiones.

Estos datos representan el _payload_ y las peticiones sin hacer scroll. Claramente, hay una proporción significativa de sitios que parecen estar haciendo peticiones para más archivos (la mediana es superior a 100), con un _payload_ total mayor que la que debería ser necesaria para la primera carga. Consulte también: [Solicitudes y bytes de terceros] (#solicitudes-y-bytes-de-terceros) más adelante.

Necesitamos investigar más para comprender mejor por qué tantas páginas de inicio en plataformas de comercio electrónico hacen tantas peticiones y tienen _payloads_ tan grandes. Los autores ven regularmente páginas de inicio en plataformas de comercio electrónico que realizan cientos de peticiones en la primera carga, con _payloads_ de varios megabytes. Si el número de peticiones y el _payload_ son un problema para el rendimiento, ¿cómo se pueden reducir?

## Solicitudes y payload por tipo

Los siguientes gráficos son para peticiones de escritorio:

<figure>
  <table>
    <thead>
      <tr>
        <th>Tipo</th>
        <th>10</th>
        <th>25</th>
        <th>50</th>
        <th>75</th>
        <th>90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>imagen</td>
        <td class="numeric">353</td>
        <td class="numeric">728</td>
        <td class="numeric">1.514</td>
        <td class="numeric">3.104</td>
        <td class="numeric">6.010</td>
      </tr>
      <tr>
        <td>vídeo</td>
        <td class="numeric">156</td>
        <td class="numeric">453</td>
        <td class="numeric">1.325</td>
        <td class="numeric">2.935</td>
        <td class="numeric">5.965</td>
      </tr>
      <tr>
        <td>script</td>
        <td class="numeric">199</td>
        <td class="numeric">330</td>
        <td class="numeric">572</td>
        <td class="numeric">915</td>
        <td class="numeric">1.331</td>
      </tr>
      <tr>
        <td>fuente</td>
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
        <td>otro</td>
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
<figcaption>{{ figure_link(caption="Percentiles de la distribución del peso de la página (en KB) por tipo de recurso.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Tipo</th>
        <th>10</th>
        <th>25</th>
        <th>50</th>
        <th>75</th>
        <th>90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>imagen</td>
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
        <td>fuente</td>
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
        <td>otro</td>
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
  <figcaption>{{ figure_link(caption="Percentiles de la distribución de peticiones por página por tipo de recurso.") }}</figcaption>
</figure>

Las imágenes constituyen el mayor número de peticiones y la mayor proporción de bytes para las páginas de comercio electrónico. La página de comercio electrónico de escritorio promedio incluye 39 imágenes con un peso de 1.514 KB (1,5 MB).

El número de peticiones [JavaScript](./javascript) indica que un mejor _bundling_ (y/o multiplexación [HTTP/2](./http)) podría mejorar el rendimiento. Los archivos JavaScript no son significativamente grandes en términos de bytes totales, pero se realizan muchas peticiones por separado. Según el capítulo [HTTP/2](./http#adopcion-de-contenido-de-usuario-http2), más del 40% de las peticiones no se realizan usando HTTP/2. Del mismo modo, los archivos CSS tienen el tercer mayor número de peticiones, pero generalmente son pequeños. La combinación de archivos CSS (y/o HTTP/2) podría mejorar el rendimiento de dichos sitios. Según la experiencia de los autores, muchas páginas de comercio electrónico tienen una alta proporción de CSS y JavaScript no utilizados. [Los vídeos](./media) pueden requerir una pequeña cantidad de peticiones pero, como es lógico, representan una alta proporción del peso de la página, particularmente en sitios con _payloads_ pesadas.

## Tamaño del HTML

{{ figure_markup(
  image="fig11.png",
  caption="Distribución de bytes de HTML (en KB) por página de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 de bytes de HTML por página de comercio electrónico. La página de comercio electrónico de escritorio promedio tiene 36 KB de HTML. El percentil 10 es 12 KB, el 25 es 20, el 75 es 66 y el 90 es 118. Los sitios web de escritorio tienen 1 ó 2 KB más de HTML que los sitios móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=908924961&format=interactive"
  )
}}

Tenga en cuenta que el _payload_ de HTML puede incluir otro código, como JSON, JavaScript o CSS incrustado en el marcado, en lugar de referenciarse como enlaces externos. El tamaño medio del HTML para las páginas de comercio electrónico es de 34 KB en dispositivos móviles y 36 KB en escritorio. Sin embargo, el 10% de las páginas de comercio electrónico tienen un tamaño de HTML de más de 115 KB.

Los tamaños de HTML en móvil no son muy diferentes de los de escritorio. En otras palabras, parece que los sitios no están entregando archivos HTML significativamente diferentes para diferentes dispositivos o tamaños de pantalla. En muchos sitios de comercio electrónico, el HTML de la página de inicio es grande. No sabemos si esto se debe a HTML hinchado o a otro código (como JSON) dentro de los archivos HTML.

## Estadísticas de imágenes

{{ figure_markup(
  image="fig12.png",
  caption="Distribución de bytes de imagen (en KB) por página de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 de bytes de imagen por página de comercio electrónico. La página de comercio electrónico móvil promedio tiene 1.517 KB de imágenes. El percentil 10 es 318 KB, el 25 es 703, el 75 es 3.132 y el 90 es 5.881. Los sitios web para escritorio y dispositivos móviles tienen distribuciones similares.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=323146848&format=interactive"
  )
}}

{{ figure_markup(
  image="fig13.png",
  caption="Distribución de peticiones de imágenes por página de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 de peticiones de imágenes por página de comercio electrónico. La página mediana de comercio electrónico de escritorio realiza 40 peticiones de imágenes. El percentil 10 es 16 peticiones, el 25 es 25, el 75 es 62 y el 90 es 97. La distribución de escritorio es ligeramente superior a la móvil en 2-10 peticiones en cada percentil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1483037371&format=interactive"
  )
}}

<p class="note">Tenga en cuenta que debido a que nuestra <a href="./methodology">metodología</a> de recopilación de datos no simula las interacciones del usuario en páginas como hacer clic o scroll, las imágenes cargadas de forma diferida (_lazy loading_) no se representarían en estos resultados.</p>

Las Figuras 13.12 y 13.13 muestran que la página de comercio electrónico promedio tiene 37 imágenes y representan un tráfico de 1.517 KB en dispositivos móviles, 40 imágenes y 1.524 KB en computadoras de escritorio. ¡El 10% de las páginas de inicio tienen 90 o más imágenes y representan en total casi 6 MB!

{{ figure_markup(
  caption="El número medio de bytes de imagen por página de comercio electrónico en móvil.",
  content="1.517 KB",
  classes="big-number"
)
}}

Una proporción significativa de las páginas de comercio electrónico tienen un _payload_ de imágenes considerable y realizan una gran cantidad de peticiones de imágenes en la primera carga. Consulte el informe <a hreflang="en" href="https://httparchive.org/reports/state-of-images">Estado de las imágenes</a> de HTTP Archive y los capítulos [media](./media) y [peso de página](./page-weight) para más contexto.

Los propietarios de sitios web quieren que sus sitios se vean bien en dispositivos modernos. Como resultado, muchos sitios ofrecen las mismas imágenes de productos de alta resolución a todos los usuarios, sin importar la resolución o el tamaño de la pantalla. Es posible que los desarrolladores no estén al tanto (o no quieran usar) técnicas _responsive_ que permitan servir de forma eficiente la mejor imagen posible a diferentes usuarios. Vale la pena recordar que las imágenes de alta resolución no necesariamente aumentan las tasas de conversión. Por el contrario, el uso excesivo de imágenes pesadas puede afectar la velocidad de la página y, por lo tanto, puede reducir las tasas de conversión. En la experiencia de los autores revisando sitios, algunos desarrolladores y otras partes interesadas no adoptan _lazy loading_ de imágenes por preocupaciones sobre SEO entre otros.

Necesitamos hacer más análisis para comprender mejor por qué algunos sitios no están utilizando técnicas de imágenes _responsive_ o _lazy loading_. También necesitamos proporcionar una guía que ayude a las plataformas de comercio electrónico a entregar imágenes nítidas de manera confiable a aquellos con dispositivos de alta gama y buena conectividad, al tiempo que brindamos la mejor experiencia posible a los dispositivos de gama baja y aquellos con una conectividad pobre.

## Formatos de imagen populares

{{ figure_markup(
  image="fig15.png",
  caption="Formatos de imagen populares.",
  description="Gráfico de barras que muestra la popularidad de varios formatos de imagen. JPEG es el formato más popular con el 54% de las imágenes en las páginas de comercio electrónico de escritorio. Los siguientes son PNG con un 27%, GIF con un 14%, SVG con un 2% y WebP e ICO con un 1% cada uno.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=2108999644&format=interactive"
  )
}}

<p class="note">Tenga en cuenta que algunos servicios de imágenes o CDN entregarán automáticamente WebP (en lugar de JPEG o PNG) a plataformas que admitan WebP, incluso para una URL con el sufijo `.jpg` o` .png`. Por ejemplo, <a hreflang="en" href="https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg">IMG_20190113_113201.jpg</a> devuelve una imagen WebP en Chrome. Sin embargo, la forma en que HTTP Archive <a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/31a25b9064a365d746d4811a1d6dda516c0e4985/bulktest/batch_lib.inc#L994">detecta los formatos de imagen</a> es verificar primero las palabras clave en el tipo MIME y usar como alternativa la extensión de archivo. Esto significa que el formato para imágenes con una URL como la anterior se clasifica como WebP, ya que WebP es compatible con HTTP Archive como agente de usuario.</p>

### PNG

Una de cada cuatro imágenes en las páginas de comercio electrónico son PNG. La gran cantidad de peticiones de PNG desde las páginas de plataformas de comercio electrónico es probablemente para imágenes de productos. Muchos sitios de comercio usan PNG con imágenes fotográficas porque soportan transparencia.

El uso de WebP haciendo _fallback_ a PNG puede ser una alternativa mucho más eficiente, ya sea a través de un [elemento de imagen](http://simpl.info/picturetype) o mediante la detección del soporte del agente de usuario a través de un servicio de imágenes como <a hreflang="en" href="https://res.cloudinary.com/webdotdev/f_auto/w_500/IMG_20190113_113201.jpg">Cloudinary</a>.

### WebP

Sólo el 1% de las imágenes en las plataformas de comercio electrónico son WebP, lo que coincide con la experiencia de los autores en las revisiones del sitio. WebP es <a hreflang="en" href="https://caniuse.com/#feat=webp">compatible con todos los navegadores modernos excepto Safari</a> y tiene buenos mecanismos de _fallback_ disponibles. WebP admite transparencia y es un formato mucho más eficiente que PNG para imágenes fotográficas (consulte la sección PNG anterior).

Nosotros, como comunidad web, podemos abogar por proporcionar transparencia usando WebP con unn _fallback_ a PNG y/o usando WebP/JPEG con un fondo de color sólido. Parece que WebP rara vez se usa en plataformas de comercio electrónico, a pesar de la disponibilidad de <a hreflang="es" href="https://web.dev/i18n/es/serve-images-webp">guías</a> y herramientas (por ejemplo, <a hreflang="en" href="https://squoosh.app/">Squoosh</a> y <a hreflang="en" href="https://developers.google.com/speed/webp/docs/cwebp">cwebp</a>). Necesitamos investigar más sobre por qué no ha habido más aceptación de WebP, que ahora tiene <a hreflang="en" href="https://blog.chromium.org/2010/09/webp-new-image-format-for-web.html">casi 10 años</a>.

## Dimensiones de la imagen

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Móvil</th>
        <th scope="colgroup" colspan="2">Escritorio</th>
      </tr>
      <tr>
        <th scope="col">Percentil</th>
        <th scope="col">Ancho (px)</th>
        <th scope="col">Alto (px)</th>
        <th scope="col">Ancho (px)</th>
        <th scope="col">Alto (px)</th>
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
  <figcaption>{{ figure_link(caption="Distribución de las dimensiones intrínsecas de imagen (en píxeles) por página de comercio electrónico.") }}</figcaption>
</figure>

Las dimensiones medias ('rango medio') para las imágenes solicitadas por las páginas de comercio electrónico son 247x196 px en dispositivos móviles y 240x192 px en escritorio. El 10% de las imágenes solicitadas por las páginas de comercio electrónico tienen al menos 693x512 px en dispositivos móviles y 800x546 px en escritorio. Tenga en cuenta que estas dimensiones son los tamaños intrínsecos de las imágenes, no su tamaño de visualización.

Las dimensiones de la imagen en cada percentil hasta la mediana son similares en dispositivos móviles y escritorio, o incluso en algunos casos un poco más grandes en dispositivos móviles. Parece que muchos sitios no ofrecen diferentes dimensiones de imágenes para diferentes ventanas o, en otras palabras, no utilizando técnicas de imagen _responsive_. Servir imágenes más grandes en móvil en algunos casos puede (o no) explicarse por sitios que utilizan detección de dispositivo o pantalla.

Necesitamos investigar más sobre por qué muchos sitios (aparentemente) no ofrecen diferentes tamaños de imagen a diferentes tamaños de pantalla.

## Peticiones y bytes de terceros

Muchos sitios web, especialmente las tiendas en línea, cargan una cantidad significativa de código y contenido de terceros: para análisis, pruebas A/B, seguimiento del comportamiento del cliente, publicidad y soporte de redes sociales. El contenido de terceros puede tener un <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript">impacto significativo en el rendimiento</a>. La <a hreflang="en" href="https://github.com/patrickhulce/third-party-web">herramienta third-party-web</a> de [Patrick Hulce](https://x.com/patrickhulce) se utiliza para determinar las solicitudes de terceros para este informe, y esto se discute más en el capítulo de [Third Parties](./third-parties).

{{ figure_markup(
  image="fig17.png",
  caption="Distribución de peticiones de terceros por página de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 de las solicitudes de terceros por página de comercio electrónico. El número medio de solicitudes de terceros en escritorio es 19. Los percentiles 10, 25, 75 y 90 son: 4, 9, 34 y 54. En escritorio hay 1 ó 2 peticiones más que en móvil en cada percentil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=865791628&format=interactive"
  )
}}

{{ figure_markup(
  image="fig18.png",
  caption="Distribución de bytes de terceros por página de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 de bytes de terceros por página de comercio electrónico. El número medio de bytes de terceros en el escritorio es de 320 KB. Los percentiles 10, 25, 75 y 90 son: 42, 129, 651 y 1.071. En escriorio es 10-30 KB más alto que en móvil en cada percentil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=164264869&format=interactive"
  )
}}

La página de inicio mediana ('rango medio') en una plataforma de comercio electrónico realiza 17 peticiones de contenido de terceros en dispositivos móviles y 19 en escritorio. El 10% de todas las páginas de inicio en plataformas de comercio electrónico realizan más de 50 peticiones de contenido de terceros, lo que supone un total de más de 1 MB.

<a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript/">Otros estudios</a> han indicado que el contenido de terceros puede ser un gran cuello de botella en el rendimiento. Este estudio muestra que 17 o más peticiones (50 o más para el 10% superior) es la norma para las páginas de comercio electrónico.

## Solicitudes de terceros y payload por plataforma

Tenga en cuenta que las siguientes gráficas y tablas muestran datos sólo para dispositivos móviles.

{{ figure_markup(
  image="fig19.png",
  caption="Distribución de solicitudes de terceros por página móvil para cada plataforma de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 de peticiones de terceros por página de comercio electrónico para cada plataforma. Shopify y Bigcommerce cargan la mayoría de las peticiones de terceros en las distribuciones con unas 40 peticiones en la mediana.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1242665725&format=interactive"
  )
}}

{{ figure_markup(
  image="fig20.png",
  caption="Distribución de bytes de terceros (KB) por página móvil para cada plataforma de comercio electrónico.",
  description="Distribución de los percentiles 10, 25, 50, 75 y 90 de bytes de terceros (KB) por página de comercio electrónico para cada plataforma. Shopify y Bigcommerce cargan la mayoría de los bytes de terceros en las distribuciones con más de 1.000 KB en la mediana.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1017068803&format=interactive"
  )
}}

Las plataformas como Shopify pueden extender sus servicios usando JavaScript del lado del cliente, mientras que otras plataformas como Magento usan más extensiones del lado del servidor. Esta diferencia en la arquitectura afecta a los números mostrados aquí.

Claramente, las páginas en algunas plataformas de comercio electrónico hacen más peticiones de contenido de terceros e incurren en una mayor carga de contenido de terceros. Se podría realizar un análisis adicional de _por qué_ las páginas de algunas plataformas realizan más peticiones y tienen _payloads_ de terceros más grandes que otras.

## First Contentful Paint (FCP)

{{ figure_markup(
  image="fig21.png",
  caption="Distribución promedio de experiencias FCP por plataforma de comercio electrónico.",
  description="Gráfico de barras de la distribución promedio de las experiencias de FCP para las seis principales plataformas de comercio electrónico. WooCommerce tiene la mayor densidad de experiencias FCP lentas con un 43%. Shopify tiene la mayor densidad de experiencias rápidas de FCP con 47%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1341906463&format=interactive"
  )
}}

[First Contentful Paint](./performance#first-contentful-paint) mide el tiempo que transcurre desde la navegación hasta que se muestra por primera vez contenido como texto o una imagen. En este contexto, **rápido** significa FCP en menos de un segundo, **lento** significa FCP en 3 segundos o más, y **moderado** es el resto. Tenga en cuenta que el contenido y el código de terceros pueden tener un impacto significativo en FCP.

Las seis principales plataformas de comercio electrónico tienen peor FCP en dispositivos móviles que en escritorio: menos rápido y más lento. Tenga en cuenta que el FCP se ve afectado por la capacidad del dispositivo (potencia de procesamiento, memoria, etc.) así como por la conectividad.

Necesitamos establecer por qué FCP es peor en dispositivos móviles que en escritorio. ¿Cuáles son las causas: conectividad y/o capacidad del dispositivo, o algo más?

## Puntuación de Progressive Web App (PWA)

Consulte también el [capítulo de PWA](./pwa) para obtener más información sobre este tema más allá de los sitios de comercio electrónico.

{{ figure_markup(
  image="fig22.png",
  caption="Distribución de las puntuaciones en la categoría PWA en Lighthouse para páginas de comercio electrónico móvil.",
  description="Distribución de las puntuaciones de la categoría PWA de Lighthouse para páginas de comercio electrónico. En una escala de 0 (fallando) a 1 (perfecto), el 40% de las páginas obtienen una puntuación de 0,33. El 1% de las páginas obtienen una puntuación superior a 0,6.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vROHKGuMutXmxtzEoBSJNVn7DOzlfpizJh7mOkopFK8OVl_hCUHDOmKgYOojrpVsGnGWaletE7Uc5oX/pubchart?oid=1148584930&format=interactive"
  )
}}

Más del 60% de las páginas de inicio en plataformas de comercio electrónico obtienen una <a hreflang="en" href="https://developers.google.com/web/ilt/pwa/lighthouse-pwa-analysis-tool">puntuación de PWA en Lighthouse</a> de entre 0,25 y 0,35. Menos del 20% de las páginas de inicio en las plataformas de comercio electrónico obtienen una puntuación de más de 0,5 y menos del 1% de las páginas de inicio obtienen una puntuación de más de 0,6.

Lighthouse devuelve una puntuación de Progressive Web App (PWA) entre 0 y 1. 0 es la peor puntuación posible y 1 es la mejor. Las auditorías de PWA se basan en la <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist">lista de verificación de PWA de referencia</a>, que enumera 14 requisitos. Lighthouse ha realizado auditorías automatizadas para 11 de los 14 requisitos. Los 3 restantes sólo pueden probarse manualmente. Cada una de las 11 auditorías PWA automatizadas se ponderan por igual, por lo que cada una aporta aproximadamente 9 puntos a su puntuación PWA.

Si al menos una de las auditorías de PWA obtuvo una puntuación nula, Lighthouse anula la puntuación para toda la categoría de PWA. Este fue el caso del 2,32% de las páginas móviles.

Claramente, la mayoría de las páginas de comercio electrónico fallan en la mayoría de las <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist">auditorías de la lista de verificación de PWA</a>. Necesitamos hacer más análisis para comprender mejor qué auditorías están fallando y por qué.

## Conclusión

Este estudio exhaustivo sobre el uso del comercio electrónico muestra algunos datos interesantes y también las amplias variaciones en los sitios de comercio electrónico, incluso entre aquellos creados en la misma plataforma de comercio electrónico. Aunque hemos entrado en muchos detalles aquí, hay muchos más análisis que podríamos hacer en este espacio. Por ejemplo, no obtuvimos puntuaciones de accesibilidad este año (consulte el [capítulo de accesibilidad](./accessibility) para obtener más información al respecto). Del mismo modo, sería interesante segmentar estas métricas por geografía. Este estudio detectó 246 proveedores de anuncios en páginas de inicio en plataformas de comercio electrónico. Otros estudios (¿tal vez en el Almanaque Web del próximo año?) podrían calcular qué proporción de sitios en plataformas de comercio electrónico muestran anuncios. WooCommerce obtuvo números muy altos en este estudio, por lo que otra estadística interesante que podríamos ver el próximo año es si algunos proveedores de alojamiento están instalando WooCommerce pero no lo habilitan, lo que causa cifras infladas.
