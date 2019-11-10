---
part_number: II
chapter_number: 7
title: Performance
description: Capítulo sobre rendimiento del Web Almanac de 2019 que explica First Contentful Paint (FCP), Time to First Byte (TTFB) y First Input Delay (FID) 
authors: [rviscomi]
reviewers: [JMPerez,obto,sergeychernyshev,zeman]
published: 2019-11-04T12:00:00+00:00:00
last_updated: 2019-11-07T21:46:11.000Z 
---

## Introducción

El rendimiento es una parte esencial de la experiencia del usuario. En [muchos sitios web](https://wpostats.com/), una mejora en la experiencia del usuario al acelerar el tiempo de carga de la página se corresponde con una mejora en las tasas de conversión. Por el contrario, cuando el rendimiento es deficiente, los usuarios no realizan conversiones con tanta frecuencia e incluso se ha observado que realizan [ráfagas de clicks](https://blog.fullstory.com/rage-clicks-turn-analytics-into-actionable-insights/) en la página como muestra de frustración.

Hay muchas formas de cuantificar el rendimiento web. Lo más importante es medir lo que realmente importa a los usuarios. Eventos como `onload` o` DOMContentLoaded` pueden no reflejar necesariamente lo que los usuarios experimentan visualmente. Por ejemplo, al cargar un cliente de correo electrónico, puede mostrar una barra de progreso mientras el contenido de la bandeja de entrada se carga de forma asincróna. El problema es que el evento `onload` no espera a que la bandeja de entrada se cargue asincrónamente. En este ejemplo, la métrica de carga que más le importa a los usuarios es el "tiempo para la bandeja de entrada", y centrarse en el evento `onload` puede ser engañoso. Por esa razón, este capítulo analizará métricas de pintado, carga e interactividad más modernas y de aplicación universal para tratar de capturar cómo los usuarios realmente están experimentando la página.

Hay dos tipos de datos de rendimiento: laboratorio y campo. También se les denomina pruebas sintéticas y medidas de usuario real (real-user measurement o RUM). La medición del rendimiento en el laboratorio garantiza que cada sitio web se pruebe bajo condiciones comunes y las variables como el navegador, la velocidad de conexión, la ubicación física, el estado de la memoria caché, etc., permanecen iguales. Esta garantía de consistencia hace que cada sitio web sea comparable entre sí. Por otro lado, medir el rendimiento en el campo representa cómo los usuarios realmente experimentan la web en todas las combinaciones infinitas de condiciones que nunca podríamos capturar en el laboratorio. Para los propósitos de este capítulo y para comprender las experiencias de los usuarios del mundo real, nos centraremos en los datos de campo.

## El estado de rendimiento

Casi todos los otros capítulos en el Almanaque Web se basan en datos de [HTTP Archive](https://httparchive.org/). Sin embargo, para capturar cómo los usuarios reales experimentan la web, necesitamos un conjunto de datos diferente. En esta sección estamos utilizando el [Informe de Chrome UX](http://bit.ly/chrome-ux-report) (CrUX), un conjunto de datos público de Google que consta de los mismos sitios web que HTTP Archive, y agrega cómo los usuarios de Chrome realmente los experimentan. Las experiencias se clasifican por:

- El factor de forma de los dispositivos de los usuarios.
  - Escritorio
  - Teléfono
  - Tableta
- Tipo de conexión efectiva (ECT) de los usuarios en términos móviles
  - Sin conexión
  - 2G lento
  - 2G
  - 3G
  - 4G
- Ubicaciones geográficas de los usuarios

Las experiencias se miden mensualmente, incluidas las métricas de pintado, carga e interactividad. La primera métrica que veremos es [First Contentful Paint](https://developers.google.com/web/fundamentals/performance/user-centric-performance-metrics#first_paint_and_first_contentful_paint) (FCP). Este es el tiempo que los usuarios pasan esperando que la página muestre algo útil en la pantalla, como una imagen o texto. Luego, veremos una métrica de carga, [Time to First Byte](https://developer.mozilla.org/docs/Glossary/time_to_first_byte) (TTFB). Ésta es una medida del tiempo que tarda la página web desde el momento de la navegación del usuario hasta que recibe el primer byte de la respuesta. Y, finalmente, la última métrica de campo que veremos es [First Input Delay](https://developers.google.com/web/updates/2018/05/first-input-delay) (FID). Ésta es una métrica relativamente nueva y representa partes de la experiencia de usuario que no sean el rendimiento de carga. Mide el tiempo desde la primera interacción de un usuario con la interfaz de usuario de una página hasta el momento en que el hilo principal del navegador está listo para procesar el evento.

Así que vamos a profundizar y ver qué resultados podemos encontrar.

### First Contentful Paint

<figure id="fig1">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=115935793&amp;format=interactive"></iframe>
<figcaption>Figura 1. Distribución del rendimiento rápido, moderado y lento de FCP.</figcaption>
</figure>

En la Figura 1 anterior, se puede ver cómo se distribuyen las experiencias de FCP en la web. De los millones de sitios web en el conjunto de datos de CrUX, este gráfico comprime la distribución a 1.000 sitios web, donde cada segmento vertical representa un sólo sitio web. El cuadro está ordenado por el porcentaje de experiencias rápidas de FCP, que son las que ocurren en menos de 1 segundo. Las experiencias lentas ocurren en 3 segundos o más, y las experiencias moderadas (anteriormente conocidas como "promedias") son todo lo que hay en medio. En los extremos de la tabla hay algunos sitios web con experiencias casi 100% rápidas y algunos sitios web con experiencias casi 100% lentas. Entre medias, los sitios web que tienen una combinación de rendimiento rápido, moderado y lento parecen inclinarse más hacia rápido o moderado que lento, lo cual es bueno.

<aside class="note">Nota: cuando un usuario experimenta un rendimiento lento es difícil decir cuál podría ser el motivo. Podría ser que el sitio web en sí mismo se construyó de manera deficiente e ineficiente. O podría haber otros factores ambientales como la conexión lenta del usuario, la caché vacía, etc. Por lo tanto, cuando miramos estos datos de campo, preferimos decir que las experiencias del usuario son lentas y no necesariamente los sitios web.</aside>

Para clasificar si un sitio web es lo suficientemente **rápido** utilizaremos la nueva metodología [PageSpeed Insights](https://developers.google.com/speed/docs/insights/v5/about#categories) (PSI), donde al menos el 75% de las experiencias de FCP del sitio web deben ser más rápidas que 1 segundo. Del mismo modo, un sitio web lo suficientemente **lento** tiene un 25% o más de experiencias FCP más lentas que 3 segundos. Decimos que un sitio web tiene un rendimiento **moderado** cuando no cumple con ninguna de estas condiciones.

<figure id="fig2">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=36103372&amp;format=interactive"></iframe>
<figcaption>Figure 2. Distribución de sitios web etiquetados con FCP rápido, moderado o lento.</figcaption>
</figure>

Los resultados en la Figura 2 muestran que sólo el 13% de los sitios web se consideran rápidos. Esta es una señal de que todavía hay mucho margen de mejora, pero muchos sitios web están pintando contenido significativo de manera rápida y consistente. Dos tercios de los sitios web tienen experiencias moderadas de FCP.

Para ayudarnos a comprender cómo los usuarios experimentan FCP en diferentes dispositivos, segmentemos por factor de forma.

#### FCP por dispositivo

<figure id="fig3">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1231764008&amp;format=interactive"></iframe>
<figcaption markdown>Figura 3. Distribución del rendimiento en sitios <em>de escritorio</em> según su FCP, entre rápidos, moderados y lentos.</figcaption>
</figure>

<figure id="fig4">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=167423587&amp;format=interactive"></iframe>
<figcaption markdown>Figura 3. Distribución del rendimiento en sitios <em>móviles</em> según su FCP, entre rápidos, moderados y lentos.</figcaption>
</figure>

En las Figuras 3 y 4 anteriores las distribuciones de FCP se desglosan por computadora y teléfono. Es sutil, pero el torso de la distribución rápida de FCP en escritorio parece ser más convexo que la distribución para usuarios de teléfonos. Esta aproximación visual sugiere que los usuarios de escritorio experimentan una mayor proporción general de FCP rápido. Para verificar esto, podemos aplicar la metodología PSI a cada distribución.

<figure id="fig5">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=486448175&amp;format=interactive"></iframe>
<figcaption>Figura 5. Distribución de sitios web etiquetados como que tienen FCP rápido, moderado o lento, desglosados por tipo de dispositivo.</figcaption>
</figure>

Según la clasificación de PSI, el 17% de los sitios web tienen experiencias rápidas de FCP en general para usuarios de escritorio, en comparación con el 11% para usuarios de dispositivos móviles. La distribución completa está sesgada hacia ser un poco más rápida para las experiencias de escritorio, con menos sitios web lentos y más en la categoría rápida y moderada.

¿Por qué los usuarios de escritorio pueden experimentar un FCP rápido en una mayor proporción de sitios web que los usuarios de teléfonos? Después de todo, sólo podemos especular que este conjunto de datos está destinado a responder cómo está funcionando la web y no necesariamente por qué está funcionando de esa manera. Pero una suposición podría ser que los usuarios de escritorio están conectados a Internet en redes más rápidas y fiables como WiFi en lugar de torres de telefonía celular. Para ayudar a responder esta pregunta, también podemos explorar cómo las experiencias de los usuarios varían según el ECT.

#### FCP por tipo de conexión efectiva

<figure id="fig6">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1987967547&amp;format=interactive"></iframe>
<figcaption>Figura 6. Distribución de sitios web etiquetados como que tienen FCP rápido, moderado o lento, desglosados por <abbr title="effective connection type">ECT</abbr>.</figcaption>
</figure>

En la Figura 6 anterior, las experiencias de FCP se agrupan por la ECT de la experiencia del usuario. Curiosamente, existe una correlación entre la velocidad de ECT y el porcentaje de sitios web que sirven FCP rápido. A medida que las velocidades de ECT disminuyen, la proporción de experiencias rápidas se acerca a cero. El 14% de los sitios web que sirven a los usuarios 4G ECT tienen experiencias rápidas de FCP, mientras que el 19% de esos sitios web tienen experiencias lentas. El 61% de los sitios web ofrecen FCP lento a usuarios con 3G ECT, 90% a 2G ECT y 99% a 2G lento ECT. Estos resultados sugieren que los sitios web rara vez sirven FCP rápido de manera consistente a los usuarios en conexiones efectivamente más lentas que 4G.

#### FCP por geografía

<figure id="fig7">
<iframe width="600" height="940" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=792398959&amp;format=interactive"></iframe>
<figcaption>Figura 7. Distribución de sitios web etiquetados como que tienen FCP rápido, moderado o lento, desglosados por geo.</figcaption>
</figure>

Finalmente, podemos estudiar el FCP basándonos en la geografía de los usuarios (geo). El cuadro anterior muestra los 23 principales geos que tienen el mayor número de sitios web distintos, un indicador de la popularidad general de la web abierta. Los usuarios de la web en los Estados Unidos visitan la mayor cantidad de sitios distintos, con un total de 1.211.002. Los geos se ordenan por el porcentaje de sitios web que tienen experiencias FCP suficientemente rápidas. En la parte superior de la lista hay tres geos de [Asia-Pacífico](https://en.wikipedia.org/wiki/Asia-Pacific) (APAC): Corea, Taiwán y Japón. Esto podría explicarse por la disponibilidad de [velocidades de conexión de red extremadamente rápidas en estas regiones](https://en.wikipedia.org/wiki/List_of_countries_by_Internet_connection_speeds). Corea tiene el 36% de los sitios web que cumplen con la barra rápida de FCP, y solo el 7% clasificados como FCP lento. Recuerde que la distribución global de sitios web rápidos/moderados/lentos es aproximadamente 13/66/20, lo que hace que Corea sea un valor atípico significativamente positivo.

Otros geos de APAC cuentan una historia diferente. Tailandia, Vietnam, Indonesia e India tienen menos del 10% de sitios web rápidos. Estos geos también tienen más del triple de la proporción de sitios web lentos que Corea.

### Time to First Byte (TTFB)

[Time to First Byte](https://web.dev/time-to-first-byte) (TTFB) es una medida de cuánto tiempo tarda la página web desde el momento de la navegación del usuario hasta que recibe el primer byte de la respuesta.

<figure id="fig8" markdown>
![Diagrama de la API de Navigation Timing de los eventos en la navegación de una página](/static/images/2019/07_Performance/nav-timing.png)
<figcaption>Figura 8. Diagrama de la API de Navigation Timing de los eventos en la navegación de una página.</figcaption>
</figure>

Para ayudar a explicar TTFB y los muchos factores que lo afectan, tomemos prestado un diagrama de la [especificación de la API de Navigation Timing](https://developer.mozilla.org/docs/Web/API/Navigation_timing_API). En la Figura 8 anterior, TTFB es la duración desde `startTime` hasta` responseStart`, que incluye todo lo que se encuentra entre: `unload`, `redirects`, `AppCache`,` DNS`, `SSL`,` TCP` y el tiempo el servidor pasa gestionando la petición. Dado ese contexto, veamos cómo los usuarios están experimentando esta métrica.

<figure id="fig9">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=444630188&amp;format=interactive"></iframe>
<figcaption>Figura 9. Distribución del rendimiento TTFB rápido, moderado y lento.</figcaption>
</figure>

De forma similar a la tabla de FCP en la Figura 1, ésta es una vista de 1.000 muestras representativas ordenadas por TTFB rápido. Un [TTFB rápido](https://developers.google.com/speed/docs/insights/Server#recommendations) es el que ocurre en menos de 0,2 segundos (200 ms), un TTFB lento ocurre en 1 segundo o más, y todo en medio es moderado.

Mirando la curva de las proporciones rápidas, la forma es bastante diferente de la del FCP. Hay muy pocos sitios web que tienen un TTFB rápido superior al 75%, mientras que más de la mitad están por debajo del 25%.

Apliquemos una etiqueta de velocidad TTFB a cada sitio web, inspirándonos en la metodología PSI utilizada anteriormente para FCP. Si un sitio web ofrece TTFB rápido al 75% o más de experiencias de usuario, se etiqueta como **rápido**. De lo contrario, si sirve TTFB **lento** al 25% o más de experiencias de usuario, es lento. Si ninguna de esas condiciones se aplica, es **moderada**.

<figure id="fig10">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=926985367&amp;format=interactive"></iframe>
<figcaption>Figura 10. Distribución de sitios web etiquetados como que tienen TTFB rápido, moderado o lento.</figcaption>
</figure>

El 42% de los sitios web tienen experiencias de TTFB lento. Esto es significativo porque el TTFB es un bloqueador para todas las demás métricas de rendimiento subsiguientes. _Por definición, un usuario no puede experimentar un FCP rápido si el TTFB tarda más de 1 segundo_.

#### TTFB por geo

<figure id="fig11">
<iframe width="600" height="940" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=685447534&amp;format=interactive"></iframe>
<figcaption>Figura 10. Distribución de sitios web etiquetados como que tienen TTFB rápido, moderado o lento, desglosados por geo.</figcaption>
</figure>

Ahora echemos un vistazo al porcentaje de sitios web que sirven TTFB rápido a usuarios en diferentes geos. Los geos de APAC como Corea, Taiwán y Japón siguen superando a los usuarios del resto del mundo. Pero ninguna geo tiene más del 15% de sitios web con TTFB rápido. India, por ejemplo, tiene menos del 1% de los sitios web con TTFB rápido y el 79% con TTFB lento.

### First Input Delay

La última métrica de campo que veremos es [First Input Delay](https://developers.google.com/web/updates/2018/05/first-input-delay) (FID). Esta métrica representa el tiempo desde la primera interacción de un usuario con la interfaz de usuario de una página hasta el momento en que el hilo principal del navegador está listo para procesar el evento. Tenga en cuenta que esto no incluye el tiempo que las aplicaciones pasan realmente manejando el evento de entrada. En el peor de los casos, un FID lento da como resultado una página que parece no responder y una experiencia de usuario frustrante.

Comencemos definiendo algunos umbrales. De acuerdo con la nueva metodología PSI, un FID **rápido** es uno que ocurre en menos de 100 ms. Esto le da a la aplicación suficiente tiempo para manejar el evento de entrada y proporcionar feedback al usuario en un momento que se siente instantáneo. Un FID **lento** es uno que ocurre en 300 ms o más. Todo entre medias es **moderado**.

<figure id="fig12">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=60679078&amp;format=interactive"></iframe>
<figcaption>Figura 12. Distribución de sitios web según si su rendimiento FID  es rápido, moderado o lento.</figcaption>
</figure>

Seguimos el mismo procedimiento que hasta ahora. Este gráfico muestra la distribución de las experiencias FID rápidas, moderadas y lentas de los sitios web. Éste es un gráfico dramáticamente diferente de los gráficos anteriores para FCP y TTFB. (Ver [Figura 1](#fig1) y [Figura 9](#fig9) respectivamente). La curva de FID rápido desciende muy lentamente del 100% al 75% y luego cae en picada. La gran mayoría de las experiencias de FID son rápidas para la mayoría de los sitios web.

<figure id="fig13">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1828752871&amp;format=interactive"></iframe>
<figcaption>Figura 13. Distribución de sitios web etiquetados como que tienen un TTFB rápido, moderado o lento.</figcaption>
</figure>

La metodología de PSI para etiquetar un sitio web con un FID suficientemente rápido o lento es ligeramente diferente de la de FCP. Para que un sitio sea **rápido**, el 95% de sus experiencias FID debe ser rápido. Un sitio es **lento** si el 5% de sus experiencias FID son lentas. Todas las demás experiencias son **moderadas**.

En comparación con las métricas anteriores, la distribución del rendimiento agregado de FID está mucho más sesgada hacia experiencias rápidas y moderadas que lentas. El 40% de los sitios web tienen FID rápido y sólo el 15% tiene FID lento. Dado que FID es una métrica de interactividad, a diferencia de una métrica de carga limitada por las velocidades de red, la convierte en una forma completamente diferente de representar el rendimiento.

#### FID por dispositivo

<figure id="fig14">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=16379508&amp;format=interactive"></iframe>
<figcaption>Figura 14. Distribución de sitios web de <em>escritorio</em> según si su rendimiento de FID es rápido, moderado o lento.</figcaption>
</figure>

<figure id="fig15">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=519511409&amp;format=interactive"></iframe>
<figcaption>Figura 14. Distribución de sitios web <em>móviles</em> según si su rendimiento de FID es rápido, moderado o lento.</figcaption>
</figure>

Al desglosar el FID por dispositivo queda claro que hay dos historias muy diferentes. Los usuarios de escritorio disfrutan de un FID rápido casi todo el tiempo. Por supuesto, hay algunos sitios web que sirven una experiencia lenta de vez en cuando, pero los resultados son predominantemente rápidos. Los usuarios móviles, por otro lado, tienen lo que parece ser una de dos posibles experiencias: bastante rápido (pero no tan a menudo como en escritorio) y casi nunca rápido. Los usuarios experimentan este último sólo en un ~10% de los sitios web situados en la cola, pero esto sigue siendo una diferencia sustancial.

<figure id="fig16">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1533541692&amp;format=interactive"></iframe>
<figcaption>Figura 16. Distribución de sitios web etiquetados como que tienen un FID rápido, moderado o lento, desglosado por tipo de dispositivo.</figcaption>
</figure>

Cuando aplicamos el etiquetado PSI a las experiencias de escritorio y móvil, la distinción se vuelve clara como el cristal. El 82% del FID de los sitios web experimentado por los usuarios de escritorio es rápido en comparación con el 5% lento. Para las experiencias móviles, el 26% de los sitios web son rápidos, mientras que el 22% son lentos. El tipo de dispositivo juega un papel importante en el rendimiento de las métricas de interactividad como FID.

#### FID por tipo de conexión efectiva

<figure id="fig17">
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=1173039776&amp;format=interactive"></iframe>
<figcaption>Figura 17. Distribución de sitios web etiquetados como que tienen un FID rápido, moderado o lento, desglosados por <abbr title="effective connection type">ECT</abbr>.</figcaption>
</figure>

A primera vista parece que FID estaría relacionado principalmente con la velocidad de la CPU. Sería razonable suponer que cuanto más lento es el dispositivo, mayor es la probabilidad de que esté ocupado cuando el usuario intente interactuar con una página web, ¿verdad?

Los resultados de ECT anteriores parecen sugerir que existe una correlación entre la velocidad de conexión y el rendimiento del FID. A medida que disminuye la velocidad de conexión efectiva de los usuarios, el porcentaje de sitios web en los que experimentan FID rápido también disminuye: el 41% de los sitios web visitados por los usuarios con un ECT 4G tienen FID rápido, el 22% con 3G, el 19% con 2G y el 15% con 2G lento.

#### FID por geo

<figure id="fig18">
<iframe width="600" height="940" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSQlf3_ySLPB5322aTumUZhbVGdaUdkmi1Hs4bYuO3Z1kqM4xspx7REbwXukwPd_tsOSg6oImzpYLM9/pubchart?oid=11500240&amp;format=interactive"></iframe>
<figcaption>Figura 18. Distribución de sitios web etiquetados como que tienen un FID rápido, moderado o lento, desglosados por geo.</figcaption>
</figure>

En este desglose del FID por ubicación geográfica, Corea está nuevamente al frente. Pero los principales geos tienen algunas caras nuevas: Australia, Estados Unidos y Canadá son los siguientes, con más del 50% de los sitios web que tienen una FID rápida.

Al igual que con los otros resultados geoespecíficos, hay muchos factores posibles que podrían estar contribuyendo a la experiencia del usuario. Por ejemplo, quizás los geos más ricos que son más privilegiados pueden permitirse una infraestructura de red más rápida y también tienen residentes con más dinero para gastar en computadoras de escritorio y/o teléfonos móviles de alta gama.

## Conclusión

Cuantificar cómo de rápido carga una página web es una ciencia imperfecta que no puede ser representada por una única métrica. Las métricas convencionales como `onload` pueden fallar por completo al medir partes irrelevantes o imperceptibles de la experiencia del usuario. Las métricas percibidas por el usuario, como FCP y FID, transmiten más fielmente lo que los usuarios ven y sienten. Aún así, ninguna de las métricas se puede considerar de forma aislada para sacar conclusiones sobre si la experiencia general de carga de la página es rápida o lenta. Sólo observando muchas métricas de manera integral podemos comenzar a comprender el rendimiento de un sitio web individual y el estado de la web.

Los datos presentados en este capítulo mostraron que todavía hay mucho trabajo por hacer para cumplir los objetivos establecidos para los sitios web rápidos. Ciertos factores de forma, tipos de conexión efectivos y geos se correlacionan con mejores experiencias de usuario, pero no podemos olvidarnos de las combinaciones de datos demográficos con bajo rendimiento. En muchos casos la plataforma web se utiliza para negocios; ganar más dinero mejorando las tasas de conversión puede ser un gran motivador para acelerar un sitio web. En última instancia, para todos los sitios web, el rendimiento consiste en brindar experiencias positivas a los usuarios de una manera que no los impida, los frustre o los enfurezca.

A medida que la web envejece un año más y nuestra capacidad de medir cómo los usuarios la experimentan mejora gradualmente, espero que los desarrolladores tengan acceso a métricas que capturan más la experiencia holística del usuario. FCP ocurre muy pronto en la línea de tiempo de mostrar contenido útil a los usuarios, y están surgiendo métricas más nuevas como [Largest Contentful Paint](https://web.dev/largest-contentful-paint) (LCP) para mejorar nuestra visibilidad sobre cómo la carga de la página es percibida. La [API de Layout Instability](https://web.dev/layout-instability-api) también nos ha dado una nueva visión de la frustración que experimentan los usuarios más allá de la carga de la página.

Equipados con estas nuevas métricas, la web en 2020 se volverá aún más transparente, mejor entendida y brindará a los desarrolladores una ventaja para lograr un progreso más significativo para mejorar el rendimiento y contribuir a experiencias de usuario positivas.
