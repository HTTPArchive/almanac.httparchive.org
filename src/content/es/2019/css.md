---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: Capítulo CSS del 2019 Web Almanac que cubre el color, las unidades, los selectores, el diseño, la tipografía y las fuentes, el espaciado, la decoración, la animación y las consultas de medios.
hero_alt: Hero image of almanac chracters measuring and painting a web page.
authors: [una, argyleink]
reviewers: [meyerweb, huijing]
analysts: [rviscomi]
editors: [rachellcostello]
translators: [c-torres]
discuss: 1757
results: https://docs.google.com/spreadsheets/d/1uFlkuSRetjBNEhGKWpkrXo4eEIsgYelxY-qR9Pd7QpM/
una_bio: <i lang="en">Una Kravets is a Brooklyn-based international public speaker, technical writer, and Developer Advocate for Material Design at Google. Una hosts the <a hreflang="en" href="https://www.youtube.com/watch?v=YK8GZBx3hpg">Designing the Browser</a> web series and the <a hreflang="en" href="https://spec.fm/podcasts/toolsday">Toolsday</a> developer podcast. Follow her on <a href="https://x.com/una">Twitter</a> to find her musings on creative CSS, user experiences, and web development best practices.</i>
argyleink_bio: <i lang="en">Adam Argyle is a Google Chrome developer relations member focused on CSS; He's a web addict with an insatiable lust for great UX & UI; Find him on the web <a href="https://x.com/argyleink">@argyleink</a> or checkout his website <a hreflang="en" href="https://nerdy.dev">https://nerdy.dev</a>.</i>
featured_quote: Las Hojas de Estilo en Cascada (CSS por sus siglas en inglés) se utilizan para pintar, formatear y diseñar páginas web. Sus capacidades abarcan conceptos tan simples como el color del texto hasta perspectiva 3D. También tiene ganchos para permitir a los desarrolladores manejar diferentes tamaños de pantalla, contextos de visualización e impresión. CSS ayuda a los desarrolladores a lidiar con el contenido y a asegurarse de que se adapte correctamente al usuario.
featured_stat_1: 5%
featured_stat_label_1: Páginas que utilizan custom properties
featured_stat_2: 2%
featured_stat_label_2: Sitios que utilizan CSS Grid
featured_stat_3: 780
featured_stat_label_3: Número de dígitos en el valor Z-Index más grande
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

{{ figure_markup(
  image="fig1.png",
  caption="Popularidad de los formatos de color.",
  description="Gráfico de barras que muestra la adopción de los formatos HSL, HSLA, RGB, RGBA y hexadecimal. Hex se usa en el 93% de las páginas de escritorio, RGBA en el 83%, RGB en el 22%, HSLA 19% y HSL 1%. La adopción móvil y de escritorio es similar para todos los formatos de color, excepto HSL, para el cual la adopción móvil es del 9% (9 veces mayor).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1946838030&format=interactive"
  )
}}

### Selección de color

Existen <a hreflang="en" href="https://www.w3.org/TR/css-color-4/#named-colors">148 colores de CSS nombrados</a>, sin incluir los valores especiales `transparent` y `currentcolor`. Puede usarlos por su nombre en cadena de texto para un estilo más legible. Los colores con nombre más populares son `black` y `white`, sin sorprender, seguidos por `red` y `blue`.

{{ figure_markup(
  image="fig2.png",
  caption="Principales colores con nombre.",
  description="Gráfico circular que muestra los colores con nombre más populares. El blanco es el más popular al 40%, luego el negro al 22%, el rojo al 11% y el azul al 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1985913808&format=interactive",
  width=600,
  height=415,
  data_width=600,
  data_height=415
  )
}}

El idioma también se infiere de manera interesante a través del color. Hay más instancias del "gray" de estilo americano que del "grey" de estilo británico. Casi cada instancia de <a hreflang="en" href="https://www.rapidtables.com/web/color/gray-color.html">colores grises</a> (`gray`, `lightgray`, `darkgray`, `slategray`, etc.) tenía casi el doble de uso cuando se deletreaba con una "a" en lugar de una "e". Si la combinación gr[a/e]ys se tomara en cuenta, tendrían un rango más alto que el azul, solidificándose en el puesto #4. ¡Esta podría ser la razón por la cual `plata` ocupa un lugar más alto que `grey` con una "e" en las listas!

### Conteo de color

¿Cuántos colores de fuente diferentes se utilizan en la web? Entonces este no es el número total de colores únicos; más bien, es cuántos colores diferentes se usan solo para el texto. Los números en este gráfico son bastante altos y, por experiencia, sabemos que sin variables CSS, el espaciado, los tamaños y los colores pueden escaparse rápidamente de y fragmentarse en muchos valores pequeños en sus estilos. Estos números reflejan una dificultad en la gestión del estilo, y esperamos que esto ayude a crear alguna perspectiva para que pueda traer de vuelta a sus equipos o proyectos. ¿Cómo puede reducir este número a una cantidad manejable y razonable?

{{ figure_markup(
  image="fig3.png",
  caption="Distribución de colores por página.",
  description="Distribución que muestra los percentiles 10, 25, 50, 75 y 90 de colores por computadoras de escritorio y página móvil. En computadoras de  escritorio, la distribución es 8, 22, 48, 83 y 131. Las páginas móviles tienden a tener más colores entre 1 y 10.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1361184636&format=interactive"
  )
}}

### Duplicación del color

Bueno, tenemos curiosidad aquí y queríamos inspeccionar cuántos colores duplicados hay en una página. Sin un sistema CSS de clase reutilizable bien administrado, los duplicados son bastante fáciles de crear. Resulta que la mediana tiene suficientes duplicados que valdría la pena hacer un pase para unificarlos con propiedades personalizadas.

{{ figure_markup(
  image="fig4.png",
  caption="Distribución de colores duplicados por página.",
  description="Gráfico de barras que muestra la distribución de colores por página. La página de escritorio promedio tiene 24 colores duplicados. El percentil 10 es de 4 colores duplicados y el percentil 90 es de 62. Las distribuciones de escritorio y móviles son similares.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=326531498&format=interactive"
  )
}}

## Unidades

En CSS, hay muchas formas diferentes de lograr el mismo resultado visual utilizando diferentes tipos de unidades: `rem`, `px`, `em`, `ch`, o ¡incluso `cm`! Entonces, ¿qué tipos de unidades son más populares?

{{ figure_markup(
  image="fig5.png",
  caption="Popularidad de los tipos de unidades.",
  description="Gráfico de barras de la popularidad de varios tipos de unidades.Las unidades px y em se utilizan en más del 90% de las páginas. La unidad rem es el siguiente tipo de unidad más popular en el 40% de las páginas y la popularidad cae rápidamente para los tipos de unidades restantes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=540111393&format=interactive"
  )
}}

### Longitud y tamaño

Como era de esperar, en la Figura 2.5, `px` es el tipo de unidad más utilizado, es el tipo de unidad más utilizado con aproximadamente el 95% de las páginas web usando píxeles de una forma u otra (esto podría ser el tamaño del elemento, el tamaño de la fuente, etc.). Sin embargo, la unidad `em` es casi tan popular, con uso alrededor del 90%. Esto es más de 2 veces más popular que la unidad `rem`,que tiene solo un 40% de frecuencia en las páginas web. Si te preguntas cuál es la diferencia, `em` se basa en el tamaño de fuente principal, mientras que `rem` se basa en el tamaño de fuente base establecido en la página. No cambia por componente como podría hacerlo `em`,y así permite el ajuste de todos los espacios de manera uniforme.

Cuando se trata de unidades basadas en el espacio físico, la unidad `cm` (or centímetros) es la más popular por mucho, seguida por `in` (pulgadas), y luego por  `Q`.Sabemos que este tipo de unidades son específicamente útiles para imprimir hojas de estilo, ¡pero ni siquiera sabíamos que la unidad `Q` existía hasta esta encuesta! ¿Sabías?

<p class="note">Una versión anterior de este capítulo discutia la inesperada popularidad de la unidad<code>Q</code>. Gracias a la <a hreflang="en" href="https://discuss.httparchive.org/t/chapter-2-css/1757/6">discusión de la comunidad</a> alrededor de este capítulo, hemos identificado que esto fue un error en nuestro análisis y hemos actualizado la Figura 2.5 en consecuencia.</p>

### Unidades basadas en el viewport

Vimos mayores diferencias en los tipos de unidades cuando se trata del uso en dispositivos móviles y computadoras de escritorio para unidades basadas en el _viewport_. 36.8% de los sitios móviles usan `vh` (altura del viewport), mientras que solo el 31% de los sitios de escritorio lo hacen. También encontramos que `vh` es más común que `vw` (ancho del viewport) en aproximadamente un 11%. `vmin` (mínimo del viewport) es más popular que `vmax`(máximo del viewport), con alrededor del 8% de uso de `vmin` en dispositivos móviles, mientras que `vmax` solo lo usa el 1% de los sitios web.

### Propiedades personalizadas

Las propiedades personalizadas son lo que muchos llaman variables CSS. Sin embargo, son más dinámicas que una variable estática típica. Son muy poderosas y como comunidad todavía estamos descubriendo su potencial.

{{ figure_markup(
  caption="Porcentaje de páginas que usan propiedades personalizadas.",
  content="5%",
  classes="big-number"
)
}}

Sentimos que esta era una información emocionante, ya que muestra un crecimiento saludable de una de nuestras adiciones CSS favoritas. Estaban disponibles en todos los principales navegadores desde 2016 o 2017, por lo que es justo decir que son bastante nuevos. Muchas personas todavía están haciendo la transición de sus variables de preprocesador CSS a propiedades personalizadas CSS. Estimamos que pasarán algunos años más hasta que las propiedades personalizadas sean la norma.

## Selectores

### ID vs selectores de clases

CSS tiene algunas formas de encontrar elementos en la página para el estilo, así que pongamos los ID y las clases uno contra el otro para ver cuál es más frecuente. Los resultados no deberían ser demasiado sorprendentes: ¡las clases son más populares!

{{ figure_markup(
  image="fig7.png",
  caption="Popularidad de los tipos de selector por página.",
  description="Gráfico de barras que muestra la adopción de ID y tipos de selector de clase. Las clases se usan en el 95% de las páginas de escritorio y móviles. Las ID se usan en el 89% de las páginas de escritorio y el 87% de las páginas móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1216272563&format=interactive"
  )
}}

Un buen cuadro de seguimiento es este, que muestra que las clases ocupan el 93% de los selectores encontrados en una hoja de estilo.

{{ figure_markup(
  image="fig8.png",
  caption="Popularidad de los tipos de selector por selector.",
  description="Gráfico de barras que muestra que el 94% de los selectores incluyen el selector de clase para computadoras de escritorio y dispositivos móviles, mientras que el 7% de los selectores de escritorio incluyen el selector de ID (8% para dispositivos móviles).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=351006989&format=interactive"
  )
}}

### Selectores de atributos

CSS tiene algunos selectores de comparación muy potentes. Estos son selectores como `[target="_blank"]`, `[attribute^="value"]`, `[title~="rad"]`, `[attribute$="-rad"]` o `[attribute*="value"]`. ¿Los usas? ¿Crees que se usan mucho? Comparemos cómo se usan con IDs y clases en la web.

{{ figure_markup(
  image="fig9.png",
  caption="Popularidad de operadores por selector de atributo ID.",
  description="Gráfico de barras que muestra la popularidad de los operadores utilizados por los selectores de atributos de ID. Alrededor del 4% de las páginas de escritorio y móviles usan asterisco igual y signo de intercalación igual. El 1% de las páginas usan igual y dólar igual. 0% usa virgulilla igual.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=695879874&format=interactive"
  )
}}

{{ figure_markup(
  image="fig10.png",
  caption="Popularidad de operadores por selector de atributo de clase.",
  description="Gráfico de barras que muestra la popularidad de los operadores utilizados por los selectores de atributos de clase. El 57% de las páginas usan asterisco igual. El 36% usa signo de interalación igual. El 1% usa igual y dólar igual. 0% usa virgulilla igual.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=377805296&format=interactive"
  )
}}

Estos operadores son mucho más populares con los selectores de clase que con los ID, lo cual se siente natural ya que una hoja de estilo generalmente tiene menos selectores de ID que los selectores de clase, pero aún así es interesante ver los usos de todas estas combinaciones.

### Clases por elementos

Con el surgimiento de las estrategias OOCSS, atómicas y funcionales de CSS que pueden combinar 10 o más clases en un elemento para lograr una apariencia de diseño, quizás veamos algunos resultados interesantes. La consulta resultó bastante aburrida, con una mediana en dispositivos móviles y computadoras de escritorio de 1 clase por elemento.

{{ figure_markup(
  caption="La mediana del número de nombres de clase por atributo de clase (escritorio y dispositivo móvil).",
  content="1",
  classes="big-number"
)
}}

## Diseño

### Flexbox

[Flexbox](https://developer.mozilla.org/docs/Web/CSS/CSS_Flexible_Box_Layout/Conceptos_Basicos_de_Flexbox) es un estilo contenedor que dirige y alinea a sus hijos; es decir, ayuda con el diseño de una manera basada en restricciones. Tuvo un comienzo bastante difícil en la web, ya que su especificación experimentó dos o tres cambios bastante drásticos entre 2010 y 2013. Afortunadamente, se resolvió y se implementó en todos los navegadores en 2014. Dado ese historial, tuvo una tasa de adopción lenta, ¡pero han pasado algunos años desde entonces! Es bastante popular ahora, tiene muchos artículos sobre su uso y cómo sacarle provecho, pero aún es nuevo en comparación con otras tácticas de diseño.

{{ figure_markup(
  image="fig12.png",
  caption="Adopción de flexbox.",
  description="Gráfico de barras que muestra el 49% de las páginas de escritorio y el 52% de las páginas móviles usan flexbox.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2021161093&format=interactive"
  )
}}

Toda una historia de éxito se muestra aquí, ya que casi el 50% de la web usa flexbox en sus hojas de estilo.

### Grid

Similar a flexbox, [grid](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout) también pasó por algunas alteraciones de especificaciones al principio de su vida útil, pero sin cambiar las implementaciones en los navegadores lanzados al público. Microsoft tenía grid en las primeras versiones de Windows 8, como el motor de diseño primario para su estilo de diseño de desplazamiento horizontal. Primero se investigó allí, se hizo la transición a la web y luego los otros navegadores lo maduraron hasta su lanzamiento final en 2017. Tuvo un lanzamiento muy exitoso en el sentido de que casi todos los navegadores lanzaron sus implementaciones al mismo tiempo, por lo que los desarrolladores web simplemente se despertaron un día con un excelente soporte de grid. Hoy, a fines de 2019, grid todavía se siente como un niño nuevo en el bloque, ya que la gente todavía está despertando a su poder y capacidades.

{{ figure_markup(
  caption="Porcentaje de sitios web que usan grid.",
  content="2%",
  classes="big-number"
)
}}

Esto muestra lo poco que la comunidad de desarrollo web ha utilizado y explorado su última herramienta de diseño. Esperamos que grid eventualmente tome control y se convierta en el motor de diseño primario para la construcción de sitios web. Para nosotros, los autores, nos encanta escribir grid: normalmente lo buscamos primero, luego reducimos nuestra complejidad a medida que nos damos cuenta e iteramos en el diseño. Queda por ver qué hará el resto del mundo con esta potente función CSS en los próximos años.

### Modos de escritura

La web y CSS son características de la plataforma internacional, y los modos de escritura ofrecen una forma para que HTML y CSS indiquen la dirección de lectura y escritura preferida por el usuario dentro de nuestros elementos.

{{ figure_markup(
  image="fig14.png",
  caption="Popularidad de los valores de dirección.",
  description="Gráfico de barras que muestra la popularidad de los valores de dirección ltr y rtl. ltr es utilizado por el 32% de las páginas de escritorio y el 40% de las páginas móviles. rtl es utilizado por el 32% de las páginas de escritorio y el 36% de las páginas móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=136847988&format=interactive"
  )
}}

## Tipografía

### Fuentes web por página

¿Cuántas fuentes web está cargando en su página web? ¿0? ¿10? ¡La mediana de fuentes web por página es 3!

{{ figure_markup(
  image="fig15.png",
  caption="Distribución de la cantidad de fuentes web cargadas por página.",
  description="Distribución de la cantidad de fuentes web cargadas por página. En computadoras de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 0, 1, 3, 6 y 9. Esto es ligeramente más alto que la distribución para dispositivos móviles, que es una fuente menos en los percentiles 75 y 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1453570774&format=interactive"
  )
}}

### Familias de fuentes populares

Una pregunta de seguimineto a la consulta del número total de fuentes por página es: ¿qué fuentes son? Diseñadores, sintonicen, porque ahora podrán ver si sus elecciones están en línea con lo que es popular o no.

{{ figure_markup(
  image="fig16.png",
  caption="Principales fuentes web.",
  description="Gráfico de barras de las fuentes más populares. Entre las páginas de escritorio, están Open Sans (24%), Roboto (15%), Montserrat (5%), Source Sans Pro (4%), Noto Sans JP (3%) y Lato (3%). En los dispositivos móviles, las diferencias más notables son que Open Sans se usa el 22% del tiempo (en lugar del 24%) y Roboto se usa el 19% del tiempo (en lugar del 15%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1883567922&format=interactive",
  width=600,
  height=450,
  data_width=600,
  data_height=450
  )
}}

Open Sans es un gran ganador aquí, con casi 1 de cada 4 declaraciones CSS `@ font-family` que lo especifican. Definitivamente hemos usado Open Sans en proyectos en las agencias.

También es interesante notar las diferencias entre la adopción de escritorio y móvil. Por ejemplo, las páginas móviles usan Open Sans con menos frecuencia que las de escritorio. Mientras tanto, también usan Roboto un poco más a menudo.

### Tamaños de fuente

Esta es divertida, porque si le pregunta a un usuario cuántos tamaños de fuente siente que hay en una página, generalmente devolvería un número de 5 o definitivamente menos de 10. ¿Es esa la realidad? Incluso en un sistema de diseño, ¿cuántos tamaños de fuente hay? Consultamos la web y descubrimos que la mediana era 40 en el móvil y 38 en el escritorio. Puede ser el momento de pensar realmente en las propiedades personalizadas o de crear algunas clases reutilizables para ayudarlo a distribuir su rampa de tipos.

{{ figure_markup(
  image="fig17.png",
  caption="Distribución del número de tamaños de fuente distintos por página.",
  description="Gráfico de barras que muestra la distribución de distintos tamaños de fuente por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 8, 20, 40, 66 y 92 tamaños de fuente. La distribución de escritorio difiere de la móvil en el percentil 75, donde es más grande en 7 tamaños distintos y para el percentil 90 en 13 tamaños.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1695270216&format=interactive"
  )
}}

## Espaciado

### Márgenes

Un margen es el espacio fuera de los elementos, como el espacio que exige cuando empuja los brazos hacia afuera. Esto a menudo parece el espacio entre elementos, pero no se limita a ese efecto. En un sitio web o aplicación, el espaciado juega un papel muy importante en UX y diseño. Veamos cuánto código de espaciado de margen va en una hoja de estilo, ¿de acuerdo?

{{ figure_markup(
  image="fig18.png",
  caption="Distribución del número de valores de margen distintos por página.",
  description="Gráfico de barras que muestra la distribución de valores de margen distintos por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 12, 47, 96, 167 y 248 valores de margen distintos. La distribución de escritorio difiere de la móvil en el percentil 75, donde es más pequeña en 12 a 31 valores distintos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=4233531&format=interactive"
  )
}}

¡Bastante, al parecer! La página de escritorio promedio tiene 96 valores de margen distintos y 104 en dispositivos móviles. Eso crea muchos momentos de espaciado únicos en su diseño. ¿Curioso de cuántos márgenes tienes en tu sitio? ¿Cómo podemos hacer que todo este espacio en blanco sea más manejable?

### Propiedades lógicas

{{ figure_markup(
  caption="Porcentaje de páginas de escritorio y móviles que incluyen propiedades lógicas.",
  content="0.6%",
  classes="big-number"
)
}}

Estimamos que la hegemonía de `margin-left` y `padding-top` es de duración limitada, que pronto se complementará por su dirección de escritura agnóstica, sucesiva, sintaxis de propiedad lógica. Si bien somos optimistas, el uso actual es bastante bajo, con un 0,67% de uso en las páginas de escritorio. Para nosotros, esto se siente como un cambio de hábito que necesitaremos desarrollar como industria, mientras esperamos capacitar a nuevos desarrolladores para usar la nueva sintaxis.

### z-index

Las capas verticales, o apilamiento, se pueden administrar con `z-index` en CSS. Teníamos curiosidad sobre cuántos valores diferentes usan las personas en sus sitios. El rango de lo que acepta el `z-index` es teóricamente infinito, limitado solo por las límites de tamaño variable de un navegador. ¿Se utilizan todas esas posiciones de pila? ¡Veamos!

{{ figure_markup(
  image="fig20.png",
  caption="Distribución del número de valores distintos de <code>z-index</code> por página.",
  description="Gráfico de barras que muestra la distribución de distintos valores de z-index por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 1, 7, 16, 26 y 36 valores distintos de z-index. La distribución de escritorio es mucho más alta que la móvil, en hasta 16 valores distintos en el percentil 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1320871189&format=interactive"
  )
}}

### Valores populares de z-index

Según nuestra experiencia laboral, cualquier número con 9s parecía ser la opción más popular. Aunque nos enseñamos a nosotros mismos a usar el menor número posible, esa no es la norma comunitaria. ¿Cuál es entonces? Si la gente necesita cosas al frente, ¿cuáles son los números más populares de `z-index` que se usan? Deja a un lado tu bebida; este es lo suficientemente divertido como para perdérselo.

{{ figure_markup(
  image="fig21.png",
  caption="Los valores de <code>z-index</code> más utilizados.",
  description="Diagrama de dispersión de todos los valores de z-index conocidos y la cantidad de veces que se usan, tanto para escritorio como para dispositivos móviles. 1 y 2 son los más utilizados, pero el resto de los valores populares explotan en órdenes de magnitud: 10, 100, 1,000, y así sucesivamente hasta números con cientos de dígitos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1169148473&format=interactive"
  )
}}

{{ figure_markup(
  caption="El valor de <code>z-index</code> más grande conocido.",
  content="999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 !important",
  classes="really-big-number"
)
}}

## Decoración

### Filtros

Los filtros son una forma divertida y excelente de modificar los píxeles que el navegador intenta dibujar en la pantalla. Es un efecto de procesamiento posterior que se realiza contra una versión plana del elemento, nodo o capa a la que se aplica. Photoshop los hizo fáciles de usar, luego Instagram los hizo accesibles a las masas a través de combinaciones personalizadas y estilizadas. Han existido desde aproximadamente 2012, hay 10 de ellos, y se pueden combinar para crear efectos únicos.

{{ figure_markup(
  caption="Porcentaje de páginas que incluyen una hoja de estilo con la propiedad <code>filter</code>.",
  content="78%",
  classes="big-number"
)
}}

¡Nos entusiasmó ver que el 78% de las hojas de estilo contienen la propiedad `filter`! Ese número también era tan alto que parecía un poco sospechoso, así que buscamos y explicamos el número alto. Porque seamos honestos, los filtros son limpios, pero no se incluyen en todas nuestras aplicaciones y proyectos. ¡A no ser que!

Tras una investigación más profunda, descubrimos que las hojas de estilo de <a hreflang="en" href="https://fontawesome.com">FontAwesome</a> viene con cierto uso de `filter`, de igual manera el contenido empotrado de <a hreflang="en" href="https://youtube.com">YouTube</a>. Por lo tanto, nosotros creemos  `filter` se coló en la puerta de atrás al ser utilizada en un par de hojas de estilo muy populares. También creemos que la presencia de  `-ms-filter` podría haberse incluido también, contribuyendo al alto porcentaje de uso.

### Modos de mezcla

Los modos de mezcla son similares a los filtros en que son un efecto de posprocesamiento que se ejecuta contra una versión plana de sus elementos de destino, pero son únicos en el sentido de que están relacionados con la convergencia de píxeles. Dicho de otra manera, los modos de mezcla son cómo los 2 píxeles _deberían_ impactar entre sí cuando se superponen. Cualquier elemento que se encuentre en la parte superior o inferior afectará la forma en que el modo de mezcla manipula los píxeles. Hay 16 modos de mezcla, veamos cuáles son los más populares.

{{ figure_markup(
  caption="Porcentaje de páginas que incluyen una hoja de estilo con la propiedad <code>*-blend-mode</code>.",
  content="8%",
  classes="big-number"
)
}}

En general, el uso de los modos de mezcla es mucho menor que el de los filtros, pero aún es suficiente para ser considerado moderadamente utilizado.

En una futura edición de Web Almanac, sería genial profundizar en el uso del modo de mezcla para tener una idea de los modos exactos que usan los desarrolladores, como multiplicar, pantalla, quemar colores, aclarar, etc.

## Animación

### Transiciones

CSS tiene este increíble poder de interpolación que se puede usar simplemente escribiendo una sola regla sobre cómo hacer la transición de esos valores. Si está utilizando CSS para administrar estados en su aplicación, ¿con qué frecuencia emplea transiciones para realizar la tarea? ¡Vamos a consultar la web!

{{ figure_markup(
  image="fig25.png",
  caption="Distribución del número de transiciones por página.",
  description="Gráfico de barras que muestra la distribución de las transiciones por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 0, 2, 16, 49 y 118 transiciones. La distribución del escritorio es mucho más baja que la del móvil, hasta 77 transiciones en el percentil 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=419145172&format=interactive"
  )
}}

¡Eso es bastante bueno! Nosotros vimos `animate.css` como una biblioteca popular para incluir, que trae un montón de animaciones de transición, pero aún así es agradable ver que la gente está considerando la transición de sus interfaces de usuario.

### Animaciones Keyframe

Las animaciones de keyframe CSS son una excelente solución para sus animaciones o transiciones más complejas. Le permiten ser más explícito, lo que proporciona un mayor control sobre los efectos. Pueden ser pequeños, como un efecto de _keyframe_, o grandes con muchos efectos de _keyframe_ compuestos en una animación robusta. El número medio de animaciones de _keyframes_ por página es mucho menor que las transiciones CSS.

{{ figure_markup(
  image="fig26.png",
  caption="Distribución del número de keyframe por página.",
  description="Gráfico de barras que muestra la distribución de keyframes por página. Para las páginas móviles, los percentiles 10, 25, 50, 75 y 90 son: 0, 0, 3, 18 y 76 fotogramas clave. La distribución móvil es ligeramente superior a la de escritorio en 6 fotogramas clave en los percentiles 75 y 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=11848448&format=interactive"
  )
}}

## Media queries

Las _media queries_ permiten que CSS se enganche en varias variables de nivel de sistema para adaptarse adecuadamente al usuario visitante. Algunas de estas consultas podrían manejar estilos de impresión, estilos de pantalla de proyector y tamaño de ventana / vista. Durante mucho tiempo, las consultas de los medios se aprovecharon principalmente para su conocimiento de la vista. Los diseñadores y desarrolladores podrían adaptar sus diseños para pantallas pequeñas, pantallas grandes, etc. Más tarde, la web comenzó a brindar más y más capacidades y consultas, lo que significa que las _media queries_ ahora pueden administrar las funciones de accesibilidad además de las funciones de la ventana gráfica.

Un buen lugar para comenzar con las _media queries_, ¿es aproximadamente cuántas se usan por página? ¿A cuántos momentos o contextos diferentes siente la página típica que quiere responder?

{{ figure_markup(
  image="fig27.png",
  caption="Distribución del número de consultas de media queries por página.",
  description="Gráfico de barras que muestra la distribución de consultas de medios por página. Para las páginas de escritorio, los percentiles 10, 25, 50, 75 y 90 son: 0, 3, 14, 27 y 43 media queries. La distribución de escritorio es similar a la distribución móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1892465673&format=interactive"
  )
}}

### Tamaños de punto de quiebre populares de media queries

Para media queries de ventana gráfica, cualquier tipo de unidad CSS se puede pasar a la expresión de consulta para su evaluación. En días anteriores, la gente pasaba `em` y `px` a la consulta, pero con el tiempo se agregaban más unidades, lo que nos da mucha curiosidad sobre qué tipos de tamaños se encuentran comúnmente en la web. Suponemos que la mayoría de las consultas de medios seguirán los tamaños de dispositivos populares, pero en lugar de suponer, ¡echemos un vistazo a los datos!

{{ figure_markup(
  image="fig28.png",
  caption="Puntos de ajuste más utilizados en media queries.",
  description="Gráfico de barras de los puntos de referencia de media queries más populares. 768px y 767px son los más populares con 23% y 16%, respectivamente. La lista cae rápidamente después de eso, con 992px usado el 6% del tiempo y 1200px usado el 4% del tiempo. Las computadoras de escritorio y los dispositivos móviles tienen un uso similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1353707515&format=interactive"
  )
}}

La Figura 2.28 anterior muestra que parte de nuestras suposiciones eran correctas: ciertamente hay una gran cantidad de tamaños específicos de teléfonos allí, pero también hay algunos que no lo son. Es interesante también cómo es muy dominante en píxeles, con unas pocas entradas que utilizan `em` más allá del alcance de este gráfico.

### Uso vertical versus horizontal

El valor de _media query_ más popular de los tamaños de punto de interrupción populares parece ser `768px`, lo que nos hizo sentir curiosidad. ¿Se usó este valor principalmente para cambiar a un diseño vertical, ya que podría basarse en la suposición de que `768px` representa la típica ventana vertical de un móvil? Así que realizamos una consulta de seguimiento para ver la popularidad del uso de los modos vertical y horizontal:

{{ figure_markup(
  image="fig29.png",
  caption="Adopción de modos de orientación en media queries.",
  description="Gráfico de barras que muestra la adopción de modos de orientación vertical y horizontal en media queries. El 31% de las páginas especifican horizontal, el 8% especifica vertical y el 7% especifica ambas. La adopción es la misma para páginas de escritorio y móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=295845630&format=interactive"
  )
}}

Curiosamente, `vertical` no se usa mucho, mientras que `horizontal` se usa mucho más. Solo podemos suponer que `768px` ha sido lo suficientemente confiable como el caso de diseño vertical se ha alcanzado por mucho menos. También suponemos que las personas en una computadora de escritorio, que prueban su trabajo, no pueden activar el modo vertical para ver su diseño móvil tan fácilmente como pueden simplemente aplastar el navegador. Difícil de decir, pero los datos son fascinantes.

### Tipos de unidades más populares

En las media queries de ancho y alto que hemos visto hasta ahora, los píxeles se ven como la unidad de elección dominante para los desarrolladores que buscan adaptar su interfaz de usuario a las ventanas gráficas. Sin embargo, queríamos consultar esto exclusivamente, y realmente echar un vistazo a los tipos de unidades que usan las personas. Esto es lo que encontramos.

{{ figure_markup(
  image="fig30.png",
  caption="Adopción de unidades en puntos de referencia de media queries.",
  description="Gráfico de barras que muestra el 75% de los puntos de referencia de las media queries especifican píxeles, el 8% que especifica ems y el 1% que especifica rems.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=305563768&format=interactive"
  )
}}

### `min-width` vs `max-width`

Cuando las personas escriben una _media query_, ¿están generalmente buscando una ventana gráfica que esté por encima o por debajo de un rango específico, _o_ ambos, verificando si está entre un rango de tamaños? ¡Preguntémosle a la web!

{{ figure_markup(
  image="fig31.png",
  caption="Adopción de propiedades utilizadas en puntos de referencia de media queries.",
  description="Gráfico de barras que muestra el 74% de las páginas de escritorio usan max-width, el 70% con min-width y el 68% con ambas propiedades. La adopción es similar para páginas móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2091525146&format=interactive"
  )
}}

No hay ganadores claros aquí; `max-width` y `min-width` se usan casi por igual.

### Impresión y discurso

Los sitios web se sienten como papel digital, ¿verdad? Como usuarios, generalmente se sabe que puede presionar imprimir desde su navegador y convertir ese contenido digital en contenido físico. No se requiere que un sitio web cambie para ese caso de uso, ¡pero puede hacerlo si lo desea! Menos conocida es la capacidad de ajustar su sitio web en el caso de que lo lea una herramienta o un robot. Entonces, ¿con qué frecuencia se aprovechan estas características?

{{ figure_markup(
  image="fig32.png",
  caption="Adopción de las media queries para todos, impresión, pantalla y voz.",
  description='Gráfico de barras que muestra el 35% de las páginas de escritorio con el tipo de media query "todos", el 46% con impresión, el 72% con pantalla y el 0% con voz. La adopción es inferior en aproximadamente 5 puntos porcentuales para el escritorio en comparación con el móvil.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=939890574&format=interactive"
  )
}}

## Estadísticas a nivel de página

### Hojas de estilo

¿A cuántas hojas de estilo hace referencia desde su página de inicio? ¿Cuántos de tus aplicaciones? ¿Sirven más o menos para dispositivos móviles frente a computadoras de escritorio? ¡Aquí hay una tabla de todos los demás!

{{ figure_markup(
  image="fig33.png",
  caption="Distribución del número de hojas de estilo cargadas por página.",
  description="Distribución de la cantidad de hojas de estilo cargadas por página. Las computadoras de escritorio y los dispositivos móviles tienen distribuciones idénticas con percentiles 10, 25, 50, 75 y 90: 1, 3, 6, 12 y 20 hojas de estilo por página.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1377313548&format=interactive"
  )
}}

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
  <figcaption>{{ figure_link(caption="Nombres de hojas de estilo más utilizados.") }}</figcaption>
</figure>

¡Mira todos esos nombres de archivos creativos! style, styles, main, default, all. Sin embargo, uno se destacó, ¿lo ves? `BfWyFJ2Rl5s.css` toma el lugar número cuatro para el más popular. Lo investigamos un poco y nuestra mejor suposición es que está relacionado con los botones "me gusta" de Facebook. ¿Sabes cuál es ese archivo? Deja un comentario, porque nos encantaría escuchar la historia.

### Tamaño de la hoja de estilo

¿Qué tan grandes son estas hojas de estilo? ¿Es nuestro tamaño CSS algo de qué preocuparse? A juzgar por estos datos, nuestro CSS no es uno de los principales culpables de la hinchazón de las páginas.

{{ figure_markup(
  image="fig35.png",
  caption="Distribución del número de bytes de hoja de estilo (KB) cargados por página.",
  description="Distribución del número de bytes de hoja de estilo cargados por página. Los percentiles 10, 25, 50, 75 y 90 de la página de escritorio son: 8, 26, 62, 129 y 240 KB. La distribución de escritorio es ligeramente superior a la distribución móvil en 5 a 10 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2132635319&format=interactive"
  )
}}

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
  <figcaption>{{ figure_link(caption="Porcentaje de páginas que incluyen una biblioteca CSS determinada.") }}</figcaption>
</figure>

Este cuadro sugiere que <a hreflang="en" href="https://getbootstrap.com/">Bootstrap</a> es una biblioteca valiosa que debe saber para ayudar a conseguir un trabajo. ¡Mira toda la oportunidad que hay para ayudar! También vale la pena señalar que este es solo un gráfico de señales positivas: las matemáticas no suman 100% porque no todos los sitios están usando un framework CSS. Un poco más de la mitad de todos los sitios _no utilizan_ un framework CSS conocido. Muy interesante, ¿no?

### Utilidades de restablecimiento

Las utilidades de restablecimiento de CSS tienen la intención de normalizar o crear una línea base para elementos web nativos. En caso de que no lo supiera, cada navegador sirve su propia hoja de estilo para todos los elementos HTML, y cada navegador toma sus propias decisiones únicas sobre cómo se ven o se comportan esos elementos. Las utilidades de restablecimiento han analizado estos archivos, han encontrado sus puntos en común (o no) y han solucionado cualquier diferencia para que usted, como desarrollador, pueda diseñar en un navegador y tener una confianza razonable de que se verá igual en otro.

¡Así que echemos un vistazo a cuántos sitios están usando uno! Su existencia parece bastante razonable, entonces, ¿cuántas personas están de acuerdo con sus tácticas y las usan en sus sitios?

{{ figure_markup(
  image="fig37.png",
  caption="Adopción de utilidades de restablecimiento CSS.",
  description="Gráfico de barras que muestra la adopción de tres utilidades de restablecimiento de CSS: Normalize.css (33%), Reset CSS (3%) y Pure CSS (0%). No hay diferencia en la adopción en páginas de escritorio y móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1318910215&format=interactive"
  )
}}

Resulta que aproximadamente un tercio de la web está usando <a hreflang="en" href="https://necolas.github.io/normalize.css">`normalize.css`</a>, que podría considerarse un enfoque más suave para la tarea que un reinicio. Miramos un poco más profundo, y resulta que Bootstrap incluye `normalize.css`, lo que probablemente representa una gran cantidad de su uso. Vale la pena señalar también que `normalize.css` tiene más adopción que Bootstrap, por lo que hay muchas personas que lo usan solo.

### `@supports` y `@import`

CSS `@supports` es una forma para que el navegador verifique si una combinación particular de propiedad-valor se analiza como válida y luego aplica estilos si la verificación regresa como verdadera.

{{ figure_markup(
  image="fig38.png",
  caption="Popularidad de las reglas CSS 'arroba'.",
  description='Gráfico de barras que muestra la popularidad de las reglas @import y @supports "arroba". En el escritorio, @import se usa en el 28% de las páginas y @supports se usa en el 31%. Para dispositivos móviles, @import se usa en el 26% de las páginas y @supports se usa en el 29%.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1739611283&format=interactive"
  )
}}

Considerando que `@supports` se implementó en la mayoría de los navegadores en 2013, no es demasiado sorprendente ver una gran cantidad de uso y adopción. Estamos impresionados por la atención plena de los desarrolladores aquí. ¡Esto es una codificación considerada! El 30% de todos los sitios web están buscando algún soporte relacionado con la visualización antes de usarlo.

Un seguimiento interesante de esto es que hay más uso de `@supports` que de `@imports` ¡No esperábamos eso! `@import` ha estado en los navegadores desde 1994.

## Conclusión

¡Hay mucho más aquí para investigar! Muchos de los resultados nos sorprendieron, y solo podemos esperar que ellos también lo hayan sorprendido a usted. Este sorprendente conjunto de datos hizo que el resumen fuera muy divertido, y nos dejó con muchos rastros y pistas para investigar si queremos descubrir las razones _por qué_ algunos de los resultados son como son.

¿Qué resultados le parecieron más alarmantes?
¿Qué resultados te llevan a tu base de código para una consulta rápida?

Consideramos que la conclusión más importante de estos resultados es que las propiedades personalizadas ofrecen el máximo rendimiento en términos de rendimiento, _DRYness_ y escalabilidad de sus hojas de estilo. Esperamos analizar las hojas de estilo de Internet nuevamente, en busca de nuevos datos y tentativas cartas. Comuníquese con [@una](https://x.com/una) o [@argyleink](https://x.com/argyleink) en los comentarios con sus consultas, preguntas y afirmaciones. ¡Nos encantaría escucharlos!
