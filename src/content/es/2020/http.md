---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: HTTP/2
description: Capítulo sobre HTTP/2 del Web Almanac de 2020 que cubre la adopción y el impacto  de HTTP/2, <i lang="en">HTTP/2 Push</i>, problemas con HTTP/2, y HTTP/3.
hero_alt: Hero image of Web Almanac characters driving vehicles in various lanes carrying script and images resources.
authors: [dotjs, rmarx, MikeBishop]
reviewers: [LPardue, tunetheweb, ibnesayeed]
analysts: [gregorywolf]
editors: [rviscomi]
translators: [moniloria]
dotjs_bio: Andrew trabaja en <a hreflang="en" href="https://www.cloudflare.com/es-la/">Cloudflare</a> ayudando a hacer la web más rápida y más segura. Dedica su tiempo a implementar, medir y mejorar nuevos protocolos y la entrega de recursos, para mejorar el rendimiento del sitio web para el usuario final.
rmarx_bio: Robin es investigador de protocolos web y rendimiento en la <a hreflang="en" href="https://www.uhasselt.be/edm">Universidad de Hasselt, Bélgica</a>. Ha estado trabajando para que QUIC y HTTP/3 estén listos para ser utilizados, mediante la creación de herramientas como <a hreflang="en" href="https://github.com/quiclog">qlog y qvis</a>.
MikeBishop_bio: Editor de HTTP/3 con el <a hreflang="en" href="https://quicwg.org/">QUIC Working Group</a>. Arquitecto en el grupo <i lang="en">Foundry</i> de <a hreflang="en" href="https://www.akamai.com/">Akamai</a>.
discuss: 2058
results: https://docs.google.com/spreadsheets/d/1M1tijxf04wSN3KU0ZUunjPYCrVsaJfxzuRCXUeRQ-YU/
featured_quote: Este capítulo hace una reseña acerca del estado actual de HTTP/2 y del despliegue de gQUIC, para establecer qué tan bien se han adoptado algunas de las características más nuevas del protocolo, como la priorización y el servicio <i lang="en">server push</i>. Luego, analizamos las motivaciones para HTTP/3, describimos las principales diferencias entra las versiones del protocolo y discutimos los desafíos potenciales al actualizar a un protocolo de transporte basado en UDP con QUIC.
featured_stat_1: 64%
featured_stat_label_1: Solicitudes servidas a través de HTTP/2
featured_stat_2: 31.7%
featured_stat_label_2: Solicitudes de CDN con priorización HTTP/2 incorrecta
featured_stat_3: 80%
featured_stat_label_3: Páginas servidas a través de HTTP/2 al usar una CDN, 30% si no se usa CDN
---

## Introducción

HTTP es un protocolo de capa de aplicación diseñado para transferir información entre dispositivos en red y se ejecuta sobre otras capas de la pila de protocolos de red. Después del lanzamiento de HTTP/1.x, pasaron más de 20 años hasta que la primera actualización importante, HTTP/2, se convirtió en estándar en 2015.

No se detuvo allí: durante los últimos cuatro años, HTTP/3 y QUIC (un nuevo protocolo de transporte seguro, confiable y que reduce la latencia) han estado en desarrollo de estándares en el grupo de trabajo IETF QUIC. En realidad, hay dos protocolos que comparten el mismo nombre: "Google QUIC" ("gQUIC" para abreviar), el protocolo original que fue diseñado y utilizado por Google, y la versión estándar IETF más reciente (IETF QUIC/QUIC). IETF QUIC se basó en gQUIC, pero ha crecido hasta ser bastante diferente en diseño e implementación. El 21 de octubre de 2020, el borrador 32 de IETF QUIC alcanzó un hito significativo cuando se trasladó a <a hreflang="en" href="https://mailarchive.ietf.org/arch/msg/quic/ye1LeRl7oEz898RxjE6D3koWhn0/">Last Call</a>. Esta es la parte del proceso de estandarización cuando el grupo de trabajo considera que está casi terminado y solicita una revisión final de parte de la comunidad IETF.

Este capítulo hace una reseña acerca del estado actual de HTTP/2 y del despliegue de gQUIC. Explora qué tan bien se han adoptado algunas de las características más nuevas del protocolo, como la priorización y el servicio server push. Luego, analizamos las motivaciones para HTTP/3, describimos las principales diferencias entra las versiones del protocolo y discutimos los desafíos potenciales al actualizar a un protocolo de transporte basado en UDP con QUIC.

### HTTP/1.0 a HTTP/2

A medida que el protocolo HTTP ha evolucionado, la semántica de HTTP se ha mantenido igual; no ha habido cambios en los métodos HTTP (como GET o POST), códigos de estado (200 o el temido 404), URI o campos de encabezado. Donde el protocolo HTTP ha cambiado, las diferencias han sido el <i lang="en">wire-encoding</i> y el uso de las funciones del transporte subyacente.

HTTP/1.0, publicado en 1996, definió el protocolo de aplicación basado en texto, permitiendo a los clientes y servidores intercambiar mensajes para solicitar recursos. Se requería una nueva conexión TCP para cada solicitud/respuesta, lo que introducía una sobrecarga. Las conexiones TCP utilizan un algoritmo de control de congestión para maximizar la cantidad de datos que pueden estar en tránsito. Este proceso toma tiempo para cada nueva conexión. Este <i lang="en">"slow-start"</i> significa que no todo el ancho de banda disponible se utiliza inmediatamente.

En 1997, se introdujo HTTP/1.1 para permitir la reutilización de la conexión TCP agregando <i lang="en">"keep-alives"</i>, con el objetivo de reducir el costo total de la puesta en marcha de conexiones. Con el tiempo, el aumento de las expectativas de rendimiento de los sitios web llevó a la necesidad de que hubiera concurrencia en las solicitudes. HTTP/1.1 solo podía solicitar otro recurso después de que se completara la respuesta anterior. Por lo tanto, se tenían que establecer conexiones TCP adicionales, reduciendo el impacto de las conexiones <i lang="en">"keep-alive"</i> y aumentando aún más la sobrecarga.

HTTP/2, publicado en 2015, es un protocolo binario que introdujo el concepto de flujos bidireccionales entre cliente y servidor. Con estos flujos, un navegador puede hacer un uso óptimo de una única conexión TCP para _multiplexar_ múltiples solicitudes/respuestas HTTP al mismo tiempo. HTTP/2 también introdujo un esquema de priorización para dirigir esta multiplexación; los clientes pueden señalar una prioridad de solicitud que permite enviar recursos más importantes antes que otros.

## Adopción de HTTP/2

Los datos utilizados en este capítulo se obtienen del HTTP Archive y de pruebas en más de siete millones de sitios web con un navegador Chrome. Al igual que en otros capítulos, el análisis se divide en sitios web móviles y de escritorio. Cuando los resultados entre dispositivos de escritorio y móviles son similares, las estadísticas se presentan del conjunto de datos móviles. Puede encontrar más detalles en la página [Metodología](./methodology). Al revisar estos datos, tenga en cuenta que cada sitio web recibirá el mismo peso independientemente del número de solicitudes. Le sugerimos que considere esto más como una investigación de las tendencias en una amplia gama de sitios web activos.

{{ figure_markup(
  image="http2-h2-usage.png",
  link="https://httparchive.org/reports/state-of-the-web#h2",
  caption='Uso de HTTP/2 por solicitud. (Source: <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#h2">HTTP Archive</a>)',
  description="Un gráfico temporal del uso de HTTP/2 que muestra una adopción del 64% tanto para dispositivos de escritorio como para móviles en julio de 2019. La tendendia está creciendo de manera constante aproximadamente a 15 puntos por año.",
  width=600,
  height=321
  )
}}

El análisis de los datos del HTTP Archive del año pasado mostró que HTTP/2 se utilizó para más del 50% de las solicitudes y, como puede verse, el crecimiento lineal ha continuado en 2020; ahora, más del 60% de las solicitudes se atienden a través de HTTP/2.

{{ figure_markup(
  caption="Porcentaje de solicitudes que utilizan HTTP/2.",
  content="64%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

Al comparar la Figura 22.3 con los resultados del año pasado, ha habido un **aumento del 10% en las solicitudes HTTP/2** y una disminución correspondiente del 10% en las solicitudes HTTP/1.x. Este es el primer año en el que se puede ver gQUIC en el conjunto de datos.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocolo</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">**34.47%</td>
        <td class="numeric">34.11%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">63.70%</td>
        <td class="numeric">63.80%</td>
      </tr>
      <tr>
        <td>gQUIC</td>
        <td class="numeric">1.72%</td>
        <td class="numeric">1.71%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="Uso de la versión de HTTP por solicitud.", sheets_gid="2122693316", sql_file="adoption_of_http_2_by_site_and_requests.sql") }}</figcaption>
</figure>

<aside class="note">
  ** Al igual que con el rastreo del año pasado, alrededor del 4% de las solicitudes desde un dispositivo de escritorio no reportaron una versión del protocolo. El análisis muestra que en su mayoría son HTTP/1.1 y trabajamos para corregir esta brecha en nuestras estadísticas para futuros rastreos y análisis. Aunque basamos los datos en el rastreo de agosto de 2020, confirmamos la corrección en el conjunto de datos de octubre de 2020 antes de la publicación, que de hecho mostró que se trataba de solicitudes HTTP/1.1 y, por lo tanto, las agregamos a esa estadística en la tabla anterior.
</aside>

Al revisar el número total de solicitudes de sitios web, habrá un sesgo hacia los dominios de terceros que son usuales. Para comprender mejor la adopción de HTTP/2 por instalación de servidor, veremos en su lugar el protocolo utilizado para servir el HTML desde la página de inicio de un sitio.

El año pasado, alrededor del 37% de las páginas de inicio se sirvieron a través de HTTP/2 y el 63% a través de HTTP/1. Este año, combinando dispositivos móviles y de escritorio, es una división más o menos igual, con un poco más de sitios de escritorio que se sirven a través de HTTP/2 por primera vez, como se muestra en la Figura 22.4.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocolo</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.0</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.05%</td>
      </tr>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">49.22%</td>
        <td class="numeric">50.05%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">49.97%</td>
        <td class="numeric">49.28%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="Uso de la versión de HTTP por páginas de inicio.", sheets_gid="1447413141", sql_file="measure_of_all_http_versions_for_main_page_of_all_sites.sql") }}</figcaption>
</figure>

gQUIC no se ve en los datos de la página de inicio por dos razones. Para medir un sitio web sobre gQUIC, el rastreo del HTTP Archive tendría que realizar una negociación de protocolo a través del encabezado <i lang="en">[Alternative Services](#alternative-services)</i> y luego usar este punto final para cargar el sitio sobre gQUIC. Esto no fue compatible este año, pero se espera que esté disponible en el Web Almanac del año próximo. Además, gQUIC se utiliza principalmente para herramientas de Google de terceros en lugar de servir páginas de inicio.

El impulso para aumentar la [seguridad](./security) y la [privacidad](./privacy) en la web ha visto aumentar las solicitudes sobre TLS en <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#pctHttps">más del 150% en los últimos 4 años</a>. Hoy, más del 86% de todas las solicitudes en dispositivos móviles y computadoras de escritorio son encriptadas. Mirando solo las páginas de inicio, las cifras siguen siendo un impresionante 78.1% de escritorio y 74.7% de móvil. Esto es importante porque HTTP/2 solo es compatible con navegadores sobre TLS. La proporción servida a través de HTTP/2, como se muestra en la Figura 22.5, también ha aumentado en 10 puntos porcentuales desde [el año pasado](../2019/http#fig-5), del 55% al ​​65%.

<figure>
  <table>
    <thead>
      <tr>
        <th>Protocolo</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>HTTP/1.1</td>
        <td class="numeric">36.05%</td>
        <td class="numeric">34.04%</td>
      </tr>
      <tr>
        <td>HTTP/2</td>
        <td class="numeric">63.95%</td>
        <td class="numeric">65.96%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>{{ figure_link(caption="Uso de la versión de HTTP por páginas de inicio HTTPS.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

Con más del 60% de los sitios web que se sirven a través de HTTP/2 o gQUIC, veamos un poco más en profundidad el patrón de distribución del protocolo para todas las solicitudes realizadas en sitios individuales.

{{ figure_markup(
  image="http2-h2-or-gquic-requests-per-page.png",
  caption="Compara la distribución de la fracción de solicitudes HTTP/2 por página en 2020 con 2019.",
  description="Un gráfico de barras de la fracción de solicitudes HTTP/2 por percentil de página. El porcentaje medio de solicitudes HTTP/2 o gQUIC por página aumentó al 76% en 2020 desde un 46% en 2019. En el percentil 10, 25, 75 y 90, la fracción de solicitudes HTTP/2 o gQUIC por página en 2020 es del 5%, 24%, 98% y 100% en comparación con 3%, 15%, 93% y 100% en 2019.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1328744214&format=interactive",
  sheets_gid="152400778",
  sql_file="percentiles_of_resources_loaded_over_HTTP2_or_better_per_site.sql"
  )
}}

La Figura 22.6 compara cuánto HTTP/2 o gQUIC se usa en un sitio web entre este año y el año pasado. El cambio más notable es que más de la mitad de los sitios ahora tienen el 75% o más de sus solicitudes atendidas a través de HTTP/2 o gQUIC en comparación con el 46% del año pasado. Menos del 7% de los sitios no realizan solicitudes HTTP/2 o gQUIC, mientras que (solo) el 10% de los sitios son solicitudes HTTP/2 o gQUIC en su totalidad.

¿Qué pasa con el desglose de la página en sí? Por lo general, hablamos de la diferencia entre contenido propio y de terceros. Tercero se define como contenido que no está bajo el control directo del propietario del sitio, que proporciona funciones como publicidad, marketing o análisis. La definición de terceros conocidos se toma del repositorio <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5">third party web</a>.

La Figura 22.7 ordena cada sitio web por la fracción de solicitudes HTTP/2 para terceros conocidos o solicitudes de contenido propio en comparación con otras solicitudes. Existe una diferencia notable, ya que más del 40% de todos los sitios no tienen del todo solicitudes HTTP/2 o gQUIC. Por el contrario, incluso el más bajo 5% de las páginas tiene un 30% de contenido de terceros servido a través de HTTP/2. Esto indica que una gran parte de la amplia adopción de HTTP/2 es impulsada por terceros.

{{ figure_markup(
  image="http2-first-and-third-party-http2-usage.png",
  caption="Distribución de la fracción de solicitudes HTTP/2 de terceros y de contenido propio por página.",
  description="Un gráfico de líneas que compara la fracción de solicitudes HTTP/2 de contenido propio con solicitudes HTTP/2 o gQUIC de terceros. El gráfico ordena los sitios web por fracción de solicitudes HTTP/2. El 45% de los sitios web no tienen solicitudes HTTP/2 de contenido propio. Más de la mitad de los sitios web atienden solicitudes de terceros solo a través de HTTP/2 o gQUIC. El 80% de los sitios web tienen 76% o más solicitudes HTTP/2 o gQUIC de terceros.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1409316276&format=interactive",
  sql_file="http2_1st_party_vs_3rd_party.sql",
  sheets_gid="733872185"
)
}}

¿Hay alguna diferencia ente cuáles tipos de contenido se sirven a través de HTTP/2 o gQUIC? La Figura 22.8 muestra, por ejemplo, que el 90% de los sitios web sirven el 100% de fuentes y audio de terceros a través de HTTP/2 o gQUIC, solo el 5% a través de HTTP/1.1 y un 5% son una combinación. La mayoría de los activos de terceros son scripts o imágenes, y se sirven únicamente a través de HTTP/2 o gQUIC en el 60% y el 70% de los sitios web, respectivamente.

{{ figure_markup(
  image="http2-third-party-http2-usage-by-content-type.png",
  caption='Fracción de solicitudes HTTP/2 o gQUIC de terceros conocidos por <i lang="en">content-type</i> por sitio web.',
  description='Un gráfico de barras que compara la fracción de solicitudes HTTP/2 de terceros por <i lang="en">content-type</i>. Todas las solicitudes de terceros se envían a través de HTTP/2 o gQUIC para el 90% de audio y fuentes, 80% de css y video, 70% de html, imágenes y texto y 60% de scripts.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1264128523&format=interactive",
  sheets_gid="419557288",
  sql_file="http2_1st_party_vs_3rd_party_by_type.sql"
)
}}

Los <i lang="en">ads</i>, los servicios de <i lang="en">analytics</i>, los recursos de las redes de distribución de contenido (CDN), y los administradores de etiquetas se sirven principalmente a través de HTTP/2 o gQUIC, como se muestra en la Figura 22.9. Es más probable que el contenido de <i lang="en">customer-success</i> y de márketing se sirva a través de HTTP/1.

{{ figure_markup(
  image="http2-third-party-http2-usage-by-category.png",
  caption="Fracción de solicitudes HTTP/2 o gQUIC de terceros conocidos por categoría por sitio web.",
  description='Un gráfico de barras que compara la fracción de solicitudes HTTP/2 o gQUIC de terceros por categoría. Todas las solicitudes de terceros para todos los sitios web se atienden a través de HTTP/2 o gQUIC para el 95% de administradores de etiquetas, el 90% de servicios de <i lang="en">analytics</i> y de CDN, el 80% de <i lang="en">ads</i>, redes sociales, alojamiento y utilidades, el 40% de márketing y el 30% de <i lang="en">customer-success</i>.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1419102835&format=interactive",
  sheets_gid="1059610651",
  sql_file="http2_3rd_party_by_types.sql"
)
}}

### Soporte de servidor

Los mecanismos de actualización automática del navegador son un factor determinante para la adopción de nuevos estándares web por parte del cliente. Se <a hreflang="en" href="https://caniuse.com/http2">estima</a> que más del 97% de los usuarios globales admiten HTTP/2, un poco más que el 95% medido el año pasado.

Desafortunadamente, la ruta de actualización para los servidores es más difícil, especialmente con el requisito de que deben admitir TLS. Para dispositivos móviles y de escritorio, podemos ver en la Figura 22.10, que la mayoría de los sitios HTTP/2 son servidos por nginx, Cloudflare y Apache. Casi la mitad de los sitios HTTP/1.1 son servidos por Apache.

{{ figure_markup(
  image="http2-server-protocol-usage.png",
  caption="Uso de servidor por protocolo HTTP en dispositivos móviles",
  description="Un gráfico de barras que muestra la cantidad de sitios web servidos por HTTP/1.x o HTTP/2 para los servidores más populares de clientes móviles. Nginx sirve a 727,181 sitios HTTP/1.1 y 1,023,575 sitios HTTP/2. Cloudflare 59,981 HTTP/1.1 y 679,616 HTTP/2. Apache 1,521,753 HTTP/1.1 y 585,096 HTTP/2. Litespeed 50,502 HTTP/1.1 y 166,721 HTTP/2. Microsoft-IIS 284,047 HTTP/1.1 y 81,490 HTTP/2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=718663369&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
)
}}

¿Cómo ha cambiado la adopción de HTTP/2 en el último año para cada servidor? La Figura 22.11 muestra un aumento general de la adopción de HTTP/2 de alrededor del 10% en todos los servidores desde el año pasado. Apache e IIS todavía están por debajo del 25% de HTTP/2. Esto sugiere que los servidores nuevos tienden a ser nginx o se considera demasiado difícil o no vale la pena actualizar Apache o IIS a HTTP/2 y/o TLS.

{{ figure_markup(
  image="http2-h2-usage-by-server.png",
  caption="Porcentaje de páginas servidas a través de HTTP/2 por servidor",
  description="Un gráfico de barras que compara el porcentaje de sitios web servidos a través de HTTP/2 entre 2019 y 2020. Cloudflare aumentó a 93.08% desde 85.40%. Litespeed aumentó a 81.91% de 7.80%. Openresty aumentó a 66.24% desde 51.40%. Nginx aumentó de 49.20% a 60.84%. Apache aumentó a 27.19% desde 18.10% y MIcorsoft-IIS aumentó a 22.82% desde 14.10%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=936321266&format=interactive",
  sheets_gid="306338094",
  sql_file="count_of_h2_and_h3_sites_grouped_by_server.sql"
  )
}}

Una recomendación a largo plazo para mejorar el rendimiento del sitio web ha sido utilizar una CDN. El beneficio es una reducción en la latencia al servir contenido y terminar conexiones más cerca del usuario final. Esto ayuda a mitigar la rápida evolución en la implementación de protocolos y las complejidades adicionales en el ajuste de servidores y sistemas operativos (consulte la sección [priorización](#priorización) para obtener más detalles). Para utilizar los nuevos protocolos de manera eficaz, el uso de una CDN puede considerarse el enfoque recomendado.

Las CDN se pueden clasificar en dos categorías: las que sirven la página de inicio y/o subdominios de activos, y las que se utilizan principalmente para ofrecer contenido de terceros. Ejemplos de la primera categoría son los CDN genéricos más grandes (como Cloudflare, Akamai o Fastly) y los más específicos (como WordPress o Netlify). Al observar la diferencia en las tasas de adopción de HTTP/2 para las páginas de inicio servidas con o sin CDN, vemos:

- **80%** de las páginas de inicio para dispositivos móviles se sirven a través de HTTP/2 si se utiliza una CDN
- **30%** de las páginas de inicio para dispositivos móviles se sirven a través de HTTP/2 si no se utiliza una CDN

La Figura 22.12 muestra que las CDN más específicas y modernas sirven una mayor proporción de tráfico a través de HTTP/2.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="colgroup" class="no-wrap">HTTP/2 (%)</th>
        <th scope="colgroup">CDN</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>100%</td>
        <td>Bison Grid, CDNsun, LeaseWeb CDN, NYI FTW, QUIC.cloud, Roast.io, Sirv CDN, Twitter, Zycada Networks</td>
      </tr>
      <tr>
        <td>90 - 99%</td>
        <td>Automattic, Azion, BitGravity, Facebook, KeyCDN, Microsoft Azure, NGENIX, Netlify, Yahoo, section.io, Airee, BunnyCDN, Cloudflare, GoCache, NetDNA, SFR, Sucuri Firewall</td>
      </tr>
      <tr>
        <td>70 - 89%</td>
        <td>Amazon CloudFront, BelugaCDN, CDN, CDN77, Erstream, Fastly, Highwinds, OVH CDN, Yottaa, Edgecast, Myra Security CDN, StackPath, XLabs Security</td>
      </tr>
      <tr>
        <td>20 - 69%</td>
        <td>Akamai, Aryaka, Google, Limelight, Rackspace, Incapsula, Level 3, Medianova, OnApp, Singular CDN, Vercel, Cachefly, Cedexis, Reflected Networks, Universal CDN, Yunjiasu, CDNetworks</td>
      </tr>
      <tr>
        <td> < 20%</td>
        <td>Rocket CDN, BO.LT, ChinaCache, KINX CDN, Zenedge, ChinaNetCenter </td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Porcentaje de solicitudes HTTP/2 servidas por las CDN de contenido propio a través de dispositivos móviles.", sheets_gid="781660433", sql_file="cdn_detail_by_cdn.sql") }}</figcaption>
</figure>

Los tipos de contenido de la segunda categoría suelen ser recursos compartidos (CDN de JavaScript o fuentes), <i lang="en">ads</i> o servicios de <i lang="en">analytics</i>. En todos estos casos, el uso de una CDN mejorará el rendimiento y la descarga de las diversas soluciones <i lang="en">SaaS</i>.

{{ figure_markup(
  image="http2-cdn-http2-usage.png",
  caption="Comparación del uso de HTTP/2 y gQUIC para sitios web que utilizan una CDN.",
  description="Un gráfico de líneas que compara la fracción de solicitudes servidas mediante HTTP/2 o gQUIC para sitios web que usan una CDN en comparación con sitios que no. El eje-x muestra los percentiles de la página web ordenados por porcentaje de solicitudes. El 23% de los sitios web que no utilizan CDN no usan HTTP/2 ni gQUIC. En comparación, el 60% de los sitios web que utilizan una CDN utilizan HTTP/2 o gQUIC en su totalidad. El 93% de los sitios web que utilizan un CDN y el 47% de los sitios que no utilizan un CDN tienen un 50% o más de uso de HTTP/2 o gQUIC.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1779365083&format=interactive",
  sheets_gid="1457263817",
  sql_file="cdn_summary.sql"
)
}}

En la Figura 22.13 podemos ver la gran diferencia en la adopción de HTTP/2 y gQUIC cuando un sitio web usa una CDN. El 70% de las páginas utilizan HTTP/2 para todas las solicitudes de terceros cuando se utiliza una CDN. Sin una CDN, solo el 25% de las páginas utilizan HTTP/2 para todas las solicitudes de terceros.

## Impacto de HTTP/2

Medir el impacto de cómo se está desempeñando un protocolo es difícil con el actual [enfoque](./methodology) de HTTP Archive. Sería realmente fascinante poder cuantificar el impacto de las conexiones concurrentes, el efecto de la pérdida de paquetes y de los diferentes mecanismos de control de congestión. Para comparar realmente el rendimiento, cada sitio web debería rastrearse sobre cada protocolo en diferentes condiciones de red. En cambio, lo que podemos hacer es analizar el impacto en la cantidad de conexiones que utiliza un sitio web.

### Reduciendo conexiones

Como se discutió [anteriormente](#http10-a-http2), HTTP/1.1 solo permite una única solicitud a la vez a través de una conexión TCP. La mayoría de los navegadores evitan esto permitiendo seis conexiones paralelas por host. La principal mejora con HTTP/2 es que se pueden multiplexar varias solicitudes a través de una única conexión TCP. Esto debería reducir el número total de conexiones, y el tiempo y los recursos asociados, necesarios para cargar una página.

{{ figure_markup(
  image="http2-total-number-of-connections-per-page.png",
  caption="Distribución del número total de conexiones por página",
  description="Un gráfico de percentiles del total de conexiones, comparando 2016 con 2020 en dispositivos de escritorio. La mediana de conexiones en 2016 es 23, en 2020 es 13. En el percentil 10, 6 conexiones en 2016, 5 en 2020. En el percentil 25, 12 conexiones en 2016, 8 en 2020. En el percentil 75, 43 conexiones en 2016, 20 en 2020. En el percentil 90, 76 conexiones en 2016 y 33 en 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=17394219&format=interactive",
  sheets_gid="1432183252",
  sql_file="measure_number_of_tcp_connections_per_site.sql"
)
}}

La Figura 22.15 muestra cómo se ha reducido el número de conexiones TCP por página en 2020 en comparación con 2016. La mitad de todos los sitios web utilizan ahora 13 conexiones TCP o menos en 2020 en comparación con 23 conexiones en 2016; una disminución del 44%. En el mismo período de tiempo, el <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#reqTotal">número medio de solicitudes</a> solo se redujo de 74 a 73. El número medio de solicitudes por conexión TCP ha aumentado de 3.2 a 5.6.

TCP fue diseñado para mantener un flujo de datos promedio que sea eficiente y justo. Imagine un proceso de control de flujo en el que cada flujo ejerce presión y responde a todos los demás flujos, para proporcionar una parte justa de la red. En un protocolo justo, cada sesión de TCP no desplaza a ninguna otra sesión y, con el tiempo, ocupará 1/N de la capacidad de la ruta.

La mayoría de los sitios web todavía abren más de 15 conexiones TCP. En HTTP/1.1, las seis conexiones que un navegador puede abrir a un dominio pueden, con el tiempo, reclamar seis veces más ancho de banda que una sola conexión HTTP/2. En redes de baja capacidad, esto puede ralentizar la entrega de contenido de los dominios de activos primarios a medida que aumenta el número de conexiones rivales y quita ancho de banda a las solicitudes importantes. Esto favorece a los sitios web con una pequeña cantidad de dominios de terceros.

HTTP/2 permite la <a hreflang="en" href="https://tools.ietf.org/html/rfc7540#section-9.1">reutilización de conexiones</a> en dominios diferentes pero relacionados entre sí. Para un recurso de TLS, requiere un certificado que sea válido para el host en el URI. Esto se puede utilizar para reducir el número de conexiones necesarias para los dominios bajo el control del autor del sitio.

### Priorización

Como las respuestas HTTP/2 se pueden dividir en muchas tramas individuales y como las tramas de múltiples flujos se pueden multiplexar, el orden en el que las tramas son intercaladas y entregadas por el servidor se convierte en una consideración crítica del rendimiento. Un sitio web típico consta de muchos tipos diferentes de recursos: el contenido visible (HTML, CSS, imágenes), la lógica de la aplicación (JavaScript), <i lang="en">ads</i>, servicios de <i lang="en">analytics</i> para rastrear el uso del sitio y balizas de rastreo de marketing. Con el conocimiento de cómo funciona un navegador, se puede definir un orden óptimo de los recursos que dará como resultado la experiencia de usuario más rápida. La diferencia entre óptimo y no óptimo puede ser significativa, ¡hasta un 50% de mejora en el rendimiento o más!

HTTP/2 introdujo el concepto de priorización para ayudar al cliente a comunicar al servidor cómo cree que se debe realizar la multiplexación. A cada flujo se le asigna un peso (cuánto del ancho de banda disponible se debe asignar al flujo) y posiblemente uno principal (otro flujo que se debe entregar primero). Con la flexibilidad del modelo de priorización de HTTP/2, no es del todo sorprendente que todos los motores de navegador actuales implementaran <a hreflang="en" href="https://calendar.perfplanet.com/2018/http2-prioritization/">diferentes estrategias de priorización</a>, ninguna de las cuales son <a hreflang="en" href="https://www.youtube.com/watch?v=nH4iRpFnf1c">óptimas</a>.

También hay problemas en el lado del servidor, lo que lleva a que muchos servidores implementen la priorización de manera deficiente o nula. En el caso de HTTP/1.x, ajustar los búferes de envío del lado del servidor para que sean lo más grandes posible no tiene ningún inconveniente, aparte del aumento en el uso de memoria (intercambiando memoria por CPU), y es una forma efectiva de aumentar la rendimiento de un servidor web. Esto no es cierto para HTTP/2, ya que los datos en el búfer de envío de TCP no se pueden volver a priorizar si llega una solicitud de un recurso nuevo y más importante. Para un servidor HTTP/2, el tamaño óptimo del búfer de envío es, por lo tanto, la mínima cantidad de datos necesarios para utilizar completamente el ancho de banda disponible. Esto permite que el servidor responda inmediatamente si se recibe una solicitud de mayor prioridad.

Este problema de grandes búferes que interfieren con la (re) priorización también existe en la red, donde se conoce con el nombre de <i lang="en">"bufferbloat"</i>. El equipo de red prefiere almacenar paquetes en búfer que descartarlos cuando hay una ráfaga corta. Sin embargo, si el servidor envía más datos de los que puede consumir la ruta al cliente, estos búferes se llenan hasta su capacidad. Estos bytes ya "almacenados" en la red limitan la capacidad del servidor para enviar una respuesta de mayor prioridad antes, tal como lo hace un búfer de envío grande. Para minimizar la cantidad de datos almacenados en búferes, <a hreflang="en" href="https://blog.cloudflare.com/http-2-prioritization-with-nginx/">se debe utilizar un algoritmo de control de congestión reciente como BBR</a>.

Este <a hreflang="en" href="https://github.com/andydavies/http2-prioritization-issues">conjunto de pruebas</a> mantenido por Andy Davies mide e informa cómo se desempeñan varios CDN y servicios de alojamiento en la nube. La mala noticia es que solo 9 de los 36 servicios priorizan correctamente. La Figura 22.16 muestra que para los sitios que utilizan una CDN, alrededor del 3.7% no priorizan correctamente. Esto es superior al 26.82% del año pasado, principalmente debido al aumento en el uso de Google CDN. En lugar de depender de las prioridades enviadas por el navegador, hay algunos servidores que implementan una <a hreflang="en" href="https://blog.cloudflare.com/better-http-2-prioritization-for-a-faster-web/">priorización del lado del servidor</a> en su lugar, mejorando las sugerencias del navegador con lógica adicional.

<figure>
  <table>
    <thead>
      <tr>
        <th>CDN</th>
        <th>Prioriza <br>correctamente</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>No utiliza CDN</td>
        <td>Desconocido</td>
        <td class="numeric">59.47%</td>
        <td class="numeric">60.85%</td>
      </tr>
      <tr>
        <td>Cloudflare</td>
        <td>Pasa</td>
        <td class="numeric">22.03%</td>
        <td class="numeric">21.32%</td>
      </tr>
      <tr>
        <td>Google</td>
        <td>Falla</td>
        <td class="numeric">8.26%</td>
        <td class="numeric">8.94%</td>
      </tr>
      <tr>
        <td>Amazon CloudFront</td>
        <td>Falla</td>
        <td class="numeric">2.64%</td>
        <td class="numeric">2.27%</td>
      </tr>
      <tr>
        <td>Fastly</td>
        <td>Pasa</td>
        <td class="numeric">2.34%</td>
        <td class="numeric">1.78%</td>
      </tr>
      <tr>
        <td>Akamai</td>
        <td>Pasa</td>
        <td class="numeric">1.31%</td>
        <td class="numeric">1.19%</td>
      </tr>
      <tr>
        <td>Automattic</td>
        <td>Pasa</td>
        <td class="numeric">0.93%</td>
        <td class="numeric">1.05%</td>
      </tr>
      <tr>
        <td>Sucuri Firewall</td>
        <td>Falla</td>
        <td class="numeric">0.77%</td>
        <td class="numeric">0.63%</td>
      </tr>
      <tr>
        <td>Incapsula</td>
        <td>Falla</td>
        <td class="numeric">0.42%</td>
        <td class="numeric">0.34%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td>Falla</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.20%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Soporte de priorización HTTP/2 en CDN comunes.", sheets_gid="1152953475", sql_file="percentage_of_h2_and_h3_sites_affected_by_cdn_prioritization.sql") }}</figcaption>
</figure>

Para el uso sin CDN, esperamos que la cantidad de servidores que aplican correctamente la priorización HTTP/2 sea considerablemente menor. Por ejemplo, la implementación HTTP/2 de NodeJS <a href="https://x.com/jasnell/status/1245410283582918657">no admite la priorización</a>.

### ¿Hasta pronto server push?

<i lang="en">Server push</i> fue una de las características adicionales de HTTP/2 que causó cierta confusión y complejidad para implementar en la práctica. <i lang="en">Push</i> busca evitar esperar a que un navegador/cliente descargue una página HTML, analice esa página y solo entonces descubra que requiere recursos adicionales (como una hoja de estilo), que a su vez deben buscarse y analizarse para descubrir aún más dependencias (como las fuentes). Todo ese trabajo y viajes de ida y vuelta lleva tiempo. Con el <i lang="en">server push</i>, en teoría, el servidor puede enviar varias respuestas a la vez, evitando los viajes de ida y vuelta adicionales.

Desafortunadamente, con el control de congestión de TCP en juego, la transferencia de datos comienza tan lentamente que <a hreflang="en" href="https://calendar.perfplanet.com/2016/http2-push-the-details/">no todos los activos pueden ser empujados</a> hasta que múltiples viajes de ida y vuelta hayan aumentado suficientemente la tasa de transferencia. También existen <a hreflang="en" href="https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/">diferencias de implementación</a> entre los navegadores, ya que el modelo de procesamiento del cliente no se había acordado por completo. Por ejemplo, cada navegador tiene una implementación diferente de un <i lang="en">push cache</i>.

Otro problema es que el servidor no conoce los recursos que el navegador ya ha almacenado en caché. Cuando un servidor intenta enviar algo que no es deseado, el cliente puede enviar una trama `RST_STREAM`, pero para cuando esto suceda, es posible que el servidor ya haya enviado todos los datos. Esto desperdicia ancho de banda y el servidor ha perdido la oportunidad de enviar inmediatamente algo que el navegador realmente requería. Hubo <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-httpbis-cache-digest-05">propuestas</a> para permitir a los clientes informar al servidor sobre el estado de su caché, pero tenían problemas de privacidad.

Como se puede ver en la Figura 20.17 a continuación, un porcentaje muy pequeño de sitios utilizan <i lang="en">server push</i>.

<figure>
  <table>
    <thead>
      <tr>
        <th>Cliente</th>
        <th>Páginas HTTP/2</th>
        <th>HTTP/2 (%)</th>
        <th>Páginas gQUIC</th>
        <th>gQUIC (%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Escritorio</td>
        <td class="numeric">44,257</td>
        <td class="numeric">0.85%</td>
        <td class="numeric">204</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>Móvil</td>
        <td class="numeric">62,849</td>
        <td class="numeric">1.06%</td>
        <td class="numeric">326</td>
        <td class="numeric">0.06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption='Páginas que utilizan <i lang="en">server push</i> HTTP/2 o gQUIC.', sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

Si analizamos más a fondo las distribuciones de los activos empujados en las Figuras 22.18 y 22.19, la mitad de los sitios empujan 4 recursos o menos con un tamaño total de 140 KB en computadoras de escritorio y 3 recursos o menos con un tamaño de 184 KB en dispositivos móviles. Para gQUIC, para dispositivos de escritorio es 7 o menos y para móvil es 2. La página más infractora empuja <i lang="en">41 recursos</i> sobre gQUIC en dispositivos de escritorio.

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentil</th>
        <th>HTTP/2</th>
        <th>Tamaño (KB)</th>
        <th>gQUIC</th>
        <th>Tamaño (KB)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">1</td>
        <td class="numeric">3.95</td>
        <td class="numeric">1</td>
        <td class="numeric">15.83</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">2</td>
        <td class="numeric">36.32</td>
        <td class="numeric">3</td>
        <td class="numeric">35.93</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">4</td>
        <td class="numeric">139.58</td>
        <td class="numeric">7</td>
        <td class="numeric">111.96</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">8</td>
        <td class="numeric">346.70</td>
        <td class="numeric">21</td>
        <td class="numeric">203.59</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">17</td>
        <td class="numeric">440.08</td>
        <td class="numeric">41</td>
        <td class="numeric">390.91</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribución de activos empujados en dispositivos de escritorio.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentil</th>
        <th>HTTP/2</th>
        <th>Tamaño (KB)</th>
        <th>gQUIC</th>
        <th>Tamaño (KB)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">10</td>
        <td class="numeric">1</td>
        <td class="numeric">15.48</td>
        <td class="numeric">1</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td class="numeric">25</td>
        <td class="numeric">1</td>
        <td class="numeric">36.34</td>
        <td class="numeric">1</td>
        <td class="numeric">0.06</td>
      </tr>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">3</td>
        <td class="numeric">183.83</td>
        <td class="numeric">2</td>
        <td class="numeric">24.06</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">10</td>
        <td class="numeric">225.41</td>
        <td class="numeric">5</td>
        <td class="numeric">204.65</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">12</td>
        <td class="numeric">351.05</td>
        <td class="numeric">18</td>
        <td class="numeric">453.57</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Distribución de activos empujados en dispositivos móviles.", sheets_gid="698874709", sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_transferred.sql") }}</figcaption>
</figure>

Al observar la frecuencia de empuje por tipo de contenido en la Figura 22.20, vemos que el 90% de las páginas empujan scripts y el 56% empujan CSS. Esto tiene sentido, ya que pueden ser archivos pequeños que normalmente se encuentran en la ruta crítica para representar una página.

{{ figure_markup(
  image="http2-pushed-content-types.png",
  caption="Porcentaje de páginas que empujan tipos de contenido específicos",
  description="Un gráfico de barras que muestra las páginas que empujan recursos a dispositivos de escritorio; 89.1% empujan scripts, 67.9% css, 6.1% imágenes, 1.3% fuentes, 0.7% otros y 0.7% html. En dispositivos móviles 90.29% empujan scripts, 56.08% css, 3.69% imágenes, 0.97% fuentes, 0.36% otros y 0.39% html.", chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSOkWXtrbMfTLdhlKbBGDjRU3zKbnCQi3iPhfuKaFs5mj4smEzInDCYEnk63gBdgsJ3GFk2gf4FOKCU/pubchart?oid=1708672642&format=interactive",
  sheets_gid="238923402",
  sql_file="number_of_h2_and_h3_pushed_resources_and_bytes_by_content_type.sql"
)
}}

Dada la baja adopción, y después de medir cuán pocos de los recursos enviados son realmente útiles (es decir, coinciden con una solicitud que aún no está almacenada en caché), Google ha anunciado la <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/K3rYLvmQUBY/m/vOWBKZGoAQAJ">intención de eliminar el soporte de <i lang="en">push</i> de Chrome</a> para HTTP/2 y gQUIC. Chrome tampoco ha implementado <i lang="en">push</i> para HTTP/3.

A pesar de todos estos problemas, hay circunstancias en las que el <i lang="en">server push</i> puede proporcionar una mejora. El caso de uso ideal es poder enviar una promesa <i lang="en">push</i> mucho antes que la propia respuesta HTML. Un escenario en el que esto puede beneficiarse es <a hreflang="en" href="https://medium.com/@ananner/http-2-server-push-performance-a-further-akamai-case-study-7a17573a3317">cuando se usa una CDN</a>. El "tiempo muerto" entre la CDN que recibe la solicitud y la respuesta del origen se puede utilizar de forma inteligente para preparar la conexión TCP y enviar activos ya almacenados en caché en la CDN.

Sin embargo, no existía un método estandarizado sobre cómo enviar una señal a un servidor de perímetro de una CDN de que se debería empujar un activo. En cambio, las implementaciones reutilizaban el encabezado del enlace HTTP precargado para indicar esto. Este enfoque simple parece elegante, pero no utiliza el tiempo muerto antes de que se genere el HTML, a menos que los encabezados se envíen antes de que el contenido real esté listo. Activa el perímetro para empujar los recursos a medida que se recibe el HTML en el perímetro, lo que competirá con la entrega del HTML.

Una propuesta alternativa que se está probando es <a hreflang="en" href="https://tools.ietf.org/html/rfc8297">RFC 8297</a>, que define una respuesta informativa `103 (Early Hints)`. Esto permite que los encabezados se envíen inmediatamente, sin tener que esperar a que el servidor genere los encabezados de respuesta completos. Esto puede ser utilizado por un origen para sugerir empujar recursos a una CDN, o por una CDN para alertar al cliente sobre los recursos que deben ser solicitados. Sin embargo, en la actualidad, el soporte para esto tanto desde la perspectiva del cliente como del servidor es muy bajo, <a hreflang="en" href="https://www.fastly.com/blog/beyond-server-push-experimenting-with-the-103-early-hints-status-code">pero está creciendo</a>.

## Alcanzando un mejor protocolo

Digamos que un cliente y un servidor son compatibles con HTTP/1.1 y HTTP/2. ¿Cómo eligen cuál usar? El método más común es el <a href="https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation"><i lang="en">Application Layer Protocol Negotiation</i></a> (ALPN) de TLS, en el que los clientes envían una lista de protocolos que admiten al servidor, quien selecciona el que prefiere usar para esa conexión. Debido a que el navegador necesita negociar los parámetros TLS como parte de la establecer una conexión HTTPS, también puede negociar la versión HTTP al mismo tiempo. Dado que tanto HTTP/2 como HTTP/1.1 se pueden servir desde el mismo puerto TCP (443), los navegadores no necesitan realizar esta selección antes de abrir una conexión.

Esto no funciona si los protocolos no están en el mismo puerto, usa un protocolo de transporte diferente (TCP versus QUIC), o si no está usando TLS. Para esos escenarios, se comienza con lo que esté disponible en el primer puerto al que se conecta y luego se descubren otras opciones. HTTP define dos mecanismos para cambiar los protocolos para un origen después de conectarse: `Upgrade` y `Alt-Svc`.

### `Upgrade`

El encabezado Upgrade ha sido parte de HTTP durante mucho tiempo. En HTTP/1.x, `Upgrade` permite a un cliente realizar una solicitud usando un protocolo, pero indica su soporte para otro protocolo (como HTTP/2). Si el servidor también admite el protocolo ofrecido, responde con un estado 101 (`Switching Protocols`) y procede a responder la solicitud en el nuevo protocolo. De lo contrario, el servidor responde a la solicitud en HTTP/1.x. Los servidores pueden anunciar su compatibilidad con un protocolo diferente utilizando un encabezado `Upgrade` en una respuesta.

La aplicación más común de `Upgrade` es <a href="https://developer.mozilla.org/docs/Web/API/WebSockets_API">WebSockets</a>. HTTP/2 también define una ruta de `Upgrade`, que se puede usar con su modo de texto sin cifrar. Sin embargo, no hay soporte para esta habilidad en los navegadores web. Por lo tanto, no es sorprendente que menos del 3% de las solicitudes HTTP/1.1 de texto sin cifrar en nuestro conjunto de datos hayan recibido un encabezado `Upgrade` en la respuesta. Un número muy pequeño de solicitudes que utilizan TLS (0.0011% de HTTP/2, 0.064% de HTTP/1.1) también recibieron encabezados `Upgrade` como respuesta; estos son probablemente servidores HTTP/1.1 de texto sin cifrar detrás de intermediarios que hablan HTTP/2 y/o hacen terminación TLS, pero no eliminan correctamente los encabezados `Upgrade`.

### Alternative Services

<i lang="en">Alternative Services</i> (`Alt-Svc`) habilita un origen HTTP para indicar otros puntos finales que sirven el mismo contenido, posiblemente a través de diferentes protocolos. Aunque es poco común, HTTP/2 puede estar ubicado en un puerto o <i lang="en">host</i> diferente del servicio HTTP/1.1 de un sitio. Más importante aún, dado que HTTP/3 usa QUIC (por lo tanto, UDP) donde las versiones anteriores de HTTP usan TCP, HTTP/3 siempre estará en un punto final diferente del servicio HTTP/1.x y HTTP/2.

Cuando se usa `Alt-Svc`, un cliente realiza solicitudes al origen de forma normal. Sin embargo, si el servidor incluye un encabezado o envía una trama que contiene una lista de alternativas, el cliente puede establecer una nueva conexión con el punto final y usarla para futuras solicitudes a ese origen.

Como era de esperar, el uso de `Alt-Svc` se encuentra casi en su totalidad en servicios que utilizan versiones HTTP avanzadas: el 12.0% de las solicitudes HTTP/2 y el 60.1% de las solicitudes gQUIC recibieron un encabezado `Alt-Svc` como respuesta, en comparación con el 0.055% de solicitudes HTTP/1.x. Tenga en cuenta que nuestra metodología aquí solo captura los encabezados `Alt-Svc`, no las tramas `ALTSVC` en HTTP/2, por lo que la realidad puede estar un poco subestimada.

Si bien `Alt-Svc` puede apuntar a un <i lang="en">host</i> completamente diferente, la compatibilidad con esta habilidad varía entre los navegadores. Solo el 4.71% de los encabezados `Alt-Svc` anunciaban un punto final en un <i lang="en">hostname</i> diferente; estos eran casi universalmente (99.5%) publicidad de compatibilidad con gQUIC y HTTP/3 en Google Ads. Google Chrome ignora los anuncios `Alt-Svc` entre <i lang="en">hosts</i> para HTTP/2, por lo que muchas de las otras instancias se habrían ignorado.

Dada la rareza del soporte para HTTP/2 entre <i lang="en">hosts</i>, no es sorprendente que prácticamente no haya anuncios (0.007%) para los puntos finales HTTP/2 usando `Alt-Svc`. `Alt-Svc` se usaba normalmente para indicar la compatibilidad con HTTP/3 (74.6% de los encabezados `Alt-Svc`) o gQUIC (38.7% de los encabezados `Alt-Svc`).

## Mirando hacia el futuro: HTTP/3

HTTP/2 es un protocolo poderoso, que ha tenido una adopción considerable en solo unos pocos años. Sin embargo, HTTP/3 sobre QUIC ya se está asomando a la vuelta de la esquina. Con más de cuatro años de preparación, esta próxima versión de HTTP está casi estandarizada en el IETF (se espera para la primera mitad de 2021). En este momento, ya hay <a hreflang="en" href="https://github.com/quicwg/base-drafts/wiki/Implementations">muchas implementaciones QUIC y HTTP/3 disponibles</a>, tanto para servidores como para navegadores web. Si bien estos son relativamente maduros, todavía se puede decir que están en un estado experimental.

Esto se refleja en los números de uso en los datos del HTTP Archive, donde no se identificaron solicitudes HTTP/3. Esto puede parecer un poco extraño, ya que <a hreflang="en" href="https://blog.cloudflare.com/experiment-with-http-3-using-nginx-and-quiche/">Cloudflare</a> ha tenido soporte HTTP/3 experimental durante algún tiempo, al igual que Google y Facebook. Esto se debe principalmente a que Chrome no había habilitado el protocolo de forma predeterminada cuando se recopilaron los datos.

Sin embargo, incluso los números de gQUIC más antiguos son relativamente modestos y representan menos del 2% de las solicitudes en general. Esto es de esperar, ya que gQUIC fue implementado principalmente por Google y Akamai; otras partes estaban esperando IETF QUIC. Como tal, se espera que pronto gQUIC sea reemplazado por completo por HTTP/3.

{{ figure_markup(
  caption="El porcentaje de solicitudes que usan gQUIC en dispositivos de escritorio y móviles.",
  content="1.72%",
  classes="big-number",
  sheets_gid="2122693316",
  sql_file="adoption_of_http_2_by_site_and_requests.sql"
)
}}

Es importante tener en cuenta que esta baja adopción solo refleja el uso de gQUIC y HTTP/3 para cargar páginas web. Desde hace varios años, Facebook ha tenido una implementación mucho más extensa de IETF QUIC y HTTP/3 para cargar datos dentro de sus aplicaciones nativas. <a hreflang="en" href="https://engineering.fb.com/2020/10/21/networking-traffic/how-facebook-is-bringing-quic-to-billions/">QUIC y HTTP/3 ya representan más del 75% de su tráfico total de Internet</a>. ¡Está claro que HTTP/3 recién está comenzando!

Ahora podría preguntarse: si no todo el mundo está usando HTTP/2, ¿por qué necesitaríamos HTTP/3 tan pronto? ¿Qué beneficios podemos esperar en la práctica? Echemos un vistazo más de cerca a sus mecanismos internos.

### QUIC y HTTP/3

Los intentos anteriores de implementar nuevos protocolos de transporte en Internet han resultado difíciles, por ejemplo, el [Stream Control Transmission Protocol](https://es.wikipedia.org/wiki/Stream_Control_Transmission_Protocol) (SCTP). QUIC es un nuevo protocolo de transporte que se ejecuta sobre UDP. Proporciona características similares a TCP, como entrega en orden confiable  y control de congestión para evitar inundaciones en la red.

Como se discutió en la sección [HTTP/1.0 a HTTP/2](#http10-a-http2), HTTP/2 _multiplexa_ múltiples flujos diferentes encima de una sola conexión. El propio TCP lamentablemente desconoce este hecho, lo que provoca ineficiencias o un impacto en el rendimiento cuando se producen retrasos o pérdidas de paquetes. Más detalles sobre este problema, conocido como _bloqueo de cabecera de línea_ (bloqueo HOL), <a hreflang="en" href="https://github.com/rmarx/holblocking-blogpost">se puede encontrar aquí</a>.

QUIC resuelve el problema de bloqueo HOL al llevar los flujos de HTTP/2 a la capa de transporte y realizar la detección y retransmisión de pérdidas por flujo. Entonces, simplemente colocamos HTTP/2 sobre QUIC, ¿verdad? Bueno, ya hemos [mencionado](#reduciendo-conexiones) algunas de las dificultades que surgen de tener control de flujo en TCP y HTTP/2. Ejecutar dos sistemas de transmisión separados y competidores uno encima del otro sería un problema adicional. Además, debido a que los flujos QUIC son independientes, interferiría con los estrictos requisitos de orden que HTTP/2 requiere para varios de sus sistemas.

Al final, se consideró más fácil definir una nueva versión HTTP que usara QUIC directamente, y así, nació HTTP/3. Sus características de alto nivel son muy similares a las que conocemos de HTTP/2, pero los mecanismos de implementación internos son bastante diferentes. La compresión del encabezado HPACK se reemplaza por <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-quic-qpack-19">QPACK</a>, que permite un <a hreflang="en" href="https://blog.litespeedtech.com/tag/quic-header-compression-design-team/">ajuste manual</a> de la eficiencia de compresión versus el riesgo de bloqueo HOL, y el sistema de priorización está siendo <a hreflang="en" href="https://blog.cloudflare.com/adopting-a-new-approach-to-http-prioritization/">reemplazado por uno más simple</a>. Este último también podría ser backportado a HTTP/2, posiblemente ayudando a resolver los problemas de priorización discutidos anteriormente en este artículo. HTTP/3 sigue proporcionando un mecanismo de <i lang="en">server push</i>, pero Chrome, por ejemplo, no lo implementa.

Otro beneficio de QUIC es que puede migrar conexiones y mantenerlas activas incluso cuando cambia la red subyacente. Un ejemplo típico es el llamado "problema del estacionamiento". Imagine que su teléfono inteligente está conectado a la red Wi-Fi del lugar de trabajo y acaba de comenzar a descargar un archivo grande. Al salir del alcance de Wi-Fi, su teléfono cambia automáticamente a la nueva y elegante red celular 5G. Con el simple y antiguo TCP, la conexión se rompería y provocaría una interrupción. Pero QUIC es más inteligente; utiliza un _ID de conexión_, que es más resistente a los cambios de red, y proporciona una función de _migración de conexión_ activa para que los clientes cambien sin interrupción.

Finalmente, TLS ya se utiliza para proteger HTTP/1.1 y HTTP/2. Sin embargo, QUIC tiene una integración profunda de TLS 1.3, que protege tanto los datos HTTP/3 y los metadatos de los paquetes QUIC, como por ejemplo los números de paquete. El uso de TLS de esta manera mejora la privacidad y la seguridad del usuario final y facilita la evolución continua del protocolo. Combinar el transporte y los apretones de manos criptográficos significa que la configuración de la conexión requiere solo un RTT, en comparación con el mínimo de TCP de dos y en el peor de los casos de cuatro. En algunos casos, QUIC puede incluso ir un paso más allá y enviar datos HTTP junto con su primer mensaje, que se llama _0-RTT_. Se espera que estos tiempos rápidos de preparación de conexión realmente ayuden a HTTP/3 a superar a HTTP/2.

**Entonces, ¿HTTP/3 ayudará?**

En la superficie, HTTP/3 no es realmente tan diferente de HTTP/2. No agrega ninguna característica importante, pero principalmente cambia la forma en que funcionan las características debajo de la superficie. Las mejoras reales provienen de QUIC, que ofrece configuraciones de conexión más rápidas, mayor solidez y resistencia a la pérdida de paquetes. Como tal, se espera que HTTP/3 funcione mejor que HTTP/2 en redes no tan buenas, mientras que ofrece un rendimiento muy similar en sistemas más rápidos. Sin embargo, eso es si la comunidad web puede hacer que HTTP/3 funcione, lo que puede ser un desafío en la práctica.

### Implementando y descubriendo HTTP/3

Dado que QUIC y HTTP/3 se ejecutan sobre UDP, las cosas no son tan simples como con HTTP/1.1 o HTTP/2. Normalmente, un cliente HTTP/3 tiene que descubrir primero que QUIC está disponible en el servidor. El método recomendado para esto es <i lang="en">[Alternative Services de HTTP](#alternative-services)</i>. En su primera visita a un sitio web, un cliente se conecta a un servidor mediante TCP. Luego descubre a través de `Alt-Svc` que HTTP/3 está disponible y puede configurar una nueva conexión QUIC. La entrada `Alt-Svc` se puede almacenar en caché, lo que permite que las visitas posteriores eviten el paso de TCP, pero la entrada eventualmente se volverá obsoleta y necesitará una revalidación. Es probable que esto deba hacerse para cada dominio por separado, lo que probablemente conducirá a que la mayoría de las cargas de página utilicen una combinación de HTTP/1.1, HTTP/2 y HTTP/3.

Sin embargo, incluso si se sabe que un servidor admite QUIC y HTTP/3, la red intermedia podría bloquearlo. El tráfico UDP se usa comúnmente en ataques DDoS y se bloquea de forma predeterminada en, por ejemplo, muchas redes de empresas. Si bien se pueden hacer excepciones para QUIC, su cifrado dificulta que los firewalls evalúen el tráfico. Existen soluciones potenciales para estos problemas, pero mientras tanto se espera que QUIC tenga más probabilidades de tener éxito en puertos conocidos como 443. Y es muy posible que QUIC esté bloqueado por completo. En la práctica, es probable que los clientes utilicen mecanismos sofisticados para recurrir a TCP si QUIC falla. Una opción es "competir" con una conexión TCP y QUIC y usar la que se complete primero.

Existe un trabajo en curso para definir formas de descubrir HTTP/3 sin necesidad del paso TCP. Sin embargo, esto debe considerarse una optimización, ya que es probable que los problemas de bloqueo de UDP signifiquen que HTTP basado en TCP se mantiene. El <a hreflang="en" href="https://tools.ietf.org/html/draft-ietf-dnsop-svcb-https">registro DNS de HTTPS</a> es similar a <i lang="en">servicios alternativos</i> de HTTP y algunas CDN ya están <a hreflang="en" href="https://blog.cloudflare.com/speeding-up-https-and-http-3-negotiation-with-dns/">experimentando con estos registros</a>. A largo plazo, cuando la mayoría de los servidores ofrezcan HTTP/3, los navegadores podrán cambiar a intentarlo de forma predeterminada; eso llevará mucho tiempo.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">HTTP/1.x</th>
        <th scope="colgroup" colspan="2">HTTP/2</th>
      </tr>
      <tr>
        <th scope="col">Versión TLS</th>
        <th scope="col">Escritorio</th>
        <th scope="col">Móvil</th>
        <th scope="col">Escritorio</th>
        <th scope="col">Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>desconocido</td>
        <td class="numeric">4.06%</td>
        <td class="numeric">4.03%</td>
        <td class="numeric">5.05%</td>
        <td class="numeric">7.28%</td>
      </tr>
      <tr>
        <td>TLS 1.2</td>
        <td class="numeric">26.56%</td>
        <td class="numeric">24.75%</td>
        <td class="numeric">23.12%</td>
        <td class="numeric">23.14%</td>
      </tr>
      <tr>
        <td>TLS 1.3</td>
        <td class="numeric">5.25%</td>
        <td class="numeric">5.11%</td>
        <td class="numeric">35.78%</td>
        <td class="numeric">35.54%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adopción de TLS por versión HTTP.", sheets_gid="900140630", sql_file="tls_adoption_by_http_version.sql") }}</figcaption>
</figure>

QUIC depende de TLS 1.3, que se utiliza para alrededor del 41% de las solicitudes, como se muestra en la Figura 22.21. Eso deja al 59% de las solicitudes que necesitarán actualizar su versión de TLS para admitir HTTP/3.

### ¿HTTP/3 está ya listo?

Entonces, ¿cuándo podremos comenzar a usar HTTP/3 y QUIC de verdad? Todavía no, pero se espera que pronto. Existe una <a hreflang="en" href="https://github.com/quicwg/base-drafts/wiki/Implementations">gran cantidad de implementaciones <i lang="en">open source</i> maduras</a> y los principales navegadores tienen soporte experimental. Sin embargo, la mayoría de los servidores típicos han sufrido algunos retrasos: nginx está un poco por detrás de otros, Apache no ha anunciado soporte oficial y NodeJS depende de OpenSSL, que <a hreflang="en" href="https://github.com/openssl/openssl/pull/8797">no agregará soporte QUIC pronto</a>. Aun así, esperamos ver un aumento de las implementaciones de HTTP/3 y QUIC a lo largo de 2021.

HTTP/3 y QUIC son protocolos muy avanzados con potentes funciones de rendimiento y seguridad, como un nuevo sistema de priorización HTTP, eliminación de bloqueo HOL y establecimiento de conexión 0-RTT. Esta sofisticación también los hace difíciles de implementar y usar correctamente, como ha resultado ser el caso de HTTP/2. Predecimos que las implementaciones tempranas se realizarán principalmente a través de la adopción temprana de CDN como Cloudflare, Fastly y Akamai. Esto probablemente signifique que una gran parte del tráfico HTTP/2 puede actualizarse automáticamente a HTTP/3 en 2021, lo que le daría al nuevo protocolo una gran parte del tráfico casi listo para usar. Cuándo y si las implementaciones más pequeñas seguirán su ejemplo es más difícil de responder. Lo más probable es que sigamos viendo una combinación saludable de HTTP/3, HTTP/2 e incluso HTTP/1.1 en la web durante los próximos años.

## Conclusión

Este año, HTTP/2 se ha convertido en el protocolo dominante, atendiendo el 64% de todas las solicitudes, habiendo crecido 10 puntos porcentuales durante el año. Las páginas de inicio han experimentado un aumento del 13% en la adopción de HTTP/2, lo que ha llevado a una división uniforme de las páginas servidas a través de HTTP/1.1 y HTTP/2. El uso de una CDN para servir su página de inicio impulsa la adopción de HTTP/2 hasta un 80%, en comparación con el 30% para el uso sin CDN. Quedan algunos servidores más antiguos, Apache e IIS, que se han mostrado resistentes a la actualización a HTTP/2 y TLS. Un gran éxito ha sido la disminución en el uso de conexiones de sitios web debido a la multiplexación de conexiones HTTP/2. El número medio de conexiones en 2016 fue de 23 en comparación con 13 en 2020.

La priorización de HTTP/2 y el <i lang="en">server push</i> han resultado ser mucho más complejas de implementar en general. En determinadas implementaciones, muestran claros beneficios de rendimiento. Sin embargo, existe una barrera importante para implementar y ajustar los servidores existentes para utilizar estas funciones de manera eficaz. Todavía hay una gran proporción de CDN que no apoyan la priorización de manera efectiva. También ha habido problemas con la consistencia de la compatibilidad del navegador.

HTTP/3 está a la vuelta de la esquina. Será fascinante seguir la tasa de adopción, ver cómo evolucionan los mecanismos de descubrimiento y descubrir qué nuevas funciones se implementarán con éxito. Esperamos que el Web Almanac del próximo año vea algunos datos nuevos e interesantes.
