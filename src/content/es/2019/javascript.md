---
part_number: I
chapter_number: 1
title: JavaScript
description: JavaScript chapter of the 2019 Web Almanac covering how much JavaScript we use on the web, compression, libraries and frameworks, loading, and source maps.
authors: [housseindjirdeh]
reviewers: [obto, paulcalvano, mathiasbynens]
translators: [c-torres]
discuss: 1756
results: https://docs.google.com/spreadsheets/d/1kBTglETN_V9UjKqK_EFmFjRexJnQOmLLr-I2Tkotvic/
queries: 01_JavaScript
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-03-01T00:00:00.000Z
---

## Introducción

JavaScript es un lenguaje de script que permite construir experiencias interactivas y complejas en la web. Esto incluye responder a las interacciones del usuario, actualizar contenido dinámico en una página, etc. Cualquier cosa que involucre el comportamiento de una página web cuando ocurra un evento es para lo que se usa JavaScript.

La especificación del lenguaje en sí, junto con muchas bibliotecas y marcos creados por la comunidad utilizados por desarrolladores de todo el mundo, ha cambiado y evolucionado desde que se creó el lenguaje en 1995. Las implementaciones e intérpretes de JavaScript también han seguido progresando, haciendo que el lenguaje sea utilizable en muchos entornos, no solo navegadores web.

[HTTP Archive](https://httparchive.org/) explora [millones de páginas](https://httparchive.org/reports/state-of-the-web#numUrls) todos los meses y los ejecuta a través de una instancia privada de [WebPageTest](https://webpagetest.org/) para almacenar información clave de cada página. (Puedes aprender más sobre esto en nuestra [metodología](./methodology)). En el context de JavaScript, HTTP Archive proporciona información extensa sobre el uso del lenguaje en toda la web. Este capítulo consolida y analiza muchas de estas tendencias.

## ¿Cuánto JavaScript usamos?

JavaScript es el recurso más costoso que enviamos a los navegadores, ya que tiene que ser descargado, analizado, compilado y finalmente ejecutado. Aunque los navegadores han disminuido significativamente el tiempo que lleva analizar y compilar scripts, [la descarga y la ejecución se han convertido en las etapas más costosas](https://v8.dev/blog/cost-of-javascript-2019) cuando JavaScript es procesado por una página web.

Enviar paquetes de JavaScript más pequeños al navegador es la mejor manera de reducir los tiempos de descarga y, a su vez, mejorar el rendimiento de la página.**Pero, ¿cuánto JavaScript utilizamos realmente?**

<figure>
   <a href="/static/images/2019/javascript/fig1.png">
      <img src="/static/images/2019/javascript/fig1.png" alt="Figura 1. Distribución de bytes de JavaScript por página." aria-labelledby="fig1-caption" aria-describedby="fig1-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1974602890&format=interactive">
   </a>
	<div id="fig1-description" class="visually-hidden">Gráfico de barras que muestra que 70 bytes de JavaScript se usa en el percentil p10, 174 bytes para p25, 373 bytes para p50, 693 bytes para p75 y 1.093 bytes para p90</div>
	<figcaption id="fig1-caption">Figura 1. Distribución de bytes de JavaScript por página.</figcaption>
</figure>

La Figura 1 anterior muestra que utilizamos 373 KB de JavaScript en el percentil 50, o mediana. En otras palabras, el 50% de todos los sitios envían más de este JavaScript a sus usuarios.

Mirando estos números, es natural preguntarse si esto es demasiado JavaScript. Sin embargo, en términos de rendimiento de la página, el impacto depende completamente de las conexiones de red y los dispositivos utilizados. Lo que nos lleva a nuestra siguiente pregunta: ¿cuánto JavaScript enviamos cuando comparamos clientes móviles y de escritorio?

<figure>
   <a href="/static/images/2019/javascript/fig2.png">
      <img src="/static/images/2019/javascript/fig2.png" alt="Figura 2. Distribución de JavaScript por página por dispositivo." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1914565673&format=interactive">
   </a>
	<div id="fig2-description" class="visually-hidden">Gráfico de barras que muestra 76 bytes / 65 bytes de JavaScript se usa en el percentil p10 en computadoras de escritorio y dispositivos móviles respectivamente, 186/164 bytes para p25, 391/359 bytes para p50, 721/668 bytes para p75 y 1.131 / 1.060 bytes para p90 .</div>
	<figcaption id="fig2-caption">Figura 2. Distribución de JavaScript por página por dispositivo.</figcaption>
</figure>

En cada percentil, estamos enviando un poco más de JavaScript a los dispositivos de escritorio que a los dispositivos móviles.

### Tiempo de procesamiento

Después de ser analizado y compilado, el JavaScript cargado por el navegador debe procesarse (o ejecutarse) antes de poder ser utilizado. Los dispositivos varían y su potencia de cálculo puede afectar significativamente la rapidez con que se puede procesar JavaScript en una página. ¿Cuáles son los tiempos de procesamiento actuales en la web?

Podemos tener una idea analizando los tiempos de procesamiento de subprocesos principales para V8 en diferentes percentiles:

<figure>
   <a href="/static/images/2019/javascript/fig2.png">
      <img src="/static/images/2019/javascript/fig3.png" alt="Figura 3. Tiempos de procesamiento de subprocesos principales según V8 por dispositivo." aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=924000517&format=interactive">
   </a>
	<div id="fig3-description" class="visually-hidden">Gráfico de barras que muestra 141 ms / 377 ms de tiempo de procesamiento se utiliza en el percentil p10 en computadoras de escritorio y dispositivos móviles respectivamente, 352/988 ms para p25, 849 / 2.437 ms para p50, 1.850 / 5.518 ms para p75 y 3.543 / 10.735 ms para p90.</div>
	<figcaption id="fig3-caption">Figura 3. Tiempos de procesamiento de subprocesos principales según V8 por dispositivo.</figcaption>
</figure>

En cada percentil, los tiempos de procesamiento son más largos para las páginas web móviles que para las computadoras de escritorio. La mediana del tiempo total de subprocesos principales en el escritorio es de 849 ms, mientras que el móvil está en un número mayor: 2.436 ms.

Aunque estos datos muestran cuánto tiempo puede llevar un dispositivo móvil procesar JavaScript en comparación con una máquina de escritorio más potente, los dispositivos móviles también varían en términos de potencia informática. El siguiente cuadro muestra cómo los tiempos de procesamiento en una sola página web pueden variar significativamente según la clase de dispositivo móvil.

<figure>
	<a href="/static/images/2019/javascript/js-processing-reddit.png">
		<img src="/static/images/2019/javascript/js-processing-reddit.png" alt="Figura 4. Tiempos de procesamiento de JavaScript para Reddit.com" aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="363">
	</a>
	<div id="fig4-description" class="visually-hidden">Gráfico de barras que muestra 3 dispositivos diferentes: en la parte superior, un Pixel 3, que tiene un tiempo de procesamiento pequeño tanto en el hilo principal como en el hilo worker de menos de 400 ms. Para un Moto G4 es de aproximadamente 900 ms en el subproceso principal y otros 300 ms en el subproceso del worker. Y la barra final es un Alcatel 1X 5059D con más de 2.000 ms en el subproceso principal y más de 500 ms en el subproceso del worker.</div>
	<figcaption id="fig4-caption">Figura 4. Tiempos de procesamiento de JavaScript para Reddit.com. Tomado de <a href="https://v8.dev/blog/cost-of-javascript-2019">El costo de JavaScript en 2019</a>.</figcaption>
</figure>

### Número de Solicitudes

Una vía que vale la pena explorar al tratar de analizar la cantidad de JavaScript utilizado por las páginas web es la cantidad de solicitudes enviadas. Con [HTTP/2](https://developers.google.com/web/fundamentals/performance/http2) el envío de múltiples fragmentos más pequeños puede mejorar la carga de la página sobre el envío de un paquete monolítico más grande. Si también lo desglosamos por tipo de dispositivo, **¿cuántas solicitudes se están enviando?**

<figure>
   <a href="/static/images/2019/javascript/fig5.png">
      <img src="/static/images/2019/javascript/fig5.png" alt="Figura 5. Distribución del total de solicitudes de JavaScript." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1632335480&format=interactive">
   </a>
	<div id="fig5-description" class="visually-hidden">Gráfico de barras que muestra 4/4 solicitudes se utilizan para computadoras de escritorio y dispositivos móviles respectivamente en el percentil p10, 10/9 en p25, 19/18 en p50, 33/32 en p75 y 53/52 en p90.</div>
	<figcaption id="fig5-caption">Figura 5. Distribución del total de solicitudes de JavaScript.</figcaption>
</figure>

En la mediana, se envían 19 solicitudes para computadoras de escritorio y 18 para dispositivos móviles.

### Contenido de origen vs. contenido de terceros

De los resultados analizados hasta ahora, se estaban considerando el tamaño completo y el número de solicitudes. Sin embargo, en la mayoría de los sitios web, una parte importante del código JavaScript obtenido y utilizado proviene de contenido de terceros.

JavaScript de contenido de terceros puede provenir de cualquier fuente externa de terceros. Los anuncios, herramientas de análisis y contenido de redes sociales son casos de uso comunes para obtener scripts de terceros. Entonces, naturalmente, esto nos lleva a nuestra siguiente pregunta: **¿cuántas solicitudes enviadas son de contenido de terceros en lugar de de contenido de origen?**

<figure>
   <a href="/static/images/2019/javascript/fig6.png">
      <img src="/static/images/2019/javascript/fig6.png" alt="Figura 6. Distribución de scripts de origen y de terceros en dispositivos de escritorio." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1108490&format=interactive">
   </a>
	<div id="fig6-description" class="visually-hidden">Gráfico de barras que muestra las solicitudes 0/1 en el escritorio es contenido de origen y contenido de terceros, respectivamente, en el percentil p10, 2/4 en la p25, 6/10 en la p50, 13/21 en la p75 y 24/38 en la p90.</div>
	<figcaption id="fig6-caption">Figura 6. Distribución de scripts de origen y de terceros en dispositivos de escritorio.</figcaption>
</figure>

<figure>
   <a href="/static/images/2019/javascript/fig7.png">
      <img src="/static/images/2019/javascript/fig7.png" alt="Figura 7. Distribución de scripts de origen  y de terceros en dispositivos móviles." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=998640509&format=interactive">
   </a>
	<div id="fig7-description" class="visually-hidden">Gráfico de barras que muestra las solicitudes 0/1 en dispositivos móviles es de contenido de origen y contenido de terceros, respectivamente, en el percentil p10, 2/3 en la p25, 5/9 en la p50, 13/20 en la p75 y 23/36 en la p90.</div>
	<figcaption id="fig7-caption">Figura 7. Distribución de scripts de origen  y de terceros en dispositivos móviles.</figcaption>
</figure>

Para clientes móviles y de escritorio, se envían más solicitudes de contenido de terceros que de contenido de origen en cada percentil. Si esto parece sorprendente, descubramos cuánto código real enviado proviene de proveedores externos.

<figure>
   <a href="/static/images/2019/javascript/fig8.png">
      <img src="/static/images/2019/javascript/fig8.png" alt="Figura 8. Distribución del JavaScript total descargado en dispositivos de escritorio." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=633945705&format=interactive">
   </a>
	<div id="fig8-description" class="visually-hidden">Gráfico de barras que muestra 0/17 bytes de JavaScript se descarga en dispositivos de escritorio para contenido de origen y contenido de terceros, respectivamente, en el percentil p10, 11/62 en p25, 89/232 en p50, 200/525 en p75 y 404/900 en p90.</div>
	<figcaption id="fig8-caption">Figura 8. Distribución del JavaScript total descargado en dispositivos de escritorio.</figcaption>
</figure>

<figure>
   <a href="/static/images/2019/javascript/fig9.png">
      <img src="/static/images/2019/javascript/fig9.png" alt="Figura 9. Distribución del JavaScript total descargado en dispositivos móviles." aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1611383649&format=interactive">
   </a>
	<div id="fig9-description" class="visually-hidden">Gráfico de barras que muestra 0/17 bytes de JavaScript se descarga en dispositivos móviles para contenido de origen y contenido de terceros, respectivamente, en el percentil p10, 6/54 en p25, 83/217 en p50, 189/477 en p75 y 380/827 en p90.</div>
	<figcaption id="fig9-caption">Figura 9. Distribución del JavaScript total descargado en dispositivos móviles.</figcaption>
</figure>

En la mediana, se utiliza un 89% más de código de contenido de terceros que el código de contenido de origen creado por el desarrollador para dispositivos móviles y de escritorio. Esto muestra claramente que el código de terceros puede ser uno de los mayores contribuyentes a la inflación.

## Compresión de recursos

En el contexto de las interacciones navegador-servidor, la compresión de recursos se refiere al código que se ha modificado utilizando un algoritmo de compresión de datos. Los recursos se pueden comprimir estáticamente antes de tiempo o sobre la marcha según lo solicite el navegador, y para cualquier enfoque, el tamaño del recurso transferido se reduce significativamente, lo que mejora el rendimiento de la página.

Existen varios algoritmos de compresión de texto, pero solo dos se utilizan principalmente para la compresión (y descompresión) de solicitudes de red HTTP:

- [Gzip](https://www.gzip.org/) (gzip): El formato de compresión más utilizado para las interacciones de servidor y cliente.
- [Brotli](https://github.com/google/brotli) (br): Un algoritmo de compresión más nuevo que apunta a mejorar aún más las relaciones de compresión. [90% de los navegadores](https://caniuse.com/#feat=brotli) soportan la codificación Brotli.

Los scripts comprimidos siempre deberán ser descomprimidos por el navegador una vez transferidos. Esto significa que su contenido sigue siendo el mismo y los tiempos de ejecución no están optimizados en absoluto. Sin embargo, la compresión de recursos siempre mejorará los tiempos de descarga, que también es una de las etapas más caras del procesamiento de JavaScript. Asegurarse de que los archivos JavaScript se comprimen correctamente puede ser uno de los factores más importantes para mejorar el rendimiento del sitio.

**¿Cuántos sitios están comprimiendo sus recursos de JavaScript?**

<figure>
   <a href="/static/images/2019/javascript/fig10.png">
      <img src="/static/images/2019/javascript/fig10.png" alt="Figura 10. Porcentaje de sitios que comprimen recursos de JavaScript con gzip o brotli." aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=241928028&format=interactive">
   </a>
	<div id="fig10-description" class="visually-hidden">Gráfico de barras que muestra el 67% / 65% de los recursos de JavaScript se comprime con gzip en computadoras de escritorio y dispositivos móviles respectivamente, y el 15% / 14% se comprime con Brotli.</div>
	<figcaption id="fig10-caption">Figura 10. Porcentaje de sitios que comprimen recursos de JavaScript con gzip o brotli.</figcaption>
</figure>

La mayoría de los sitios están comprimiendo sus recursos de JavaScript. La codificación Gzip se usa en ~ 64-67% de los sitios y Brotli en ~ 14%. Las relaciones de compresión son similares tanto para computadoras de escritorio como para dispositivos móviles.

Para un análisis más profundo sobre la compresión, consulte el capítulo de ["Compresión"](./compression).

## Bibliotecas y frameworks de código abierto

Código fuente abierto, o código con una licencia permisiva a la que cualquier persona pueda acceder, ver y modificar. Desde pequeñas bibliotecas hasta navegadores completos, como [Chromium](https://www.chromium.org/Home) y [Firefox](https://www.openhub.net/p/firefox), el código fuente abierto juega un papel crucial en el mundo del desarrollo web. En el contexto de JavaScript, los desarrolladores confían en herramientas de código abierto para incluir todo tipo de funcionalidad en su página web. Independientemente de si un desarrollador decide usar una pequeña biblioteca de utilidades o un framework masivo que dicta la arquitectura de toda su aplicación, confiar en paquetes de código abierto puede hacer que el desarrollo de funciones sea más fácil y rápido.

**¿Qué bibliotecas de código abierto de JavaScript se usan más?**

<figure>
	<table>
      <thead>
        <tr>
          <th>Librería</th>
          <th>Escritorio</th>
          <th>Móvil</th>
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
	<figcaption>Figura 11. Principales bibliotecas de JavaScript en computadoras de escritorio y dispositivos móviles.</figcaption>
</figure>

[jQuery](https://jquery.com/), la biblioteca JavaScript más popular jamás creada, se utiliza en el 85,03% de las páginas de escritorio y el 83,46% de las páginas móviles. El advenimiento de muchas API y métodos del navegador, tales como [Fetch](https://developer.mozilla.org/docs/Web/API/Fetch_API) y [querySelector](https://developer.mozilla.org/docs/Web/API/Document/querySelector), estandarizaron gran parte de la funcionalidad proporcionada por la biblioteca en una forma nativa. Aunque la popularidad de jQuery puede parecer estar disminuyendo, ¿por qué todavía se usa en la gran mayoría de la web?

Hay varias razones posibles:

- [WordPress](https://wordpress.org/), que se usa en más del 30% de los sitios, incluye jQuery por defecto.
- Cambiar de jQuery a una biblioteca más nueva del lado del cliente puede llevar tiempo dependiendo de qué tan grande sea una aplicación, y muchos sitios pueden consistir en jQuery y además bibliotecas más nuevas del lado del cliente.

Otras bibliotecas JavaScript más utilizadas incluyen variantes de jQuery (jQuery migrate, jQuery UI), [Modernizr](https://modernizr.com/), [Moment.js](https://momentjs.com/), [Underscore.js](https://underscorejs.org/), etc.

### Frameworks y bibliotecas de UI

En los últimos años, el ecosistema de JavaScript ha visto un aumento en las bibliotecas y frameworks de código abierto para facilitar la construcción de **aplicaciones de página única** (SPA por sus siglas en inglés). Una aplicación página única se caracteriza por ser una página web que carga una sola página HTML y usa JavaScript para modificar la página en la interacción del usuario en lugar de buscar nuevas páginas del servidor. Aunque esta sigue siendo la premisa principal de las aplicaciones de página única, todavía se pueden utilizar diferentes enfoques de representación del servidor para mejorar la experiencia de dichos sitios.

**¿Cuántos sitios usan este tipo de frameworks?**

<figure>
   <a href="/static/images/2019/javascript/fig12.png">
      <img src="/static/images/2019/javascript/fig12.png" alt="Figura 12. Los frameworks más utilizados en el escritorio." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1699359221&format=interactive">
   </a>
	<div id="fig12-description" class="visually-hidden">Gráfico de barras que muestra que el 4,6% de los sitios usan React, 2,0% AngiularJS, 1,8% Backbone.js, 0,8% Vue.js, 0,4% Knockout.js, 0,3% Zone.js, 0,3% Angular, 0,1% AMP, 0,1% Ember. js.</div>
	<figcaption id="fig12-caption">Figura 12. Los frameworks más utilizados en el escritorio.</figcaption>
</figure>

Aquí solo se analiza un subconjunto de marcos populares, pero es importante tener en cuenta que todos ellos siguen uno de estos dos enfoques:

- Arquitectura [modelo-vista-controlador](https://developer.chrome.com/apps/app_frameworks) (o modelo-vista-modelo de vista)
- Arquitectura basada en componentes

Aunque ha habido un cambio hacia un modelo basado en componentes, muchos frameworks más antiguos que siguen el paradigma MVC ([AngularJS](https://angularjs.org/), [Backbone.js](https://backbonejs.org/), [Ember](https://emberjs.com/)) todavía se usan en miles de páginas. Sin embargo, [React](https://reactjs.org/), [Vue](https://vuejs.org/) y [Angular](https://angular.io/) son los frameworks basados en componentes más populares ([Zone.js](https://github.com/angular/zone.js) es un paquete que ahora forma parte del núcleo angular).

Aunque este análisis es interesante, es importante tener en cuenta que estos resultados se basan en una biblioteca de detección de terceros - [Wappalyzer](https://www.wappalyzer.com). Todos estos números de uso dependen de la precisión de cada uno de los [mecanismos de detección](https://github.com/AliasIO/Wappalyzer/blob/master/src/apps.json).

## Carga diferenciada

Los [módulos JavaScript](https://v8.dev/features/modules), o ES modules, son soportados en [todos los navegadores principales](https://caniuse.com/#feat=es6-module). Los módulos proporcionan la capacidad de crear scripts que pueden importar y exportar desde otros módulos. Esto permite a cualquier persona construir sus aplicaciones diseñadas en un patrón de módulo, importando y exportando donde sea necesario, sin depender de cargadores de módulos de terceros.

Para declarar un script como módulo, la etiqueta del script debe tener el código `type="module"`:

```html
<script type="module" src="main.mjs"></script>
```

**¿Cuántos sitios usan `type ="module"` para los scripts en su página?**

<figure>
   <a href="/static/images/2019/javascript/fig13.png">
      <img src="/static/images/2019/javascript/fig13.png" alt="Figura 13. Porcentaje de sitios que utilizan type=module." aria-labelledby="fig13-caption" aria-describedby="fig13-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=1409239029&format=interactive">
   </a>
	<div id="fig13-description" class="visually-hidden">Gráfico de barras que muestra el 0,6% de los sitios en computadoras de escritorio usan 'type=module' y el 0,8% de los sitios en dispositivos móviles.</div>
	<figcaption id="fig13-caption">Figura 13. Porcentaje de sitios que utilizan type=module.</figcaption>
</figure>

El soporte a nivel de navegador para módulos todavía es relativamente nuevo, y los números aquí muestran que muy pocos sitios usan actualmente `type="module"` para sus scripts. Muchos sitios todavía dependen de cargadores de módulos (2,37% de todos los sitios de escritorio usan [RequireJS](https://github.com/requirejs/requirejs) por ejemplo) y _bundlers_ ([webpack](https://webpack.js.org/) por ejemplo) para definir módulos dentro de su código fuente.

Si se usan módulos nativos, es importante asegurarse de que se use un script de respaldo apropiado para los navegadores que aún no admiten módulos. Esto se puede hacer incluyendo un script adicional con un atributo `nomodule`.

```html
<script nomodule src="fallback.js"></script>
```

Cuando se usan juntos, los navegadores que admiten módulos ignorarán por completo cualquier script que contenga el atributo `nomodule`. Por otro lado, los navegadores que aún no admiten módulos no descargarán ningún script con `type ="module"`. Como tampoco reconocen `nomodule`, normalmente descargarán scripts con el atributo. El uso de este enfoque puede permitir a los desarrolladores [enviar código moderno a navegadores modernos para cargas de página más rápidas](https://web.dev/serve-modern-code-to-modern-browsers/).

Así que, **¿Cuántos sitios usan `nomodule` para los scripts en su página?**

<figure>
   <a href="/static/images/2019/javascript/fig14.png">
      <img src="/static/images/2019/javascript/fig14.png" alt="Figura 14. Porcentaje de sitios que usan nomodule." aria-labelledby="fig14-caption" aria-describedby="fig14-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=781034243&format=interactive">
   </a>
	<div id="fig14-description" class="visually-hidden">Gráfico de barras que muestra el 0,8% de los sitios en computadoras de escritorio usan 'nomodule' y el 0,5% de los sitios en dispositivos móviles.</div>
	<figcaption id="fig14-caption">Figura 14. Porcentaje de sitios que usan nomodule.</figcaption>
</figure>

Del mismo modo, muy pocos sitios (0,50% - 0,80%) usan el atributo `nomodule` para cualquier script.

## Preload y prefetch

[Preload](https://developer.mozilla.org/en-US/docs/Web/HTML/Preloading_content) y [prefetch](https://developer.mozilla.org/en-US/docs/Web/HTTP/Link_prefetching_FAQ) son directivas que le permiten ayudar al navegador a determinar qué recursos deben descargarse.

- Precargar un recurso con `<link rel="preload">` le dice al navegador que descargue este recurso lo antes posible. Esto es especialmente útil para los recursos críticos que se descubren tarde en el proceso de carga de la página (por ejemplo, JavaScript ubicado en la parte inferior de su HTML) y que, de lo contrario, se descargan al final.
- Usar `<link rel="prefetch">` le dice al navegador que aproveche el tiempo de inactividad que tiene para obtener estos recursos necesarios para futuras navegaciones

**Entonces, ¿cuántos sitios usan directivas de preload y prefetch?**

<figure>
   <a href="/static/images/2019/javascript/fig15.png">
      <img src="/static/images/2019/javascript/fig15.png" alt="Figura 15. Porcentaje de sitios que usan rel=preload para scripts." aria-labelledby="fig15-caption" aria-describedby="fig15-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=2007534370&format=interactive">
   </a>
	<div id="fig15-description" class="visually-hidden">Gráfico de barras que muestra que el 14% de los sitios en computadoras de escritorio usan 'rel=preload 'para scripts, y el 15% de los sitios en dispositivos móviles.</div>
	<figcaption id="fig15-caption">Figura 15. Porcentaje de sitios que usan rel=preload para scripts.</figcaption>
</figure>

Para todos los sitios medidos en HTTP Archive, el 14.33% de los sitios de computadoras de escritorio y el 14.84% de los sitios en dispositivos móviles usan `<link rel="preload">` para los scripts en su página.

Para _prefetch_:

<figure>
   <a href="/static/images/2019/javascript/fig16.png">
      <img src="/static/images/2019/javascript/fig16.png" alt="Figura 16. Porcentaje de sitios que usan rel=prefetch para scripts." aria-labelledby="fig16-caption" aria-describedby="fig16-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=547807937&format=interactive">
   </a>
	<div id="fig16-description" class="visually-hidden">Gráfico de barras que muestra el 0,08% de los sitios en computadoras de escritorio usan 'rel=prefetch' y el 0,08% de los sitios en dispositivos móviles.</div>
	<figcaption id="fig16-caption">Figura 16. Porcentaje de sitios que usan rel=prefetch para scripts.</figcaption>
</figure>

Tanto para dispositivos móviles como para computadoras de escritorio, el 0,08% de las páginas aprovechan la captación previa para cualquiera de sus scripts.

## Nuevos APIs

JavaScript continúa evolucionando como lenguaje. Todos los años se lanza una nueva versión del estándar del lenguaje, conocido como ECMAScript, con nuevas API y características que pasan las etapas de la propuesta para formar parte del lenguaje en sí.

Con HTTP Archive, podemos echar un vistazo a cualquier API más nueva que sea compatible (o esté a punto de serlo) y ver qué tan extendido es su uso. Estas API ya se pueden usar en navegadores que las admiten _o_ con un polyfill adjunto para asegurarse de que aún funcionan para todos los usuarios.

**¿Cuántos sitios usan las siguientes API?**

- [Atomics](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Atomics)
- [Intl](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl)
- [Proxy](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy)
- [SharedArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer)
- [WeakMap](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap)
- [WeakSet](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakSet)

<figure>
   <a href="/static/images/2019/javascript/fig17.png">
      <img src="/static/images/2019/javascript/fig17.png" alt="Figura 17. Uso de nuevas API de JavaScript." aria-labelledby="fig17-caption" aria-describedby="fig17-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=594315296&format=interactive">
   </a>
	<div id="fig17-description" class="visually-hidden">Gráfico de barras que muestra el 25,5% / 36,2% de los sitios en computadoras de escritorio y dispositivos móviles usa WeakMap, 6,1% / 17,2% usa WeakSet, 3,9% / 14,0% usa Intl, 3,9% / 4,4% usa Proxy, 0,4% / 0,4% usa Atomics, y 0,2% / 0,2% usan SharedArrayBuffer.</div>
	<figcaption id="fig17-caption">Figura 17. Uso de nuevas API de JavaScript.</figcaption>
</figure>

Atomics (0,38%) y SharedArrayBuffer (0,20%) son apenas visibles en este gráfico ya que se usan en tan pocas páginas.

Es importante tener en cuenta que los números aquí son aproximaciones y no aprovechan [UseCounter](https://chromium.googlesource.com/chromium/src.git/+/master/docs/use_counter_wiki.md) para medir el uso de funciones.

## Mapas fuente

En muchos sistemas de compilación, los archivos JavaScript sufren una minificación para minimizar su tamaño y transpilación para las nuevas funciones de lenguaje que aún no son compatibles con muchos navegadores. Asimismo, superconjuntos de lenguage como [TypeScript](https://www.typescriptlang.org/) compilan a una salida que pueda verse notablemente diferente del código fuente original. Por todas estas razones, el código final servido al navegador puede ser ilegible y difícil de descifrar.

Un **mapa fuente** es un archivo adicional que acompaña a un archivo JavaScript que permite que un navegador asigne la salida final a su fuente original. Esto puede hacer que la depuración y el análisis de paquetes de producción sean mucho más simples.

Aunque es útil, hay una serie de razones por las cuales muchos sitios pueden no querer incluir mapas fuente en su sitio de producción final, como elegir no exponer el código fuente completo al público. **Entonces, ¿cuántos sitios realmente incluyen mapas fuente?**

<figure>
   <a href="/static/images/2019/javascript/fig18.png">
      <img src="/static/images/2019/javascript/fig18.png" alt="Figura 18. Porcentaje de sitios que usan mapas fuente." aria-labelledby="fig18-caption" aria-describedby="fig18-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vTpzDb9HGbdVvin6YPTOmw11qBVGGysltxmH545fUfnqIThAq878F_b-KxUo65IuXaeFVSnlmJ5K1Dm/pubchart?oid=906754154&format=interactive">
   </a>
	<div id="fig18-description" class="visually-hidden">Gráfico de barras que muestra el 18% de los sitios de escritorio y el 17% de los sitios móviles utilizan mapas fuente.</div>
	<figcaption id="fig18-caption">Figura 18. Porcentaje de sitios que usan mapas fuente.</figcaption>
</figure>

Para las páginas de escritorio y móviles, los resultados son casi los mismos. Un 17-18% incluye un mapa fuente para al menos un script en la página (detectado como un script de contenido de origen con `sourceMappingURL`).

## Conclusión

El ecosistema de JavaScript continúa cambiando y evolucionando cada año. Las API más nuevas, los motores de navegador mejorados y las bibliotecas y frameworks nuevos son cosas que podemos esperar que sucedan indefinidamente. HTTP Archive nos proporciona información valiosa sobre cómo los sitios en la naturaleza usan el lenguaje.

Sin JavaScript, la web no estaría donde está hoy, y todos los datos recopilados para este artículo solo lo demuestran.

<script src='/static/js/chapter.js' defer></script>
