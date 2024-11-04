---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Marcado Web
description: Capítulo sobre marcado del Web Almanac de 2019 que cubre elementos utilizados, elementos personalizados, valor, productos y casos de uso comunes.
authors: [bkardell]
reviewers: [zcorpan, tomhodgins, matthewp]
analysts: [rviscomi]
editors: [rviscomi]
translators: [c-torres]
discuss: 1758
results: https://docs.google.com/spreadsheets/d/1WnDKLar_0Btlt9UgT53Giy2229bpV4IM2D_v6OM_WzA/
bkardell_bio: <i lang="en">Brian Kardell is developer advocate at <a hreflang="en" href="https://igalia.com">Igalia</a>, standards contributor, <a hreflang="en" href="https://bkardell.com">blogger</a>, and is currently the W3C Advisory Committee Representative for the <a hreflang="en" href="https://openjsf.org/">Open JS Foundation</a>. He was a founder of the Extensible Web Community Group and co-author of <a hreflang="en" href="https://extensiblewebmanifesto.org">The Extensible Web Manifesto</a>.</i>
featured_quote: A partir de julio de 2019, el HTTP Archive ha comenzado a recopilar todos los nombres de elementos usados en el DOM para aproximadamente 4,4 millones de páginas de inicio de computadoras de escritorio y alrededor de 5,3 millones de páginas de inicio de dispositivos móviles que ahora podemos comenzar a investigar y diseccionar. Esta exploración encontró *más de 5.000 nombres distintos de elementos no estándar* en estas páginas, por lo que limitamos el número total de elementos distintos que contamos a los 'principales' (explicado a continuación) 5.048.
featured_stat_1: 11
featured_stat_label_1: Elementos utilizados en más del 90% de las páginas
featured_stat_2: 15%
featured_stat_label_2: Páginas que contienen elementos obsoletos
featured_stat_3: 65
featured_stat_label_3: Variantes de carruseles encontradas
---

## Introduction

En 2005, Ian "Hixie" Hickson publicó <a hreflang="en" href="https://web.archive.org/web/20060203035414/http://code.google.com/webstats/index.html">algunos análisis de datos de marcado</a> basándose en varios trabajos anteriores. Gran parte de este trabajo tenía como objetivo investigar los nombres de las clases para ver si había una semántica informal común que los desarrolladores estaban adoptando y que podría tener sentido estandarizar. Parte de esta investigación ayudó a darle forma a nuevos elementos en HTML5.

14 años después, es hora de dar un nuevo vistazo. Desde entonces, hemos tenido la introducción de [Elementos Personalizados](https://developer.mozilla.org/docs/Web/Web_Components/Using_custom_elements) y del <a hreflang="en" href="https://extensiblewebmanifesto.org/">Manifesto Web Extensible</a> alentando a que encontremos mejores formas de pavimentar los caminos de acceso al permitir a los desarrolladores explorar el espacio de los elementos y permitir a los organismos de estándares <a hreflang="en" href="https://bkardell.com/blog/Dropping-The-F-Bomb-On-Standards.html">actuar más como editores de diccionario</a>. A diferencia de los nombres de clase CSS, que podrían usarse para cualquier cosa, podemos estar mucho más seguros de que los autores que usaron un *elemento* no estándar realmente pretendían que fuera un elemento.

A partir de julio de 2019, el HTTP Archive ha comenzado a recopilar todos los nombres de elementos usados en el DOM para aproximadamente 4,4 millones de páginas de inicio de computadoras de escritorio y alrededor de 5,3 millones de páginas de inicio de dispositivos móviles que ahora podemos comenzar a investigar y diseccionar. _(Conozca más sobre nuestra [Metodología](./methodology).)_

Esta exploración encontró *más de 5.000 nombres distintos de elementos no estándar* en estas páginas, por lo que limitamos el número total de elementos distintos que contamos a los 'principales' (explicado a continuación) 5.048.

## Metodología

Los nombres de los elementos en cada página se recopilaron del DOM mismo, después de la ejecución inicial de JavaScript.

Mirar un recuento de frecuencia sin procesar no es especialmente útil, incluso para elementos estándar: Alrededor del 25% de todos los elementos encontrados son `<div>`.  Alrededor del 17% son `<a>`, alrededor del 11% son `<span>` -- y esos son los únicos elementos que representan más del 10% de las ocurrencias. Los lenguajes <a hreflang="en" href="https://www.youtube.com/watch?v=fCn8zs912OE">generalmente son así</a>; un pequeño número de términos se usan asombrosamente en comparación. Además, cuando comenzamos a buscar elementos no estándar para la captación, esto podría ser muy engañoso, ya que un sitio podría usar un cierto elemento miles de veces y, por lo tanto, parecer artificialmente muy popular.

En lugar, como en el estudio original de Hixie, Lo que veremos es cuántos sitios incluyen cada elemento al menos una vez en su página de inicio.

<p class="note">Nota: Esto es, en sí mismo, no sin algunos sesgos potenciales. Varios sitios pueden utilizar productos populares, lo que introduce un marcado no estándar, incluso "invisible" para autores individuales. Por lo tanto, se debe tener cuidado al reconocer que el uso no implica necesariamente el conocimiento directo del autor y la adopción consciente tanto como el servicio de una necesidad común, de una manera común. Durante nuestra investigación, encontramos varios ejemplos de esto, algunos los indicaremos.</p>

## Principales elementos e información general

En 2005, la encuesta de Hixie enumeró los elementos más comunes utilizados en las páginas. Los 3 principales fueron `html`, `head` y `body` lo que señaló como interesante porque son opcionales y creados por el _parser_ si se omiten. Dado que utilizamos el DOM después del _parseo_ , aparecerán universalmente en nuestros datos. Por lo tanto, comenzaremos con el cuarto elemento más utilizado. A continuación se muestra una comparación de los datos de entonces a ahora. (También he incluido la comparación de frecuencias aquí solo por diversión).

<figure>
  <table>
    <thead>
      <tr>
        <th>2005 (por sitio)</th>
        <th>2019 (por sitio)</th>
        <th>2019 (frecuencia)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>title</td>
        <td>title</td>
        <td>div</td>
      </tr>
      <tr>
        <td>a</td>
        <td>meta</td>
        <td>a</td>
      </tr>
      <tr>
        <td>img</td>
        <td>a</td>
        <td>span</td>
      </tr>
      <tr>
        <td>meta</td>
        <td>div</td>
        <td>li</td>
      </tr>
      <tr>
        <td>br</td>
        <td>link</td>
        <td>img</td>
      </tr>
      <tr>
        <td>table</td>
        <td>script</td>
        <td>script</td>
      </tr>
      <tr>
        <td>td</td>
        <td>img</td>
        <td>p</td>
      </tr>
      <tr>
        <td>tr</td>
        <td>span</td>
        <td>option</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Comparación de los principales elementos de 2005 y 2019.") }}</figcaption>
</figure>

### Elementos por página

{{ figure_markup(
  image="hixie_elements_per_page.png",
  caption="Distribución del análisis de Hixie en 2005 de las frecuencias de los elementos.",
  description="Gráfico que muestra una distribución decreciente de frecuencia relativa a medida que aumenta el número de elementos",
  width=600,
  height=318
  )
}}

{{ figure_markup(
  image="fig3.png",
  caption="Frecuencias de elementos de acuerdo al 2019.",
  description="El gráfico que muestra alrededor de 2.500 páginas comienza con aproximadamente 30 elementos, esto aumenta con un máximo de 6.876 páginas con 283 elementos, antes de llegar bastante linealmente a 327 páginas con 2.000 elementos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=2141583176&format=interactive"
  )
}}

Comparando los últimos datos en la Figura 3.3 con los del informe de Hixie de 2005 en la Figura 3.2, podemos ver que el tamaño promedio de los árboles DOM ha aumentado.

{{ figure_markup(
  image="hixie_element_types_per_page.png",
  caption="Histograma del análisis de Hixie de 2005 de los tipos de elementos por página.",
  description="Graph that relative frequency is a bell curve around the 19 elements point.",
  width=600,
  height=320
  )
}}

{{ figure_markup(
  image="fig5.png",
  caption="Histograma de tipos de elementos por página a partir de 2019.",
  description="El gráfico que muestra el número promedio de elementos es una curva de campana alrededor de los 30 elementos marcados, utilizados por 308,168 mil sitios.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1500675289&format=interactive"
  )
}}

Podemos ver que tanto el número promedio de tipos de elementos por página ha aumentado, como el número máximo de elementos únicos que encontramos.

## Elementos personalizados

La mayoría de los elementos que grabamos son personalizados (como en simplemente "no estándar"), pero discutir qué elementos son y no son personalizados puede ser un poco difícil. Escrito en alguna especificación o propuesta en algún lugar hay, en realidad, bastantes elementos. Para fines aquí, consideramos 244 elementos como estándar (aunque algunos de ellos están en desuso o no son compatibles):

* 145 Elementos de HTML
* 68 Elementos de SVG
* 31 Elementos de MathML

En la práctica, encontramos solo 214 de estos:

* 137 de HTML
* 54 de SVG
* 23 de MathML

En el conjunto de datos de escritorio, recopilamos datos para los principales 4,834 elementos no estándar que encontramos. De estos:

* 155 (3%) son identificables como muy probable marcado o errores de escape (contienen caracteres en el nombre de la etiqueta analizada, lo que implica que el marcado está roto)
* 341 (7%) usan espacios de nombre de dos puntos al estilo XML (aunque, como HTML, no usan espacios de nombres XML reales)
* 3,207 (66%) son nombres de elementos personalizados válidos
* 1,211 (25%) se encuentran en el espacio de nombres global (no estándar, sin guión ni dos puntos)
* 216 de estos los hemos marcado como *probables* errores tipográficos, ya que tienen más de 2 caracteres y tienen una distancia de Levenshtein de 1 desde algún nombre de elemento estándar como `<cript>`,`<spsn>` or `<artice>`. Algunos de estos (como `<jdiv>`), sin embargo, son ciertamente intencionales.

Además, el 15% de las páginas de escritorio y el 16% de las páginas móviles contienen elementos obsoletos.

<p class="note">Nota: Mucho de esto es muy probable debido al uso de productos en lugar de que los autores individuales sigan creando manualmente el marcado.</p>

{{ figure_markup(
  image="fig6.png",
  caption="Elementos en desuso más utilizados.",
  description="Bar chart showing 'center' in use by 8.31% of desktop sites (7.96% of mobile), 'font' in use by 8.01% of desktop sites (7.38% of mobile), 'marquee' in use by 1.07% of desktop sites (1.20% of mobile), 'nobr' in use by 0.71% of desktop sites (0.55% of mobile), 'big' in use by 0.53% of desktop sites (0.47% of mobile), 'frameset' in use by 0.39% of desktop sites (0.35% of mobile), 'frame' in use by 0.39% of desktop sites (0.35% of mobile), 'strike' in use by 0.33% of desktop sites (0.27% of mobile), and 'noframes' in use by 0.25% of desktop sites (0.27% of mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1304237557&format=interactive"
  )
}}

La Figura 3.6 anterior muestra los 10 elementos obsoletos más utilizados. La mayoría de estos pueden parecer números muy pequeños, pero la perspectiva es importante.

## Perspectiva sobre valor y uso

Para discutir números sobre el uso de elementos (estándar, obsoleto o personalizado), primero necesitamos establecer alguna perspectiva.

{{ figure_markup(
  image="fig7_full.png",
  caption='Principales 150 elementos (<a hreflang="en" href="fig7_full.png">detalle completo</a>).',
  description="Gráfico de barras que muestra un uso decreciente de elementos en orden descendente: html, head, body, title por encima del 99% de uso, meta, a, div por encima del 98% de uso, link, script, img, span por encima del 90% de uso, ul, li , p, style, input, br, form por encima del 70% de uso, h2, h1, iframe, h3, button, footer, header, nav por encima del 50% de uso y otras etiquetas menos conocidas que descienden desde menos del 50% hasta casi 0 % de uso.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=1694360298&format=interactive",
  width=600,
  height=778,
  data_width=600,
  data_height=778
  )
}}

En la Figura 3.7 anterior, se muestran los 150 nombres de elementos principales, contando el número de páginas donde aparecen. Observe lo rápido que se cae el uso.

Solo se utilizan 11 elementos en más del 90% de las páginas:

- `<html>`
- `<head>`
- `<body>`
- `<title>`
- `<meta>`
- `<a>`
- `<div>`
- `<link>`
- `<script>`
- `<img>`
- `<span>`

Solo hay otros 15 elementos que ocurren en más del 50% de las páginas:

- `<ul>`
- `<li>`
- `<p>`
- `<style>`
- `<input>`
- `<br>`
- `<form>`
- `<h2>`
- `<h1>`
- `<iframe>`
- `<h3>`
- `<button>`
- `<footer>`
- `<header>`
- `<nav>`

Y solo hay otros 40 elementos que ocurren en más del 5% de las páginas.

Incluso `<video>`, por ejemplo, no cumple con el corte. Aparece solo en el 4% de las páginas de escritorio en el conjunto de datos (3% en dispositivos móviles). Si bien estos números suenan muy bajos, el 4% es en realidad *bastante* popular en comparación. De hecho, solo 98 elementos ocurren en más del 1% de las páginas.

Es interesante, entonces, ver cómo se ve la distribución de estos elementos y cuáles tienen más del 1% de uso.

{{ figure_markup(
  link="https://rainy-periwinkle.glitch.me/scatter/html",
  image="element_categories.png",
  caption="Elemento de popularidad categorizado por estandarización.",
  description='Los gráficos de dispersión que muestran HTML, SVG y Math ML usan relativamente pocas etiquetas, mientras que los elementos no estándar (divididos en "en ns globales", "dasherized" y "dos puntos") están mucho más dispersos.',
  width=600,
  height=1065
  )
}}

La Figura 3.8 muestra el rango de cada elemento y en qué categoría se encuentran. He separado los puntos de datos en conjuntos discretos simplemente para que puedan verse (de lo contrario, no hay suficientes píxeles para capturar todos esos datos), pero representan una única "línea" de popularidad; el más bajo es el más común, el más alto es el menos común. La flecha apunta al final de los elementos que aparecen en más del 1% de las páginas.

Se pueden observar dos cosas aquí. Primero, el conjunto de elementos que tienen más del 1% de uso no son exclusivamente HTML. De hecho, *27 de los 100 elementos más populares ni siquiera son HTML* - son SVG! Y hay *etiquetas no estándar en o muy cerca de ese límite también*!  Segundo, tenga en cuenta que menos del 1% de las páginas utilizan una gran cantidad de elementos HTML.

Entonces, ¿todos esos elementos que son utilizados por menos del 1% de las páginas "inútiles"? Definitivamente no. Por eso es importante establecer una perspectiva. Hay alrededor <a hreflang="en" href="https://www.websitehostingrating.com/internet-statistics-facts/">dos mil millones de sitios web en la web</a>. Si algo aparece en el 0.1% de todos los sitios web de nuestro conjunto de datos, podemos extrapolar que esto representa quizás *dos milliones de sitios web* en toda la web. Incluso 0,01% se extrapola a _doscientos mil sitios_.  Esta es también la razón por la cual eliminar el soporte para elementos, incluso aquellos muy antiguos que creemos que no son buenas ideas, es algo muy raro. Romper cientos de miles o millones de sitios simplemente no es algo que los proveedores de navegadores puedan hacer a la ligera.

Muchos elementos, incluso los nativos, aparecen en menos del 1% de las páginas y siguen siendo muy importantes y exitosos. `<code>`, por ejemplo, es un elemento que uso y encuentro mucho. Definitivamente es útil e importante, y sin embargo, se usa solo en el 0,57% de estas páginas. Parte de esto está sesgado según lo que estamos midiendo; las páginas de inicio son generalmente *menos probable* para incluir ciertos tipos de cosas (como `<code>` por ejemplo). Las páginas de inicio tienen un propósito menos general que, por ejemplo, encabezados, párrafos, enlaces y listas. Sin embargo, los datos son generalmente útiles.

También recopilamos información sobre qué páginas contenían un autor definido (no nativo) `.shadowRoot`. Alrededor del 0,22% de las páginas de escritorio y el 0,15% de las páginas móviles tenían un _shadow root_. Esto puede no parecer mucho, pero es más o menos 6.500 sitios en el conjunto de datos móviles y 10.000 sitios en el escritorio y es más que varios elementos HTML. `<summary>` por ejemplo, tiene un uso equivalente en el escritorio y es el elemento número 146 más popular. `<datalist>` aparece en el 0,04% de las páginas de inicio y es el elemento 201 más popular.

De hecho, más del 15% de los elementos que contamos según lo definido por HTML están fuera de los 200 primeros en el conjunto de datos de escritorio. `<meter>` es el elemento menos popular de la "era HTML5", que podemos definir como 2004-2011, antes de que HTML se moviera a un modelo de Living Standard. Es alrededor del elemento número 1.000 en popularidad. `<slot>`, el elemento introducido más recientemente (abril de 2016) está situado alrededor del puesto 1.400 en cuanto a popularidad.

## Muchos datos: DOM real en la web real

Con esta perspectiva en mente acerca de cómo se ve el uso de características nativas / estándar en el conjunto de datos, hablemos de las cosas no estándar.

Puede esperar que muchos de los elementos que medimos se usen solo en una sola página web, pero de hecho, todos los 5.048 elementos aparecen en más de una página. La menor cantidad de páginas en las que aparece un elemento de nuestro conjunto de datos es 15. Aproximadamente una quinta parte de ellas ocurre en más de 100 páginas. Alrededor del 7% se produce en más de 1.000 páginas.

Para ayudar a analizar los datos, _hackee_ en conjunto una <a hreflang="en" href="https://rainy-periwinkle.glitch.me">pequeña herramienta con Glitch</a>. Puede usar esta herramienta usted mismo y por favor comparta un enlace permanente con el [@HTTPArchive](https://x.com/HTTPArchive) junto con sus observaciones. (Tommy Hodgins también ha construido una herramienta similar <a hreflang="en" href="https://github.com/tomhodgins/hade">CLI Tool</a> que se puede usar para explorar.)

Veamos algunos datos.

### Productos (y librerías) y su marcado personalizado

Para varios elementos no estándar, su prevalencia puede tener más que ver con su inclusión en herramientas populares de terceros que la adopción por parte de primeros. Por ejemplo, el elemento `<fb:like>` se encuentra en el 0,3% de las páginas no porque los propietarios del sitio lo escriban explícitamente sino porque incluyen el widget de Facebook. Muchos de los elementos que <a hreflang="en" href="https://web.archive.org/web/20060203031245/http://code.google.com/webstats/2005-12/editors.html">Hixie mencionó hace 14 años</a> parece haber disminuido, pero otros siguen siendo bastante grandes:

- Elementos populares creados por [Claris Home Page](https://en.wikipedia.org/wiki/Claris_Home_Page) (cuya última versión estable fue hace 21 años) *todavía* aparece en más de 100 páginas. <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/28b0b7abb3980af793a2f63b484e7815365b91c04ae625dd4170389cc1ab0a52.html">`<x-claris-window>`</a>, por ejemplo, aparece en 130 páginas.
- Algunos de los `<actinic:*>` elementos del proveedor de comercio electrónico británico <a hreflang="en" href="https://www.oxatis.co.uk">Oxatis</a> aparecen en incluso más páginas. Por ejemplo, <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/30dfca0fde9fad9b2ec58b12cb2b0271a272fb5c8970cd40e316adc728a09d19.html">`<actinic:basehref>`</a> todavía aparece en 154 páginas en los datos del escritorio.
- Los elementos de Macromedia parecen haber desaparecido en gran medida. Solo un elemento, <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/836d469b8c29e5892dedfd43556ed1b0e28a5647066858ca1c395f5b30f8485c.html">`<mm:endlock>`</a>, aparece en nuestra lista y en solo 22 páginas.
- El elemento de Adobe Go-Live <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/579abc77652df3ac2db1338d17aab0a8dc737b9d945510b562085d8522b18799.html">`<csscriptdict>`</a> todavía aparece en 640 páginas en el escritorio dataset.
- El elemento de Microsoft Office <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/579abc77652df3ac2db1338d17aab0a8dc737b9d945510b562085d8522b18799.html">`<o:p>`</a> El elemento todavía aparece en el 0,5% de las páginas de escritorio, más de 20.000 páginas.

Pero hay muchos recién llegados que tampoco estaban en el informe original de Hixie, y con números aún mayores.

- <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/e8bf0130c4f29b28a97b3c525c09a9a423c31c0c813ae0bd1f227bd74ddec03d.html">`<ym-measure>`</a> es una etiqueta inyectada por Yandex <a hreflang="en" href="https://www.npmjs.com/package/yandex-metrica-watch">del paquete de analisis Metrica</a>. Se utiliza en más del 1% de las páginas de escritorio y móviles, consolidando su lugar en los 100 elementos más utilizados. ¡Eso es enorme!
- <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/a532f18bbfd1b565b460776a64fa9a2cdd1aa4cd2ae0d37eb2facc02bfacb40c.html">`<g:plusone>`</a> del ahora desaparecido Google Plus se produce en más de 21.000 páginas.
- Facebook <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/2e2f63858f7715ef84d28625344066480365adba8da8e6ca1a00dfdde105669a.html">`<fb:like>`</a> ocurre en 14.000 páginas móviles.
- De manera similar, <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/5a964079ac2a3ec1b4f552503addd406d02ec4ddb4955e61f54971c27b461984.html">`<fb:like-box>`</a> ocurre en 7.800 páginas móviles.
- <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/6997d689f56fe77e5ce345cfb570adbd42d802393f4cc175a1b974833a0e3cb5.html">`<app-root>`</a>, que generalmente se incluye en frameworks como Angular, aparece en algo más de 8.200 páginas móviles.

Comparemos esto con algunos de los elementos HTML nativos que están por debajo de la barra del 5%, por perspectiva.

{{ figure_markup(
  image="fig9.png",
  caption="Popularidad de elementos nativos y específicos del producto por debajo del 5% de adopción.",
  description="Bar chart showing video is used by 184,149 sites, canvas by 108,355, ym-measure (a product-specific tag) by 52,146, code by 25,075, g:plusone (a product-specific tag) by 21,098, fb:like (a product-specific tag) by 12,773, fb:like-box (a product-specific tag) by 6,792, app-root (a product-specific tag) by 8,468, summary by 6,578, template by 5,913, and meter by 0.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=962404708&format=interactive",
  width=600,
  height=370,
  data_width=600,
  data_height=370
  )
}}

Usted podría descubrir ideas interesantes como estas durante todo el día.

Aquí hay una que es un poco diferente: los elementos populares pueden ser causados por errores directos en los productos. Por ejemplo, `<pclass="ddc-font-size-large">` ocurre en más de 1,000 sitios. Esto fue gracias a la falta de espacio en un popular tipo de producto "como servicio". Afortunadamente, informamos este error durante nuestra investigación y se solucionó rápidamente.

En su artículo original, Hixie menciona que:

<blockquote>Lo bueno, si se nos puede perdonar por tratar de seguir siendo optimistas ante todo este marcado no estándar, es que al menos estos elementos están claramente usando nombres específicos del proveedor. Esto reduce enormemente la probabilidad de que los organismos de normalización inventen elementos y atributos que entren en conflicto con cualquiera de ellos.</blockquote>

Sin embargo, como se mencionó anteriormente, esto no es universal. Más del 25% de los elementos no estándar que capturamos no utilizan ningún tipo de estrategia de espacio de nombres para evitar contaminar el espacio de nombres global. Por ejemplo, aquí está <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/53567ec94b328de965eb821010b8b5935b0e0ba316e833267dc04f1fb3b53bd5.html">una lista de 1.157 elementos como ese del conjunto de datos móviles</a>. Es probable que muchos de ellos no sean problemáticos, ya que tienen nombres oscuros, faltas de ortografía, etc. Pero al menos algunos probablemente presentan algunos desafíos. Se puede notar, por ejemplo, que `<toast>` (el cual Googlers <a hreflang="en" href="https://www.chromestatus.com/feature/5674896879255552">recientemente intentaron proponer como `<std-toast>`</a>) aparece en esta lista.

Hay algunos elementos populares que probablemente no sean tan desafiantes:

- <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/2ba66fb067dce29ecca276201c37e01aa7fe7c191e6be9f36dd59224f9a36e16.html">`<ymaps>`</a> de Yahoo Maps aparece en ~12.500 páginas móviles.
- <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/5cfe2db53aadf5049e32cf7db0f7f6d8d2f1d4926d06467d9bdcd0842d943a17.html">`<cufon>` and `<cufontext>`</a> de una biblioteca de reemplazo de fuentes de 2008, aparece en ~10.500 páginas móviles.
- El elemento <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/976b0cf78c73d125644d347be9e93e51d3a9112e31a283259c35942bda06e989.html">`<jdiv>`</a>, que parece estar inyectado por el producto JivoChat, aparece en ~40.300 páginas móviles.

Colocar estos elementos en nuestro mismo cuadro anterior para obtener una perspectiva se parece a esto (nuevamente, varía ligeramente según el conjunto de datos)

{{ figure_markup(
  image="fig10.png",
  caption="Otros elementos populares en el contexto de elementos nativos y específicos del producto con menos del 5% de adopción.",
  description="A bar chart showing video is used by 184,149 sites, canvas by 108,355, ym-measure by 52,416, code by 25,075, g:plusone by 21,098, db:like by 12,773, cufon by 10,523, ymaps by 8,303, fb:like-box by 6,972, app-root by 8,468, summary by 6,578, template by 5,913, and meter by 0",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTbHgqcSepZye6DrCTpifFAUYxKT1hEO56585awyMips8oiPMLYu20GETuIE8mALkm814ObJyktEe2P/pubchart?oid=468373762&format=interactive",
  width=600,
  height=370,
  data_width=600,
  data_height=370
  )
}}

Lo interesante de estos resultados es que también introducen algunas otras formas en que nuestra herramienta puede ser muy útil. Si estamos interesados en explorar el espacio de los datos, un nombre de etiqueta muy específico es solo una medida posible. Definitivamente es el indicador más fuerte si podemos encontrar un buen desarrollo de "jerga". Sin embargo, ¿qué pasa si eso no es todo lo que nos interesa?

### Casos de uso comunes y soluciones

¿Qué pasaría si, por ejemplo, estuviéramos interesados en las personas resolviendo casos de uso comunes? Esto podría deberse a que estamos buscando soluciones para casos de uso que tenemos actualmente, o para investigar de manera más amplia qué casos de uso común están resolviendo las personas con miras a incubar algún esfuerzo de estandarización. Tomemos un ejemplo común: pestañas. A lo largo de los años ha habido muchas solicitudes de cosas como pestañas. Podemos usar una búsqueda rápida aquí y encontrar que hay <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/c6d39f24d61d811b55fc032806cade9f0be437dcb2f5735a4291adb04aa7a0ea.html">muchas variantes de pestañas</a>. Es un poco más difícil contar el uso aquí ya que no podemos distinguir tan fácilmente si aparecen dos elementos en la misma página, por lo que el conteo provisto allí conservadoramente simplemente toma el que tiene el mayor conteo. En la mayoría de los casos, el número real de páginas es probablemente significativamente mayor.

También hay muchos <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/e573cf279bf1d2f0f98a90f0d7e507ac8dbd3e570336b20c6befc9370146220b.html">acordeones</a>, <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/0bb74b808e7850a441fc9b93b61abf053efc28f05e0a1bc2382937e3b78695d9.html">diálogos</a>, al menos 65 variantes de <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/651e592cb2957c14cdb43d6610b6acf696272b2fbd0d58a74c283e5ad4c79a12.html">carruseles</a>, muchas cosas sobre <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/981967b19a9346ac466482c51b35c49fc1c1cc66177ede440ab3ee51a7912187.html">ventanas emergentes</a>, al menos 27 variantes de <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/2e6827af7c9d2530cb3d2f39a3f904091c523c2ead14daccd4a41428f34da5e8.html">alternadores e interruptores</a>, y así.

Quizás podríamos investigar por qué necesitamos <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/5ae67c941395ca3125e42909c2c3881e27cb49cfa9aaf1cf59471e3779435339.html">92 variantes de elementos relacionados con botones que no son nativos</a>, por ejemplo, y tratar de llenar el vacío nativo.

Si notamos que surgen cosas populares (como `<jdiv>`, resolviendo chat) podemos tomar conocimiento de las cosas que sabemos (como, que es lo que `<jdiv>` resuelve, o `<olark>`) e intenta mirar <a hreflang="en" href="https://rainy-periwinkle.glitch.me/permalink/db8fc0e58d2d46d2e2a251ed13e3daab39eba864e46d14d69cc114ab5d684b00.html">al menos 43 cosas que hemos construido para abordar eso</a> y seguir las conexiones para inspeccionar el espacio.

## Conclusión

Entonces, hay muchos datos aquí, pero para resumir:

* Las páginas tienen más elementos que hace 14 años, tanto en promedio como en máximo.
* La vida útil de las cosas en las páginas de inicio es *muy* larga. Marcar como obsoleto o descontinuar las cosas no las hace desaparecer, y puede que nunca lo haga.
* Hay una gran cantidad de marcado roto en la naturaleza (etiquetas mal escritas, espacios faltantes, mal escape, malentendidos).
* Medir lo que significa "útil" es complicado. Muchos elementos nativos no pasan la barra del 5%, o incluso la barra del 1%, pero muchos de los personalizados sí, y por muchas razones. Pasar del 1% definitivamente debería captar nuestra atención al menos, pero tal vez incluso debería ser del 0.5% porque, según los datos, es comparativamente *muy* exitoso.
* Ya hay un montón de marcas personalizadas por ahí. Viene en muchas formas, pero los elementos que contienen un guión definitivamente parecen haber despegado.
* Necesitamos estudiar cada vez más estos datos y generar buenas observaciones para ayudar a encontrar y pavimentar los senderos.

En este último es donde usted entra. Nos encantaría aprovechar la creatividad y la curiosidad de la comunidad en general para ayudar a explorar estos datos utilizando algunas de las herramientas. (como <a hreflang="en" href="https://rainy-periwinkle.glitch.me/">https://rainy-periwinkle.glitch.me/</a>). Comparta sus observaciones interesantes y ayude a construir nuestros conocimientos y entendimientos.
