---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: JavaScript
description: Capítulo sobre JavaScript del Web Almanac 2020 que cubre cuánto JavaScript usamos en la web, compresión, librerías y <i lang="en">frameworks</i>, cargado y <i lang="en">source maps</i>.
authors: [tkadlec]
reviewers: [ibnesayeed, denar90]
analysts: [rviscomi, paulcalvano]
editors: [rviscomi]
translators: [alangdm]
tkadlec_bio: Tim es un consultor y entrenador sobre desempeño web enfocado en crear una web que todos podamos usar. El es autor de <i lang="en">High Performance Images</i> (O'Reilly, 2016) y <i lang="en">Implementing Responsive Design</i> (New Riders, 2012). Él escribe sobre la web en general en <a hreflang="en" href="https://timkadlec.com/">timkadlec.com</a>. Puedes encontrarlo compartiendo sus opiniones en un formato más breve en Twitter con el usuario <a href="https://twitter.com/tkadlec">@tkadlec</a>.
discuss: 2038
results: https://docs.google.com/spreadsheets/d/1cgXJrFH02SHPKDGD0AelaXAdB3UI7PIb5dlS0dxVtfY/
featured_quote: JavaScript ha avanzado mucho desde su origen humilde hasta ser considerado el tercer pilar de la web junto con CSS y HTML. Hoy en día, JavaScript ha comenzado a invadir un amplio espectro del <i lang="en">stack</i> técnico. JavaScript ya no se encuentra limitado al lado del cliente y se ha convertido en una elección cada vez más popular para crear herramientas de construcción y <i lang="en">scripting</i> del lado del servidor. JavaScript también se ha adentrado en la capa de CDN gracias a soluciones de <i lang="en">edge computing</i>.
featured_stat_1: 1,897ms
featured_stat_label_1: Mediana de tiempo de ejecución del hilo principal de JS en móviles
featured_stat_2: 37.22%
featured_stat_label_2: Porcentaje de JS sin usar en móviles
featured_stat_3: 12.2%
featured_stat_label_3: Porcentaje de <i lang="en">scripts</i> cargados asíncronamente
---

## Introducción

JavaScript ha avanzado mucho desde su origen humilde hasta ser considerado el tercer pilar de la web junto con CSS y HTML. Hoy en día, JavaScript ha comenzado a invadir un amplio espectro del <i lang="en">stack</i> técnico. JavaScript ya no se encuentra limitado al lado del cliente y se ha convertido en una elección cada vez más popular para crear herramientas de construcción y <i lang="en">scripting</i> del lado del servidor. JavaScript también se ha adentrado en la capa de CDN gracias a soluciones de <i lang="en">edge computing</i>.

Los desarrolladores amamos usar JavaScript. De acuerdo con el capítulo de marcado, el elemento `script` es el [6to elemento de HTML más popular](./markup) en uso (por delante de elementos tales como `p` e `i` entre muchos otros). Utilizamos más de 14 veces más bytes de JavaScript de los que usamos de HTML, los bloques para construir la web, y 6 veces más bytes que los que usamos de CSS.

{{ figure_markup(
  image="../page-weight/bytes-distribution-content-type.png",
  caption="Mediana de tamaño de página por tipo de contenido.",
  description="Gráfica de barras mostrando la mediana de tamaño de página para páginas móviles y de escritorio dividida en imágenes, JS, CSS y HTML. La mediana de bytes para cada tipo de contenido en páginas móviles es de: 916 KB de imágenes, 411 KB de JS, 62 KB de CSS y 25 KB de HTML. Las páginas de escritorio tienden a tener imágenes de mayor tamaño (alrededor de 1000 KB) y una ligera mayor cantidad de JS (alrededor de 450 KB).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQlN4Clqeb8aPc63h0J58WfBxoJluSFT6kXn45JGPghw1LGU28hzabMYAATXNY5st9TtjKrr2HnbfGd/pubchart?oid=1147150650&format=interactive",
  sheets_gid="https://docs.google.com/spreadsheets/d/1wG4u0LV5PT9aN-XB1hixSFtI8KIDARTOCX0sp7ZT3h0/#378779486",
  sql_file="../page-weight/bytes_per_type_2020.sql"
) }}

Pero nada es gratis y esto aplica especialmente para JavaScript. Todo ese código tiene un costo. Veamos con más detalle cuánto código usamos, cómo lo usamos y cuáles son los efectos secundarios de este.

## ¿Cuánto JavaScript usamos?

Mencionamos que la etiqueta `script` es el 6to elemento de HTML más usado. Entremos más en detalle para ver cuánto JavaScript está contenido ahí.

Un sitio ubicado en la mediana (percentil 50) envía 444 KB de JavaScript al ser cargado en un dispositivo de escritorio y un poco menos que eso (411 KB) a un dispositivo móvil.

{{ figure_markup(
  image="bytes-2020.png",
  caption="Distribución de la cantidad de kilobytes cargados por página.",
  description="Gráfica de barras mostrando la distribución de bytes de JavaScript por página en intervalos de 10%. Las páginas de escritorio consistentemente cargan más bytes de JavaScript que las páginas móviles. Los percentiles 10, 25, 50, 75 y 90 para escritorio son de: 87 KB, 209 KB, 444 KB, 826 KB y 1,322 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=441749673&format=interactive",
  sheets_gid="2139688512",
  sql_file="bytes_2020.sql"
) }}

Es un poco decepcionante no ver una mayor diferencia. Si bien es peligroso hacer muchas suposiciones sobre la red o el poder de procesamiento basados en si el dispositivo es un teléfono o una computadora de escritorio (o algo intermedio), debemos recalcar que las [pruebas en móviles del <i lang="en">HTTP Archive</i>](./methodology#webpagetest) son hechas emulando un Moto G4 en una red 3G. En otras palabras, si existiese algún trabajo para adaptarse a condiciones no ideales y transmitir menos código estas pruebas deberían demostrarlo.

La tendencia parece estar a favor de usar más JavaScript, no menos. Comparando con [los resultados del año pasado](../2019/javascript#how-much-javascript-do-we-use), vemos un incremento de 13.4% en la mediana de JavaScript al probar en un dispositivo de escritorio y un incremento de 14.4% en la cantidad de JavaScript enviado a un dispositivo móvil.

<figure>
  <table>
    <thead>
      <tr>
        <th>Cliente</th>
        <th>2019</th>
        <th>2020</th>
        <th>Cambio</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Escritorio</td>
        <td class="numeric">391</td>
        <td class="numeric">444</td>
        <td class="numeric">13.4%</td>
      </tr>
      <tr>
        <td>Móvil</td>
        <td class="numeric">359</td>
        <td class="numeric">411</td>
        <td class="numeric">14.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Cambio año a año en la mediana de kilobytes de JavaScript por página.",
      sheets_gid="86213362",
      sql_file="bytes_2020.sql"
    ) }}
  </figcaption>
</figure>

Al menos parte de este tamaño parece ser innecesario. Si vemos un desglose de cuanto JavaScript no es usado al cargar una página, podemos ver que una página ubicada en la mediana transmite 152 KB de JavaScript que no es usado. Este número sube a 334 KB en el percentil 75 y a 567 KB en el percentil 90.

{{ figure_markup(
  image="unused-js-bytes-distribution.png",
  caption="Distribución de la cantidad de bytes de JavaScript desperdiciados por página móvil.",
  description="Gráfica de barras mostrando la distribución de bytes de JavaScript desperdiciados por página. Para los percentiles 10, 25, 50, 75 y 90 la distribución es: 0, 57, 153, 335 y 568 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=773002950&format=interactive",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

Los números sin procesar pueden o no saltar a tu vista dependiendo de que tan aficionado seas a optimizar el desempeño, pero al verlo como un porcentaje del total de JavaScript usado en cada página, se vuelve un poco más fácil ver que tanto código extra se está enviando.

{{ figure_markup(
  caption="Porcentaje de los bytes de JavaScript en una página ubicada en la mediana que no son usados.",
  content="37.22%",
  classes="big-number",
  sheets_gid="611267860",
  sql_file="unused_js_bytes_distribution.sql"
) }}

Esos 153 KB equivalen a alrededor de 37% del tamaño total del código que le enviamos a los dispositivos móviles. Esto definitivamente puede mejorar.

### `module` y `nomodule`
Un mecanismo que tenemos que tiene el potencial de reducir la cantidad de código que enviamos es utilizar <a hreflang="en" href="https://web.dev/serve-modern-code-to-modern-browsers/">el patrón `module`/`nomodule`</a>. Con este patrón, creamos dos <i lang="en">bundles</i>: uno para navegadores modernos y otro para navegadores <i lang="en">legacy</i>. Al <i lang="en">bundle</i> para navegadores modernos se le asigna `type=module` y al <i lang="en">bundle</i> para navegadores <i lang="en">legacy</i> se le asigna `type=nomodule`.

Esta estrategia nos permite crear <i lang="en">bundles</i> más pequeños utilizando sintaxis moderna optimizada para los browsers que son compatibles, mientras tanto, también proveemos <i lang="en">polyfills</i> cargados condicionalmente y una sintaxis diferente para los que no son compatibles.

La compatibilidad con `module` y `nomodule` va en aumento pero aún es una estrategia relativamente nueva. Como resultado, la adopción aún es baja. Sólo 3.6% de las páginas móviles usa al menos un script con `type=module` y sólo 0.7% de las páginas móviles usa al menos un script con `type=nomodule` para ser compatible con navegadores <i lang="en">legacy</i>.

### Conteo de peticiones

Otra manera de ver cuánto JavaScript usamos es explorar cuantas peticiones de JavaScript son hechas por página. Reducir el número de peticiones era fundamental para tener un buen desempeño usando HTTP/1.1, sin embargo, con HTTP/2 aplica lo contrario: dividir el código en JavaScript en <a hreflang="en" href="https://web.dev/granular-chunking-nextjs/">archivos individuales y más pequeños</a> resulta en [un mejor desempeño en general.](../2019/http#impact-of-http2).

{{ figure_markup(
  image="requests-2020.png",
  caption="Distribución de peticiones de JavaScript por página.",
  description="Gráfica de barras mostrando la distribución de peticiones de JavaScript por página en 2020. Los percentiles 10, 25, 50, 75 y 90 para páginas móviles son: 4, 10, 19, 34 y 55. Las páginas de escritorio tienden a tener 0 o 1 petición más por página.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=153746548&format=interactive",
  sheets_gid="1804671297",
  sql_file="requests_2020.sql"
) }}

En la mediana, las páginas hacen 20 peticiones de JavaScript. Esto es un incremento menor con respecto al año pasado cuando una página en la mediana hacía 19 peticiones de JavaScript.

{{ figure_markup(
  image="requests-2019.png",
  caption="Distribución de peticiones de JavaScript por página en 2019.",
  description="Gráfica de barras mostrando la distribución de peticiones de JavaScript por página en 2020. Los percentiles 10, 25, 50, 75 y 90 para páginas móviles son: 4, 9, 18, 32 y 52. Los resultados son ligeramente menores a los resultados de 2020.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=528431485&format=interactive",
  sheets_gid="1983394384",
  sql_file="requests_2019.sql"
) }}

## ¿De dónde viene el incremento?

Una tendencia que posiblemente contribuye al incremento en la cantidad de JavaScript usado en nuestras páginas es la cantidad cada vez mayor de scripts de terceros que son añadidos a las páginas para ayudar con cosas desde pruebas A/B en el lado del cliente y análiticos hasta commerciales y personalización.

Veamos esto más a detalle para ver cuantos scripts de terceros estamos enviando.

Justo hasta la mediana, los sitios envían aproximadamente la misma cantidad de scripts propios que de terceros. En la mediana, 9 scripts por página son propios y 10 son de terceros. Desde ese punto, la diferencia crece un poco: mientras más scripts envía un sitio en total, es mayor la probabilidad de que la mayoría de esos scripts sean de terceros.

{{ figure_markup(
  image="requests-by-3p-desktop.png",
  caption="Distribución del número de peticiones de JavaScript por dominio en escritorio.",
  description="Gráfica de barras mostrando la distribución de peticiones de JavaScript por dominio para escritorio. Los percentiles 10, 25, 50, 75 y 90 para peticiones propias son de: 2, 4, 9, 17 y 30 peticiones por página. El número de peticiones a terceros es ligeramente mayor en los percentiles altos por desde 1 hasta 6 peticiones.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1566679225&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

{{ figure_markup(
  image="requests-by-3p-mobile.png",
  caption="Distribución del número de peticiones de JavaScript por dominio en móviles.",
  description="Gráfica de barras mostrando la distribución de peticiones de JavaScript por dominio para escritorio. Los percentiles 10, 25, 50, 75 y 90 para peticiones propias son de: 2, 4, 9, 17 y 30 peticiones por página. Estos números son iguales a los de escritorio. El número de peticiones a terceros es ligeramente mayor en los percentiles altos por desde 1 hasta 5 peticiones, una situación similar a la de escritorio.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1465647946&format=interactive",
  sheets_gid="978380311",
  sql_file="requests_by_3p.sql"
) }}

Si bien la cantidad de peticiones de JavaScript es similar en la mediana, el tamaño real de esos scripts está cargado hacia los scripts de terceros. Un sitio en la mediana envía 267 KB de JavaScript de terceros a dispositivos de escritorio, comparado a 147 KB de scripts propios. La situación es similar en móviles, donde un sitio en la mediana envía 255 KB de scripts de terceros contra 134 KB de scripts propios.

{{ figure_markup(
  image="bytes-by-3p-desktop.png",
  caption="Distribución de la cantidad de bytes de JavaScript por dominio para escritorio.",
  description="Gráfica de barras mostrando la distribución de la cantidad de bytes de JavaScript por dominio para escritorio. Los percentiles 10, 25, 50, 75 y 90 para scripts propios son: 21, 67, 147, 296 y 599 KB por página. La cantidad de bytes de scripts de terceros por página aumenta en cantidades mucho mayores en percentiles altos por hasta 343 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1749995505&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

{{ figure_markup(
  image="bytes-by-3p-mobile.png",
  caption="Distribución de la cantidad de bytes de JavaScript por dominio para móviles.",
  description="Gráfica de barras mostrando la distribución de la cantidad de bytes de JavaScript por dominio para móviles. Los percentiles 10, 25, 50, 75 y 90 para scripts propios son: 18, 60, 134, 275 y 560 KB por página. Estos números son consistentemente menores que los de escritorio, pero sólo por 10-30 KB. Al igual que en escritorio, la cantidad de bytes de scripts de terceros por página aumenta, en móviles la diferencia no es tan amplia, es de 328 KB en el percentil 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=231883913&format=interactive",
  sheets_gid="1145367011",
  sql_file="bytes_by_3p.sql"
) }}

## ¿Cómo cargamos JavaScript?

La manera en la que cargamos JavaScript tiene un impacto significativo en la experiencia en general.

JavaScript _bloquea al analizador sintáctico_ por defecto. En otras palabras, cuando el navegador encuentra un elemento `script`, debe pausar el análisis del HTML hasta que el script haya sido descargado, analizado y ejecutado. Esto es un cuello de botella significativo y es una causa común de que las páginas se muestren lentamente.

Podemos comenzar a compensar el costo de cargar JavaScript haciendo que los scripts se descarguen asíncronamente (usando el atributo `async`), este atributo sólo detiene el analizador de HTML durante las fases de análisis y ejecución de JavaScript y no durante la de descarga, o diferidamente (usando el atributo `defer`), este atributo no detiene al analizador de HTML nunca. Ambos atributos sólo pueden aplicarse a scripts externos, no se pueden aplicar a scripts _inline_.

En móviles, los scripts externos representan el 59.0% de todos los scripts encontrados.

<p class="note">
  Como nota, cuando hablamos anteriormente acerca de cuánto JavaScript es cargado en una página, ese total no tomaba en cuenta el tamaño de los scripts _inline_. Debido a que son parte del documento HTML, se cuentan como parte del tamaño de marcado. Esto significa que cargamos aún más scripts de lo que los números muestran.
</p>

{{ figure_markup(
  image="external-inline-mobile.png",
  caption="Distribución del número de scripts externos e _inline_ por página móvil.",
  description="Gráfica de pie mostrando que 41.0% de los scripts en móviles son _inline_ y 59.0% son externos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1326937127&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

De los scripts externos, sólo el 12.2% son cargados con el atributo `async` y 6.0% son cargados con el atributo `defer`.

{{ figure_markup(
  image="async-defer-mobile.png",
  caption="Distribución del número de scripts `async` y `defer` por página móvil.",
  description="Gráfica de pie mostrando que el 12.2% de los script externos en móviles usan async, 6.0% usa defer y 81.8% no usa ninguno de los dos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=662584253&format=interactive",
  sheets_gid="1991661912",
  sql_file="breakdown_of_scripts_using_async_defer_module_nomodule.sql"
) }}

Tomando en consideración que `defer` provee el mejor desempeño al cargar (ya que se asegura que la descarga del script ocurre en paralelo a otras tareas y la ejecución se realiza hasta después de que la página pueda ser mostrada), desearíamos que el porcentaje de uso fuera mayor. De hecho, el 6.0% anterior está un poco inflado.

Cuando el soporte para IE8 e IE9 era más común, era relativamente común usar _ambos atributos_. Cuando ambos están presentes, cualquier navegador que soporte ambos usará `async`. IE8 e IE9 no soportan `async` entonces usarán `defer`.

En días recientes, este patrón no es necesario para la mayoría de los sitios y cualquier script cargado con este patrón interrumpirá al analizador de HTML cuando debe ser ejecutado, en lugar de diferir hasta que la página haya cargado. Este patrón tiene un uso sorprendentemente frecuente, 11.4% de las páginas móviles tienen al menos un script con este patrón. En otras palabras, al menos una parte del 6% de scripts que usan `defer` no están obteniendo los beneficios del atributo `defer`.

Pero hay una historia alentadora sobre esto.

Harry Roberts [hizo un _tweet_ sobre este antipatrón en Twitter](https://twitter.com/csswizardry/status/1331721659498319873), lo cual fue lo que nos motivó a medir que tan frecuentemente ocurre en realidad. [Rick Viscomi revisó quiénes eran culpables de esto con mayor frecuencia](https://twitter.com/rick_viscomi/status/1331735748060524551), y resultó que "stats.wp.com" era la fuente de los culpables más frecuentes. @Kraft de Automattic respondió y el patrón será [removido de ahora en adelante](https://twitter.com/Kraft/status/1336772912414601224)

Una de las grandes ventajas sobre lo abierta que es la web es que una observación puede llevar a un cambio significativo como el que vimos aquí.

### _Resource hints_

Otra herramienta que tenemos a nuestra disposición para compensar algunos de los costos de cargar JavaScript son los [_resource hints_](./resource-hints), específicamente `prefetch` y `preload`.

El _hint_ de `prefetch` permite a los desarrolladores indicar que un recurso será utilizado en la siguiente navegación de página, por ende el navegador deberá intentar descargarlo una vez que se encuentre desocupado.

El _hint_ de `preload` indica que un recurso será utilizado en la página actual y que el browser lo debería tratar de descargar cuanto antes posible.

Globalmente, 16.7% de las páginas móviles usa al menos uno de estos dos _resource hints_ para cargar JavaScript proactivamente.

De ese 16.7%, casi todo el uso viene de usar `preload`. Mientras que el 16.6% de las páginas móviles usa al menos un _hint_ de preload para cargar JavaScript, sólo el 0.4% de las páginas móviles usan al menos un _hint_ de `prefetch`.

Existe un riesgo, en particular con `preload`, al usar demasiados _hints_ pues se reduce su eficacia, así que vale la pena analizar las páginas que usan estos _hints_ para ver cuántos usan.

{{ figure_markup(
  image="prefetch-distribution.png",
  caption="Distribución del número de _hints_ de `prefetch` por página que tiene dichos _hints_.",
  description="Gráfica de barras mostrando la distribución de _hints_ de prefetch por página que tiene dichos _hints_. Los percentiles 10, 25 y 50 para páginas de escritorio y móviles es de 1, 2 y 3 _hints_ de prefecth por página. En el percentil 75 el número es 6 para páginas de escritorio y 4 para móviles. En el percentil 90 las páginas de escritorio usan 14 _hints_ de prefetch por página y 12 en páginas móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1874381460&format=interactive",
  sheets_gid="1910228743",
  sql_file="resource-hints-preload-prefetch-distribution.sql"
) }}

{{ figure_markup(
  image="preload-distribution.png",
  caption="Distribución del número de _hints_ de `preload` por página que tiene dichos _hints_.",
  description="Gráfica de barras mostrando la distribución de _hints_ de preload por página que tiene dichos _hints_. 75% de las páginas de escritorio y móviles que usan _hints_ de preload los usan exactamente una vez. En el percentil 90 hay 5 _hints_ de preload por página de escritorio y 7 por página móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=320533828&format=interactive",
  sheets_gid="1910228743",
  sql_file="resource-hints-preload-prefetch-distribution.sql"
) }}

En la mediana, las páginas que usan _hints_ de `prefetch` para cargar JavaScript los usan 3 veces, mientras que las páginas que usan `preload` lo usan sólo una vez. La cola se pone un poco más interesante, en el percentil 90 se usan 12 _hints_ de `prefetch` y 7 _hints_ de `preload`. Para mayor detalle acerca de _resource hints_ vaya al capítulo de [_Resource Hints_](./resource-hints) de este año.

## ¿Cómo servimos JavaScript?

Al igual que con otros recursos basados en texto en la web, podemos ahorrar una cantidad significativa de bytes a través de minimización y compresión. Ninguna de estas optimizaciones son nuevas, llevan siendo usadas por mucho tiempo, así que deberíamos verlas usadas frecuentemente.

Una de las auditorías en [Lighthouse](./methodology#lighthouse) revisa si el JavaScript no ha sido minimizado y provee una calificación (0.00 siendo la mínima calificación y 1.00 siendo la máxima) basado en lo que encuentra.

{{ figure_markup(
  image="lighthouse-unminified-js.png",
  caption="Distribución de las calificaciones de la auditoría de Lighthouse para JavaScript por página móvil.",
  description="Gráfica de barras mostrando que 0% de las páginas móviles obtienen una calificación de minimización de JavaScript en Lighthouse por debajo de 0.25, 4% de las páginas obtienen una calificación de entre 0.25 y 0.5, 10% de las páginas están entre 0.5 y 0.75, 8% de las páginas están entre 0.75  y 0.9 y 77% de las páginas están entre 0.9 y 1.0.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=158284816&format=interactive",
  sheets_gid="362705605",
  sql_file="lighthouse_unminified_js.sql"
) }}

La gráfica anterior muestra que la mayor parte de las páginas evaluadas (77%) tienen una calificación de 0.90 o superior, lo que significa que pocos scripts sin minimización han sido encontrados.

En general, sólo el 4.5% de las peticiones de JavaScript medidas no están minimizadas.

Algo interesante es que, si bien hemos sido quisquillosos con las peticiones a terceros, esta es un área donde los scripts de terceros tienen un mejor resultado que los propios. En la página móvil promedio, el 82% de los bytes de JavaScript sin minimizar vienen de código propio.

{{ figure_markup(
  image="lighthouse-unminified-js-by-3p.png",
  caption="Distribución promedio de los bytes de JavaScript sin minimizar por host.",
  description="Gráfica de pie mostrando que el 17.7% de los bytes de JS sin minimizar son de scripts de terceros y el 82.3% son de scripts propios.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=2073491355&format=interactive",
  sheets_gid="1169731612",
  sql_file="lighthouse_unminified_js_by_3p.sql"
) }}

### Compresión

Minimizar los scripts es una buena manera de reducir el tamaño de los archivos, pero la compresión es aún más efectiva y por ende más importante. La compresión provee la mayor parte del ahorro en transmisión con mayor frecuencia.

{{ figure_markup(
  image="compression-method-request.png",
  caption="Distribución del porcentaje de peticiones de JavaScript por método de compresión.",
  description="Gráfica de barras mostrando la distribución del porcentaje de peticiones de JavaScript por método de compresión. Los valores en escritorio y móviles son muy similares. 65% de las peticiones de JavaScript usan compresión Gzip, 20% usan br (Brotli), 15% no usan compresión y deflate, UTF-8 y ninguno aparecen con un 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=263239275&format=interactive",
  sheets_gid="1270710983",
  sql_file="compression_method.sql"
) }}

85% de todas las peticiones de JavaScript usan algún tipo de compresión. Gzip ocupa la mayoría de ese porcentaje, con 65% de los scripts siendo comprimidos usando Gzip en comparación a un 20% para Brotli (br). Mientras que el porcentaje de Brotli (qué es más efectivo que Gzip) es bajo tomando en cuenta el soporte que tiene en los navegadores, la tendencia va en la dirección correcta, pues subió 5 puntos porcentuales comparado con el año pasado.

Una vez más, esta parece ser un área donde los scripts de terceros están haciendo un mejor trabajo que los propios. Si hacemos la comparativa entre los métodos de compresión entre scripts propios y de terceros, podemos ver que el 24% de los scripts de terceros son comprimidos usando Brotli en comparación con un 15% en scripts propios.

{{ figure_markup(
  image="compression-method-3p.png",
  caption="Distribución del porcentaje de peticiones de JavaScript en móviles por método de compresión y host.",
  description="Gráfica de barras mostrando la distribución del porcentaje de peticiones de JavaScript en móviles por método de compresión y host. 66% de las peticiones de JavaScript propias y 64% de las de terceros usan Gzip. 15% de las peticiones de scripts propios y 24% de las de terceros usan Brotli. Y el 19% de los scripts propios y el 12% de los de terceros no usan ningún método de compresión.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1402692197&format=interactive",
  sheets_gid="564760060",
  sql_file="compression_method_by_3p.sql"
) }}

Los scripts de terceros también son menos propensos a ser servidos sin ningún tipo de compresión: 12% de los scripts de terceros no usan ni Gzip ni Brotli comparado al 19% de scripts propios.

Vale la pena ver más de cerca a los scripts que _no_ usan compresión. La compresión se vuelve más eficiente en términos de ahorros mientras más contenido tiene que comprimir. En otras palabras, si el archivo es pequeño, a veces el costo de compresión no sobrepasa la minúscula reducción al tamaño del archivo.

{{ figure_markup(
  caption="Porcentaje de peticiones de JavaScript de terceros sin comprimir cuyo tamaño es menor a 5 KB.",
  content="90.25%",
  classes="big-number",
  sheets_gid="347926930",
  sql_file="compression_none_by_bytes.sql"
) }}

Por fortuna, eso es exactamente lo que podemos observar, en particular para los scripts de terceros donde el 90% de los scripts sin comprimir tiene un tamaño menor a 5 KB. Por otro lado, 49% de los scripts propios son de menos de 5 KB y 37% de los scripts propios sin comprimir son de más de 10 KB. Así que mientras que si vemos una gran cantidad de scripts propios pequeños sin comprimir, aún existen muchos que podrían beneficiarse de la compresión.

## ¿Qué usamos?

Mientras usamos cada vez más JavaScript para crear nuestros sitios y aplicaciones también se ha incrementado la demanda por librerías y _frameworks open source_ que ayuden a mejorar la productividad de los desarrolladores y hacer más mantenible el código. Los sitios que _no_ usan una de estas librerías son una minoría, solamente jQuery se encuentra en el 85% de las páginas móviles medidas por el HTTP Archive.

Es importante que seamos críticos acerca de las herramientas que usamos al construir la web y cuáles son sus pros y contras. Por lo que tiene sentido analizar más de cerca qué usamos hoy en día.

### Librerías

El HTTP Archive usa [Wappalyzer](./methodology#wappalyzer) para detectar las tecnologías usadas en una página. Wappalyzer revisa tanto las librerías de JavaScript (estas son una colección de fragmentos de código y funciones útiles para hacer facilitar el desarrollo como jQuery) y _frameworks_ de JavaScript (estos son más _scaffolding_ y proveen plantillas y estructuras como React).

Las librerías más populares no cambiaron mucho respecto al año pasado, con jQuery manteniendo un dominio en el uso y sólo una de las librerías en el top 21 bajando posiciones (lazy,js siendo reemplazado por DataTables). De hecho, el porcentaje de las librerías más comunes prácticamente no cambió con respecto al año pasado.

{{ figure_markup(
  image="frameworks-libraries.png",
  caption="Uso de los frameworks y librerías de JavaScript más comunes en porcentaje de páginas.",
  description="Gráfica de barras mostrando el uso de los frameworks y librerías de JavaScript más comunes en porcentaje de páginas (no número de vistas o descargas de npm). jQuery es el líder dominante, se encuentra en 83% de las páginas móviles. Lo siguen jQuery migrate con un 30%, jQuery UI con 21%, Modernizr con 15%, FancyBox con 7%, Slick y Lightbox con 6% y el resto de los frameworks y librerías con 4% o 3%: Moment.js, Underscore.js, Lodash, React, GSAP, Select2, RequireJS y prettyPhoto.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=419887153&format=interactive",
  sheets_gid="1654577118",
  sql_file="frameworks_libraries.sql"
) }}

El año pasado [Houssein listó algunas de las razones por las cuales la dominación de jQuery continúa](../2019/javascript#open-source-libraries-and-frameworks):

> WordPress, que es usado en más del 30% de los sitios e incluye jQuery por defecto.
> Migrar de jQuery a una librería del lado del cliente más nueva puede tomar tiempo dependiendo de qué tan grande es la aplicación y muchos sitios consisten de jQuery en conjunto con alguna librería más nueva.

Ambas son suposiciones bastante sólidas y parece que la situación no ha cambiado mucho en ninguno de los casos.

De hecho, la dominación de jQuery tiene un mayor respaldo si consideramos que, de las librerías en el top 10, 6 son ya sea jQuery o requieren de jQuery para ser usadas: jQuery UI, jQuery Migrate, FancyBox, Lightbox y Slick.

### Frameworks

Cuando tomamos un vistazo a los frameworks, no vemos un cambio dramático en términos de uso en los frameworks principales que fueron destacados el año pasado. Vue.js ha incrementado su uso significativamente y AMP creció un poco, pero la mayoría siguen más o menos donde estaban el año pasado.

Vale la pena mencionar que <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/issues/2450">el problema de detección que fue notado el año pasado aún aplica</a> e impacta los resultados aquí. Es posible que _haya_ habido un cambio significativo en la popularidad de más de estas herramientas pero no podemos notarla con la manera en la que estos datos son recolectados en este momento.

### Qué significa todo esto

Nos interesa más el impacto que tienen estas herramientas en las cosas que construimos que su popularidad.

Para empezar, es importante notar que mientras podemos pensar en el uso de una herramienta contra el de otra, en realidad, pocas veces usamos sólo una librería o framework en producción. Sólo el 21% de las páginas analizadas usaban sólo una librería o _framework_. Dos o tres _frameworks_ era algo común y la cola se vuelve larga muy rápidamente.

Cuando observamos las combinaciones más comunes en producción, la mayoría son esperadas. Sabiendo el dominio de jQuery, no sorprende ver que la mayoría de las combinaciones populares incluyen jQuery y algún número de _plugins_ relacionados a jQuery.

<figure>
  <table>
    <thead>
      <tr>
        <th>Combinaciones</th>
        <th>Páginas</th>
        <th>(%)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">1,312,601</td>
        <td class="numeric">20.7%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate</td>
        <td class="numeric">658,628</td>
        <td class="numeric">10.4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery UI</td>
        <td class="numeric">289,074</td>
        <td class="numeric">4.6%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery</td>
        <td class="numeric">155,082</td>
        <td class="numeric">2.4%</td>
      </tr>
      <tr>
        <td>jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">140,466</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery Migrate</td>
        <td class="numeric">85,296</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery</td>
        <td class="numeric">84,392</td>
        <td class="numeric">1.3%</td>
      </tr>
      <tr>
        <td>Slick, jQuery</td>
        <td class="numeric">72,591</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td>GSAP, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">61,935</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery UI</td>
        <td class="numeric">61,152</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Lightbox, jQuery</td>
        <td class="numeric">60,395</td>
        <td class="numeric">1.0%</td>
      </tr>
      <tr>
        <td>Modernizr, jQuery, jQuery Migrate, jQuery UI</td>
        <td class="numeric">53,924</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Slick, jQuery, jQuery Migrate</td>
        <td class="numeric">51,686</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>Lightbox, jQuery, jQuery Migrate</td>
        <td class="numeric">50,557</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery, jQuery UI</td>
        <td class="numeric">44,193</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>Modernizr, YUI</td>
        <td class="numeric">42,489</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>React, jQuery</td>
        <td class="numeric">37,753</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Moment.js, jQuery</td>
        <td class="numeric">32,793</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>FancyBox, jQuery, jQuery Migrate</td>
        <td class="numeric">31,259</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>MooTools, jQuery, jQuery Migrate</td>
        <td class="numeric">28,795</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>
    {{ figure_link(
      caption="Las combinaciones más populares de librerías y frameworks en páginas móviles.",
      sheets_gid="795160444",
      sql_file="frameworks_libraries_combos.sql"
    ) }}
  </figcaption>
</figure>

También podemos ver una cantidad relativamente alta de _frameworks_ "modernos" como React, Vue y Angular usados en conjunto con jQuery, por ejemplo como resultado de una migración o inclusión por terceros.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Combinación</th>
        <th scope="col">Sin jQuery</th>
        <th scope="col">Con jQuery</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>GSAP, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">1.0%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>React, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>React</td>
        <td class="numeric">0.4%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>React, jQuery, jQuery Migrate</td>
        <td>&nbsp;</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>Vue.js, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Vue.js</td>
        <td class="numeric">0.2%</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>AngularJS, jQuery</td>
        <td>&nbsp;</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>GSAP, Hammer.js, Lodash, React, RequireJS, Zepto</td>
        <td class="numeric">0.2%</td>
        <td>&nbsp;</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">Total</th>
        <th scope="col" class="numeric">1.7%</th>
        <th scope="col" class="numeric">1.4%</th>
      </tr>
    </tfoot>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Las combinaciones más populares de React, Angular y vue con y sin jQuery.",
      sheets_gid="795160444",
      sql_file="frameworks_libraries_combos.sql"
    ) }}
  </figcaption>
</figure>

Es más importante notar que todas estas herramientas usualmente derivan en más código y más tiempo de procesamiento.

Revisando específicamente los _frameworks_ en uso, vemos que la mediana de bytes de JavaScript por páginas usándolos varía dramáticamente dependiendo de _qué_ está siendo usado.

La gráfica siguiente muestra la mediana de bytes por páginas donde cualquiera de los 35 frameworks más comunes fueron encontrados divididos por tipo de cliente.

{{ figure_markup(
  image="frameworks-bytes.png",
  caption="La mediana de kilobytes de JavaScript por página por framework de JavaScript.",
  description="Gráfica de barras mostrando la mediana de kilobytes de JavaScript por página dividida y ordenada por popularidad de los frameworks de JavaScript. El framework más popular, React, tiene una mediana de 1,328 en páginas móviles. Otros frameworks como RequireJS y Angular tienen números altos de bytes de JS por página. Páginas con MooTools, Prototype, AMP, RightJS, Alpine.js y Svelte tienen medianas de menos de 500 KB por página móvil. Ember.js es un caso aparte con alrededor de 1,800 KB de JS por página móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=955720480&format=interactive",
  sheets_gid="1206934500",
  width="600",
  height="835",
  sql_file="frameworks-bytes-by-framework.sql"
) }}

En un lado del espectro están _frameworks_ como React, Angular o Ember, que tienden a resultar en mucho código sin importar el cliente. Por otro lado, observamos que _frameworks_ minimalistas como Alpine.js y Svelte muestran resultados muy prometedores. La configuración por defecto es muy importante, y parece ser que, al empezar con una base con un alto desempeño, Svelte y Alpine están teniendo éxito (hasta ahora&hellip; la muestra es bastante pequeña) en crear páginas más ligeras.

La situación es muy similar cuando tomamos un vistazo al tiempo de ejecución del hilo principal para páginas donde estas herramientas fueron detectadas.

{{ figure_markup(
  image="frameworks-main-thread.png",
  caption="La mediana de tiempo de ejecución del hilo principal por página por framework de JavaScript.",
  description="Gráfica de barras mostrando la mediana de tiempo de ejecución del hilo principal por framework. Es difícil notar algo que no sea Ember.js, cuya mediana de tiempo de ejecución del hilo principal en móviles es de más de 20,000 milisegundos (20 segundos). El resto de los frameworks tienen números pequeños en comparación.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=691531699&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

El tiempo de ejecución del hilo principal de Ember destaca tanto que distorsiona la gráfica por tanto tiempo que tarda en ejecutarse. (Pasé algo de tiempo extra investigando esto y parece haber una gran influencia <a hreflang="en" href="https://timkadlec.com/remembers/2021-01-26-what-about-ember/">de una cierta plataforma usando este _framework_ de manera poco eficiente</a> en vez de ser un problema con Ember en sí.) Quitar Ember de la gráfica la hace un poco más fácil de entender.

{{ figure_markup(
  image="frameworks-main-thread-no-ember.png",
  caption="La mediana de tiempo de ejecución del hilo principal por página por framework de JavaScript, sin contar a Ember.js.",
  description="Gráfica de barras mostrando la mediana de tiempo de ejecución del hilo principal por framework, sin contar Ember.js. Los tiempos de ejecución del hilo principal son todos altos debido a que en la metodología de pruebas se usaron velocidades bajas de CPU para móviles. Los frameworks más populares como React, GSAP y RequireJS tienen tiempos de ejecución de hilo principal altos de alrededor de 2-3 segundos en escritorio y 5-7 segundos en móviles. Polymer también sobresale en la parte baja de la lista de popularidad. MooToos, Prototype, Alpine.js y Svelte tienden a tener tiempos de ejecución de hilo principal más bajos, por debajo de los 2 segundos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=77448759&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Herramientas como React, GSAP y RequireJS tienden a ocupar mucho del tiempo de ejecución del hilo principal del browser, sin importar si es una página de escritorio o móvil. Las mismas herramientas que dan como resultado una menor cantidad de código—herramientas como Alpine o Svelte—también tienden a tener un menor impacto en el hilo principal.

También vale la pena indagar en el intervalo que existe entre la experiencia que un _framework_ provee en escritorio y móvil. El tráfico de dispositivos móviles cada vez se vuelve más dominante y es crítico que nuestras herramientas se desempeñen tan bien como sea posible en móviles. Una gran diferencia en el desempeño en móviles de un _framework_ es una gran alerta roja.

{{ figure_markup(
  image="frameworks-main-thread-no-ember-diff.png",
  caption="Diferencia entre la mediana del tiempo de ejecución del hilo principal por página por framework de JavaScript, sin contar Ember.js.",
  description="Gráfica de barras mostrando la diferencia absoluta y relativa entre la mediana del tiempo de ejecución del hilo principal por página por framework de JavaScript entre escritorio y móvil, sin contar Ember.js. Polymer destaca hacia el final de la lista de popularidad teniendo una gran diferencia: alrededor de 5 segundos y un tiempo de ejecución del hilo principal 250% más lento en páginas móviles que en páginas de escritorio. Otros frameworks que saltan a la vista son GSAP y RequireJS teniendo una diferencia de 4 segundos o 150%. Los frameworks con menor diferencia son Mustache y RxJS que sólo son 20-30% más lentos en móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1758266664&format=interactive",
  sheets_gid="160832134",
  sql_file="main_thread_time_frameworks.sql"
) }}

Como era de esperarse, existe un intervalo para todas las herramientas usadas debido al bajo poder de procesamiento del [Moto G4 emulado](methodology#webpagetest). Ember y Polymer parecen ser ejemplos particularmente atroces, mientras que RxJS y Mustache varían muy poco entre escritorio y móvil.

## ¿Cuál es el impacto?

Ahora tenemos una buena idea de cuanto JavaScript usamos, de donde viene y para que lo usamos. Eso es interesante por su cuenta pero la verdadera pregunta aquí es el "¿Y eso qué?" ¿Qué impacto tiene todo este script que usamos en la experiencia de nuestras páginas?

La primera cosa que debemos considerar es qué ocurre con todo ese JavaScript una vez que ha sido descargado. La descarga es sólo la primera parte del viaje del JavaScript. El navegador aún tiene que analizar ese script, compilarlo y eventualmente ejecutarlo. Mientras que los browsers están en una constante búsqueda de maneras de mover parte de ese costo a otros hilos, mucho de ese trabajo aún ocurre en el hilo principal, lo que impide al navegador realizar trabajo de _layout_ o pintado, así como de responder a interacciones del usuario.

Como mencionamos antes, sólo existe una diferencia de 30KB entre lo que se le envía a dispositivos móviles y de escritorio. Dependiendo de tu punto de vista, es entendible si no te molesta mucho la pequeña diferencia entre la cantidad de código enviado a un navegador de escritorio contra uno móvil—después de todo, ¿Qué son 30KB, no?

El mayor problema viene cuando todo ese código llega a un dispositivo de gama media o baja, algo poco parecido a los dispositivos que la mayoría de los desarrolladores tienden a usar, y un poco más parecido al tipo de dispositivos usados por la mayoría de las personas en el mundo. Esa diferencia relativamente pequeña entre escritorio y móvil es mucho más notoria cuando la medimos en términos de tiempo de procesamiento.

Un sitio de escritorio en la mediana pasa 891 ms en lo que el navegador ejecuta todo ese JavaScript en el hilo principal. Mientras tanto, un sitio móvil en la mediana pasa 1,897 ms—más del doble de tiempo que en escritorio. Esto es aún peor para el resto de los sitios. En el percentil 90, los sitios móviles tienen un tiempo de ejecución del hilo principal de JavaScript abrumador de 8,921 ms, comparado con 3,838 ms en sitios de escritorio.

{{ figure_markup(
  image="main-thread-time.png",
  caption="Distribución del tiempo de ejecución del hilo principal.",
  description="Gráfica de barras mostrando la distribución del tiempo de ejecución del hilo principal en escritorio y móvil. El tiempo en móvil es 2-3 veces más alto a lo largo de la distribución. Los percentiles 10, 25, 50, 75 y 90 de escritorio son de: 137, 356, 891, 1,988 y 3,838 milisegundos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=740020507&format=interactive",
  sheets_gid="2039579122",
  sql_file="main_thread_time.sql"
) }}

### La correlación entre el uso de JavaScript y la calificación de Lighthouse

Una manera de ver cómo todo esto se traduce en un impacto en la experiencia de usuario es intentar encontrar una correlación entre algunas de las métricas de JavaScript que identificamos anteriormente con las calificaciones de Lighthouse para diferentes métricas y categorías.

{{ figure_markup(
  image="correlations.png",
  caption="Correlaciones de JavaScript en varios aspectos de la experiencia de usuario.",
  description="Gráfica de barras mostrando el coeficiente de correlación de Pearson para varios aspectos de la experiencia de usuario. La correlación de bytes con la calificación de desempeño de Lighthouse tiene un coeficiente de correlación de -0.47. De bytes con la calificación de Lighthouse de accesibilidad: 0.08. De bytes y el Tiempo Total de Bloqueo (TBT): 0.55. De bytes de terceros y la calificación de desempeño de Lighthouse: -0.37. De bytes de terceros y la calificación de Lighthouse de accesibilidad: 0.00. De bytes de terceros y TBT: 0.48. Del número de scripts async por página y la calificación de desempeño de Lighthouse: -0.19. Scripts async y la calificación de Lighthouse de accesibilidad: 0.08. Scripts async y TBT: 0.36.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=649523941&format=interactive",
  sheets_gid="2035770638",
  sql_file="correlations.sql"
) }}

La gráfica anterior utiliza el [coeficiente de correlación de Pearson](https://es.wikipedia.org/wiki/Coeficiente_de_correlaci%C3%B3n_de_Pearson). Hay una larga y relativamente compleja explicación de lo que eso significa, pero en pocas palabras significa que estamos buscando el grado de correlación entre dos números diferentes. Si encontramos un coeficiente de 1.00, tenemos una correlación directa positiva. Una correlación de 0.00 mostraría que no hay conexión entre ambos números. Cualquier cosa menor a 0.00 indica que hay una correlación negativa—en otras palabras, si un número aumenta el otro disminuye.

Para empezar, no parece haber una correlación medible entre nuestras métricas de JavaScript y la calificación de accesibilidad de Lighthouse ("LH A11y" en la gráfica). Esto es completamente opuesto a lo que se encontró en otros estudios, especialmente en el <a hreflang="en" href="https://webaim.org/projects/million/#frameworks">estudio anual de WebAIM</a>.

La explicación más probable para esto es que las pruebas de accesibilidad de Lighthouse (aún) no son tan completas comparadas con otras herramientas enfocadas en accesibilidad, como WebAIM.

Donde sí vemos una correlación fuerte es entre la cantidad de bytes de JavaScript ("Bytes") y tanto la calificación general de desempeño de Lighthouse ("LH Perf") como el Tiempo Total de Bloqueo ("TBT").

La correlación entre los bytes de JavaScript y las calificaciones de desempeño de Lighthouse es de -0.47. En otras palabras, mientras la cantidad de bytes de JS aumenta, la calificación de Lighthouse de desempeño disminuye. La cantidad total de bytes tiene una correlación más fuerte que la cantidad de bytes de terceros ("3P bytes"), lo cual sugiere que si bien los scripts de terceros fungen un rol, no podemos echarles toda la culpa a ellos.

La conexión entre el Tiempo Total de Bloqueo y los bytes de JavaScript es aún más significativa (0.55 para bytes totales y 0.48 para bytes de terceros). Esto no es sorpresivo debido a que conocemos todo el trabajo extra que los navegadores deben hacer para hacer que el código JavaScript corra en una página—más bytes significa más tiempo.

### Vulnerabilidades de seguridad

Otra auditoría útil que Lighthouse corre es revisar si existen vulnerabilidades de seguridad conocidas en librerías de terceros. Hace esto detectando que librerías y _frameworks_ y que versiones son usadas en una página. Después revisa la <a hreflang="en" href="https://snyk.io/vuln?type=npm">base de datos _open source_ de Snyk</a> para ver si alguna vulnerabilidad ha sido descubierta en las herramientas detectadas.

{{ figure_markup(
  caption="Porcentaje de páginas móviles con al menos una librería de JavaScript vulnerable.",
  content="83.50%",
  classes="big-number",
  sheets_gid="1326928130",
  sql_file="lighthouse_vulnerabilities.sql"
) }}

De acuerdo a la auditoría, 83.5% de las páginas móviles usan una librería o _framework_ con al menos una vulnerabilidad de seguridad conocida.

Esto es a lo que llamamos el efecto jQuery. Anteriormente vimos como jQuery es usado en un 83% de las páginas. Múltiples versiones viejas de jQuery contienen vulnerabilidades conocidas, lo cual constituye la vasta mayoría de las vulnerabilidades que esta auditoría revisó.

De las casi 5 millones de páginas móviles que fueron probadas, 81% de ellas contiene una versión vulnerable de jQuery—una delantera considerable contra la segunda librería vulnerable más común—jQuery UI con un 15.6%.

<figure>
  <table>
    <thead>
      <tr>
        <th>Librería</th>
        <th>Páginas vulnerables</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>jQuery</td>
        <td class="numeric">80.86%</td>
      </tr>
      <tr>
        <td>jQuery UI</td>
        <td class="numeric">15.61%</td>
      </tr>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">13.19%</td>
      </tr>
      <tr>
        <td>Lodash</td>
        <td class="numeric">4.90%</td>
      </tr>
      <tr>
        <td>Moment.js</td>
        <td class="numeric">2.61%</td>
      </tr>
      <tr>
        <td>Handlebars</td>
        <td class="numeric">1.38%</td>
      </tr>
      <tr>
        <td>AngularJS</td>
        <td class="numeric">1.26%</td>
      </tr>
      <tr>
        <td>Mustache</td>
        <td class="numeric">0.77%</td>
      </tr>
      <tr>
        <td>Dojo</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>jQuery Mobile</td>
        <td class="numeric">0.53%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top 10 de librerías que contribuyen la mayor cantidad de páginas móviles vulnerables de acuerdo a Lighthouse.",
      sheets_gid="1803013938",
      sql_file="lighthouse_vulnerable_libraries.sql"
    ) }}
  </figcaption>
</figure>

En otras palabras, si podemos hacer que se haga una migración de esas versiones viejas y vulnerables de jQuery, veríamos el número de sitios con vulnerabilidades conocidas desplomarse (al menos hasta que encontremos vulnerabilidades en los _frameworks_ más nuevos).

La mayor parte de las vulnerabilidades encontradas cae en la categoría de severidad "media".

{{ figure_markup(
  image="vulnerabilities-by-severity.png",
  caption="Distribución del porcentaje de páginas móviles que tienen vulnerabilidades en JavaScript por severidad.",
  description="Gráfica de pie mostrando que 13.7% de las páginas móviles no tienen vulnerabilidades de JavaScript, 0.7 tienen vulnerabilidades de baja severidad, 69.1% tienen vulnerabilidades de media severidad y 16.4% tienen alta severidad.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRn1IaMxnTl0jhdC-C-vC5VLN_boJfLAaOfGJ968IalK1vPc8-dz0OkVmNY0LjMxZ6BIwSRB7xtRmIE/pubchart?oid=1932740277&format=interactive",
  sheets_gid="1409147642",
  sql_file="lighthouse_vulnerabilities_by_severity.sql"
) }}

## Conclusión

La popularidad de JavaScript está aumentando continuamente y eso tiene muchos lados positivos. Es increíble considerar todo lo que podemos lograr con la web de hoy gracias a JavaScript que, hasta hace unos años, sería inimaginable.

Pero es claro que también debemos andar con cuidado. La cantidad de JavaScript aumenta de manera consistente cada año (si el mercado accionario fuera así de predecible todos seríamos increíblemente ricos) y eso tiene sus contras. Mayores cantidades de JavaScript están conectadas a un incremento en el tiempo de procesamiento lo cual afecta negativamente métricas clave como el Tiempo Total de Bloqueo. Y, si descuidamos todas esas librerías sin actualizarlas, corremos el riesgo de exponer a los usuarios a vulnerabilidades de seguridad conocidas.

Nuestras mejores apuestas para asegurar que construyamos una web accesible, con buen desempeño y segura son medir cuidadosamente el costo de los scripts que agregamos a nuestras páginas y estar dispuestos a ver con un ojo crítico a las herramientas que usamos y pedirles que sean mejores.
