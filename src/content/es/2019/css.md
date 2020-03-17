---
part_number: I
chapter_number: 2
title: CSS
description: Capítulo CSS del 2019 Web Almanac que cubre el color, las unidades, los selectores, el diseño, la tipografía y las fuentes, el espaciado, la decoración, la animación y las consultas de medios.
authors: [una, argyleink]
reviewers: [meyerweb, huijing]
translators: [c-torres]
discuss: 1757
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-23T00:00:00.000Z
---

## Introducción

Las Hojas de Estilo en Cascada (CSS por sus siglas en inglés) se utilizan para pintar, formatear y diseñar páginas web. Sus capacidades abarcan conceptos tan simples como el color del texto hasta perspectiva 3D. También tiene ganchos para permitir a los desarrolladores manejar diferentes tamaños de pantalla, contextos de visualización e impresión. CSS ayuda a los desarrolladores a lidiar con el contenido y a asegurarse de que se adapte correctamente al usuario.

Al describir CSS a aquellos que no están familiarizados con la tecnología web, puede ser útil pensar que es el lenguaje para pintar las paredes de la casa; describiendo el tamaño y la posición de ventanas y puertas, así como decoraciones florecientes como papel tapiz o vida vegetal. El giro divertido de esa historia es que, dependiendo del usuario que camina por la casa, ¡un desarrollador puede adaptar la casa a las preferencias o contextos específicos de ese usuario!

En este capítulo, inspeccionaremos, contaremos y extraeremos datos sobre cómo se usa CSS en la web. Nuestro objetivo es comprender de manera integral qué características se están utilizando, cómo se usan y cómo CSS está creciendo y siendo adoptado.

¿Listo para profundizar en los datos fascinantes? ¡Muchos de los siguientes números pueden ser pequeños, pero no los confundas como insignificantes! Pueden pasar muchos años hasta que nuevas cosas saturen la web.

## Color

El color es una parte integral de la temática y el estilo en la web. Echemos un vistazo a cómo los sitios web tienden a usar el color.

### Tipos de color

Hex es la forma más popular de describir el color por mucho, con un 93% de uso, seguido de RGB y luego HSL. Curiosamente, los desarrolladores están aprovechando al máximo el argumento de la transparencia alfa cuando se trata de estos tipos de colores: HSLA y RGBA son mucho más populares que HSL y RGB, ¡con casi el doble de uso! Aunque la transparencia alfa se agregó más tarde a la especificación web, HSLA y RGBA son compatibles [desde IE9] (https://caniuse.com/#feat=css3-colors), por lo que puede seguir adelante, y ¡usarlos a ellos tambien!

<figure>
  <a href="/static/images/2019/css/fig1.png">
    <img src="/static/images/2019/css/fig1.png" alt="Figura 1. Popularidad de los formatos de color." aria-labelledby="fig1-caption" aria-describedby="fig1-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1946838030&amp;format=interactive">
  </a>
  <div id="fig1-description" class="visually-hidden">Gráfico de barras que muestra la adopción de los formatos HSL, HSLA, RGB, RGBA y hexadecimal. Hex se usa en el 93% de las páginas de escritorio, RGBA en el 83%, RGB en el 22%, HSLA 19% y HSL 1%. La adopción móvil y de escritorio es similar para todos los formatos de color, excepto HSL, para el cual la adopción móvil es del 9% (9 veces mayor).</div>
  <figcaption id="fig1-caption">Figura 1. Popularidad de los formatos de color.</figcaption>
</figure>

### Selección de color

Existen [148 colores de CSS nombrados](https://www.w3.org/TR/css-color-4/#named-colors), sin incluir los valores especiales `transparent` y `currentcolor`. Puede usarlos por su nombre en cadena de texto para un estilo más legible. Los colores con nombre más populares son `black` y `white`, sin sorprender, seguidos por `red` y `blue`.

<figure>
  <a href="/static/images/2019/css/fig2.png">
    <img src="/static/images/2019/css/fig2.png" alt="Figura 2. Principales colores con nombre." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="415" data-width="600" data-height="415" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1985913808&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">Gráfico circular que muestra los colores con nombre más populares. El blanco es el más popular al 40%, luego el negro al 22%, el rojo al 11% y el azul al 5%.</div>
  <figcaption id="fig2-caption">Figura 2. Principales colores con nombre.</figcaption>
</figure>

El idioma también se infiere de manera interesante a través del color. Hay más instancias del "gray" de estilo americano que del "grey" de estilo británico. Casi cada instancia de [colores grises](https://www.rapidtables.com/web/color/gray-color.html) (`gray`, `lightgray`, `darkgray`, `slategray`, etc.) tenía casi el doble de uso cuando se deletreaba con una "a" en lugar de una "e". Si la combinación gr[a/e]ys se tomara en cuenta, tendrían un rango más alto que el azul, solidificándose en el puesto #4. ¡Esta podría ser la razón por la cual `plata` ocupa un lugar más alto que `grey` con una "e" en las listas!

### Conteo de color

¿Cuántos colores de fuente diferentes se utilizan en la web? Entonces este no es el número total de colores únicos; más bien, es cuántos colores diferentes se usan solo para el texto. Los números en este gráfico son bastante altos y, por experiencia, sabemos que sin variables CSS, el espaciado, los tamaños y los colores pueden escaparse rápidamente de y fragmentarse en muchos valores pequeños en sus estilos. Estos números reflejan una dificultad en la gestión del estilo, y esperamos que esto ayude a crear alguna perspectiva para que pueda traer de vuelta a sus equipos o proyectos. ¿Cómo puede reducir este número a una cantidad manejable y razonable?

<figure>
  <a href="/static/images/2019/css/fig3.png">
    <img src="/static/images/2019/css/fig3.png" alt="Figura 3. Distribución de colores por página." aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1361184636&amp;format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">Distribución que muestra los percentiles 10, 25, 50, 75 y 90 de colores por computadoras de escritorio y página móvil. En computadoras de  escritorio, la distribución es 8, 22, 48, 83 y 131. Las páginas móviles tienden a tener más colores entre 1 y 10.</div>
  <figcaption id="fig3-caption">Figura 3. Distribución de colores por página.</figcaption>
</figure>

### Duplicación del color

Bueno, tenemos curiosidad aquí y queríamos inspeccionar cuántos colores duplicados hay en una página. Sin un sistema CSS de clase reutilizable bien administrado, los duplicados son bastante fáciles de crear. Resulta que la mediana tiene suficientes duplicados que valdría la pena hacer un pase para unificarlos con propiedades personalizadas.

<figure>
  <a href="/static/images/2019/css/fig4.png">
    <img src="/static/images/2019/css/fig4.png" alt="Figura 4. Distribución de colores duplicados por página." aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=326531498&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">Gráfico de barras que muestra la distribución de colores por página. La página de escritorio promedio tiene 24 colores duplicados. El percentil 10 es de 4 colores duplicados y el percentil 90 es de 62. Las distribuciones de escritorio y móviles son similares.</div>
  <figcaption id="fig4-caption">Figura 4. Distribución de colores duplicados por página.</figcaption>
</figure>

## Unidades

En CSS, hay muchas formas diferentes de lograr el mismo resultado visual utilizando diferentes tipos de unidades: `rem`, `px`, `em`, `ch`, o ¡incluso `cm`! Entonces, ¿qué tipos de unidades son más populares?

<figure>
  <a href="/static/images/2019/css/fig5.png">
    <img src="/static/images/2019/css/fig5.png" alt="Figura 5. Popularidad de los tipos de unidades." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=540111393&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">Gráfico de barras de la popularidad de varios tipos de unidades.Las unidades px y em se utilizan en más del 90% de las páginas. La unidad rem es el siguiente tipo de unidad más popular en el 40% de las páginas y la popularidad cae rápidamente para los tipos de unidades restantes.</div>
  <figcaption id="fig5-caption">Figura 5. Popularidad de los tipos de unidades.</figcaption>
</figure>

### Longitud y tamaño

Como era de esperar, en la figura 5, `px` es el tipo de unidad más utilizado, es el tipo de unidad más utilizado con aproximadamente el 95% de las páginas web usando píxeles de una forma u otra (esto podría ser el tamaño del elemento, el tamaño de la fuente, etc.). Sin embargo, la unidad `em` es casi tan popular, con uso alrededor del 90%. Esto es más de 2 veces más popular que la unidad `rem`,que tiene solo un 40% de frecuencia en las páginas web. Si te preguntas cuál es la diferencia, `em` se basa en el tamaño de fuente principal, mientras que `rem` se basa en el tamaño de fuente base establecido en la página. No cambia por componente como podría hacerlo `em`,y así permite el ajuste de todos los espacios de manera uniforme.

Cuando se trata de unidades basadas en el espacio físico, la unidad `cm` (or centímetros) es la más popular por mucho, seguida por `in` (pulgadas), y luego por  `Q`.Sabemos que este tipo de unidades son específicamente útiles para imprimir hojas de estilo, ¡pero ni siquiera sabíamos que la unidad `Q` existía hasta esta encuesta! ¿Sabías?

<p class="note">Una versión anterior de este capítulo discutia la inesperada popularidad de la unidad<code>Q</code>. Gracias a la discusión de la comunidad <a href="https://discuss.httparchive.org/t/chapter-2-css/1757/6"></a> alrededor de este capítulo, hemos identificado que esto fue un error en nuestro análisis y hemos actualizado la Figura 5 en consecuencia.</p>

### Unidades basadas en el viewport

Vimos mayores diferencias en los tipos de unidades cuando se trata del uso en dispositivos móviles y computadoras de escritorio para unidades basadas en el _viewport_. 36.8% de los sitios móviles usan `vh` (altura del viewport), mientras que solo el 31% de los sitios de escritorio lo hacen. También encontramos que `vh` es más común que `vw` (ancho del viewport) en aproximadamente un 11%. `vmin` (mínimo del viewport) es más popular que `vmax`(máximo del viewport), con alrededor del 8% de uso de `vmin` en dispositivos móviles, mientras que `vmax` solo lo usa el 1% de los sitios web.

### Propiedades personalizadas

Las propiedades personalizadas son lo que muchos llaman variables CSS. Sin embargo, son más dinámicas que una variable estática típica. Son muy poderosas y como comunidad todavía estamos descubriendo su potencial.

<figure>
  <div class="big-number">5%</div>
  <figcaption>Figura 6. Porcentaje de páginas que usan propiedades personalizadas.</figcaption>
</figure>

Sentimos que esta era una información emocionante, ya que muestra un crecimiento saludable de una de nuestras adiciones CSS favoritas. Estaban disponibles en todos los principales navegadores desde 2016 o 2017, por lo que es justo decir que son bastante nuevos. Muchas personas todavía están haciendo la transición de sus variables de preprocesador CSS a propiedades personalizadas CSS. Estimamos que pasarán algunos años más hasta que las propiedades personalizadas sean la norma.

## Selectores

### ID vs selectores de clases

CSS tiene algunas formas de encontrar elementos en la página para el estilo, así que pongamos los ID y las clases uno contra el otro para ver cuál es más frecuente. Los resultados no deberían ser demasiado sorprendentes: ¡las clases son más populares!

<figure>
  <a href="/static/images/2019/css/fig7.png">
    <img src="/static/images/2019/css/fig7.png" alt="Figura 7. Popularidad de los tipos de selector por página." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1216272563&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Gráfico de barras que muestra la adopción de ID y tipos de selector de clase. Las clases se usan en el 95% de las páginas de escritorio y móviles. Las ID se usan en el 89% de las páginas de escritorio y el 87% de las páginas móviles.</div>
  <figcaption id="fig7-caption">Figura 7. Popularidad de los tipos de selector por página.</figcaption>
</figure>

Un buen cuadro de seguimiento es este, que muestra que las clases ocupan el 93% de los selectores encontrados en una hoja de estilo.

<figure>
  <a href="/static/images/2019/css/fig8.png">
    <img src="/static/images/2019/css/fig8.png" alt="Figura 8. Popularidad de los tipos de selector por selector." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=351006989&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">Gráfico de barras que muestra que el 94% de los selectores incluyen el selector de clase para computadoras de escritorio y dispositivos móviles, mientras que el 7% de los selectores de escritorio incluyen el selector de ID (8% para dispositivos móviles).</div>
  <figcaption id="fig8-caption">Figura 8. Popularidad de los tipos de selector por selector.</figcaption>
</figure>

### Selectores de atributos

CSS tiene algunos selectores de comparación muy potentes. Estos son selectores como `[target="_blank"]`, `[attribute^="value"]`, `[title~="rad"]`, `[attribute$="-rad"]` o `[attribute*="value"]`. ¿Los usas? ¿Crees que se usan mucho? Comparemos cómo se usan con IDs y clases en la web.

<figure>
  <a href="/static/images/2019/css/fig9.png">
    <img src="/static/images/2019/css/fig9.png" alt="Figura 9. Popularidad de operadores por selector de atributo ID." aria-labelledby="fig9-caption" aria-describedby="fig9-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=695879874&amp;format=interactive">
  </a>
  <div id="fig9-description" class="visually-hidden">Gráfico de barras que muestra la popularidad de los operadores utilizados por los selectores de atributos de ID. Alrededor del 4% de las páginas de escritorio y móviles usan asterisco igual y signo de intercalación igual. El 1% de las páginas usan igual y dólar igual. 0% usa virgulilla igual.</div>
  <figcaption id="fig9-caption">Figura 9. Popularidad de operadores por selector de atributo ID.</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/css/fig10.png">
    <img src="/static/images/2019/css/fig10.png" alt="Figura 10. Popularidad de operadores por selector de atributo de clase." aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=377805296&amp;format=interactive">
  </a>
  <div id="fig10-description" class="visually-hidden">Gráfico de barras que muestra la popularidad de los operadores utilizados por los selectores de atributos de clase. El 57% de las páginas usan asterisco igual. El 36% usa signo de interalación igual. El 1% usa igual y dólar igual. 0% usa virgulilla igual.</div>
  <figcaption id="fig10-caption">Figura 10. Popularidad de operadores por selector de atributo de clase.</figcaption>
</figure>

Estos operadores son mucho más populares con los selectores de clase que con los ID, lo cual se siente natural ya que una hoja de estilo generalmente tiene menos selectores de ID que los selectores de clase, pero aún así es interesante ver los usos de todas estas combinaciones.

### Clases por elementos

Con el surgimiento de las estrategias OOCSS, atómicas y funcionales de CSS que pueden combinar 10 o más clases en un elemento para lograr una apariencia de diseño, quizás veamos algunos resultados interesantes. La consulta resultó bastante aburrida, con una mediana en dispositivos móviles y computadoras de escritorio de 1 clase por elemento.

<figure>
  <div class="big-number">1</div>
  <figcaption>Figura 11. La mediana del número de nombres de clase por atributo de clase (escritorio y dispositivo móvil).</figcaption>
</figure>

## Diseño

### Flexbox

[Flexbox](https://developer.mozilla.org/es/docs/Web/CSS/CSS_Flexible_Box_Layout/Conceptos_Basicos_de_Flexbox) es un estilo contenedor que dirige y alinea a sus hijos; es decir, ayuda con el diseño de una manera basada en restricciones. Tuvo un comienzo bastante difícil en la web, ya que su especificación experimentó dos o tres cambios bastante drásticos entre 2010 y 2013. Afortunadamente, se resolvió y se implementó en todos los navegadores en 2014. Dado ese historial, tuvo una tasa de adopción lenta, ¡pero han pasado algunos años desde entonces! Es bastante popular ahora, tiene muchos artículos sobre su uso y cómo sacarle provecho, pero aún es nuevo en comparación con otras tácticas de diseño.

<figure>
  <a href="/static/images/2019/css/fig12.png">
    <img src="/static/images/2019/css/fig12.png" alt="Figura 12. Adopción de flexbox." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2021161093&amp;format=interactive">
  </a>
  <div id="fig12-description" class="visually-hidden">Gráfico de barras que muestra el 49% de las páginas de escritorio y el 52% de las páginas móviles usan flexbox.</div>
  <figcaption id="fig12-caption">Figura 12. Adopción de flexbox.</figcaption>
</figure>

Toda una historia de éxito se muestra aquí, ya que casi el 50% de la web usa flexbox en sus hojas de estilo.

### Grid

Similar a flexbox, [grid](https://developer.mozilla.org/es/docs/Web/CSS/CSS_Grid_Layout) también pasó por algunas alteraciones de especificaciones al principio de su vida útil, pero sin cambiar las implementaciones en los navegadores lanzados al público. Microsoft tenía grid en las primeras versiones de Windows 8, como el motor de diseño primario para su estilo de diseño de desplazamiento horizontal. Primero se investigó allí, se hizo la transición a la web y luego los otros navegadores lo maduraron hasta su lanzamiento final en 2017. Tuvo un lanzamiento muy exitoso en el sentido de que casi todos los navegadores lanzaron sus implementaciones al mismo tiempo, por lo que los desarrolladores web simplemente se despertaron un día con un excelente soporte de grid. Hoy, a fines de 2019, grid todavía se siente como un niño nuevo en el bloque, ya que la gente todavía está despertando a su poder y capacidades.

<figure>
  <div class="big-number">2%</div>
  <figcaption>Figura 13. Porcentaje de sitios web que usan grid.</figcaption>
</figure>

Esto muestra lo poco que la comunidad de desarrollo web ha utilizado y explorado su última herramienta de diseño. Esperamos que grid eventualmente tome control y se convierta en el motor de diseño primario para la construcción de sitios web. Para nosotros, los autores, nos encanta escribir grid: normalmente lo buscamos primero, luego reducimos nuestra complejidad a medida que nos damos cuenta e iteramos en el diseño. Queda por ver qué hará el resto del mundo con esta potente función CSS en los próximos años.

### Modos de escritura

La web y CSS son características de la plataforma internacional, y los modos de escritura ofrecen una forma para que HTML y CSS indiquen la dirección de lectura y escritura preferida por el usuario dentro de nuestros elementos.

<figure>
  <a href="/static/images/2019/css/fig14.png">
    <img src="/static/images/2019/css/fig14.png" alt="Figura 14. Popularidad de los valores de dirección." aria-labelledby="fig14-caption" aria-describedby="fig14-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=136847988&amp;format=interactive">
  </a>
  <div id="fig14-description" class="visually-hidden">Gráfico de barras que muestra la popularidad de los valores de dirección ltr y rtl. ltr es utilizado por el 32% de las páginas de escritorio y el 40% de las páginas móviles. rtl es utilizado por el 32% de las páginas de escritorio y el 36% de las páginas móviles.</div>
  <figcaption id="fig14-caption">Figura 14. Popularidad de los valores de dirección.</figcaption>
</figure>

## Tipografía

### Fuentes web por página

¿Cuántas fuentes web está cargando en su página web? ¿0? ¿10? ¡La mediana de fuentes web por página es 3!

<figure>
  <a href="/static/images/2019/css/fig15.png">
    <img src="/static/images/2019/css/fig15.png" alt="Figura 15. Distribución de la cantidad de fuentes web cargadas por página." aria-labelledby="fig15-caption" aria-describedby="fig15-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1453570774&amp;format=interactive">
  </a>
  <div id="fig15-description" class="visually-hidden">Distribución de la cantidad de fuentes web cargadas por página. En computadoras de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 0, 1, 3, 6 y 9. Esto es ligeramente más alto que la distribución para dispositivos móviles, que es una fuente menos en los percentiles 75 y 90.</div>
  <figcaption id="fig15-caption">Figura 15. Distribución de la cantidad de fuentes web cargadas por página.</figcaption>
</figure>

### Familias de fuentes populares

Una pregunta de seguimineto a la consulta del número total de fuentes por página es: ¿qué fuentes son? Diseñadores, sintonicen, porque ahora podrán ver si sus elecciones están en línea con lo que es popular o no.

<figure>
  <a href="/static/images/2019/css/fig16.png">
    <img src="/static/images/2019/css/fig16.png" alt="Figura 16. Principales fuentes web." aria-labelledby="fig16-caption" aria-describedby="fig16-description" width="600" height="450" data-width="600" data-height="450" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1883567922&amp;format=interactive">
  </a>
  <div id="fig16-description" class="visually-hidden">Gráfico de barras de las fuentes más populares. Entre las páginas de escritorio, están Open Sans (24%), Roboto (15%), Montserrat (5%), Source Sans Pro (4%), Noto Sans JP (3%) y Lato (3%). En los dispositivos móviles, las diferencias más notables son que Open Sans se usa el 22% del tiempo (en lugar del 24%) y Roboto se usa el 19% del tiempo (en lugar del 15%).</div>
  <figcaption id="fig16-caption">Figura 16. Principales fuentes web.</figcaption>
</figure>

Open Sans es un gran ganador aquí, con casi 1 de cada 4 declaraciones CSS `@ font-family` que lo especifican. Definitivamente hemos usado Open Sans en proyectos en las agencias.

También es interesante notar las diferencias entre la adopción de escritorio y móvil. Por ejemplo, las páginas móviles usan Open Sans con menos frecuencia que las de escritorio. Mientras tanto, también usan Roboto un poco más a menudo.

### Tamaños de fuente

Esta es divertida, porque si le pregunta a un usuario cuántos tamaños de fuente siente que hay en una página, generalmente devolvería un número de 5 o definitivamente menos de 10. ¿Es esa la realidad? Incluso en un sistema de diseño, ¿cuántos tamaños de fuente hay? Consultamos la web y descubrimos que la mediana era 40 en el móvil y 38 en el escritorio. Puede ser el momento de pensar realmente en las propiedades personalizadas o de crear algunas clases reutilizables para ayudarlo a distribuir su rampa de tipos.

<figure>
  <a href="/static/images/2019/css/fig17.png">
    <img src="/static/images/2019/css/fig17.png" alt="Figura 17. Distribución del número de tamaños de fuente distintos por página." aria-labelledby="fig17-caption" aria-describedby="fig17-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1695270216&amp;format=interactive">
  </a>
  <div id="fig17-description" class="visually-hidden">Gráfico de barras que muestra la distribución de distintos tamaños de fuente por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 8, 20, 40, 66 y 92 tamaños de fuente. La distribución de escritorio difiere de la móvil en el percentil 75, donde es más grande en 7 tamaños distintos y para el percentil 90 en 13 tamaños.</div>
  <figcaption id="fig17-caption">Figura 17. Distribución del número de tamaños de fuente distintos por página.</figcaption>
</figure>

## Espaciado

### Márgenes

Un margen es el espacio fuera de los elementos, como el espacio que exige cuando empuja los brazos hacia afuera. Esto a menudo parece el espacio entre elementos, pero no se limita a ese efecto. En un sitio web o aplicación, el espaciado juega un papel muy importante en UX y diseño. Veamos cuánto código de espaciado de margen va en una hoja de estilo, ¿de acuerdo?

<figure>
  <a href="/static/images/2019/css/fig18.png">
    <img src="/static/images/2019/css/fig18.png" alt="Figura 18. Distribución del número de valores de margen distintos por página." aria-labelledby="fig18-caption" aria-describedby="fig18-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=4233531&amp;format=interactive">
  </a>
  <div id="fig18-description" class="visually-hidden">Gráfico de barras que muestra la distribución de valores de margen distintos por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 12, 47, 96, 167 y 248 valores de margen distintos. La distribución de escritorio difiere de la móvil en el percentil 75, donde es más pequeña en 12 a 31 valores distintos.</div>
  <figcaption id="fig18-caption">Figura 18. Distribución del número de valores de margen distintos por página.</figcaption>
</figure>

¡Bastante, al parecer! La página de escritorio promedio tiene 96 valores de margen distintos y 104 en dispositivos móviles. Eso crea muchos momentos de espaciado únicos en su diseño. ¿Curioso de cuántos márgenes tienes en tu sitio? ¿Cómo podemos hacer que todo este espacio en blanco sea más manejable?

### Propiedades lógicas

<figure>
  <div class="big-number">0.6%</div>
  <figcaption>Figura 19. Porcentaje de páginas de escritorio y móviles que incluyen propiedades lógicas.</figcaption>
</figure>

Estimamos que la hegemonía de `margin-left` y `padding-top` es de duración limitada, que pronto se complementará por su dirección de escritura agnóstica, sucesiva, sintaxis de propiedad lógica. Si bien somos optimistas, el uso actual es bastante bajo, con un 0,67% de uso en las páginas de escritorio. Para nosotros, esto se siente como un cambio de hábito que necesitaremos desarrollar como industria, mientras esperamos capacitar a nuevos desarrolladores para usar la nueva sintaxis.

### z-index

Las capas verticales, o apilamiento, se pueden administrar con `z-index` en CSS. Teníamos curiosidad sobre cuántos valores diferentes usan las personas en sus sitios. El rango de lo que acepta el `z-index` es teóricamente infinito, limitado solo por las límites de tamaño variable de un navegador. ¿Se utilizan todas esas posiciones de pila? ¡Veamos!

<figure>
  <a href="/static/images/2019/css/fig20.png">
    <img src="/static/images/2019/css/fig20.png" alt="Figura 20. Distribución del número de valores distintos de 'z-index' por página." aria-labelledby="fig20-caption" aria-describedby="fig20-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1320871189&amp;format=interactive">
  </a>
  <div id="fig20-description" class="visually-hidden">Gráfico de barras que muestra la distribución de distintos valores de z-index por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 1, 7, 16, 26 y 36 valores distintos de z-index. La distribución de escritorio es mucho más alta que la móvil, en hasta 16 valores distintos en el percentil 90.</div>
  <figcaption id="fig20-caption">Figura 20. Distribución del número de valores distintos de <code>z-index</code> por página.</figcaption>
</figure>

### Valores populares de z-index

Según nuestra experiencia laboral, cualquier número con 9s parecía ser la opción más popular. Aunque nos enseñamos a nosotros mismos a usar el menor número posible, esa no es la norma comunitaria. ¿Cuál es entonces? Si la gente necesita cosas al frente, ¿cuáles son los números más populares de `z-index` que se usan? Deja a un lado tu bebida; este es lo suficientemente divertido como para perdérselo.

<figure>
  <a href="/static/images/2019/css/fig21.png">
    <img src="/static/images/2019/css/fig21.png" alt="Figura 21. Los valores de 'z-index' más utilizados." aria-labelledby="fig21-caption" aria-describedby="fig21-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1169148473&amp;format=interactive">
  </a>
  <div id="fig21-description" class="visually-hidden">Diagrama de dispersión de todos los valores de z-index conocidos y la cantidad de veces que se usan, tanto para escritorio como para dispositivos móviles. 1 y 2 son los más utilizados, pero el resto de los valores populares explotan en órdenes de magnitud: 10, 100, 1,000, y así sucesivamente hasta números con cientos de dígitos.</div>
  <figcaption id="fig21-caption">Figura 21. Los valores de <code>z-index</code> más utilizados.</figcaption>
</figure>

<figure>
  <div class="big-number" style="word-break: break-all; font-size: 24px">999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 !important</div>
  <figcaption>Figura 22. El valor de <code>z-index</code> más grande conocido.</figcaption>
</figure>

## Decoración

### Filtros

Los filtros son una forma divertida y excelente de modificar los píxeles que el navegador intenta dibujar en la pantalla. Es un efecto de procesamiento posterior que se realiza contra una versión plana del elemento, nodo o capa a la que se aplica. Photoshop los hizo fáciles de usar, luego Instagram los hizo accesibles a las masas a través de combinaciones personalizadas y estilizadas. Han existido desde aproximadamente 2012, hay 10 de ellos, y se pueden combinar para crear efectos únicos.

<figure>
  <div class="big-number">78%</div>
  <figcaption>Figura 23. Porcentaje de páginas que incluyen una hoja de estilo con la propiedad <code>filter</code>.</figcaption>
</figure>

¡Nos entusiasmó ver que el 78% de las hojas de estilo contienen la propiedad `filter`! Ese número también era tan alto que parecía un poco sospechoso, así que buscamos y explicamos el número alto. Porque seamos honestos, los filtros son limpios, pero no se incluyen en todas nuestras aplicaciones y proyectos. ¡A no ser que!

Tras una investigación más profunda, descubrimos que las hojas de estilo de [FontAwesome](https://fontawesome.com) viene con cierto uso de `filter`, de igual manera el contenido empotrado de [YouTube](https://youtube.com). Por lo tanto, nosotros creemos  `filter` se coló en la puerta de atrás al ser utilizada en un par de hojas de estilo muy populares. También creemos que la presencia de  `-ms-filter` podría haberse incluido también, contribuyendo al alto porcentaje de uso.

### Modos de mezcla

Los modos de mezcla son similares a los filtros en que son un efecto de posprocesamiento que se ejecuta contra una versión plana de sus elementos de destino, pero son únicos en el sentido de que están relacionados con la convergencia de píxeles. Dicho de otra manera, los modos de mezcla son cómo los 2 píxeles _deberían_ impactar entre sí cuando se superponen. Cualquier elemento que se encuentre en la parte superior o inferior afectará la forma en que el modo de mezcla manipula los píxeles. Hay 16 modos de mezcla, veamos cuáles son los más populares.

<figure>
  <div class="big-number">8%</div>
  <figcaption>Figura 24. Porcentaje de páginas que incluyen una hoja de estilo con la propiedad <code>*-blend-mode</code>.</figcaption>
</figure>

En general, el uso de los modos de mezcla es mucho menor que el de los filtros, pero aún es suficiente para ser considerado moderadamente utilizado.

En una futura edición de Web Almanac, sería genial profundizar en el uso del modo de mezcla para tener una idea de los modos exactos que usan los desarrolladores, como multiplicar, pantalla, quemar colores, aclarar, etc.

## Animación

### Transiciones

CSS tiene este increíble poder de interpolación que se puede usar simplemente escribiendo una sola regla sobre cómo hacer la transición de esos valores. Si está utilizando CSS para administrar estados en su aplicación, ¿con qué frecuencia emplea transiciones para realizar la tarea? ¡Vamos a consultar la web!

<figure>
  <a href="/static/images/2019/css/fig25.png">
    <img src="/static/images/2019/css/fig25.png" alt="Figura 25. Distribución del número de transiciones por página." aria-labelledby="fig25-caption" aria-describedby="fig25-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=419145172&amp;format=interactive">
  </a>
  <div id="fig25-description" class="visually-hidden">Gráfico de barras que muestra la distribución de las transiciones por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 0, 2, 16, 49 y 118 transiciones. La distribución del escritorio es mucho más baja que la del móvil, hasta 77 transiciones en el percentil 90.</div>
  <figcaption id="fig25-caption">Figura 25. Distribución del número de transiciones por página.</figcaption>
</figure>

¡Eso es bastante bueno! Nosotros vimos `animate.css` como una biblioteca popular para incluir, que trae un montón de animaciones de transición, pero aún así es agradable ver que la gente está considerando la transición de sus interfaces de usuario.

### Animaciones Keyframe

Las animaciones de keyframe CSS son una excelente solución para sus animaciones o transiciones más complejas. Le permiten ser más explícito, lo que proporciona un mayor control sobre los efectos. Pueden ser pequeños, como un efecto de _keyframe_, o grandes con muchos efectos de _keyframe_ compuestos en una animación robusta. El número medio de animaciones de _keyframes_ por página es mucho menor que las transiciones CSS.

<figure>
  <a href="/static/images/2019/css/fig26.png">
    <img src="/static/images/2019/css/fig26.png" alt="Figura 26. Distribución del número de keyframe por página." aria-labelledby="fig26-caption" aria-describedby="fig26-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=11848448&amp;format=interactive">
  </a>
  <div id="fig26-description" class="visually-hidden">Gráfico de barras que muestra la distribución de keyframes por página. Para las páginas móviles, los percentiles 10, 25, 50, 75 y 90 son: 0, 0, 3, 18 y 76 fotogramas clave. La distribución móvil es ligeramente superior a la de escritorio en 6 fotogramas clave en los percentiles 75 y 90.</div>
  <figcaption id="fig26-caption">Figura 26. Distribución del número de keyframe por página.</figcaption>
</figure>

## Media queries

Las _media queries_ permiten que CSS se enganche en varias variables de nivel de sistema para adaptarse adecuadamente al usuario visitante. Algunas de estas consultas podrían manejar estilos de impresión, estilos de pantalla de proyector y tamaño de ventana / vista. Durante mucho tiempo, las consultas de los medios se aprovecharon principalmente para su conocimiento de la vista. Los diseñadores y desarrolladores podrían adaptar sus diseños para pantallas pequeñas, pantallas grandes, etc. Más tarde, la web comenzó a brindar más y más capacidades y consultas, lo que significa que las _media queries_ ahora pueden administrar las funciones de accesibilidad además de las funciones de la ventana gráfica.

Un buen lugar para comenzar con las _media queries_, ¿es aproximadamente cuántas se usan por página? ¿A cuántos momentos o contextos diferentes siente la página típica que quiere responder?

<figure>
  <a href="/static/images/2019/css/fig27.png">
    <img src="/static/images/2019/css/fig27.png" alt="Figura 27. Distribución del número de media queries por página." aria-labelledby="fig27-caption" aria-describedby="fig27-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1892465673&amp;format=interactive">
  </a>
  <div id="fig27-description" class="visually-hidden">Gráfico de barras que muestra la distribución de consultas de medios por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 0, 3, 14, 27 y 43 media queries. La distribución de escritorio es similar a la distribución móvil.</div>
  <figcaption id="fig27-caption">Figura 27. Distribución del número de consultas de media queries por página.</figcaption>
</figure>

### Tamaños de punto de quiebre populares de media queries

Para media queries de ventana gráfica, cualquier tipo de unidad CSS se puede pasar a la expresión de consulta para su evaluación. En días anteriores, la gente pasaba `em` y `px` a la consulta, pero con el tiempo se agregaban más unidades, lo que nos da mucha curiosidad sobre qué tipos de tamaños se encuentran comúnmente en la web. Suponemos que la mayoría de las consultas de medios seguirán los tamaños de dispositivos populares, pero en lugar de suponer, ¡echemos un vistazo a los datos!

<figure>
  <a href="/static/images/2019/css/fig28.png">
    <img src="/static/images/2019/css/fig28.png" alt="Figura 28. Puntos de ajuste más utilizados en media queries." aria-labelledby="fig28-caption" aria-describedby="fig28-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1353707515&amp;format=interactive">
  </a>
  <div id="fig28-description" class="visually-hidden">Gráfico de barras de los puntos de referencia de media queries más populares. 768px y 767px son los más populares con 23% y 16%, respectivamente. La lista cae rápidamente después de eso, con 992px usado el 6% del tiempo y 1200px usado el 4% del tiempo. Las computadoras de escritorio y los dispositivos móviles tienen un uso similar.</div>
  <figcaption id="fig28-caption">Figura 28. Puntos de ajuste más utilizados en media queries.</figcaption>
</figure>

La Figura 28 anterior muestra que parte de nuestras suposiciones eran correctas: ciertamente hay una gran cantidad de tamaños específicos de teléfonos allí, pero también hay algunos que no lo son. Es interesante también cómo es muy dominante en píxeles, con unas pocas entradas que utilizan `em` más allá del alcance de este gráfico.

### Uso vertical versus horizontal

El valor de _media query_ más popular de los tamaños de punto de interrupción populares parece ser `768px`, lo que nos hizo sentir curiosidad. ¿Se usó este valor principalmente para cambiar a un diseño vertical, ya que podría basarse en la suposición de que `768px` representa la típica ventana vertical de un móvil? Así que realizamos una consulta de seguimiento para ver la popularidad del uso de los modos vertical y horizontal:

<figure>
  <a href="/static/images/2019/css/fig29.png">
    <img src="/static/images/2019/css/fig29.png" alt="Figura 29. Adopción de modos de orientación en media queries." aria-labelledby="fig29-caption" aria-describedby="fig29-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=295845630&amp;format=interactive">
  </a>
  <div id="fig29-description" class="visually-hidden">Gráfico de barras que muestra la adopción de modos de orientación vertical y horizontal en media queries. El 31% de las páginas especifican horizontal, el 8% especifica vertical y el 7% especifica ambas. La adopción es la misma para páginas de escritorio y móviles.</div>
  <figcaption id="fig29-caption">Figura 29. Adopción de modos de orientación en media queries.</figcaption>
</figure>

Curiosamente, `vertical` no se usa mucho, mientras que `horizontal` se usa mucho más. Solo podemos suponer que `768px` ha sido lo suficientemente confiable como el caso de diseño vertical se ha alcanzado por mucho menos. También suponemos que las personas en una computadora de escritorio, que prueban su trabajo, no pueden activar el modo vertical para ver su diseño móvil tan fácilmente como pueden simplemente aplastar el navegador. Difícil de decir, pero los datos son fascinantes.

### Tipos de unidades más populares

En las media queries de ancho y alto que hemos visto hasta ahora, los píxeles se ven como la unidad de elección dominante para los desarrolladores que buscan adaptar su interfaz de usuario a las ventanas gráficas. Sin embargo, queríamos consultar esto exclusivamente, y realmente echar un vistazo a los tipos de unidades que usan las personas. Esto es lo que encontramos.

<figure>
  <a href="/static/images/2019/css/fig30.png">
    <img src="/static/images/2019/css/fig30.png" alt="Figura 30. Adopción de unidades en puntos de referencia de media queries." aria-labelledby="fig30-caption" aria-describedby="fig30-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=305563768&amp;format=interactive">
  </a>
  <div id="fig30-description" class="visually-hidden">Gráfico de barras que muestra el 75% de los puntos de referencia de las media queries especifican píxeles, el 8% que especifica ems y el 1% que especifica rems.</div>
  <figcaption id="fig30-caption">Figura 30. Adopción de unidades en puntos de referencia de media queries.</figcaption>
</figure>

### `min-width` vs `max-width`

Cuando las personas escriben una _media query_, ¿están generalmente buscando una ventana gráfica que esté por encima o por debajo de un rango específico, _o_ ambos, verificando si está entre un rango de tamaños? ¡Preguntémosle a la web!

<figure>
  <a href="/static/images/2019/css/fig31.png">
    <img src="/static/images/2019/css/fig31.png" alt="Figura 31. Adopción de propiedades utilizadas en puntos de referencia de media queries." aria-labelledby="fig31-caption" aria-describedby="fig31-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2091525146&amp;format=interactive">
  </a>
  <div id="fig31-description" class="visually-hidden">Gráfico de barras que muestra el 74% de las páginas de escritorio usan max-width, el 70% con min-width y el 68% con ambas propiedades. La adopción es similar para páginas móviles.</div>
  <figcaption id="fig31-caption">Figura 31. Adopción de propiedades utilizadas en puntos de referencia de media queries.</figcaption>
</figure>

No hay ganadores claros aquí; `max-width` y `min-width` se usan casi por igual.

### Impresión y discurso

Los sitios web se sienten como papel digital, ¿verdad? Como usuarios, generalmente se sabe que puede presionar imprimir desde su navegador y convertir ese contenido digital en contenido físico. No se requiere que un sitio web cambie para ese caso de uso, ¡pero puede hacerlo si lo desea! Menos conocida es la capacidad de ajustar su sitio web en el caso de que lo lea una herramienta o un robot. Entonces, ¿con qué frecuencia se aprovechan estas características?

<figure>
  <a href="/static/images/2019/css/fig32.png">
    <img src="/static/images/2019/css/fig32.png" alt="Figura 32. Adopción de las media queries para todos, impresión, pantalla y voz." aria-labelledby="fig32-caption" aria-describedby="fig32-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=939890574&amp;format=interactive">
  </a>
  <div id="fig32-description" class="visually-hidden">Gráfico de barras que muestra el 35% de las páginas de escritorio con el tipo de media query "todos", el 46% con impresión, el 72% con pantalla y el 0% con voz. La adopción es inferior en aproximadamente 5 puntos porcentuales para el escritorio en comparación con el móvil.</div>
  <figcaption id="fig32-caption">Figura 32. Adopción de las media queries para todos, impresión, pantalla y voz.</figcaption>
</figure>

## Estadísticas a nivel de página

### Hojas de estilo

¿A cuántas hojas de estilo hace referencia desde su página de inicio? ¿Cuántos de tus aplicaciones? ¿Sirven más o menos para dispositivos móviles frente a computadoras de escritorio? ¡Aquí hay una tabla de todos los demás!

<figure>
  <a href="/static/images/2019/css/fig33.png">
    <img src="/static/images/2019/css/fig33.png" alt="Figura 33. Distribución del número de hojas de estilo cargadas por página." aria-labelledby="fig33-caption" aria-describedby="fig33-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1377313548&amp;format=interactive">
  </a>
  <div id="fig33-description" class="visually-hidden">Distribución de la cantidad de hojas de estilo cargadas por página. Las computadoras de escritorio y los dispositivos móviles tienen distribuciones idénticas con percentiles 10, 25, 50, 75 y 90: 1, 3, 6, 12 y 20 hojas de estilo por página.</div>
  <figcaption id="fig33-caption">Figura 33. Distribución del número de hojas de estilo cargadas por página.</figcaption>
</figure>

### Nombres de hojas de estilo

¿Cómo nombras tus hojas de estilo? ¿Has sido constante a lo largo de tu carrera? ¿Has convergido lentamente o divergido constantemente? Este gráfico muestra una pequeña visión de la popularidad de la biblioteca, pero también una gran visión de los nombres populares de los archivos CSS.

<figure>
  <table>
    <thead>
      <tr>
        <th>Nombre de hoja de estilo</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>style.css</td>
        <td class="numeric">2.43%</td>
        <td class="numeric">2.55%</td>
      </tr>
      <tr>
        <td>font-awesome.min.css</td>
        <td class="numeric">1.86%</td>
        <td class="numeric">1.92%</td>
      </tr>
      <tr>
        <td>bootstrap.min.css</td>
        <td class="numeric">1.09%</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td>BfWyFJ2Rl5s.css</td>
        <td class="numeric">0.67%</td>
        <td class="numeric">0.66%</td>
      </tr>
      <tr>
        <td>style.min.css?ver=5.2.2</td>
        <td class="numeric">0.64%</td>
        <td class="numeric">0.67%</td>
      </tr>
      <tr>
        <td>styles.css</td>
        <td class="numeric">0.54%</td>
        <td class="numeric">0.55%</td>
      </tr>
      <tr>
        <td>style.css?ver=5.2.2</td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.43%</td>
      </tr>
      <tr>
        <td>main.css</td>
        <td class="numeric">0.43%</td>
        <td class="numeric">0.39%</td>
      </tr>
      <tr>
        <td>bootstrap.css</td>
        <td class="numeric">0.40%</td>
        <td class="numeric">0.42%</td>
      </tr>
      <tr>
        <td>font-awesome.css</td>
        <td class="numeric">0.37%</td>
        <td class="numeric">0.38%</td>
      </tr>
      <tr>
        <td>style.min.css</td>
        <td class="numeric">0.37%</td>
        <td class="numeric">0.37%</td>
      </tr>
      <tr>
        <td>styles__ltr.css</td>
        <td class="numeric">0.38%</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td>default.css</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td>reset.css</td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.37%</td>
      </tr>
      <tr>
        <td>styles.css?ver=5.1.3</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td>custom.css</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.33%</td>
      </tr>
      <tr>
        <td>print.css</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.28%</td>
      </tr>
      <tr>
        <td>responsive.css</td>
        <td class="numeric">0.28%</td>
        <td class="numeric">0.31%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figura 34. Nombres de hojas de estilo más utilizados.</figcaption>
</figure>

¡Mira todos esos nombres de archivos creativos! style, styles, main, default, all. Sin embargo, uno se destacó, ¿lo ves? `BfWyFJ2Rl5s.css` toma el lugar número cuatro para el más popular. Lo investigamos un poco y nuestra mejor suposición es que está relacionado con los botones "me gusta" de Facebook. ¿Sabes cuál es ese archivo? Deja un comentario, porque nos encantaría escuchar la historia.

### Tamaño de la hoja de estilo

¿Qué tan grandes son estas hojas de estilo? ¿Es nuestro tamaño CSS algo de qué preocuparse? A juzgar por estos datos, nuestro CSS no es uno de los principales culpables de la hinchazón de las páginas.

<figure>
  <a href="/static/images/2019/css/fig35.png">
    <img src="/static/images/2019/css/fig35.png" alt="Figura 35. Distribución del número de bytes de hoja de estilo (KB) cargados por página." aria-labelledby="fig35-caption" aria-describedby="fig35-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2132635319&amp;format=interactive">
  </a>
  <div id="fig35-description" class="visually-hidden">Distribución del número de bytes de hoja de estilo cargados por página. Los percentiles 10, 25, 50, 75 y 90 de la página de escritorio son: 8, 26, 62, 129 y 240 KB. La distribución de escritorio es ligeramente superior a la distribución móvil en 5 a 10 KB.</div>
  <figcaption id="fig35-caption">Figura 35. Distribución del número de bytes de hoja de estilo (KB) cargados por página.</figcaption>
</figure>

Consulte el capítulo [Page Weight](./page-weight)) para obtener una visión más detallada de la cantidad de bytes que los sitios web están cargando para cada tipo de contenido.

### Libraries

Es común, popular, conveniente y poderoso llegar a una biblioteca CSS para iniciar un nuevo proyecto. Si bien es posible que usted no sea delos que consumen bibliotecas, hemos consultado la web en 2019 para ver cuáles lideran el paquete. Si los resultados lo sorprenden, como lo hicieron con nosotros, creo que es una pista interesante de cuán pequeña es la burbuja de desarrollador en la que podemos vivir. Las cosas pueden sentirse enormemente populares, pero cuando la web pregunta, la realidad es un poco diferente.

<figure>
  <table>
    <thead>
      <tr>
        <th>Biblioteca</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">27.8%</td>
        <td class="numeric">26.9%</td>
      </tr>
      <tr>
        <td>animate.css</td>
        <td class="numeric">6.1%</td>
        <td class="numeric">6.4%</td>
      </tr>
      <tr>
        <td>ZURB Foundation</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td>UIKit</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Material Design Lite</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Materialize CSS</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Pure CSS</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Angular Material</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Semantic-ui</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Bulma</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Ant Design</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>tailwindcss</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Milligram</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Clarity</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figura 36. Porcentaje de páginas que incluyen una biblioteca CSS determinada.</figcaption>
</figure>

Este cuadro sugiere que [Bootstrap](https://getbootstrap.com/) es una biblioteca valiosa que debe saber para ayudar a conseguir un trabajo. ¡Mira toda la oportunidad que hay para ayudar! También vale la pena señalar que este es solo un gráfico de señales positivas: las matemáticas no suman 100% porque no todos los sitios están usando un framework CSS. Un poco más de la mitad de todos los sitios _no utilizan_ un framework CSS conocido. Muy interesante, ¿no?

### Utilidades de restablecimiento

Las utilidades de restablecimiento de CSS tienen la intención de normalizar o crear una línea base para elementos web nativos. En caso de que no lo supiera, cada navegador sirve su propia hoja de estilo para todos los elementos HTML, y cada navegador toma sus propias decisiones únicas sobre cómo se ven o se comportan esos elementos. Las utilidades de restablecimiento han analizado estos archivos, han encontrado sus puntos en común (o no) y han solucionado cualquier diferencia para que usted, como desarrollador, pueda diseñar en un navegador y tener una confianza razonable de que se verá igual en otro.

¡Así que echemos un vistazo a cuántos sitios están usando uno! Su existencia parece bastante razonable, entonces, ¿cuántas personas están de acuerdo con sus tácticas y las usan en sus sitios?

<figure>
  <a href="/static/images/2019/css/fig37.png">
    <img src="/static/images/2019/css/fig37.png" alt="Figura 37. Adopción de utilidades de restablecimiento CSS." aria-labelledby="fig37-caption" aria-describedby="fig37-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1318910215&amp;format=interactive">
  </a>
  <div id="fig37-description" class="visually-hidden">Gráfico de barras que muestra la adopción de tres utilidades de restablecimiento de CSS: Normalize.css (33%), Reset CSS (3%) y Pure CSS (0%). No hay diferencia en la adopción en páginas de escritorio y móviles.</div>
  <figcaption id="fig37-caption">Figura 37. Adopción de utilidades de restablecimiento CSS.</figcaption>
</figure>

Resulta que aproximadamente un tercio de la web está usando [`normalize.css`](https://necolas.github.io/normalize.css), que podría considerarse un enfoque más suave para la tarea que un reinicio. Miramos un poco más profundo, y resulta que Bootstrap incluye `normalize.css`, lo que probablemente representa una gran cantidad de su uso. Vale la pena señalar también que `normalize.css` tiene más adopción que Bootstrap, por lo que hay muchas personas que lo usan solo.

### `@supports` y `@import`

CSS `@supports` es una forma para que el navegador verifique si una combinación particular de propiedad-valor se analiza como válida y luego aplica estilos si la verificación regresa como verdadera.

<figure>
  <a href="/static/images/2019/css/fig38.png">
    <img src="/static/images/2019/css/fig38.png" alt="Figura 38. Popularidad de las reglas CSS 'arroba'" aria-labelledby="fig38-caption" aria-describedby="fig38-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1739611283&amp;format=interactive">
  </a>
  <div id="fig38-description" class="visually-hidden">Gráfico de barras que muestra la popularidad de las reglas @import y @supports "arroba". En el escritorio, @import se usa en el 28% de las páginas y @supports se usa en el 31%. Para dispositivos móviles, @import se usa en el 26% de las páginas y @supports se usa en el 29%.</div>
  <figcaption id="fig38-caption">Figura 38. Popularidad de las reglas CSS 'arroba'.</figcaption>
</figure>

Considerando que `@supports` se implementó en la mayoría de los navegadores en 2013, no es demasiado sorprendente ver una gran cantidad de uso y adopción. Estamos impresionados por la atención plena de los desarrolladores aquí. ¡Esto es una codificación considerada! El 30% de todos los sitios web están buscando algún soporte relacionado con la visualización antes de usarlo.

Un seguimiento interesante de esto es que hay más uso de `@supports` que de `@imports` ¡No esperábamos eso! `@import` ha estado en los navegadores desde 1994.

## Conclusión

¡Hay mucho más aquí para investigar! Muchos de los resultados nos sorprendieron, y solo podemos esperar que ellos también lo hayan sorprendido a usted. Este sorprendente conjunto de datos hizo que el resumen fuera muy divertido, y nos dejó con muchos rastros y pistas para investigar si queremos descubrir las razones _por qué_ algunos de los resultados son como son.

¿Qué resultados le parecieron más alarmantes?
¿Qué resultados te llevan a tu base de código para una consulta rápida?

Consideramos que la conclusión más importante de estos resultados es que las propiedades personalizadas ofrecen el máximo rendimiento en términos de rendimiento, _DRYness_ y escalabilidad de sus hojas de estilo. Esperamos analizar las hojas de estilo de Internet nuevamente, en busca de nuevos datos y tentativas cartas. Comuníquese con [@una](https://twitter.com/una) o [@argyleink](https://twitter.com/argyleink) en los comentarios con sus consultas, preguntas y afirmaciones. ¡Nos encantaría escucharlos!
